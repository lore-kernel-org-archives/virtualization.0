Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D61AC00140
	for <virtualization@archiver.kernel.org>; Wed, 24 Aug 2022 07:52:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D03164056F;
	Wed, 24 Aug 2022 07:52:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D03164056F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=nP79giSc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e6mF6bomZaei; Wed, 24 Aug 2022 07:52:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 55B4B404CD;
	Wed, 24 Aug 2022 07:52:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 55B4B404CD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05832C0033;
	Wed, 24 Aug 2022 07:52:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A3A9C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 07:51:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A7F58161D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 07:51:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A7F58161D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=nP79giSc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TA2SW0ZrXOV2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 07:51:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B8CFA81A5F
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B8CFA81A5F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 07:51:58 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 c13-20020a17090a4d0d00b001fb6921b42aso730879pjg.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 00:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
 bh=OUyW19wrN1btQVDGIT+ggfn2hZiT0B6iVBs+vQvwmeI=;
 b=nP79giSc1tBC0OinzuNxAY6V+xzaFwmHTRwoBoQ7jN6MNQa/0nlXSwAr0Vehinqdy/
 ajAaF/vAbWEBVT55HVKQMVvqOGemDbdj9BPkdVJXpnkpMgQLnG9vjcwuCNNU53yqjtdw
 nYMggMtwKijeKfkU4MWlhqUms5i/YtB/ezGGcPSvND8A4MG27xgpICeDe1zJzTDtBa8w
 +HlwUQAtMyjLJZ6ZNAESTrcikrJwTK4RC1VHeEHOVc5uqGib4IhuBMKvdRwtqpbDp4VZ
 zXR0d4eVuyqUEoq49eehdN0gzyviGoKNMC9bPFE3PooxoH0af2fqahCbUybbuXHLezyD
 kHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc;
 bh=OUyW19wrN1btQVDGIT+ggfn2hZiT0B6iVBs+vQvwmeI=;
 b=qbR/Yv+fDSyN95q1omUjqH1n/prC8dG1NceQ1ic9gQSuD96nOSD7p8R8//QjtVH0Tf
 bhWRUiCC2vblclX11agoV0kkxHjXExueo8V8LuSe0Ujvk3/FLzCm7nklPsEgBm8fjiEQ
 5eK7DQp9L/qFwL1Dw8d7ifr+X9/A5qSrY6Nig2Bf7hk+tSRRHAPfu4sYPNHDpxZTljrK
 OA0nB90sUn9ljHoc2fo3mtnOicWP2/+yJvOpE2b9BTERGsl1Yw5omSv7MXDVe4HkGMAW
 SRmCNaFPnnW3Hg8mNQtOznAkKIwm9jlseyBWs8QUKnhVU5DrIiozvVCR6mRp2woQeKkF
 axMg==
X-Gm-Message-State: ACgBeo063FxhTLDrQsDovGYZmInub43+HkZGDv0otEPbe1DJ1zF3W/qx
 FOqszoc3Pbu25P2V3XYso6nG20oYDU+La5MrgS+JNtzi3LwvTg==
X-Google-Smtp-Source: AA6agR6x52gLCcMN0s2Bzz6+ZSZjZbKTyQ2mOYjfKKKPwXhUxFjNs3qAWHxcBlORTftpouAack9LwdAkR7fi86t2Xn8=
X-Received: by 2002:a17:903:1ce:b0:16f:1c1f:50e5 with SMTP id
 e14-20020a17090301ce00b0016f1c1f50e5mr28484206plh.132.1661327517734; Wed, 24
 Aug 2022 00:51:57 -0700 (PDT)
MIME-Version: 1.0
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Wed, 24 Aug 2022 10:51:22 +0300
Message-ID: <CAJs=3_DJ8x5h98WBbXhzxVx+D6pqpBkCrBHXa_7ApqYO4vGDpQ@mail.gmail.com>
Subject: Virtio-net - add timeouts to control commands
To: virtualization@lists.linux-foundation.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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

I think that we should add a timeout to the control virtqueue commands.
If the hypervisor crashes while handling a control command, the guest
will spin forever.
This may not be necessary for a virtual environment, when both the
hypervisor and the guest OS run in the same bare metal, but this
is needed for a physical network device compatible with VirtIO.

(In these cases, the network device acts as the hypervisor, and the
server acts as
the guest OS).

The network device may fail to answer a control command, or may crash, leading
to a stall in the server.

My idea is to add a big enough timeout, to allow the slow devices to
complete the command.

I wrote a simple patch that returns false from virtnet_send_command in
case of timeouts.

The timeout approach introduces some serious problems in cases when
the network device does answer the control command, but after the
timeout.

* The device will think that the command succeeded, while the server won't.
   This may be serious with the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command.
   The server may receive packets in an unexpected queue.

* virtqueue_get_buf will return the previous response for the next
control command.

Addressing this case by adding a timeout  to the spec won't be easy,
since the network device and the server have different clocks, and the
server won't know when exactly the network device noticed the kick.

So maybe we should call virtnet_remove if we reach a timeout.

Or maybe we can just assume that the network device crashed after a
long timeout, and nothing should be done.

What do you guys think?

Alvaro
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
