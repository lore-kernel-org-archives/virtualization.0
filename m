From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC/PATCH 15/15] guest: virtio device support, and kvm hypercalls
Date: Fri, 21 Mar 2008 11:24:49 +1100
Message-ID: <200803211124.49829.rusty__7132.07463636554$1206059394$gmane$org@rustcorp.com.au>
References: <1206028710.6690.21.camel@cotte.boeblingen.de.ibm.com>
	<1206030328.6690.66.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1206030328.6690.66.camel@cotte.boeblingen.de.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Carsten Otte <cotte@de.ibm.com>
Cc: aliguori@us.ibm.com, EHRHARDT@de.ibm.com, arnd@arndb.de, hollisb@us.ibm.com, kvm-devel@lists.sourceforge.net, heiko.carstens@de.ibm.com, jeroney@us.ibm.com, virtualization@lists.linux-foundation.org, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, rvdheij@gmail.com, os@de.ibm.com, jblunck@suse.de, "Zhang,
	Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Friday 21 March 2008 03:25:28 Carsten Otte wrote:
> +static void kvm_set_status(struct virtio_device *vdev, u8 status)
> +{
> +	BUG_ON(!status);
> +	to_kvmdev(vdev)->desc->status = status;
> +}
> +
> +/*
> + * To reset the device, we (ab)use the NOTIFY hypercall, with the descriptor
> + * address of the device.  The Host will zero the status and all the 
> + * features. 
> + */
> +static void kvm_reset(struct virtio_device *vdev)
> +{
> +	unsigned long offset = (void *)to_kvmdev(vdev)->desc - kvm_devices;
> +
> +	kvm_hypercall1(1237, (max_pfn<<PAGE_SHIFT) + offset);
> +}

I'd recommend a hypercall after set_status, as well as reset.  The
reason lguest doesn't do this is that we don't do feature negotiation
(assuming guest kernel matches host kernel).  In general, the host
needs to know when the VIRTIO_CONFIG_S_DRIVER_OK is set so it can see
what features the guest driver accepted.

Overloading the notify hypercall is kind of a hack too, but it works so
no real need to change that.

> + * The root device for the kvm virtio devices.
> + * This makes them appear as /sys/devices/kvm/0,1,2 not /sys/devices/0,1,2.
> + */ 
> +static struct device kvm_root = {
> +	.parent = NULL,
> +	.bus_id = "kvm_s390",
> +};

You mean /sys/devices/kvm_s390/0,1,2?

> +static int __init kvm_devices_init(void)
> +{
> +	if (!MACHINE_IS_KVM)
> +		return -ENODEV;
> +
> +	if (device_register(&kvm_root) != 0)
> +		panic("Could not register kvm root");
> +
> +	if (add_shared_memory((max_pfn) << PAGE_SHIFT, PAGE_SIZE)) {
> +		device_unregister(&kvm_root);
> +		return -ENOMEM;
> +	}

Hmm, panic on device_register fail, but -ENOMEM on add_shared_memory fail?
My theory was that since this is boot time, panic() is the right thing.

Cheers,
Rusty.
