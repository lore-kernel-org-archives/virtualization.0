From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH]: Staging: hv: Allocate the vmbus irq dynamically
Date: Fri, 18 Feb 2011 13:14:23 -0800
Message-ID: <20110218211423.GH796@kroah.com>
References: <1297799735-25917-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1297799735-25917-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 15, 2011 at 11:55:35AM -0800, K. Y. Srinivasan wrote:
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Hank Janssen <hjanssen@microsoft.com>

You didn't run this through checkpatch.pl.

Please do so and fix the warning it gives you.

thanks,

greg k-h
