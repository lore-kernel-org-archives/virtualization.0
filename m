From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 14/26] Xen-paravirt_ops: add common patching
	machinery
Date: Fri, 16 Mar 2007 10:20:54 +0100
Message-ID: <20070316092054.GK23174@elte.hu>
References: <20070301232443.195603797@goop.org>
	<20070301232528.055105942@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <20070301232528.055105942@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Anthony Liguori <anthony@codemonkey.ws>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Implement the actual patching machinery.  paravirt_patch_default() 
> contains the logic to automatically patch a callsite based on a few 
> simple rules:
> 
>  - if the paravirt_op function is paravirt_nop, then patch nops
>  - if the paravirt_op function is a jmp target, then jmp to it
>  - if the paravirt_op function is callable and doesn't clobber too much
>     for the callsite, call it directly
> 
> paravirt_patch_default is suitable as a default implementation of 
> paravirt_ops.patch, will remove most of the expensive indirect calls 
> in favour of either a direct call or a pile of nops.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
