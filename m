From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Re: [patch 05/24] Xen-paravirt_ops: Add pagetable
	accessors to pack and unpack pagetable entries
Date: Wed, 21 Feb 2007 15:27:21 -0800
Message-ID: <45DCD559.1040301@goop.org>
References: <20070221205254.169835700@goop.org>	<20070221205322.869165491@goop.org>
	<200702212315.12883.ak@suse.de>
	<1172100002.13378.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <1172100002.13378.42.camel@localhost.localdomain>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: xen-devel@lists.xensource.com, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Wed, 2007-02-21 at 23:15 +0100, Andi Kleen wrote:
>   
>> On Wednesday 21 February 2007 21:52, Jeremy Fitzhardinge wrote:
>>     
>>> Add a set of accessors to pack, unpack and modify page table entries
>>> (at all levels).  This allows a paravirt implementation to control the
>>> contents of pgd/pmd/pte entries.  For example, Xen uses this to
>>> convert the (pseudo-)physical address into a machine address when
>>> populating a pagetable entry, and converting back to pphys address
>>> when an entry is read.
>>>       
>> Do you have some lmbench numbers before/after this change? 
>> iirc at least fork and exit do a lot of pte accesses in various forms.
>> If it's measurable it might be needed to patch those for the native case.
>>     
>
> Yes, __mkpte must be patched to avoid performance embarrassment.
>
> Jeremy, did you want me to do this, or are you happy to?
>   
I'm working on it now.  I'll mail out a proposal in a little bit.

    J
