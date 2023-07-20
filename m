Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914C6EB64DA
	for <virtualization@archiver.kernel.org>; Thu, 20 Jul 2023 08:38:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2538B81604;
	Thu, 20 Jul 2023 08:38:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2538B81604
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XUPg56eG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zkJ1TRUnFW2I; Thu, 20 Jul 2023 08:38:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B7FE481773;
	Thu, 20 Jul 2023 08:38:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B7FE481773
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DA1DC0071;
	Thu, 20 Jul 2023 08:38:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20EF6C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 08:38:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DBF1581773
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 08:38:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DBF1581773
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tf_zlYkjkz8G
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 08:38:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 394A581604
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 08:38:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 394A581604
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689842328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uD8lCSCMjSGZH3wOzVWgkovAsvnWHdzdpIGokpNxVkQ=;
 b=XUPg56eGvAuZIPBh9Rfetn4dFYGWWb1rBR3UeU+stAU4AlqEttVtfM8IScdyudqgXZ4TbH
 JNpCOtkCbJIjOjoVmaYJFmibJ0pnQGJc2k9qlmO1dmlXBiGLVaGFqxK9jjUF3fUApQrqJ0
 baFk9h/a3/2f4qB/H1yjGMEAONKGFOQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-MUO2sSHNPdOz-BhsdqPtqg-1; Thu, 20 Jul 2023 04:38:47 -0400
X-MC-Unique: MUO2sSHNPdOz-BhsdqPtqg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4532E1C04B62;
 Thu, 20 Jul 2023 08:38:46 +0000 (UTC)
Received: from dell-per430-12.lab.eng.pek2.redhat.com
 (dell-per430-12.lab.eng.pek2.redhat.com [10.73.196.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAEEBF6CD8;
 Thu, 20 Jul 2023 08:38:41 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Subject: [PATCH net-next v4 0/2] virtio-net: don't busy poll for cvq command
Date: Thu, 20 Jul 2023 04:38:37 -0400
Message-Id: <20230720083839.481487-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 maxime.coquelin@redhat.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
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

Hi all:

The code used to busy poll for cvq command which turns out to have
several side effects:

1) infinite poll for buggy devices
2) bad interaction with scheduler

So this series tries to use cond_resched() in the waiting loop. Before
doing this we need first make sure the cvq command is not executed in
atomic environment, so we need first convert rx mode handling to a
workqueue.

Note that, this doesn't try to solve the case that a malicous device
may block networking stack (RTNL) or break freezer which requries more
thought to gracefully exit and resend the commands.

Please review.

Changes since V3:

- Tweak the comments
- Tweak the changelog to explain the rx mode lost after resuming.
- No functional changes

Changes since V2:

- Don't use interrupt but cond_resched()

Changes since V1:

- use RTNL to synchronize rx mode worker
- use completion for simplicity
- don't try to harden CVQ command

Changes since RFC:

- switch to use BAD_RING in virtio_break_device()
- check virtqueue_is_broken() after being woken up
- use more_used() instead of virtqueue_get_buf() to allow caller to
  get buffers afterwards
- break the virtio-net device when timeout
- get buffer manually since the virtio core check more_used() instead

Jason Wang (2):
  virtio-net: convert rx mode setting to use workqueue
  virtio-net: add cond_resched() to the command waiting loop

 drivers/net/virtio_net.c | 59 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 4 deletions(-)

-- 
2.39.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
