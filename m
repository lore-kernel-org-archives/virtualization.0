From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/1] Staging: hv: util: Fix a bug in kvp implementation
Date: Tue, 4 Oct 2011 21:37:17 -0700
Message-ID: <20111005043717.GA3918@suse.de>
References: <1317762002-4351-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1317762002-4351-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, longli@microsoft.com, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 04, 2011 at 02:00:02PM -0700, K. Y. Srinivasan wrote:
> The host gurantees that there can be only one kvp transaction active
> against the guest. So, the transaction active state is needed only to
> protect against spurious user level calls. The current code had a race
> condition where the guest could prematurely return because the previous
> transaction state was not cleared - this state was being cleared after
> sending the response to the host and there was a window where the host
> could notify the guest of a new transaction before the transaction active
> state was properly set. 
> Also deal with the case when the user mode component
> does not respond in a timely fashion correctly.
> I would like to thank Long Li <longli@microsoft.com>
> for identifying the problem.

So that would be a "Reported-by:" tag, we don't have a "Diagnosed-by" do
we?

And should this go to the older (i.e. stable) kernels as well?

thanks,

greg k-h
