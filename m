From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] CPUID usage for interaction between Hypervisors and Linux.
Date: Wed, 01 Oct 2008 11:16:05 -0700
Message-ID: <48E3BE65.2050909__9122.81743153489$1222885369$gmane$org@zytor.com>
References: <1222881242.9381.17.camel@alok-dev1> <48E3BBC1.2050607@goop.org>
	<48E3BC47.60900@zytor.com> <48E3BD83.2090801@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48E3BD83.2090801@goop.org>
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
Cc: kvm@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Dan Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, "avi@redhat.com" <avi@redhat.com>, akataria@vmware.com, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
>>
>> I suspect we can get a larger number space if we ask Intel & AMD.  In 
>> fact, I think we should request that the entire 0x40xxxxxx numberspace 
>> is assigned to virtualization *anyway*.
> 
> Yes, that would be good.  In that case I'd revise my proposal to back 
> each leaf block 256 leaves instead of 16.  But it still needs to be a 
> proper enumeration with signatures, rather than assigning fixed points 
> in that space to specific interfaces.
> 

With a sufficiently large block, we could use fixed points, e.g. by 
having each vendor create interfaces in the 0x40SSSSXX range, where SSSS 
is the PCI ID they use for PCI devices.

Note that I said "create interfaces".  It's important that all about 
this is who specified the interface -- for "what hypervisor is this" 
just use 0x40000000 and disambiguate based on that.

	-hpa
