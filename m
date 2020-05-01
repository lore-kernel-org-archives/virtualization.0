From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v2] vhost: vsock: kick send_pkt worker once device is
 started
Date: Fri, 1 May 2020 16:40:51 +0200
Message-ID: <20200501144051.aotbofpyuy5tqcfp@steredhat>
References: <20200501043840.186557-1-justin.he@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200501043840.186557-1-justin.he@arm.com>
Sender: kvm-owner@vger.kernel.org
To: Jia He <justin.he@arm.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kaly Xin <Kaly.Xin@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 01, 2020 at 12:38:40PM +0800, Jia He wrote:
> Ning Bo reported an abnormal 2-second gap when booting Kata container [1].
> The unconditional timeout was caused by VSOCK_DEFAULT_CONNECT_TIMEOUT of
> connecting from the client side. The vhost vsock client tries to connect
> an initializing virtio vsock server.
> 
> The abnormal flow looks like:
> host-userspace           vhost vsock                       guest vsock
> ==============           ===========                       ============
> connect()     -------->  vhost_transport_send_pkt_work()   initializing
>    |                     vq->private_data==NULL
>    |                     will not be queued
>    V
> schedule_timeout(2s)
>                          vhost_vsock_start()  <---------   device ready
>                          set vq->private_data
> 
> wait for 2s and failed
> connect() again          vq->private_data!=NULL         recv connecting pkt
> 
> Details:
> 1. Host userspace sends a connect pkt, at that time, guest vsock is under
>    initializing, hence the vhost_vsock_start has not been called. So
>    vq->private_data==NULL, and the pkt is not been queued to send to guest
> 2. Then it sleeps for 2s
> 3. After guest vsock finishes initializing, vq->private_data is set
> 4. When host userspace wakes up after 2s, send connecting pkt again,
>    everything is fine.
> 
> As suggested by Stefano Garzarella, this fixes it by additional kicking the
> send_pkt worker in vhost_vsock_start once the virtio device is started. This
> makes the pending pkt sent again.
> 
> After this patch, kata-runtime (with vsock enabled) boot time is reduced
> from 3s to 1s on a ThunderX2 arm64 server.
> 
> [1] https://github.com/kata-containers/runtime/issues/1917
> 
> Reported-by: Ning Bo <n.b@live.com>
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
> v2: new solution suggested by Stefano Garzarella
> 
>  drivers/vhost/vsock.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index e36aaf9ba7bd..0716a9cdffee 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -543,6 +543,11 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
>  		mutex_unlock(&vq->mutex);
>  	}
>  
> +	/* Some packets may have been queued before the device was started,
> +	 * let's kick the send worker to send them.
> +	 */
> +	vhost_work_queue(&vsock->dev, &vsock->send_pkt_work);
> +
>  	mutex_unlock(&vsock->dev.mutex);
>  	return 0;
>  
> -- 
> 2.17.1
> 
