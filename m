Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CDDC77B75
	for <virtualization@archiver.kernel.org>; Wed,  3 May 2023 12:09:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E78C4146F;
	Wed,  3 May 2023 12:09:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2E78C4146F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LnYafboR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ThPuWbaN0fTa; Wed,  3 May 2023 12:09:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 101D7410AB;
	Wed,  3 May 2023 12:09:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 101D7410AB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB716C0037;
	Wed,  3 May 2023 12:09:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3F8FC002A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 12:09:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8B467611B5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 12:09:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8B467611B5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LnYafboR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H8DGrOwR2ayM
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 12:09:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 69DDB610C1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 69DDB610C1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 12:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683115789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RkjEggx5doDuLSwR8ZjUhb7IBiYs0z5W7yuB+yUHCuk=;
 b=LnYafboRk6sykktbyqZ4IAaKBd7/7606fi12U+MGBasbq4qYwu6U2Bb8J/KcOUVaF2+QMW
 5kbRTo5wXy5zIA5/6s5YSmAPyef3OBeUfQV2g/wSF9a/SKgZrn8ZTP8N/0sdL3DfUr+X/g
 PGedkbTdnWFNptWDv6hqCCQKy3Ci+40=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-wMjq31DKMUSiln14vLZyXQ-1; Wed, 03 May 2023 08:09:47 -0400
X-MC-Unique: wMjq31DKMUSiln14vLZyXQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94f0dd11762so619791766b.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 May 2023 05:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683115786; x=1685707786;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RkjEggx5doDuLSwR8ZjUhb7IBiYs0z5W7yuB+yUHCuk=;
 b=i7QMs+uUvURMAEGuZNhp7m2bgXiyrgxTHs+vQEhWppRh/LiDQxAHQZAsaICrSnT+Ct
 W6lu4z9cr+yoxZWAr1SodblmwzBv0KTLxOo1NsLO7j2ECLqsKiX8slQBxwpYNdCQWIZp
 P/s94oIecu5CZjQ3kfhNLRX21Ry74+5bgjeS1ra7lYBMgzTxNAxMdslyokVrbQWFMd9l
 ylz1itAWYHExpWVHQ+QWfUQXb8LOwQXnRf94TJ7ly+WxHPiIWYx0++Ov3sAfulDZC+5Z
 UiAVt0CkOJvexuNHabVUEFgfXMLwbXijW6AXlv4Nydu+uOB6CL6yZDeeIsUV4hWwo8JI
 dJcQ==
X-Gm-Message-State: AC+VfDzRbOHDyB8DN/zyEF1HwwcxccExXgqaEtyd/rxN+MsmaBDKJLUs
 Pofxd4zfZO7/72K+NJA8ZKQm2C5t81JcVFWUVWSNO0hh0LvlR7eteu1oh/iMXeuguuvySwEbwdV
 T0xasz/gDtJuwI0UecGsGfFX2I+y8x3C9ON6KyhTo/w==
X-Received: by 2002:a17:907:3684:b0:94e:547b:6301 with SMTP id
 bi4-20020a170907368400b0094e547b6301mr2777495ejc.8.1683115786390; 
 Wed, 03 May 2023 05:09:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6SuQbXI5bAnd45tZOFasAVvd6rklyRosKoF3BB7Xuzo6B77CAdECRGvlWYq0kYBrlTvQht1w==
X-Received: by 2002:a17:907:3684:b0:94e:547b:6301 with SMTP id
 bi4-20020a170907368400b0094e547b6301mr2777459ejc.8.1683115786077; 
 Wed, 03 May 2023 05:09:46 -0700 (PDT)
Received: from sgarzare-redhat ([185.29.96.107])
 by smtp.gmail.com with ESMTPSA id
 y15-20020a170906070f00b0094f54279f13sm17256035ejb.157.2023.05.03.05.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 May 2023 05:09:45 -0700 (PDT)
Date: Wed, 3 May 2023 14:09:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH RFC net-next v2 3/4] vsock: Add lockless sendmsg() support
Message-ID: <lc2v5porgyzx6neimlyrpeg3d5l7trnorbs7xubqgcrlp7bbi7@yxs25wx67tm7>
References: <20230413-b4-vsock-dgram-v2-0-079cc7cee62e@bytedance.com>
 <20230413-b4-vsock-dgram-v2-3-079cc7cee62e@bytedance.com>
 <bs3elc4lwvvq22y2vq27ewo23qibei2neys4txszi6wybxpuzu@czyq5hb7iv5t>
 <ZDp837+YDvAfoNLc@bullseye>
 <se4wymgrmiihkoq4kpnlo2uwklxhfreyzrqjuc7qcqz3c3l7l3@dlxostl5y6q2>
 <ZDre6Mqh9+HA8wuN@bullseye>
MIME-Version: 1.0
In-Reply-To: <ZDre6Mqh9+HA8wuN@bullseye>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vishnu Dasa <vdasa@vmware.com>, Wei Liu <wei.liu@kernel.org>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, netdev@vger.kernel.org,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Bryan Tan <bryantan@vmware.com>, Eric Dumazet <edumazet@google.com>,
 linux-hyperv@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sat, Apr 15, 2023 at 05:29:12PM +0000, Bobby Eshleman wrote:
>On Fri, Apr 28, 2023 at 12:29:50PM +0200, Stefano Garzarella wrote:
>> On Sat, Apr 15, 2023 at 10:30:55AM +0000, Bobby Eshleman wrote:
>> > On Wed, Apr 19, 2023 at 11:30:53AM +0200, Stefano Garzarella wrote:
>> > > On Fri, Apr 14, 2023 at 12:25:59AM +0000, Bobby Eshleman wrote:
>> > > > Because the dgram sendmsg() path for AF_VSOCK acquires the socket lock
>> > > > it does not scale when many senders share a socket.
>> > > >
>> > > > Prior to this patch the socket lock is used to protect the local_addr,
>> > > > remote_addr, transport, and buffer size variables. What follows are the
>> > > > new protection schemes for the various protected fields that ensure a
>> > > > race-free multi-sender sendmsg() path for vsock dgrams.
>> > > >
>> > > > - local_addr
>> > > >    local_addr changes as a result of binding a socket. The write path
>> > > >    for local_addr is bind() and various vsock_auto_bind() call sites.
>> > > >    After a socket has been bound via vsock_auto_bind() or bind(), subsequent
>> > > >    calls to bind()/vsock_auto_bind() do not write to local_addr again. bind()
>> > > >    rejects the user request and vsock_auto_bind() early exits.
>> > > >    Therefore, the local addr can not change while a parallel thread is
>> > > >    in sendmsg() and lock-free reads of local addr in sendmsg() are safe.
>> > > >    Change: only acquire lock for auto-binding as-needed in sendmsg().
>> > > >
>> > > > - vsk->transport
>> > > >    Updated upon socket creation and it doesn't change again until the
>> > >
>> > > This is true only for dgram, right?
>> > >
>> >
>> > Yes.
>> >
>> > > How do we decide which transport to assign for dgram?
>> > >
>> >
>> > The transport is assigned in proto->create() [vsock_create()]. It is
>> > assigned there *only* for dgrams, whereas for streams/seqpackets it is
>> > assigned in connect(). vsock_create() sets transport to
>> > 'transport_dgram' if sock->type == SOCK_DGRAM.
>> >
>> > vsock_sk_destruct() then eventually sets vsk->transport to NULL.
>> >
>> > Neither destruct nor create can occur in parallel with sendmsg().
>> > create() hasn't yet returned the sockfd for the user to call upon it
>> > sendmsg(), and AFAICT destruct is only called after the final socket
>> > reference is released, which only happens after the socket no longer
>> > exists in the fd lookup table and so sendmsg() will fail before it ever
>> > has the chance to race.
>>
>> This is okay if a socket can be assigned to a single transport, but with
>> dgrams I'm not sure we can do that.
>>
>> Since it is not connected, a socket can send or receive packets from
>> different transports, so maybe we can't assign it to a specific one,
>> but do a lookup for every packets to understand which transport to use.
>>
>
>Yes this is true, this lookup needs to be implemented... currently
>sendmsg() doesn't do this at all. It grabs the remote_addr when passed
>in from sendto(), but then just uses the same old transport from vsk.
>You are right that sendto() should be a per-packet lookup, not a
>vsk->transport read. Perhaps I should add that as another patch in this
>series, and make it precede this one?

Yep, I think so, we need to implement it before adding a new transport
that can support dgram.

>
>For the send() / sendto(NULL) case where vsk->transport is being read, I
>do believe this is still race-free, but...
>
>If we later support dynamic transports for datagram, such that
>connect(VMADDR_LOCAL_CID) sets vsk->transport to transport_loopback,
>connect(VMADDR_CID_HOST) sets vsk->transport to something like
>transport_datagram_g2h, etc..., then vsk->transport will need to be
>bundled into the RCU-protected pointer too, since it may change when
>remote_addr changes.

Yep, I think so. Although in vsock_dgram_connect we call lock_sock(), so 
maybe that could be enough to protect us.

In general I think we should use vsk->transport if vsock_dgram_connect()
is called, or we need to do per-packet lookup.

Another think I would change, is the dgram_dequeue() callback.
I would remove it, and move in the core the code in 
vmci_transport_dgram_dequeue() since it seems pretty generic.

This should work well if every transport uses sk_receive_skb() to 
enqueue sk_buffs in the socket buffer.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
