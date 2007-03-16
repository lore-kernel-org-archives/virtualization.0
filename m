From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 05/26] Xen-paravirt_ops: paravirt_ops: hooks to set up
 initial pagetable
Date: Fri, 16 Mar 2007 11:39:43 -0700
Message-ID: <45FAE46F.7080009@goop.org>
References: <20070301232443.195603797@goop.org> <20070301232526.611972133@goop.org> <20070316093348.GS23174@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753581AbXCPSjy@vger.kernel.org>
In-Reply-To: <20070316093348.GS23174@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, William Lee Irwin III <wli@holomorphy.com>
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
>> +	/* Make sure kernel address space is empty so that a pagetable
>> +	   will be allocated for it. */
>>     
>
> comment style.
>   

As you've noticed its a comment style I use quite often.  I use it for
what's essentially a little local comment, rather than a block comment
which really needs to draw attention to itself.  In this case, I think using

/*
 * Make sure kernel address space is empty so that a pagetable
 * will be allocated for it.
 */

is just too loud for what its trying to say.  If // comments were deemed
acceptable, I'd probably use them here instead.

    J
