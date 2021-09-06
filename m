Return-Path: <SRS0=ZzT7=N4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D99DC433EF
	for <virtualization@archiver.kernel.org>; Mon,  6 Sep 2021 07:33:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C410C606A5
	for <virtualization@archiver.kernel.org>; Mon,  6 Sep 2021 07:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C410C606A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E359401F8;
	Mon,  6 Sep 2021 07:33:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zt0h-EVdYqQY; Mon,  6 Sep 2021 07:33:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 16D0340166;
	Mon,  6 Sep 2021 07:33:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE4D8C0020;
	Mon,  6 Sep 2021 07:33:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5893CC001B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 07:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 45DB860623
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 07:33:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FkF_h6XTHMqu
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 07:33:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B70F605F5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 07:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630913602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RSrx4XOVTKDR+lRM3utIJIs7HCPXyZCtAZOFr15Y8Bw=;
 b=aWeXZUiuwaC8TFEuFQddTgSzWPcnlZ+jdA5ibPsRReUmr1tWkqzlPT0VS+ghp9pyZyhqWV
 Dw90R5kKhEbns1cmbYbpbYnD8PcENoxSXguV3xcAGLEOWdVq1BWsNhCajd0k7KI91ibDu5
 5A1NjTjTSceJJm7RqJKOH48Jw/+2BoI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-ZyUgX1InMB-DTphCfp7k3A-1; Mon, 06 Sep 2021 03:33:19 -0400
X-MC-Unique: ZyUgX1InMB-DTphCfp7k3A-1
Received: by mail-ej1-f72.google.com with SMTP id
 o7-20020a170906288700b005bb05cb6e25so1901059ejd.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Sep 2021 00:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RSrx4XOVTKDR+lRM3utIJIs7HCPXyZCtAZOFr15Y8Bw=;
 b=a87XzkHKV5neRcA1rQRT4nDwErjCT+RgcgYlcdzTn+dnVh6/FxVXB2Tx7Ax4O1Pz7o
 0uirxEHRWTU57L5Dna3+OokgZv2T+wYMPQ0WRcDRzqA+dJZ2sxNPl2R7GpYJB0Q+TSDW
 B4UJdONbe65ilEuY2HVWQVuIujinwl/X8Z0YzkvWz9svXlnuXSKqNU9F+ksu2rKUGo7h
 NspuCuSdG7kZtNIJ63JJyUt1xyqguDpPpfVrOaQgT+I+tHiV+nGVW7fmMPcWIsd296VG
 01TYMlXfxfDMu8pu7WeJaPsCW0axIKBlNcQ5yU4nYiukOh0Bi1l1t+MI6XQYeC9HgunM
 IZWA==
X-Gm-Message-State: AOAM532FRSON0MhPt0Itgmlwnbg9tgL9p95t+siwcNzhzNHCZDKswGub
 3nXx4tu200o70eCEgt3f6RG7k2IXUhESdrWFCouJ99VAmKhu2bBdcdhMHhOQVJpQX03jBz31GSh
 aWrbK+ItY9LkBqhZVrzz3aOX64y1lUS+D7KWaDBLvAw==
X-Received: by 2002:a05:6402:524f:: with SMTP id
 t15mr12090724edd.121.1630913598481; 
 Mon, 06 Sep 2021 00:33:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztuWeCXr3yeqKVL82y9FHLYnMqEF7PCrl5+Qj+0fsCR1hZx3SVNS75Zj5Zq0HWAuYyDMs9jw==
X-Received: by 2002:a05:6402:524f:: with SMTP id
 t15mr12090699edd.121.1630913598298; 
 Mon, 06 Sep 2021 00:33:18 -0700 (PDT)
Received: from steredhat (host-79-51-2-59.retail.telecomitalia.it.
 [79.51.2.59])
 by smtp.gmail.com with ESMTPSA id y32sm4119673ede.22.2021.09.06.00.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Sep 2021 00:33:17 -0700 (PDT)
Date: Mon, 6 Sep 2021 09:33:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next v5 0/6] virtio/vsock: introduce MSG_EOR flag for
 SEQPACKET
Message-ID: <20210906073315.n7qgsv3gm7dasgzu@steredhat>
References: <20210903123016.3272800-1-arseny.krasnov@kaspersky.com>
 <20210905115139-mutt-send-email-mst@kernel.org>
 <4558e96b-6330-667f-955b-b689986f884f@kaspersky.com>
 <20210905121932-mutt-send-email-mst@kernel.org>
 <5b20410a-fb8f-2e38-59d9-74dc6b8a9d4f@kaspersky.com>
 <20210905161809-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210905161809-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "stsp2@yandex.ru" <stsp2@yandex.ru>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "oxffffaa@gmail.com" <oxffffaa@gmail.com>,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Colin Ian King <colin.king@canonical.com>,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>,
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

On Sun, Sep 05, 2021 at 04:18:52PM -0400, Michael S. Tsirkin wrote:
>On Sun, Sep 05, 2021 at 07:21:10PM +0300, Arseny Krasnov wrote:
>>
>> On 05.09.2021 19:19, Michael S. Tsirkin wrote:
>> > On Sun, Sep 05, 2021 at 07:02:44PM +0300, Arseny Krasnov wrote:
>> >> On 05.09.2021 18:55, Michael S. Tsirkin wrote:
>> >>> On Fri, Sep 03, 2021 at 03:30:13PM +0300, Arseny Krasnov wrote:
>> >>>> 	This patchset implements support of MSG_EOR bit for SEQPACKET
>> >>>> AF_VSOCK sockets over virtio transport.
>> >>>> 	First we need to define 'messages' and 'records' like this:
>> >>>> Message is result of sending calls: 'write()', 'send()', 'sendmsg()'
>> >>>> etc. It has fixed maximum length, and it bounds are visible using
>> >>>> return from receive calls: 'read()', 'recv()', 'recvmsg()' etc.
>> >>>> Current implementation based on message definition above.
>> >>>> 	Record has unlimited length, it consists of multiple message,
>> >>>> and bounds of record are visible via MSG_EOR flag returned from
>> >>>> 'recvmsg()' call. Sender passes MSG_EOR to sending system call and
>> >>>> receiver will see MSG_EOR when corresponding message will be processed.
>> >>>> 	Idea of patchset comes from POSIX: it says that SEQPACKET
>> >>>> supports record boundaries which are visible for receiver using
>> >>>> MSG_EOR bit. So, it looks like MSG_EOR is enough thing for SEQPACKET
>> >>>> and we don't need to maintain boundaries of corresponding send -
>> >>>> receive system calls. But, for 'sendXXX()' and 'recXXX()' POSIX says,
>> >>>> that all these calls operates with messages, e.g. 'sendXXX()' sends
>> >>>> message, while 'recXXX()' reads messages and for SEQPACKET, 'recXXX()'
>> >>>> must read one entire message from socket, dropping all out of size
>> >>>> bytes. Thus, both message boundaries and MSG_EOR bit must be supported
>> >>>> to follow POSIX rules.
>> >>>> 	To support MSG_EOR new bit was added along with existing
>> >>>> 'VIRTIO_VSOCK_SEQ_EOR': 'VIRTIO_VSOCK_SEQ_EOM'(end-of-message) - now it
>> >>>> works in the same way as 'VIRTIO_VSOCK_SEQ_EOR'. But 'VIRTIO_VSOCK_SEQ_EOR'
>> >>>> is used to mark 'MSG_EOR' bit passed from userspace.
>> >>>> 	This patchset includes simple test for MSG_EOR.
>> >>> I'm prepared to merge this for this window,
>> >>> but I'm not sure who's supposed to ack the net/vmw_vsock/af_vsock.c
>> >>> bits. It's a harmless variable renaming so maybe it does not matter.
>> >>>
>> >>> The rest is virtio stuff so I guess my tree is ok.
>> >>>
>> >>> Objections, anyone?
>> >> https://lkml.org/lkml/2021/9/3/76 this is v4. It is same as v5 in af_vsock.c changes.
>> >>
>> >> It has Reviewed by from Stefano Garzarella.
>> > Is Stefano the maintainer for af_vsock then?
>> > I wasn't sure.

I'm maintaining virtio-vsock stuff, but I'm reviewing most of the 
af_vsock patches. We don't have an entry for it in MAINTAINERS, maybe we 
should.

>> Ack, let's wait for maintainer's comment
>
>
>The specific patch is a trivial variable renaming so
>I parked this in my tree for now, will merge unless I
>hear any objections in the next couple of days.

I agree, I think your tree is fine, since this series is mostly about 
virtio-vsock.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
