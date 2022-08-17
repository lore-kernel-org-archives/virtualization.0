Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0832C25B08
	for <virtualization@archiver.kernel.org>; Wed, 17 Aug 2022 17:20:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 251884010B;
	Wed, 17 Aug 2022 17:20:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 251884010B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DIDKnbS4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rhew9mHhgKpJ; Wed, 17 Aug 2022 17:20:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 429824031F;
	Wed, 17 Aug 2022 17:20:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 429824031F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09758C0033;
	Wed, 17 Aug 2022 17:20:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F86BC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 17:20:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 63E6D83EE1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 17:20:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 63E6D83EE1
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DIDKnbS4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gs_xe52GMZSA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 17:20:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8CC3B83EDF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8CC3B83EDF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 17:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660756828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E1x5LNrRWuvWgMZzul66wIPkfRn59vrBUCTEKqLPjoU=;
 b=DIDKnbS4bitFJ/nmetDMX6j2ebs8SPgpNWSvDlbrSonr8sSgvLMwfJB8y/AX08Sc8F2umS
 b6SlhzGsAo7ZJdVJCndR/lRsaJvPz4PJ6wPLMaFy2OsSivGNunPpen2Mito3xS4iPs+51p
 ZyJJBk9ZsygPe0Al0ttE4C5+s/f0tE0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-634-5OlsoNt_MHij0Yj3PbWl1Q-1; Wed, 17 Aug 2022 13:20:26 -0400
X-MC-Unique: 5OlsoNt_MHij0Yj3PbWl1Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 l16-20020adfbd90000000b0022073dbf2f3so2629307wrh.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 10:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=E1x5LNrRWuvWgMZzul66wIPkfRn59vrBUCTEKqLPjoU=;
 b=SBS6HUWgnX7W598pjevluxnSUBKBe2wPXPXO5Vn4+h4JA7oMBuUeKxVm2eSk8LszPM
 qhiLlA/9xnbTrQc3HpwO21IJFEkXzBUKKFvVRm8tm1WphGI0bzPwJQb5uAc3RCkzBX7J
 nYWWzSB2xI0gpW14hrzJrSagtanflx2j4jXff4SmTX6/ES7UgOXyuCYZECfEPJhgI2IS
 jwKMjZayJaEkDbIFHZi1GDsMmlj3KypEs1mlEAFwVBkwKDtsRhWpgi/oIALivtTb+Xuh
 xR+NHhApK8TL5LFSB/owyds/lwAeolpVFTtodZYS6Aa5gUaDVCx9cKRea+7QHKmi6dXJ
 aV7Q==
X-Gm-Message-State: ACgBeo2DysUk07Eh9LhudByogBiXDqLQP/PZpXywtvg+f86i9YaY5X5K
 SCkaUWy8NUMFJZdX/JH2pnJRb3rEH4ML0FZ57TNeYeXYF13qLqhAzAK2dNJwDqWWtJ+DnQF3S3h
 sfu7c1tqg+ucT0zvmWdaXaINmp7RlNWz2IOI6bImC0A==
X-Received: by 2002:a1c:19c2:0:b0:3a5:168e:a918 with SMTP id
 185-20020a1c19c2000000b003a5168ea918mr2792768wmz.31.1660756825530; 
 Wed, 17 Aug 2022 10:20:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4cDOhH9gb57ZgsmemV6RwBgg2yGkmkUplYW2gdzH3YejzjL5WNaW6YF8Ruh007bts4KbJ2Bw==
X-Received: by 2002:a1c:19c2:0:b0:3a5:168e:a918 with SMTP id
 185-20020a1c19c2000000b003a5168ea918mr2792746wmz.31.1660756825315; 
 Wed, 17 Aug 2022 10:20:25 -0700 (PDT)
Received: from redhat.com ([2.55.4.37]) by smtp.gmail.com with ESMTPSA id
 h82-20020a1c2155000000b003a319bd3278sm2862407wmh.40.2022.08.17.10.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Aug 2022 10:20:24 -0700 (PDT)
Date: Wed, 17 Aug 2022 13:20:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH 3/6] vsock: add netdev to vhost/virtio vsock
Message-ID: <20220817131437-mutt-send-email-mst@kernel.org>
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
 <5a93c5aad99d79f028d349cb7e3c128c65d5d7e2.1660362668.git.bobby.eshleman@bytedance.com>
 <20220816123701-mutt-send-email-mst@kernel.org>
 <20220816110717.5422e976@kernel.org> <YvtAktdB09tM0Ykr@bullseye>
 <20220816160755.7eb11d2e@kernel.org> <YvtVN195TS1xpEN7@bullseye>
 <20220816181528.5128bc06@kernel.org> <Yvt2f5i5R9NNNYUL@bullseye>
MIME-Version: 1.0
In-Reply-To: <Yvt2f5i5R9NNNYUL@bullseye>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Cong Wang <cong.wang@bytedance.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Jiang Wang <jiang.wang@bytedance.com>, netdev@vger.kernel.org,
 Bobby Eshleman <bobby.eshleman@gmail.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
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

On Tue, Aug 16, 2022 at 10:50:55AM +0000, Bobby Eshleman wrote:
> > > > Eh, I was hoping it was a side channel of an existing virtio_net 
> > > > which is not the case. Given the zero-config requirement IDK if 
> > > > we'll be able to fit this into netdev semantics :(  
> > > 
> > > It's certainly possible that it may not fit :/ I feel that it partially
> > > depends on what we mean by zero-config. Is it "no config required to
> > > have a working socket" or is it "no config required, but also no
> > > tuning/policy/etc... supported"?
> > 
> > The value of tuning vs confusion of a strange netdev floating around
> > in the system is hard to estimate upfront. 
> 
> I think "a strange netdev floating around" is a total
> mischaracterization... vsock is a networking device and it supports
> vsock networks. Sure, it is a virtual device and the routing is done in
> host software, but the same is true for virtio-net and VM-to-VM vlan.
> 
> This patch actually uses netdev for its intended purpose: to support and
> manage the transmission of packets via a network device to a network.
> 
> Furthermore, it actually prepares vsock to eliminate a "strange" use of
> a netdev. The netdev in vsockmon isn't even used to transmit
> packets, it's "floating around" for no other reason than it is needed to
> support packet capture, which vsock couldn't support because it didn't
> have a netdev.
> 
> Something smells when we are required to build workaround kernel modules
> that use netdev for ciphoning packets off to userspace, when we could
> instead be using netdev for its intended purpose and get the same and
> more benefit.

So what happens when userspace inevitably attempts to bind a raw
packet socket to this device? Assign it an IP? Set up some firewall
rules?

These things all need to be addressed before merging since they affect UAPI.


> > 
> > The nice thing about using a built-in fq with no user visible knobs is
> > that there's no extra uAPI. We can always rip it out and replace later.
> > And it shouldn't be controversial, making the path to upstream smoother.
> 
> The issue is that after pulling in fq for one kind of flow management,
> then as users observe other flow issues, we will need to re-implement
> pfifo, and then TBF, and then we need to build an interface to let users
> select one, and to choose queue sizes... and then after awhile we've
> needlessly re-implemented huge chunks of the tc system.
> 
> I don't see any good reason to restrict vsock users to using suboptimal
> and rigid queuing.
> 
> Thanks.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
