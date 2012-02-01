From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 2/2] virtio-serial: setup_port_vq when adding port
Date: Wed, 1 Feb 2012 13:42:57 +0530
Message-ID: <20120201081257.GD24943@amit.redhat.com>
References: <1326331207-10339-1-git-send-email-zanghongyong@huawei.com>
	<1326331207-10339-3-git-send-email-zanghongyong@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1326331207-10339-3-git-send-email-zanghongyong@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: zanghongyong@huawei.com
Cc: aliguori@us.ibm.com, kvm@vger.kernel.org, wusongwei@huawei.com, hanweidong@huawei.com, Virtualization List <virtualization@lists.linux-foundation.org>, xiaowei.yang@huawei.com, jiangningyu@huawei.com
List-Id: virtualization@lists.linuxfoundation.org

Hi,

Sorry for the late reply.

On (Thu) 12 Jan 2012 [09:20:07], zanghongyong@huawei.com wrote:
> From: Hongyong Zang <zanghongyong@huawei.com>
> 
> Add setup_port_vq(). Create the io ports' vqs when add_port.

Can you describe the changes in more detail, please?

> Signed-off-by: Hongyong Zang <zanghongyong@huawei.com>
> ---
>  drivers/char/virtio_console.c |   65 ++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 61 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 8e3c46d..2e5187e 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1132,6 +1132,55 @@ static void send_sigio_to_port(struct port *port)
>  		kill_fasync(&port->async_queue, SIGIO, POLL_OUT);
>  }
>  
> +static void in_intr(struct virtqueue *vq);
> +static void out_intr(struct virtqueue *vq);
> +
> +static int setup_port_vq(struct ports_device *portdev,  u32 id)
> +{
> +	int err, vq_num;
> +	vq_callback_t **io_callbacks;
> +	char **io_names;
> +	struct virtqueue **vqs;
> +	u32 i,j,nr_ports,nr_queues;
> +
> +	err = 0;
> +	vq_num = (id + 1) * 2;
> +	nr_ports = portdev->config.max_nr_ports;
> +	nr_queues = use_multiport(portdev) ? (nr_ports + 1) * 2 : 2;
> +
> +	vqs = kmalloc(nr_queues * sizeof(struct virtqueue *), GFP_KERNEL);
> +	io_callbacks = kmalloc(nr_queues * sizeof(vq_callback_t *), GFP_KERNEL);
> +	io_names = kmalloc(nr_queues * sizeof(char *), GFP_KERNEL);
> +	if (!vqs || !io_callbacks || !io_names) {
> +		err = -ENOMEM;
> +		goto free;
> +	}
> +
> +	for (i = 0, j = 0; i <= nr_ports; i++) {
> +		io_callbacks[j] = in_intr;
> +		io_callbacks[j + 1] = out_intr;
> +		io_names[j] = NULL;
> +		io_names[j + 1] = NULL;
> +		j += 2;
> +	}
> +	io_names[vq_num] = "serial-input";
> +	io_names[vq_num + 1] = "serial-output";
> +	err = portdev->vdev->config->find_vqs(portdev->vdev, nr_queues, vqs,
> +				io_callbacks,
> +				(const char **)io_names);
> +	if (err)
> +		goto free;
> +	portdev->in_vqs[id] = vqs[vq_num];
> +	portdev->out_vqs[id] = vqs[vq_num + 1];

I don't think this approach will work fine for port hot-plug /
hot-unplug cases at all.  For example, I first start qemu with one
port, at id 1.  Then I add a port at id 5, then at 2, then at 10.
Will that be fine?

> +
> +free:
> +	kfree(io_names);
> +	kfree(io_callbacks);
> +	kfree(vqs);
> +
> +	return err;
> +}
> +
>  static int add_port(struct ports_device *portdev, u32 id)
>  {
>  	char debugfs_name[16];
> @@ -1163,6 +1212,14 @@ static int add_port(struct ports_device *portdev, u32 id)
>  
>  	port->outvq_full = false;
>  
> +	if (!portdev->in_vqs[port->id] && !portdev->out_vqs[port->id]) {
> +		spin_lock(&portdev->ports_lock);
> +		err = setup_port_vq(portdev, port->id);
> +		spin_unlock(&portdev->ports_lock);
> +		if (err)
> +			goto free_port;
> +	}
> +
>  	port->in_vq = portdev->in_vqs[port->id];
>  	port->out_vq = portdev->out_vqs[port->id];
>  
> @@ -1614,8 +1671,8 @@ static int init_vqs(struct ports_device *portdev)
>  			j += 2;
>  			io_callbacks[j] = in_intr;
>  			io_callbacks[j + 1] = out_intr;
> -			io_names[j] = "input";
> -			io_names[j + 1] = "output";
> +			io_names[j] = NULL;
> +			io_names[j + 1] = NULL;
>  		}
>  	}
>  	/* Find the queues. */
> @@ -1635,8 +1692,8 @@ static int init_vqs(struct ports_device *portdev)
>  
>  		for (i = 1; i < nr_ports; i++) {
>  			j += 2;
> -			portdev->in_vqs[i] = vqs[j];
> -			portdev->out_vqs[i] = vqs[j + 1];
> +			portdev->in_vqs[i] = NULL;
> +			portdev->out_vqs[i] = NULL;
>  		}
>  	}
>  	kfree(io_names);

So a queue once created will not be removed unless the module is
removed or the device is removed.  That seems reasonable, port
hot-unplug will keep queues around, as is the case now.

		Amit
