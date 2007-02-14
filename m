From: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [patch 16/21] Xen-paravirt: Add code into
	head.S to handle being booted by Xen
Date: Wed, 14 Feb 2007 08:56:09 +0000
Message-ID: <45D2DCB9.76E4.0078.0@novell.com>
References: <20070213221729.772002682@goop.org>
	<20070213221830.707197267@goop.org> <20070213235424.GA1908@muc.de>
	<45D25A56.1000706@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <45D25A56.1000706@goop.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

>>> @@ -528,7 +532,7 @@ ENTRY(_stext)
>>>  /*
>>>   * BSS section
>>>   */
>>> -.section ".bss.page_aligned","w"
>>> +.section ".bss.page_aligned"
>>>     
>>
>> Why? 
>>   
>
>I got complaints about section attribute mismatches without it.

Then perhaps ... "aw" is meant?

>>> +fastcall unsigned long long xen_pgd_val(pgd_t pgd)
>>> +{
>>> +	unsigned long long ret = pgd.pgd;
>>> +	if (ret)
>>> +		ret = machine_to_phys(XMADDR(ret)).paddr | 1;
>>>     
>>
>> Why can they be 0 here anyways?
>>
>> Normally they are all considered undefined when not present
>>   
>
>Not sure.

This should probably get sync-ed up with the page table handling changes
submitted to xen-devel yesterday. Using zero/non-zero tests in contexts
like this was always broken; should check for _PAGE_PRESENT.

Jan
