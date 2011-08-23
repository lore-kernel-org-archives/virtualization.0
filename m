From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/8] Staging: hv: vmbus: Driver cleanup
Date: Tue, 23 Aug 2011 16:18:50 -0700
Message-ID: <20110823231850.GD9955@kroah.com>
References: <1313446210-10611-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1313446210-10611-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: devel@linuxdriverproject.org, gregkh@suse.de, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 15, 2011 at 03:10:10PM -0700, K. Y. Srinivasan wrote:
> Further cleanup of the vmbus driver:
> 
> 	1) Cleanup the interrupt handler by inlining some code. 
> 
> 	2) Ensure message handling is performed on the same CPU that
> 	   takes the vmbus interrupt. 
> 
> 	3) Check for events before messages (from the host).
> 
> 	4) Disable auto eoi for the vmbus interrupt since Linux will eoi the
> 	   interrupt anyway. 
> 
> 	5) Some general cleanup.

As I didn't apply your other changes, care to respin all of your
outstanding hv patches against the next linux-next release and resend
them?  I tried picking some of the other patches, but they started not
applying easily so it would be easier for everyone to just resend them
after you fix them up.

thanks,

greg k-h
