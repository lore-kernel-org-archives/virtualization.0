Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFADAC433FE
	for <virtualization@archiver.kernel.org>; Thu, 21 Apr 2022 14:08:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F88F6117B;
	Thu, 21 Apr 2022 14:08:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id upazXtcDwVPO; Thu, 21 Apr 2022 14:08:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E341060E33;
	Thu, 21 Apr 2022 14:08:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9EABC0033;
	Thu, 21 Apr 2022 14:08:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0789EC002C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 14:08:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 03B1D409DE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 14:08:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t2eSMsGA_KJr
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 14:08:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3FE8D400E4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 14:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650550093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QysMU2yYugYFLYjW2LOfTqqKvlLZq8H2fqc/5Hi2OwA=;
 b=BL/kTCXkRzLD/RiHjxwYTUi6T176psjxwc9l7oLPJ4vhDgjfpQXcQu0g3CGstlEYkJVcln
 m5m2lVTOlOkq7UmZrvHoejZ1Tu2cLIqcaYgZhdx58gPPqWvFKnLE7XkvbvYSuLOzBYdZnG
 HwFNQtDd/Vq+yOU47mQ+hpmfXaoKO+k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-CdkiY8INOj26-ISWh2QGFA-1; Thu, 21 Apr 2022 10:08:12 -0400
X-MC-Unique: CdkiY8INOj26-ISWh2QGFA-1
Received: by mail-ej1-f69.google.com with SMTP id
 sb12-20020a1709076d8c00b006efa121ff38so2553030ejc.16
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 07:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QysMU2yYugYFLYjW2LOfTqqKvlLZq8H2fqc/5Hi2OwA=;
 b=lqKXYR+52urKTfV300RT4UIGoXbN60V5SUug2GVhEp4oBcl1NlSgZI5Kagwn0vzdw5
 UoDF8HburXre4pv0UDm1UMhnCGB7nAJaJXqayXXvuv2eYYdTlhgk3iOS7VqwZzxTJgA0
 1Bw7o/hFPRPp02DJgMg5gyjUjmv6KHBt9lLsZ+w8XdyEpE1NRpL/R/BR+WRVy9meMCH8
 5MpIBIVzOftxrtlWBwtj0IqMEtYAznuXFm1rAGgi/G2ktpM0EjrkOvHpQzdG6dMiu3tb
 zntZEluNT/mnz7a+IKWH8WovsYz9M8W0onRiKaMjPNZZHV79P9fBVSuJQ8kgsEaOUjXw
 3Gdg==
X-Gm-Message-State: AOAM532FFI2AaRaf8LlSS4SqmSzzQ8cj5fC6TpVeKNdfM7hEvnNAJiPc
 ikBNtszF7MpEFFrQVNmUkQxYR7e1eSH1qiDZk+sEw1HG37lJUzw3NTVqOtClicUsGSS3npDpraP
 NEpHkqZdtaH4kYnziyN84AH//qLhQSsg7adY0PFyvqA==
X-Received: by 2002:aa7:d2d6:0:b0:423:97a4:801c with SMTP id
 k22-20020aa7d2d6000000b0042397a4801cmr28374704edr.383.1650550091510; 
 Thu, 21 Apr 2022 07:08:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3UzhXjJKIUWIe+FtmghcBY3LXg/jvh/2MMeLG1JqYitGhX//nK2tUibwxnsLz37Kl67RNDA==
X-Received: by 2002:aa7:d2d6:0:b0:423:97a4:801c with SMTP id
 k22-20020aa7d2d6000000b0042397a4801cmr28374687edr.383.1650550091329; 
 Thu, 21 Apr 2022 07:08:11 -0700 (PDT)
Received: from sgarzare-redhat ([217.171.75.76])
 by smtp.gmail.com with ESMTPSA id
 ee17-20020a056402291100b0041fe1e4e342sm11340261edb.27.2022.04.21.07.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Apr 2022 07:08:10 -0700 (PDT)
Date: Thu, 21 Apr 2022 16:08:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: Re: [PATCH 3/5] hv_sock: Add validation for untrusted Hyper-V values
Message-ID: <20220421140805.qg4cwqhsq5vuqkut@sgarzare-redhat>
References: <20220420200720.434717-1-parri.andrea@gmail.com>
 <20220420200720.434717-4-parri.andrea@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20220420200720.434717-4-parri.andrea@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Wei Liu <wei.liu@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, netdev@vger.kernel.org,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 linux-hyperv@vger.kernel.org, Michael Kelley <mikelley@microsoft.com>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Apr 20, 2022 at 10:07:18PM +0200, Andrea Parri (Microsoft) wrote:
>For additional robustness in the face of Hyper-V errors or malicious
>behavior, validate all values that originate from packets that Hyper-V
>has sent to the guest in the host-to-guest ring buffer.  Ensure that
>invalid values cannot cause data being copied out of the bounds of the
>source buffer in hvs_stream_dequeue().
>
>Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
>---
> include/linux/hyperv.h           |  5 +++++
> net/vmw_vsock/hyperv_transport.c | 11 +++++++++--
> 2 files changed, 14 insertions(+), 2 deletions(-)
>
>diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
>index fe2e0179ed51e..55478a6810b60 100644
>--- a/include/linux/hyperv.h
>+++ b/include/linux/hyperv.h
>@@ -1663,6 +1663,11 @@ static inline u32 hv_pkt_datalen(const struct vmpacket_descriptor *desc)
> 	return (desc->len8 << 3) - (desc->offset8 << 3);
> }
>
>+/* Get packet length associated with descriptor */
>+static inline u32 hv_pkt_len(const struct vmpacket_descriptor *desc)
>+{
>+	return desc->len8 << 3;
>+}
>
> struct vmpacket_descriptor *
> hv_pkt_iter_first_raw(struct vmbus_channel *channel);
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index 8c37d07017fc4..092cadc2c866d 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -577,12 +577,19 @@ static bool hvs_dgram_allow(u32 cid, u32 port)
> static int hvs_update_recv_data(struct hvsock *hvs)
> {
> 	struct hvs_recv_buf *recv_buf;
>-	u32 payload_len;
>+	u32 pkt_len, payload_len;
>+
>+	pkt_len = hv_pkt_len(hvs->recv_desc);
>+
>+	/* Ensure the packet is big enough to read its header */
>+	if (pkt_len < HVS_HEADER_LEN)
>+		return -EIO;
>
> 	recv_buf = (struct hvs_recv_buf *)(hvs->recv_desc + 1);
> 	payload_len = recv_buf->hdr.data_size;
>
>-	if (payload_len > HVS_MTU_SIZE)
>+	/* Ensure the packet is big enough to read its payload */
>+	if (payload_len > pkt_len - HVS_HEADER_LEN || payload_len > HVS_MTU_SIZE)

checkpatch warns that we exceed 80 characters, I do not have a strong 
opinion on this, but if you have to resend better break the condition 
into 2 lines.

Maybe even update or remove the comment? (it only describes the first 
condition, but the conditions are pretty clear, so I don't think it adds 
much).

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
