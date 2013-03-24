From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 16/22] virtio_pci: use separate notification offsets for
	each vq.
Date: Sun, 24 Mar 2013 22:19:10 +0200
Message-ID: <20130324201910.GA31631@redhat.com>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-17-git-send-email-rusty@rustcorp.com.au>
	<20130321101300.GA30493@redhat.com>
	<87wqt0du2e.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87wqt0du2e.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: hpa@zytor.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 22, 2013 at 01:22:57PM +1030, Rusty Russell wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> > On Thu, Mar 21, 2013 at 06:59:37PM +1030, Rusty Russell wrote:
> >> (MST, is this what you were thinking?)
> >
> > Almost.
> >
> > Three points:
> >
> > 1. this is still an offset in BAR so for KVM we are still forced to use
> > an IO BAR. 
> 
> Right, because memory bar accesses are slow as per your 'Subject: virtio
> PCI on KVM without IO BARs' post.
> 
> > I would like an option for hypervisor to simply say "Do IO
> > to this fixed address for this VQ". Then virtio can avoid using IO BARs
> > completely.
> 
> It could be done.  AFAICT, this would be an x86-ism, though, which is a
> little nasty.

Okay, talked to HPA and he suggests a useful extension of my
or rather Gleb's earlier idea
(which was accessing mmio from special asm code which puts the value in
a known predefined register):
if we make each queue use a different address, then we avoid
the need to emulate the instruction (because we get GPA in the VMCS),
and the value can just be ignored.

There's still some overhead (CPU simply seems to take a bit more
time to handle an EPT violation than an IO access)
and we need to actually add such code in kvm in host kernel,
but it sure looks nice since unlike my idea it does not
need anything special in the guest, and it will just work
for a physical virtio device if such ever surfaces.

> 
> > 2.  for a real virtio device, offset is only 16 bit, using a 32 bit
> > offset in a memory BAR giving each VQ a separate 4K page would allow
> > priveledge separation where e.g. RXVQ/TXVQ are passed through to
> > hardware but CVQ is handled by the hypervisor.
> 
> Hmm, u16 fits nicely :)  Unless you need priv separation between different
> vqs, you could have control vq at 0, and start rx/tx from 4096.
> 
> (Actually, since the notification base is already an offset into a bar,
> you could arrange that at 4094, so control is at 0, vqs start at 1).
> 
> > 3. last thing - (1) applies to ISR reads as well.
> 
> I've been assuming that optimizing ISR access was pointless with MSI-X,
> so keeping that simple.
> 
> > So the minimal change on top of this patch, would be adding a FIXED
> > option to BIR and reporting data and not just offset for queue_notify
> > (so it can include device info if we share same address between
> > devices).
> 
> The first is easy, since we have a 'u8 bar': 255 could mean FIXED.
> 
> I wonder why you only want a u16 for data, when a u32 would be more
> flexible?  If we have to enlarge things anyway...
> 
> How's this?
> 
> Cheers,
> Rusty.
> 
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> index 23b90cb..9a59138 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -123,6 +123,9 @@
>  /* Device specific confiuration */
>  #define VIRTIO_PCI_CAP_DEVICE_CFG	4
>  
> +/* Not really a bar: this means notification via outl */
> +#define VIRTIO_PCI_BAR_FIXED_IO		255
> +
>  /* This is the PCI capability header: */
>  struct virtio_pci_cap {
>  	u8 cap_vndr;	/* Generic PCI field: PCI_CAP_ID_VNDR */
> @@ -150,7 +153,9 @@ struct virtio_pci_common_cfg {
>  	__le16 queue_size;	/* read-write, power of 2. */
>  	__le16 queue_msix_vector;/* read-write */
>  	__le16 queue_enable;	/* read-write */
> -	__le16 queue_notify;	/* read-only */
> +	__le16 unused2;
> +	__le32 queue_notify_val;/* read-only */
> +	__le32 queue_notify_off;/* read-only */
>  	__le64 queue_desc;	/* read-write */
>  	__le64 queue_avail;	/* read-write */
>  	__le64 queue_used;	/* read-write */

So how exactly do the offsets mesh with the dual capability?  For IO we
want to use the same address and get queue from the data, for memory we
want a per queue address ...

-- 
MST
