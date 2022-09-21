Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FF8C32771
	for <virtualization@archiver.kernel.org>; Wed, 21 Sep 2022 06:52:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0B8B408D8;
	Wed, 21 Sep 2022 06:52:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B0B8B408D8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=rg8cDotN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nYVke39sJhhc; Wed, 21 Sep 2022 06:52:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D6AF6402C1;
	Wed, 21 Sep 2022 06:52:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D6AF6402C1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD65FC0033;
	Wed, 21 Sep 2022 06:52:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53D4CC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 06:52:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2914B81B35
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 06:52:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2914B81B35
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=rg8cDotN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GSqj8FQ-FnQb
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 06:52:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 782C581947
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 782C581947
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 06:52:11 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 s14-20020a17090a6e4e00b0020057c70943so13243254pjm.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 23:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=TuLNBnV8qaazQgcsoaFid5VZfSqd2xd9TIKtxXOnL4A=;
 b=rg8cDotNuP+r0x1omegquNtOUzX8R1u/LO+EpWodK/dz4JzScuD6kA39TYBLe84k7a
 ESuG/MJ1P7MyHADMR+Juu8Qg4vvAnhIraMCum0KNeRDUMiCGtWvdNa3TnENshrMFWmS2
 jzXDKEv5b4SUsj1pUYQYpvmf5V+iaMSqhCt+3tMUv8I3uC+4h2gKul09Tvr6s2ZbAplN
 nUIeBUsYM6xqj0o2cq9yKY1uv1XDknx5vYp97lOmB4mucVY4bZAo2qxdoAfvPSS+2hQ/
 81eTRRBR8cj7+14RHBeeQDKUh0f5M1fC9JOUeQ3n5958OkXcSUHg0ZM8IZFzJZz5Eu5W
 K7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=TuLNBnV8qaazQgcsoaFid5VZfSqd2xd9TIKtxXOnL4A=;
 b=Gf9JGcpxe0rWeEcz5qvJQ2KvFheKv2DptMIZfmMeuBJBKjNcDiyAErv+H88tmo8BpK
 1UQGOQPtekPtyKKA4IALDIU3JHaKVAHo0bc9CWsENiiXzbI9jDz0NPcZUqGAIOVCGCho
 hnOynUHAy+EhZOfZfXt6x40SEPzaa7N9go59aGiZKVW678lPI3UMkc2w/dc9rWXMJnjH
 nVI0OCOLxlyuGVHY0diCPE7OFlCNqGvgXYzpX8Pf2mUTUIRasn1iwzULPaoeiv6FfAVi
 ToYA/YeZWo1dubCzOLOXDUoXTYIaoBev3xIvBsOYNvKM03AJ0G9Z7NbC/0GsGbD5n03P
 3b8Q==
X-Gm-Message-State: ACrzQf270sb5a4oyGL5Bjjl1xSFzNBS0+cqglh1zogOgzWHRD+KlVu4+
 BBrq9/1HxcOzoX4vcGd2rwM6Yc9SxrqJnujJUW7IzA==
X-Google-Smtp-Source: AMsMyM6gw1Z3AUjr7ruUNHt5zl75UTIIKT/It1XQ4ZaItqmLSqlYd6FOKqLt+IU4A8Z0HCBpGU/ToMLg9xKoZrMziFk=
X-Received: by 2002:a17:903:1c5:b0:178:44cd:e9c with SMTP id
 e5-20020a17090301c500b0017844cd0e9cmr3407040plh.132.1663743130846; Tue, 20
 Sep 2022 23:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220829082313.419220-1-alvaro.karsz@solid-run.com>
 <Yyin8zSKJb3GPFno@fedora>
 <CAJs=3_ASjr0DF9MTvS=P-ZeJpC4nAH+2vkTjWROzQbS+mvLU4Q@mail.gmail.com>
 <YyoCXOwRE7NLxTTH@fedora>
In-Reply-To: <YyoCXOwRE7NLxTTH@fedora>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Wed, 21 Sep 2022 09:51:35 +0300
Message-ID: <CAJs=3_Dn9B-p4R-TdAjnw_HeF3DLzrgFv47_bjD5M4wWu+BQWw@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_blk: add SECURE ERASE command support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
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

> Okay, I have replied in the max_secure_erase_seg sub-thread. I think
> probing the device should fail if the value is 0. There are no existing
> non-compliant devices that we need to be compatible with - let's
> encourage device implementors to report usable max_secure_erase_seg
> values.

Ok, I will include it in the new version.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
