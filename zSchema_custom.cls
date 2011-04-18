public class zSchema_custom{
    public static final String Z_ACCOUNT = 'Account';
    public static final String Z_AMENDMENT = 'Amendment';
    public static final String Z_CONTACT = 'Contact';
    public static final String Z_INVOICE = 'Invoice';
    public static final String Z_INVOICE_ITEM = 'InvoiceItem';
    public static final String Z_INVOICE_PAYMENT = 'InvoicePayment';
    public static final String Z_PAYMENT = 'Payment';
    public static final String Z_PRODUCT = 'Product';
    public static final String Z_PRODUCT_RATEPLAN = 'ProductRatePlan';
    public static final String Z_PRODUCT_RATEPLAN_CHARGE = 'ProductRatePlanCharge';
    public static final String Z_RATEPLAN = 'RatePlan';
    public static final String Z_RATEPLAN_CHARGE = 'RatePlanCharge';
    public static final String Z_RATEPLAN_CHARGE_TIER = 'RatePlanChargeTier';
    public static final String Z_PAYMENT_METHOD = 'PaymentMethod';      
    public static final String Z_RATEPLAN_DATA = 'RatePlanData';
    public static final String Z_RATEPLAN_CHARGE_DATA = 'RatePlanChargeData';
    public static final String Z_SUBSCRIPTION = 'Subscription';
    public static final String Z_TAXATION_ITEM = 'TaxItem';
    public static final String Z_USAGE = 'Usage';
    public static final String Z_GENERATE = 'Generate';
    public static final String Z_OBJECT = 'zObject';
   	public static final String Z_REFUND = 'Refund';
    
    public static final String Z_INVOICE_ADJUSTMENT = 'InvoiceAdjustment';
    public static final String Z_INVOICE_ITEM_ADJUSTMENT = 'InvoiceItemAdjustment';
    public static final String Z_REFUND_INVOICE_PAYMENT = 'RefundInvoicePayment';
    public static final String Z_CREDIT_BALANCE_ADJUSTMENT = 'CreditBalanceAdjustment';
    public static final String Z_EXPORT = 'Export';
    
    public static final Map<String,String> account_schema = new Map<String,String>{
         'Id'=>'string,1',
         'fieldsToNull'=> 'string,1',
         'AccountNumber'=>'string,1',
         'AdditionalEmailAddresses'=>'string,1',
         'AllowInvoiceEdit'=>'boolean,1',
         'AutoPay'=>'boolean,1',
         'Balance'=>'double,1',
         'Batch'=>'string,1',
         'BillCycleDay'=>'int,1',
         'BillToId'=>'string,1',
         'CreatedById'=>'string,1',
         'CreatedDate'=>'dateTime,1',
         'CreditBalance'=>'double,1',
         'CrmId'=>'string,1',
         'Currency'=>'string,1',
         'CustomerServiceRepName'=>'string,1',
         'DefaultPaymentMethodId'=>'string,1',
         'InvoiceDeliveryPrefsEmail'=>'boolean,1',
         'InvoiceDeliveryPrefsPrint'=>'boolean,1',
         'InvoiceTemplateId'=>'string,1',
         'LastInvoiceDate'=>'dateTime,1',
         'Name'=>'string,1','Notes'=>'string,1',
         'PaymentGateway'=>'string,1',
         'PaymentTerm'=>'string,1',
         'PurchaseOrderNumber'=>'string,1',
         'SalesRepName'=>'string,1',
         'SoldToId'=>'string,1',
         'Status'=>'string,1',
         'TaxExemptCertificateID'=>'string,1',
         'TaxExemptCertificateType'=>'string,1',
         'TaxExemptDescription'=>'string,1',
         'TaxExemptEffectiveDate'=>'dateTime,1',
         'TaxExemptExpirationDate'=>'dateTime,1',
         'TaxExemptIssuingJurisdiction'=>'string,1',
         'TaxExemptStatus'=>'string,1',
         'TotalInvoiceBalance'=>'double,1',
         'UpdatedDate'=>'dateTime,1',
         'UpdatedById'=>'string,1',
         'ParentId'=>'string,1'
     };  
     		
	public static final Map<String,String> refund_schema = new Map<String,String>{
         'Id'=>'string,1',
         'fieldsToNull'=> 'string,1',
         'AccountId'=>'string,1',
         'AccountingCode'=>'string,1',
         'Amount'=>'double,1',
         'Comment'=>'string,1',
         'Gateway'=>'string,1',
         'GatewayResponse'=>'string,1',
         'GatewayResponseCode'=>'string,1',
         'MethodType'=>'string,1',
         'PaymentId'=>'string,1',
         'ReferenceID'=>'string,1',
         'RefundDate'=>'dateTime,1',
         'RefundNumber'=>'string,1',
         'RefundTransactionTime'=>'dateTime,1',
         'SourceType'=>'string,1',
         'Status'=>'string,1',
         'TransferredToAccounting'=>'string,1',
         'Type'=>'string,1',
         'UpdatedDate'=>'dateTime,1',
         'UpdatedById'=>'dateTime,1',
          'CreatedById'=>'string,1',
         'CreatedDate'=>'dateTime,1'
        
     };  
    
     public static final Map<String,String> zObject_schema = new Map<String,String> {
             
             'CreatedById'=>'string,1',
             'CreatedDate'=>'dateTime,1',
             'Id'=>'string,1',
             'fieldsToNull'=> 'string,1'
    };
    
    public static final Map<String,String> rateplan_schema = new Map<String,String> {
             
             'CreatedById'=>'string,1',
             'CreatedDate'=>'dateTime,1',
             'Id'=>'string,1',
             'fieldsToNull'=> 'string,1',
             'AmendmentId'=>'string,1',
             'AmendmentSubscriptionRatePlanId'=>'string,1',
             'AmendmentType'=>'string,1',
             'Name'=>'string,1',
             'ProductRatePlanId'=>'string,1',
             'SubscriptionId'=>'string,1',
             'UpdatedDate'=>'dateTime,1',
                'UpdatedById'=>'string,1'
    };
    
        public static final Map<String,String> rateplancharge_schema = new Map<String,String> {
             'Id'=>'string,1',
             'fieldsToNull'=> 'string,1',
             'AccountingCode'=>'string,1',
             'ApplyDiscountTo'=>'string,1',
             'BillCycleDay'=>'int,1',
             'BillCycleType'=>'string,1',
             'BillingPeriodAlignment'=>'string,1',
             'ChargedThroughDate'=>'datetime,1',
             'ChargeModel'=>'string,1',
             'ChargeNumber'=>'string,1',
             'ChargeType'=>'string,1',
             'CreatedById'=>'string,1',
             'CreatedDate'=>'dateTime,1',
             'Description'=>'string,1',
             'DiscountAmount'=>'double,1',
             'DiscountLevel'=>'string,1',
             'DiscountPercentage'=>'double,1',
             'DMRC'=>'double,1',
             'DTCV'=>'double,1',
             'EffectiveEndDate'=>'dateTime,1',
             'EffectiveStartDate'=>'dateTime,1',
             'IncludedUnits'=>'double,1',
             'IsLastSegment'=>'boolean,1',
             'MRR'=>'double,1',
             'Name'=>'string,1',
             'NumberOfPeriods'=>'long,1',
             'OriginalId'=>'string,1',
             'OverageCalculationOption'=>'string,1',
             'OveragePrice'=>'double,1',
             'OverageUnusedUnitsCreditOption'=>'string,1',
             'Price'=>'double,1',
             'ProcessedThroughDate'=> 'datetime,1',
             'ProductRatePlanChargeId'=>'string,1',
             'DiscountAmount'=>'string,1',
         	 'DiscountPercentage'=>'string,1',
        	 'Quantity'=>'double,1',
             'RatePlanId'=>'string,1',
             'RolloverBalance'=>'double,1',
             'segment'=>'int,1',
             'TCV'=>'double,1',
             'TriggerDate'=>'datetime,1',
             'TriggerEvent'=>'string,1',
             'UnusedUnitsCreditRates'=>'double,1',
             'UOM'=>'string,1',
             'UpdatedById'=>'string,1',
             'UpdatedDate'=>'datetime,1',
             'UpToPeriods'=>'int,1',
             'version'=>'int,1'
    };
    
    public static final Map<String,String> rateplanchargetier_schema = new Map<String,String> {
             'fieldsToNull'=> 'string,1',
             'Id'=>'string,1',
             'EndingUnit'=>'double,1',
             'IsOveragePrice'=>'boolean,1',
             'Price'=>'double,1',
             'PriceFormat'=>'string,1',
             'RatePlanChargeId'=>'string,1',
             'StartingUnit'=>'double,1',
             'Tier'=>'int,1'
             
             
    };
    
    public static final Map<String,String> rateplanchargedata_schema = new Map<String, String>{
                'RatePlanCharge'=>'zobject_custom,1,RatePlanCharge',
                'RatePlanChargeTier'=>'zobject_custom,-1,RatePlanChargeTier'
    };
    
    public static final Map<String,String> rateplandata_schema = new Map<String, String>{
            'RatePlan'=>'zobject_custom,1,RatePlan',
            'RatePlanChargeData'=>'zobject_custom,-1,RatePlanChargeData'
    };
      
    public static final Map<String,String> amendment_schema = new Map<String,String> {
            'Id'=>'string,1',
            'fieldsToNull'=> 'string,1',
            'AutoRenew'=>'boolean,1',
        'Code'=>'string,1',
        'ContractEffectiveDate'=>'datetime,1',
        'CreatedById'=>'string,1',
        'CreatedDate'=>'datetime,1',
        'CustomerAcceptanceDate'=>'datetime,1',
        'Description'=>'string,1',
        'DestinationAccountId'=>'string,1',
        'EffectiveDate'=>'datetime,1',
        'InitialTerm'=>'int,1',
        'Name'=>'string,1',
        'RatePlanData'=>'RatePlanData,1',
        'RenewalTerm'=>'int,1',
        'ServiceActivationDate'=>'datetime,1',
        'Status'=>'string,1',
        'SubscriptionId'=>'string,1',
        'TermStartDate'=>'datetime,1',
        'TermType'=>'string,1',
        'Type'=>'string,1',
        'UpdatedDate'=>'dateTime,1',
            'UpdatedById'=>'string,1'
    }; 
    
    public static final Map<String,String> contact_schema = new Map<String,String> {
         'Id'=>'string,1',
         'fieldsToNull'=> 'string,1',
         'AccountId'=>'string,1',
         'Address1'=>'string,1',
         'Address2'=>'string,1',
         'City'=>'string,1',
         'Country'=>'string,1',
         'CreatedById'=>'string,1',
         'CreatedDate'=>'dateTime,1',
         'Description'=>'string,1',
         'Fax'=>'string,1',
         'FirstName'=>'string,1',
         'HomePhone'=>'string,1',
         'LastName'=>'string,1',
         'MobilePhone'=>'string,1',
         'NickName'=>'string,1',
         'OtherPhone'=>'string,1',
         'OtherPhoneType'=>'string,1',
         'PersonalEmail'=>'string,1',
         'PostalCode'=>'string,1',
         'State'=>'string,1',
         'TaxRegion'=>'string,1',
         'UpdatedDate'=>'dateTime,1',
         'UpdatedById'=>'string,1',
         'TaxRegion'=>'string,1',
         'WorkEmail'=>'string,1',
         'WorkPhone'=>'string,1',
          'County'=>'string,1'
    };

    public static final Map<String,String> subscription_schema = new Map<String,String> {
         'Id'=>'string,1',
         'AccountId'=>'string,1',
         'AncestorAccountId'=>'string,1',
         'AutoRenew'=>'boolean,1',
         'CancelledDate'=>'datetime,1',
         'ContractAcceptanceDate'=>'datetime,1',
         'ContractEffectiveDate'=>'datetime,1',
         'CreatedById'=>'string,1',
             'CreatedDate'=>'dateTime,1',
             'CreatorAccountId'=>'string,1',
         'Currency'=>'string,1',
         'InitialTerm'=>'int,1',
         'Name'=>'string,1',
         'Notes'=>'string,1',
         'OriginalCreatedDate'=>'datetime,1',
         'OriginalId'=>'string,1',
         'OriginalSubscriptionId'=>'string,1',
         'PreviousSubscriptionId'=>'string,1',
         'RenewalTerm'=>'int,1',
         'ServiceActivationDate'=>'datetime,1',
         'Status'=>'string,1',
         'SubscriptionEndDate'=>'datetime,1',
         'SubscriptionStartDate'=>'datetime,1',
         'TermEndDate'=>'datetime,1',
         'TermStartDate'=>'datetime,1',
         'TermType'=>'string,1',
         'UpdatedDate'=>'dateTime,1',
         'UpdatedById'=>'string,1',
         'Version'=>'int,1',
         'VersionCreatedDate'=>'datetime,1',
         'Petname__c'=>'string,1',
         'DeviceID__c'=>'string,1'
        };
    
    public static final Map<String,String> paymentmethod_schema = new Map<String,String>{
        'Id'=>'string,1',
        'fieldsToNull'=> 'string,1',
        'AccountId'=>'string,1',
        'AchAbaCode'=>'string,1',
        'AchAccountName'=>'string,1',
        'AchAccountNumber'=>'string,1',
        'AchAccountNumberMask'=>'string,1',
        'AchAccountType'=>'string,1',
        'AchBankName'=>'string,1',
        'Active'=>'boolean,1',
        'BankIdentificationNumber'=>'string,1',
        'CreatedDate'=>'datetime,1',
        'CreatedById'=>'string,1',
        'CreditCardAddress1'=>'string,1',
        'CreditCardAddress2'=>'string,1',
        'CreditCardCity'=>'string,1',
        'CreditCardCountry'=>'string,1',
        'CreditCardExpirationMonth'=>'int,1',
        'CreditCardExpirationYear'=>'int,1',
        'CreditCardHolderName'=>'string,1',
        'CreditCardMaskNumber'=>'string,1',
        'CreditCardNumber'=>'string,1',
        'CreditCardPostalCode'=>'string,1',
        'CreditCardSecurityCode'=>'string,1',
        'CreditCardState'=>'string,1',
        'CreditCardType'=>'string,1',
        'DeviceSessionId'=>'string,1',
                'Email'=>'string,1',
                'IPAddress'=>'string,1',
                'LastFailedSaleTransactionDate'=>'string,1',
                'LastTransactionDateTime'=>'string,1',
                'LastTransactionStatus'=>'string,1',
                'MaxConsecutivePaymentFailures'=>'int,1',
                'Name'=>'string,1',
                'NumConsecutiveFailures'=>'int,1',
                'PaymentRetryWindow'=>'int,1',
                'PaypalBaid'=>'string,1',
                'PaypalEmail'=>'string,1',
                'Phone'=>'string,1',
                'SkipValidation'=>'boolean,1',
                'Type'=>'string,1',
        'UpdatedDate'=>'datetime,1',
        'UpdatedById'=>'string,1',
        'UseDefaultRetryRule'=>'boolean,1'
    };  
    
    
    public static final Map<String,String> payment_schema = new Map<String, String>
        {'Id'=>'string,1',
        
                        'AccountingCode'=>'string,1',
                        'AppliedCreditBalanceAmount'=>'double,1',
                        'AppliedInvoiceAmount'=>'double,1',
                        'AuthTransactionId'=>'string,1',
                        'BankIdentificationNumber'=>'string,1',
                        'CreatedDate'=>'datetime,1',
                        'CreatedById'=>'string,1',
                        'GatewayOrderId'=>'string,1',
                        'InvoiceId'=>'string,1',
                        'InvoiceNumber'=>'string,1',
                        'PaymentNumber'=>'string,1',
                        'RefundAmount'=>'double,1',
                        'SecondPaymentReferenceId'=>'string,1',
                        'SoftDescriptor'=>'string,1',
                        'SoftDescriptorPhone'=>'string,1',
                        'TransferredToAccounting'=>'string,1',
                        'UpdatedDate'=>'datetime,1',
                        'UpdatedById'=>'string,1',
                'fieldsToNull'=>'string,1','AccountId'=>'string,1',
         'Amount'=>'double,1','Comment'=>'string,1','EffectiveDate'=>'datetime,1',
         'GatewayResponse'=>'string,1','GatewayResponseCode'=>'string,1',
         'PaymentMethodId'=>'string,1','ReferenceId'=>'string,1','Status'=>'string,1','Type'=>'string,1'};

    public static final Map<String,String> invoicepayment_schema = new Map<String, String>
        {'Id'=>'string,1','fieldsToNull'=>'string,1',
            'Amount'=>'double,1',
            'CreatedDate'=>'datetime,1',
            'CreatedById'=>'string,1',
            'InvoiceId'=>'string,1',
            'PaymentId'=>'string,1',
            'RefundAmount'=>'double,1',
            'UpdatedDate'=>'datetime,1',
            'UpdatedById'=>'string,1'
        
            
            };

    public static final Map<String,String> product_schema = new Map<String,String>  {
         'Id'=>'string,1',
         'fieldsToNull'=> 'string,1',
         'Category'=>'string,1',
         'Description'=>'string,1',
         'EffectiveEndDate'=>'datetime,1',
         'EffectiveStartDate'=>'datetime,1',
         'Name'=>'string,1',
         'SKU'=>'string,1',
         'CreatedDate'=>'datetime,1',
         'CreatedById'=>'string,1',
         'UpdatedDate'=>'datetime,1',
         'UpdatedById'=>'string,1'
    };

    public static final Map<String,String> productrateplan_schema = new Map<String,String>  {
         'Id'=>'string,1',
         'fieldsToNull'=> 'string,1',
         'Description'=>'string,1',
         'EffectiveEndDate'=>'datetime,1',
         'EffectiveStartDate'=>'datetime,1',
         'Name'=>'string,1',
         'ProductId'=>'string,1',
         'CreatedDate'=>'datetime,1',
         'CreatedById'=>'string,1',
         'UpdatedDate'=>'datetime,1',
         'UpdatedById'=>'string,1'
    };
    
    
    public static final Map<String,String> productrateplanchargetier_schema = new Map<String, String>{
         'Id'=>'string,1',
         'AccountingCode'=>'string,1',
         'Active'=>'boolean,1',
         'BillCycleDay'=>'int,1',
         'CreatedDate'=>'datetime,1',
         'CreatedById'=>'string,1',
         'UpdatedDate'=>'datetime,1',
         'UpdatedById'=>'string,1',
         'Currency'=>'string,1',
         'EndingUnit'=>'double,1',       
         'IsOveragePrice'=>'boolean,1',
         'Price'=>'double,1',
         'PriceFormat'=>'string,1',
         'ProductRatePlanChargeId'=>'string,1',
         'StartingUnit'=>'double,1',
         'Tier'=>'int,1'         
         
        };
    
    
     public static final Map<String,String> productrateplanchargetierdata_schema = new Map<String, String>{
                'ProductRatePlanChargeTier'=>'zobject_custom,-1,ProductRatePlanChargeTier'
        };

    
    public static final Map<String,String> productrateplancharge_schema = new Map<String,String>    {
         'Id'=>'string,1',
         'AccountingCode'=>'string,1',
         'BillCycleType'=>'string,1',
         'BillCycleDay'=>'int,1',
         'BillingPeriod'=>'string,1',
         'BillingPeriodAlignment'=>'string,1',
         'ChargeModel'=>'string,1',
         'ChargeType'=>'string,1',
         'IncludedUnits'=>'double,1',
         'CreatedById'=>'string,1',
         'CreatedDate'=>'datetime,1',
         'DefaultQuantity'=>'double,1',
         'Description'=>'string,1',
         'MaxQuantity'=>'double,1',
         'MinQuantity'=>'double,1',
         'Model'=>'string,1', // Old field.
         'Name'=>'string,1',
         'NumberOfPeriod'=>'double,1',
         'OverageCalculationOption'=>'string,1',
         'OverageUnusedUnitsCreditOption'=>'string,1',
         'ProductRatePlanChargeTierData'=>'zobject_custom,-1,ProductRatePlanChargeTierData',
         'ProductRatePlanId'=>'string,1',
         'RevRecCode'=>'string,1',
         'RevRecTriggerCondition'=>'string,1',
         'SmoothingModel'=>'string,1',
         'SpecificBillingPeriod'=>'double,1',
         'Taxable'=>'string,1',
         'TaxCode'=>'string,1',
         'TriggerEvent'=>'string,1',
         'Type'=>'string,1', // Old field.
         'UOM'=>'string,1',
         'UpdatedById'=>'datetime,1',
         'UpdatedDate'=>'string,1'
    };

    public static final Map<String,String> invoice_schema = new Map<String, String>
        {'Id'=>'string,1',
         'fieldsToNull'=>'string,1',
         'AccountId'=>'string,1',
         'AdjustmentAmount'=>'double,1',
         'Amount'=>'double,1',
         'AmountWithoutTax'=>'double,1',
         'Balance'=>'double,1',
         'Body'=>'string,1',
         'Comments'=>'string,1',
         'CreatedBy'=>'string,1',
         'CreatedDate'=>'datetime,1',
         'DueDate'=>'datetime,1',
         'IncludesOneTime'=>'boolean,1',
         'IncludesRecurring'=>'boolean,1',
         'IncludesUsage'=>'boolean,1',
         'InvoiceDate'=>'datetime,1',
         'InvoiceNumber'=>'string,1',
         'LastEmailSentDate'=>'datetime,1',
         'PaymentAmount'=>'double,1',
         'PostedBy'=>'string,1',
         'PostedDate'=>'datetime,1',
         'RefundAmount'=>'double,1',
         'Status'=>'string,1',
         'TargetDate'=>'datetime,1',
         'TaxAmount'=>'double,1',
         'TaxExemptAmount'=>'double,1',
         'TransferredToAccounting'=>'string,1',
         'UpdatedById'=>'string,1',
         'UpdatedDate'=>'datetime,1'
            };

    public static final Map<String,String> invoiceitem_schema = new Map<String, String>
        {'Id'=>'string,1',
         'fieldsToNull'=>'string,1',
         'AccountingCode'=>'string,1',
         'ChargeAmount'=>'double,1',
         'ChargeDate'=>'datetime,1',
         'ChargeDescription'=>'string,1',
         'ChargeName'=>'string,1',
         'ChargeNumber'=>'string,1',
         'CreatedById'=>'string,1',
         'CreatedDate'=>'datetime,1',
         'InvoiceId'=>'string,1',
         'ProductDescription'=>'string,1',
         'ProductId'=>'string,1',
         'ProductName'=>'string,1',
         'Quantity'=>'double,1',
         'RatePlanChargeId'=>'string,1',
         'RevRecCode'=>'string,1',
         'RevRecStartDate'=>'datetime,1',
         'RevRecTriggerCondition'=>'string,1',
         'SKU'=>'string,1',
         'ServiceEndDate'=>'datetime,1',
         'ServiceStartDate'=>'datetime,1',
         'SubscriptionId'=>'string,1',
         'SubscriptionNumber'=>'string,1',
         'TaxAmount'=>'double,1',
         'TaxCode'=>'string,1',
         'TaxExemptAmount'=>'double,1',
         'UOM'=>'string,1',
         'UnitPrice'=>'double,1',
         'UpdatedById'=>'string,1',
         'UpdatedDate'=>'datetime,1'
   
            };

    public static final Map<String,String> taxationitem_schema = new Map<String, String>
        {'Id'=>'string,1','fieldsToNull'=>'string,1',
            'AccountingCode'=>'string,1',
            'ExemptAmount'=>'double,1',
            'InvoiceId'=>'string,1',
            'InvoiceItemId'=>'string,1',
            'Jurisdiction'=>'string,1',
            'LocationCode'=>'string,1',
            'Name'=>'string,1',
            'TaxAmount'=>'double,1',
            'TaxCode'=>'string,1',
            'TaxCodeDescription'=>'string,1',
            'TaxDate'=>'datetime,1',
            'TaxRate'=>'double,1',
            'TaxRateDescription'=>'string,1',
            'TaxRateType'=>'string,1',
             'CreatedById'=>'string,1',
            'CreatedDate'=>'datetime,1',
            'UpdatedById'=>'datetime,1',
            'UpdatedDate'=>'string,1'
                    
            
            };

    public static final Map<String,String> generate_schema = new Map<String, String>
        {'AccountId'=>'string,1',
        	'IncludesOneTime'=>'boolean,1',
             'IncludesRecurring'=>'boolean,1',
            'IncludesUsage'=>'boolean,1',
            'InvoiceDate'=>'datetime,1',
            'TargetDate'=>'datetime,1'
      	
       
         };




    public static final Map<String,String> usage_schema = new Map<String,String>    {
         'Id'=>'string,1',
         'fieldsToNull'=> 'string,1',
         'AccountId'=>'string,1',
         'AncestorAccountId'=>'string,1',
         'ChargeId'=>'string,1',
          'CreatedById'=>'string,1',
      'CreatedDate'=>'datetime,1',
         'AccountNumber'=>'string,1',
         'Description'=>'string,1',
         'ChargeNumber'=>'string,1',
         'EndDateTime'=>'datetime,1',
         'Quantity'=>'double,1',
         'RbeStatus'=>'string,1',
         'SourceName'=>'string,1',
         'SourceType'=>'string,1',
         'StartDateTime'=>'datetime,1',
         'SubmissionDateTime'=>'datetime,1',
         'SubscriptionNumber'=>'string,1',
         'SubscriptionId'=>'string,1',
         'UOM'=>'string,1',
         'Description'=>'string,1',
         'UpdatedById'=>'datetime,1',
     'UpdatedDate'=>'string,1'
    };

	public static final Map<String,String> invoiceadjustment_schema = new Map<String,String>    {
         'Id'=>'string,1',
         'fieldsToNull'=> 'string,1',
         'AccountId'=>'string,1',
         'AccountingCode'=>'string,1',
         'AdjustmentDate'=>'datetime,1',
         'AdjustmentNumber'=>'string,1',
         'Amount'=>'double,1',
         'CancelledById'=>'string,1',
         'CancelledOn'=>'datetime,1',
         'Comments'=>'string,1',
         'CreatedById'=>'string,1',
         'CreatedDate'=>'datetime,1',
         'CustomerName'=>'string,1',
         'CustomerNumber'=>'string,1',
         'ImpactAmount'=>'double,1',
         'InvoiceId'=>'string,1',
         'InvoiceNumber'=>'string,1',
         'ReferenceId'=>'string,1',
         'Status'=>'string,1',
         'TransferredToAccounting'=>'string,1',
         'Type'=>'string,1',
         'UpdatedById'=>'string,1',
         'UpdatedDate'=>'datetime,1'
    };
    
     public static final Map<String,String> invoiceitemadjustment_schema = new Map<String,String>    {
         'Id'=>'string,1',
         'fieldsToNull'=> 'string,1',
         'AccountId'=>'string,1',
         'AccountingCode'=>'string,1',
         'AdjustmentDate'=>'datetime,1',
         'AdjustmentNumber'=>'string,1',
         'Amount'=>'double,1',
         'CancelledById'=>'string,1',
         'CancelledDate'=>'datetime,1',
         'Comment'=>'string,1',
         'CreatedById'=>'string,1',
         'CreatedDate'=>'datetime,1',
         'CustomerName'=>'string,1',
         'CustomerNumber'=>'string,1',
         'InvoiceId'=>'string,1',
         'InvoiceItemName'=>'string,1',
         'InvoiceNumber'=>'string,1',
         'ReferenceId'=>'string,1',
         'ServiceEndDate'=>'datetime,1',
         'ServiceStartDate'=>'datetime,1',
         'SourceId'=>'string,1',
         'SourceType'=>'string,1',
         'Status'=>'string,1',
         'TransferredToAccounting'=>'string,1',
         'Type'=>'string,1',
         'UpdatedById'=>'string,1',
         'UpdatedDate'=>'datetime,1'
    };
    
    public static final Map<String,String> refundinvoicepayment_schema = new Map<String,String>    {
         'Id'=>'string,1',
         'fieldsToNull'=> 'string,1',
         'CreatedById'=>'string,1',
         'CreatedDate'=>'string,1',
         'InvoicePaymentId'=>'string,1',
         'RefundAmount'=>'string,1',
         'RefundId'=>'string,1',
         'UpdatedById'=>'string,1',
         'UpdatedDate'=>'datetime,1'
    };

    public static final Map<String,String> creditbalanceadjustment_schema = new Map<String,String>    {
         'Id'=>'string,1',
         'fieldsToNull'=> 'string,1',
         'AccountId'=>'string,1',
         'AccountingCode'=>'string,1',
         'AdjustmentDate'=>'datetime,1',
         'Amount'=>'double,1',
         'Comment'=>'string,1',
         'CreatedById'=>'string,1',
         'CreatedDate'=>'datetime,1',
         'Number'=>'string,1',
         'ReferenceId'=>'string,1',
         'SourceTransactionId'=>'string,1',
         'SourceTransactionNumber'=>'string,1',
         'SourceTransactionType'=>'string,1',
         'Status'=>'string,1',
         'TransferredToAccounting'=>'string,1',
         'Type'=>'string,1',
         'UpdatedById'=>'string,1',
         'UpdatedDate'=>'datetime,1'
    };

    public static final Map<String,String> export_schema = new Map<String,String>    {
         'Id'=>'string,1',
         'fieldsToNull'=> 'string,1',
         'CreatedById'=>'string,1',
         'CreatedDate'=>'datetime,1',
         'FileId'=>'string,1',
         'Format'=>'string,1',
         'Name'=>'string,1',
         'Query'=>'string,1',
         'Size'=>'int,1',
         'Status'=>'string,1',
         'StatusReason'=>'string,1',
         'UpdatedById'=>'string,1',
         'UpdatedDate'=>'datetime,1'
    };
    
    
    


    
    //schema for api call out result parsing and subscribe request, should only referenced by zApi
    public static final String Z_LOGIN_RESULT = 'LoginResult';
    public static final String Z_SAVE_RESULT = 'SaveResult';
    public static final String Z_DELETE_RESULT = 'DeleteResult';
    public static final String Z_ERROR = 'Error';
    public static final String Z_SUB_RESULT = 'SubscribeResult';
    public static final String Z_AMEND_RESULT = 'AmendResult';
    
    
        
    public static final Map<String,String> loginresult_schema = new Map<String,String>{
        'Session'=>'string,1',
        'ServerUrl'=>'string,1'
    };


    public static final Map<String,String> saveresult_schema = new Map<String, String>{
        'Errors'=>'zobject_custom,-1,Error',
        'Id'=>'string,1',
        'Success'=>'boolean,1'
    };
        
    
    public static final Map<String,String> deleteresult_schema = new Map<String, String>{
        'Errors'=>'zobject_custom,-1,Error',
        'id'=>'string,1',
        'success'=>'boolean,1'
    };
        
    public static final Map<String,String> error_schema = new Map<String, String>{
        'Code'=>'string,1',
        'Message'=>'string,1',
        'Field'=>'boolean,1'
    };
    
    public static final Map<String,String> subscriberesult_schema = new Map<String, String>{
        'AccountId'=>'string,1',
        'AccountNumber'=>'string,1',
        'Errors'=>'zobject_custom,-1,Error',
        'InvoiceData'=>'InvoiceData,1',
        'InvoiceId'=>'string,1',
        'InvoiceNumber'=>'string,1',
        'PaymentTransactionNumber'=>'string,1',
        'SubscriptionId'=>'string,1',
        'SubscriptionNumber'=>'string,1',
        'Success'=>'boolean,1'
    };
    
	public static final Map<String,String> amendresult_schema = new Map<String, String>{
        'AmendmentIds'=>'string,-1,string',
        'Errors'=>'zobject_custom,-1,Error',
        'InvoiceDatas'=>'InvoiceDatas,1',
        'Success'=>'boolean,1'
        
    };
    
   
    
    
    
    
    public static Map<String,String> getschema(String ztype){
        if(zSchema_custom.Z_ACCOUNT == ztype){return zSchema_custom.account_schema; }
        else if(zSchema_custom.Z_AMENDMENT == ztype){return zSchema_custom.amendment_schema;}
        else if(zSchema_custom.Z_CONTACT == ztype){return zSchema_custom.contact_schema;}
        else if(zSchema_custom.Z_DELETE_RESULT == ztype){return zSchema_custom.deleteresult_schema;}
        else if(zSchema_custom.Z_ERROR == ztype){return zSchema_custom.error_schema;}
        else if(zSchema_custom.Z_INVOICE == ztype){return zSchema_custom.invoice_schema;}
        else if(zSchema_custom.Z_INVOICE_ITEM == ztype){return zSchema_custom.invoiceitem_schema;}
        else if(zSchema_custom.Z_INVOICE_PAYMENT == ztype){return zSchema_custom.invoicepayment_schema;}
        else if(zSchema_custom.Z_LOGIN_RESULT == ztype){return zSchema_custom.loginresult_schema;}
        else if(zSchema_custom.Z_PAYMENT == ztype){return zSchema_custom.payment_schema;}
        else if(zSchema_custom.Z_PAYMENT_METHOD == ztype){return zSchema_custom.paymentmethod_schema;}
        else if(zSchema_custom.Z_PRODUCT == ztype){return zSchema_custom.product_schema;}
        else if(zSchema_custom.Z_PRODUCT_RATEPLAN == ztype){return zSchema_custom.productrateplan_schema;}
        else if(zSchema_custom.Z_PRODUCT_RATEPLAN_CHARGE == ztype){return zSchema_custom.productrateplancharge_schema;}
        else if(zSchema_custom.Z_RATEPLAN == ztype){return zSchema_custom.rateplan_schema;}
        else if(zSchema_custom.Z_RATEPLAN_CHARGE == ztype){return zSchema_custom.rateplancharge_schema;}
        else if(zSchema_custom.Z_RATEPLAN_CHARGE_DATA == ztype){return zSchema_custom.rateplanchargedata_schema;}
        else if(zSchema_custom.Z_RATEPLAN_CHARGE_TIER == ztype){return zSchema_custom.rateplanchargetier_schema;}
        else if(zSchema_custom.Z_RATEPLAN_DATA == ztype){return zSchema_custom.rateplandata_schema;}
        else if(zSchema_custom.Z_SAVE_RESULT == ztype){return zSchema_custom.saveresult_schema;}
        else if(zSchema_custom.Z_SUBSCRIPTION == ztype){return zSchema_custom.subscription_schema;}
        else if(zSchema_custom.Z_SUB_RESULT == ztype){return zSchema_custom.subscriberesult_schema;}
        else if(zSchema_custom.Z_AMEND_RESULT == ztype){return zSchema_custom.amendresult_schema;}
        else if(zSchema_custom.Z_TAXATION_ITEM == ztype){return zSchema_custom.taxationitem_schema;}
        else if(zSchema_custom.Z_USAGE == ztype){return zSchema_custom.usage_schema;}
        else if(zSchema_custom.Z_OBJECT == ztype){return zSchema_custom.zObject_schema;}
        else if(zSchema_custom.Z_RATEPLAN_DATA == ztype){return zSchema_custom.rateplandata_schema;}
        else if(zSchema_custom.Z_REFUND == ztype){return zSchema_custom.refund_schema;}
        else if(zSchema_custom.Z_GENERATE == ztype){return zSchema_custom.generate_schema;}
        else if(zSchema_custom.Z_INVOICE_ADJUSTMENT == ztype){return zSchema_custom.invoiceadjustment_schema;}
        else if(zSchema_custom.Z_INVOICE_ITEM_ADJUSTMENT == ztype){return zSchema_custom.invoiceitemadjustment_schema;}
        else if(zSchema_custom.Z_REFUND_INVOICE_PAYMENT == ztype){return zSchema_custom.refundinvoicepayment_schema;}
        else if(zSchema_custom.Z_CREDIT_BALANCE_ADJUSTMENT == ztype){return zSchema_custom.creditbalanceadjustment_schema;}
        else if(zSchema_custom.Z_EXPORT == ztype){return zSchema_custom.export_schema;}

        else{
             throw new zobject_custom.ObjectException('ztype: ' + ztype + ' currently not supported.');
        	 //return zSchema_custom.export_schema;
        }
    } 
        
    public static Boolean isSupportedzType(String ztype){
        return 
        Z_ACCOUNT == ztype ||
        Z_AMENDMENT == ztype ||
        Z_CONTACT == ztype ||
        Z_DELETE_RESULT == ztype ||
        Z_ERROR == ztype ||
        Z_INVOICE == ztype ||
        Z_INVOICE_ITEM == ztype ||
        Z_INVOICE_PAYMENT == ztype ||
        Z_LOGIN_RESULT == ztype ||
        Z_PAYMENT == ztype ||
        Z_PAYMENT_METHOD == ztype ||
        Z_PRODUCT == ztype ||
        Z_PRODUCT_RATEPLAN == ztype ||
        Z_PRODUCT_RATEPLAN_CHARGE == ztype ||
        Z_RATEPLAN == ztype ||
        Z_RATEPLAN_CHARGE == ztype ||
        Z_RATEPLAN_CHARGE_DATA == ztype ||
        Z_RATEPLAN_CHARGE_TIER == ztype ||
        Z_RATEPLAN_DATA == ztype ||
        Z_SAVE_RESULT == ztype ||
        Z_SUBSCRIPTION == ztype ||
        Z_SUB_RESULT == ztype ||
        Z_TAXATION_ITEM == ztype ||
        Z_AMEND_RESULT == ztype ||
        Z_USAGE == ztype  ||
        Z_OBJECT == ztype ||
        Z_REFUND == ztype ||
        Z_GENERATE == ztype ||
        Z_INVOICE_ADJUSTMENT == ztype ||
		Z_INVOICE_ITEM_ADJUSTMENT == ztype ||
		Z_REFUND_INVOICE_PAYMENT == ztype ||
		Z_CREDIT_BALANCE_ADJUSTMENT == ztype ||
		Z_EXPORT == ztype;
    }
}