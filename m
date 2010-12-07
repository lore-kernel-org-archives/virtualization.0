From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2/3]: An implementation of HyperV KVP functionality
Date: Tue, 7 Dec 2010 15:12:54 -0800
Message-ID: <20101207231254.GA27988@suse.de>
References: <4CFE5204020000300009174C@novprvoes0310.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4CFE5204020000300009174C@novprvoes0310.provo.novell.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ky Srinivasan <ksrinivasan@novell.com>
Cc: devel@driverdev.osuosl.org, Haiyang Zhang <haiyangz@microsoft.com>, Virtualization@lists.osdl.org, Zbr@ioremap.net, Stephen Hemminger <shemminger@vyatta.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 07, 2010 at 03:25:56PM -0700, Ky Srinivasan wrote:
> This patch is re-based on the latest linux-next tree.
> 
> From: K. Y. Srinivasan <ksrinivasan@novell.com>
> 
> Subject: The hv_utils module will be composed of more than one file;
> rename hv_utils.c to accommodate this without changing the module name.
> 
> Signed-off-by: K. Y. Srinivasan <ksrinivasan@novell.com>
> 


Please put the diffstat of the patch in below the signed-off-by: and
after a --- line.


> Index: linux.trees.git/drivers/staging/hv/Makefile
> ===================================================================
> --- linux.trees.git.orig/drivers/staging/hv/Makefile	2010-12-07 07:04:41.000000000 -0500
> +++ linux.trees.git/drivers/staging/hv/Makefile	2010-12-07 08:00:10.000000000 -0500
> @@ -10,3 +10,4 @@ hv_vmbus-y := vmbus_drv.o osd.o \
>  hv_storvsc-y := storvsc_drv.o storvsc.o
>  hv_blkvsc-y := blkvsc_drv.o blkvsc.o
>  hv_netvsc-y := netvsc_drv.o netvsc.o rndis_filter.o
> +hv_utils-y := hv_util.o
> Index: linux.trees.git/drivers/staging/hv/hv_util.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux.trees.git/drivers/staging/hv/hv_util.c	2010-12-07 08:00:10.000000000 -0500

Are you renaming the file here?  Are you using git?  If so, it should
produce a patch that shows the rename happened, not this big 'remove it
all and then add it back' type thing.

thanks,

greg k-h
