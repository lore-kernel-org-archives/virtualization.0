Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDCFC64EC4
	for <virtualization@archiver.kernel.org>; Mon,  6 Mar 2023 16:49:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A22E4813CD;
	Mon,  6 Mar 2023 16:49:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A22E4813CD
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=aTRhtOKz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KtDzvaGuUuya; Mon,  6 Mar 2023 16:49:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6F1D2813B6;
	Mon,  6 Mar 2023 16:49:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F1D2813B6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4860DC0071;
	Mon,  6 Mar 2023 16:49:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27707C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 16:49:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 02B664046D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 16:49:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 02B664046D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=aTRhtOKz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HcTHRaoJ3NjW
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 16:49:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4DE3540108
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4DE3540108
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 16:49:27 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id a9so11046095plh.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Mar 2023 08:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1678121366;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FyzVPjWfXnTi2A6JA+vLWl/vlGfJCkJsgnI57YCj2dk=;
 b=aTRhtOKzopegMmO2yssOZkimSjssIB1Fe4aC8HZEsD3OR5cnh4N2g7iuSqfDbS9K5N
 CS8TVBVdeQZqQfD3dFmdVX3QUkxzNkaZ5MaF35ZM6wNjohaLBeFCivpxT+cs4mnddsN1
 4TMJT+ngEmiRar/0a7wziePefj2s334WYFD1cml4bH29b/21M17Q0ZMzTPan6WcmWTyV
 9z+EsmcrSJrphT/ZIbuuL729qCpqvNQLIwNflHSDPWKS/qjn5RYl046inEUlPM8721Bx
 ifkSjYxCj6fWSgL9rgRzzT4NIF7Zp898TfP7yV3sl2SLv2TiV5V89riysdMyUhr4XQ+t
 SKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678121366;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FyzVPjWfXnTi2A6JA+vLWl/vlGfJCkJsgnI57YCj2dk=;
 b=51XJ1ts7PW0jj/WckkEhGBdtTSdzdUTnQi1K9EP9sSXJLjIQ0HuxNSykce+RHV7TDq
 f+Eu6ZE3BBZ1kIeeTShzGYIXoaY3u82AdNoxYCx2bVTrNnO4tSCMT+jzdCNGd8xlFmck
 ZJmWrHGZi2G9KFtjs0vtfm8T0OGR+Ya0WKLOzrwINOpTiSJGzDnp/KJTeI+N+2rh05bR
 ErtII7Pb8pUvAXO3E8h1Fmjt/YyKAgVqOauWYKoIK8NEiyVyoT+17F0c4CrojHimVLSw
 XtWGzi23tcyQNchzhHI6TGXwnFC3tUmLLzXbQhak10Cms2pkcdKuu/1OCJRq1LWbJDbF
 R52Q==
X-Gm-Message-State: AO0yUKXt7ieFs2b3Poo1A3xqmPB63mAVyScYTMR27bqLXeKjrLf5VC1W
 7xqioLVBltRprhW4f00y6Ek=
X-Google-Smtp-Source: AK7set/tAvMHEOLBgk/J+TSbInWJpoBAIk9fk2swfjHlWNVo4lmtt2y54TjkH+Sact5n0jkX8+6sNA==
X-Received: by 2002:a17:902:d4cd:b0:19e:23c1:4c3d with SMTP id
 o13-20020a170902d4cd00b0019e23c14c3dmr14086927plg.2.1678121366695; 
 Mon, 06 Mar 2023 08:49:26 -0800 (PST)
Received: from [192.168.0.128] ([98.97.39.127])
 by smtp.googlemail.com with ESMTPSA id
 jy11-20020a17090342cb00b0019cbd37a335sm6962692plb.93.2023.03.06.08.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Mar 2023 08:49:26 -0800 (PST)
Message-ID: <3507f6a501688243d1f16ef65753acc40b9e85aa.camel@gmail.com>
Subject: Re: [PATCH net 0/2] add checking sq is full inside xdp xmit
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Date: Mon, 06 Mar 2023 08:49:24 -0800
In-Reply-To: <20230306041535.73319-1-xuanzhuo@linux.alibaba.com>
References: <20230306041535.73319-1-xuanzhuo@linux.alibaba.com>
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
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

On Mon, 2023-03-06 at 12:15 +0800, Xuan Zhuo wrote:
> If the queue of xdp xmit is not an independent queue, then when the xdp
> xmit used all the desc, the xmit from the __dev_queue_xmit() may encounter
> the following error.
> 
> net ens4: Unexpected TXQ (0) queue failure: -28
> 
> This patch adds a check whether sq is full in XDP Xmit.
> 
> Thanks.
> 
> Xuan Zhuo (2):
>   virtio_net: separate the logic of checking whether sq is full
>   virtio_net: add checking sq is full inside xdp xmit
> 
>  drivers/net/virtio_net.c | 78 ++++++++++++++++++++++++----------------
>  1 file changed, 47 insertions(+), 31 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f
> 

Series looks good to me.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
