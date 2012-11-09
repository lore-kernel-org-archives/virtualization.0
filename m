From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: Don't access index after unregister.
Date: Fri, 9 Nov 2012 07:14:13 +0200
Message-ID: <20121109051413.GB9242@redhat.com>
References: <1352371427-32363-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1352371427-32363-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 08, 2012 at 11:43:47AM +0100, Cornelia Huck wrote:
> Virtio wants to release used indices after the corresponding
> virtio device has been unregistered. However, virtio does not
> hold an extra reference, giving up its last reference with
> device_unregister(), making accessing dev->index afterwards
> invalid.
> 
> I actually saw problems when testing my (not-yet-merged)
> virtio-ccw code:
> 
> - device_add virtio-net,id=xxx
> -> creates device virtio<n> with n>0
> 
> - device_del xxx
> -> deletes virtio<n>, but calls ida_simple_remove with an
>    index of 0
> 
> - device_add virtio-net,id=xxx
> -> tries to add virtio0, which is still in use...
> 
> So let's save the index we want to release before calling
> device_unregister().
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  drivers/virtio/virtio.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 1e8659c..809b0de 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -225,8 +225,10 @@ EXPORT_SYMBOL_GPL(register_virtio_device);
>  
>  void unregister_virtio_device(struct virtio_device *dev)
>  {
> +	int index = dev->index; /* save for after device release */

It's obvious from code that we safe for after release,
I think a better comment would explain *why* we do this.

Something like
	/*
	   device_unregister drops reference to device so put_device could
	   invoke release callback. In case that callback will free the device,
	   make sure we don't access device after this call.
	 */
   	int index = dev->index;

?

> +
>  	device_unregister(&dev->dev);
> -	ida_simple_remove(&virtio_index_ida, dev->index);
> +	ida_simple_remove(&virtio_index_ida, index);
>  }
>  EXPORT_SYMBOL_GPL(unregister_virtio_device);
>  
> -- 
> 1.7.12.4
