Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1149C77B7E
	for <virtualization@archiver.kernel.org>; Tue, 18 Apr 2023 06:53:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1C77540CA5;
	Tue, 18 Apr 2023 06:53:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C77540CA5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3PdaApXOcuMs; Tue, 18 Apr 2023 06:53:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8CCF440C12;
	Tue, 18 Apr 2023 06:53:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8CCF440C12
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 475C3C0037;
	Tue, 18 Apr 2023 06:53:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30782C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 06:53:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F29CE817EB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 06:53:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F29CE817EB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kRfxkmZ_OeW2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 06:53:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 20B97817D3
Received: from out30-111.freemail.mail.aliyun.com
 (out30-111.freemail.mail.aliyun.com [115.124.30.111])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 20B97817D3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 06:53:33 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VgOIH1e_1681800807; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VgOIH1e_1681800807) by smtp.aliyun-inc.com;
 Tue, 18 Apr 2023 14:53:28 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v2 00/14] virtio_net: refactor xdp codes
Date: Tue, 18 Apr 2023 14:53:13 +0800
Message-Id: <20230418065327.72281-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
X-Git-Hash: d931ac25730a
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

Due to historical reasons, the implementation of XDP in virtio-net is relatively
chaotic. For example, the processing of XDP actions has two copies of similar
code. Such as page, xdp_page processing, etc.

The purpose of this patch set is to refactor these code. Reduce the difficulty
of subsequent maintenance. Subsequent developers will not introduce new bugs
because of some complex logical relationships.

In addition, the supporting to AF_XDP that I want to submit later will also need
to reuse the logic of XDP, such as the processing of actions, I don't want to
introduce a new similar code. In this way, I can reuse these codes in the
future.

Please review.

Thanks.

v2:
    1. re-split to make review more convenient

v1:
    1. fix some variables are uninitialized

Xuan Zhuo (14):
  virtio_net: mergeable xdp: put old page immediately
  virtio_net: introduce mergeable_xdp_prepare()
  virtio_net: optimize mergeable_xdp_prepare()
  virtio_net: introduce virtnet_xdp_handler() to seprate the logic of
    run xdp
  virtio_net: introduce xdp res enums
  virtio_net: separate the logic of freeing xdp shinfo
  virtio_net: separate the logic of freeing the rest mergeable buf
  virtio_net: auto release xdp shinfo
  virtio_net: introduce receive_mergeable_xdp()
  virtio_net: merge: remove skip_xdp
  virtio_net: introduce receive_small_xdp()
  virtio_net: small: optimize code
  virtio_net: small: optimize code
  virtio_net: small: remove skip_xdp

 drivers/net/virtio_net.c | 625 +++++++++++++++++++++++----------------
 1 file changed, 362 insertions(+), 263 deletions(-)

--
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
