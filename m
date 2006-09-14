From: Zachary Amsden <zach@vmware.com>
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
Date: Thu, 14 Sep 2006 02:23:38 -0700
Message-ID: <45091F9A.5020805@vmware.com>
References: <20060901110948.GD15684@skybase>  <45084C2E.4060203@vmware.com> <1158224199.18478.22.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751502AbWINJXk@vger.kernel.org>
In-Reply-To: <1158224199.18478.22.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
List-Id: virtualization@lists.linuxfoundation.org

Martin Schwidefsky wrote
> The discard fault happens on access to a volatile that has been
> discarded. An important property of the s390 architecture comes into
> play here: there are two page tables, a guest page table and a host page
> table. What the guest perceives as its "physical" memory is in virtual
> storage for the host. An address resolution has to walk two pages
> tables, if a pte is invalid in either table you get a fault. A guest
> fault if the invalid pte is in the guest table and a host fault if it is
>   

Yes, I'm familiar with that trick.  Wasn't sure if you had it in 
hardware or not.

> in the host table. That gives s390 a simple method to implement
> discarded pages: the hypervisor just unmaps the page from the host table
> and changes the state of the guest page. I can see that you will have a
> much harder time to implement this on i386.
>   

Nah, I think we'll do just fine.

Thanks for the info - based on this, I think we can probably use the 
volatile page / swap cache changes as well for VMware, also pretty much 
unchanged.  Sorry to take so long to look at these patches, BTW - I was 
on holiday for two weeks.

Zach
