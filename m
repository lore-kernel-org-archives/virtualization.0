From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 00/22] Staging: hv: Cleanup-storage-drivers-phase-III
Date: Mon, 4 Apr 2011 21:59:04 -0700
Message-ID: <20110405045904.GA4635@kroah.com>
References: <1301331615-26226-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1301331615-26226-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: devel@linuxdriverproject.org, gregkh@suse.de, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 28, 2011 at 10:00:15AM -0700, K. Y. Srinivasan wrote:
> This patch-set deals with some of the style isues in blkvsc_drv.c. We also
> get rid most of the "dead code" in this file:
> 
> 	1) Get rid of most of the forward declarations in this file.
> 	   The only remaining forward declarations are to deal with 
> 	   circular dependencies.
> 
> 	2) Get rid of most of the dead code in the file. Some of
> 	   the functions in this file are place holders - they are not
> 	   fuly implementedi yet (blkvsc_ioctl(), blkvsc_media_changed(). 
> 	   We have retained some comments/dead code, to help us in the
> 	   final implementation.

For some reason, this patch series fails to apply after the first one.
So I've not applied any of them, care to resync and resend?

thanks,

greg k-h
