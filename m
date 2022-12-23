Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABE1C4167B
	for <virtualization@archiver.kernel.org>; Fri, 23 Dec 2022 07:39:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E19D760A9D;
	Fri, 23 Dec 2022 07:39:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E19D760A9D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=vEB8Uzl9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N4rf584jrHac; Fri, 23 Dec 2022 07:39:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 834FF60594;
	Fri, 23 Dec 2022 07:39:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 834FF60594
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45835C0071;
	Fri, 23 Dec 2022 07:39:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 560F9C0070
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 07:39:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C32780C3C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 07:39:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C32780C3C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=vEB8Uzl9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oG33V9RwED2h
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 07:39:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6E9C280B4B
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6E9C280B4B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 07:39:15 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 k88-20020a17090a4ce100b00219d0b857bcso4271270pjh.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 23:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FA3Upgc6ssVe6xdA6JsVzh+Jt01y4Sqla6SzmXxN8g4=;
 b=vEB8Uzl9vY9nFk2qr5qnMKufBVt0p9QAaVvDrH4DemwYgfNK7N0YX/xnomNhC/xTTL
 roXzvIplSwSMpCGxoARG08eZpDE1T+19szBMbk0zc4KcmmR2b4OMZMKPcq4csrBwjO/a
 fp+xxrOFSU6sg99h++InHBt9mE1TuCRX8FazaiHK4BKU1KqhL4UYUruHLrs654GnB0TE
 rrq1pC3kMoIj+fvCqOofRqJUAEPQlJsIQ5nv6VN3MKzV8LqjaH/fdY8B+TwjQCPOmd7y
 9rc+M7H642JfsI2vne32JJk2ylFSaC9hk5KyHKbBTY3YYOhisb6k2qB62QnWUtkrnRjA
 7dHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FA3Upgc6ssVe6xdA6JsVzh+Jt01y4Sqla6SzmXxN8g4=;
 b=U4aqwdTC/SKZ8Cs+LHIqJfw6eB81dwtF71BoAsvdbEUcZG89w14C7lbEDW3Nh6eJED
 A6HzT8QK65tygVffqeXGf9mmlXKgNh31ypGIYhvUOVIBJLyNCUCAj/60h9bH0QI5o5wZ
 QYFyHfh2qqeFmoLDFNjusqUMJR5/gvm9IDFMyMVknBBqxTwykYyXzZCFFgHmoT5+YmGs
 nL3qGrZiMQWRgAM9Pzjq6xxTGCVurtQNo+RN7S2dikKkf68XJ9PLNM60dYXCDZZmnKHc
 ZiE+p6u4fKSE2dMoVbXXOawgVNNenlbJjHVGJTF1qrUHSKx5X2dZ/QO/IR9dIVUeUVjX
 S4oA==
X-Gm-Message-State: AFqh2krALvfgZHi2EqnWhoYLzNjADbvQZ5FnRMlWOQN4HMLYn3vb5yFO
 +S8cqeS31Ns3XZqClLZJ4YLigpI+oL6PO+GcuaMh8A==
X-Google-Smtp-Source: AMrXdXvDj0D6mEXUNNu6qGMXLoMu/FdEZ4pbbuy35Y4YNHmOWTPoYDiaqmoAxQk43wJi6/6n/NRUNy34u1Azpqdc3mM=
X-Received: by 2002:a17:90b:8b:b0:219:19c1:1ae7 with SMTP id
 bb11-20020a17090b008b00b0021919c11ae7mr675588pjb.13.1671781154551; Thu, 22
 Dec 2022 23:39:14 -0800 (PST)
MIME-Version: 1.0
References: <20221222060427.21626-1-jasowang@redhat.com>
 <20221222060427.21626-5-jasowang@redhat.com>
 <CAJs=3_D6sug80Bb9tnAw5T0_NaL_b=u8ZMcwZtd-dy+AH_yqzQ@mail.gmail.com>
 <CACGkMEv4YxuqrSx_HW2uWgXXSMOFCzTJCCD_EVhMwegsL8SoCg@mail.gmail.com>
 <CAJs=3_Akv1zoKy_HARjnqMdNsy_n34TzzGA6a25xrkF2rCnqwg@mail.gmail.com>
 <CACGkMEvtgr=pDpcZeE4+ssh+PiL0k2B2+3kzdDmEvxxe=2mtGA@mail.gmail.com>
In-Reply-To: <CACGkMEvtgr=pDpcZeE4+ssh+PiL0k2B2+3kzdDmEvxxe=2mtGA@mail.gmail.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Fri, 23 Dec 2022 09:38:37 +0200
Message-ID: <CAJs=3_BqDqEoXGiU9zCNfGNqEjd1eijqkE_8_mb3nC=GwQoxHA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] virtio-net: sleep instead of busy waiting for cvq
 command
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

> This needs to be proposed to the virtio spec first. And actually we
> need more than this:
>
> 1) we still need a way to deal with the device without this feature
> 2) driver can't depend solely on what is advertised by the device (e.g
> device can choose to advertise a very long timeout)

I think that I wasn't clear, sorry.
I'm not talking about a new virtio feature, I'm talking about a situation when:
* virtio_net issues a control command.
* the device gets the command, but somehow, completes the command
after timeout.
* virtio_net assumes that the command failed (timeout), and issues a
different control command.
* virtio_net will then call virtqueue_wait_for_used, and will
immediately get the previous response (If I'm not wrong).

So, this is not a new feature that I'm proposing, just a situation
that may occur due to cvq timeouts.

Anyhow, your solution calling BAD_RING if we reach a timeout should
prevent this situation.

Thanks
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
