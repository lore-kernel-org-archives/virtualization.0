From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] kvm: add PV MMIO EVENTFD
Date: Thu, 4 Apr 2013 16:03:02 +0300
Message-ID: <20130404130302.GD6467@redhat.com>
References: <20130404104846.GA6227@redhat.com>
	<6D40C5F1-849E-4F32-B391-E1A1BFA8C59D@suse.de>
	<20130404120825.GD17919@redhat.com>
	<959E147D-EB7B-4F4B-9F84-4F1BBA98DEF8@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <959E147D-EB7B-4F4B-9F84-4F1BBA98DEF8@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Graf <agraf@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, kvm@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Sasha Levin <sasha.levin@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Christoffer Dall <c.dall@virtualopensystems.com>, virtualization@lists.linux-foundation.org, Takuya Yoshikawa <yoshikawa_takuya_b1@lab.ntt.co.jp>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 04, 2013 at 02:32:08PM +0200, Alexander Graf wrote:
> 
> On 04.04.2013, at 14:08, Gleb Natapov wrote:
> 
> > On Thu, Apr 04, 2013 at 01:57:34PM +0200, Alexander Graf wrote:
> >> 
> >> On 04.04.2013, at 12:50, Michael S. Tsirkin wrote:
> >> 
> >>> With KVM, MMIO is much slower than PIO, due to the need to
> >>> do page walk and emulation. But with EPT, it does not have to be: we
> >>> know the address from the VMCS so if the address is unique, we can look
> >>> up the eventfd directly, bypassing emulation.
> >>> 
> >>> Add an interface for userspace to specify this per-address, we can
> >>> use this e.g. for virtio.
> >>> 
> >>> The implementation adds a separate bus internally. This serves two
> >>> purposes:
> >>> - minimize overhead for old userspace that does not use PV MMIO
> >>> - minimize disruption in other code (since we don't know the length,
> >>> devices on the MMIO bus only get a valid address in write, this
> >>> way we don't need to touch all devices to teach them handle
> >>> an dinvalid length)
> >>> 
> >>> At the moment, this optimization is only supported for EPT on x86 and
> >>> silently ignored for NPT and MMU, so everything works correctly but
> >>> slowly.
> >>> 
> >>> TODO: NPT, MMU and non x86 architectures.
> >>> 
> >>> The idea was suggested by Peter Anvin.  Lots of thanks to Gleb for
> >>> pre-review and suggestions.
> >>> 
> >>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >> 
> >> This still uses page fault intercepts which are orders of magnitudes slower than hypercalls. Why don't you just create a PV MMIO hypercall that the guest can use to invoke MMIO accesses towards the host based on physical addresses with explicit length encodings?
> >> 
> > It is slower, but not an order of magnitude slower. It become faster
> > with newer HW.
> > 
> >> That way you simplify and speed up all code paths, exceeding the speed of PIO exits even. It should also be quite easily portable, as all other platforms have hypercalls available as well.
> >> 
> > We are trying to avoid PV as much as possible (well this is also PV,
> > but not guest visible
> 
> Also, how is this not guest visible?

It's visible but it does not require special code in the guest.
Only on qemu. Guest can use standard iowritel/w/b.

> Who sets
> KVM_IOEVENTFD_FLAG_PV_MMIO?

It's an ioctl so qemu does this.

> The comment above its definition indicates
> that the guest does so, so it is guest visible.
> 
> +/*
> + * PV_MMIO - Guest can promise us that all accesses touching this address
> + * are writes of specified length, starting at the specified address.
> + * If not - it's a Guest bug.
> + * Can not be used together with either PIO or DATAMATCH.
> + */
> 
> 
> Alex

The requirement is to only access a specific address by a single aligned
instruction.  For example, only aligned signle-word accesses are
allowed.

This is a standard practice with many devices, in fact,
virtio spec already requires this for notifications.


-- 
MST
