From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Using virtio for inter-VM communication
Date: Fri, 13 Jun 2014 10:45:53 +0200
Message-ID: <539ABA41.3070701@redhat.com>
References: <20140610184818.2e490419@nbschild1>	<87r42uq2v8.fsf@rustcorp.com.au>
	<53993B7B.7010404@siemens.com>	<87fvj9prdi.fsf@rustcorp.com.au>
	<539A98D3.3070601@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <539A98D3.3070601@siemens.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Kiszka <jan.kiszka@siemens.com>, Rusty Russell <rusty@rustcorp.com.au>, Henning Schild <henning.schild@siemens.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Il 13/06/2014 08:23, Jan Kiszka ha scritto:
>>> That would preserve zero-copy capabilities (as long as you can work
>>> against the shared mem directly, e.g. doing DMA from a physical NIC or
>>> storage device into it) and keep the hypervisor out of the loop.
> >
> > This seems ill thought out.  How will you program a NIC via the virtio
> > protocol without a hypervisor?  And how will you make it safe?  You'll
> > need an IOMMU.  But if you have an IOMMU you don't need shared memory.
>
> Scenarios behind this are things like driver VMs: You pass through the
> physical hardware to a driver guest that talks to the hardware and
> relays data via one or more virtual channels to other VMs. This confines
> a certain set of security and stability risks to the driver VM.

I think implementing Xen hypercalls in jailhouse for grant table and 
event channels would actually make a lot of sense.  The Xen 
implementation is 2.5kLOC and I think it should be possible to compact 
it noticeably, especially if you limit yourself to 64-bit guests.

It should also be almost enough to run Xen PVH guests as jailhouse 
partitions.

If later Xen starts to support virtio, you will get that for free.

Paolo
