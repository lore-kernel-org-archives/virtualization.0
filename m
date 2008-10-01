From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [RFC] CPUID usage for interaction between Hypervisors and Linux.
Date: Wed, 01 Oct 2008 15:03:44 -0500
Message-ID: <48E3D7A0.3000403__1878.61186354912$1222891634$gmane$org@codemonkey.ws>
References: <1222881242.9381.17.camel@alok-dev1>
	<48E3BBC1.2050607__35819.6151479662$1222884502$gmane$org@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48E3BBC1.2050607__35819.6151479662$1222884502$gmane$org@goop.org>
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
Cc: kvm@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Dan Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, "avi@redhat.com" <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, akataria@vmware.com, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Alok Kataria wrote:
> 
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

Mmm, cpuid bikeshedding :-)

> The space 0x40000000-0x400000ff is reserved for hypervisor usage.
> 
> This region is divided into 16 16-leaf blocks.  Each block has the 
> structure:
> 
> 0x400000x0:
>     eax: max used leaf within the leaf block (max 0x400000xf)

Why even bother with this?  It doesn't seem necessary in your proposal.

Regards,

Anthony Liguori
