From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] paravirt: VDSO page is essential
Date: Mon, 5 Mar 2007 14:38:28 +0100
Message-ID: <20070305133828.GA29200@elte.hu>
References: <20070305120631.GA14105@elte.hu> <1173101297.26165.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932364AbXCENrI@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1173101297.26165.39.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>, Andi Kleen <ak@suse.de>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org


* Rusty Russell <rusty@rustcorp.com.au> wrote:

> -#ifdef CONFIG_PARAVIRT
> +#if defined(CONFIG_COMPAT_VDSO) && defined(CONFIG_RESERVE_TOP)

NACK - my patch is quite a bit simpler and yours only increases the
#ifdef jungle. If there's any complication of the VDSO coming from some
other hypervisor support patch then I will judge that in full context, 
when it's submitted. Meanwhile, my patch is a must-have for v2.6.21.

	Ingo
