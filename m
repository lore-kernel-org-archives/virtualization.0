Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85938C4332F
	for <virtualization@archiver.kernel.org>; Fri, 23 Dec 2022 03:01:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 05A514056A;
	Fri, 23 Dec 2022 03:01:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 05A514056A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UMNR7Vs1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XMSGoeE0iLT4; Fri, 23 Dec 2022 03:01:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8CA1440004;
	Fri, 23 Dec 2022 03:01:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8CA1440004
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 617C7C0071;
	Fri, 23 Dec 2022 03:01:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4672BC0070
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 03:01:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0DB9E40135
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 03:01:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0DB9E40135
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id juPMvc-Y2TzU
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 03:01:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5556740004
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5556740004
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 03:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671764462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VK82Nhu6JHr+tzvOCienuycRQvWqNfDLEqiJgirwkQM=;
 b=UMNR7Vs1cg4QqPJX/l1WKvrvgYgCWZirvoneGa5q+rvXKEGOYVhLdzRi7G3EEkn1U9+PCd
 x2zeq9z5DSZm+0er/Ynr+hxf4BgDVXfUJN2b0u0+0raKE5CPScGe21aRs/hcbkiGsPSXH0
 6pzT8p9aSsIorQAmi7ZsCbC8wXi3xQk=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-607-6ilrCM9GNvKRxJ3SEtoD2w-1; Thu, 22 Dec 2022 22:01:00 -0500
X-MC-Unique: 6ilrCM9GNvKRxJ3SEtoD2w-1
Received: by mail-ot1-f72.google.com with SMTP id
 o11-20020a9d6d0b000000b0067074f355b3so1954955otp.23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 19:01:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VK82Nhu6JHr+tzvOCienuycRQvWqNfDLEqiJgirwkQM=;
 b=8GTDtgIJfynOK34uc/ThOXFg4Ml6B0CeDytMTz5Pp6Rvd2rWUSY36Ckb18WTu6fJpa
 aIULqEwMeD9RnX7VslIxylp7ZvKHEuhUyzu8FYh3d5eQPBphGY3EjJV8pHdf2OiEHmSJ
 W/2pZg6oPHVE264KBF/QVM2QI3NrhXn9qqSliia7OUeE5mYcnlEQnQnSda392TdO1e6U
 CW/7V0a8WKZkKtjJ5jBlaxZvk1nyt196YX+P6Yetd5IHyd+gqIF/hMrKpfUduQzqf2d7
 hRSvsCSXx1qaHFS79rhPyG4JyCRgRj8qkcVs3tlsR1E8seH8PGiAqmnJOG4BdUJ3xC+j
 YwaQ==
X-Gm-Message-State: AFqh2koSjrvWDsqekFago5KZodcdfapNmdqKmAC8EiFrDH2iCRZkAJmm
 NpU1rQpktHdGZ8uiAXsNC8DE8oAjTNKgBRwmwHnljYAMnQJNqjlrxewDgck0ZVnzx0QoRj0Hc03
 ofm6+Mkse8gdTFI+0bXOS4FgFTmHZG/0FK4aUgjv+Y+R4cq+TyPpFPPEGJA==
X-Received: by 2002:aca:1111:0:b0:35e:7a42:7ab5 with SMTP id
 17-20020aca1111000000b0035e7a427ab5mr408472oir.280.1671764459702; 
 Thu, 22 Dec 2022 19:00:59 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtIOVCwh9+wmHi8r4jbqvdTXxqGzFftGQO+ErpobPf+73EjJy6JS/t0taKiB9+4ROWrt8mVx4kFe/M/uwZYo6c=
X-Received: by 2002:aca:1111:0:b0:35e:7a42:7ab5 with SMTP id
 17-20020aca1111000000b0035e7a427ab5mr408461oir.280.1671764459516; Thu, 22 Dec
 2022 19:00:59 -0800 (PST)
MIME-Version: 1.0
References: <20221222060427.21626-1-jasowang@redhat.com>
 <20221222060427.21626-5-jasowang@redhat.com>
 <CAJs=3_D6sug80Bb9tnAw5T0_NaL_b=u8ZMcwZtd-dy+AH_yqzQ@mail.gmail.com>
 <CACGkMEv4YxuqrSx_HW2uWgXXSMOFCzTJCCD_EVhMwegsL8SoCg@mail.gmail.com>
 <CAJs=3_Akv1zoKy_HARjnqMdNsy_n34TzzGA6a25xrkF2rCnqwg@mail.gmail.com>
In-Reply-To: <CAJs=3_Akv1zoKy_HARjnqMdNsy_n34TzzGA6a25xrkF2rCnqwg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 23 Dec 2022 11:00:48 +0800
Message-ID: <CACGkMEvtgr=pDpcZeE4+ssh+PiL0k2B2+3kzdDmEvxxe=2mtGA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] virtio-net: sleep instead of busy waiting for cvq
 command
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Thu, Dec 22, 2022 at 11:55 PM Alvaro Karsz
<alvaro.karsz@solid-run.com> wrote:
>
> My point is that the device may complete the control command after the timeout,

This needs to be proposed to the virtio spec first. And actually we
need more than this:

1) we still need a way to deal with the device without this feature
2) driver can't depend solely on what is advertised by the device (e.g
device can choose to advertise a very long timeout)

> so, if I'm not mistaken, next time we send a control command and call
> virtqueue_wait_for_used we'll get the previous response.
>

In the next version, I will first put BAD_RING() to prevent future
requests for cvq.

Note that the patch can't fix all the issues, we need more things on
top. But it's a good step and it will behave much better than the
current code.

Thanks

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
