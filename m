Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4C6C6FD1C
	for <virtualization@archiver.kernel.org>; Wed, 22 Mar 2023 03:34:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8EC7282612;
	Wed, 22 Mar 2023 03:34:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8EC7282612
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NgVA6JC+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SR9x4LD-qld1; Wed, 22 Mar 2023 03:34:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1118B82178;
	Wed, 22 Mar 2023 03:34:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1118B82178
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9934C0071;
	Wed, 22 Mar 2023 03:34:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFCE4C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 03:34:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 940214031F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 03:34:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 940214031F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NgVA6JC+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8ciVcYzejBJj
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 03:34:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D827240198
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D827240198
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 03:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679456090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rEgoe1zFDcLmhk4rxGiMPFPfHT6rEh3EAYPVCGRVzRQ=;
 b=NgVA6JC+blAWGymsfkGaGh4vuEW6ztRhZMAf75FY6hZFUaK9H0a9HIoSLuCTWJnBPyQdW2
 KuUqhxDoInIEzhBjpKAOvroK0/TaAR3kNNCkTfAA1uqiQ8/JOdlhJcb5MaFvu57z4avqnW
 5aelbhkzOEX820t8u4ZhNgJmNUSp7nQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-6rKhV3PqOr-H0lhqtVF38A-1; Tue, 21 Mar 2023 23:34:49 -0400
X-MC-Unique: 6rKhV3PqOr-H0lhqtVF38A-1
Received: by mail-wm1-f71.google.com with SMTP id
 ay12-20020a05600c1e0c00b003ed201dcf71so8051995wmb.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 20:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679456088;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rEgoe1zFDcLmhk4rxGiMPFPfHT6rEh3EAYPVCGRVzRQ=;
 b=12FXMyXclP760X40ZrqZekWumm7R0qTsmarOMuOIE6CgYnSSKG/wLr4SRfx/hRnkU5
 FooAZRHhWCqrV0DrfN5TfTkjJCn76fQDkiFiRtluWSK+kiqF2190thL0s3/sWl4yrLr+
 FfoiV0+VRSd62HU6QD0uRrcvYzAWpcUHxkNyvQf4hrFdlTeMiROJr8wYy/NXBpbopCvQ
 qX4ZsXGpDkI36Spx7OMV9mfQQqxr2UKe9myWJHCwwKGytTJdU1nfxG1ohYXt17RCsb6F
 XWKkDOb5cZa6GZyE/zHFpOebAzlNPtkjvGxJ3bcz3Mnb2vLZIHuy6BoAWPt8tNwrc2IM
 NUXQ==
X-Gm-Message-State: AO0yUKWOihPu6ZO+TClMz5VB7C39wFL5GPUBMir4qv5huGQ2KY50yq34
 HHGkNfJu6YY9aYGMuaPKj0JOxRl9PmvHsYZMC4zUGlWJcZCYrjGASOXJu0iY85MB4+L+M3j7TXG
 iGIFlfF5ZStPVSyCWtZfZBOZQ1s+HGnAQkKPE0FTmOQ==
X-Received: by 2002:adf:e981:0:b0:2c7:a55:bef5 with SMTP id
 h1-20020adfe981000000b002c70a55bef5mr3544123wrm.23.1679456088343; 
 Tue, 21 Mar 2023 20:34:48 -0700 (PDT)
X-Google-Smtp-Source: AK7set+Apq+HPpz2Z8yaQvS6OjyfaVy0S9hujAOKApOdfMAoD3TzIb2fbtsNFWywoo0nKrsHt9X9zg==
X-Received: by 2002:adf:e981:0:b0:2c7:a55:bef5 with SMTP id
 h1-20020adfe981000000b002c70a55bef5mr3544111wrm.23.1679456088062; 
 Tue, 21 Mar 2023 20:34:48 -0700 (PDT)
Received: from redhat.com ([2.52.1.105]) by smtp.gmail.com with ESMTPSA id
 v3-20020adfe4c3000000b002cf8220cc75sm4802911wrm.24.2023.03.21.20.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Mar 2023 20:34:47 -0700 (PDT)
Date: Tue, 21 Mar 2023 23:34:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 0/8] virtio_net: refactor xdp codes
Message-ID: <20230321233325-mutt-send-email-mst@kernel.org>
References: <20230322030308.16046-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230322030308.16046-1-xuanzhuo@linux.alibaba.com>
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

On Wed, Mar 22, 2023 at 11:03:00AM +0800, Xuan Zhuo wrote:
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

I really want to see that code make progress though.
Would it make sense to merge this one through the virtio tree?

Then you will have all the pieces in one place and try to target
next linux.


> Xuan Zhuo (8):
>   virtio_net: mergeable xdp: put old page immediately
>   virtio_net: mergeable xdp: introduce mergeable_xdp_prepare
>   virtio_net: introduce virtnet_xdp_handler() to seprate the logic of
>     run xdp
>   virtio_net: separate the logic of freeing xdp shinfo
>   virtio_net: separate the logic of freeing the rest mergeable buf
>   virtio_net: auto release xdp shinfo
>   virtio_net: introduce receive_mergeable_xdp()
>   virtio_net: introduce receive_small_xdp()
> 
>  drivers/net/virtio_net.c | 615 +++++++++++++++++++++++----------------
>  1 file changed, 357 insertions(+), 258 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
