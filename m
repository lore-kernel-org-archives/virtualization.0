From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 4/4] x86 paravirt_ops: binary patching infrastructure
Date: Mon, 7 Aug 2006 07:38:13 +0200
Message-ID: <200608070738.13768.ak@muc.de>
References: <1154925835.21647.29.camel@localhost.localdomain> <1154926048.21647.35.camel@localhost.localdomain> <1154926114.21647.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751083AbWHGFka@vger.kernel.org>
In-Reply-To: <1154926114.21647.38.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.osdl.org
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Monday 07 August 2006 06:48, Rusty Russell wrote:

>  
> +#ifdef CONFIG_PARAVIRT
> +void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *end)

It would be better to merge this with the existing LOCK prefix patching
or perhaps the normal alternative() patcher (is there any particular
reason you can't use it?)

Three alternative patching mechanisms just seems to be too many

-Andi
