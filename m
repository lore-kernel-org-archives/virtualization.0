From: olof@lixom.net (Olof Johansson)
Subject: Re: [PATCH 16/25] xen: Use the hvc console infrastructure for Xen console
Date: Mon, 23 Apr 2007 20:21:11 -0500
Message-ID: <20070424012111.GA28649@lixom.net>
References: <20070423215638.563901986@goop.org> <20070423215712.328111104@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754534AbXDXBVK@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070423215712.328111104@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Gerd Hoffmann <kraxel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 23, 2007 at 02:56:54PM -0700, Jeremy Fitzhardinge wrote:
> Implement a Xen back-end for hvc console.
> 
> From: Gerd Hoffmann <kraxel@suse.de>
> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
> 
> ---
>  arch/i386/xen/Kconfig     |    1 
>  arch/i386/xen/events.c    |    3 -
>  drivers/Makefile          |    3 +
>  drivers/xen/Makefile      |    1 
>  drivers/xen/hvc-console.c |  134 +++++++++++++++++++++++++++++++++++++++++++++
>  include/xen/events.h      |    1 
>  6 files changed, 142 insertions(+), 1 deletion(-)

If you move the driver to drivers/char/hvc_xen.c instead, you won't have to do...

> +#include "../char/hvc_console.h"

...this.

Other single-platform backend hvc drivers are under drivers/char already.


-Olof
