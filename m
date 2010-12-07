From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 3/3]: An implementation of HyperV KVP functionality
Date: Tue, 7 Dec 2010 15:13:42 -0800
Message-ID: <20101207231342.GB27988@suse.de>
References: <4CFE5342020000300009175A@novprvoes0310.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <4CFE5342020000300009175A@novprvoes0310.provo.novell.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Ky Srinivasan <ksrinivasan@novell.com>
Cc: devel@driverdev.osuosl.org, Haiyang Zhang <haiyangz@microsoft.com>, Virtualization@lists.osdl.org, Zbr@ioremap.net, Stephen Hemminger <shemminger@vyatta.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 07, 2010 at 03:31:14PM -0700, Ky Srinivasan wrote:
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux.trees.git/drivers/staging/hv/hv_kvp.c	2010-12-07 07:05:39.000000000 -0500
> @@ -0,0 +1,356 @@
> +/*
> + * An implementation of key value pair (KVP) functionality for Linux.
> + *
> + *
> + * Copyright (C) 2010, Novell, Inc.
> + * Author : K. Y. Srinivasan <ksrinivasan@novell.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.

This is fine.

> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
> + * NON INFRINGEMENT.  See the GNU General Public License for more
> + * details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.

These two paragraphs are not needed.

Especially if the FSF moves again, you don't want to have to go and
patch all old files in the kernel.

thanks,

greg k-h
