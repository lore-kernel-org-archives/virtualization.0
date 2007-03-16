From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 23/26] Xen-paravirt_ops: Add Xen grant table
	support
Date: Fri, 16 Mar 2007 10:00:20 -0700
Message-ID: <45FACD24.5080000@goop.org>
References: <20070301232443.195603797@goop.org>
	<20070301232529.139074125@goop.org>
	<20070316085107.GC23174@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070316085107.GC23174@elte.hu>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
>> +
>> +#ifndef __ia64__
>> +	{
>>     
>
> introduce a proper arch method instead.
>   

I'll clean out the ia64 stuff.  We can add it back properly when (if?)
the time comes.

>> +	grant_ref_t g = *private_head;
>> +	if (unlikely(g == GNTTAB_LIST_END))
>>     
>
> coding style problems.

Yup.
