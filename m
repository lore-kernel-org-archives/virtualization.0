From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 0/11] RFC: PCI using capabilitities
Date: Sun, 11 Dec 2011 11:05:51 +0200
Message-ID: <4EE4726F.3010503@redhat.com>
References: <87pqfzgy6p.fsf@rustcorp.com.au> <1323358657.32487.9.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 12/08/2011 05:37 PM, Sasha Levin wrote:
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
> From that I understood that the ordering is wrong, the driver was trying
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

mmios are strictly ordered.

Perhaps your printfs are reordered by buffering?  Are they from
different threads?  Are you using coalesced mmio (which is still
strictly ordered, if used correctly)?

-- 
error compiling committee.c: too many arguments to function
