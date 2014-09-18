From: KY Srinivasan <kys@microsoft.com>
Subject: RE: Standardizing an MSR or other hypercall to get an RNG seed?
Date: Thu, 18 Sep 2014 14:40:44 +0000
Message-ID: <2aa00301e9af4826b5781e01709f81e7__13583.5193600089$1411052198$gmane$org@BY2PR0301MB0711.namprd03.prod.outlook.com>
References: <CALCETrX66iDM+eG56hpMN4TcuXtzbEr5nB_f6JE-2XETSMWV5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrX66iDM+eG56hpMN4TcuXtzbEr5nB_f6JE-2XETSMWV5w@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@amacapital.net>, Linux Virtualization <virtualization@lists.linux-foundation.org>, kvm list <kvm@vger.kernel.org>
Cc: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Theodore Ts'o <tytso@mit.edu>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: virtualization-bounces@lists.linux-foundation.org
> [mailto:virtualization-bounces@lists.linux-foundation.org] On Behalf Of Andy
> Lutomirski
> Sent: Wednesday, September 17, 2014 7:51 PM
> To: Linux Virtualization; kvm list
> Cc: Gleb Natapov; Paolo Bonzini; Theodore Ts'o; H. Peter Anvin
> Subject: Standardizing an MSR or other hypercall to get an RNG seed?
> 
> Hi all-
> 
> I would like to standardize on a very simple protocol by which a guest OS can
> obtain an RNG seed early in boot.
> 
> The main design requirements are:
> 
>  - The interface should be very easy to use.  Linux, at least, will want to use it
> extremely early in boot as part of kernel ASLR.  This means that PCI and ACPI
> will not work.
> 
>  - It should be synchronous.  We don't want to delay boot while waiting for a
> slow host RNG.  (On Linux, at least, we have a separate interface for that:
> virtio-rng.  I think that Windows has some support for virtio-rng as well.)
> 
>  - Random numbers obtained through this interface should be best-effort.
> We want the best quality randomness that the host can provide
> immediately.
> 
> It seems to me that the best interface for the actual request for a random
> number is rdmsr.  This is supported on all hypervisors and all virtualization
> technologies.  It can return a 64 bit random number, and it is easy to rdmsr
> the same register more than once to get a larger random number.
> 
> The main questions are what MSR index to use and how to detect the
> presence of the MSR.  I've played with two approaches:
> 
> 1. Use CPUID to detect the presence of this feature.  This is very easy for
> KVM to implement by using a KVM-specific CPUID feature.  The problem is
> that this will necessarily be KVM-specific, as the guest must first probe for
> KVM and then probe for the KVM feature.  I doubt that Hyper-V, for
> example, wants to claim to be KVM.  If we could standardize a non-
> hypervisor-specific CPUID feature, then this problem would go away.

We would prefer a CPUID feature bit to detect this feature.
 
> 
> 2. Detect the existence of the MSR by trying to read it and handling the
> #GP(0) that will occur if the MSR is not present.  Linux, at least, is okay with
> doing this, and I have code to enable an IDT and an rdmsr fixup early enough
> in boot to use it for ASLR.  I don't know whether other operating systems can
> do this, though.
> 
> The major questions, then, are what enumeration mechanism should be
> used and what MSR index should be used.
> 
> For the MSR index, we could use an MSR from the Intel range if Intel were to
> give explicit approval, thus guaranteeing that nothing would conflict.  Or we
> could try to agree on an MSR index in the 0x40000000-0x4fffffff range that is
> unlikely to conflict with anything.
> 
> For enumeration, we could just probe the MSR if all relevant guests are okay
> with this or we could standardize on a CPUID-based mechanism.
> If we do the latter, I don't know what that mechanism would be.
> 
> NB: This thread will be cc'd to Microsoft and possibly Hyper-V people shortly.
> I very much appreciate Jun Nakajima's help with this!
> 
> Thanks,
> Andy


Regards,

K. Y
> 
> --
> Andy Lutomirski
> AMA Capital Management, LLC
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
