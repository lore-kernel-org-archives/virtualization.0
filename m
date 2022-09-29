Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69546C07E9D
	for <virtualization@archiver.kernel.org>; Thu, 29 Sep 2022 08:52:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DACD340CD8;
	Thu, 29 Sep 2022 08:52:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DACD340CD8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=zRXOsuJk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c-rmqPK2byAL; Thu, 29 Sep 2022 08:52:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9957D400CE;
	Thu, 29 Sep 2022 08:52:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9957D400CE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 765B2C0032;
	Thu, 29 Sep 2022 08:52:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A83DDC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 08:52:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7CCB360FA7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 08:52:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7CCB360FA7
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=zRXOsuJk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9fp15mm5kRkK
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 08:51:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6AFEF60F40
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6AFEF60F40
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 08:51:59 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1318106fe2cso1020796fac.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 01:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=FbKGdi8sG9plba/0oH6VK6R0YvD3aCbYmJsdPxCWQkE=;
 b=zRXOsuJkFtbuqaTwI4oWYDWLFIt9fMV/eHB2OPoxMMix6bUQes4RRNv/2xxkFq6Lbi
 Yf/Sp9o6h6bQ+WhRdVodLZ8TadkujcO7n5/k2zujKjzMB8uQleL09yffljHg0U3fS2x0
 qjcv5tIdsTyS7G2xSp5N3+QFoFba/e+HFDP4cehZIK11Jb8RnOGYskP8f44LmsTSa0pQ
 ftjWn8q2Rod8wqWTFIlsqJAXiEKoPGB+Oa1tW/cgTQRyX5akDn/pB/1RS38GbKQFJ+Fu
 mn4UosQ9PtOlb8Ehn8Dr8hpxSYGoEaPhMU6Xw7Rlv+UETSMJZUs1D1enoATQZNZ00tk0
 vWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=FbKGdi8sG9plba/0oH6VK6R0YvD3aCbYmJsdPxCWQkE=;
 b=ylyXIcQ65IsPHLfQfQJtkTJEXojadJSzotmW6rYIt7s5BgJGkhWKPdk+ani3KlF4yl
 1CQPh5/iLOKQh7hb+cAWVpB+MpgfL2UMwaOEZ7o6+sikrFJNVXZt/fKijNV43AObQ6s8
 2nAKohJWPbnBZn0qLG1DdaXSf97aahOX/2f4Y1ZKpsJcc+tE2PzJADhAVfpNIPJZ/rdj
 ejjs7E9vMmeLctbZilzKVuvqcJlnlwuvSz15AxseBLQaTKtYVAM+TzyghqAF1YcPoufE
 aVE6p6F7Fg9F2ixicU930DJ/TVEnXF1toLEPz1ffUdu0tlQXYV9B5tl9D3WwcYrsMjjS
 LvZQ==
X-Gm-Message-State: ACrzQf09wcLs0ZzdnmjWiJJX37rvfpqTW4IOjP/E57S7B8TFsVbFbTYj
 0i4fMX3qrjR4sz/3dsnV2HkY5CUOao49eJ0XVcJHFA==
X-Google-Smtp-Source: AMsMyM6dAvW/v2F9tklRkXN1naHSMBjrQdmmZBQbXHlc1wYfk1hwrKB3Fsw7c4KDAbuaGXA5PZU/ct28VkBih53CqIA=
X-Received: by 2002:a05:6870:2388:b0:127:377d:4eee with SMTP id
 e8-20020a056870238800b00127377d4eeemr7858175oap.102.1664441518429; Thu, 29
 Sep 2022 01:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220921082729.2516779-1-alvaro.karsz@solid-run.com>
 <YyyfJQo7N/iMPLNP@fedora>
 <CAJs=3_BXGpu-kDq1_bJSanh-iY63uwpc2tZtH6jOYcqBUptsNA@mail.gmail.com>
 <20220928091512-mutt-send-email-mst@kernel.org>
 <CAJs=3_CmKjhS=Y3JHujws9y5KmN-AbSRXTnt1aZOhDzMuK7g3Q@mail.gmail.com>
 <20220929032021-mutt-send-email-mst@kernel.org>
 <CAJs=3_AgfyZkWhwK3pycSs49=k-q+9mpD3pyjG0us+ke60RqmQ@mail.gmail.com>
 <20220929033858-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220929033858-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Thu, 29 Sep 2022 11:51:22 +0300
Message-ID: <CAJs=3_AD_KLZHwo1gxejYRUJ6ucdCxv=3RnpOQXs+KiBEV=K5A@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_blk: add SECURE ERASE command support
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
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

> However, this means that even if host exposes VIRTIO_BLK_F_SECURE_ERASE
> the host can not be sure guest will use secure erase.
> Is this or can be a security problem?
> If yes let's be strict and fail probe as current code does.
> If not let's be flexible and ensure forward compatibility.


I can't think of any security problems.
Stefan, what do you think?
Are you ok with clearing the feature?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
