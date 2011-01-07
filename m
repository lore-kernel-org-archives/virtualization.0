From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/1] staging: hv: Removed unneeded call to
 netif_stop_queue() in hv_netvsc
Date: Fri, 7 Jan 2011 09:31:39 -0800
Message-ID: <20110107173139.GA12343@suse.de>
References: <1294421139-18657-1-git-send-email-hjanssen@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1294421139-18657-1-git-send-email-hjanssen@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hank Janssen <hjanssen@microsoft.com>
Cc: linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Abhishek Kane <v-abkane@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 07, 2011 at 09:25:39AM -0800, Hank Janssen wrote:
> From: Hank Janssen <hjanssen@microsoft.com>
> 
> Removed the call to netif_stop_queue() in netvsc_probe() as
> the queue is not initialized at that point and further call
> to it after queue initialization is really not necessary.
> 
> This change was prompted after an upstream change went into 
> 2.6.37 (netif_tx_stop_queue) that now checks if netif_stop_queue
> is called before register with netdev is done.
> 
> This will eliminate the warning message to the log when hv_netvsc
> driver starts up.
> 
> Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Hank Janssen <hjanssen@microsoft.com>

What kernel is this needed for, .37?  .38?  older than .37?

thanks,

greg k-h
