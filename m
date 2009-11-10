From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 8/8] virtio: console: struct ports for multiple ports
	per device.
Date: Tue, 10 Nov 2009 15:03:28 +0530
Message-ID: <20091110093328.GA22563@amit-x200.redhat.com>
References: <1257834450..rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1257834450..rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) Nov 10 2009 [16:57:30], Rusty Russell wrote:
> 
> Rather than assume a single port, add a 'struct ports' with an array
> of ports.  Currently, there's always only one, but that will change.

Hey Rusty,

>  static void virtcons_apply_config(struct virtio_device *dev)
>  {
> -	struct port *port = dev->priv;
> +	struct ports *ports = dev->priv;
>  	struct winsize ws;
>  
>  	if (virtio_has_feature(dev, VIRTIO_CONSOLE_F_SIZE)) {
> @@ -158,7 +168,9 @@ static void virtcons_apply_config(struct
>  		dev->config->get(dev,
>  				 offsetof(struct virtio_console_config, rows),
>  				 &ws.ws_row, sizeof(u16));
> -		hvc_resize(port->hvc, ws);
> +		/* This is the pre-multiport style: we use control messages
> +		 * these days which specify the port.  So this means port 0. */
> +		hvc_resize(ports->port[0].hvc, ws);

I've fixed a bug in the latest patches that I have (just on git so far;
not sent to lists) -- this function is also called from hvc's
notifier_add, so instead of passing vdev here, we can just pass the port
and look up the port in the notifier_add_vio() function via
get_port_from_vtermno().

> -static struct port *__devinit alloc_port(u32 vtermno)
> +static struct ports *__devinit alloc_ports(unsigned int num)

This will have to be changed when we add support for hotplug. So instead
of doing this, just have a linked list from the start?

>  {
> -	struct port *port = kmalloc(sizeof *port, GFP_KERNEL);
> +	struct ports *ports;
> +	int i;
>  
> -	if (!port)
> +	ports = kmalloc(sizeof *ports + sizeof(ports->port[0]) * num,
> +			GFP_KERNEL);
> +	if (!ports)
>  		return NULL;


Other than this, the series is good; I can base my patches on top of
these.

I guess we can also assign a number to each vdev that gets probed so
that sysfs and debugfs entries for ports can be put in their
vdev-specific directories, like

/sys/class/virtio-console0/vcon0/name

etc.

Also, if you think the send/receive workqueues are fine and we move to
those, they will have to be introduced slightly earlier in this patch
series.

(I'll send out my patches to the list in a while; some polishing is
required still but they're all style issues rather than functionality
ones.)

		Amit
