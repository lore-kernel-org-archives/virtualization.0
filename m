From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 12/26] Xen-paravirt_ops: Fix patch site
 clobbers to include return register
Date: Fri, 16 Mar 2007 10:37:44 -0700
Message-ID: <45FAD5E8.1030301@goop.org>
References: <20070301232443.195603797@goop.org>
	<20070301232527.755495278@goop.org>
	<20070316092626.GN23174@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070316092626.GN23174@elte.hu>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
>   
>> Fix a few clobbers to include the return register.  The clobbers set 
>> is the set of all registers modified (or may be modified) by the code 
>> snippet, regardless of whether it was deliberate or accidental.
>>     
>
> i guess we need these paravirt.h clobber fixes for v2.6.21 (VMI) too, 
> correct?

No, I don't think so.  These aren't gcc-style clobbers, but a marker in
the .parainstruction section about what registers may be clobbered by
the patched in code.   VMI doesn't use that info, and/or doesn't clobber
more than is allowed at each site, so it isn't an issue.

    J
