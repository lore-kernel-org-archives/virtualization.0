Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043AAC00A98
	for <virtualization@archiver.kernel.org>; Fri, 20 Oct 2023 15:58:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B77384BD8;
	Fri, 20 Oct 2023 15:58:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6B77384BD8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LAgP6YAP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4OwrZKErNGQg; Fri, 20 Oct 2023 15:58:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CA0F784BDF;
	Fri, 20 Oct 2023 15:58:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CA0F784BDF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2C1FC0DD2;
	Fri, 20 Oct 2023 15:58:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D63D8C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 15:58:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9FB53433AD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 15:58:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9FB53433AD
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LAgP6YAP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vHxieXrwOxNR
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 15:58:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8BEFE433B5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 15:58:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8BEFE433B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697817523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=umrr8klAQ5M6VrOQW9RqPBZxb5qUD5G43p73Sx5jNAU=;
 b=LAgP6YAPbY+8vDuC50vm1Nsof4vYYDOBwu2noEdqYyqveFbrVrUO36VRWPRxHn6w/pdb/I
 We09ZJ+6cqphBE61OXcWbs8HrdYcxAh7L+Bib1o6U311BjHJ0d+tJQsa5dpjdK0i85PmEi
 YVJ011MTIPvLCfyfa9stc68os8emjno=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-uMYW_5-WPJydi6sEzSiaKA-1; Fri, 20 Oct 2023 11:58:29 -0400
X-MC-Unique: uMYW_5-WPJydi6sEzSiaKA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13A5988B773;
 Fri, 20 Oct 2023 15:58:29 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A9B3C503B;
 Fri, 20 Oct 2023 15:58:25 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 stephen.smalley.work@gmail.com, eparis@parisplace.org,
 xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, david.marchand@redhat.com, lulu@redhat.com
Subject: [PATCH v4 0/4] vduse: add support for networking devices
Date: Fri, 20 Oct 2023 17:58:15 +0200
Message-ID: <20231020155819.24000-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
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

This small series enables virtio-net device type in VDUSE.
With it, basic operation have been tested, both with
virtio-vdpa and vhost-vdpa using DPDK Vhost library series
adding VDUSE support using split rings layout (merged in
DPDK v23.07-rc1).

Control queue support (and so multiqueue) has also been
tested, but requires a Kernel series from Jason Wang
relaxing control queue polling [1] to function reliably,
so while Jason rework is done, a patch is added to disable
CVQ and features that depend on it (tested also with DPDK
v23.07-rc1).

In this v4, LSM hooks are added to allow/deny application
to create/destroy/open devices based on their type (Net,
Block).

[1]: https://lore.kernel.org/lkml/CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0WvjGRr3whU+QasUg@mail.gmail.com/T/

v3->v4 changes:
===============
- Add LSM hooks (Michael)
- Rebase

v2 -> v3 changes:
=================
- Use allow list instead of deny list (Michael)

v1 -> v2 changes:
=================
- Add a patch to disable CVQ (Michael)

RFC -> v1 changes:
==================
- Fail device init if it does not support VERSION_1 (Jason)

Maxime Coquelin (4):
  vduse: validate block features only with block devices
  vduse: enable Virtio-net device type
  vduse: Temporarily disable control queue features
  vduse: Add LSM hooks to check Virtio device type

 drivers/vdpa/vdpa_user/vduse_dev.c  | 64 +++++++++++++++++++++++++++--
 include/linux/lsm_hook_defs.h       |  4 ++
 include/linux/security.h            | 15 +++++++
 security/security.c                 | 42 +++++++++++++++++++
 security/selinux/hooks.c            | 55 +++++++++++++++++++++++++
 security/selinux/include/classmap.h |  2 +
 6 files changed, 178 insertions(+), 4 deletions(-)

-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
