Return-Path: <SRS0=p2bm=JS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABE8C433B4
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 08:24:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C202A6142C
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 08:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C202A6142C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 30F4340392;
	Wed, 21 Apr 2021 08:24:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5oKx4eADWtRj; Wed, 21 Apr 2021 08:24:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id B926D404EB;
	Wed, 21 Apr 2021 08:24:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CBDCC000E;
	Wed, 21 Apr 2021 08:24:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 232B5C001E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 08:24:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 63C1F83E2A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 08:24:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id unA9U45esZuf
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 08:24:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3332383E26
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 08:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618993483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O9CZm+91EdQYg7yYBJww7y34QuMMqs7TuU0rnr6Nr3o=;
 b=PaXYMr1wAnyXGntaGPyn6g+iw4BmtPBdjTw2ThxxUrB4gNPVbbM1AmY1IpVAzZLnKbCXgh
 3C+XccfJ+rZ5H6NXAPoAVH3wQkW7uQCZ4cLuu/+ipI7C4bnmaQ6FxO0bAzWBsRx9C5j/+T
 qlFCBhwpAujodJctvcgrdAEZp0MK39s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-Ssu6iiNoMvKCSaHb4SB9yA-1; Wed, 21 Apr 2021 04:24:41 -0400
X-MC-Unique: Ssu6iiNoMvKCSaHb4SB9yA-1
Received: by mail-wr1-f72.google.com with SMTP id
 t18-20020adfdc120000b02900ffe4432d8bso12326072wri.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 01:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=O9CZm+91EdQYg7yYBJww7y34QuMMqs7TuU0rnr6Nr3o=;
 b=alGoQkNab8xay32RuREI9tVrEe61UQkJaHTN84ctc95OzmxxggxSLmbKYK4iz5BbA7
 emgwYhMbyVv7qDZ+MjNCslbj2DoVvrPCK8NrDWTff8QRW9NscJS+G/mPO2DLu+uON/g7
 uqxt2yZPCc/ZsHgXvJTQlnB6FHu2npN9aB+Z9kB6aXtjrjPjNtr0t/T2eUjpBzFnrvo9
 8Wv9IVfVrxlCIb+X0EckO7Bop4k72B3Y2z0ywRjMKrST71cFaxx/Tlz6InOjF0QYc4+O
 afQhJr0JcjXjEKpJyD7KngrLjdGp9108w3cuWY1FwBXmGUcIzPzSLwEPGwY439GUTZGN
 E/Qg==
X-Gm-Message-State: AOAM533u4P8FTT7WDDYv29mB8N83sk+XAQtJeyXEdmju/9nMQGtvmmiN
 t6E5g51itiP35i49q50WCGBwYSImJv+pgjxqHOjkwhwX/nFf5btIyjxWAw144cFZLxS3iC8Ozos
 z4Teilnf0UnnqxkXwpLFKBAKFSN7eXBYetVzpZR4whQ==
X-Received: by 2002:a7b:cc10:: with SMTP id f16mr8344591wmh.131.1618993480374; 
 Wed, 21 Apr 2021 01:24:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgb+RWFCn5LziYb3Wo3ZVu5BWtbx7BbuNVYAN8bileqniP+A4PXpOP2ZgSsjH0OHqgw6Bf/w==
X-Received: by 2002:a7b:cc10:: with SMTP id f16mr8344567wmh.131.1618993480110; 
 Wed, 21 Apr 2021 01:24:40 -0700 (PDT)
Received: from redhat.com ([2a10:800a:cdef:0:114d:2085:61e4:7b41])
 by smtp.gmail.com with ESMTPSA id s8sm2161869wrn.97.2021.04.21.01.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Apr 2021 01:24:39 -0700 (PDT)
Date: Wed, 21 Apr 2021 04:24:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [virtio-comment] Re: [RFC PATCH v5 2/2] virtio-vsock:
 SOCK_SEQPACKET description
Message-ID: <20210421042335-mutt-send-email-mst@kernel.org>
References: <20210413125217.3416876-1-arseny.krasnov@kaspersky.com>
 <20210413125333.3419315-1-arseny.krasnov@kaspersky.com>
 <20210413090642-mutt-send-email-mst@kernel.org>
 <92a6b268-a36a-5f1b-2d67-02accfde70ce@kaspersky.com>
 <20210413155316-mutt-send-email-mst@kernel.org>
 <783d12e5-50b6-2363-f953-bc95d4b59d72@kaspersky.com>
 <20210421074523.s7wna25hsy65vc75@steredhat>
MIME-Version: 1.0
In-Reply-To: <20210421074523.s7wna25hsy65vc75@steredhat>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
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
 Arseny Krasnov <arseny.krasnov@kaspersky.com>,
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Apr 21, 2021 at 09:45:23AM +0200, Stefano Garzarella wrote:
> On Wed, Apr 14, 2021 at 09:04:47AM +0300, Arseny Krasnov wrote:
> > =

> > On 13.04.2021 22:55, Michael S. Tsirkin wrote:
> > > On Tue, Apr 13, 2021 at 05:22:44PM +0300, Arseny Krasnov wrote:
> > > > On 13.04.2021 16:10, Michael S. Tsirkin wrote:
> > > > > On Tue, Apr 13, 2021 at 03:53:29PM +0300, Arseny Krasnov wrote:
> > > > > > This adds description of SOCK_SEQPACKET socket type
> > > > > > support for virtio-vsock.
> > > > > > =

> > > > > > Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> > > > > > ---
> > > > > >  virtio-vsock.tex | 26 +++++++++++++++++++++-----
> > > > > >  1 file changed, 21 insertions(+), 5 deletions(-)
> > > > > > =

> > > > > > diff --git a/virtio-vsock.tex b/virtio-vsock.tex
> > > > > > index ad57f9d..00e59cc 100644
> > > > > > --- a/virtio-vsock.tex
> > > > > > +++ b/virtio-vsock.tex
> > > > > > @@ -16,7 +16,10 @@ \subsection{Virtqueues}\label{sec:Device Typ=
es / Socket Device / Virtqueues}
> > > > > > =

> > > > > >  \subsection{Feature bits}\label{sec:Device Types / Socket Devi=
ce / Feature bits}
> > > > > > =

> > > > > > -There are currently no feature bits defined for this device.
> > > > > > +\begin{description}
> > > > > > +\item VIRTIO_VSOCK_F_SEQPACKET (0) SOCK_SEQPACKET socket type =
is
> > > > > > +    supported.
> > > > > Does it make sense to only support seqpacket and not stream?
> > > > > I am guessing not since seqpacket is more or less
> > > > > a superset ...
> > > > You mean, this sentence must be "Both SOCK_SEQPACKET and SOCK_STREA=
M types
> > > > =

> > > > are supported"?
> > > =

> > > No. I am asking whether we want a feature bit for SOCK_STREAM too?
> > =

> > I think=A0 there is no practical sense in SOCK_STREAM bit, because SOCK=
_SEQPACKET
> > =

> > is stream + message boundaries and potential DGRAM is completely differ=
ent
> > =

> > thing. Of course i can implement it in my patches and also add it to sp=
ec patch, but=A0 i see only
> > =

> > esthetic in this: all three socket types have own feature bits.
> > =

> =

> I agree that it may make sense to have a bit for SOCK_STREAM. For example=
 we
> may have devices in the future that want to implement only DGRAM for
> simplicity.
> =

> I'm just worried about backwards compatibility with current devices where=
 we
> don't have any feature bit.
> =

> Should we add a negative feature flag? (e.g. VIRTIO_VSOCK_F_NO_STREAM)
> I don't like it much, but I can't think of anything better.
> =

> Thanks,
> Stefano

We can simply specify that if there are no feature bits at all then
stream is assumed supported.


> =

> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
> =

> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
> =

> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-l=
ists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
