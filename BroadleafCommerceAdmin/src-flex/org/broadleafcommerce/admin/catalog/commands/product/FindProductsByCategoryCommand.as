package org.broadleafcommerce.admin.catalog.commands.product
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.broadleafcommerce.admin.catalog.business.CatalogServiceDelegate;
	import org.broadleafcommerce.admin.catalog.control.events.product.FindProductsByCategoryEvent;
	import org.broadleafcommerce.admin.catalog.model.CatalogModelLocator;

	public class FindProductsByCategoryCommand implements Command, IResponder
	{
		public function FindProductsByCategoryCommand()
		{
		}

		public function execute(event:CairngormEvent):void
		{
			trace("FindProductsByCategoryCommand.execute()");
			var fpfce:FindProductsByCategoryEvent = FindProductsByCategoryEvent(event);
			var delegate:CatalogServiceDelegate = new CatalogServiceDelegate(this);
			delegate.findActiveProductsByCategory(fpfce.category);
		}

		public function result(data:Object):void
		{
			trace("FindProductsByCategoryCommand.result()");
			var event:ResultEvent = ResultEvent(data);
			CatalogModelLocator.getInstance().productModel.catalogProducts = ArrayCollection(event.result);
			CatalogModelLocator.getInstance().productModel.filteredCatalogProducts = ArrayCollection(event.result);
		}
		
		public function fault(info:Object):void
		{
			trace("FindProductsByCategoryCommand.fault()");
			var event:FaultEvent = FaultEvent(info);
			Alert.show("Error: "+ event);
		}

		
	}
}