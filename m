Return-Path: <SRS0=T/77=JT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B86BC433ED
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 09:00:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 891206144E
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 09:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891206144E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18B01405C5;
	Thu, 22 Apr 2021 09:00:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id srOHKn1WkRuP; Thu, 22 Apr 2021 09:00:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BA2F405BF;
	Thu, 22 Apr 2021 09:00:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E688C000F;
	Thu, 22 Apr 2021 09:00:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6399EC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 09:00:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 521F2405C2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 09:00:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XxGr-qHhob70
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 09:00:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1D24B405BF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 09:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619082011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BMiYw7M5bZm9zDKFXYwtpWLNGSm7la9gJTUUCZl+Nas=;
 b=d46MWf1Qsl3lWYRxnY9+XzPx6kzoSn5lP+20EZAHnZPnbKUQHrF5+Cs8ndOSPw4lxWyMOp
 OsNEWQBBg2mGT5fCHDXd9Ux4d4HeuQNfpRzG4eKBKBTh0AtknEEsfCjpEbR0fQm5N/kxY0
 MsgYMi4gx9gX3/zwjzbSFLar9wfhpAA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-RaTAfzxbNoKXOhg1fMs4bg-1; Thu, 22 Apr 2021 05:00:10 -0400
X-MC-Unique: RaTAfzxbNoKXOhg1fMs4bg-1
Received: by mail-ed1-f71.google.com with SMTP id
 l7-20020aa7c3070000b029038502ffe9f2so10595560edq.16
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 02:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=BMiYw7M5bZm9zDKFXYwtpWLNGSm7la9gJTUUCZl+Nas=;
 b=Dt/MSocKp0axoaQv+9ctEfV2J+QVlbrviWNby0nwQ6C8bkURDliULA4zvA1dlIfhxL
 cienDUuDP2mR17yu23DxIwEv0SRBtrOvh9TALYyWeMxr8XKEjtxqDcb/AoH1jxGjy9NI
 5L/ffQgMES+rt7I96SvTbFbKjPtAlXU16sIR3omKw+M1LRgA+1F+/7UGSsK4uZyterVL
 Lu9KRjkECU3gjcy+r3hmllheQAKoBJxuk106SyTSXTtXuapqUc5YIurPeHziKnyoOh3p
 0XNU5svc+TuUu1iMXke5A3aotUzdc8oWks/Ytc+KHzrAjlp1OHvA1BEQA93vTUCMClfI
 8eig==
X-Gm-Message-State: AOAM530/00XtUcjA5arS3vHzL9czlii36XeuvD7evxhrGXaXpNHZxM4F
 sXATBIM9B1xE/UPh6EpLqA+YFC2TRbYeLd5S+wvqm6ennVoHaEOjiJj1gGHmxqR/5ySMSTIrIhY
 sJFwiJMJUSxNgWPJAjmLk8lntrTE0C+4Di2qNEZfY1Q==
X-Received: by 2002:a17:907:16a3:: with SMTP id
 hc35mr2232905ejc.488.1619082008888; 
 Thu, 22 Apr 2021 02:00:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWCcWFR5Zh85WLfBj70AHDOacHAd4mnLV4Gz8dmrOeeFufgXCc/jtr2vEijRhePfy8I+BAMA==
X-Received: by 2002:a17:907:16a3:: with SMTP id
 hc35mr2232877ejc.488.1619082008652; 
 Thu, 22 Apr 2021 02:00:08 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id ju23sm1431247ejc.17.2021.04.22.02.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Apr 2021 02:00:08 -0700 (PDT)
Date: Thu, 22 Apr 2021 11:00:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [virtio-comment] Re: [RFC PATCH v5 2/2] virtio-vsock:
 SOCK_SEQPACKET description
Message-ID: <20210422090005.krhgunvunfu2er5u@steredhat>
References: <20210413125217.3416876-1-arseny.krasnov@kaspersky.com>
 <20210413125333.3419315-1-arseny.krasnov@kaspersky.com>
 <20210413090642-mutt-send-email-mst@kernel.org>
 <92a6b268-a36a-5f1b-2d67-02accfde70ce@kaspersky.com>
 <20210413155316-mutt-send-email-mst@kernel.org>
 <783d12e5-50b6-2363-f953-bc95d4b59d72@kaspersky.com>
 <20210421074523.s7wna25hsy65vc75@steredhat>
 <20210421042335-mutt-send-email-mst@kernel.org>
 <20210421095425.3bkixnasl34g3t5p@steredhat>
 <acd87b8c-f030-f757-130e-edab0e460cce@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <acd87b8c-f030-f757-130e-edab0e460cce@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Vander Stoep <jeffv@google.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 Colin Ian King <colin.king@canonical.com>,
 "oxffffaa@gmail.com" <oxffffaa@gmail.com>,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Jakub Kicinski <kuba@kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>,
 Alexander Popov <alex.popov@linux.com>
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Apr 21, 2021 at 06:09:21PM +0300, Arseny Krasnov wrote:
>
>On 21.04.2021 12:54, Stefano Garzarella wrote:
>> On Wed, Apr 21, 2021 at 04:24:36AM -0400, Michael S. Tsirkin wrote:
>>> On Wed, Apr 21, 2021 at 09:45:23AM +0200, Stefano Garzarella wrote:
>>>> On Wed, Apr 14, 2021 at 09:04:47AM +0300, Arseny Krasnov wrote:
>>>>> On 13.04.2021 22:55, Michael S. Tsirkin wrote:
>>>>>> On Tue, Apr 13, 2021 at 05:22:44PM +0300, Arseny Krasnov wrote:
>>>>>>> On 13.04.2021 16:10, Michael S. Tsirkin wrote:
>>>>>>>> On Tue, Apr 13, 2021 at 03:53:29PM +0300, Arseny Krasnov wrote:
>>>>>>>>> This adds description of SOCK_SEQPACKET socket type
>>>>>>>>> support for virtio-vsock.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>>>>>>>>> ---
>>>>>>>>>  virtio-vsock.tex | 26 +++++++++++++++++++++-----
>>>>>>>>>  1 file changed, 21 insertions(+), 5 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/virtio-vsock.tex b/virtio-vsock.tex
>>>>>>>>> index ad57f9d..00e59cc 100644
>>>>>>>>> --- a/virtio-vsock.tex
>>>>>>>>> +++ b/virtio-vsock.tex
>>>>>>>>> @@ -16,7 +16,10 @@ \subsection{Virtqueues}\label{sec:Device Types=
 / Socket Device / Virtqueues}
>>>>>>>>>
>>>>>>>>>  \subsection{Feature bits}\label{sec:Device Types / Socket Device=
 / Feature bits}
>>>>>>>>>
>>>>>>>>> -There are currently no feature bits defined for this device.
>>>>>>>>> +\begin{description}
>>>>>>>>> +\item VIRTIO_VSOCK_F_SEQPACKET (0) SOCK_SEQPACKET socket type is
>>>>>>>>> +    supported.
>>>>>>>> Does it make sense to only support seqpacket and not stream?
>>>>>>>> I am guessing not since seqpacket is more or less
>>>>>>>> a superset ...
>>>>>>> You mean, this sentence must be "Both SOCK_SEQPACKET and SOCK_STREA=
M types
>>>>>>>
>>>>>>> are supported"?
>>>>>> No. I am asking whether we want a feature bit for SOCK_STREAM too?
>>>>> I think=A0 there is no practical sense in SOCK_STREAM bit, because SO=
CK_SEQPACKET
>>>>>
>>>>> is stream + message boundaries and potential DGRAM is completely diff=
erent
>>>>>
>>>>> thing. Of course i can implement it in my patches and also add it to =
spec patch, but=A0 i see only
>>>>>
>>>>> esthetic in this: all three socket types have own feature bits.
>>>>>
>>>> I agree that it may make sense to have a bit for SOCK_STREAM. For exam=
ple we
>>>> may have devices in the future that want to implement only DGRAM for
>>>> simplicity.
>>>>
>>>> I'm just worried about backwards compatibility with current devices wh=
ere we
>>>> don't have any feature bit.
>>>>
>>>> Should we add a negative feature flag? (e.g. VIRTIO_VSOCK_F_NO_STREAM)
>>>> I don't like it much, but I can't think of anything better.
>>>>
>>>> Thanks,
>>>> Stefano
>>> We can simply specify that if there are no feature bits at all then
>>> stream is assumed supported.
>>>
>> oh yeah, that sounds like a good idea!
>
>So it is not necessary for my SEQPACKET patchset to support STREAM in both
>kernel and spec?
>

I don't think it's necessary for SEQPACKET, but I would reserve bit 0 to =

stream.

We could add a patch to this series that adds the bit for stream and =

explains that if there is no feature bit set, then only stream is =

supported.

Or I can send it separately if you don't want to include it in the =

series.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
