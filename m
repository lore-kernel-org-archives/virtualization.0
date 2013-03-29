From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH v2 2/2] virtio: console: add locking around c_ovq
	operations
Date: Fri, 29 Mar 2013 19:05:09 +0800
Message-ID: <51557565.2050009@cn.fujitsu.com>
References: <cover.1364554596.git.amit.shah@redhat.com>
	<06f1e0e5f31d65735dedef2377435259971b4fc9.1364554596.git.amit.shah@redhat.com>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <06f1e0e5f31d65735dedef2377435259971b4fc9.1364554596.git.amit.shah@redhat.com>
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

On 03/29/2013 07:00 PM, Amit Shah wrote:
> When multiple ovq operations are being performed (lots of open/close
> operations on virtio_console fds), the __send_control_msg() function can
> get confused without locking.
> 
> A simple recipe to cause badness is:
> * create a QEMU VM with two virtio-serial ports
> * in the guest, do
>   while true;do echo abc >/dev/vport0p1;done
>   while true;do echo edf >/dev/vport0p2;done
> 
> In one run, this caused a panic in __send_control_msg().  In another, I
> got
> 
>    virtio_console virtio0: control-o:id 0 is not a head!
> 
> This also results repeated messages similar to these on the host:
> 
>   qemu-kvm: virtio-serial-bus: Unexpected port id 478762112 for device virtio-serial-bus.0
>   qemu-kvm: virtio-serial-bus: Unexpected port id 478762368 for device virtio-serial-bus.0
> 
> Reported-by: FuXiangChun <xfu@redhat.com>
> Signed-off-by: Amit Shah <amit.shah@redhat.com>

Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> ---
>  drivers/char/virtio_console.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 7e9bc1d..a91488c 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -150,6 +150,7 @@ struct ports_device {
>  
>  	/* To protect the vq operations for the control channel */
>  	spinlock_t c_ivq_lock;
> +	spinlock_t c_ovq_lock;
>  
>  	/* The current config space is stored here */
>  	struct virtio_console_config config;
> @@ -569,11 +570,14 @@ static ssize_t __send_control_msg(struct ports_device *portdev, u32 port_id,
>  	vq = portdev->c_ovq;
>  
>  	sg_init_one(sg, &cpkt, sizeof(cpkt));
> +
> +	spin_lock(&portdev->c_ovq_lock);
>  	if (virtqueue_add_buf(vq, sg, 1, 0, &cpkt, GFP_ATOMIC) == 0) {
>  		virtqueue_kick(vq);
>  		while (!virtqueue_get_buf(vq, &len))
>  			cpu_relax();
>  	}
> +	spin_unlock(&portdev->c_ovq_lock);
>  	return 0;
>  }
>  
> @@ -1987,6 +1991,7 @@ static int virtcons_probe(struct virtio_device *vdev)
>  		unsigned int nr_added_bufs;
>  
>  		spin_lock_init(&portdev->c_ivq_lock);
> +		spin_lock_init(&portdev->c_ovq_lock);
>  		INIT_WORK(&portdev->control_work, &control_work_handler);
>  
>  		nr_added_bufs = fill_queue(portdev->c_ivq,
> 
