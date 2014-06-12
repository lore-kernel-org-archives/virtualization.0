From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: Using virtio for inter-VM communication
Date: Thu, 12 Jun 2014 07:32:43 +0200
Message-ID: <53993B7B.7010404__46239.1691784889$1402551896$gmane$org@siemens.com>
References: <20140610184818.2e490419@nbschild1>
	<87r42uq2v8.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87r42uq2v8.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, Henning Schild <henning.schild@siemens.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 2014-06-12 04:27, Rusty Russell wrote:
> Henning Schild <henning.schild@siemens.com> writes:
>> Hi,
>>
>> i am working on the jailhouse[1] project and am currently looking at
>> inter-VM communication. We want to connect guests directly with virtual
>> consoles based on shared memory. The code complexity in the hypervisor
>> should be minimal, it should just make the shared memory discoverable
>> and provide a signaling mechanism.
> 
> Hi Henning,
> 
>         The virtio assumption was that the host can see all of guest
> memory.  This simplifies things significantly, and makes it efficient.
> 
> If you don't have this, *someone* needs to do a copy.  Usually the guest
> OS does a bounce buffer into your shared region.  Goodbye performance.
> Or you can play remapping tricks.  Goodbye performance again.
> 
> My preferred model is to have a trusted helper (ie. host) which
> understands how to copy between virtio rings.  The backend guest (to
> steal Xen vocab) R/O maps the descriptor, avail ring and used rings in
> the guest.  It then asks the trusted helper to do various operation
> (copy into writable descriptor, copy out of readable descriptor, mark
> used).  The virtio ring itself acts as a grant table.
> 
> Note: that helper mechanism is completely protocol agnostic.  It was
> also explicitly designed into the virtio mechanism (with its 4k
> boundaries for data structures and its 'len' field to indicate how much
> was written into the descriptor). 
> 
> It was also never implemented, and remains a thought experiment.
> However, implementing it in lguest should be fairly easy.

The reason why a trusted helper, i.e. additional logic in the
hypervisor, is not our favorite solution is that we'd like to keep the
hypervisor as small as possible. I wouldn't exclude such an approach
categorically, but we have to weigh the costs (lines of code, additional
hypervisor interface) carefully against the gain (existing
specifications and guest driver infrastructure).

Back to VIRTIO_F_RING_SHMEM_ADDR (which you once brought up in an MCA
working group discussion): What speaks against introducing an
alternative encoding of addresses inside virtio data structures? The
idea of this flag was to replace guest-physical addresses with offsets
into a shared memory region associated with or part of a virtio device.
That would preserve zero-copy capabilities (as long as you can work
against the shared mem directly, e.g. doing DMA from a physical NIC or
storage device into it) and keep the hypervisor out of the loop. Is it
too invasive to existing infrastructure or does it have some other pitfalls?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux
