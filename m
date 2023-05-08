Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353E0C77B75
	for <virtualization@archiver.kernel.org>; Mon,  8 May 2023 06:18:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB5D5605EE;
	Mon,  8 May 2023 06:18:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB5D5605EE
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QdLKK1Yq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P_h3vEuf4pq4; Mon,  8 May 2023 06:18:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3E077605A2;
	Mon,  8 May 2023 06:18:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3E077605A2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16DF9C0037;
	Mon,  8 May 2023 06:18:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F256EC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:18:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D94E6410BA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:18:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D94E6410BA
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QdLKK1Yq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QaACfd_hl-EN
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:18:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DD567409B4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DD567409B4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 06:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683526701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=twNVqqauWglNgKKrdFKUfRfF/HMwG9acwMp36woonWA=;
 b=QdLKK1Yq4DZzwj30AfcpFlPiUX7mYgIcN71LSWMtblcFFzpOtCne1gjdbHNKzcqAxlUfU1
 QEequIAVpabYOsgPModDbzoa5jxX6FMnRSd9lVCE94MMuYqRyjzCfLJSHkirPRDDRs1EQH
 XLn1llykN5gbS12quweVCz68/Sj1tLE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-HUPrrE6_MMW_InDfTtlokQ-1; Mon, 08 May 2023 02:18:20 -0400
X-MC-Unique: HUPrrE6_MMW_InDfTtlokQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30634323dfeso1438982f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 07 May 2023 23:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683526699; x=1686118699;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=twNVqqauWglNgKKrdFKUfRfF/HMwG9acwMp36woonWA=;
 b=Nketle53B85GfSA8723cgFedgJwgts68ZLAiDMn9UCfuaP09eLeYd03GaTcEfrDBqi
 80KI2oYb1ISXFSgzL8P2ntvgH6tdmtr88gD/C7mhHIes1VTwDAi1iOYY0L6BQJXTDl2W
 BsdxMqxVEMepYV8TWWNFH5mDNQDcbTITimEubqMAPNysLEmpnRa1W6qiP3DldtEs1hUL
 6hwqhn+y1YDuw9r8/meRHoZYVFiigbIv14nwxUwVzYgmBf5AmC4qIn+nAZSenHXSBbCT
 lgTc4obu6sQgCjP8JsW0xMeuarbKtbgrUgPeezAg7MV80FF+Cd3ylH+LFFCNkM25zAHV
 Azhg==
X-Gm-Message-State: AC+VfDy9b9KpSO5VsjkjI5+5CNcBzi6tHO+kCLlh134gLcnhQCnZ69Zo
 wxBYdWObQ4tEUuwVLHhnNyuRAgMSDYc+2TxlnUQ3jhjf+xHPcEDPubwKlKxaAHWbGLmpqfSi6ZQ
 t+1YcnYPO9IAnFs99sMCEXF3ud/cj52Te0BOi7P8JRQ==
X-Received: by 2002:a5d:43c4:0:b0:307:6278:611a with SMTP id
 v4-20020a5d43c4000000b003076278611amr6983779wrr.21.1683526699119; 
 Sun, 07 May 2023 23:18:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4xKmKhnerUW03D9p2QkXzZlk0/X16EpWQ6gzcG7QI5oWBVZfiaRw8SsukRANFbpIHqbmlbaA==
X-Received: by 2002:a5d:43c4:0:b0:307:6278:611a with SMTP id
 v4-20020a5d43c4000000b003076278611amr6983764wrr.21.1683526698837; 
 Sun, 07 May 2023 23:18:18 -0700 (PDT)
Received: from redhat.com ([2.52.158.28]) by smtp.gmail.com with ESMTPSA id
 e1-20020adffc41000000b003063c130ef1sm10238380wrs.112.2023.05.07.23.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 May 2023 23:18:18 -0700 (PDT)
Date: Mon, 8 May 2023 02:18:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 00/15] virtio_net: refactor xdp codes
Message-ID: <20230508021807-mutt-send-email-mst@kernel.org>
References: <20230508061417.65297-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230508061417.65297-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Mon, May 08, 2023 at 02:14:02PM +0800, Xuan Zhuo wrote:
> Due to historical reasons, the implementation of XDP in virtio-net is relatively
> chaotic. For example, the processing of XDP actions has two copies of similar
> code. Such as page, xdp_page processing, etc.
> 
> The purpose of this patch set is to refactor these code. Reduce the difficulty
> of subsequent maintenance. Subsequent developers will not introduce new bugs
> because of some complex logical relationships.
> 
> In addition, the supporting to AF_XDP that I want to submit later will also need
> to reuse the logic of XDP, such as the processing of actions, I don't want to
> introduce a new similar code. In this way, I can reuse these codes in the
> future.
> 
> Please review.
> 
> Thanks.

Series:

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> v5:
>     1. replace "double counting" by "code duplication"
> 
> v2:
>     1. re-split to make review more convenient
> 
> v1:
>     1. fix some variables are uninitialized
> 
> 
> 
> 
> Xuan Zhuo (15):
>   virtio_net: mergeable xdp: put old page immediately
>   virtio_net: introduce mergeable_xdp_get_buf()
>   virtio_net: optimize mergeable_xdp_get_buf()
>   virtio_net: introduce virtnet_xdp_handler() to seprate the logic of
>     run xdp
>   virtio_net: separate the logic of freeing xdp shinfo
>   virtio_net: separate the logic of freeing the rest mergeable buf
>   virtio_net: virtnet_build_xdp_buff_mrg() auto release xdp shinfo
>   virtio_net: introduce receive_mergeable_xdp()
>   virtio_net: merge: remove skip_xdp
>   virtio_net: introduce receive_small_xdp()
>   virtio_net: small: remove the delta
>   virtio_net: small: avoid code duplication in xdp scenarios
>   virtio_net: small: remove skip_xdp
>   virtio_net: introduce receive_small_build_xdp
>   virtio_net: introduce virtnet_build_skb()
> 
>  drivers/net/virtio_net.c | 657 +++++++++++++++++++++++----------------
>  1 file changed, 384 insertions(+), 273 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
