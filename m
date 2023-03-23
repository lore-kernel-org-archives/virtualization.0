Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF160C6FD1C
	for <virtualization@archiver.kernel.org>; Thu, 23 Mar 2023 05:41:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6375241DD3;
	Thu, 23 Mar 2023 05:41:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6375241DD3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kd4Nr4ZZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cnToWDYhX6XM; Thu, 23 Mar 2023 05:41:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 18DA741DC8;
	Thu, 23 Mar 2023 05:41:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 18DA741DC8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3AE3C0071;
	Thu, 23 Mar 2023 05:41:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7072C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 05:40:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BEC2141DC8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 05:40:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BEC2141DC8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qRSBvPBYyjf3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 05:40:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4D6F841D96
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4D6F841D96
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 05:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679550056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D8WMSh/aQ+eAzT9IfV/3va57SyXLtifjECFun3hDE68=;
 b=Kd4Nr4ZZ2vPWUYQbwSM3kBk/sHoQV/SQjloPxdEM15C5sRZFOTerbBEADuHHeP0xe5fI6r
 zkxUr5QLSJU5GFv2v+VFFiVxRrFPsKyIw77VryiFbCy7n4/htBj0AG2kUNvbYMNlzEiLQ0
 6Ntea6FaMcWif4sn/BA+cvxmRJLs4j0=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-CQIov2NJP_mOQPUFAgwtKA-1; Thu, 23 Mar 2023 01:40:55 -0400
X-MC-Unique: CQIov2NJP_mOQPUFAgwtKA-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-177c9cc7db5so11096024fac.15
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 22:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679550054;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D8WMSh/aQ+eAzT9IfV/3va57SyXLtifjECFun3hDE68=;
 b=brawYXOMAEz2MfiRxjxqk4dklieNReDbd+4CzfxqVu5H2DFNuWT+iZ2k3UwZmWbibq
 wgUF1yrM5+i0pzQh7R5gjaAv8RBBbkaO52m4WbncXwqO+ana+iyR1Rlrt74zOLlOp8ug
 kBgHqal+RisptjRwOiaHu/5DXFWG2jtbs1brFoz9GeEKENk63HVwLU2ys7cPHrLjbN53
 jfmNyExUwbTsbUGYrSf98HHGU8siDRkM6LaaojDWbOjRBmad6uWX3pBAnNBf7s5eJr/T
 wlsX4Dn5PmWY568qoQZH/5MnTtq3f5YQiGD41uxPcEhzg4u8AFlCXVk4QqYzgvePvnb9
 BIsQ==
X-Gm-Message-State: AAQBX9eMLpHgXIAIHNT8jvg5wn6KsjJYbFHsU16+MPwMtN0qVQ+ub/UC
 rQ23XBHVDEcVspaml17cTgq4vh4hf4Ba5stUeSWFjVm7ZdWNRFpzhQcORgVehPtodnGc/fy6Luv
 zU/wlgpT+KiGg0Nj39CfF/zYTIMVKlltwVTr3H/hgiQtNv+bunKtHpWT4Zw==
X-Received: by 2002:a05:6871:8f14:b0:177:83f7:351c with SMTP id
 zz20-20020a0568718f1400b0017783f7351cmr593757oab.9.1679550054428; 
 Wed, 22 Mar 2023 22:40:54 -0700 (PDT)
X-Google-Smtp-Source: AK7set9g1YSjMDMQC+7+4yeX/CPsFYBSYAc0A6erI1PPIA4fosMlO2u/x57fcKvYMnvLOFEHYjlSjRzQvBThlEzDl9M=
X-Received: by 2002:a05:6871:8f14:b0:177:83f7:351c with SMTP id
 zz20-20020a0568718f1400b0017783f7351cmr593745oab.9.1679550054237; Wed, 22 Mar
 2023 22:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230322030308.16046-1-xuanzhuo@linux.alibaba.com>
 <20230322030308.16046-3-xuanzhuo@linux.alibaba.com>
 <c7749936-c154-da51-ccfb-f16150d19c62@huawei.com>
 <1679535924.6219428-2-xuanzhuo@linux.alibaba.com>
 <215e791d-1802-2419-ff59-49476bcdcd02@huawei.com>
In-Reply-To: <215e791d-1802-2419-ff59-49476bcdcd02@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Mar 2023 13:40:43 +0800
Message-ID: <CACGkMEv=0gt6LS0HSgKELQqnWfQ2UdFgAKdvh=CLaAPLeNytww@mail.gmail.com>
Subject: Re: [PATCH net-next 2/8] virtio_net: mergeable xdp: introduce
 mergeable_xdp_prepare
To: Yunsheng Lin <linyunsheng@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

> >
> >>
> >> Also, it seems better to split the xdp_linearize_page() to two functions
> >> as pskb_expand_head() and __skb_linearize() do, one to expand the headroom,
> >> the other one to do the linearizing.
> >
> > No skb here.
>
> I means following the semantics of pskb_expand_head() and __skb_linearize(),
> not to combine the headroom expanding and linearizing into one function as
> xdp_linearize_page() does now if we want a better refoctor result.

Not sure it's worth it, since the use is very specific unless we could
find a case that wants only one of them.

Thanks

>
> >
> >
> >>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
