From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 2 of 4] paravirt: add hooks
	for	ptep_modify_prot_start/commit
Date: Mon, 02 Jun 2008 12:57:00 +0100
Message-ID: <4843E00C.1080407@goop.org>
References: <patchbomb.1212192268@localhost>
	<5bed0127be5f509fd686.1212192270@localhost>
	<20080602111249.GA18586@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20080602111249.GA18586@elte.hu>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm-devel <kvm-devel@lists.sourceforge.net>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Hugh Dickins <hugh@veritas.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
>   
>> +#define  __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
>>     
>
> please turn this into CONFIG_ARCH_HAS_PTEP_MODIFY_PROT_TRANSACTION 
> instead.

The __HAVE_ARCH_ form is consistent with all the other conditional 
things in asm/pgtable.h, like __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS, 
__HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG, etc.  I don't think adding 
CONFIG_ARCH_HAS_ for this one case is a good idea.

    J
