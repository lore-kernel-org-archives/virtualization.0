From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 16/22] virtio_pci: use separate notification offsets for
	each vq.
Date: Tue, 26 Mar 2013 21:39:11 +0200
Message-ID: <20130326193911.GA19251@redhat.com>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-17-git-send-email-rusty@rustcorp.com.au>
	<20130321101300.GA30493@redhat.com>
	<87wqt0du2e.fsf@rustcorp.com.au>
	<20130324201910.GA31631@redhat.com>
	<8738vjer43.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <8738vjer43.fsf@rustcorp.com.au>
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

On Mon, Mar 25, 2013 at 08:30:28PM +1030, Rusty Russell wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> > On Fri, Mar 22, 2013 at 01:22:57PM +1030, Rusty Russell wrote:
> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >> > I would like an option for hypervisor to simply say "Do IO
> >> > to this fixed address for this VQ". Then virtio can avoid using IO BARs
> >> > completely.
> >> 
> >> It could be done.  AFAICT, this would be an x86-ism, though, which is a
> >> little nasty.
> >
> > Okay, talked to HPA and he suggests a useful extension of my
> > or rather Gleb's earlier idea
> > (which was accessing mmio from special asm code which puts the value in
> > a known predefined register):
> > if we make each queue use a different address, then we avoid
> > the need to emulate the instruction (because we get GPA in the VMCS),
> > and the value can just be ignored.
> 
> I had the same thought, but obviously lost it when I re-parsed your
> message.

I will try to implement this in KVM, and benchmark. Then we'll see.

> > There's still some overhead (CPU simply seems to take a bit more
> > time to handle an EPT violation than an IO access)
> > and we need to actually add such code in kvm in host kernel,
> > but it sure looks nice since unlike my idea it does not
> > need anything special in the guest, and it will just work
> > for a physical virtio device if such ever surfaces.
> 
> I think a physical virtio device would be a bit weird, but it's a nice
> sanity check.
> 
> But if we do this, let's drop back to the simpler layout suggested in
> the original patch (a u16 offset, and you write the vq index there).
> >> @@ -150,7 +153,9 @@ struct virtio_pci_common_cfg {
> >>  	__le16 queue_size;	/* read-write, power of 2. */
> >>  	__le16 queue_msix_vector;/* read-write */
> >>  	__le16 queue_enable;	/* read-write */
> >> -	__le16 queue_notify;	/* read-only */
> >> +	__le16 unused2;
> >> +	__le32 queue_notify_val;/* read-only */
> >> +	__le32 queue_notify_off;/* read-only */
> >>  	__le64 queue_desc;	/* read-write */
> >>  	__le64 queue_avail;	/* read-write */
> >>  	__le64 queue_used;	/* read-write */
> >
> > So how exactly do the offsets mesh with the dual capability?  For IO we
> > want to use the same address and get queue from the data, for memory we
> > want a per queue address ...
> 
> Let's go back a level.  Do we still need I/O bars at all now?  Or can we
> say "if you want hundreds of vqs, use mem bars"?
> 
> hpa wanted the option to have either, but do we still want that?
> 
> Cheers,
> Rusty.

hpa says having both is required for BIOS, not just for speed with KVM.

-- 
MST
