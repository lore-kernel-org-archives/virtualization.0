From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/1] hv: Update MAINTAINERS
Date: Thu, 1 Dec 2011 14:04:31 -0800
Message-ID: <20111201220431.GA3261@suse.de>
References: <1322776486-17077-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1322776486-17077-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, joe@perches.com, dmitry.torokhov@gmail.com, jkosina@suse.cz, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 01, 2011 at 01:54:46PM -0800, K. Y. Srinivasan wrote:
> Update the MAINTAINERS file to reflect the current state
> of the Hyper-V drivers.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  MAINTAINERS |   25 +++++++++++++++++++++++--
>  1 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3523ab0..db6cee2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3197,6 +3197,27 @@ M:	William Irwin <wli@holomorphy.com>
>  S:	Maintained
>  F:	fs/hugetlbfs/
>  
> +Hyper-V CORE DRIVERS
> +M:	K. Y. Srinivasan <kys@microsoft.com>
> +M:	Haiyang Zhang <haiyangz@microsoft.com>
> +L:	devel@linuxdriverproject.org
> +S:	Maintained
> +F:	drivers/hv/
> +
> +Hyper-V MOUSE DRIVER
> +M:	K. Y. Srinivasan <kys@microsoft.com>
> +M:	Haiyang Zhang <haiyangz@microsoft.com>
> +L:	devel@linuxdriverproject.org
> +S:	Maintained
> +F:	drivers/hid/hid-hyperv.c
> +
> +Hyper-V NETWORK DRIVER
> +M:	K. Y. Srinivasan <kys@microsoft.com>
> +M:	Haiyang Zhang <haiyangz@microsoft.com>
> +L:	devel@linuxdriverproject.org
> +S:	Maintained
> +F:	drivers/net/hyperv/

This whole patch could all be consolidated into one entry, that also
fixes the name of the subsystem to follow the rest of the file format:

HYPER-V CORE AND DRIVERS
M:	K. Y. Srinivasan <kys@microsoft.com>
M:	Haiyang Zhang <haiyangz@microsoft.com>
L:	devel@linuxdriverproject.org
S:	Maintained
F:	drivers/hv/
F:	drivers/hid/hid-hyperv.c
F:	drivers/net/hyperv/
F:	drivers/staging/hv/

Care to redo this?

thanks,

greg k-h
