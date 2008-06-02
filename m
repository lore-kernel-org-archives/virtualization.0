From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1 of 4] mm: add a ptep_modify_prot
	transaction abstraction
Date: Mon, 2 Jun 2008 13:13:39 +0200
Message-ID: <20080602111339.GB18586@elte.hu>
References: <patchbomb.1212192268@localhost>
	<4deead25e96efc8ca783.1212192269@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <4deead25e96efc8ca783.1212192269@localhost>
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

> +	/* Get the current pte state, but zero it out to make it
> +	   non-present, preventing the hardware from asynchronously
> +	   updating it. */

please use standard and consistent comment style, similar to:

> +/*
> + * Start a pte protection read-modify-write transaction, which
> + * protects against asynchronous hardware modifications to the pte.
> + * The intention is not to prevent the hardware from making pte
> + * updates, but to prevent any updates it may make from being lost.

	Ingo
