From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 09/26] Xen-paravirt_ops: remove
 HAVE_ARCH_MM_LIFETIME, define no-op architecture implementations
Date: Tue, 27 Feb 2007 10:48:40 -0800
Message-ID: <45E47D08.5020802@goop.org>
References: <20070227081337.434798469@goop.org>	
	<20070227081632.356636957@goop.org>	
	<1172589358.3408.2.camel@mulgrave.il.steeleye.com>	
	<45E46889.9090801@goop.org>	
	<1172597726.3408.25.camel@mulgrave.il.steeleye.com>	
	<45E470D6.7050401@goop.org>
	<1172599480.3408.28.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <1172599480.3408.28.camel@mulgrave.il.steeleye.com>
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
> Yes ... I forgot about that ... we'd need an asm/mmu_context_paravirt.h
> on every arch.
>   

Yep.  And I'm not too keen on that name; one could imagine other uses
for those hooks, even if they're being used for x86 paravirtualization
in this instance.

> I suppose this is just me being lazy ... I'm currently doing a bit of a
> rewrite in asm-parisc/mmu_context.h and I didn't want a massive merge
> conflict.
>   

Well, I'm happy to create asm-generic/mm_hooks.h or something, and
reduce all the changes to asm-*/mmu_context.h to a one-liner.

    J
