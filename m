From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: Using virtio for inter-VM communication
Date: Fri, 13 Jun 2014 08:23:15 +0200
Message-ID: <539A98D3.3070601@siemens.com>
References: <20140610184818.2e490419@nbschild1>
	<87r42uq2v8.fsf@rustcorp.com.au> <53993B7B.7010404@siemens.com>
	<87fvj9prdi.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87fvj9prdi.fsf@rustcorp.com.au>
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

On 2014-06-13 02:47, Rusty Russell wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> On 2014-06-12 04:27, Rusty Russell wrote:
>>> Henning Schild <henning.schild@siemens.com> writes:
>>> It was also never implemented, and remains a thought experiment.
>>> However, implementing it in lguest should be fairly easy.
>>
>> The reason why a trusted helper, i.e. additional logic in the
>> hypervisor, is not our favorite solution is that we'd like to keep the
>> hypervisor as small as possible. I wouldn't exclude such an approach
>> categorically, but we have to weigh the costs (lines of code, additional
>> hypervisor interface) carefully against the gain (existing
>> specifications and guest driver infrastructure).
> 
> Reasonable, but I think you'll find it is about the minimal
> implementation in practice.  Unfortunately, I don't have time during the
> next 6 months to implement it myself :(
> 
>> Back to VIRTIO_F_RING_SHMEM_ADDR (which you once brought up in an MCA
>> working group discussion): What speaks against introducing an
>> alternative encoding of addresses inside virtio data structures? The
>> idea of this flag was to replace guest-physical addresses with offsets
>> into a shared memory region associated with or part of a virtio
>> device.
> 
> We would also need a way of defining the shared memory region.  But
> that's not the problem.  If such a feature is not accepted by the guest?
> How to you fall back?

Depends on the hypervisor and its scope, but it should be quite
straightforward: full-featured ones like KVM could fall back to slow
copying, specialized ones like Jailhouse would clear FEATURES_OK if the
guest driver does not accept it (because there would be no ring walking
or copying code in Jailhouse), thus refuse the activate the device. That
would be absolutely fine for application domains of specialized
hypervisors (often embedded, customized guests etc.).

The shared memory regions could be exposed as a BARs (PCI) or additional
address ranges (device tree) and addressed in the redefined guest
address fields via some region index and offset.

> 
> We don't add features which unmake the standard.
> 
>> That would preserve zero-copy capabilities (as long as you can work
>> against the shared mem directly, e.g. doing DMA from a physical NIC or
>> storage device into it) and keep the hypervisor out of the loop.
> 
> This seems ill thought out.  How will you program a NIC via the virtio
> protocol without a hypervisor?  And how will you make it safe?  You'll
> need an IOMMU.  But if you have an IOMMU you don't need shared memory.

Scenarios behind this are things like driver VMs: You pass through the
physical hardware to a driver guest that talks to the hardware and
relays data via one or more virtual channels to other VMs. This confines
a certain set of security and stability risks to the driver VM.

> 
>> Is it
>> too invasive to existing infrastructure or does it have some other pitfalls?
> 
> You'll have to convince every vendor to implement your addition to the
> standard.  Which is easier than inventing a completely new system, but
> it's not quite virtio.

It would be an optional addition, a feature all three sides (host and
the communicating guests) would have to agree on. I think we would only
have to agree on extending the spec to enable this - after demonstrating
it via an implementation, of course.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux
