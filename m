From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 09/26] Xen-paravirt_ops: remove
 HAVE_ARCH_MM_LIFETIME, define no-op architecture implementations
Date: Tue, 27 Feb 2007 09:56:38 -0800
Message-ID: <45E470D6.7050401@goop.org>
References: <20070227081337.434798469@goop.org>	
	<20070227081632.356636957@goop.org>	
	<1172589358.3408.2.camel@mulgrave.il.steeleye.com>	
	<45E46889.9090801@goop.org>
	<1172597726.3408.25.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <1172597726.3408.25.camel@mulgrave.il.steeleye.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Zachary Amsden <zach@vmware.com>, linux-arch@vger.kernel.org, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

James Bottomley wrote:
> On Tue, 2007-02-27 at 09:21 -0800, Jeremy Fitzhardinge wrote:
>   
>> You mean add the two stubs to asm-generic/mmu_context.h, and then
>> include that in all these files?  That would be cleaner, but it
>> wouldn't
>> remove the need to touch all these files, would it?
>>     
>
> it would if you added asm-generic/mmu_context_paravirt.h
>   

include/asm-generic isn't in the compile include path; its contents are
only ever used if they're explicitly included by some other asm/
header.  I seem to remember there was some debate about this, but I
don't really understand the rationale for the current arrangement; it
makes sense to me to have asm-generic as a set of fallback default includes.

> and only included that in the main kernel files that need the three
> operations (that's just fork.c and mmap.c, isn't it)?
>   

Yeah, it's really only two operations.  activate_mm happens in arch code
anyway, so there's no need to make a fuss about it.

    J
