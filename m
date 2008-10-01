From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [RFC] CPUID usage for interaction between Hypervisors and	Linux.
Date: Wed, 01 Oct 2008 14:17:18 -0700
Message-ID: <48E3E8DE.1080602__29758.0574675978$1222896420$gmane$org@goop.org>
References: <1222881242.9381.17.camel@alok-dev1> <48E3BBC1.2050607@goop.org>
	<1222894878.9381.63.camel@alok-dev1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1222894878.9381.63.camel@alok-dev1>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: akataria@vmware.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Daniel Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "avi@redhat.com" <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Alok Kataria wrote:
> 1. Kernel complexity : Just thinking about the complexity that this will
> put in the kernel to handle these multiple ABI signatures and scanning
> all of these leaf block's is difficult to digest.
>   

The scanning for the signatures is trivial; it's not a significant 
amount of code.  Actually implementing them is a different matter, but 
that's the same regardless of where they are placed or how they're 
discovered.  After discovery its the same either way: there's a leaf 
base with offsets from it.

> 2. Divergence in the interface provided by the hypervisors  : 
> 	The reason we brought up a flat hierarchy is because we think we should
> be moving towards a approach where the guest code doesn't diverge too
> much when running under different hypervisors. That is the guest
> essentially does the same thing if its running on say Xen or VMware.
>   

I guess, but the bulk of the uses of this stuff are going to be 
hypervisor-specific.  You're hard-pressed to come up with any other 
generic uses beyond tsc.  In general, if a hypervisor is going to put 
something in a special cpuid leaf, its because there's no other good way 
to represent it.  Generic things are generally going to appear as an 
emulated piece of the virtualized platform, in ACPI, DMI, a 
hardware-defined cpuid leaf, etc...

> 3. Is their a need to do all this over engineering : 
> 	Aren't we over engineering a simple interface over here. The point is,
> there are right now 256 cpuid leafs do we realistically think we are
> ever going to exhaust all these leafs. We are really surprised to know
> that people may think this space is small enough. It would be
> interesting to know what all use you might want to put cpuid for.
>   

Look, if you want to propose a way to use that cpuid space in a 
reasonably flexible way that allows it to be used as the need arises, 
then we can talk about it.  But I think your proposal is a poor way to 
achieve those ends

If you want blessing for something that you've already implemented and 
shipped, well, you don't need anyone's blessing for that.

    J
