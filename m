From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 5/5] staging: hv: Gracefully handle SCSI resets - RESEND
Date: Wed, 01 Sep 2010 09:28:53 -0700
Message-ID: <1283358535.1797.174.camel@Joe-Laptop>
References: <4C7D4848.6090409@sailtheuniverse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C7D4848.6090409@sailtheuniverse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hank Janssen <hjanssen@sailtheuniverse.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, devel@driverdev.osuosl.org, haiyangz@microsoft.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2010-08-31 at 11:22 -0700, Hank Janssen wrote:
> If we get a SCSI host bus reset we now gracefully handle it, and we 
> take the device offline. This before sometimes caused hangs.
> ---
>  drivers/staging/hv/storvsc.c |   36 +++++++++++++++++++++++++++++++++++-
[]
> +	/*
> +	 * Wait for traffic in transit to complete
> +	 */
> +	while (atomic_read(&storDevice->NumOutstandingRequests))
> +		udelay(1000);
> +

Is it useful to have a maximum check or timeout?
Maybe use usleep_range?
