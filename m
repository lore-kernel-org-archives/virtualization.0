From: Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [Xen-devel] [RFC] Hypervisor RNG and enumeration
Date: Wed, 29 Oct 2014 10:37:17 +0000
Message-ID: <5450C35D.1030907@citrix.com>
References: <CALCETrUuSApjNk+xdB1XEPH+Lz2PGY0gnreHwx5Z6xQ0Vj74tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrUuSApjNk+xdB1XEPH+Lz2PGY0gnreHwx5Z6xQ0Vj74tw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@amacapital.net>, Linux Virtualization <virtualization@lists.linux-foundation.org>
Cc: Mathew John <mathewj@microsoft.com>, Theodore Ts'o <tytso@mit.edu>, Jim Mattson <jmattson@vmware.com>, kvm list <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Niels Ferguson <niels@microsoft.com>, David Hepkin <davidhep@microsoft.com>, Doug Covelli <dcovelli@vmware.com>, Paolo Bonzini <pbonzini@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Jake Oshins <jakeo@microsoft.com>, xen-devel@lists.xenproject.org, Alok Kataria <akataria@vmware.com>, John Starks <John.Starks@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On 29/10/14 05:19, Andy Lutomirski wrote:
> Here's a draft CommonHV spec.  It's also on github:
>
> https://github.com/amluto/CommonHV
>
> So far, this provides a two-way RNG interface, a way to detect it, and
> a way to detect other hypervisor leaves.  The latter is because, after
> both the enormous public thread and some private discussions, it seems
> that detection of existing CPUID paravirt leaves is annoying and
> inefficient.  If we're going to define some cross-vendor CPUID leaves,
> it seems like it would be useful to offer a way to quickly enumerate
> other leaves.
>
> I've been told the AMD intends to update their manual to match Intel's
> so that hypervisors can use the entire 0x4F?????? CPUID range.  I have
> intentionally not fixed an MSR value for the RNG because the range of
> allowed MSRs is very small in both the Intel and AMD manuals.  If any
> given hypervisor wants to ignore that small range and advertise a
> higher-numbered MSR, it is welcome to, but I don't want to codify
> something that doesn't comply with the manuals.
>
> Here's the draft.  Comments?  To the people who work on various
> hypervisors: Would you implement this?  Do you like it?  Is there
> anything, major or minor, that you'd like to see changed?  Do you
> think that this is a good idea at all?

As a first pass, it looks like a plausible idea.  I do however have come
comments.

>
> I've tried to get good coverage of various hypervisors.  There are
> Hyper-V, VMWare, KVM, and Xen people on the cc list.
>
> Thanks,
> Andy
>
>
>
> CommonHV, a common hypervisor interface
> =======================================
>
> This is CommonHV draft 1.
>
> The CommonHV specification is Copyright (c) 2014 Andrew Lutomirski.
>
> Licensing will be determined soon.  The license is expected to be extremely
> liberal.  I am currently leaning towards CC-BY-SA for the specification and
> an explicit license permitting anyone to implement the specification
> with no restrictions whatsoever.
>
> I have not patented, nor do I intend to patent, anything required to implement
> this specification.  I am not aware of any current or future intellectual
> property rights that would prevent a royalty-free implementation of
> this specification.
>
> I would like to find a stable, neutral steward of this specification
> going forward.  Help with this would be much appreciated.
>
> Scope
> -----
>
> CommonHV is a simple interface for communication
> between hypervisors and their guests.
>
> CommonHV is intended to be very simple and to avoid interfering with
> existing paravirtual interfaces.  To that end, its scope is limited.
> CommonHV does only two types of things:
>
>   * It provides a way to enumerate other paravirtual interfaces.
>   * It provides a small, extensible set of paravirtual features that do not
>     modify or replace standard system functionality.
>
> For example, CommonHV does not and will not define anything related to
> interrupt handling or virtual CPU management.
>
> For now, CommonHV is only applicable to the x86 platform.
>
> Discovery
> ---------
>
> A CommonHV hypervisor MUST set the hypervisor bit (bit 31 in CPUID.1H.0H.ECX)
> and provide the CPUID leaf 4F000000H, containing:
>
>   * CPUID.4F000000H.0H.EAX = max_commonhv_leaf
>   * CPUID.4F000000H.0H.EBX = 0x6D6D6F43
>   * CPUID.4F000000H.0H.ECX = 0x56486E6F
>   * CPUID.4F000000H.0H.EDX = 0x66746e49
>
> EBX, ECX, and EDX form the string "CommonHVIntf" in little-endian ASCII.

While testing various nested combinations, XenServer has found that
modern Windows Server versions must have the hypervisor bit hidden from
them for them to be happy running HyperV, despite the fact that they
will make use of the Viridian virtual extensions also provided.

As a result, while it is certainly advisable for the hypervisor bit to
be set, CommonHV should be available to be found by paravirtualised
drivers inside an OS which can't cope with the hypervisor bit set.

>
> max_commonhv_leaf MUST be a number between 0x4F000000 and 0x4FFFFFFF.  It
> indicates the largest leaf defined in this specification that is provided.
> Any leaves described in this specification with EAX values that exceed
> max_commonhv_leaf MUST be handled by guests as though they contain
> all zeros.
>
> CPUID leaf 4F000001H: hypervisor interface enumeration
> ------------------------------------------------------
>
> If max_commonhv_leaf >= 0x4F000001, CommonHV provides a list of tuples
> (location, signature).  Each tuple indicates the presence of another
> paravirtual interface identified by the signature at the indicated
> CPUID location.  It is expected that CPUID.location.0H will have
> (EBX, ECX, EDX) == signature, although whether this is required
> is left to the specification associated with the given signature.
>
> If the list contains N tuples, then, for each 0 <= i < N:
>
>   * CPUID.4F000001H.i.EBX, CPUID.4F000001H.i.ECX, and CPUID.4F000001H.i.EDX
>     are the signature.
>   * CPUID.4F000001H.i.EAX is the location.
>
> CPUID with EAX = 0x4F000001 and ECX >= N MUST return all zeros.
>
> To the extent that the hypervisor prefers a given interface, it should
> specify that interface earlier in the list.  For example, KVM might place
> its "KVMKVMKVM" signature first in the list to indicate that it should be
> used by guests in preference to other supported interfaces.  Other hypervisors
> would likely use a different order.
>
> The exact semantics of the ordering of the list is beyond the scope of
> this specification.

How do you evaluate N?

It would make more sense for CPUID.4F000001[ECX=0] to return N in one
register, and perhaps "prefered interface index" in another.  The
signatures can then be obtained from CPUID.4F000001[ECX={1 to N}].

That way, a consumer can be confident that they have found all the
signatures, without relying on an unbounded loop and checking for zeroes.

>
> CPUID leaf 4F000002H: miscellaneous features
> --------------------------------------------
>
> CPUID.4F000002H.EAX is nonzero if the CommonHV RNG interface is available.
> CPUID.4F000002H.EBX, CPUID.4F000002H.ECX, and CPUID.4F000002H.EDX are reserved
> and must be zero in hypervisors compliant with this version of the CommonHV
> specification.

This doesn't match the name of "miscellaneous features".  Furthermore, 0
is a valid (albeit unlikely) MSR index.

How about having a proper bitmask, where bit 0 in one of the registers
means "the RNG information at leaf 4F000003 is valid"?

>
> ### CommonHV RNG
>
> If CPUID.4F000002H.EAX is nonzero, then it contains an MSR index used to
> communicate with a hypervisor random number generator.  This MSR is
> referred to as MSR_COMMONHV_RNG.
>
> rdmsr(MSR_COMMONHV_RNG) returns a 64-bit best-effort random number.  If the
> hypervisor is able to generate a 64-bit cryptographically secure random number,
> it SHOULD return it.  If not, then the hypervisor SHOULD do its best to return
> a random number suitable for seeding a cryptographic RNG.

Is it useful for the hypervisor to inform the guest (perhaps by a
bitfield in 4F000003) whether the number is cryptographically secure or
not?  I am not sure, as at the end of the day the guest will have to
completely trust the hypervisor, but it might be useful to signify "this
number is most certainly not cryptographically secure".

Xen itself has no entropy pool, so is certainly not in a position to
provide a cryptographically secure number.

>
> A guest is expected to read MSR_COMMONHV_RNG several times in a row.
> The hypervisor SHOULD return different values each time.
>
> rdmsr(MSR_COMMONHV_RNG) MUST NOT result in an exception, but guests MUST
> NOT assume that its return value is indeed secure.  For example, a hypervisor
> is free to return zero in response to rdmsr(MSR_COMMONHV_RNG).

This is in contradiction to the previous paragraph.  If the hypervisor
is not capable of providing random numbers, it should not advertise the
presence of RNG.

>
> wrmsr(MSR_COMMONHV_RNG) offers the hypervisor up to 64 bits of entropy.
> The hypervisor MAY use it as it sees fit to improve its own random number
> generator.  A hypervisor SHOULD make a reasonable effort to avoid making
> values written to MSR_COMMONHV_RNG visible to untrusted parties, but
> guests SHOULD NOT write sensitive values to wrmsr(MSR_COMMONHV_RNG).

Under what circumstances might this be useful.  The hypervisor cannot
possibly trust that the numbers are even random at all, meaning that the
only safe action is to completely discard them.

Furthermore, the hypervisor itself is in a much better position to draw
entropy from other places in the system, and virtual machines are
specifically lacking in good sources of entropy.  No VM should be
exhausting its limited entropy by trying to push random numbers back at
the hypervisor.

~Andrew

>
> A hypervisor is free to ignore wrmsr(MSR_COMMONHV_RNG), but wrmsr to
> MSR_COMMONHV_RNG MUST NOT result in an exception.
>
> Note that the CommonHV RNG is not intended to replace stronger, asynchronous
> paravirtual random number generator interfaces.  It is intended primarily
> for seeding guest RNGs early in boot.
>
> Future extension
> ----------------
>
> CPUID leaves beyond those defined in this version of the CommonHV specification
> should be ignored by guests written for this version of the specification.
>
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> http://lists.xen.org/xen-devel
