Return-Path: <SRS0=cXtE=IO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A848C433DB
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 14:08:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0F764F0C
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 14:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0F764F0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D31C605E0;
	Tue, 16 Mar 2021 14:08:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VZtOWWibopy9; Tue, 16 Mar 2021 14:08:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD6C960664;
	Tue, 16 Mar 2021 14:08:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B790AC000C;
	Tue, 16 Mar 2021 14:08:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4003BC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 14:08:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 198D060664
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 14:08:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TGZ9YVT1ZqJP
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 14:08:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 282CF605E0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 14:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615903716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MRHGjkHDkGx5RQrNBl/0GvcmsIRONkq0oieKafsVXN8=;
 b=PFd7xKZllxOXySBzeI6AKg5KtZFAGZKWAS2sAv1Y4YT9EIf4jVbD/+S9hmOpzHuJbIBHhZ
 ozfLa4mIAEOfm6IzsYchFAgdLiyJ+anlTBMZss1+mG9vgvwZOuk8KRw3Zqkpg8sNxD7Tyo
 Prj8b22ijq1V9ZBD2KrGiXXHRVoyw4c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-P4BI-PkDMsiMjon6RemG8w-1; Tue, 16 Mar 2021 10:08:35 -0400
X-MC-Unique: P4BI-PkDMsiMjon6RemG8w-1
Received: by mail-wm1-f72.google.com with SMTP id a63so3436567wmd.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 07:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MRHGjkHDkGx5RQrNBl/0GvcmsIRONkq0oieKafsVXN8=;
 b=Jy/aNnHFOTib5urNPFGWGaRpFanbKO4IIlU1kidsWtT8V1yXh1B5TiPApYlKU9K32H
 nMVVjVYG5BOwwgMb5awkLL/DPwTUlMdZ7DBfPPaszkKo0PgyYN7GlHZo5wkwc+SqMFcv
 VzlyvOBNi7DD5T7Z08pzlX/0tpzfpg+mNP0xQR9P+mN2ZTcIowLHutHx1QyDTp8FoPN1
 fVLS8UBmlPCwLJVK1h04YF8rkIfP6bd+t0cNQpmqxVI8JIUKemuHfc/jCG9x71V9u6Z0
 J1WfAG4BBQTxohRJ99x1LO/PzHVMPYxR5IeUSme7WMyG7nvPtiziH7avqmVpF0xVIzTF
 gmPg==
X-Gm-Message-State: AOAM5301Iwryb+VuC29bqYjpHWPGWHjxA/ISfWZX4zb6bQYfmQvvN8Yn
 1gITnEdi4h0AqXNp97YhUZO4tx18OnysEi+vcahZYtEg4Lp8/4mVvaFT4tvJqWX3MLToao5xsID
 yQ3SMWS0LZoMunsdka/HSWZu4R+Qxah0omxGy3KPogQ==
X-Received: by 2002:a5d:5250:: with SMTP id k16mr5150302wrc.309.1615903708887; 
 Tue, 16 Mar 2021 07:08:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTrCm9EqsBY7CcmKfftdO14fNCrt42VSjoGeaEFF9ovetbKQPowW0yoqnxTusjsFrXTTnZqw==
X-Received: by 2002:a5d:5250:: with SMTP id k16mr5150014wrc.309.1615903706101; 
 Tue, 16 Mar 2021 07:08:26 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id o2sm3237151wme.16.2021.03.16.07.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Mar 2021 07:08:25 -0700 (PDT)
Date: Tue, 16 Mar 2021 15:08:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] Re: [RFC PATCH v1 0/1] virtio-vsock: introduce
 SEQPACKET description
Message-ID: <20210316140822.gvdtqci22tlmh3x6@steredhat>
References: <20210218060715.1075547-1-arseny.krasnov@kaspersky.com>
 <20210222101654.63tz75jzspiwt4tc@steredhat>
 <20210316095002-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210316095002-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Mar 16, 2021 at 09:50:48AM -0400, Michael S. Tsirkin wrote:
>On Mon, Feb 22, 2021 at 11:16:54AM +0100, Stefano Garzarella wrote:
>> On Thu, Feb 18, 2021 at 09:07:12AM +0300, Arseny Krasnov wrote:
>> > This patchset adds description of SOCK_SEQPACKET socket's type
>> > of virtio vsock.
>> >
>> > Here is implementation:
>> > https://lkml.org/lkml/2021/2/18/24
>> >
>> > Arseny Krasnov(1):
>> >  virtio-vsock: add SOCK_SEQPACKET description
>> >
>> > virtio-vsock.tex | 40 +++++++++++++++++++++++++++++++++++++---
>> > 1 files changed, 37 insertions(+), 3 deletions(-)
>> >
>> > TODO:
>> > - for messages identification I use header's field called 'msg_cnt'.
>> >  May be it is better to call it 'msg_id' or 'msg_num', because it
>> >  is used as ID, but implemented as counter.
>>
>> If we use it only as an identifier, I think 'msg_id' is preferable and we
>> shouldn't mention in the specs that it's a counter, since it's just a
>> possible implementation.
>> Instead if we use the counter for some control, for example if we lost a
>> packet, then maybe msg_cnt is better.
>> But since the channel shouldn't lose packets, I don't think this is the
>> case.
>>
>> >
>> > - in current version of specification, some values of headers' fields
>> >  still unnamed, for example type of socket (stream or seqpacket), then
>> >  shutdown flags. Spec says that for stream socket value of 'type'
>> >  must be 1. For receive shutdown bit 0 is set in 'flags', for send
>> >  shutdown bit 1 is set in 'flags'. But in Linux these unnamed ones and
>> >  zeroes are implemented as enums, so may be it will be ok to add such
>> >  enums in specification (as 'enum virtio_vsock_event_id').
>>
>> Since we have an enumerate for VIRTIO_VSOCK_OP_* values, I think we can add
>> enums for socket type and maybe 'flags'.
>
>We really need to switch enums to defines, for consistency.

I fully agree, indeed at least in the virtio-vsock part, we use the 
enumerate as they were many defines, always redefining the assigned 
value.
Using defines, we are forced to always define the value and I think 
that's fair!

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
