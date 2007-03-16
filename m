From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 21/26] Xen-paravirt_ops: Use the hvc console
 infrastructure for Xen console
Date: Fri, 16 Mar 2007 10:02:23 -0700
Message-ID: <45FACD9F.6020604@goop.org>
References: <20070301232443.195603797@goop.org>
	<20070301232528.926984984@goop.org>
	<20070316085451.GE23174@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070316085451.GE23174@elte.hu>
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
>> +	prod = intf->in_prod;
>> +	mb();
>> +	BUG_ON((prod - cons) > sizeof(intf->in));
>>     
>
> such mb()'s are typically a sign of "i have no clear idea what SMP 
> serialization rules apply here, but something is needed because 
> otherwise it breaks" ?

Hm, in this case its because it's sharing the memory with Xen, so
there's a particular ordering protocol.  It needs some comments.

    J
