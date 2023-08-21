Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665CCEE4996
	for <virtualization@archiver.kernel.org>; Mon, 21 Aug 2023 14:47:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D90574088A;
	Mon, 21 Aug 2023 14:47:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D90574088A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=nzOfc/+3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9XpjMfIyZhz4; Mon, 21 Aug 2023 14:47:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0BFA0405A4;
	Mon, 21 Aug 2023 14:47:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0BFA0405A4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB423C0071;
	Mon, 21 Aug 2023 14:47:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B27BDC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Aug 2023 14:47:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8AF58405CE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Aug 2023 14:47:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8AF58405CE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yle3yRKqm5Vv
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Aug 2023 14:46:59 +0000 (UTC)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9104D405A4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Aug 2023 14:46:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9104D405A4
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-64cca551ae2so14356986d6.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Aug 2023 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692629218; x=1693234018;
 h=content-transfer-encoding:mime-version:subject:references
 :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WuA3TdNjVttC4ENEMTU7iIB13TPKbbPgEw4DfONfOIg=;
 b=nzOfc/+3vPkk+2xcoHixT2qig/KVfSfruaE8oC/BHOhj4Vj8zK9wQl/YBsovUfjuyE
 zzdUfx0F+1nY+xEONrt5yI8FWOp1QrAohZ3IkYZyY94D8Nb0lF63snqV0onxX8UJbdRS
 W1OENcVQ/wPS91JuWs6rzqCuSYu2pCwXc2MvCLhv1xAQf/GW34/3Xok29hzwDsUcEWri
 K6RBfHFWHDQw3zBVPMEemIuhjd5J2WirIGF8kiJIV2fCCwk1JLsGdgid8sas/T3c1R7D
 ClfsowvOP6bADW4XnuMdfydqJvFH70N4COIOkZ7NSD8UaocdbL6/2rMcwVI7BOjmq2gJ
 pIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692629218; x=1693234018;
 h=content-transfer-encoding:mime-version:subject:references
 :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WuA3TdNjVttC4ENEMTU7iIB13TPKbbPgEw4DfONfOIg=;
 b=cJ4UvUBqopHActT3hc3/W80GVu2U9hRDuFVEHoWL0j6DCDRaIUuBGN5jeYYCCpCtJd
 7ZPrf7GLTpJ8laJbhjRf2pBWdEsa+SehyIvU/RFSBtMEYKBKvAQ8bne5MN5Dr0V5fXEp
 vTMdDNAEo+DSVCjBznxI2MxAv4LLTpLoH3zmDQ1ebVn1OYNAs5erykBjmMHXoQOvJ37T
 0DyxqTJv0aL0j6kni3kBcDF6P6YoIS4M9kF1ratPaR1/h8W+r7Qts/BiKHZ/XfNvears
 od9uHnJ4KZYsnbEt2IT1TPIxQOYBqbscMqDY4+Es7IiYYvWzpi4hgbntodKgAj+V8bsT
 k70A==
X-Gm-Message-State: AOJu0YxCye6e85YFg6rF7TH9RiRrz0kp2LKE42bVhmX3kaiUWIjj/MjW
 /qzssLf3qAzimC/x0EVgn6Q=
X-Google-Smtp-Source: AGHT+IG/I4x/uX5zBHwBZnZQvnI1/jXeEL+zKtLEb5rhbvBKzlFssu9Ud/GZZNrEpLvz+FrLSwB56A==
X-Received: by 2002:a0c:e084:0:b0:64f:3e27:1e4a with SMTP id
 l4-20020a0ce084000000b0064f3e271e4amr3752794qvk.19.1692629218377; 
 Mon, 21 Aug 2023 07:46:58 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com.
 [35.245.174.172]) by smtp.gmail.com with ESMTPSA id
 t3-20020a0ce2c3000000b0064729e5b2d9sm2950385qvl.14.2023.08.21.07.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 07:46:58 -0700 (PDT)
Date: Mon, 21 Aug 2023 10:46:57 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Feng Liu <feliu@nvidia.com>, virtualization@lists.linux-foundation.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <64e378e1c7fed_1b7a7294fd@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230821142713.5062-1-feliu@nvidia.com>
References: <20230821142713.5062-1-feliu@nvidia.com>
Subject: Re: [PATCH net-next v3] virtio_net: Introduce skb_vnet_common_hdr to
 avoid typecasting
Mime-Version: 1.0
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>
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

Feng Liu wrote:
> The virtio_net driver currently deals with different versions and types
> of virtio net headers, such as virtio_net_hdr_mrg_rxbuf,
> virtio_net_hdr_v1_hash, etc. Due to these variations, the code relies
> on multiple type casts to convert memory between different structures,
> potentially leading to bugs when there are changes in these structures.
> 
> Introduces the "struct skb_vnet_common_hdr" as a unifying header
> structure using a union. With this approach, various virtio net header
> structures can be converted by accessing different members of this
> structure, thus eliminating the need for type casting and reducing the
> risk of potential bugs.
> 
> For example following code:
> static struct sk_buff *page_to_skb(struct virtnet_info *vi,
> 		struct receive_queue *rq,
> 		struct page *page, unsigned int offset,
> 		unsigned int len, unsigned int truesize,
> 		unsigned int headroom)
> {
> [...]
> 	struct virtio_net_hdr_mrg_rxbuf *hdr;
> [...]
> 	hdr_len = vi->hdr_len;
> [...]
> ok:
> 	hdr = skb_vnet_hdr(skb);
> 	memcpy(hdr, hdr_p, hdr_len);
> [...]
> }
> 
> When VIRTIO_NET_F_HASH_REPORT feature is enabled, hdr_len = 20
> But the sizeof(*hdr) is 12,
> memcpy(hdr, hdr_p, hdr_len); will copy 20 bytes to the hdr,
> which make a potential risk of bug. And this risk can be avoided by
> introducing struct skb_vnet_common_hdr.
> 
> Change log
> v1->v2
> feedback from Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> feedback from Simon Horman <horms@kernel.org>
> 1. change to use net-next tree.
> 2. move skb_vnet_common_hdr inside kernel file instead of the UAPI header.
> 
> v2->v3
> feedback from Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> 1. fix typo in commit message.
> 2. add original struct virtio_net_hdr into union
> 3. remove virtio_net_hdr_mrg_rxbuf variable in receive_buf;
> 
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

A similar solution as tpacket_uhdr.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
