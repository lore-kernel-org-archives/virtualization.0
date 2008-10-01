From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [RFC] CPUID usage for interaction between Hypervisors and Linux.
Date: Wed, 01 Oct 2008 16:08:47 -0500
Message-ID: <48E3E6DF.8060400__42065.1016211652$1222895699$gmane$org@codemonkey.ws>
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
Cc: the arch/x86 maintainers <x86@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Daniel Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "avi@redhat.com" <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Alok Kataria wrote:
> On Wed, 2008-10-01 at 11:04 -0700, Jeremy Fitzhardinge wrote:
>   
> 2. Divergence in the interface provided by the hypervisors  : 
> 	The reason we brought up a flat hierarchy is because we think we should
> be moving towards a approach where the guest code doesn't diverge too
> much when running under different hypervisors. That is the guest
> essentially does the same thing if its running on say Xen or VMware.
>
> This design IMO, will take us a step backward to  what we already have
> seen with para virt ops. Each hypervisor (mostly) defines its own cpuid
> block, the guest correspondingly needs to have code to handle each of
> these cpuid blocks, with these blocks will mostly being exclusive.
>   

What's wrong with what we have in paravirt_ops?  Just agreeing on CPUID 
doesn't help very much.  You still need a mechanism for doing hypercalls 
to implement anything meaningful.  We aren't going to agree on a 
hypercall mechanism.  KVM uses direct hypercall instructions, Xen uses a 
hypercall page, VMware uses VMI, Hyper-V uses MSR writes.  We all have 
already defined the hypercall namespace in a certain way.

We've already gone down the road of trying to make standard paravirtual 
interfaces (via virtio).  No one was sufficiently interested in 
collaborating.  I don't see why other paravirtualizations are going to 
be much different.

Regards,

Anthony Liguori
