Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8769C433EF
	for <virtualization@archiver.kernel.org>; Tue, 22 Mar 2022 11:43:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8735140133;
	Tue, 22 Mar 2022 11:43:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uoS-MUXZnC22; Tue, 22 Mar 2022 11:43:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D82364000B;
	Tue, 22 Mar 2022 11:43:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADA96C0012;
	Tue, 22 Mar 2022 11:43:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02825C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 11:43:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E62CD4050E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 11:43:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id odCS04HHN-at
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 11:43:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 100BC40358
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 11:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647949404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2l0fFq2ky7IzX1acqQDcv0PT6l/OeImeJ+r0/hABWSs=;
 b=P2BnhLN8Wm2zLTLqLaIaETrasrFfCvlwSmcVI6D4EX2hwhJnuKn1NnC1g0L467q2xrksNQ
 in/L7M0V6n+iLYmN98a0YX9TlqrwFBts2U9Ij1c1/an3nSItp3x8a3O0V+U+hDL7FoMG1W
 gSr3CDIfk16qZfUCt0AoeyJWKPh6xdk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-ZcZTDtoKP2WwWK6jFQW4VA-1; Tue, 22 Mar 2022 07:43:23 -0400
X-MC-Unique: ZcZTDtoKP2WwWK6jFQW4VA-1
Received: by mail-qk1-f198.google.com with SMTP id
 f11-20020a05620a20cb00b0067b3fedce10so11562860qka.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 04:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2l0fFq2ky7IzX1acqQDcv0PT6l/OeImeJ+r0/hABWSs=;
 b=Uyh9oYzxi12+x8/E5K2uD8eoFYzrPZgO2aS2CCUaZbOuZEpJCixhLGMEjEPS5jkOEd
 i7oLv0dwOf+0EOBuVna2kdZam7FM8h+ZSA8NKVJIVDZmUUTEWnu3gUKbwFryYmlHPduY
 LERGjuG1ntjVQbiD//Vgm6ps2/JUEiqlBb6BKKhfDQoByrGjQMU2FuvuVkOcmwSd1JKe
 fgjg2fvOlqRrS0aS83BOYedUcpnSGgRQNbJ9nBpIjovngT557tlg6ntT72EZetr9hOvo
 zgZrAeAy9vqZT3csqNkvZG6+TATyNexIFMPZH1JUb4PwsuJ5JfltuW4+YrB+gXXf1BYV
 X6KA==
X-Gm-Message-State: AOAM532ChdGDQgAkqmipvkM6wDnegeh/r6tztrnouoee+RYB/NfdJvuG
 9Pu70GiNJNF7TlNdKdZyMI52X+rF1W5DGMPxhtp6tupY2INurOOYCO08C4c8Hm0ffo+aTVoBbOU
 LStACtOHvcIzcsO++fuWU3G8KKWOrjLYhNuyscqTquyDnf8fTJRwwkcVXU4r5E/Tc350UidptYe
 PtN9taD5cjRtL+mg4vQw==
X-Received: by 2002:ad4:574d:0:b0:435:82ea:d03c with SMTP id
 q13-20020ad4574d000000b0043582ead03cmr18959372qvx.131.1647949402781; 
 Tue, 22 Mar 2022 04:43:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAAjBCXd7O70+Bvy7zI379GD8IRuBdJuK4sQOv2roJe09wIwfOWpSci+9Wv5tMuxFEEnV38w==
X-Received: by 2002:ad4:574d:0:b0:435:82ea:d03c with SMTP id
 q13-20020ad4574d000000b0043582ead03cmr18959357qvx.131.1647949402514; 
 Tue, 22 Mar 2022 04:43:22 -0700 (PDT)
Received: from step1.redhat.com ([87.12.25.114])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a05622a164c00b002e1e277885esm13177825qtj.8.2022.03.22.04.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Mar 2022 04:43:21 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio: use virtio_device_ready() in virtio_device_restore()
Date: Tue, 22 Mar 2022 12:43:13 +0100
Message-Id: <20220322114313.116516-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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

After waking up a suspended VM, the kernel prints the following trace
for virtio drivers which do not directly call virtio_device_ready() in
the .restore:

    PM: suspend exit
    irq 22: nobody cared (try booting with the "irqpoll" option)
    Call Trace:
     <IRQ>
     dump_stack_lvl+0x38/0x49
     dump_stack+0x10/0x12
     __report_bad_irq+0x3a/0xaf
     note_interrupt.cold+0xb/0x60
     handle_irq_event+0x71/0x80
     handle_fasteoi_irq+0x95/0x1e0
     __common_interrupt+0x6b/0x110
     common_interrupt+0x63/0xe0
     asm_common_interrupt+0x1e/0x40
     ? __do_softirq+0x75/0x2f3
     irq_exit_rcu+0x93/0xe0
     sysvec_apic_timer_interrupt+0xac/0xd0
     </IRQ>
     <TASK>
     asm_sysvec_apic_timer_interrupt+0x12/0x20
     arch_cpu_idle+0x12/0x20
     default_idle_call+0x39/0xf0
     do_idle+0x1b5/0x210
     cpu_startup_entry+0x20/0x30
     start_secondary+0xf3/0x100
     secondary_startup_64_no_verify+0xc3/0xcb
     </TASK>
    handlers:
    [<000000008f9bac49>] vp_interrupt
    [<000000008f9bac49>] vp_interrupt
    Disabling IRQ #22

This happens because we don't invoke .enable_cbs callback in
virtio_device_restore(). That callback is used by some transports
(e.g. virtio-pci) to enable interrupts.

Let's fix it, by calling virtio_device_ready() as we do in
virtio_dev_probe(). This function calls .enable_cts callback and sets
DRIVER_OK status bit.

This fix also avoids setting DRIVER_OK twice for those drivers that
call virtio_device_ready() in the .restore.

Fixes: d50497eb4e55 ("virtio_config: introduce a new .enable_cbs method")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

I'm not sure about the fixes tag. That one is more generic, but the
following one I think introduced the issue.

Fixes: 9e35276a5344 ("virtio_pci: harden MSI-X interrupts")

Thanks,
Stefano
---
 drivers/virtio/virtio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 22f15f444f75..75c8d560bbd3 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -526,8 +526,9 @@ int virtio_device_restore(struct virtio_device *dev)
 			goto err;
 	}
 
-	/* Finally, tell the device we're all set */
-	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
+	/* If restore didn't do it, mark device DRIVER_OK ourselves. */
+	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
+		virtio_device_ready(dev);
 
 	virtio_config_enable(dev);
 
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
