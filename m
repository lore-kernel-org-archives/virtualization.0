From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] staging: hv: use sync_bitops when interacting with the
 hypervisor
Date: Thu, 7 Apr 2011 15:46:29 -0700
Message-ID: <20110407224629.GA28700@suse.de>
References: <1302216598-686-1-git-send-email-haiyangz@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1302216598-686-1-git-send-email-haiyangz@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: hjanssen@microsoft.com, kys@microsoft.com, v-abkane@microsoft.com, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Olaf Hering <olaf@aepfle.de>, stable <stable@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 07, 2011 at 03:49:58PM -0700, Haiyang Zhang wrote:
> From: Olaf Hering <olaf@aepfle.de>
> 
> Locking is required when tweaking bits located in a shared page, use the
> sync_ version of bitops. Without this change vmbus_on_event() will miss
> events and as a result, vmbus_isr() will not schedule the receive tasklet.
> 
> Backported to 2.6.32 stable kernel by Haiyang Zhang <haiyangz@microsoft.com>

Thanks for the backport, now queued up.

greg k-h
