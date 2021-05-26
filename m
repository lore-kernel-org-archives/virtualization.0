Return-Path: <SRS0=MQJa=KV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E992BC47088
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 08:24:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96EEC61005
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 08:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96EEC61005
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A7F08394A;
	Wed, 26 May 2021 08:24:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HJI6G5ViAZZ6; Wed, 26 May 2021 08:24:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3077B83196;
	Wed, 26 May 2021 08:24:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 019FCC000E;
	Wed, 26 May 2021 08:24:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00DA2C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 08:24:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CD98A402EB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 08:24:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6dcwTtpersAZ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 08:24:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A6DA0402CE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 08:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622017478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=h/IiZdevU24C6iPRKe1yVzH4pkUf/4vRqKB2RZ+6Gak=;
 b=Nz7Rw64aif5FDY11yYPihwCX4PndsiCxoJBwOY8sa4w31mlZhBizusv7UXvrVELxcUqkpq
 wjYYYJmJYreDlR2tnHMsVe8rBEr44ovY+y9D5FnmPvs/ofmRt29PsmbUHgWaozKPkm+WHF
 iHU0m1FkMdbcrLIXjPlM7j+bM1FOC2w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-DK6kKTRWMyCGPbYIC6eKtA-1; Wed, 26 May 2021 04:24:36 -0400
X-MC-Unique: DK6kKTRWMyCGPbYIC6eKtA-1
Received: by mail-wr1-f69.google.com with SMTP id
 i102-20020adf90ef0000b029010dfcfc46c0so53213wri.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 01:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=h/IiZdevU24C6iPRKe1yVzH4pkUf/4vRqKB2RZ+6Gak=;
 b=EjF+z+UPmWRKl1WhszzjQ6Hmz0KyInba6Dp0dNr5xTVr923cF17CfZYLQEYAP+DmmT
 fHO+ChY1wPWC7JvHwQpa7RclqprRdVR7Xz4+hiSxx+6NXEMGWjo1bGdtcAz+wBT2vuo3
 zxfIpNz/r6OmcGUC9afWGc42LhWX+9rj50iWER6gcJmM493wPyp0TprnNBI80qOgBvvj
 W03ow1ZQQxdoLPcTczi4cikVrnaYI4rW0P/D8+fI2tJDUPBj699LcJdqKaXWbeWIISEr
 BEJ4oy52g3KVGBoAZjK8oMI+a3d/yleUUwKa6mB+Y2M2oLOnlUQQNarrFv8RLBvELYjF
 lmUA==
X-Gm-Message-State: AOAM531m03kajdGgO7nfYRK3J16EUho/MehdaaW1i6/jVT5kTCrBP4w6
 lY4ldKS581br48/0hdodgv3RJmpf5sepuy1ds5CvR+sjZF+54Hm5HBvPH3kpWPv7jAjmLgIPRug
 b8bntUSy0tnDDLlsuKbMp2jDg8xrF5f6eczIlPnsk2A==
X-Received: by 2002:a05:6000:22f:: with SMTP id
 l15mr31043311wrz.316.1622017474987; 
 Wed, 26 May 2021 01:24:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCiZwAZaoPLnVZeYjw1jGMxvTHDr/fij7cEsvVkrjAJeTC0ZTaZikGLvMscL1b2PuHa1A7HA==
X-Received: by 2002:a05:6000:22f:: with SMTP id
 l15mr31043301wrz.316.1622017474846; 
 Wed, 26 May 2021 01:24:34 -0700 (PDT)
Received: from redhat.com ([2a10:8006:fcda:0:90d:c7e7:9e26:b297])
 by smtp.gmail.com with ESMTPSA id n2sm17372318wmb.32.2021.05.26.01.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 01:24:34 -0700 (PDT)
Date: Wed, 26 May 2021 04:24:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] virtio net: spurious interrupt related fixes
Message-ID: <20210526082423.47837-1-mst@redhat.com>
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
Somewhat tested but I couldn't reproduce the original issues
reported, sending out for help with testing.

Wei, does this address the spurious interrupt issue you are
observing? Could you confirm please?

Thanks!

changes from v2:
	Fixed a race condition in start_xmit: enable_cb_delayed was
	done as an optimization (to push out event index for
	split ring) so we did not have to care about it
	returning false (recheck). Now that we actually disable the cb
	we have to do test the return value and do the actual recheck.


Michael S. Tsirkin (4):
  virtio_net: move tx vq operation under tx queue lock
  virtio_net: move txq wakeups under tx q lock
  virtio: fix up virtio_disable_cb
  virtio_net: disable cb aggressively

 drivers/net/virtio_net.c     | 49 ++++++++++++++++++++++++++++--------
 drivers/virtio/virtio_ring.c | 26 ++++++++++++++++++-
 2 files changed, 64 insertions(+), 11 deletions(-)

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
