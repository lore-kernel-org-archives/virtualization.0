From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 3/3] powerpc-virtio: virtio support introduced (block,
	network, serial, balloon, 9p-fs), both fullemu and power-kvm
Date: Tue, 17 May 2011 09:06:41 +0200
Message-ID: <CC7C7633-F1F6-4CCC-BC48-F7DC057CB63E__42026.3779735707$1305616060$gmane$org@suse.de>
References: <1305614826-1815-1-git-send-email-david@gibson.dropbear.id.au>
	<1305614826-1815-4-git-send-email-david@gibson.dropbear.id.au>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1305614826-1815-4-git-send-email-david@gibson.dropbear.id.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>
List-Id: virtualization@lists.linuxfoundation.org


On 17.05.2011, at 08:47, David Gibson wrote:

> From: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> The recently added pseries machine does not currently support PCI
> emulation.  For the (upcoming) kvm case, this is quite difficult to do
> because the preferred HV mode for the host kernel does not allow MMIO
> emulation (a hardware limitation).
> 
> Therefore, to support virtio devices, we implement a new virtio setup
> protocol for PAPR guests.  This is based loosely on the s390 and lguest
> methods, using the PAPR hcalls for the virtio primitive operations,
> and the PAPR device tree to advertise the virtio device resources to the
> guest.
> 
> This patch includes support for the virtio block, network, serial, and
> balloon devices, and the 9p filesystem.
> 
> The guest linux kernel should be updated as well in order to
> support a new virtio setup.
> 
> Supported devices are (below are QEMU command line switches):
> 
> - virtio-blk - block device, at the moment works as "IDE":
>    usage: -drive file=test-virtio-blk.img,if=ide
> 
> - virtio-net - network device
>    usage: -net nic,model=virtio-net
> 
> - virtio-balloon - memory hot-swap device (at the moment of commit, power-kvm
> did not support balloon)
>    usage: -device virtio-balloon-spapr
> 
> - virtio-serial - serial bus controller
>    usage: -device virtio-serial-spapr \
>           -chardev socket,id=CONSOLE,host=localhost,port=4444,server,telnet \
>           -device virtconsole,chardev=CONSOLE
>    The first switch tells QEMU to create a serial bus device and next
>    2 switches create "chardev" and virtual console device connected to
>    that "chardev".
> 
> - virtio-9p - plan9 filesystem with ability to work over virtio transport
>    usage: -fsdev fstype=local,id=TAG,path=/home/aik/,security_model=none \
>           -device virtio-9p-spapr,fsdev=TAG,mount_tag=TAG
>    where TAG is a tag which should be used later when mounting is linux as:
>           mount -t 9p -o trans=virtio TAG /mnt
> 
>    Configure for full emulation as:
>       ./configure --target-list=ppc64-softmmu --enable-attr
> 
>    Configure for power-kvm as:
>       ./configure --enable-kvm  --target-list=ppc64-softmmu --enable-fdt \
>                    --cc="gcc -m64" \
>                    --kerneldir=/root/kheaders --enable-io-thread --enable-attr
> 
> Note: --enable-attr is required for 9p support. On ppc64 systems, libattr
> should be compiled and installed manually as it is not distributes in
> 64bit packages.

Before including such a patch, we should really discuss the desired interface for virtio on sPAPR. I personally would prefer if we could have a generic MMIO hypercall that the guest issues, so that we can simply use virtio-pci on sPAPR (and all the other PCI hardware).

But at the end of the day, the steps should be as follows:

  1) Discuss this on the virtualization ML
  2) Send patches for the virtio documentation so the protocol has a spec (which we're lacking for s390 still)
  3) Implement Linux side, upstream it
  4) Upstream Qemu side

Since I haven't seen 1-3, I'd like to defer this patch until the other points are good :)


Alex
