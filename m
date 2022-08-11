Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B85C19F2D
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 08:13:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABF4560FCA;
	Thu, 11 Aug 2022 08:13:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ABF4560FCA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AwC1dd8-4CsO; Thu, 11 Aug 2022 08:13:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4C3E060E64;
	Thu, 11 Aug 2022 08:13:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4C3E060E64
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A873C0033;
	Thu, 11 Aug 2022 08:13:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D02CC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:13:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5FAA660F2F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:13:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5FAA660F2F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ravafDlLWBby
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:13:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2C54460E64
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2C54460E64
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:13:22 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0VLyTMzl_1660205596; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VLyTMzl_1660205596) by smtp.aliyun-inc.com;
 Thu, 11 Aug 2022 16:13:17 +0800
Message-ID: <1660205553.7374692-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 0/2] virtio_net: fix for stuck when change ring size
 with dev down
Date: Thu, 11 Aug 2022 16:12:33 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20220811080258.79398-1-xuanzhuo@linux.alibaba.com>
 <20220811041041-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220811041041-mutt-send-email-mst@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
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

On Thu, 11 Aug 2022 04:11:22 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Aug 11, 2022 at 04:02:56PM +0800, Xuan Zhuo wrote:
> > When dev is set to DOWN state, napi has been disabled, if we modify the
> > ring size at this time, we should not call napi_disable() again, which
> > will cause stuck.
> >
> > And all operations are under the protection of rtnl_lock, so there is no
> > need to consider concurrency issues.
> >
> > PS.
> > Hi Michael, I don't know which way is more convenient for you, so I split the
> > commit into two commits, so you can fixup to my previous commit:
> >
> >     virtio_net: support tx queue resize
> > 	virtio_net: support rx queue resize
> >
> > Xuan Zhuo (2):
> >   virtio_net: fix for stuck when change rx ring size with dev down
> >   virtio_net: fix for stuck when change tx ring size with dev down
> >
> >  drivers/net/virtio_net.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
>
>
> Which patches does this fix?
> Maybe I should squash.

These two:
     virtio_net: support tx queue resize
     virtio_net: support rx queue resize

Thanks.


>
> > --
> > 2.31.0
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
