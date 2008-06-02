From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2 of 4] paravirt: add hooks for
	ptep_modify_prot_start/commit
Date: Mon, 2 Jun 2008 13:12:49 +0200
Message-ID: <20080602111249.GA18586@elte.hu>
References: <patchbomb.1212192268@localhost>
	<5bed0127be5f509fd686.1212192270@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <5bed0127be5f509fd686.1212192270@localhost>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm-devel <kvm-devel@lists.sourceforge.net>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Hugh Dickins <hugh@veritas.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> +#define  __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION

please turn this into CONFIG_ARCH_HAS_PTEP_MODIFY_PROT_TRANSACTION 
instead.

	Ingo
