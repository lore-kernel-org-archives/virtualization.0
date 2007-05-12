From: Bastian Blank <bastian@waldi.eu.org>
Subject: Re: [Xen-devel] [patch 19/28]xen: Add early printk support via hvc console
Date: Sat, 12 May 2007 21:08:13 +0200
Message-ID: <20070512190813.GA17757@wavehammer.waldi.eu.org>
References: <20070511000643.025196000@goop.org> <20070511001204.948444000@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758754AbXELTI3@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070511001204.948444000@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, Xen-devel <xen-devel@lists.xensource.com>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 10, 2007 at 05:07:02PM -0700, Jeremy Fitzhardinge wrote:
> +#ifdef CONFIG_XEN

xenboot_console is only available with CONFIG_HVC_XEN.

> +	} else if (!strncmp(buf, "xen", 3)) {
> + 		early_console = &xenboot_console;
> +#endif
