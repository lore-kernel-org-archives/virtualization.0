From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [RFC/PATCH 01/15] preparation: provide	hook	to	enable
	pgstes in user pagetable
Date: Mon, 24 Mar 2008 08:57:49 +0200
Message-ID: <47E750ED.7060509__39823.1773324825$1206342363$gmane$org@qumranet.com>
References: <1206028710.6690.21.camel@cotte.boeblingen.de.ibm.com>	
	<1206030278.6690.52.camel@cotte.boeblingen.de.ibm.com>	
	<47E29EC6.5050403@goop.org>	<1206040405.8232.24.camel@nimitz.home.sr71.net>	
	<47E2CAAC.6020903@de.ibm.com>	
	<1206124176.30471.27.camel@nimitz.home.sr71.net>	
	<20080322175705.GD6367@osiris.boeblingen.de.ibm.com>	
	<47E62DBA.4050102@qumranet.com>
	<1206296609.10233.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1206296609.10233.5.camel@localhost>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: schwidefsky@de.ibm.com
Cc: Christian Ehrhardt <EHRHARDT@de.ibm.com>, hollisb@us.ibm.com, arnd@arndb.de, carsteno@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Dave Hansen <haveblue@us.ibm.com>, jeroney@us.ibm.com, borntrae@linux.vnet.ibm.com, virtualization@lists.linux-foundation.org, Linux Memory Management List <linux-mm@kvack.org>, mschwid2@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com, rvdheij@gmail.com, Olaf Schnapper <os@de.ibm.com>, jblunck@suse.de, "Zhang, Xiantao" <xiantao.zhang@intel.com>, kvm-devel@lists.sourceforge.net
List-Id: virtualization@lists.linuxfoundation.org

Martin Schwidefsky wrote:
> On Sun, 2008-03-23 at 12:15 +0200, Avi Kivity wrote:
>   
>>>> Can you convert the page tables at a later time without doing a
>>>> wholesale replacement of the mm?  It should be a bit easier to keep
>>>> people off the pagetables than keep their grubby mitts off the mm
>>>> itself.
>>>>     
>>>>         
>>> Yes, as far as I can see you're right. And whatever we do in arch code,
>>> after all it's just a work around to avoid a new clone flag.
>>> If something like clone() with CLONE_KVM would be useful for more
>>> architectures than just s390 then maybe we should try to get a flag.
>>>
>>> Oh... there are just two unused clone flag bits left. Looks like the
>>> namespace changes ate up a lot of them lately.
>>>
>>> Well, we could still play dirty tricks like setting a bit in current
>>> via whatever mechanism which indicates child-wants-extended-page-tables
>>> and then just fork and be happy.
>>>   
>>>       
>> How about taking mmap_sem for write and converting all page tables 
>> in-place?  I'd rather avoid the need to fork() when creating a VM.
>>     
>
> That was my initial approach as well. If all the page table allocations
> can be fullfilled the code is not too complicated. To handle allocation
> failures gets tricky. At this point I realized that dup_mmap already
> does what we want to do. It walks all the page tables, allocates new
> page tables and copies the ptes. In principle I would reinvent the wheel
> if we can not use dup_mmap

Well, dup_mm() can't work (and now that I think about it, for more 
reasons -- what if the process has threads?).

I don't think conversion is too bad.  You'd need a four-level loop to 
allocate and convert, and another loop to deallocate in case of error.  
If, as I don't doubt, s390 hardware can modify the ptes, you'd need 
cmpxchg to read and clear a pte in one operation.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
