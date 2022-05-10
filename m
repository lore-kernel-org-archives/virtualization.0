Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21249C433F5
	for <virtualization@archiver.kernel.org>; Tue, 10 May 2022 11:22:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE3A260D90;
	Tue, 10 May 2022 11:22:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e65QGIffnwhv; Tue, 10 May 2022 11:22:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5763360B89;
	Tue, 10 May 2022 11:22:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 383D9C0039;
	Tue, 10 May 2022 11:22:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05A1EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 11:22:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DA2F880DF9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 11:22:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ISgIWcQLByRB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 11:22:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3493081249
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 11:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652181743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D4785r27233Ml+uZtnZNjcNdrWzVl9UsExUsQlhNDXI=;
 b=MOuDKwrvOHX+QfW68A7l5HjqPYnQctn/ys3U5an759WvP7zdEjr/axox/XcM/zjCLENbTI
 9gtXT3FrsFA3ZO1+RLuJxO9G2NBBhkIG6qoAMhGi4nBBD+HM6JblL3/SD+Sp5/WKBAAxgD
 o23FyGNszUBPcXX2V5ID5d/cjMispCk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-HeApfzIpOtyBuLviHcIskA-1; Tue, 10 May 2022 07:22:22 -0400
X-MC-Unique: HeApfzIpOtyBuLviHcIskA-1
Received: by mail-wr1-f72.google.com with SMTP id
 u26-20020adfb21a000000b0020ac48a9aa4so6916708wra.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 04:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=D4785r27233Ml+uZtnZNjcNdrWzVl9UsExUsQlhNDXI=;
 b=E127BoOkTOeLLQ1IJcnhd/cHfbAQRbVpkoTTVUB8OE4vkm2PqW6kR1Iu9r/doxfE9b
 iueq7JIaE3kf6dMUK5MM/aPHqrMiiNp/I7qNO9w93w9RijCpaGDEwXdEtrwXcfUUJ/tv
 4YovKEH8P0G42NRygyQzrh24RHH48M49Tx/ggEYERp8eQ/Ts3P3ziZmCXRH0XwzXZrDa
 2xt9FCJGURG/VcjdjkDcA4uFMxCjUmTjFuDYPJCHnU4TgmloILbTTI3Y9ntXS89AOajq
 8IdE5joGfuZLlshXlG9yGYs014SyIHN4iASq0+Rb7RNp9t9UwlZxSzGj7jbT3b7Sedlw
 E7sQ==
X-Gm-Message-State: AOAM531j6fc4o4pZoJrmXiX1vbnRUBCx1dm7o4t9oUcFWOSjb1ByCuTy
 bkCQkXcXRIBHy9Ce1ZNOeHpnvvlfmvXgPtBLtK23fOgDV1Mi0fhnc38isAPmA79LgARhm4rykFL
 STyIRlMx6h8AOVVwSvdGQFCWal3vNn8st+3zg4cYFGg==
X-Received: by 2002:a5d:5051:0:b0:20a:e005:cca3 with SMTP id
 h17-20020a5d5051000000b0020ae005cca3mr17795088wrt.560.1652181741630; 
 Tue, 10 May 2022 04:22:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9tr6mSmtvQ50bZR7deuOD32uuBMCg9W5pDvp0BbCM1/ro5QrbdARz9/itKP70Q+2PP0bUsQ==
X-Received: by 2002:a5d:5051:0:b0:20a:e005:cca3 with SMTP id
 h17-20020a5d5051000000b0020ae005cca3mr17795072wrt.560.1652181741436; 
 Tue, 10 May 2022 04:22:21 -0700 (PDT)
Received: from redhat.com ([2.55.130.230]) by smtp.gmail.com with ESMTPSA id
 q9-20020adfea09000000b0020c5253d8desm13912558wrm.42.2022.05.10.04.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 May 2022 04:22:20 -0700 (PDT)
Date: Tue, 10 May 2022 07:22:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shunsuke Mie <mie@igel.co.jp>
Subject: Re: [RFC PATCH] virtio: fix virtio transitional ids
Message-ID: <20220510072157-mutt-send-email-mst@kernel.org>
References: <20220510102723.87666-1-mie@igel.co.jp>
MIME-Version: 1.0
In-Reply-To: <20220510102723.87666-1-mie@igel.co.jp>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, Zhu Lingshan <lingshan.zhu@intel.com>,
 virtualization@lists.linux-foundation.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, May 10, 2022 at 07:27:23PM +0900, Shunsuke Mie wrote:
> This commit fixes the transitional PCI device ID.
> 
> Fixes: d61914ea6ada ("virtio: update virtio id table, add transitional ids")
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>

Absolutely! I don't understand how I could have missed this.

Applied, thanks!

> ---
>  include/uapi/linux/virtio_ids.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index 80d76b75bccd..7aa2eb766205 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -73,12 +73,12 @@
>   * Virtio Transitional IDs
>   */
>  
> -#define VIRTIO_TRANS_ID_NET		1000 /* transitional virtio net */
> -#define VIRTIO_TRANS_ID_BLOCK		1001 /* transitional virtio block */
> -#define VIRTIO_TRANS_ID_BALLOON		1002 /* transitional virtio balloon */
> -#define VIRTIO_TRANS_ID_CONSOLE		1003 /* transitional virtio console */
> -#define VIRTIO_TRANS_ID_SCSI		1004 /* transitional virtio SCSI */
> -#define VIRTIO_TRANS_ID_RNG		1005 /* transitional virtio rng */
> -#define VIRTIO_TRANS_ID_9P		1009 /* transitional virtio 9p console */
> +#define VIRTIO_TRANS_ID_NET		0x1000 /* transitional virtio net */
> +#define VIRTIO_TRANS_ID_BLOCK		0x1001 /* transitional virtio block */
> +#define VIRTIO_TRANS_ID_BALLOON		0x1002 /* transitional virtio balloon */
> +#define VIRTIO_TRANS_ID_CONSOLE		0x1003 /* transitional virtio console */
> +#define VIRTIO_TRANS_ID_SCSI		0x1004 /* transitional virtio SCSI */
> +#define VIRTIO_TRANS_ID_RNG		0x1005 /* transitional virtio rng */
> +#define VIRTIO_TRANS_ID_9P		0x1009 /* transitional virtio 9p console */
>  
>  #endif /* _LINUX_VIRTIO_IDS_H */
> -- 
> 2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
