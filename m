From: Alok Kataria <akataria@vmware.com>
Subject: Re: [RFC] CPUID usage for interaction between Hypervisors and Linux.
Date: Wed, 01 Oct 2008 14:23:35 -0700
Message-ID: <1222896215.9381.79.camel__20364.6714137451$1222896353$gmane$org@alok-dev1>
References: <1222881242.9381.17.camel@alok-dev1> <48E3BBC1.2050607@goop.org>
	<1222894878.9381.63.camel@alok-dev1> <48E3E6DF.8060400@codemonkey.ws>
Reply-To: akataria@vmware.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48E3E6DF.8060400@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: the arch/x86 maintainers <x86@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Daniel Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "avi@redhat.com" <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2008-10-01 at 14:08 -0700, Anthony Liguori wrote:
> Alok Kataria wrote:
> > On Wed, 2008-10-01 at 11:04 -0700, Jeremy Fitzhardinge wrote:
> >
> > 2. Divergence in the interface provided by the hypervisors  :
> >       The reason we brought up a flat hierarchy is because we think we should
> > be moving towards a approach where the guest code doesn't diverge too
> > much when running under different hypervisors. That is the guest
> > essentially does the same thing if its running on say Xen or VMware.
> >
> > This design IMO, will take us a step backward to  what we already have
> > seen with para virt ops. Each hypervisor (mostly) defines its own cpuid
> > block, the guest correspondingly needs to have code to handle each of
> > these cpuid blocks, with these blocks will mostly being exclusive.
> >
> 
> What's wrong with what we have in paravirt_ops? 

Your explanation below answers the question you raised, the problem
being we need to have support for each of these different hypercall
mechanisms in the kernel. 
I understand that this was the correct thing to do at that moment. 
But do we want to go the same way again for CPUID when we can make it
generic (flat enough) for anybody to use it in the same manner and
expose a generic interface to the kernel.

>  Just agreeing on CPUID
> doesn't help very much. 
Yeah, nobody is removing any of the paravirt ops support.

>  You still need a mechanism for doing hypercalls
> to implement anything meaningful.  We aren't going to agree on a
> hypercall mechanism.  KVM uses direct hypercall instructions, Xen uses a
> hypercall page, VMware uses VMI, Hyper-V uses MSR writes.  We all have
> already defined the hypercall namespace in a certain way.

Thanks,
Alok
