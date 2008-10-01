From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [RFC] CPUID usage for interaction between Hypervisors and Linux.
Date: Wed, 01 Oct 2008 11:36:27 -0700
Message-ID: <48E3C32B.3090701__40114.6371420056$1222886337$gmane$org@goop.org>
References: <1222881242.9381.17.camel@alok-dev1> <48E3BBC1.2050607@goop.org>
	<48E3BC47.60900@zytor.com> <48E3BD83.2090801@goop.org>
	<48E3BE65.2050909@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48E3BE65.2050909@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: kvm@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Dan Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, "avi@redhat.com" <avi@redhat.com>, akataria@vmware.com, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> With a sufficiently large block, we could use fixed points, e.g. by 
> having each vendor create interfaces in the 0x40SSSSXX range, where 
> SSSS is the PCI ID they use for PCI devices.

Sure, you could do that, but you'd still want to have a signature in 
0x40SSSS00 to positively identify the chunk.  And what if you wanted 
more than 256 leaves?

> Note that I said "create interfaces".  It's important that all about 
> this is who specified the interface -- for "what hypervisor is this" 
> just use 0x40000000 and disambiguate based on that.

"What hypervisor is this?" isn't a very interesting question; if you're 
even asking it then it suggests that something has gone wrong.  Its much 
more useful to ask "what interfaces does this hypervisor support?", and 
enumerating a smallish range of well-known leaves looking for signatures 
is the simplest way to do that.  (We could use signatures derived from 
the PCI vendor IDs which would help with managing that namespace.)

    J
