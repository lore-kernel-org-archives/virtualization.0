Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38462C4332F
	for <virtualization@archiver.kernel.org>; Sun,  4 Dec 2022 12:01:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE57160BBE;
	Sun,  4 Dec 2022 12:01:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BE57160BBE
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=VqymDKhB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sYQ7I0jIlW-i; Sun,  4 Dec 2022 12:01:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3F75860BBD;
	Sun,  4 Dec 2022 12:01:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3F75860BBD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0870EC0032;
	Sun,  4 Dec 2022 12:01:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55FB0C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Dec 2022 12:01:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2FF4F415A9
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Dec 2022 12:01:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2FF4F415A9
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=VqymDKhB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ccw1KIlh8I_c
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Dec 2022 12:01:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9610C41553
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9610C41553
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Dec 2022 12:01:02 +0000 (UTC)
Received: by mail-io1-xd2b.google.com with SMTP id b2so5844276iof.12
 for <virtualization@lists.linux-foundation.org>;
 Sun, 04 Dec 2022 04:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AGcgdNWIgAmYp38qvzLbthK15G8/spJICPCwktBGAsI=;
 b=VqymDKhBoD9yc0mNA/Bn/w8LVxLvLpsaB0PD9WgDxfiBnRsbnhewVXLfR+Ra2rtYCh
 ttyKTF1PzxXNi3pitbLjqaC8ra27umaZl1hcaiQrpXScZ6KRKyeXeN8ns+En15p1pP/2
 YMy4EmQOEn2uvORd2eG70f4oQfWd0BhsKYhd1GdbSDcPWuW2RS7FPA6y/q95nwWSz00D
 0uSS/xR0TVGd3C9c+XIPy65gMjEjQKBfsX2FreL8LGPTAMi2Dv2nOxg/MGjPiVZ2nSQg
 shZAMDLQEPfL/sOZh0DY6XT1Mj3vZX/+sr1ttQ8kwnGCvj4BcWCEv2wAbeUOATYG33iz
 OJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AGcgdNWIgAmYp38qvzLbthK15G8/spJICPCwktBGAsI=;
 b=ge84Py6VoTfkpGv0LouCrdPfxVsplPVIJlekfmd38OHLrdrwxVD/KvhY1j0HjYFoQE
 3fASn2PZo8jhIzxC5lnnGdWaTBJSbLeYUhDka7jhsQW7E8BWLOafNjEAqkdpmr22ggSZ
 rFg6IQ5DUAVN9kFrNgWAzhnn+voqRi0xi32LHjCUUhr++PONTfEoxGiN7aVC01ut9JSY
 LuOoaIABrcNaZjLEF9trYGMBVuMkkw7S2Wa+xca1tGpYtd0X4lTWEYgXPi+ExUxSbIcT
 33fK0PZLI98FxfXFnYJWGpsgCfUs/d4cNN2a/sL9MBaL/GCBoEtjf1KuRjAWDIrIZyds
 l1TA==
X-Gm-Message-State: ANoB5pl1YQL+VHvejDh8QOtuOwuFUdsxcT65SbRvXAp2HG0y3rkkxwJR
 Gd7g4Beq3ozZtG5aq+aOdG84O3obgVYsuGG3qJNL5g==
X-Google-Smtp-Source: AA0mqf4o4eIhfaJMDXjSPBe/S9D5kTb8s/l6Crx9Vl/JikI6tSj05eq5JEXAw0PGWZ7kqsdgnFysSjFi+BWkP0Irwpw=
X-Received: by 2002:a02:6a26:0:b0:389:d02c:7e4c with SMTP id
 l38-20020a026a26000000b00389d02c7e4cmr17911304jac.218.1670155261575; Sun, 04
 Dec 2022 04:01:01 -0800 (PST)
MIME-Version: 1.0
References: <20221121085923.2717501-1-alvaro.karsz@solid-run.com>
 <1bd1c77e-d8c3-b04a-4fbc-bbc85391e630@nvidia.com>
 <20221124013830-mutt-send-email-mst@kernel.org>
 <Y3/WXWoV1jcJnohR@fedora>
 <CAJs=3_AY_1eGwsu5MvzUr4N03=3qgYiVdu5=EV+VSj6+yUYeyg@mail.gmail.com>
 <Y4UG6lQXbzxOix1/@fedora> <dc8bf007-a6f6-9824-63e1-9447335da732@nvidia.com>
 <20221129001239-mutt-send-email-mst@kernel.org>
 <b76ad252-3f6a-8f4b-cb2d-0a4f45860aae@nvidia.com>
 <CAJs=3_Bma3KiOW3Cah2KWiN34TG4c=bdw1bTjB71Fo_QLaKmXw@mail.gmail.com>
 <20221204055044-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221204055044-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Sun, 4 Dec 2022 14:00:25 +0200
Message-ID: <CAJs=3_D1nX3K4=PXiS_CoLHmq1TbYUhecM6CkWT6FCV1JV2PCA@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

> I don't see the connection. virtio would often pass through lifetime
> info from the host. If other devices gain more info then it will make
> sense to add that to virtio, too.

> Depends. If we expect more types, then I think we
> can solve this by passing an array of values.


Good idea!

We could pass something like virtio_blk_lifetime_ioctl struct to userspace:

enum blk_lifetime_type {
         VIRTIO_BLK_LIFETIME_PRE_EOL_TYPE_A_B = 1,
};

struct virtio_blk_lifetime_element {
        void *data;
        enum blk_lifetime_type;
};

struct virtio_blk_lifetime_ioctl {
        struct virtio_blk_lifetime_element elements[];
        u32 elements_num;
};

If just VIRTIO_BLK_F_LIFETIME is negotiated, the array size is 1, and
the element type is VIRTIO_BLK_LIFETIME_PRE_EOL_TYPE_A_B, so the user
will know that this is a virtio_blk_lifetime struct.
This seems general enough to handle future additions and to handle out
of order types (if for example VIRTIO_BLK_LIFETIME is not negotiated
and VIRTIO_BLK_LIFETIME_FUTURE is).

The only downside I can think of is if we add new fields to the struct
virtio_blk_lifetime struct, instead of creating a new, dedicated
struct in the spec.
For example:

struct virtio_blk_lifetime {
  le16 pre_eol_info;
  le16 device_lifetime_est_typ_a;
  le16 device_lifetime_est_typ_b;
  le16 device_lifetime_est_typ_c;  //only if
VIRTIO_BLK_LIFETIME_FUTURE is negotiated
};

In this case, we may need to split it into 2 different structs, and
pass it as 2 elements to userspace.

What do you think?
Should I go ahead and create a new version?


Alvaro
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
