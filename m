From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] staging: hv: Fix GARP not sent after Quick Migration
Date: Tue, 5 Apr 2011 08:41:33 -0700
Message-ID: <20110405154133.GA30923@suse.de>
References: <1302017268-22913-1-git-send-email-haiyangz@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1302017268-22913-1-git-send-email-haiyangz@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: hjanssen@microsoft.com, kys@microsoft.com, v-abkane@microsoft.com, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Mike Surcouf <mike@surcouf.co.uk>, stable <stable@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 05, 2011 at 08:27:48AM -0700, Haiyang Zhang wrote:
> After Quick Migration, the network is not immediately operational in the
> current context when receiving RNDIS_STATUS_MEDIA_CONNECT event. So, I put
> the netif_notify_peers() into a scheduled work, otherwise GARP packet will
> not be sent after quick migration, and cause network disconnection.

But that's a hypervisor bug, right?  It shouldn't be sending a "connect"
event on the ethernet device if the network really isn't present.  How
about getting it fixed there, which will resolve the issues for all
guest operating systems, not just Linux.

Or, if this is something that the hyperv developers are not going to
fix, we need to document it in the code itself so that people don't try
to remove it in a few years as an "optimization".

thanks,

greg k-h
