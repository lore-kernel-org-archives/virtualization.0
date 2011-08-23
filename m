From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0000/0117] Staging: hv: Driver cleanup
Date: Tue, 23 Aug 2011 16:11:20 -0700
Message-ID: <20110823231120.GP9641@kroah.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1310752024-27854-1-git-send-email-kys@microsoft.com>
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

On Fri, Jul 15, 2011 at 10:47:04AM -0700, K. Y. Srinivasan wrote:
> Further cleanup of the hv drivers. Back in June I had sent two patch
> sets to address these issues. I have addressed the comments I got from
> the community on my earlier patches here:
> 
> 	1) Implement code for autoloading the vmbus drivers without using PCI or DMI
> 	   signatures. I have implemented this based on Greg's feedback on my earlier
> 	   implementation.
> 
> 	2) Cleanup error handling across the board and use standard Linux error codes.
> 
> 	3) General cleanup
> 
> 	4) Some bug fixes.
> 
> 	5) Cleanup the reference counting mess for both stor and net devices.
> 
> 	6) Handle all block devices using the storvsc driver. I have modified
> 	   the implementation here based on Christoph's feedback on my earlier
> 	   implementation.
> 
> 	7) Accomodate some host side scsi emulation bugs.
> 
> 	8) In case of scsi errors off-line the device.

Care to respin this patch series based on my comments?

thanks,

greg k-h
