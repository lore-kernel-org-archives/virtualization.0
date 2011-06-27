From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 2/2] xen: Add alias to autoload backend drivers
Date: Mon, 27 Jun 2011 12:13:27 -0400
Message-ID: <20110627161327.GO6978__29749.6748426513$1309191374$gmane$org@dumpdata.com>
References: <20110624215155.GB4735@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110624215155.GB4735@wavehammer.waldi.eu.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Bastian Blank <waldi@debian.org>, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 24, 2011 at 11:51:55PM +0200, Bastian Blank wrote:
> All the Xen backend drivers are assigned to a special bus type
> xen-backend. This allows userspace to load the modules on request.

Is there a specific version of udev that would take advantage of this?

> 
> This patch defines xen-backend:* aliases on the modules and exports this
> names through modalias and uevent.
> 
> Signed-off-by: Bastian Blank <waldi@debian.org>
> ---
>  drivers/block/xen-blkback/blkback.c       |    1 +
>  drivers/net/xen-netback/netback.c         |    1 +
>  drivers/xen/xenbus/xenbus_probe.c         |    3 ++-
>  drivers/xen/xenbus/xenbus_probe_backend.c |    3 +++
>  4 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
> index 5cf2993..ed62008 100644
> --- a/drivers/block/xen-blkback/blkback.c
> +++ b/drivers/block/xen-blkback/blkback.c
> @@ -824,3 +824,4 @@ static int __init xen_blkif_init(void)
>  module_init(xen_blkif_init);
>  
>  MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_ALIAS("xen-backend:vbd");
> diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
> index 0e4851b..fd00f25 100644
> --- a/drivers/net/xen-netback/netback.c
> +++ b/drivers/net/xen-netback/netback.c
> @@ -1743,3 +1743,4 @@ failed_init:
>  module_init(netback_init);
>  
>  MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_ALIAS("xen-backend:vif");
> diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
> index 2ed0b04..bd2f90c 100644
> --- a/drivers/xen/xenbus/xenbus_probe.c
> +++ b/drivers/xen/xenbus/xenbus_probe.c
> @@ -393,7 +393,8 @@ static ssize_t devtype_show(struct device *dev,
>  static ssize_t modalias_show(struct device *dev,
>  			     struct device_attribute *attr, char *buf)
>  {
> -	return sprintf(buf, "xen:%s\n", to_xenbus_device(dev)->devicetype);
> +	return sprintf(buf, "%s:%s\n", dev->bus->name,
> +		       to_xenbus_device(dev)->devicetype);
>  }
>  
>  struct device_attribute xenbus_dev_attrs[] = {
> diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
> index ec510e5..60adf91 100644
> --- a/drivers/xen/xenbus/xenbus_probe_backend.c
> +++ b/drivers/xen/xenbus/xenbus_probe_backend.c
> @@ -107,6 +107,9 @@ static int xenbus_uevent_backend(struct device *dev,
>  	if (xdev == NULL)
>  		return -ENODEV;
>  
> +	if (add_uevent_var(env, "MODALIAS=xen-backend:%s", xdev->devicetype))
> +		return -ENOMEM;
> +
>  	/* stuff we want to pass to /sbin/hotplug */
>  	if (add_uevent_var(env, "XENBUS_TYPE=%s", xdev->devicetype))
>  		return -ENOMEM;
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
