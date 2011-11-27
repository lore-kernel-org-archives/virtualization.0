From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/1] Staging: hv: mousevsc: Remove the mouse driver from
 the staging tree
Date: Sat, 26 Nov 2011 17:00:59 -0800
Message-ID: <20111127010059.GA19285@kroah.com>
References: <1322285308-3507-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1322285308-3507-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, joe@perches.com, dmitry.torokhov@gmail.com, jkosina@suse.cz
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 25, 2011 at 09:28:28PM -0800, K. Y. Srinivasan wrote:
> The mouse driver for Hyper-V is a HID compliant mouse driver.
> Now that all relevant review comments have been addressed,
> Jiri has agreed to merge this mouse driver into 3.3 hid.git.
> This patch takes care of removing the mouse driver from the
> staging area. Greg, if you can ack this patch, Jiri will proceed
> with his merge.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

Nice job.

greg k-h
