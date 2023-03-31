Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F85C77B60
	for <virtualization@archiver.kernel.org>; Fri, 31 Mar 2023 07:21:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE6AA84466;
	Fri, 31 Mar 2023 07:21:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BE6AA84466
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t_eqb4NvGDUT; Fri, 31 Mar 2023 07:21:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 69F198449E;
	Fri, 31 Mar 2023 07:21:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 69F198449E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30D88C0036;
	Fri, 31 Mar 2023 07:21:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C38FC002F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:21:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 30F78421A1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:21:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 30F78421A1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FIble-fl5yjI
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:21:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5DA7F421B8
Received: from out30-111.freemail.mail.aliyun.com
 (out30-111.freemail.mail.aliyun.com [115.124.30.111])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5DA7F421B8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:21:18 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R331e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0Vf1F9lX_1680247271; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vf1F9lX_1680247271) by smtp.aliyun-inc.com;
 Fri, 31 Mar 2023 15:21:12 +0800
Message-ID: <1680247235.3085878-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 8/8] virtio_net: introduce receive_small_xdp()
Date: Fri, 31 Mar 2023 15:20:35 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Paolo Abeni <pabeni@redhat.com>
References: <20230328120412.110114-1-xuanzhuo@linux.alibaba.com>
 <20230328120412.110114-9-xuanzhuo@linux.alibaba.com>
 <343825bad568ec0a21c283f876585585b040da9f.camel@redhat.com>
In-Reply-To: <343825bad568ec0a21c283f876585585b040da9f.camel@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

On Thu, 30 Mar 2023 12:48:22 +0200, Paolo Abeni <pabeni@redhat.com> wrote:
> On Tue, 2023-03-28 at 20:04 +0800, Xuan Zhuo wrote:
> > @@ -949,15 +1042,11 @@ static struct sk_buff *receive_small(struct net_device *dev,
> >  {
> >  	struct sk_buff *skb;
> >  	struct bpf_prog *xdp_prog;
> > -	unsigned int xdp_headroom = (unsigned long)ctx;
> > -	unsigned int header_offset = VIRTNET_RX_PAD + xdp_headroom;
> > +	unsigned int header_offset = VIRTNET_RX_PAD;
> >  	unsigned int headroom = vi->hdr_len + header_offset;
>
> This changes (reduces) the headroom for non-xpd-pass skbs.
>
> [...]
> > +	buf += header_offset;
> > +	memcpy(skb_vnet_hdr(skb), buf, vi->hdr_len);
>
> AFAICS, that also means that receive_small(), for such packets, will
> look for the virtio header in a different location. Is that expected?


That is a mistake.

Will fix.

Thanks.

>
> Thanks.
>
> Paolo
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
