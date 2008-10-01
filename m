From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [RFC] CPUID usage for interaction between Hypervisors and Linux.
Date: Wed, 01 Oct 2008 16:31:30 -0500
Message-ID: <48E3EC32.4030603__36343.7498607256$1222897039$gmane$org@codemonkey.ws>
References: <1222881242.9381.17.camel@alok-dev1> <48E3BBC1.2050607@goop.org>
	<1222894878.9381.63.camel@alok-dev1>
	<48E3E6DF.8060400@codemonkey.ws>
	<20081001211532.GC634@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081001211532.GC634@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: the arch/x86 maintainers <x86@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Daniel Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, akataria@vmware.com, Ingo Molnar <mingo@elte.hu>, "avi@redhat.com" <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Chris Wright wrote:
> * Anthony Liguori (anthony@codemonkey.ws) wrote:
>   
>> We've already gone down the road of trying to make standard paravirtual  
>> interfaces (via virtio).  No one was sufficiently interested in  
>> collaborating.  I don't see why other paravirtualizations are going to  
>> be much different.
>>     
>
> The point is to be able to support those interfaces.  Presently a Linux guest
> will test and find out which HV it's running on, and adapt.  Another
> guest will fail to enlighten itself, and perf will suffer...yadda, yadda.
>   

Agreeing on CPUID does not get us close at all to having shared 
interfaces for paravirtualization.  As I said in another note, there are 
more fundamental things that we differ on (like hypercall mechanism) 
that's going to make that challenging.

We already are sharing code, when appropriate (see the Xen/KVM PV clock 
interface).

Regards,

Anthony Liguori

> thanks,
> -chris
>   
