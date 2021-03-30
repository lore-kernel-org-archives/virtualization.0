Return-Path: <SRS0=i4sF=I4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7831FC433E2
	for <virtualization@archiver.kernel.org>; Tue, 30 Mar 2021 15:32:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D2A4619C5
	for <virtualization@archiver.kernel.org>; Tue, 30 Mar 2021 15:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2A4619C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A73F94043F;
	Tue, 30 Mar 2021 15:32:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fczCx-i7ppQu; Tue, 30 Mar 2021 15:32:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13B5E40483;
	Tue, 30 Mar 2021 15:32:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2CFAC000C;
	Tue, 30 Mar 2021 15:32:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97FB9C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 15:32:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7048B4031D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 15:32:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GcwRlB9yzhVC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 15:32:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8426B401B7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 15:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617118360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xpPRXfFLi0tNVEalh3rDH/QOq/YyI0RXG9DXsdcuwl8=;
 b=RXbeRweu1Db8GOe8IZztp/VzlbPvGckJ2I22QvODcdg+i9nHjh9QFZ75VmgdCOVaOSUW+w
 fFlTtTVK2Eg5bBnwBN3r+NTu/8QMPkWJmSsHOY//Oe9w4KIOlRhZG0NnX2CDwG+pwJ+ibi
 cguPPNFspQpQy1CnM4rcAhmHouGyzU8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-dUotWOBaMmGnX65ZO7LB_Q-1; Tue, 30 Mar 2021 11:32:36 -0400
X-MC-Unique: dUotWOBaMmGnX65ZO7LB_Q-1
Received: by mail-wr1-f72.google.com with SMTP id e10so6953298wru.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 08:32:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xpPRXfFLi0tNVEalh3rDH/QOq/YyI0RXG9DXsdcuwl8=;
 b=BGWjXH4LAs4x5McIaVV0qUzrANMho6X9tpvxB+XDX6H3ptHwih2rCgnmPsCmVxV3He
 RvvE8HSq4INVOYHOgH6/JUaKq5QcIXavdhqWAHDs65ow9uIy2IEY/OqIZBdKWXHpEJwD
 XGb91IQa2bQBg3qFKm+zfjql6no2LAxpEKwoh2q++1jrh6NyBvb/kZt8nBtnthN0Y/vi
 paAtZT9V4evU068+3+elaPoTli4ZXHZqdWkaLyqm6zICfMC9CqCqmALvb8lS7JZ0z0xI
 OVAjG5gGScuBcnzxC5bcEnkK7N+FfxGghiXmjaaR8392q0EkanYfvd2xVjVA4divDqFX
 5x/A==
X-Gm-Message-State: AOAM530m4EEh7JT7gEdf7gvppzks9QXQ0PeBJm5LFP6xpWe2h5jXOOzy
 /+ZE7R+83QI9/wxdpVp2MzIS3LbfgLJoEZ6vOb/6cFDAu08TH5il0E7hDZ99HmssAOXx5Ya28PB
 KbJYQmzaj48qtSN47NlXsRuGAIdqjDLPAz13UqgGDJw==
X-Received: by 2002:adf:fb91:: with SMTP id a17mr35383364wrr.118.1617118355077; 
 Tue, 30 Mar 2021 08:32:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFXYI/zYUIeoqnE6eFShZTCDtycfVJvqoDaXGlRGT1YF2bZQ4Fe7g3GSWdzHEtdIbMBJFC1A==
X-Received: by 2002:adf:fb91:: with SMTP id a17mr35383340wrr.118.1617118354824; 
 Tue, 30 Mar 2021 08:32:34 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id i26sm4695868wmb.18.2021.03.30.08.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Mar 2021 08:32:34 -0700 (PDT)
Date: Tue, 30 Mar 2021 17:32:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Jiang Wang ." <jiang.wang@bytedance.com>
Subject: Re: [External] Re: [RFC PATCH] virtio-vsock: add description for
 datagram type
Message-ID: <20210330153231.duj6wqnekztdherp@steredhat>
References: <20210316215644.2254177-1-jiang.wang@bytedance.com>
 <YFIj+FQQzZmVAqWw@stefanha-x1.localdomain>
 <CAP_N_Z857fnkc4GejHt_t_nxnhXC60=S51i_XQ-AdgXO2NipFA@mail.gmail.com>
 <YFjK7MkmJOFaUvgz@stefanha-x1.localdomain>
 <CAP_N_Z-aOds0-DgSYgGLb3AG7kvf=iqmLHojMjh878j8bTBkwg@mail.gmail.com>
 <20210322190517-mutt-send-email-mst@kernel.org>
 <CAP_N_Z_g1jgQE71WLPA45w72WJ8+1WFaP3zzXH8FRpFap=jqCA@mail.gmail.com>
 <YFmsb6o82KOSml9u@stefanha-x1.localdomain>
 <CAP_N_Z9g3VUeLGtC0D0EGmHk7D1RxFQvUBMzLDMkct5b=t6x3A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP_N_Z9g3VUeLGtC0D0EGmHk7D1RxFQvUBMzLDMkct5b=t6x3A@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: cong.wang@bytedance.com, Xiongchun Duan <duanxiongchun@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 Stefan Hajnoczi <stefanha@redhat.com>, asias@redhat.com,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Jiang,

On Fri, Mar 26, 2021 at 04:40:09PM -0700, Jiang Wang . wrote:
>Hi Michael and Stefan,
>
>I thought about this and discussed it with my colleague Cong Wang.
>One idea is to make current asynchronous send_pkt flow to be synchronous,
>then if the virtqueue is full, the function can return  ENOMEM all the way back
>to the caller and the caller can check the return value of sendmsg
>and slow down when necessary.
>
>In the spec, we can put something like, if the virtqueue is full, the caller
>should be notified with an error etc.
>
>In terms of implementation, that means we will remove the current
>send_pkt_work for both stream and dgram sockets. Currently, the
>code path uses RCU and a work queue, then grab a mutex in the
>work queue function. Since we cannot grab mutex when in rcu
>critical section, we have to change RCU to a normal reference
>counting mechanism. I think this is doable. The drawback is
>that the reference counting in general spends a little more
>cycles than the RCU, so there is a small price to pay. Another
>option is to use Sleepable RCU and remove the work queue.
>
>What do you guys think?

another thing that came to mind not related to the spec but to the Linux 
implementation, is the multi-transport support.
When we discussed the initial proposals [1][2], we decided to take a 
shortcut for DGRAM, since the only transport with DGRAM support was 
vmci. So for now only a single transport with VSOCK_TRANSPORT_F_DGRAM 
set can be registered.

Since also virtio-transport and vhost-transport will support DGRAM, we 
need to find a way to allow multiple transports that support DGRAM to be 
registered together to support nested VMs.

Do you have already thought about how to solve this problem?

We should definitely allow the registration of more transports with 
VSOCK_TRANSPORT_F_DGRAM, and dynamically choose which one to use when 
sending a packet.

Thanks,
Stefano

[1] https://www.spinics.net/lists/netdev/msg570274.html
[2] https://www.spinics.net/lists/netdev/msg575792.html

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
