From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 04/26] Xen-paravirt_ops: Add pagetable
 accessors to pack and unpack pagetable entries
Date: Wed, 28 Feb 2007 12:12:37 -0800
Message-ID: <45E5E235.60707@goop.org>
References: <20070227081337.434798469@goop.org>
	<20070227081630.311681690@goop.org>
	<20070227100850.GA10827@elte.hu> <45E47DEF.70405@goop.org>
	<20070228083203.GB8866@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070228083203.GB8866@elte.hu>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
>> Yes, but it happens after asm/paravirt.h has already included some 
>> things, and it ends up causing problems.  paravirt.h still defines 
>> various stub functions in the !CONFIG_PARAVIRT case, so it needs to do 
>> the includes either way.
>>     
>
> hm, it then needs to be fixed first, instead of adding to the mess.
>   

OK, I've fixed this by hoisting all the native_* implementations into
pgtable.h.  In the !PARAVIRT case the normal macros directly use the
native_* functions, and in the PARAVIRT case they're used by the native
paravirt_ops.  This has the nice property of avoiding this specific
problem, and also generally removes code duplication.

    J
