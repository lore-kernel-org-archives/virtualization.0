From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: find_vqs operation starting at arbitrary index
Date: Mon, 1 Jun 2009 11:11:06 +0300
Message-ID: <20090601081106.GA5061@redhat.com>
References: <20090601080348.GA17119@amit-x200.pnq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090601080348.GA17119@amit-x200.pnq.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 01, 2009 at 01:33:48PM +0530, Amit Shah wrote:
> Hello,
> 
> The recent find_vqs operation doesn't allow for a vq to be found at an
> arbitrary location; it's meant to be called once at startup to find all
> possible queues and never called again.
> 
> This doesn't work for devices which can have queues hot-plugged at
> run-time. This can be made to work by passing the 'start_index' value as
> was done earlier for find_vq, but I doubt something like the following
> will work. The MSI vectors might need some changing as well.

How, specifically?

> If this indeed is the right way to do it, I can add a
> 
> virtio_find_vqs helper along similar lines as virtio_find_single_vq and
> pass '0' as the start index to the ->find_vqs operation.
> 
> Or is there another way to do it?
> 
> diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
> index 193c8f0..cb3f8df 100644
> --- a/drivers/virtio/virtio_pci.c
> +++ b/drivers/virtio/virtio_pci.c
> @@ -499,7 +499,7 @@ static void vp_del_vqs(struct virtio_device *vdev)
>  
>  /* the config->find_vqs() implementation */
>  static int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> -		       struct virtqueue *vqs[],
> +		       unsigned start_index, struct virtqueue *vqs[],
>  		       vq_callback_t *callbacks[],
>  		       const char *names[])
>  {
> @@ -516,7 +516,8 @@ static int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  		goto error_request;
>  
>  	for (i = 0; i < nvqs; ++i) {
> -		vqs[i] = vp_find_vq(vdev, i, callbacks[i], names[i]);
> +		vqs[i] = vp_find_vq(vdev, start_index + i, callbacks[i],
> +				    names[i]);
>  		if (IS_ERR(vqs[i]))
>  			goto error_find;
>  	}
> 
> 
> 
> 		Amit
