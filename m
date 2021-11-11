Return-Path: <SRS0=fJjx=P6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE88C433F5
	for <virtualization@archiver.kernel.org>; Thu, 11 Nov 2021 22:48:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27E9461039
	for <virtualization@archiver.kernel.org>; Thu, 11 Nov 2021 22:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 27E9461039
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D579B6067F;
	Thu, 11 Nov 2021 22:48:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uvj37w2UTcgf; Thu, 11 Nov 2021 22:48:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 935E960625;
	Thu, 11 Nov 2021 22:48:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6961AC0012;
	Thu, 11 Nov 2021 22:48:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFE54C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 22:48:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9FB784037A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 22:48:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RUQ1ATT6H4RY
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 22:48:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 22D004010B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 22:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
 Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=P8dbu6bq4K+PWUujkU4hjoft1+fqI27MatlMJ/QyGuI=; b=DIEtXFmC2F85m71vwyPLcjKOQk
 XjZEbHKR4s6o9R+TJFbZJAX5w6NIoGC4G7Tyr4UiU2sDuxm/bM/DqzgQfEXijaLfYzbsZMB+nW2Pg
 3fS5axfaKR/QoXehw3rpT5x08XLk3pdS95g4GbvhgzZTXlpNNp6aQoUMl8nKH29W8h0noSg8OSL0n
 bfGMRaMuz1qL/dM15gvBb/UkqsFSNFor48hNDm5vJjOo3uKFAeVY6JWhl++NRpUh8COLKxDqePUS7
 nbT7OL0ngCIQOs/4Ikle6bmn7BGmq4XLLkOsvsgEBmXO9v2HT1XAil0vxpAZBxgPPz22kmyXqe6R9
 rLTU1SPQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1mlIrp-008vaU-R6; Thu, 11 Nov 2021 22:48:25 +0000
Date: Thu, 11 Nov 2021 14:48:25 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: mst@redhat.com, david@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org,
 Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: update_balloon_size_func blocked for more than 120 seconds
Message-ID: <YY2duTi0wAyAKUTJ@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Cc: Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org
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

I get the following splats with a kvm guest in idle, after a few seconds
it starts:

[  242.412806] INFO: task kworker/6:2:271 blockedfor more than 120 seconds.
[  242.415790]       Tainted: G            E     5.15.0-next-20211111 #68
[  242.417755] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  242.418332] task:kworker/6:2     state:D stack:    0 pid:  271 ppid: 2 flags:0x00004000
[  242.418954] Workqueue: events_freezable update_balloon_size_func [virtio_balloon]
[  242.419518] Call Trace:
[  242.419709]  <TASK>
[  242.419873]  __schedule+0x2fd/0x990
[  242.420142]  schedule+0x4e/0xc0
[  242.420382]  tell_host+0xaa/0xf0 [virtio_balloon]
[  242.420757]  ? do_wait_intr_irq+0xa0/0xa0
[  242.421065]  update_balloon_size_func+0x2c9/0x2e0 [virtio_balloon]
[  242.421527]  process_one_work+0x1e5/0x3c0
[  242.421833]  worker_thread+0x50/0x3b0
[  242.422204]  ? rescuer_thread+0x370/0x370
[  242.422507]  kthread+0x169/0x190
[  242.422754]  ? set_kthread_struct+0x40/0x40
[  242.423073]  ret_from_fork+0x1f/0x30
[  242.423347]  </TASK>

And this goes on endlessly. The last one says it blocked for more than 1208
seconds. This was not happening until the last few weeks but I see no
relevant recent commits for virtio_balloon, so the related change could
be elsewhere.

I could bisect but first I figured I'd check to see if someone already
had spotted this.

  Luis
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
