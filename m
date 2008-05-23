From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 0 of 4] mm+paravirt+xen: add pte
	read-modify-write abstraction
Date: Fri, 23 May 2008 21:42:23 +0100
Message-ID: <48372C2F.1090704@goop.org>
References: <patchbomb.1211552448@localhost>
	<alpine.LFD.1.10.0805231133130.3081@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <alpine.LFD.1.10.0805231133130.3081@woody.linux-foundation.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm-devel <kvm-devel@lists.sourceforge.net>, Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

Linus Torvalds wrote:
> On Fri, 23 May 2008, Jeremy Fitzhardinge wrote:
>   
>> This series adds the pte_rmw_start() and pte_rmw_commit() operations,
>> which change this sequence to:
>>
>> 	ptent = pte_rmw_start(mm, addr, pte);
>> 	ptent = pte_modify(ptent, newprot);
>> 	/* ... */
>> 	pte_rmw_commit(mm, addr, pte, ptent);
>>     
>
> Can you please rename these.
>
> It's not a general "read-modify-write" operation on the PTE, and this 
> *only* works for changing protection details. In particular, you cannot 
> use pte_rmw_start/commit to change the actual page. So it's very much 
> about just protection bits.
>   

Well, you could use it to update the page and protection bits while 
preserving the AD bits, but I don't think that's very useful.

> It should probably also be called ptep_xyz(), since it takes a pte 
> pointer, not a pte.
>
> So maybe calling it "ptent = ptep_modify_prot_start(..)" ... 
> "ptep_modify_prot_commit(..)" or something.
>   

Yep, sounds fine to me.

    J
