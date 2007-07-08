From: Avi Kivity <avi@qumranet.com>
Subject: Re: [RFC 1/4] New virtio bus driver
Date: Sun, 08 Jul 2007 12:59:56 +0300
Message-ID: <4690B59C.10201@qumranet.com>
References: <20070706124200.988637662@arndb.de>
	<20070706125717.576683142@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070706125717.576683142@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: arnd@arndb.de
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

arnd@arndb.de wrote:

> This adds a new bus_type for virtio that is intended to
> be completely agnostic of the underlying host transport
> and the upper-level protocol.
>
> Device drivers and host drivers register here, and operations
> are provided that let a device driver talk to the device
> emulation in the hypervisor without knowing the kind of hypervisor.
> Module autoloading through udev should also work.
>
> Loosely based on Rusty's Virtio draft III.
> +
> +/**
> + * virtio_device_id - match a virtio device to a driver
> + * @device_type: string identifying the virtio interface.
> + * @driver_data: used internally by the driver.
> + */
> +struct virtio_device_id {
> +	const char *device_type;
> +	unsigned long driver_data;
> +};
>   

Carrying a string through a hypervisor interface can be unpleasant.  How 
about a constant instead?

> +
> +/**
> + * virtio_config - virtual device configuration.
> + * @host: structured data interpreted by the host driver.
> + * @driver: structured data interpreted by the device driver.
> + *
> + * The configuration space is what gets used to tell a driver
> + * about the device, e.g. MAC address or block device size.
> + * All fields in here are read-only in the virtual machine,
> + * they are set up by the host.
> + *
> + * The host part remains opaque to the device driver, it can
> + * contain e.g. lguest device index numbers or part of a PCI
> + * configuration space.
> + *
> + * The 256 bytes total intentionally match the size of the
> + * legacy PCI config registers, but the driver should not
> + * expect the layout to be derived from PCI.
> + *
> + * Every virtio_driver should define a data structure for the
> + * virtio_config->driver data, which becomes part of its ABI.
> + */
> +struct virtio_config {
> +	const char host[128];
> +	const char driver[128];
> +};
>   

There needs to be a way for the driver to tell the device that 
configuration has changed (promiscuous mode, MAC address) and vice versa 
(media detect).

Maybe have a configuration virtqueue for that.


What I'm missing here is the lego approach, where you can mix and match:

  virtnet.ko: basic net driver atop virtio, not linked to any implementation
  virtio-lguest.ko, virtio-kvm.ko, virtio-xen.ko:  virtio transports
  virtbus-pci.ko, virtbus-vio.ko, virtbus-xen.ko: virtual configuration 
space handlers; responsible for creating queues

  vnet-kvm-pci.ko, vnet-kvm-virtbus.ko: stub drivers that glue the 
components together

So we'd have one 10-line driver for every combination.

-- 
error compiling committee.c: too many arguments to function
