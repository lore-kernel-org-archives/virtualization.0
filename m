Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBC6C76196
	for <virtualization@archiver.kernel.org>; Fri, 31 Mar 2023 07:25:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42BD48445D;
	Fri, 31 Mar 2023 07:25:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 42BD48445D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ry2Y8VMZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hpm_NeFvlkNI; Fri, 31 Mar 2023 07:25:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2F3FE84143;
	Fri, 31 Mar 2023 07:25:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2F3FE84143
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB72EC0036;
	Fri, 31 Mar 2023 07:25:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00669C002F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:25:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8D7884151
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:25:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C8D7884151
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id abVl_-BQwnPx
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:25:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1BBC484143
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1BBC484143
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680247504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VPSbdMbPx11k4M8+J8Q+rCNz0C06kx/qXnXgmGgyU7E=;
 b=Ry2Y8VMZsLfmS6wDPQrGfVjy/2P2ZzwcX8Y4f9I3kBTB9XkfwImaWhR9axjjSncoOUxs5U
 ZqxJW4YpSrFslpGvSWPzhWpf7edmCmuNYlvwhvkNe1RirWu9CBmR4Y/Jz6znP3LcARB4Ui
 5UyC55foPDzwzUfFU2KkIfbKtEaNYy0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-UXWALaNtObuUvh-MsGJPjQ-1; Fri, 31 Mar 2023 03:25:03 -0400
X-MC-Unique: UXWALaNtObuUvh-MsGJPjQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 u14-20020a05600c19ce00b003f0331154b1so2687708wmq.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 00:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680247502;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VPSbdMbPx11k4M8+J8Q+rCNz0C06kx/qXnXgmGgyU7E=;
 b=hMYd/Sn9Jor7vOCMlIi/ipB2zzmOqwTvI/IDt9rx7RT8cqR4UHe1OGkHHuVuaSjYLz
 1OApjQBUSMTOX1e3UPBwkuPLw6lqfxFUGNSluTpApebe/FHmO3YwUncEkn4+SMEgP1ba
 dPNzgH+gIVglwrsFvnoVIJK0dWMj0xhE3fDzukT//1IyaytldqYuZcCt4TdV8LT5stew
 CfMUJJ37q0+sWlqof+DXncUFz3vQwC22lgG7aAKzM77wqPu674T39N3xuYhm2zvcH4DN
 Ksq4PyHSFFlq33ZZXJlmMf/YA+v8XYQvCEvTphxh46UWcOXqh1S6VghAcnBiX+l92TTs
 twnw==
X-Gm-Message-State: AAQBX9epcy7JEIpGaqqDW87lELWiC6qlinBe4P1Q8mjT8vYwhlgh2h4m
 q0ub11wSHTWcwOBobqO+hXFjsYeR6eLW+2I3Z55jZYSdfhvpKvpWkxg+bwFahGtbevcLam0TxMJ
 b8a7ub3voFAHKUlXjmXXDDvc9vijh+0yVZ4ON4puG+g==
X-Received: by 2002:a05:600c:241:b0:3f0:3a57:f01e with SMTP id
 1-20020a05600c024100b003f03a57f01emr2956394wmj.4.1680247502185; 
 Fri, 31 Mar 2023 00:25:02 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y08BdWXqdQRGJH998OLYyVlQMH54B5che3e83idrXE64Gc4f2CsyU9Ise5WEsqQaQFWkNEIg==
X-Received: by 2002:a05:600c:241:b0:3f0:3a57:f01e with SMTP id
 1-20020a05600c024100b003f03a57f01emr2956380wmj.4.1680247501930; 
 Fri, 31 Mar 2023 00:25:01 -0700 (PDT)
Received: from redhat.com ([2.52.159.107]) by smtp.gmail.com with ESMTPSA id
 h16-20020a05600c315000b003eda46d6792sm8851744wmo.32.2023.03.31.00.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Mar 2023 00:25:01 -0700 (PDT)
Date: Fri, 31 Mar 2023 03:24:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 8/8] virtio_net: introduce receive_small_xdp()
Message-ID: <20230331032429-mutt-send-email-mst@kernel.org>
References: <20230328120412.110114-1-xuanzhuo@linux.alibaba.com>
 <20230328120412.110114-9-xuanzhuo@linux.alibaba.com>
 <343825bad568ec0a21c283f876585585b040da9f.camel@redhat.com>
 <1680247235.3085878-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1680247235.3085878-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
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

On Fri, Mar 31, 2023 at 03:20:35PM +0800, Xuan Zhuo wrote:
> On Thu, 30 Mar 2023 12:48:22 +0200, Paolo Abeni <pabeni@redhat.com> wrote:
> > On Tue, 2023-03-28 at 20:04 +0800, Xuan Zhuo wrote:
> > > @@ -949,15 +1042,11 @@ static struct sk_buff *receive_small(struct net_device *dev,
> > >  {
> > >  	struct sk_buff *skb;
> > >  	struct bpf_prog *xdp_prog;
> > > -	unsigned int xdp_headroom = (unsigned long)ctx;
> > > -	unsigned int header_offset = VIRTNET_RX_PAD + xdp_headroom;
> > > +	unsigned int header_offset = VIRTNET_RX_PAD;
> > >  	unsigned int headroom = vi->hdr_len + header_offset;
> >
> > This changes (reduces) the headroom for non-xpd-pass skbs.
> >
> > [...]
> > > +	buf += header_offset;
> > > +	memcpy(skb_vnet_hdr(skb), buf, vi->hdr_len);
> >
> > AFAICS, that also means that receive_small(), for such packets, will
> > look for the virtio header in a different location. Is that expected?
> 
> 
> That is a mistake.
> 
> Will fix.
> 
> Thanks.

Do try to test small and big packet configurations though, too.

> >
> > Thanks.
> >
> > Paolo
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
