From: Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH 7/8] staging: hv: Convert camel cased struct fields in
 vmbus_packet_format.h to lower cases
Date: Wed, 26 Jan 2011 21:04:01 +0300
Message-ID: <20110126180400.GS2721@bicker>
References: <1296064206-11372-1-git-send-email-haiyangz@microsoft.com>
 <1296064206-11372-2-git-send-email-haiyangz@microsoft.com>
 <1296064206-11372-3-git-send-email-haiyangz@microsoft.com>
 <1296064206-11372-4-git-send-email-haiyangz@microsoft.com>
 <1296064206-11372-5-git-send-email-haiyangz@microsoft.com>
 <1296064206-11372-6-git-send-email-haiyangz@microsoft.com>
 <1296064206-11372-7-git-send-email-haiyangz@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1296064206-11372-7-git-send-email-haiyangz@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: hjanssen@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 26, 2011 at 09:50:05AM -0800, Haiyang Zhang wrote:
> +	VM_PKT_INVALID				= 0x0,
> +	VM_PKT_SYNCH				= 0x1,
> +	VM_PKT_ADD_XFER_PAGESET		= 0x2,
> +	VM_PKT_RM_XFER_PAGESET		= 0x3,
                                          ^^^^
> +	VM_PKT_ESTABLISH_GPADL			= 0x4,
> +	VM_PKT_TEARDOWN_GPADL			= 0x5,
> +	VM_PKT_DATA_INBAND			= 0x6,
> +	VM_PKT_DATA_USING_XFER_PAGES		= 0x7,
> +	VM_PKT_DATA_USING_GPADL			= 0x8,
> +	VM_PKT_DATA_USING_GPA_DIRECT		= 0x9,
> +	VM_PKT_CANCEL_REQUEST			= 0xa,
> +	VM_PKT_COMP			= 0xb,
                                        ^^^^^^
> +	VM_PKT_DATA_USING_ADDITIONAL_PKT	= 0xc,
> +	VM_PKT_ADDITIONAL_DATA			= 0xd


These don't line up with the others.

regards,
dan carpenter
