Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C384C433EF
	for <virtualization@archiver.kernel.org>; Wed, 27 Apr 2022 13:38:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6A5660F79;
	Wed, 27 Apr 2022 13:38:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UcqwG3X9N--U; Wed, 27 Apr 2022 13:38:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 677F360EE7;
	Wed, 27 Apr 2022 13:38:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EC44C0032;
	Wed, 27 Apr 2022 13:38:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB700C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 13:38:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BBA9283EEF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 13:38:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eAU22L1JZnzi
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 13:38:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EB47183E1C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 13:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651066716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pASs2MCvHDKO6IuV9YUAJxKscoYhMe+WGgBrqsLgpeA=;
 b=fGWs2UipOXI0bq5z5BTx/krWoXgrYR4zEVGekhtofcbbdrdFhC+p3azkKTScqUpTZyR/pP
 gTyqtLzuDnTB8v/g7ZE4BHYs69NrR2f/JR4ylsmhnckUEuxocCx7C07xX+dTUUHWVDDk+O
 n6MCL6A6cmoSZhrPzNc3x5KVAOFeZ3w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-RrsVz6CEP_qg-4TPUrf7JA-1; Wed, 27 Apr 2022 09:38:35 -0400
X-MC-Unique: RrsVz6CEP_qg-4TPUrf7JA-1
Received: by mail-wm1-f72.google.com with SMTP id
 d13-20020a05600c3acd00b0038ff865c043so2843081wms.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 06:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pASs2MCvHDKO6IuV9YUAJxKscoYhMe+WGgBrqsLgpeA=;
 b=YE4MBKqVG+gNZ0IrXWaQ6iKkwHSSmZFv8wwLPXgB+nP1ZAf7fJ02FEqaBbp+LlMEMY
 WElogr/EVf6CxLWYAllOQ9UprwKT3/uiRzFElakp0nRWp3/FCMjmVBTVtf5YpwH+1Uzc
 AsjiqbeGnX34K5/6ZBhXw2kOe7UnEOWPKYPSloP3GV49DGAZyq9/DfI4LJAHvyVzxh8K
 KSPau22THFTCCKrd+CQBk1eMJK42Zpr60mGh2ibbd2GPBVFvBlMpwM2CZbo2oc2Kc5Zm
 GHvOcVt2+LRKGJP15zqOKRPeIejdnwKTlM+BaVz+HbuJVatFumyA+eutOEGCjT+P5LDN
 v5WQ==
X-Gm-Message-State: AOAM533PPq8joYyu/GhLtwrA3+4PGTHy/4wRH/k5h+PXAnt26j3eGE1J
 EeyuDZMEVXwi3PWPym83GxwE2DW9qdu0KLxht2JchjVgDPdJrtD9URkN9bVn/smrMnX1q/2maKN
 Nts3MdbKGxaGcj2eEkAhGKPVQij/XLGzqYvABC2XY9A==
X-Received: by 2002:a1c:19c1:0:b0:393:a19f:8f95 with SMTP id
 184-20020a1c19c1000000b00393a19f8f95mr25986323wmz.149.1651066714167; 
 Wed, 27 Apr 2022 06:38:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyZHIKV3c3j9uqHgcGZ8eA8TvBTNFbmTsiNROeafQbnIh2surKm1WpizXdg1ibVysWg5ZlMw==
X-Received: by 2002:a1c:19c1:0:b0:393:a19f:8f95 with SMTP id
 184-20020a1c19c1000000b00393a19f8f95mr25986295wmz.149.1651066713905; 
 Wed, 27 Apr 2022 06:38:33 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-234.retail.telecomitalia.it.
 [87.11.6.234]) by smtp.gmail.com with ESMTPSA id
 n38-20020a05600c502600b00393d946aef4sm1548556wmr.10.2022.04.27.06.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Apr 2022 06:38:32 -0700 (PDT)
Date: Wed, 27 Apr 2022 15:38:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: Re: [PATCH v2 3/5] hv_sock: Add validation for untrusted Hyper-V
 values
Message-ID: <20220427133829.w5biauq2omc5xvuu@sgarzare-redhat>
References: <20220427131225.3785-1-parri.andrea@gmail.com>
 <20220427131225.3785-4-parri.andrea@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20220427131225.3785-4-parri.andrea@gmail.com>
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

On Wed, Apr 27, 2022 at 03:12:23PM +0200, Andrea Parri (Microsoft) wrote:
>For additional robustness in the face of Hyper-V errors or malicious
>behavior, validate all values that originate from packets that Hyper-V
>has sent to the guest in the host-to-guest ring buffer.  Ensure that
>invalid values cannot cause data being copied out of the bounds of the
>source buffer in hvs_stream_dequeue().
>
>Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
>Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>---
> include/linux/hyperv.h           |  5 +++++
> net/vmw_vsock/hyperv_transport.c | 10 ++++++++--
> 2 files changed, 13 insertions(+), 2 deletions(-)
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
>index 8c37d07017fc4..fd98229e3db30 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -577,12 +577,18 @@ static bool hvs_dgram_allow(u32 cid, u32 port)
> static int hvs_update_recv_data(struct hvsock *hvs)
> {
> 	struct hvs_recv_buf *recv_buf;
>-	u32 payload_len;
>+	u32 pkt_len, payload_len;
>+
>+	pkt_len = hv_pkt_len(hvs->recv_desc);
>+
>+	if (pkt_len < HVS_HEADER_LEN)
>+		return -EIO;
>
> 	recv_buf = (struct hvs_recv_buf *)(hvs->recv_desc + 1);
> 	payload_len = recv_buf->hdr.data_size;
>
>-	if (payload_len > HVS_MTU_SIZE)
>+	if (payload_len > pkt_len - HVS_HEADER_LEN ||
>+	    payload_len > HVS_MTU_SIZE)
> 		return -EIO;
>
> 	if (payload_len == 0)
>-- 
>2.25.1
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
