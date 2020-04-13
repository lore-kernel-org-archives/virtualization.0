From: "Derrick, Jonathan" <jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 11/34] iommu: Split off default domain allocation
 from group assignment
Date: Mon, 13 Apr 2020 22:10:50 +0000
Message-ID: <6a801ff9e6471bda7c6f510dfa2ba7e7c35cb559.camel@intel.com>
References: <20200407183742.4344-1-joro@8bytes.org>
 <20200407183742.4344-12-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane-mx.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20200407183742.4344-12-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
Content-ID: <32CCA6BEC8F53949916D97ED0C44AA2D-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane-mx.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: "heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org" <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "robin.murphy-5wv7dgnIgG8@public.gmane.org" <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "jean-philippe-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <jean-philippe-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org" <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, "agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Joerg,

On Tue, 2020-04-07 at 20:37 +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> When a bus is initialized with iommu-ops, all devices on the bus are
> scanned and iommu-groups are allocated for them, and each groups will
> also get a default domain allocated.
> 
> Until now this happened as soon as the group was created and the first
> device added to it. When other devices with different default domain
> requirements were added to the group later on, the default domain was
> re-allocated, if possible.
> 
> This resulted in some back and forth and unnecessary allocations, so
> change the flow to defer default domain allocation until all devices
> have been added to their respective IOMMU groups.
> 
> The default domains are allocated for newly allocated groups after
> each device on the bus is handled and was probed by the IOMMU driver.
> 
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
[snip]


I had to add the following for initial VMD support. The new PCIe domain
added on VMD endpoint probe didn't have the dev_iommu member set on the
VMD subdevices, which I'm guessing is due to probe_iommu_group already
having been run on the VMD endpoint's group prior to those subdevices
being added.

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8a5e1ac328dd..ac1e4fb9bf48 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1577,6 +1577,9 @@ static int iommu_bus_notifier(struct notifier_block *nb,
        if (action == BUS_NOTIFY_ADD_DEVICE) {
                int ret;
 
+               if (!dev_iommu_get(dev))
+                       return -ENOMEM;
+
                ret = iommu_probe_device(dev);
                return (ret) ? NOTIFY_DONE : NOTIFY_OK;
        } else if (action == BUS_NOTIFY_REMOVED_DEVICE) {
