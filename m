From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 17/20] XEN-paravirt: Add Xen grant table support
Date: Mon, 15 Jan 2007 13:05:56 +0000
Message-ID: <20070115130556.GB4272@ucw.cz>
References: <20070113014539.408244126@goop.org> <20070113014648.925356430@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932489AbXAQPg4@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070113014648.925356430@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi!

>  drivers/xen/core/Makefile |    2
>  drivers/xen/core/gnttab.c |  422 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/xen/gnttab.h      |  105 +++++++++++
>  3 files changed, 528 insertions(+), 1 deletion(-)
...
> ===================================================================
> --- /dev/null
> +++ b/drivers/xen/core/grant_table.c

What is going on? Diffstat does not seem to match the diff.


						Pavel
-- 
Thanks for all the (sleeping) penguins.
