From: Asias He <asias@redhat.com>
Subject: Re: [PATCH 1/2] virtio: console: rename cvq_lock to c_ivq_lock
Date: Fri, 29 Mar 2013 08:30:49 +0800
Message-ID: <20130329003049.GB22450@hj.localdomain>
References: <cover.1364469955.git.amit.shah@redhat.com>
	<31670e919527c1594c2fbab64c7a398a5f673086.1364469955.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <31670e919527c1594c2fbab64c7a398a5f673086.1364469955.git.amit.shah@redhat.com>
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

On Thu, Mar 28, 2013 at 04:58:32PM +0530, Amit Shah wrote:
> The cvq_lock was taken for the c_ivq.  Rename the lock to make that
> obvious.
> 
> We'll also add a lock around the c_ovq in the next commit, so there's no
> ambiguity.
> 
> Signed-off-by: Amit Shah <amit.shah@redhat.com>

Reviewed-by: Asias He <asias@redhat.com>

> ---
>  drivers/char/virtio_console.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index e905d5f..7e9bc1d 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -149,7 +149,7 @@ struct ports_device {
>  	spinlock_t ports_lock;
>  
>  	/* To protect the vq operations for the control channel */
> -	spinlock_t cvq_lock;
> +	spinlock_t c_ivq_lock;
>  
>  	/* The current config space is stored here */
>  	struct virtio_console_config config;
> @@ -1709,23 +1709,23 @@ static void control_work_handler(struct work_struct *work)
>  	portdev = container_of(work, struct ports_device, control_work);
>  	vq = portdev->c_ivq;
>  
> -	spin_lock(&portdev->cvq_lock);
> +	spin_lock(&portdev->c_ivq_lock);
>  	while ((buf = virtqueue_get_buf(vq, &len))) {
> -		spin_unlock(&portdev->cvq_lock);
> +		spin_unlock(&portdev->c_ivq_lock);
>  
>  		buf->len = len;
>  		buf->offset = 0;
>  
>  		handle_control_message(portdev, buf);
>  
> -		spin_lock(&portdev->cvq_lock);
> +		spin_lock(&portdev->c_ivq_lock);
>  		if (add_inbuf(portdev->c_ivq, buf) < 0) {
>  			dev_warn(&portdev->vdev->dev,
>  				 "Error adding buffer to queue\n");
>  			free_buf(buf, false);
>  		}
>  	}
> -	spin_unlock(&portdev->cvq_lock);
> +	spin_unlock(&portdev->c_ivq_lock);
>  }
>  
>  static void out_intr(struct virtqueue *vq)
> @@ -1986,10 +1986,11 @@ static int virtcons_probe(struct virtio_device *vdev)
>  	if (multiport) {
>  		unsigned int nr_added_bufs;
>  
> -		spin_lock_init(&portdev->cvq_lock);
> +		spin_lock_init(&portdev->c_ivq_lock);
>  		INIT_WORK(&portdev->control_work, &control_work_handler);
>  
> -		nr_added_bufs = fill_queue(portdev->c_ivq, &portdev->cvq_lock);
> +		nr_added_bufs = fill_queue(portdev->c_ivq,
> +					   &portdev->c_ivq_lock);
>  		if (!nr_added_bufs) {
>  			dev_err(&vdev->dev,
>  				"Error allocating buffers for control queue\n");
> @@ -2140,7 +2141,7 @@ static int virtcons_restore(struct virtio_device *vdev)
>  		return ret;
>  
>  	if (use_multiport(portdev))
> -		fill_queue(portdev->c_ivq, &portdev->cvq_lock);
> +		fill_queue(portdev->c_ivq, &portdev->c_ivq_lock);
>  
>  	list_for_each_entry(port, &portdev->ports, list) {
>  		port->in_vq = portdev->in_vqs[port->id];
> -- 
> 1.8.1.4
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

-- 
Asias
