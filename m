Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADEAC77B75
	for <virtualization@archiver.kernel.org>; Wed, 17 May 2023 02:56:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5B66841A3;
	Wed, 17 May 2023 02:56:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B5B66841A3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=M/J5k6mp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F8w0wtQKMaHV; Wed, 17 May 2023 02:56:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3CE3C841A0;
	Wed, 17 May 2023 02:56:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3CE3C841A0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14526C0036;
	Wed, 17 May 2023 02:56:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B995C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 02:56:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4C470841A1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 02:56:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4C470841A1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X9_jnb4CTCG0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 02:56:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0D63A841A0
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0D63A841A0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 02:56:32 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6434e65d808so193739b3a.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 19:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1684292192; x=1686884192;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0ZO1TY70d7JB54ZSdTzcbWlEKFT+XnqOX871W+Km0K4=;
 b=M/J5k6mpUDJ7zHnVuje5rzGIiUI4Fg5+wLDHTXT1id7bm7QXJTEs+JIbbz0KNOPlHP
 5RHGgG2nCX/wB65HSNpsJsx7WlN+Q1iopT7D9j9GVBSOxHR2qxhShnJKb3IzZmtb+9ue
 Z8gVkhum+qzraD7SObBaFfdehgltTpwR87/Qjg6tEAM9c2jSGZdLpUTMSI3+La3sxZop
 yXkTqN89pzj+QFfTVclKC6MGgbbL9XsdFCCSHKvVNhjRD3qfU3Umsvj7zxr4lvDJat03
 DF7g2yBjgODafx8wj0zX71ThL+T444fKM4hCeK155iq38q6D54vPTABWJHGROlQhEXJT
 G10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684292192; x=1686884192;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0ZO1TY70d7JB54ZSdTzcbWlEKFT+XnqOX871W+Km0K4=;
 b=EQZ3ryUgnTONUu5APZHHQh3smdnLdCRvjuY5f4EwMAm/Ok7du3zM1zLNtB1H1w37rt
 K/NDGHOUB23LnIv0EaRxhCr6uXfw1LsH6j4CYXGtjtT9J92RUFjf5ZUyu69umOdrrnOz
 Dgai4j4XA1e5j8MnyyXwuGH40sDS0vu+M/+kwDI3KtnIV/btnRHkYpDFYFFBsMEg1bOq
 0HAPrXSscg2JhvaGToRauH0CXv3aqyAL4oU1xJOBNpeTfEENEA5n/pRyWd0a5q5OWDya
 QbLMxTUqzrM99OUK1ehTR12xqEVdCY+cSojrBWaed8CB4N21KDGipSItxo52idlmUL7W
 U2Ng==
X-Gm-Message-State: AC+VfDwLHRcAiMOS8R+AMaDU89aCjgEYWaLFDj2WoRLsrra5H4Lux3/E
 5ByF9UG4v7x9juFQoBauxsUFEg==
X-Google-Smtp-Source: ACHHUZ5WauqPWuzVwbbCM7sQ9PlEsup7ohuTtKWD2cYYNIVL/pEsXFcV4RvdmCyZbIvzdCV4lx/qdg==
X-Received: by 2002:aa7:88ce:0:b0:645:cfb0:2779 with SMTP id
 k14-20020aa788ce000000b00645cfb02779mr35734717pff.26.1684292192266; 
 Tue, 16 May 2023 19:56:32 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 b19-20020aa78713000000b00643355ff6a6sm14527971pfo.99.2023.05.16.19.56.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 19:56:31 -0700 (PDT)
To: stefanha@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v2 0/2] virtio: abstract virtqueue related methods
Date: Wed, 17 May 2023 10:54:22 +0800
Message-Id: <20230517025424.601141-1-pizhenwei@bytedance.com>
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

v1 -> v2:
- Suggested by MST, use fast path for vring based performance
sensitive API.
- Reduce changes in tools/virtio.

Add test result(no obvious change):
Before:
time ./vringh_test --parallel
Using CPUS 0 and 191
Guest: notified 10036893, pinged 68278
Host: notified 68278, pinged 3093532

real	0m14.463s
user	0m6.437s
sys	0m8.010s

After:
time ./vringh_test --parallel
Using CPUS 0 and 191
Guest: notified 10036709, pinged 68347
Host: notified 68347, pinged 3085292

real	0m14.196s
user	0m6.289s
sys	0m7.885s

v1:
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

 drivers/virtio/virtio_ring.c | 285 +++++-----------------
 include/linux/virtio.h       | 441 +++++++++++++++++++++++++++++++----
 include/linux/virtio_ring.h  |  26 +++
 tools/virtio/linux/virtio.h  | 355 +++++++++++++++++++++++++---
 4 files changed, 807 insertions(+), 300 deletions(-)

-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
