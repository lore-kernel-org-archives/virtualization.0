From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/11] RFC: PCI using capabilitities
Date: Sun, 11 Dec 2011 14:47:04 +0200
Message-ID: <20111211124703.GE11504@redhat.com>
References: <87pqfzgy6p.fsf@rustcorp.com.au> <1323358657.32487.9.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1323358657.32487.9.camel@lappy>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: Avi Kivity <avi@redhat.com>, kvm@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 08, 2011 at 05:37:37PM +0200, Sasha Levin wrote:
> On Thu, 2011-12-08 at 20:52 +1030, Rusty Russell wrote:
> > Here's the patch series I ended up with.  I haven't coded up the QEMU
> > side yet, so no idea if the new driver works.
> > 
> > Questions:
> > (1) Do we win from separating ISR, NOTIFY and COMMON?
> > (2) I used a "u8 bar"; should I use a bir and pack it instead?  BIR
> >     seems a little obscure (noone else in the kernel source seems to
> >     refer to it).
> 
> I started implementing it for KVM tools, when I noticed a strange thing:
> my vq creating was failing because the driver was reading a value other
> than 0 from the address field of a new vq, and failing.
> 
> I've added simple prints in the usermode code, and saw the following
> ordering:
> 
> 1. queue select vq 0
> 2. queue read address (returns 0 - new vq)
> 3. queue write address (good address of vq)
> 4. queue read address (returns !=0, fails)
> 4. queue select vq 1
> 
> >From that I understood that the ordering is wrong, the driver was trying
> to read address before selecting the correct vq.
> 
> At that point, I've added simple prints to the driver. Initially it
> looked as follows:
> 
> 	iowrite16(index, &vp_dev->common->queue_select);
> 
> 	switch (ioread64(&vp_dev->common->queue_address)) {
> 		[...]
> 	};
> 
> So I added prints before the iowrite16() and after the ioread64(), and
> saw that while the driver prints were ordered, the device ones weren't:
> 
> 	[    1.264052] before iowrite index=1
> 	kvmtool: net returning pfn (vq=0): 310706176
> 	kvmtool: queue selected: 1
> 	[    1.264890] after ioread index=1
> 
> Suspecting that something was wrong with ordering, I've added a print
> between the iowrite and the ioread, and it finally started working well.
> 
> Which leads me to the question: Are MMIO vs MMIO reads/writes not
> ordered?

First, I'd like to answer your questions from the PCI side.
Look for PCI rules in the PCI spec.
You will notices that a write is required to be able to
pass a read request. It might also pass read completion.
A read request will not pass a write request.
There's more or less no ordering between different types of transactions
(memory versus io/configuration).

That's wrt to the question you asked.

But this is not your setup: you have a single vcpu so
you will not initiate a write (select vq) until you get
a read completion.

So what you are really describing is this setup: guest reads a value,
gets the response, then writes out another one, and kvm tool reports the
write before the read.


> -- 
> 
> Sasha.
