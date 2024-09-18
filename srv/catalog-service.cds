using {app.db as db} from '../db/data-model';




service CatalogService @(path : '/catalog')
@(requires: 'authenticated-user')
{
    entity Sales
      @(restrict: [{ grant: ['READ'],
                     to: 'Viewer'
                   },
                   { grant: ['WRITE'],
                     to: 'Admin' 
                   }
                  ])
      as select * from db.Sales
      actions {
        @(restrict: [{ to: 'Admin' }])
        action boost();
      }
    ;

    function topSales
      @(restrict: [{ to: 'Viewer' }])
      (amount: Integer)
      returns many Sales;




    type userRoles { identified: Boolean; authenticated: Boolean; Viewer: Boolean; Admin: Boolean; };
    type user { user: String; locale: String; roles: userRoles; };
    function userInfo() returns user;
};
