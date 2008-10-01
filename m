From: Alok Kataria <akataria@vmware.com>
Subject: Re: [RFC] CPUID usage for interaction between Hypervisors and Linux.
Date: Wed, 01 Oct 2008 14:01:18 -0700
Message-ID: <1222894878.9381.63.camel__16188.9166491621$1222895273$gmane$org@alok-dev1>
References: <1222881242.9381.17.camel@alok-dev1> <48E3BBC1.2050607@goop.org>
Reply-To: akataria@vmware.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48E3BBC1.2050607@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Daniel Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "avi@redhat.com" <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2008-10-01 at 11:04 -0700, Jeremy Fitzhardinge wrote:

> No, we're not getting anywhere.  This is an outright broken idea.  The
> space is too small to be able to chop up in this way, and the number of
> vendors too large to be able to do it without having a central oversight.
> 
> The only way this can work is by having explicit positive identification
> of each group of leaves with a signature.  If there's a recognizable
> signature, then you can inspect the rest of the group; if not, then you
> can't.  That way, you can avoid any leaf usage which doesn't conform to
> this model, and you can also simultaneously support multiple hypervisor
> ABIs.  It also accommodates existing hypervisor use of this leaf space,
> even if they currently use a fixed location within it.
> 
> A concrete counter-proposal:
> 
> The space 0x40000000-0x400000ff is reserved for hypervisor usage.
> 
> This region is divided into 16 16-leaf blocks.  Each block has the
> structure:
> 
> 0x400000x0:
>     eax: max used leaf within the leaf block (max 0x400000xf)
>     e[bcd]x: leaf block signature.  This may be a hypervisor-specific
> signature, or a generic signature, depending on the contents of the block
> 
> A guest may search for any supported Hypervisor ABIs by inspecting each
> leaf at 0x400000x0 for a known signature, and then may choose its mode
> of operation accordingly.  It must ignore any unknown signatures, and
> not touch any of the leaves within an unknown leaf block.
> Hypervisor vendors who want to add a hypervisor-specific leaf block must
> choose a signature which is recognizably related to their or their
> hypervisor's name.
> 
> Signatures starting with "Generic" are reserved for generic leaf blocks.
> 
> A guest may scan leaf blocks to enumerate what hypervisor ABIs/hypercall
> interfaces are available to it.  It may mix and match any information
> from leaves it understands.  However, once it starts using a specific
> hypervisor ABI by making hypercalls or doing other operations with
> side-effects, it must commit to using that ABI exclusively (a specific
> hypervisor ABI may include the generic ABI by reference, however).
> 
> Correspondingly, a hypervisor must treat any cpuid accesses as
> side-effect free.
> 
> Definition of specific blocks:
> 
> Generic hypervisor leaf block:
>   0x400000x0 signature is "GenericVMMIF" (or something)
>   0x400000x1 tsc leaf as you've described
> 

I see following issues with this proposal,

1. Kernel complexity : Just thinking about the complexity that this will
put in the kernel to handle these multiple ABI signatures and scanning
all of these leaf block's is difficult to digest.

2. Divergence in the interface provided by the hypervisors  : 
	The reason we brought up a flat hierarchy is because we think we should
be moving towards a approach where the guest code doesn't diverge too
much when running under different hypervisors. That is the guest
essentially does the same thing if its running on say Xen or VMware.

This design IMO, will take us a step backward to  what we already have
seen with para virt ops. Each hypervisor (mostly) defines its own cpuid
block, the guest correspondingly needs to have code to handle each of
these cpuid blocks, with these blocks will mostly being exclusive.


3. Is their a need to do all this over engineering : 
	Aren't we over engineering a simple interface over here. The point is,
there are right now 256 cpuid leafs do we realistically think we are
ever going to exhaust all these leafs. We are really surprised to know
that people may think this space is small enough. It would be
interesting to know what all use you might want to put cpuid for.

Thanks,
Alok



>     J
