From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 020/117] Staging: hv: vmbus: Support the notion of id
 tables in vmbus_match()
Date: Fri, 15 Jul 2011 22:02:50 -0400
Message-ID: <20110716020250.GA7199@infradead.org>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-20-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1310752065-27895-20-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 15, 2011 at 10:46:08AM -0700, K. Y. Srinivasan wrote:
> +static bool is_not_null_guid(const __u8 *guid)
> +{
> +	int i;
> +
> +	for (i = 0; i < (sizeof(struct hv_vmbus_device_id)); i++)
> +		if (guid[i] != 0)
> +			return true;
> +	return false;
> +}

would be nice to add uuid_{le,be}_is_nil helpers to uuid.h.  I also
think simply using a memcpy might be more efficient than the hand-rolled
loop.
