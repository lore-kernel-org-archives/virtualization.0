Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4690BC04E69
	for <virtualization@archiver.kernel.org>; Wed, 16 Aug 2023 14:53:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9927F416BF;
	Wed, 16 Aug 2023 14:53:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9927F416BF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=hJ0JNR07
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uau4jUePCgEX; Wed, 16 Aug 2023 14:53:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 05F66414C6;
	Wed, 16 Aug 2023 14:53:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 05F66414C6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8AEBC0071;
	Wed, 16 Aug 2023 14:53:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42A89C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 14:53:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 125B242059
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 14:53:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 125B242059
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20221208 header.b=hJ0JNR07
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h-1l96I-hUT4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 14:53:41 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C943440382
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 14:53:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C943440382
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-76d70fb1369so40894685a.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 07:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692197619; x=1692802419;
 h=content-transfer-encoding:mime-version:subject:references
 :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C/F+yO89r+58XA2jTJmqFV7AKNI1UXlByvHmUmA3sA4=;
 b=hJ0JNR07O6hNfvI0xZ2K57RdwwA+zhGGvgN1u5MeIJpwg2g6A38rxQYYtjMTc+DrIQ
 OQKQIzsh/kXj6LBcKPZHjh6TDJjQoyZR9sv/ZFs1MrH/0YQbtE8WdYpPg89JB9m9u9j8
 y/u5h/wRwaSktqnNv6AeWOnq16To/G5M8xOsJ4xwE5+6U03REY4mPgeLMapCOdBPycHL
 JEq5/GHZ+7CMff1ABYwHMm7pYN1NFal7znvXjmINFymH4O7Fe5T77dnWF9Ir/tCqjnF7
 mqH+Pdma8Ou779VNhqk7dP7ET2SKLB2szR+/7oxYyeGGm6ZxG5QXiGhmus7LtSaOPOCl
 7lcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692197619; x=1692802419;
 h=content-transfer-encoding:mime-version:subject:references
 :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=C/F+yO89r+58XA2jTJmqFV7AKNI1UXlByvHmUmA3sA4=;
 b=UGjd3VjCLorrz33VIZB7VR2kPYZCvP5le1jO3n2gT5aVzIO+R0rKBLXFVtf+zDdR5N
 ukH1ppmiQ+DYXk9WQFrm9DzUSahc5qbWQHeoYyMJpHSGzLI2xhH3gVoT7jfXu1K82VEi
 QP9Z/ksAVtJpwRq+1kQGInGjSeCENNAFbunvpo8IecUfGURp4BR6wYbw2xaEFxjAJKg+
 S3nmiJcvYFNhKDduSJ3BNmkbSjMc5iBdGz/9c2L3EhOZsOA1RgbKHkjEap7uQHPitvW2
 7NJeUVYNVU8p6/KOwPWVigKaVs53Q4ddJbULj8hcGObty8BDk8IJ/2nwa4ZVBIDrH2dL
 0f9A==
X-Gm-Message-State: AOJu0Yzq4PJU3lN/uU3XHc+C0i85QbmqPCIjqw8tX5GDAiRDD1bYQ8W8
 IU51+ZUNNnDZBnqcSEYbOT4=
X-Google-Smtp-Source: AGHT+IE/ongpvCQd3F2ohVavPqcLH2c3ICTQBale59UpK8GdXCBun10dc4tTmVJGODuMRW1RyyVMpQ==
X-Received: by 2002:a05:620a:b8d:b0:76c:9ad6:8199 with SMTP id
 k13-20020a05620a0b8d00b0076c9ad68199mr1789963qkh.77.1692197619528; 
 Wed, 16 Aug 2023 07:53:39 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com.
 [35.245.174.172]) by smtp.gmail.com with ESMTPSA id
 f23-20020a05620a15b700b0076cf0c4eecbsm4469821qkk.0.2023.08.16.07.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 07:53:38 -0700 (PDT)
Date: Wed, 16 Aug 2023 10:53:38 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Feng Liu <feliu@nvidia.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Simon Horman <horms@kernel.org>
Message-ID: <64dce2f2b99f5_23f1f82949f@willemb.c.googlers.com.notmuch>
In-Reply-To: <f9f3c150-2b5e-7bd0-1c1a-062bd1f16fcd@nvidia.com>
References: <20230814171845.65930-1-feliu@nvidia.com>
 <ZNtYpohWyjnb883M@vergenet.net>
 <05348d62-586c-4b1f-40bd-5541caca0947@nvidia.com>
 <ZNunz1hbqPKpcOgA@vergenet.net>
 <CAF=yD-L+d34Uuvt3sOFOnxXhMmoMXNfHzcaSPk=t1PtiPUHZ1g@mail.gmail.com>
 <f9f3c150-2b5e-7bd0-1c1a-062bd1f16fcd@nvidia.com>
Subject: Re: [PATCH net v1] virtio_net: Introduce skb_vnet_common_hdr to avoid
 typecasting
Mime-Version: 1.0
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
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

> > 
> > Since legacy virtio will no longer be modified, I don't think there is
> > much value is exposing this new union as UAPI. I do appreciate the
> > benefit to the implementation.
> > 
> > [1] https://patches.linaro.org/project/netdev/patch/20210208185558.995292-3-willemdebruijn.kernel@gmail.com/
> Hi, William and Simon
> 
> Thanks for the detailed explanation.
> 
> I kept virtio_net_hdr_mrg_rxbuf and virtio_net_hdr_v1_hash structures in 
> virtio_net.h, which can be forward compatible with existing user 
> applications which use these structures.

They're UAPI, so we cannot modify or remove them anyway.

Which is exactly why we want to be careful with adding anything new.
 
> virtio_net_hdr_v1_hash cannot use virtio_net_hdr as the first member, 
> because in virtio_net_hdr_v1, csum_start and csum_offset are stored in 
> union as a structure, and virtio_net_hdr cannot be used instead.

Oh right. That wasn't always the case, or the reason for this.
Not super relevant but, commit ed9ecb0415b9 has the history

    virtio: Don't expose legacy net features when VIRTIO_NET_NO_LEGACY defined.

    In particular, the virtio header always has the u16 num_buffers field.
    We define a new 'struct virtio_net_hdr_v1' for this (rather than
    simply calling it 'struct virtio_net_hdr', to avoid nasty type errors
    if some parts of a project define VIRTIO_NET_NO_LEGACY and some don't.

    Transitional devices (which can't define VIRTIO_NET_NO_LEGACY) will
    have to keep using struct virtio_net_hdr_mrg_rxbuf, which has the same
    byte layout as struct virtio_net_hdr_v1.

The union was added to overload csum use on tx with RSC use on rx, in
commit 22b436c9b568. I don't quite follow why there now are three
structs, rather than two. The first two seem to both implement csum
partial. Anyway, not super important here.

> In addition, I put this new structure virtio_net_common_hdr in uapi, 
> hoping it could be used in future user space application to avoid 
> potential risks caused by type coercion (such as the problems mentioned 
> in the patch description ). So I think it should be in this header file.
> What do you think?

Adding anything to UAPI has a high bar. Do you have a concrete use
case for this?

This does seem mostly a helper to simplify kernel logic to me, which
is better kept in non-UAPI headers.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
