Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9ABC07E9D
	for <virtualization@archiver.kernel.org>; Thu, 29 Sep 2022 07:40:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 753516059C;
	Thu, 29 Sep 2022 07:40:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 753516059C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C2ehiRqR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CS4awAYkCFur; Thu, 29 Sep 2022 07:40:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EFCC0607A3;
	Thu, 29 Sep 2022 07:40:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EFCC0607A3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3E9CC0033;
	Thu, 29 Sep 2022 07:40:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40E39C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:40:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 05D4983ECE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:40:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 05D4983ECE
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=C2ehiRqR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KK8UXupUVYOF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:40:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4070483E69
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4070483E69
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664437225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oaCFqrQ5GzdKP7AhOQ10Zj7koIi79amAnF/+mMQ81sg=;
 b=C2ehiRqR18C32CsrbUOuXXBHx729r95iKMTcgINXXE2o9XPnq7Mh0KwjOWIakwx9a3NQ1v
 1rEwpElOnAOvLuRblzt9+UK8jlVi3Rk2RqSKaC2lgMFHb4x1YdhXO0/kJ3TCXVdlMO03vz
 Qvowoke1FdeU1L/ym16PBIM7r8uUon4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-269-6jXOaNB1OoyCXrpcKbdNJA-1; Thu, 29 Sep 2022 03:40:21 -0400
X-MC-Unique: 6jXOaNB1OoyCXrpcKbdNJA-1
Received: by mail-qt1-f197.google.com with SMTP id
 i12-20020ac871cc000000b0035ba1b1ba9cso373800qtp.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 00:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=oaCFqrQ5GzdKP7AhOQ10Zj7koIi79amAnF/+mMQ81sg=;
 b=7fto8aTI1HmfDQGMNGeEb4sijDsROiNq12Zd46+jFwKyKYKdK+YoM/AzYXL/dhCdXv
 F8BzQNl6EHbiZi5jP8BL+34YFNJnGC+AoZuGxDqzg926Wkt6RjhfIDwHPuyxBOe5CWd3
 hCHmQUELcGR2ikVJLEizh7XJ2ui95deLca8GFTA/xNnLw0Ah8X2dPsiHdNMft2yZJKVR
 OHZa5QHB+Cws8BxqCu+6Y+MbGra78YlBWpBDDCG2I2nGn+RHOMwhclmqNFHzW7dYWsfd
 Ac4NPDzYEQbUM52luHLZqhzXQ4cEUpFX+YPPI+7l9+2cGQA1Qf2Cgcz6sR6m/rFjfKFd
 Tvzg==
X-Gm-Message-State: ACrzQf1jien87lQrYP8JwpsscrjDv26wBiAQUtr7G633EM+kCNjmhcmc
 VVd87CvGxMuncn8JJA+a//OSVTUYGosw0BVEt2TjFuwRpUwm2PRN0+rT+iDBAqKar6rLGvKOdAX
 I3UaVqZ/iH91ZdsPNmoSlVJ2zAgQfjF/k2Kxx6b2wnQ==
X-Received: by 2002:a05:620a:c15:b0:6ce:d1db:f7dc with SMTP id
 l21-20020a05620a0c1500b006ced1dbf7dcmr1200825qki.259.1664437221183; 
 Thu, 29 Sep 2022 00:40:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7ojPjmY7apjIi1WK+7gxu/7NwTtehomIcT45iZfLQ6HJTQ6dVYty87P02i03q/EK/PFipsQA==
X-Received: by 2002:a05:620a:c15:b0:6ce:d1db:f7dc with SMTP id
 l21-20020a05620a0c1500b006ced1dbf7dcmr1200814qki.259.1664437220936; 
 Thu, 29 Sep 2022 00:40:20 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-222.retail.telecomitalia.it.
 [79.46.200.222]) by smtp.gmail.com with ESMTPSA id
 x11-20020a05620a258b00b006bac157ec19sm5392848qko.123.2022.09.29.00.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Sep 2022 00:40:20 -0700 (PDT)
Date: Thu, 29 Sep 2022 09:40:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost/vsock: Use kvmalloc/kvfree for larger packets.
Message-ID: <20220929074010.37mksjmwr3l4wlwt@sgarzare-redhat>
References: <20220928064538.667678-1-uekawa@chromium.org>
 <20220928082823.wyxplop5wtpuurwo@sgarzare-redhat>
 <20220928052738-mutt-send-email-mst@kernel.org>
 <20220928151135.pvrlsylg6j3hzh74@sgarzare-redhat>
 <20220928160116-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220928160116-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Junichi Uekawa <uekawa@chromium.org>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, Bobby Eshleman <bobby.eshleman@gmail.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Sep 28, 2022 at 04:02:12PM -0400, Michael S. Tsirkin wrote:
>On Wed, Sep 28, 2022 at 05:11:35PM +0200, Stefano Garzarella wrote:
>> On Wed, Sep 28, 2022 at 05:31:58AM -0400, Michael S. Tsirkin wrote:
>> > On Wed, Sep 28, 2022 at 10:28:23AM +0200, Stefano Garzarella wrote:
>> > > On Wed, Sep 28, 2022 at 03:45:38PM +0900, Junichi Uekawa wrote:
>> > > > When copying a large file over sftp over vsock, data size is usually 32kB,
>> > > > and kmalloc seems to fail to try to allocate 32 32kB regions.
>> > > >
>> > > > Call Trace:
>> > > >  [<ffffffffb6a0df64>] dump_stack+0x97/0xdb
>> > > >  [<ffffffffb68d6aed>] warn_alloc_failed+0x10f/0x138
>> > > >  [<ffffffffb68d868a>] ? __alloc_pages_direct_compact+0x38/0xc8
>> > > >  [<ffffffffb664619f>] __alloc_pages_nodemask+0x84c/0x90d
>> > > >  [<ffffffffb6646e56>] alloc_kmem_pages+0x17/0x19
>> > > >  [<ffffffffb6653a26>] kmalloc_order_trace+0x2b/0xdb
>> > > >  [<ffffffffb66682f3>] __kmalloc+0x177/0x1f7
>> > > >  [<ffffffffb66e0d94>] ? copy_from_iter+0x8d/0x31d
>> > > >  [<ffffffffc0689ab7>] vhost_vsock_handle_tx_kick+0x1fa/0x301 [vhost_vsock]
>> > > >  [<ffffffffc06828d9>] vhost_worker+0xf7/0x157 [vhost]
>> > > >  [<ffffffffb683ddce>] kthread+0xfd/0x105
>> > > >  [<ffffffffc06827e2>] ? vhost_dev_set_owner+0x22e/0x22e [vhost]
>> > > >  [<ffffffffb683dcd1>] ? flush_kthread_worker+0xf3/0xf3
>> > > >  [<ffffffffb6eb332e>] ret_from_fork+0x4e/0x80
>> > > >  [<ffffffffb683dcd1>] ? flush_kthread_worker+0xf3/0xf3
>> > > >
>> > > > Work around by doing kvmalloc instead.
>> > > >
>> > > > Signed-off-by: Junichi Uekawa <uekawa@chromium.org>
>> >
>> > My worry here is that this in more of a work around.
>> > It would be better to not allocate memory so aggressively:
>> > if we are so short on memory we should probably process
>> > packets one at a time. Is that very hard to implement?
>>
>> Currently the "virtio_vsock_pkt" is allocated in the "handle_kick" callback
>> of TX virtqueue. Then the packet is multiplexed on the right socket queue,
>> then the user space can de-queue it whenever they want.
>>
>> So maybe we can stop processing the virtqueue if we are short on memory, but
>> when can we restart the TX virtqueue processing?
>
>Assuming you added at least one buffer, the time to restart would be
>after that buffer has been used.

Yes, but we still might not have as many continuous pages to allocate, 
so I would use kvmalloc the same.

I agree that we should do better, I hope that moving to sk_buff will 
allow us to better manage allocation. Maybe after we merge that part we 
should spend some time to solve these problems.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
