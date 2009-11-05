From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: virtio: Add memory statistics reporting to the balloon driver
Date: Thu, 05 Nov 2009 17:39:09 -0600
Message-ID: <4AF3621D.1080401@us.ibm.com>
References: <1257461425.3121.22.camel@aglitke>
	<1257462155.3121.25.camel@aglitke>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1257462155.3121.25.camel@aglitke>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: agl@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

agl@linux.vnet.ibm.com wrote:
> Here are the corresponding changes to the Linux virtio driver...
>
>     virtio: Add memory statistics reporting to the balloon driver
>     
>     When using ballooning to manage overcommitted memory on a host, a system for
>     guests to communicate their memory usage to the host can provide information
>     that will minimize the impact of ballooning on the guests.  The current method
>     employs a daemon running in each guest that communicates memory statistics to a
>     host daemon at a specified time interval.  The host daemon aggregates this
>     information and inflates and/or deflates balloons according to the level of
>     host memory pressure.  This approach is effective but overly complex since a
>     daemon must be installed inside each guest and coordinated to communicate with
>     the host.  A simpler approach is to collect memory statistics in the virtio
>     balloon driver and communicate them to the host via the device config space.
>     
>     This patch enables the guest-side support by adding stats collection and
>     reporting to the virtio balloon driver.
>     
>     Signed-off-by: Adam Litke <agl@us.ibm.com>
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 3a43ebf..1029363 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -135,6 +135,7 @@ static int virtio_dev_probe(struct device *_d)
>  			set_bit(i, dev->features);
>
>  	dev->config->finalize_features(dev);
> +	printk("virtio_dev_probe: final features = %lx\n", dev->features[0]);
>   

Looks like leftover debugging.

>  	err = drv->probe(dev);
>  	if (err)
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 200c22f..77cb953 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -180,6 +180,45 @@ static void update_balloon_size(struct virtio_balloon *vb)
>  			      &actual, sizeof(actual));
>  }
>
> +static inline void update_stat(struct virtio_device *vdev, int feature,
> +				unsigned long value, unsigned offset)
> +{
> +	if (virtio_has_feature(vdev, feature)) {
> +		vdev->config->set(vdev, offset, &value, sizeof(value));
>   

I think this bit assumes a little endian guest.  We shouldn't make that 
assumption.

For virtio kernel patches, please CC the virtualization list and Rusty 
as he's the maintainer.  It wouldn't hurt to CC lkml either.

-- 
Regards,

Anthony Liguori
