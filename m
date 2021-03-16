Return-Path: <SRS0=cXtE=IO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B432C433DB
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 13:51:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1CFC65064
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 13:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1CFC65064
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 057AA4ECC5;
	Tue, 16 Mar 2021 13:51:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rCnfxtNr19bh; Tue, 16 Mar 2021 13:51:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFE824EC94;
	Tue, 16 Mar 2021 13:51:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BB8EC000C;
	Tue, 16 Mar 2021 13:51:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDCB6C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 13:51:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9E79F60681
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 13:51:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B2X-6XWmFAS5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 13:50:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F21C660664
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 13:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615902657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/YnnRRt9i17iI2TQ821szCaXKJRXbSpDYyrvn7R8MPQ=;
 b=OT3NpqdmQptJncBG59r1MpAUaA9IiZbIYoxtpAQLW3UIbkSdxJskRJtrNmvgE6s1kkwk8Y
 1e6r14Fam5WeK/Awm6wrQdXhVeWp0SCH1cL8ZHJ7vFlTJw0wOIMjgpntRbS71Evf0gLswB
 CoXLhSHNEb4DJOceDYvl0cpuxqbs/9E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-xVK0cSNvPbCLSxJxIFgUkA-1; Tue, 16 Mar 2021 09:50:53 -0400
X-MC-Unique: xVK0cSNvPbCLSxJxIFgUkA-1
Received: by mail-wr1-f72.google.com with SMTP id m23so11673543wrh.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 06:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/YnnRRt9i17iI2TQ821szCaXKJRXbSpDYyrvn7R8MPQ=;
 b=aUHPOFgFjIjNGAimnT2boDO4yo9aWRiRjBLqM7Twuh9+TzakSnqLWol5sTOd9ZJZ/8
 n9MmZhQZ3lzHHmrAmig/GbAH14/eB8+/a2Ud7HKnlu+vWOLeX5OkW5mftoiOUwxhfMnL
 0dQl0cvvP2QwtFcXIpqpLXXhNnIETP8W5SD3iYYhvcN4N1+17nyRI37yUvFtTta1O8rs
 Vq1XkSp7d1GByqKCMGvUJkncZltt2y5raZ3S+fU7KkB3Q+4Spla2n3Se1vIPl8ZtveRU
 l0CWpEgTT5tCnRt2LahdJmDbvNV7pRlQ6ZBWAIKn8IIbPmtuSfKg/d12B8OLHpqRQ76B
 qNSw==
X-Gm-Message-State: AOAM530NmBPCQHiOD0AzOuPXBOSecXiomWNDrJtybBOyZpZdeO8vRZCZ
 yatlXzw3aUiGaSfWcjCAqvG46+HTgy7QUTT0qOPhWs/Ui57fRqc5IQshkVR4DsuvBXaVcozLoU4
 6mY2mpStFcMfFU+sV9byUOPHZSVcBjb4/FZeNTewy+w==
X-Received: by 2002:a05:600c:4150:: with SMTP id
 h16mr4875669wmm.120.1615902652193; 
 Tue, 16 Mar 2021 06:50:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqrRzpF8QZG945YXBnt814ljEcOpLj7AT6+qveNX+F3our6rWfKMhDnOmyOxkuYmUGvBdEhA==
X-Received: by 2002:a05:600c:4150:: with SMTP id
 h16mr4875657wmm.120.1615902652046; 
 Tue, 16 Mar 2021 06:50:52 -0700 (PDT)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id y18sm22481573wrw.39.2021.03.16.06.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Mar 2021 06:50:51 -0700 (PDT)
Date: Tue, 16 Mar 2021 09:50:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [virtio-comment] Re: [RFC PATCH v1 0/1] virtio-vsock: introduce
 SEQPACKET description
Message-ID: <20210316095002-mutt-send-email-mst@kernel.org>
References: <20210218060715.1075547-1-arseny.krasnov@kaspersky.com>
 <20210222101654.63tz75jzspiwt4tc@steredhat>
MIME-Version: 1.0
In-Reply-To: <20210222101654.63tz75jzspiwt4tc@steredhat>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, cohuck@redhat.com,
 Colin Ian King <colin.king@canonical.com>, oxffffaa@gmail.com,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 virtio-comment@lists.oasis-open.org, Jakub Kicinski <kuba@kernel.org>,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>,
 virtualization@lists.linux-foundation.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Feb 22, 2021 at 11:16:54AM +0100, Stefano Garzarella wrote:
> On Thu, Feb 18, 2021 at 09:07:12AM +0300, Arseny Krasnov wrote:
> > This patchset adds description of SOCK_SEQPACKET socket's type
> > of virtio vsock.
> > 
> > Here is implementation:
> > https://lkml.org/lkml/2021/2/18/24
> > 
> > Arseny Krasnov(1):
> >  virtio-vsock: add SOCK_SEQPACKET description
> > 
> > virtio-vsock.tex | 40 +++++++++++++++++++++++++++++++++++++---
> > 1 files changed, 37 insertions(+), 3 deletions(-)
> > 
> > TODO:
> > - for messages identification I use header's field called 'msg_cnt'.
> >  May be it is better to call it 'msg_id' or 'msg_num', because it
> >  is used as ID, but implemented as counter.
> 
> If we use it only as an identifier, I think 'msg_id' is preferable and we
> shouldn't mention in the specs that it's a counter, since it's just a
> possible implementation.
> Instead if we use the counter for some control, for example if we lost a
> packet, then maybe msg_cnt is better.
> But since the channel shouldn't lose packets, I don't think this is the
> case.
> 
> > 
> > - in current version of specification, some values of headers' fields
> >  still unnamed, for example type of socket (stream or seqpacket), then
> >  shutdown flags. Spec says that for stream socket value of 'type'
> >  must be 1. For receive shutdown bit 0 is set in 'flags', for send
> >  shutdown bit 1 is set in 'flags'. But in Linux these unnamed ones and
> >  zeroes are implemented as enums, so may be it will be ok to add such
> >  enums in specification (as 'enum virtio_vsock_event_id').
> 
> Since we have an enumerate for VIRTIO_VSOCK_OP_* values, I think we can add
> enums for socket type and maybe 'flags'.

We really need to switch enums to defines, for consistency.



> Thanks,
> Stefano
> 
> 
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
> 
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
> 
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
