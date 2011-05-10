From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 017/206] Staging: hv: Get rid of the indirection for
 invoking io request
Date: Tue, 10 May 2011 03:01:37 -0400
Message-ID: <20110510070137.GA13847@infradead.org>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-17-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1304978288-22999-17-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

> -	ret = storvsc_drv->on_io_request(blkdev->device_ctx,
> +	ret =  storvsc_do_io(blkdev->device_ctx,
>  					   &blkvsc_req->request);

	ret = storvsc_do_io(blkdev->device_ctx, &blkvsc_req->request);
