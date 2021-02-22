Return-Path: <SRS0=djY9=HY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE01C433E0
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 14:23:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FAAE64E20
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 14:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FAAE64E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD6DD6F559;
	Mon, 22 Feb 2021 14:23:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VNWTHt9r13vc; Mon, 22 Feb 2021 14:23:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C2AD6F51A;
	Mon, 22 Feb 2021 14:23:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDD22C000B;
	Mon, 22 Feb 2021 14:23:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B558C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 14:23:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 59C3083979
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 14:23:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M4CM09gFBJAm
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 14:23:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 475D983963
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 14:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614003800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wzyVHac7bUd3mCc3EMe28wAe65P5w8DpSyWYPCo7GCg=;
 b=Ves5y9v7FS1UoIEnM9HJcJ1o3oagkKKs4cpNtZF/mZP7YKS4rr4aTtgwztvrwc4ZlAjIA6
 KijgC1DEmcBaU4XVs21ZxxUgcCgzp4tHz6I5TXIKmuqhP3PEM2O8MByXcgBogzMq8Fb9u4
 8MSp/hv4/+FxJ6Z7IW3GkWHc3MuQBU0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-8hVfosccMdSKVXAP8BQLMw-1; Mon, 22 Feb 2021 09:23:16 -0500
X-MC-Unique: 8hVfosccMdSKVXAP8BQLMw-1
Received: by mail-wr1-f72.google.com with SMTP id v1so6171049wru.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 06:23:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wzyVHac7bUd3mCc3EMe28wAe65P5w8DpSyWYPCo7GCg=;
 b=VJUeF5ZLmFTr8jL2dqs4Kv/7sz1ohD3Vi5DwUJoiVkjD5lWJ3PT7ZGlACqdBfQ7t80
 /xp+W2JPO56VatLyqDpZ5AuuEAgc8DyCi0rFJ1LWhkWhQOwhDbxUT1lULo+ftwb9cqw4
 RqdoiWfcsQdUbfKJZLXNF1TJykmFulCz/yNSGf2L2YMzqbF6OTjEkjitMl8dgaY4mJmD
 OwmIb4JJ5T+e0U3o8bF5JUzXsXhyAjl3aAh+lJvKzIK3VcGKF+T1KtUR/vFQ9ClgxsN3
 v90m+HNSGtYm5f90sYLdjoCdHK7/nHksUCGwU1xDQEocimnoWWyIIU5PsN7Z40ep/MLO
 SnOw==
X-Gm-Message-State: AOAM533salFK7RlWePdhI4IjgPy68uLn5sN6O7y24V+LBd1PZLvfbPET
 NGzlOkprvHxqJgUSW3V/u/85zEQdEt5XNPcrq6dsPHv6w9NBRWD0m3QnfFKwf8R6tOdrjz7WeTu
 XD6FeWurDjxCFH12LU1/b1+7vpnNN2otfQ5uKin4Nfg==
X-Received: by 2002:a1c:23c2:: with SMTP id j185mr20392837wmj.96.1614003795021; 
 Mon, 22 Feb 2021 06:23:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCb72c0yXyjgk1dT0m2zWBpWEuSOVEk1PCqETARj8JSNyPsc7yiew5yYtu4mvxw9C4hwrGDA==
X-Received: by 2002:a1c:23c2:: with SMTP id j185mr20392806wmj.96.1614003794853; 
 Mon, 22 Feb 2021 06:23:14 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id o10sm22488407wrx.5.2021.02.22.06.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Feb 2021 06:23:14 -0800 (PST)
Date: Mon, 22 Feb 2021 15:23:11 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v5 00/19] virtio/vsock: introduce SOCK_SEQPACKET
 support
Message-ID: <20210222142311.gekdd7gsm33wglos@steredhat>
References: <20210218053347.1066159-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210218053347.1066159-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, stsp2@yandex.ru,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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

Hi Arseny,

On Thu, Feb 18, 2021 at 08:33:44AM +0300, Arseny Krasnov wrote:
>	This patchset impelements support of SOCK_SEQPACKET for virtio
>transport.
>	As SOCK_SEQPACKET guarantees to save record boundaries, so to
>do it, two new packet operations were added: first for start of record
> and second to mark end of record(SEQ_BEGIN and SEQ_END later). Also,
>both operations carries metadata - to maintain boundaries and payload
>integrity. Metadata is introduced by adding special header with two
>fields - message count and message length:
>
>	struct virtio_vsock_seq_hdr {
>		__le32  msg_cnt;
>		__le32  msg_len;
>	} __attribute__((packed));
>
>	This header is transmitted as payload of SEQ_BEGIN and SEQ_END
>packets(buffer of second virtio descriptor in chain) in the same way as
>data transmitted in RW packets. Payload was chosen as buffer for this
>header to avoid touching first virtio buffer which carries header of
>packet, because someone could check that size of this buffer is equal
>to size of packet header. To send record, packet with start marker is
>sent first(it's header contains length of record and counter), then
>counter is incremented and all data is sent as usual 'RW' packets and
>finally SEQ_END is sent(it also carries counter of message, which is
>counter of SEQ_BEGIN + 1), also after sedning SEQ_END counter is
>incremented again. On receiver's side, length of record is known from
>packet with start record marker. To check that no packets were dropped
>by transport, counters of two sequential SEQ_BEGIN and SEQ_END are
>checked(counter of SEQ_END must be bigger that counter of SEQ_BEGIN by
>1) and length of data between two markers is compared to length in
>SEQ_BEGIN header.
>	Now as  packets of one socket are not reordered neither on
>vsock nor on vhost transport layers, such markers allows to restore
>original record on receiver's side. If user's buffer is smaller that
>record length, when all out of size data is dropped.
>	Maximum length of datagram is not limited as in stream socket,
>because same credit logic is used. Difference with stream socket is
>that user is not woken up until whole record is received or error
>occurred. Implementation also supports 'MSG_EOR' and 'MSG_TRUNC' flags.
>	Tests also implemented.

I reviewed the first part (af_vsock.c changes), tomorrow I'll review the 
rest. That part looks great to me, only found a few minor issues.

In the meantime, however, I'm getting a doubt, especially with regard to 
other transports besides virtio.

Should we hide the begin/end marker sending in the transport?

I mean, should the transport just provide a seqpacket_enqueue() 
callbacl?
Inside it then the transport will send the markers. This is because some 
transports might not need to send markers.

But thinking about it more, they could actually implement stubs for that 
calls, if they don't need to send markers.

So I think for now it's fine since it allows us to reuse a lot of code, 
unless someone has some objection.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
