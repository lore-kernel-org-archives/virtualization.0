From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] staging: hv: Fix GARP not sent after Quick Migration
Date: Tue, 5 Apr 2011 09:23:06 -0700
Message-ID: <20110405162306.GA1800@kroah.com>
References: <1302020655-27133-1-git-send-email-haiyangz@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1302020655-27133-1-git-send-email-haiyangz@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: hjanssen@microsoft.com, kys@microsoft.com, v-abkane@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, stable <stable@kernel.org>, Mike Surcouf <mike@surcouf.co.uk>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 05, 2011 at 09:24:15AM -0700, Haiyang Zhang wrote:
> After Quick Migration, the network is not immediately operational in the
> current context when receiving RNDIS_STATUS_MEDIA_CONNECT event. So, I put
> the netif_notify_peers() into a scheduled work, otherwise GARP packet will
> not be sent after quick migration, and cause network disconnection.

Wait, what are you relying on here for the delay?  What happens when
processors get faster and that work queue gets run even sooner than
today?  You are relying on the scheduler to introduce a "delay" here and
you can't rely on that at all.

Instead, use a proper timer as you do know how long you need to wait,
right?  Don't abuse workqueues for something they were not designed for.

thanks,

greg k-h
