From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 4/4] A daemon to gather guest specific information for KVP
Date: Wed, 8 Dec 2010 14:37:00 -0800
Message-ID: <20101208223700.GA7068@suse.de>
References: <4CFFA57702000030000918E9@novprvoes0310.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <4CFFA57702000030000918E9@novprvoes0310.provo.novell.com>
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

How about:
	Subject: [PATCH 4/4] Staging: hv: add userspace daemon code to control key/value connection to the kernel

On Wed, Dec 08, 2010 at 03:34:15PM -0700, Ky Srinivasan wrote:
> >From 718eed47e4c2eb740dc04a6729c8853424ac6965 Mon Sep 17 00:00:00 2001
> From: ksrinivasan <ksrinivasan@novell.com>
> Date: Wed, 8 Dec 2010 14:10:35 -0700
> 
> This daemon gathers all the guest specific information needed to support the
> HyperV KVP functionality. This daemon communicates with the kernel
> component via a netlink channel.
> 
> 
> Signed-off-by: ksrinivasan <ksrinivasan@novell.com>

Wrong name :(


> ---
>  drivers/staging/hv/tools/hv_kvp_daemon.c |  470 ++++++++++++++++++++++++++++++
>  1 files changed, 470 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/staging/hv/tools/hv_kvp_daemon.c
> 
> diff --git a/drivers/staging/hv/tools/hv_kvp_daemon.c b/drivers/staging/hv/tools/hv_kvp_daemon.c
> new file mode 100644
> index 0000000..f5a2dd6
> --- /dev/null
> +++ b/drivers/staging/hv/tools/hv_kvp_daemon.c
> @@ -0,0 +1,470 @@
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

You left in these two paragraphs, which aren't needed.

thanks,

greg k-h
