Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6498DC77B7F
	for <virtualization@archiver.kernel.org>; Tue,  9 May 2023 01:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CB53541D49;
	Tue,  9 May 2023 01:54:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CB53541D49
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hC6PEnBANLWb; Tue,  9 May 2023 01:54:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4EF8F400E2;
	Tue,  9 May 2023 01:54:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4EF8F400E2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29C48C0037;
	Tue,  9 May 2023 01:54:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 574A1C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 May 2023 01:54:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2F837416A3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 May 2023 01:54:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2F837416A3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rLD2ri3zc6P4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 May 2023 01:54:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B44D34167F
Received: from out30-100.freemail.mail.aliyun.com
 (out30-100.freemail.mail.aliyun.com [115.124.30.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B44D34167F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 May 2023 01:54:14 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0Vi8pzhn_1683597247; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vi8pzhn_1683597247) by smtp.aliyun-inc.com;
 Tue, 09 May 2023 09:54:08 +0800
Message-ID: <1683597099.3423615-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_net: set default mtu to 1500 when 'Device maximum
 MTU' bigger than 1500
Date: Tue, 9 May 2023 09:51:39 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230506021529.396812-1-chenh@yusur.tech>
 <1683341417.0965195-4-xuanzhuo@linux.alibaba.com>
 <07b6b325-9a15-222f-e618-d149b57cbac2@yusur.tech>
 <20230507045627-mutt-send-email-mst@kernel.org>
 <1683511319.099806-2-xuanzhuo@linux.alibaba.com>
 <20230508020953-mutt-send-email-mst@kernel.org>
 <1683526688.7492425-1-xuanzhuo@linux.alibaba.com>
 <20230508024147-mutt-send-email-mst@kernel.org>
 <1683531716.238961-1-xuanzhuo@linux.alibaba.com>
 <20230508062928-mutt-send-email-mst@kernel.org>
 <20230508092548.5fc8f078@hermes.local>
 <20230508140640-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230508140640-mutt-send-email-mst@kernel.org>
Cc: zy@yusur.tech, Hao Chen <chenh@yusur.tech>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Eric Dumazet <edumazet@google.com>, hengqi@linux.alibaba.com,
 huangml@yusur.tech, Jakub Kicinski <kuba@kernel.org>,
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

On Mon, 8 May 2023 14:10:07 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, May 08, 2023 at 09:25:48AM -0700, Stephen Hemminger wrote:
> > On Mon, 8 May 2023 06:30:07 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >
> > > > > > I don't know, in any scenario, when the hardware supports a large mtu, but we do
> > > > > > not want the user to use it by default.
> > > > >
> > > > > When other devices on the same LAN have mtu set to 1500 and
> > > > > won't accept bigger packets.
> > > >
> > > > So, that depends on pmtu/tcp-probe-mtu.
> > > >
> > > > If the os without pmtu/tcp-probe-mtu has a bigger mtu, then it's big packet
> > > > will lost.
> > > >
> > > > Thanks.
> > > >
> > >
> > > pmtu is designed for routing. LAN is supposed to be configured with
> > > a consistent MTU.
> >
> > Virtio is often used with bridging or macvlan which can't support PMTU.
> > PMTU only works when forwarding at layer 3 (ie routing) where there is
> > a IP address to send the ICMP response. If doing L2 forwarding, the
> > only thin the bridge can do is drop the packet.
> >
> > TCP cab recover but detecting an MTU blackhole requires retransmissions.
>
> Exactly. That's why we basically use the MTU advice supplied by device
> by default - it's designed for use-cases of software devices where
> the device might have more information about the MTU than the guest.
> If hardware devices want e.g. a way to communicate support for
> jumbo frames without communicating any information about the LAN,
> a new feature will be needed.


Let's think this question carefully. If necessary, we will try to introduce a
new feature for virtio-net spec to support Jumbo Frame.

Thanks.


>
> --
> MST
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
