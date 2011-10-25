From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/1] Staging: hv: vmbus: Support building the vmbus
 driver as part of the kernel
Date: Tue, 25 Oct 2011 04:27:17 +0200
Message-ID: <20111025022717.GA32457@kroah.com>
References: <1319488265-26936-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1319488265-26936-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Oct 24, 2011 at 01:31:05PM -0700, K. Y. Srinivasan wrote:
> Modify the way we initialize the vmbus driver so that all the hyper-v drivers
> can be linked with the kernel and still ensure that the vmbus driver
> is fully initialized before the drivers that depend upon the vmbus 
> driver attempt to initialize.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Any reason you sent this out twice?  Was there a difference between the
two versions that I missed?

greg k-h
