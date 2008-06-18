From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 1 of 4] mm: add a ptep_modify_prot
	transaction	abstraction
Date: Wed, 18 Jun 2008 16:59:05 -0700
Message-ID: <4859A149.9090004@goop.org>
References: <b020e42384197b824320.1213615800@localhost>
	<1213831403.8011.24.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <1213831403.8011.24.camel@pasglop>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: benh@kernel.crashing.org
Cc: Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm-devel <kvm-devel@lists.sourceforge.net>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

Benjamin Herrenschmidt wrote:
> On Mon, 2008-06-16 at 04:30 -0700, Jeremy Fitzhardinge wrote:
>   
>> The only current user of this interface is mprotect
>>     
>
> Do you plan to use it with fork ultimately ?
>   

Good point, I'd overlooked that.  I guess that means using it in 
ptep_set_wrprotect().

At present the x86 ptep_set_wrprotect() just uses clear_bit on the pte, 
which is a locked cycle.  Is that significantly cheaper than an xchg + 
set?  (Same number of locked operations...)

    J
