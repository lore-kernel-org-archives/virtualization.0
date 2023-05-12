Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B2FC77B7C
	for <virtualization@archiver.kernel.org>; Fri, 12 May 2023 09:48:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C5EE41517;
	Fri, 12 May 2023 09:48:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1C5EE41517
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=crfSML1D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2kmXACfOcwnx; Fri, 12 May 2023 09:48:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 44E18414C3;
	Fri, 12 May 2023 09:48:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 44E18414C3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C633C0037;
	Fri, 12 May 2023 09:48:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9302C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 09:48:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9F82E410C2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 09:48:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9F82E410C2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ZOJ2CB4Ivl5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 09:48:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5DA4D409A3
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5DA4D409A3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 09:48:23 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-64ab2a37812so3484564b3a.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 02:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1683884902; x=1686476902;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xQT0FmogO5TGY0rbQj7fXytMe4BFJtheTdNHt0t5iWE=;
 b=crfSML1D5wH7IO5vc+OyCVHZrQULvGv9CCRF1/naJtHJtQvEtBJue48p2BLCutjHdx
 k/3GgoGdwnBmEGE4B+5SMLpmay4Pgjpccn5NWT+WKQ/2h5wTCoZhc3EfGRYnW+LETqJl
 8gHlKIAXXbrGB87dkSZQ2y0/MNMJLzUeWKb8R9fcOHObPNix/I9+CCqa+PRuRYxqwgDa
 99pqlMt+lI9RgDqZro8ewFxfZrOMi9/TEUpXSignIUAHjfzaT6BV7uP4aWmikLvGUkik
 O+NjI7Tt2wIrBWDIdy4QHQbNoaHkb5ihUXuuap2onVXBURooML4V/B2gLlW9SwjCJIic
 Wmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683884902; x=1686476902;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xQT0FmogO5TGY0rbQj7fXytMe4BFJtheTdNHt0t5iWE=;
 b=I/JdQ84gFdcZQ+ukF7MnSKS7iG0VBJ9iklYwjX8Qtq+p/N24gm2xDuW790NeIZGXxc
 oMYdPykxPdhwtCR8Bs18egLbHsxQAS+Arno/juoBNzZD/utICWpogpcxYGve0JCZR6Tl
 1W1LfebBmrY8spizPverhcc11tAIrNHole3BfWYn6AsS4KXhomAe5aklX9Wb+72BxZ0i
 j1luY+PsQqY6k6DOzDgtQcvFK44fEJrPsfgRDGbRYQBagmu+GdAtKbX3rpq9iW/gDF5B
 LqNNwrampzTJ0EMCisVptWB3CbMjeUa+1Q6YRFdMegW5yRzYmiXRGZdUAudX4uDku2f6
 n6pw==
X-Gm-Message-State: AC+VfDxtQ+vhwUjroS4gyW7S4r8PAuujefl20oqwhYEWFd/cgnYKptnK
 CbSdS6/CykxEb9JLRU6v7OQLwg==
X-Google-Smtp-Source: ACHHUZ6jca329PTc/0Z6VeTJ8ExSq29nobPjfYbIoKeiC5aivyG/NRPzQV74tXnzbHRlO+aAZ1NNlA==
X-Received: by 2002:a17:902:e547:b0:1ac:b03c:a58e with SMTP id
 n7-20020a170902e54700b001acb03ca58emr11886825plf.25.1683884902614; 
 Fri, 12 May 2023 02:48:22 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.213.176.13])
 by smtp.gmail.com with ESMTPSA id
 x17-20020a170902821100b001a6d4ffc760sm7452956pln.244.2023.05.12.02.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 May 2023 02:48:22 -0700 (PDT)
To: stefanha@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 0/2] virtio: abstract virtqueue related methods
Date: Fri, 12 May 2023 17:46:16 +0800
Message-Id: <20230512094618.433707-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
 zhenwei pi <pizhenwei@bytedance.com>,
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
From: zhenwei pi via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: zhenwei pi <pizhenwei@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi,

3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html

Jason and Stefan pointed out that a non-vring based virtqueue has a
chance to overwrite virtqueue instead of using vring virtqueue.

Then I try to abstract virtqueue related methods in this series, the
details changes see the comment of patch 'virtio: abstract virtqueue related methods'.

Something is still remained:
- __virtqueue_break/__virtqueue_unbreak is supposed to use by internal
  virtio core, I'd like to rename them to vring_virtqueue_break
  /vring_virtqueue_unbreak. Is this reasonable?
- virtqueue_get_desc_addr/virtqueue_get_avail_addr/virtqueue_get_used_addr
  /virtqueue_get_vring is vring specific, I'd like to rename them like
  vring_virtqueue_get_desc_addr. Is this reasonable?
- there are still some functions in virtio_ring.c with prefix *virtqueue*,
  for example 'virtqueue_add_split', just keep it or rename it to
  'vring_virtqueue_add_split'?

zhenwei pi (2):
  virtio: abstract virtqueue related methods
  tools/virtio: implement virtqueue in test

 drivers/virtio/virtio.c      | 362 ++++++++++++++++++++++++++++++++++
 drivers/virtio/virtio_ring.c | 282 +++++----------------------
 include/linux/virtio.h       |  29 +++
 tools/virtio/Makefile        |   4 +-
 tools/virtio/linux/virtio.h  |  30 +++
 tools/virtio/virtqueue.c     | 367 +++++++++++++++++++++++++++++++++++
 6 files changed, 842 insertions(+), 232 deletions(-)
 create mode 100644 tools/virtio/virtqueue.c

-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
