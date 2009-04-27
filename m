From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 0/8] virtio: add guest MSI-X support
Date: Mon, 27 Apr 2009 20:19:17 +0300
Message-ID: <20090427171917.GC2276__47744.3944233984$1240856723$gmane$org@redhat.com>
References: <20090427123136.GA1152@redhat.com> <49F5CA08.6060003@redhat.com>
	<20090427153936.GA2276@redhat.com>
	<200904271859.53190.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200904271859.53190.borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm@vger.kernel.org, Avi Kivity <avi@redhat.com>, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 27, 2009 at 06:59:52PM +0200, Christian Borntraeger wrote:
> Am Monday 27 April 2009 17:39:36 schrieb Michael S. Tsirkin:
> > So we'll probably need to rename request_vqs to request_vectors,
> > but we probably still need the driver to pass the number of
> > vectors it wants to the transport. Right?
> 
> This might be a stupid idea, but would something like the following
> be sufficient for you?

Yes.

> Index: linux-2.6/drivers/net/virtio_net.c
> ===================================================================
> --- linux-2.6.orig/drivers/net/virtio_net.c
> +++ linux-2.6/drivers/net/virtio_net.c
> @@ -1021,6 +1021,7 @@ static unsigned int features[] = {
>  static struct virtio_driver virtio_net = {
>         .feature_table = features,
>         .feature_table_size = ARRAY_SIZE(features),
> +       .num_vq_max = 3,
>         .driver.name =  KBUILD_MODNAME,
>         .driver.owner = THIS_MODULE,
>         .id_table =     id_table,
> Index: linux-2.6/include/linux/virtio.h
> ===================================================================
> --- linux-2.6.orig/include/linux/virtio.h
> +++ linux-2.6/include/linux/virtio.h
> @@ -110,6 +110,7 @@ struct virtio_driver {
>         const struct virtio_device_id *id_table;
>         const unsigned int *feature_table;
>         unsigned int feature_table_size;
> +       unsigned int num_vq_max;
>         int (*probe)(struct virtio_device *dev);
>         void (*remove)(struct virtio_device *dev);
>         void (*config_changed)(struct virtio_device *dev);

Good idea.

-- 
MST
