From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [RFC] CPUID usage for interaction between Hypervisors and Linux.
Date: Wed, 01 Oct 2008 16:29:48 -0500
Message-ID: <48E3EBCC.70502__10421.7312335551$1222896934$gmane$org@codemonkey.ws>
References: <1222881242.9381.17.camel@alok-dev1> <48E3BBC1.2050607@goop.org>	
	<1222894878.9381.63.camel@alok-dev1>
	<48E3E6DF.8060400@codemonkey.ws>
	<1222896215.9381.79.camel@alok-dev1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1222896215.9381.79.camel@alok-dev1>
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
Cc: the arch/x86 maintainers <x86@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Daniel Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "avi@redhat.com" <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Alok Kataria wrote:
> Your explanation below answers the question you raised, the problem
> being we need to have support for each of these different hypercall
> mechanisms in the kernel. 
> I understand that this was the correct thing to do at that moment. 
> But do we want to go the same way again for CPUID when we can make it
> generic (flat enough) for anybody to use it in the same manner and
> expose a generic interface to the kernel.
>   

But what sort of information can be stored in cpuid that's actually 
useful?  Right now we just it in KVM for feature bits.  Most of the 
stuff that's interesting is stored in shared memory because a guest can 
read that without taking a vmexit or via a hypercall.

We can all agree upon a common mechanism for doing something but if no 
one is using that mechanism to do anything significant, what purpose 
does it serve?

Regards,

Anthony Liguori
