Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75014CE79A8
	for <virtualization@archiver.kernel.org>; Wed, 20 Sep 2023 02:38:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E064941498;
	Wed, 20 Sep 2023 02:38:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E064941498
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fRUYapky
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GYrwdXnEM_Sk; Wed, 20 Sep 2023 02:38:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E060D409D0;
	Wed, 20 Sep 2023 02:38:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E060D409D0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1E46C0071;
	Wed, 20 Sep 2023 02:38:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 559B3C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Sep 2023 02:38:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C4FE82F39
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Sep 2023 02:38:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C4FE82F39
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fRUYapky
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UVwEBaaloDzi
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Sep 2023 02:38:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4EE2A82F32
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Sep 2023 02:38:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4EE2A82F32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695177525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mltdWUrYuG2mZM3mBsS3pkG+K6kdQVfPyUFr6/Wteqo=;
 b=fRUYapkyUuGEW7ywxbzIoKoyH+mpzZjT6c+1fFvwfKHzaKzBrpsM0SPgqwD4868KDUX3Xs
 O6ngl4YHLGoPfjTBFVz0/Ar0SfqzFBa0CQNFFiOoRLJ6mDlWUFOronOl46GteWo3HhLnLI
 POthraKGVr3eojz/2W7uEH3vPwC4abY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-affvC8SSOqmXRlpVf9KtHQ-1; Tue, 19 Sep 2023 22:38:40 -0400
X-MC-Unique: affvC8SSOqmXRlpVf9KtHQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c0165b5c5cso31672151fa.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 19:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695177519; x=1695782319;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mltdWUrYuG2mZM3mBsS3pkG+K6kdQVfPyUFr6/Wteqo=;
 b=ICQhFpCFGiC7znj4GyILOPVqTFxfQuQmGFCaTS5PFRTPJT3DAHC5I3tUOwQSpNQ4GB
 cqhc8V0HOQJRJmuDMzjBoh2B6Q+wcVku/bx3jibgOk7znJZiIRtNbb03tXfJONZnBMDt
 oT9dz/TwYFH10mRS8+QI3iTMJk96lOeKQ9liPKhpBX3wj0f6X8rs4kVPeERzNenh/Ls0
 kxH0rFHn57VohACnpm++UGN4QWHMmEcjRt6B9/gY0wo5ZH/Da9iZxWE07+t9HAj3hX7a
 2HZT5CnuLAssGOpv1g5jBJdujpzj7l4Fn6L03nhLFxt/Ju9P/YFZp8+X4i2lGypjmU3u
 Yzgg==
X-Gm-Message-State: AOJu0YwiuKmaUtoZp106peY2xzApRvRchMnJGA1gIyy4wqkhWtBLwZXC
 lT/4RFZ/iT5hZE2v26yk2NhA5xnKe9BsMuUloh25V9vVkLqRp6yJlYJcJZtcBbaqFMCCbr8V6HL
 ePoF2dvxQ2Qiy28eYnpDEoTNVWCbNCvLdtazak/Bfhw==
X-Received: by 2002:a2e:a3cd:0:b0:2bc:c557:84a0 with SMTP id
 w13-20020a2ea3cd000000b002bcc55784a0mr928155lje.30.1695177519198; 
 Tue, 19 Sep 2023 19:38:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwXnlVNVhmJOWz1liAl5cY3Hket0qS/kxuaMrxgmSZwkofhhqlaN8M29TK4O/sX6epr0sArA==
X-Received: by 2002:a2e:a3cd:0:b0:2bc:c557:84a0 with SMTP id
 w13-20020a2ea3cd000000b002bcc55784a0mr928135lje.30.1695177518840; 
 Tue, 19 Sep 2023 19:38:38 -0700 (PDT)
Received: from redhat.com ([2.52.26.122]) by smtp.gmail.com with ESMTPSA id
 r11-20020a170906350b00b009a5f1d1564dsm8531069eja.126.2023.09.19.19.38.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 19:38:37 -0700 (PDT)
Date: Tue, 19 Sep 2023 22:38:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net-next v9 0/4] vsock/virtio/vhost: MSG_ZEROCOPY
 preparations
Message-ID: <20230919223700-mutt-send-email-mst@kernel.org>
References: <20230916130918.4105122-1-avkrasnov@salutedevices.com>
 <b5873e36-fe8c-85e8-e11b-4ccec386c015@salutedevices.com>
 <yys5jgwkukvfyrgfz6txxzqc7el5megf2xntnk6j4ausvjdgld@7aan4quqy4bs>
 <a5b25ee07245125fac4bbdc3b3604758251907d2.camel@redhat.com>
 <hq67e2b3ljfjikvbaneczdve3fzg3dl5ziyc7xtujyqesp6dzm@fh5nqkptpb4n>
MIME-Version: 1.0
In-Reply-To: <hq67e2b3ljfjikvbaneczdve3fzg3dl5ziyc7xtujyqesp6dzm@fh5nqkptpb4n>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, Arseniy Krasnov <avkrasnov@salutedevices.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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

On Tue, Sep 19, 2023 at 03:35:51PM +0200, Stefano Garzarella wrote:
> On Tue, Sep 19, 2023 at 03:19:54PM +0200, Paolo Abeni wrote:
> > On Tue, 2023-09-19 at 09:54 +0200, Stefano Garzarella wrote:
> > > On Mon, Sep 18, 2023 at 07:56:00PM +0300, Arseniy Krasnov wrote:
> > > > Hi Stefano,
> > > >
> > > > thanks for review! So when this patchset will be merged to net-next,
> > > > I'll start sending next part of MSG_ZEROCOPY patchset, e.g. AF_VSOCK +
> > > > Documentation/ patches.
> > > 
> > > Ack, if it is not a very big series, maybe better to include also the
> > > tests so we can run them before merge the feature.
> > 
> > I understand that at least 2 follow-up series are waiting for this, one
> > of them targeting net-next and the bigger one targeting the virtio
> > tree. Am I correct?
> 
> IIUC the next series will touch only the vsock core
> (net/vmw_vsock/af_vsock.c), tests, and documentation.
> 
> The virtio part should be fully covered by this series.
> 
> @Arseniy feel free to correct me!
> 
> > 
> > DaveM suggests this should go via the virtio tree, too. Any different
> > opinion?
> 
> For this series should be fine, I'm not sure about the next series.
> Merging this with the virtio tree, then it forces us to do it for
> followup as well right?
> 
> In theory followup is more on the core, so better with net-next, but
> it's also true that for now only virtio transports support it, so it
> might be okay to continue with virtio.
> 
> @Michael WDYT?
> 
> Thanks,
> Stefano

I didn't get DaveM's mail - was this off-list?
I think net-next is easier because the follow up belongs in net-next.
But if not I can take it, sure. Let me know.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
