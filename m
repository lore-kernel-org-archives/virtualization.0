Return-Path: <SRS0=5nkl=M3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0CFC432BE
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 12:57:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 577AF60EBC
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 12:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 577AF60EBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C110C83CAD;
	Wed,  4 Aug 2021 12:57:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YKgglBRKXhH8; Wed,  4 Aug 2021 12:57:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C40BE83C9F;
	Wed,  4 Aug 2021 12:57:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B47CC001A;
	Wed,  4 Aug 2021 12:57:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D1E3C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 12:57:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2402860632
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 12:57:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HV574CkCMgXD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 12:57:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C369F60624
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 12:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628081866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0/bO+MgPDOUvO02RQ1/ITQ19fPYuZ/wXOCdSbbV0LTs=;
 b=Sjgg8Ao0Trwp81RWAEPO0dUa7lOoKtZ5BPnl5k5yKQcH8T+vSPrBkFoHqrXRBlkpK1rc/W
 LgdrACJHyhl/AzIWpOknBraAU0v3e4HYCR6tqi51v5JlorUmzctOpmAv7X+iY8WjSpOO4k
 ntoLJOAP/OhitVXgn7Vgcenpi4P5KR4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-p8fwpVW_NmuL9Hnqn3gkxA-1; Wed, 04 Aug 2021 08:57:45 -0400
X-MC-Unique: p8fwpVW_NmuL9Hnqn3gkxA-1
Received: by mail-ed1-f70.google.com with SMTP id
 c1-20020aa7df010000b02903bb5c6f746eso1401057edy.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 04 Aug 2021 05:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0/bO+MgPDOUvO02RQ1/ITQ19fPYuZ/wXOCdSbbV0LTs=;
 b=cWHLJpaC2X5gTsoP+6vbYc7xAInl8ZL45PpRdJGL2rmGdnXHkG9IB3DttwSZ+rO7Ab
 w/bNYTjOVPsaKIkfbhNgsKbKO+wU41zcaf8rVN7UcuKXjwugdnVdGOX2oClH4Ecy2EsA
 qpuKdmsmnoaTaXjWP4OtChUHrcJR0dZuCZ+62ZRlR4YxU1ODjCHpwY2dSUj7tpffIUM+
 gEnUVKp/o6NBPnrt0rvom0x03PcPJ1ND/VXU/klFURA/kFh5jugZeL7ww8zNC9/9oA5x
 vMR9kSeJ+7n/UD9o6je+0pZG5Ff82yGA33FJwzrfGK3i4f2uLvZihTKTXq2GOgmRrWvR
 6SiQ==
X-Gm-Message-State: AOAM531jQrmVyp0xkGY7mtwxI0aHeTfD9d3p394zFpzNK6UB38BeKduj
 BBln6/StSOxSTpkmR2mtlJxYDLhVk2OwhU8U9CmRCDnwF/Z0svagSh76rE2yZO0ZC4/xEHV/gBJ
 WJYsv/fh8gGyoKB38OgeAzhI1AJl5h7X2ph+leJnTew==
X-Received: by 2002:a17:906:c085:: with SMTP id
 f5mr26109119ejz.250.1628081864047; 
 Wed, 04 Aug 2021 05:57:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiZNmhNR8yr3j+9pHq54LbMN6zvfVQtndDuehBDERZ/x4tZYc2Uu210Q95TZ8Abyb0Xl5IzQ==
X-Received: by 2002:a17:906:c085:: with SMTP id
 f5mr26109096ejz.250.1628081863868; 
 Wed, 04 Aug 2021 05:57:43 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id n11sm666345ejg.111.2021.08.04.05.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Aug 2021 05:57:43 -0700 (PDT)
Date: Wed, 4 Aug 2021 14:57:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v1 0/7] virtio/vsock: introduce MSG_EOR flag for
 SEQPACKET
Message-ID: <20210804125737.kbgc6mg2v5lw25wu@steredhat>
References: <20210726163137.2589102-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210726163137.2589102-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Colin Ian King <colin.king@canonical.com>,
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

Hi Arseny,

On Mon, Jul 26, 2021 at 07:31:33PM +0300, Arseny Krasnov wrote:
>	This patchset implements support of MSG_EOR bit for SEQPACKET
>AF_VSOCK sockets over virtio transport.
>	Idea is to distinguish concepts of 'messages' and 'records'.
>Message is result of sending calls: 'write()', 'send()', 'sendmsg()'
>etc. It has fixed maximum length, and it bounds are visible using
>return from receive calls: 'read()', 'recv()', 'recvmsg()' etc.
>Current implementation based on message definition above.

Okay, so the implementation we merged is wrong right?
Should we disable the feature bit in stable kernels that contain it? Or 
maybe we can backport the fixes...

>	Record has unlimited length, it consists of multiple message,
>and bounds of record are visible via MSG_EOR flag returned from
>'recvmsg()' call. Sender passes MSG_EOR to sending system call and
>receiver will see MSG_EOR when corresponding message will be processed.
>	To support MSG_EOR new bit was added along with existing
>'VIRTIO_VSOCK_SEQ_EOR': 'VIRTIO_VSOCK_SEQ_EOM'(end-of-message) - now it
>works in the same way as 'VIRTIO_VSOCK_SEQ_EOR'. But 'VIRTIO_VSOCK_SEQ_EOR'
>is used to mark 'MSG_EOR' bit passed from userspace.

I understand that it makes sense to remap VIRTIO_VSOCK_SEQ_EOR to 
MSG_EOR to make the user understand the boundaries, but why do we need 
EOM as well?

Why do we care about the boundaries of a message within a record?
I mean, if the sender makes 3 calls:
     send(A1,0)
     send(A2,0)
     send(A3, MSG_EOR);

IIUC it should be fine if the receiver for example receives all in one 
single recv() calll with MSG_EOR set, so why do we need EOM?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
