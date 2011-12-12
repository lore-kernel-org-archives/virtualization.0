From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0000/0004] Drivers: hv: Fixes
Date: Mon, 12 Dec 2011 14:28:01 -0800
Message-ID: <20111212222801.GA16054@kroah.com>
References: <1323710931-29616-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1323710931-29616-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Dec 12, 2011 at 09:28:51AM -0800, K. Y. Srinivasan wrote:
> Some fixes to the vmbus driver:
> 
> 	1. Fix a memory leak in a failure path.
> 
> 	2. Make vmbus driver unloadable.
> 
> 	3. Get rid of an unnecessary check in hv_init()
> 	   in preparation for supporting kexec().
> 
> 	4. Make it possible to build the vmbus driver as part of the
> 	   kernel. This patch was submitted earlier, but seems to have been 
> 	   lost.

No, it was not lost, it was applied to my driver-core-next tree a while
ago.  Because of this, I had to hand-edit patch 2 above and skip patch 4
here.

greg k-h
