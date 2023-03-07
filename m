Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDBBC678D5
	for <virtualization@archiver.kernel.org>; Tue,  7 Mar 2023 16:00:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3AA081975;
	Tue,  7 Mar 2023 16:00:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A3AA081975
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Izg3Jg6C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XL0AxNbsi7ux; Tue,  7 Mar 2023 16:00:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2A2DA8186E;
	Tue,  7 Mar 2023 15:59:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2A2DA8186E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05621C0071;
	Tue,  7 Mar 2023 15:59:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31BD6C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 15:59:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0C1D36108F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 15:59:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0C1D36108F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Izg3Jg6C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pCqI1ILiU7MC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 15:59:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 49C1460ABA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 49C1460ABA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 15:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678204795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I0FHpHDfgMNKIF0PugEg3oYZEslsm/Wba3C2OVAQmj8=;
 b=Izg3Jg6CYaaMo5EAyzqv9m+GruL1/gKP0jwc7rOlYhRdfrpxHWB7A6F+ehPCS67mLBjZYy
 ymtlklD3M4Hud4SCNkNhhZR+36/1dlI9koOofpRdN1mr3+2/c1jXMMX+p3SWuq5z8vSZQo
 A5ZKwKb5sis3YGX+zbrDmxJQldvtrXM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-_0IDTFZXNeeThtQ2KQH6ig-1; Tue, 07 Mar 2023 10:59:53 -0500
X-MC-Unique: _0IDTFZXNeeThtQ2KQH6ig-1
Received: by mail-wm1-f69.google.com with SMTP id
 k26-20020a05600c0b5a00b003dfe4bae099so5156478wmr.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Mar 2023 07:59:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678204793;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I0FHpHDfgMNKIF0PugEg3oYZEslsm/Wba3C2OVAQmj8=;
 b=qJtB1B/hdxQK75A+YjuGnM3pCbu5ogJflhvB8DXstZO+i2RorrnK4H80X7jvoxBiNz
 ylRXScILx9MvVSyei2grY6grhxLlYFdwoxZ3P2C98QeeeLKX2Brtq/5WPoh6etGRdFaS
 hd7AnX2iM3pk/qMsybxRzCRTXDI/rKq5Fb2lK/HVxytFLO9PBBHou/IdcbLPrLCtJ+bP
 59KBfqoJr5ceJkJk02gI9uqCFHts4JKIGZy+na+sRnN6LWqHiHQReg9vBaIcauwTJXwo
 fN3AzTVkXLB0+yikoz+bS5YY6O1teeGjAa0hGK79bWcgN6kA+4bvmSBJYnsaG3yL0394
 Dieg==
X-Gm-Message-State: AO0yUKVgQMjmK0JZTma+j5TK+PN8TidqLB9bnpc6/q5csMy8dSpGh/dV
 scExZyu9fT/9Mqt4kwfLrqnUo3gKeHm+83dgQA/tNzj60kzlQqy97NuaK1TkRWcIJu43wFhys+2
 Law+I9LQsbbXcfSKr+4SElEt2ciZUEwtLmb4JJbn17Q==
X-Received: by 2002:a05:600c:4708:b0:3ea:e7e7:95d9 with SMTP id
 v8-20020a05600c470800b003eae7e795d9mr13611736wmo.32.1678204792806; 
 Tue, 07 Mar 2023 07:59:52 -0800 (PST)
X-Google-Smtp-Source: AK7set9ob27rJ5Fb3HgQd1GlfrWD/oV9eHzxuYT1BLvurc5s6TprDFYyhGudmqSQfuT1fPyQzYHBIQ==
X-Received: by 2002:a05:600c:4708:b0:3ea:e7e7:95d9 with SMTP id
 v8-20020a05600c470800b003eae7e795d9mr13611707wmo.32.1678204792450; 
 Tue, 07 Mar 2023 07:59:52 -0800 (PST)
Received: from redhat.com ([2.52.138.216]) by smtp.gmail.com with ESMTPSA id
 n37-20020a05600c3ba500b003e2052bad94sm19010162wms.33.2023.03.07.07.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Mar 2023 07:59:51 -0800 (PST)
Date: Tue, 7 Mar 2023 10:59:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 0/2] add checking sq is full inside xdp xmit
Message-ID: <20230307105848-mutt-send-email-mst@kernel.org>
References: <20230306041535.73319-1-xuanzhuo@linux.alibaba.com>
 <20230306125742-mutt-send-email-mst@kernel.org>
 <1678153770.8281553-2-xuanzhuo@linux.alibaba.com>
 <27a06a7d79fef3446ae1167612808a2af09922be.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <27a06a7d79fef3446ae1167612808a2af09922be.camel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

On Tue, Mar 07, 2023 at 10:53:41AM +0100, Paolo Abeni wrote:
> Hi,
> On Tue, 2023-03-07 at 09:49 +0800, Xuan Zhuo wrote:
> > On Mon, 6 Mar 2023 12:58:22 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Mon, Mar 06, 2023 at 12:15:33PM +0800, Xuan Zhuo wrote:
> > > > If the queue of xdp xmit is not an independent queue, then when the xdp
> > > > xmit used all the desc, the xmit from the __dev_queue_xmit() may encounter
> > > > the following error.
> > > > 
> > > > net ens4: Unexpected TXQ (0) queue failure: -28
> > > > 
> > > > This patch adds a check whether sq is full in XDP Xmit.
> > > > 
> > > > Thanks.
> > > 
> > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > > 
> > > needed for stable?
> > 
> > Yes i think.
> 
> Could you please re-post including a suitable 'Fixes' tag? That would
> address stable, too. Additionally you could rename check_sq_full() in
> patch 1, perhaps 'check_disable_sq_full()' would do.

Not that's even more confusing it sounds like it's checking that
it's checking that sq is disabled unless one looks closely.

I think check_sq_full_and_disable() is better.

> You can retain the already collected tags.
> 
> Thanks!
> 
> Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
