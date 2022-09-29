Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246B4C6FA82
	for <virtualization@archiver.kernel.org>; Thu, 29 Sep 2022 07:29:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 915D561116;
	Thu, 29 Sep 2022 07:29:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 915D561116
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=2bncyhtE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id teaBWL6RAfZW; Thu, 29 Sep 2022 07:29:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4697361050;
	Thu, 29 Sep 2022 07:29:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4697361050
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28D70C0033;
	Thu, 29 Sep 2022 07:29:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29047C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:29:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EAEFB61050
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:29:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EAEFB61050
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ALa0x3ryYTRY
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:29:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5334E60FA7
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5334E60FA7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:29:46 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id d64so757778oia.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 00:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=3xPteUXlvCrstcAdS5NLzsw3FTQBH03gRmKCfD2Gwgg=;
 b=2bncyhtEscNoscv7X1nzxlhSLGtav35Fv6AYnzJIx9cBraxYpbHcGRGYacEhYmD+m7
 9BfaSiYdQbHEn1SI/0UMYfnV9ZlhMR/bBw1aZLsGZRacTK0JWWaX4gmlFWuBUSwDygY6
 swhYuN9KhJGM59xwrejWuZKW6Vrs3PaTAiO1volef1mdH3627jWSjvUubp5QObIFK4A0
 OyigdzjoX6Rzbod97VrnXcmILgqQOsRfem6P1dhKDrCOEWXxlBAKjJw8U9nxkX1EDzrI
 3w9wun0u4dA3evBFHkX1DxjR4L+UL27/DkczRMMDmojQxxI6TVNurtpBJG8KJOr1b9c7
 15zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=3xPteUXlvCrstcAdS5NLzsw3FTQBH03gRmKCfD2Gwgg=;
 b=g4ZjmXgd8Y8NhqlJuzzT+3zo3r79aVdrWOVUEU/H19SqL7wQruMi9IjRMHT3J7SeQx
 m4vJP6yfTgiCjIazsxDVz6y2QPy7Mv7v4zXBvpbNOl5LtoMr+ZplTNRUS7AuzpMsMB2G
 /hx73eZrGMqxARmK8XBBw0HqxZDRpjBbrH8eZQotf16Lr5yoLdv6823v0Vymka1Y/6qy
 wlUlmdRTU1YPv0kS408jIpWH/9Am7H2/Uo2AMqeyvXjgrUinSc1FiM8p041EgfLaYh9+
 Lq9fbaVPzCFaOlhshg979mLHFF2QEvo1hidQKfo/Yl3G/OgyLFUOCuGmQy4evugXeAdv
 lp2g==
X-Gm-Message-State: ACrzQf2Ze/v21YWyQG4nYLR5zMFWmKrh0Lt1qtuJ7ZQp7hXNt9d88xQp
 CRqfwS3cfG0HZtq0Mh/u3WkI8PuSNcp10enHkgxI3Q==
X-Google-Smtp-Source: AMsMyM6Y23PQngha7Hw9vfJrLPe+MmWbRrt32RBQe2E0uhiyeJlKmqcoGGkLHLoZoe3/D5QoHJvBdXwMdqROYceUWUA=
X-Received: by 2002:a54:410a:0:b0:34f:84d1:b2b3 with SMTP id
 l10-20020a54410a000000b0034f84d1b2b3mr6249034oic.102.1664436585268; Thu, 29
 Sep 2022 00:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220921082729.2516779-1-alvaro.karsz@solid-run.com>
 <YyyfJQo7N/iMPLNP@fedora>
 <CAJs=3_BXGpu-kDq1_bJSanh-iY63uwpc2tZtH6jOYcqBUptsNA@mail.gmail.com>
 <20220928091512-mutt-send-email-mst@kernel.org>
 <CAJs=3_CmKjhS=Y3JHujws9y5KmN-AbSRXTnt1aZOhDzMuK7g3Q@mail.gmail.com>
 <20220929032021-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220929032021-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Thu, 29 Sep 2022 10:29:09 +0300
Message-ID: <CAJs=3_AgfyZkWhwK3pycSs49=k-q+9mpD3pyjG0us+ke60RqmQ@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_blk: add SECURE ERASE command support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
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

> OK so virtio_blk_config->max_discard_seg is unused without
> VIRTIO_BLK_F_DISCARD.


Yes, if I understood the spec correctly,
virtio_blk_config->max_discard_seg is relevant if VIRTIO_BLK_F_DISCARD
is negotiated, and virtio_blk_config->max_secure_erase_seg is relevant
if VIRTIO_BLK_F_SECURE_ERASE is negotiated.

What should I do?
Should I fix the patch?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
