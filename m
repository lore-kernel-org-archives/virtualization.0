From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/6] Staging: hv: vmbus_drv.c Replaced DPRINT with native
	pr_XXX
Date: Wed, 23 Feb 2011 11:11:35 -0800
Message-ID: <20110223191135.GA1030@kroah.com>
References: <1298417565-12356-1-git-send-email-hjanssen@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1298417565-12356-1-git-send-email-hjanssen@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Hank Janssen <hjanssen@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, devel@linuxdriverproject.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 22, 2011 at 03:32:40PM -0800, Hank Janssen wrote:
> This group of patches removes all DPRINT from hv_vmbus.ko.
> It is divided in several patches due to size.

Why say this in the 1/6 patch?  It should be in the 0/6 introduction.

> 
> All DPRINT calls have been removed, and where needed have been
> replaced with pr_XX native calls. Many debug DPRINT calls have
> been removed outright.

I think a lot of these pr_XX calls can be switched to dev_XX calls
instead, right?

How about you break this up into a different series of patches to make
it more readable:
	- remove unneeded DPRINT calls
	- convert remaining DPRINT calls to pr_XX or dev_XX as needed

That would make it easier to review, as it is, it's quite difficult.

thanks,

greg k-h
