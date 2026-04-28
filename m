Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6744C19992C
	for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381974; cv=none; b=Rtix+fd7gmxmAdZkjvoflj9wEgmwrkAuq2frgFnwYlc4PtDIv+A8OI6pcvHCmmgILkV7XH7SHsOZESBD+bjZuNDW6rN+9cnHgEocs6UGBG7l54rJHsZjkq6mt9Vgaxv6Z1KWbgAEmQzXoV+vawg9c34y1BrKKDsspXKfsaXUmFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381974; c=relaxed/simple;
	bh=ENP0+US9+uoSMKwsdCFAUa8StYi9uiDiDLxaqDcJiMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hTgNwJlF+bzMinlSNClgHL3oXRIw4NKT0xl7z2k7saEkfjo3GWs7z8AcYFrKu6GjHhmX3Fue0D7e2VSeHZIvsBUtSSIhy1IHoI/Igud9DWb4ThuPfaTYcXzGOEiEFRM55gIaQMGS1dGbZUuNppm/h9+eOCqzRzE4hcGfBlvqE3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q0H/R6oW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0H/R6oW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777381972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7GdUrfWfNS9OpD5GGiftL2t6uJKybTSHgDqr3QHoPs=;
	b=Q0H/R6oWqIPkaU2SCF26uJ+379oAiiPXDxlY/edBIdjKy9qYEuO9WLMxRIEE+wgT55vkgV
	WAnPuIYMnDBzCvHfL0KZU5H5qJH5HY5hG7U+bvK3lzqtQzadd+Qir92iAv4ngdD/oO94ES
	yomSyfrTvIl3Nb/zN7AYc8dJrQADIeQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-cbNoNR_DO7S90TOMCeQ11Q-1; Tue, 28 Apr 2026 09:12:51 -0400
X-MC-Unique: cbNoNR_DO7S90TOMCeQ11Q-1
X-Mimecast-MFC-AGG-ID: cbNoNR_DO7S90TOMCeQ11Q_1777381970
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4362197d1easo9329776f8f.2
        for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 06:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777381970; x=1777986770;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j7GdUrfWfNS9OpD5GGiftL2t6uJKybTSHgDqr3QHoPs=;
        b=KM9SuEjX0w4lLaO9sgg0SkoTuZi7WKSpqg4/BUdnTXZmlNleox6EDc0TM5QAepD8QO
         nr5IaA2/7M93cmZFNlCzR4XSpOrXjbSQPfbLmTw1DXVrwww0MwWHrtgNfu/V818KxIRU
         SJYORC3kW81IgQw9V4wkQGCbbAcg/R/h0CCrdHs5MqnHM1eY4yF7yGalwLzQ7Sfm6Nv7
         7JBXlPjY18qEji78iwblexF3fpd8qaCEUwrqmX4B2vHPTd/uLA4z6dJt4Bn858b72lTc
         BOJuinIIMvQEZDuj6vbGHT1nL9yRuycl6FvP8ZJWdpi2zgje+xDmdYmQK5Bx3nrOMKeJ
         mZ9Q==
X-Forwarded-Encrypted: i=1; AFNElJ9qoqyy6CNSHhl/RO+40PXoDjyV3jkVAFasGmL/0GlbNMNPS+DE8NhMpu6l29n3rsHDwBbnvN3Fb65WMesU3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxADMRkYL1NKKynXXtG0vQZE14P0KAXh/BlWyFySZtxmmH68Ka9
	WDuWzSHadTScPBJz2+IQFhbeSuy3KR5kSL2MYS/nebCeQkWQbxmWXdNPYeVS7Gr11IenP2T85cr
	I0PAHTsVEjk9Y5CAsO/NVZM7IWZiCyu0IqrwK9CBH34qLo4q+WPm3VKb0YUh7Ek9Q/Y7a
X-Gm-Gg: AeBDiev+Fk0YASay7Oa9ZcRXl8br8/9gvGO4zmuopeuwxjqabYNrAzQES8pUAbxMQtm
	ji970zYiRQb891NQZwsbwitL4+u+WKIV3JN5dHTKlSmx9w01YfNSeX6sxBCm+wTnretftWirPVh
	YhQhP6dTSPQ9Cp6dH6bwJjpc0J/+dix3UC+kcBMpLc4j/opTCVebc+J732D46eplH3s1O9ED5uD
	bOd64/llTMlankwcQd37IPKm0PCj0w9Q3LUF0OEbb/FMIurpN5g5JOitLQPSZs02JD0QrvaqOZe
	cqRUodGbEnNVNBmhikaVDK17ZlI5Wq5YJUgx/sekFgJbcQ9KwzL4NNox7Knm/de4zFQkZFvitNQ
	HNtm4IEQU/nLsFtCr/SWzFz85WTDlyvtNb+7bNpSQEV77+oU2GPZINmq/B2u1j/FOwFm4na6fR6
	Kgn+kIIA==
X-Received: by 2002:a05:600c:8b57:b0:489:1a65:dd6e with SMTP id 5b1f17b1804b1-48a77aed628mr53248845e9.8.1777381969868;
        Tue, 28 Apr 2026 06:12:49 -0700 (PDT)
X-Received: by 2002:a05:600c:8b57:b0:489:1a65:dd6e with SMTP id 5b1f17b1804b1-48a77aed628mr53248255e9.8.1777381969380;
        Tue, 28 Apr 2026 06:12:49 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463d02f270sm6398058f8f.9.2026.04.28.06.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:12:48 -0700 (PDT)
Date: Tue, 28 Apr 2026 15:12:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: netdev@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Long Li <longli@microsoft.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Michael Kelley <mhklinux@outlook.com>, Himadri Pandya <himadrispandya@gmail.com>, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hv_sock: fix ARM64 support
Message-ID: <afCxfHKA7hJilGM3@sgarzare-redhat>
References: <20260428125339.13963-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260428125339.13963-1-hamzamahfooz@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ymXBMKIvKNzO2TUMbdX6n4uop9Z0GCdUp5YckMzDNJg_1777381970
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

No version number in the subject?

Please next time follow 
https://docs.kernel.org/process/submitting-patches.html#subject-line

   Common tags might include a version descriptor if the multiple 
   versions of the patch have been sent out in response to comments 
   (i.e., “v1, v2, v3”), or “RFC” to indicate a request for comments.

On Tue, Apr 28, 2026 at 08:53:39AM -0400, Hamza Mahfooz wrote:
>VMBUS ring buffers must be page aligned. Therefore, the current value of
>24K presents a challenge on ARM64 kernels (with 64K pages). So, use
>VMBUS_RING_SIZE() to ensure they are always aligned and large enough to
>hold all of the relevant data.
>
>Cc: stable@vger.kernel.org
>Fixes: 77ffe33363c0 ("hv_sock: use HV_HYP_PAGE_SIZE for Hyper-V communication")
>Tested-by: Dexuan Cui <decui@microsoft.com>
>Reviewed-by: Dexuan Cui <decui@microsoft.com>
>Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
>---
> net/vmw_vsock/hyperv_transport.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index 069386a74557..40f09b23efa3 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -375,10 +375,10 @@ static void hvs_open_connection(struct vmbus_channel *chan)
> 	} else {
> 		sndbuf = max_t(int, sk->sk_sndbuf, RINGBUFFER_HVS_SND_SIZE);
> 		sndbuf = min_t(int, sndbuf, RINGBUFFER_HVS_MAX_SIZE);
>-		sndbuf = ALIGN(sndbuf, HV_HYP_PAGE_SIZE);
>+		sndbuf = VMBUS_RING_SIZE(sndbuf);
> 		rcvbuf = max_t(int, sk->sk_rcvbuf, RINGBUFFER_HVS_RCV_SIZE);
> 		rcvbuf = min_t(int, rcvbuf, RINGBUFFER_HVS_MAX_SIZE);
>-		rcvbuf = ALIGN(rcvbuf, HV_HYP_PAGE_SIZE);
>+		rcvbuf = VMBUS_RING_SIZE(rcvbuf);
> 	}
>
> 	chan->max_pkt_size = HVS_MAX_PKT_SIZE;
>-- 
>2.54.0
>

