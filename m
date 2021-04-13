Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862AEC433ED
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 05:48:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3445A613B3
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 05:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3445A613B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EFF88400C1;
	Tue, 13 Apr 2021 05:48:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I3TJG71IZ92w; Tue, 13 Apr 2021 05:47:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id F3EAF400B5;
	Tue, 13 Apr 2021 05:47:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C137CC000B;
	Tue, 13 Apr 2021 05:47:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD1DCC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 05:47:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AE0B58432F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 05:47:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d4i7mVZLqAvb
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 05:47:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 913CD84329
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 05:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618292870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=NoGLR1VJ5gNLYdaNxmqjFzT6An+veHXT72XxxlzyW7A=;
 b=LqGNea/evVgwZkDAOqvivMIXeUppJv7L4x7yOogPxdkuLSujkgG3VlGPxH3aRuH5b1MbzV
 iCwBc6qL0y51WjSqxAF2ieq/frnZ/grR8Tzy5PXn5xkGXwMELHiXu05IZKMhq2oCBZUdDM
 M10L0MfnfbQLv324lpQpDyyX3N+wfiM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-X5nh-yjVM-KcSGHxrwT3zg-1; Tue, 13 Apr 2021 01:47:48 -0400
X-MC-Unique: X5nh-yjVM-KcSGHxrwT3zg-1
Received: by mail-wm1-f70.google.com with SMTP id
 z135-20020a1c7e8d0000b02901297f50f20dso412804wmc.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 22:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=NoGLR1VJ5gNLYdaNxmqjFzT6An+veHXT72XxxlzyW7A=;
 b=OmkvDgMRJ9vNDmH3iPn4HFZJfYUQ2mztOU5ASN7TEaW3c9aucH//tN18vfxROUqtkZ
 6F9B1PavYqJSxdEA/sXdnwtCFxdSzoYty89bEl+BINKogaBwVuioP15TDGUNatd1w1+d
 wXr3Jk33TDD1uMTfCzmJbuH3FUr7BOlSIxh9rIG+iKs9ycRw15mjkKlB3uilj2lg2yLg
 xl0lZosrTeBB9NFF8JmxtTKUTdb3QwPnj311fdxjaBLJHAfXlR0mqtI98KdwhUW6rV8c
 l9PczfwyGG71mR2TZoUj0rw0M+OToppMh3pO0XAvBeuL9oTeyp6n3xTqCfeB5+07HFah
 xe1A==
X-Gm-Message-State: AOAM532F1RjZgYLCbSMLjNh8m/UVhnPwVhuBEG7vdfll5lOLmVjvb+ok
 ZU1HkaDq5LjmsNLW28Ft8CVqijVwl7afC+Lz4RU+b49ONndYa/DriGxZQK1jGnoFvoJESWADJDr
 /u4E1mC6odhXvOIlNNRlJeNFgHO6UXryNPDijFlMBcw==
X-Received: by 2002:adf:dc4f:: with SMTP id m15mr35092244wrj.420.1618292867442; 
 Mon, 12 Apr 2021 22:47:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxHY/ypRcjTg5TsZRaoQK31psb9y/vV26Xnbj/l6lE6PeheJEYSaDyTSaGX+fe0fFMMvdRZw==
X-Received: by 2002:adf:dc4f:: with SMTP id m15mr35092229wrj.420.1618292867318; 
 Mon, 12 Apr 2021 22:47:47 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
 by smtp.gmail.com with ESMTPSA id u9sm1326079wmc.38.2021.04.12.22.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Apr 2021 22:47:46 -0700 (PDT)
Date: Tue, 13 Apr 2021 01:47:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 0/4] virtio net: spurious interrupt related fixes
Message-ID: <20210413054733.36363-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 Wei Wang <weiwan@google.com>, David Miller <davem@davemloft.net>
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

With the implementation of napi-tx in virtio driver, we clean tx
descriptors from rx napi handler, for the purpose of reducing tx
complete interrupts. But this introduces a race where tx complete
interrupt has been raised, but the handler finds there is no work to do
because we have done the work in the previous rx interrupt handler.
A similar issue exists with polling from start_xmit, it is however
less common because of the delayed cb optimization of the split ring -
but will likely affect the packed ring once that is more common.

In particular, this was reported to lead to the following warning msg:
[ 3588.010778] irq 38: nobody cared (try booting with the
"irqpoll" option)
[ 3588.017938] CPU: 4 PID: 0 Comm: swapper/4 Not tainted
5.3.0-19-generic #20~18.04.2-Ubuntu
[ 3588.017940] Call Trace:
[ 3588.017942]  <IRQ>
[ 3588.017951]  dump_stack+0x63/0x85
[ 3588.017953]  __report_bad_irq+0x35/0xc0
[ 3588.017955]  note_interrupt+0x24b/0x2a0
[ 3588.017956]  handle_irq_event_percpu+0x54/0x80
[ 3588.017957]  handle_irq_event+0x3b/0x60
[ 3588.017958]  handle_edge_irq+0x83/0x1a0
[ 3588.017961]  handle_irq+0x20/0x30
[ 3588.017964]  do_IRQ+0x50/0xe0
[ 3588.017966]  common_interrupt+0xf/0xf
[ 3588.017966]  </IRQ>
[ 3588.017989] handlers:
[ 3588.020374] [<000000001b9f1da8>] vring_interrupt
[ 3588.025099] Disabling IRQ #38

This patchset attempts to fix this by cleaning up a bunch of races
related to the handling of sq callbacks (aka tx interrupts).
Very lightly tested, sending out for help with testing, early feedback
and flames. Thanks!

Michael S. Tsirkin (4):
  virtio: fix up virtio_disable_cb
  virtio_net: disable cb aggressively
  virtio_net: move tx vq operation under tx queue lock
  virtio_net: move txq wakeups under tx q lock

 drivers/net/virtio_net.c     | 35 +++++++++++++++++++++++++++++------
 drivers/virtio/virtio_ring.c | 26 +++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 7 deletions(-)

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
