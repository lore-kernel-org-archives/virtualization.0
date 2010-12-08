From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2/4] Rename the file hv_utils.c
Date: Wed, 8 Dec 2010 14:34:00 -0800
Message-ID: <20101208223400.GB6714@suse.de>
References: <4CFFA39202000030000918CC@novprvoes0310.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <4CFFA39202000030000918CC@novprvoes0310.provo.novell.com>
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

For the subject on the rest of the patches they would look like:
	Subject: [PATCH 2/4] Staging: hv: rename hv_utils.c to hv_util.c

Note the "Staging: hv:" prefix.

On Wed, Dec 08, 2010 at 03:26:10PM -0700, Ky Srinivasan wrote:
> >From 453acddcf55f1e68c5baf9dc5e8f601d18de15b0 Mon Sep 17 00:00:00 2001
> From: ksrinivasan <ksrinivasan@novell.com>
> Date: Wed, 8 Dec 2010 12:24:58 -0700
> 
> The hv_utils module will be composed of more than one file.
> Rename hv_utils.c to accommodate this without changing the module name.
> 
> 
> Signed-off-by: ksrinivasan <ksrinivasan@novell.com>

Again, use your full name.

thanks,

greg k-h
