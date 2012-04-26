From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/3] virtio: balloon: let host know of updated balloon
	size before module removal
Date: Thu, 26 Apr 2012 23:50:41 +0300
Message-ID: <20120426205041.GA30261@redhat.com>
References: <cover.1335467427.git.amit.shah@redhat.com>
	<22d281728c195b275e909be36535d9e14cefff27.1335467427.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <22d281728c195b275e909be36535d9e14cefff27.1335467427.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 27, 2012 at 12:45:56AM +0530, Amit Shah wrote:
> When the balloon module is removed, we deflate the balloon, reclaiming
> all the pages that were given to the host.  However, we don't update the
> config values for the new balloon size, resulting in the host showing
> outdated balloon values.
> 
> The size update is done after each leak and fill operation, only the
> module removal case was left out.
> 
> Signed-off-by: Amit Shah <amit.shah@redhat.com>


applied,
thanks

the rest are 3.5 material imo

> ---
>  drivers/virtio/virtio_balloon.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 6921326..04baad6 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -390,6 +390,7 @@ static void __devexit virtballoon_remove(struct virtio_device *vdev)
>  	/* There might be pages left in the balloon: free them. */
>  	while (vb->num_pages)
>  		leak_balloon(vb, vb->num_pages);
> +	update_balloon_size(vb);
>  
>  	/* Now we reset the device so we can clean up the queues. */
>  	vdev->config->reset(vdev);
> -- 
> 1.7.7.6
