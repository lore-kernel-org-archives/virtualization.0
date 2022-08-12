Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE747C25B06
	for <virtualization@archiver.kernel.org>; Fri, 12 Aug 2022 01:33:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5611140914;
	Fri, 12 Aug 2022 01:33:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5611140914
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FbmR9Jcq0dXu; Fri, 12 Aug 2022 01:33:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C22704063F;
	Fri, 12 Aug 2022 01:33:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C22704063F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 975F4C0033;
	Fri, 12 Aug 2022 01:33:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98359C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 01:33:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6B2514069B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 01:33:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6B2514069B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tk5AEZrBOoMW
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 01:33:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 89D49404E8
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 89D49404E8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 01:33:36 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0VM.UGd7_1660268012; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VM.UGd7_1660268012) by smtp.aliyun-inc.com;
 Fri, 12 Aug 2022 09:33:32 +0800
Message-ID: <1660267838.1945586-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 0/2] virtio_net: fix for stuck when change ring size
 with dev down
Date: Fri, 12 Aug 2022 09:30:38 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
References: <20220811080258.79398-1-xuanzhuo@linux.alibaba.com>
 <20220811041041-mutt-send-email-mst@kernel.org>
 <20220811103730.0f085866@kernel.org>
In-Reply-To: <20220811103730.0f085866@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, 11 Aug 2022 10:37:30 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Thu, 11 Aug 2022 04:11:22 -0400 Michael S. Tsirkin wrote:
> > Which patches does this fix?
> > Maybe I should squash.
>
> Side question to make sure I understand the terminology - this
> is *not* a vhost patch, right? vhost is the host side of virtio?
> Is the work going via the vhost tree because of some dependencies?


Yes, the commits fixed by this patch are currently in Michael's vhost branch.

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/log/?h=linux-next

So I mean that by "vhost" here, not into the net/net-next branch. Or should I use
a more accurate term next time?

Thanks.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
