From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/2] Connector: Correctly set the error code in case of
 success when dispatching receive callbacks
Date: Tue, 17 May 2011 15:31:55 -0700
Message-ID: <20110517223155.GC15741@kroah.com>
References: <1305671138-19443-1-git-send-email-kys@microsoft.com>
 <1305671138-19443-2-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1305671138-19443-2-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 17, 2011 at 03:25:38PM -0700, K. Y. Srinivasan wrote:
> The recent changes to the connector code introduced this bug where even
> when a callback was invoked, we would return an error resulting in
> double freeing of the skb. This patch fixes this bug.

By "recent" what do you mean?  Is this something that is in the .39
kernel?  Do you have a git commit id that caused this?

Or is this due to changes that are queued up for the .40 merge window?

thanks,

greg k-h
