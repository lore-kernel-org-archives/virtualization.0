Return-Path: <SRS0=p2bm=JS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAFFC433B4
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 07:45:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D40761433
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 07:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D40761433
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BBAD40666;
	Wed, 21 Apr 2021 07:45:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NaVYhNEaKA2E; Wed, 21 Apr 2021 07:45:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8414F4065E;
	Wed, 21 Apr 2021 07:45:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D611C000F;
	Wed, 21 Apr 2021 07:45:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3207C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 07:45:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C244983D60
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 07:45:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R5MjXCKDvG3f
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 07:45:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0155483D5C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 07:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618991129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=90bVDlVrgCBNgDTtoBFZbp2bfy3Oa8Cjch3Nag5iAqg=;
 b=YVj/9E3rMc9K2oH+nSn4NbJ13xjIg/2xqJmjbgU7N8pT523P3zRmSVX8lIA8CrH9Fnt0Vn
 sPQMfCzkGaDkgaHu2UdAELYWkJYexyXDFWPgNL+Ufl8/ARBL4QCxr2gDMRFsgc5G01eglI
 6nMpvmQ+9x/VEMLuM70v1wbz3E7Agoo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-1p7lKpmRM2e3iEt4nVLOZQ-1; Wed, 21 Apr 2021 03:45:27 -0400
X-MC-Unique: 1p7lKpmRM2e3iEt4nVLOZQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 d16-20020a1709066410b0290373cd3ce7e6so5576543ejm.14
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 00:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=90bVDlVrgCBNgDTtoBFZbp2bfy3Oa8Cjch3Nag5iAqg=;
 b=uBXrcqpSeU43tCm8GpZyyOK3WeSVSnipG87BJyczyuxVDly5E+HU9JX0MWr42v+3R6
 ureCq+oVxXVQecpWirvkmoDQHiVA/p0Z4Ui30gkpw/VIH8MghglhHXIXSRrVzVPlxCJq
 kFZh8i2ZlhMDliWzelDKwKvV6SfTEfe9EqBFhhym5kWkx7fhR/QietoAqjFC12E/OIn1
 RW4/3MWG5SSqH2gm6mYWsR7XgtduF5UgltxLlFmbqwHC/PY1a0asfTF71e/1kHOVxhwZ
 MxShbNx8vgenLOPSrD64g6QNy+0EtZxKDidaK6/P4AA77rtF8s0Rh4weuJnpTIP4hO1S
 rEcg==
X-Gm-Message-State: AOAM5333JRgqBGOzDhJa3XMsAtSjtGXH2MoErr8GjEG4EV/Z9vUbhhpI
 IkFKm9wa6xaF7uumVVtM50yHlcRGW3LXU6Yj008D93EF8HTS5DWull40+9cna4Z1AfoL7lKD6LW
 2++3b7sErWgU0F1mS8xOBnimi0RX2M28s0u9Jc91iMw==
X-Received: by 2002:a17:907:264f:: with SMTP id
 ar15mr32100613ejc.484.1618991126503; 
 Wed, 21 Apr 2021 00:45:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdof39avLRNCQMtHlytV6BRsG4vnvmTYi2Ofn3oTzl3ERCH0thOzPOd8QQer2Rb21xnvPE7Q==
X-Received: by 2002:a17:907:264f:: with SMTP id
 ar15mr32100604ejc.484.1618991126321; 
 Wed, 21 Apr 2021 00:45:26 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id gz10sm1469137ejc.25.2021.04.21.00.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Apr 2021 00:45:25 -0700 (PDT)
Date: Wed, 21 Apr 2021 09:45:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH v5 2/2] virtio-vsock: SOCK_SEQPACKET description
Message-ID: <20210421074523.s7wna25hsy65vc75@steredhat>
References: <20210413125217.3416876-1-arseny.krasnov@kaspersky.com>
 <20210413125333.3419315-1-arseny.krasnov@kaspersky.com>
 <20210413090642-mutt-send-email-mst@kernel.org>
 <92a6b268-a36a-5f1b-2d67-02accfde70ce@kaspersky.com>
 <20210413155316-mutt-send-email-mst@kernel.org>
 <783d12e5-50b6-2363-f953-bc95d4b59d72@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <783d12e5-50b6-2363-f953-bc95d4b59d72@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, Jeff Vander Stoep <jeffv@google.com>,
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

On Wed, Apr 14, 2021 at 09:04:47AM +0300, Arseny Krasnov wrote:
>
>On 13.04.2021 22:55, Michael S. Tsirkin wrote:
>> On Tue, Apr 13, 2021 at 05:22:44PM +0300, Arseny Krasnov wrote:
>>> On 13.04.2021 16:10, Michael S. Tsirkin wrote:
>>>> On Tue, Apr 13, 2021 at 03:53:29PM +0300, Arseny Krasnov wrote:
>>>>> This adds description of SOCK_SEQPACKET socket type
>>>>> support for virtio-vsock.
>>>>>
>>>>> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>>>>> ---
>>>>>  virtio-vsock.tex | 26 +++++++++++++++++++++-----
>>>>>  1 file changed, 21 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/virtio-vsock.tex b/virtio-vsock.tex
>>>>> index ad57f9d..00e59cc 100644
>>>>> --- a/virtio-vsock.tex
>>>>> +++ b/virtio-vsock.tex
>>>>> @@ -16,7 +16,10 @@ \subsection{Virtqueues}\label{sec:Device Types / S=
ocket Device / Virtqueues}
>>>>>
>>>>>  \subsection{Feature bits}\label{sec:Device Types / Socket Device / F=
eature bits}
>>>>>
>>>>> -There are currently no feature bits defined for this device.
>>>>> +\begin{description}
>>>>> +\item VIRTIO_VSOCK_F_SEQPACKET (0) SOCK_SEQPACKET socket type is
>>>>> +    supported.
>>>> Does it make sense to only support seqpacket and not stream?
>>>> I am guessing not since seqpacket is more or less
>>>> a superset ...
>>> You mean, this sentence must be "Both SOCK_SEQPACKET and SOCK_STREAM ty=
pes
>>>
>>> are supported"?
>>
>> No. I am asking whether we want a feature bit for SOCK_STREAM too?
>
>I think=A0 there is no practical sense in SOCK_STREAM bit, because SOCK_SE=
QPACKET
>
>is stream + message boundaries and potential DGRAM is completely different
>
>thing. Of course i can implement it in my patches and also add it to spec =
patch, but=A0 i see only
>
>esthetic in this: all three socket types have own feature bits.
>

I agree that it may make sense to have a bit for SOCK_STREAM. For =

example we may have devices in the future that want to implement only =

DGRAM for simplicity.

I'm just worried about backwards compatibility with current devices =

where we don't have any feature bit.

Should we add a negative feature flag? (e.g. VIRTIO_VSOCK_F_NO_STREAM)
I don't like it much, but I can't think of anything better.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
