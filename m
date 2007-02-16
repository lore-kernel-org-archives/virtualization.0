From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 18/21] Xen-paravirt: Add Xen grant table
	support
Date: Thu, 15 Feb 2007 22:58:01 -0800
Message-ID: <45D555F9.7010203@goop.org>
References: <20070216022449.739760547@goop.org>	<20070216022531.904462260@goop.org>
	<20070215225229.6b63d050.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070215225229.6b63d050.akpm@linux-foundation.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

Andrew Morton wrote:
> On Thu, 15 Feb 2007 18:25:07 -0800 Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
>   
>> +int gnttab_grant_foreign_access(domid_t domid, unsigned long frame,
>> +				int readonly)
>> +{
>> +	int ref;
>> +
>> +	if (unlikely((ref = get_free_entry()) == -1))
>> +		return -ENOSPC;
>> +
>> +	shared[ref].frame = frame;
>> +	shared[ref].domid = domid;
>> +	wmb();
>> +	shared[ref].flags = GTF_permit_access | (readonly ? GTF_readonly : 0);
>> +
>> +	return ref;
>> +}
>> +EXPORT_SYMBOL_GPL(gnttab_grant_foreign_access);
>>     
>
> We have lots of open-coded mysteriously unexplained barriers in here.
>
> I assume they're not smp_wmb() because this could be a !SMP guest talking
> to an SMP host?
>   

Yeah.  The grant tables refer to pages which are shared with other
domains, so they could be running on other cpus even if this domain is
UP.  There's a lockless protocol going on here, but I'll need to look it
up and sprinkle some comments.

    J
