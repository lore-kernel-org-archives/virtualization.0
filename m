Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3320DC0015E
	for <virtualization@archiver.kernel.org>; Tue, 25 Jul 2023 12:39:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BAD4140A21;
	Tue, 25 Jul 2023 12:39:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BAD4140A21
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DOKiICql
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bZZ76WOcX6oN; Tue, 25 Jul 2023 12:39:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EA02640022;
	Tue, 25 Jul 2023 12:39:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EA02640022
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFB48C0072;
	Tue, 25 Jul 2023 12:39:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA65CC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 12:39:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A106B408BF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 12:39:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A106B408BF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R0sd12QR2uQz
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 12:39:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C7ACC40022
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 12:39:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C7ACC40022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690288766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C0L81qzAix0/zgzaASRrrWq5Ht6GiafQqJmF+ctDLSM=;
 b=DOKiICqlnTJJewQwRSx22N9RzwfA0yw6TeJqWyT0XIJVHHixOPrgzvBTYCk3OOG3U57IPY
 HF69RdTdk0XcpolRGcb9w/zR5lN1Aezaokqpdb7EaHZl3cAsQ0dJU9DON6NgMvWMdXT+C+
 LQ5nFkn24UJM40qmY8T7Qk/fkevfhsM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-EF__kuwUNKeUCaxFQUpqgg-1; Tue, 25 Jul 2023 08:39:24 -0400
X-MC-Unique: EF__kuwUNKeUCaxFQUpqgg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-51a595bc30dso6869232a12.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 05:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690288763; x=1690893563;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C0L81qzAix0/zgzaASRrrWq5Ht6GiafQqJmF+ctDLSM=;
 b=IngtcHX9vPpHsWQYHL7JWbTBGIHjldd9vUMLN7cT+VPt0YIgYVaZEFnOHyA+5aXEGQ
 Q4Zg7+FmVFF303C7R1hlpv76iVrdDT8nfiX6r1cfmXHefDmyk7W8YiH8f9w35hjzPHys
 HnTuLPkSsJjGD6xY/ILFvVYrm8JKpfT1Bani9OevfSAP+yTT1/k/f+B+xScMfm4w/Obk
 if5FGSOttcqTDIyb8f+bUdD8sJw6Y/uZVLqCn+v1V2jwS59SSzxf1zXk6vWycIsmHcMc
 8rkITWc0MqW0ogA+iAWPXKlS5m7Wyge7x4vl5gIxFnwuyLTL8cXPU0T2c4TvGLfiFliU
 rARw==
X-Gm-Message-State: ABy/qLYpljflqOT82pBpvy14dtg1BCudyfxTHpO0+Vse38hW0YLozkhe
 tpKqTpeuZyfzmP6PPYDiyG7MOq2Uch/eAajrDdmjFAjMgj4lROMgO/7XFvYTIVusuvBscx3ln8k
 dsPy/iA8v6qhheL+kp+oOz4RxOSvmz4uE3Y3iSef9Ng==
X-Received: by 2002:a05:6402:7da:b0:521:d2ab:e4df with SMTP id
 u26-20020a05640207da00b00521d2abe4dfmr2242349edy.19.1690288763017; 
 Tue, 25 Jul 2023 05:39:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEZbT/9sLf9SJUi2km6xKCfsN6lBnNmF8+myjdUi1f+mFGkC/VPgqG8v9x7Cn7VgrIjISJYxQ==
X-Received: by 2002:a05:6402:7da:b0:521:d2ab:e4df with SMTP id
 u26-20020a05640207da00b00521d2abe4dfmr2242326edy.19.1690288762712; 
 Tue, 25 Jul 2023 05:39:22 -0700 (PDT)
Received: from redhat.com ([2.55.164.187]) by smtp.gmail.com with ESMTPSA id
 kg13-20020a17090776ed00b009929ab17be0sm8168056ejc.162.2023.07.25.05.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 05:39:22 -0700 (PDT)
Date: Tue, 25 Jul 2023 08:39:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net-next v3 4/4] vsock/virtio: MSG_ZEROCOPY flag support
Message-ID: <20230725083823-mutt-send-email-mst@kernel.org>
References: <20230720214245.457298-1-AVKrasnov@sberdevices.ru>
 <20230720214245.457298-5-AVKrasnov@sberdevices.ru>
 <091c067b-43a0-da7f-265f-30c8c7e62977@sberdevices.ru>
 <2k3cbz762ua3fmlben5vcm7rs624sktaltbz3ldeevwiguwk2w@klggxj5e3ueu>
 <51022d5f-5b50-b943-ad92-b06f60bef433@sberdevices.ru>
 <3d1d76c9-2fdb-3dfe-222a-b2184cf17708@sberdevices.ru>
 <o6axh6mxd6mxai2zrpax6wa25slns7ysz5xsegntskvfxl53mt@wowjgb3jazt6>
MIME-Version: 1.0
In-Reply-To: <o6axh6mxd6mxai2zrpax6wa25slns7ysz5xsegntskvfxl53mt@wowjgb3jazt6>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Arseniy Krasnov <avkrasnov@sberdevices.ru>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel@sberdevices.ru, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Tue, Jul 25, 2023 at 02:28:02PM +0200, Stefano Garzarella wrote:
> On Tue, Jul 25, 2023 at 12:16:11PM +0300, Arseniy Krasnov wrote:
> > =

> > =

> > On 25.07.2023 11:46, Arseniy Krasnov wrote:
> > > =

> > > =

> > > On 25.07.2023 11:43, Stefano Garzarella wrote:
> > > > On Fri, Jul 21, 2023 at 08:09:03AM +0300, Arseniy Krasnov wrote:
> > > > > =

> > > > > =

> > > > > On 21.07.2023 00:42, Arseniy Krasnov wrote:
> > > > > > This adds handling of MSG_ZEROCOPY flag on transmission path: i=
f this
> > > > > > flag is set and zerocopy transmission is possible (enabled in s=
ocket
> > > > > > options and transport allows zerocopy), then non-linear skb wil=
l be
> > > > > > created and filled with the pages of user's buffer. Pages of us=
er's
> > > > > > buffer are locked in memory by 'get_user_pages()'. Second thing=
 that
> > > > > > this patch does is replace type of skb owning: instead of calli=
ng
> > > > > > 'skb_set_owner_sk_safe()' it calls 'skb_set_owner_w()'. Reason =
of this
> > > > > > change is that '__zerocopy_sg_from_iter()' increments 'sk_wmem_=
alloc'
> > > > > > of socket, so to decrease this field correctly proper skb destr=
uctor is
> > > > > > needed: 'sock_wfree()'. This destructor is set by 'skb_set_owne=
r_w()'.
> > > > > > =

> > > > > > Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> > > > > > ---
> > > > > > =A0Changelog:
> > > > > > =A0v5(big patchset) -> v1:
> > > > > > =A0 * Refactorings of 'if' conditions.
> > > > > > =A0 * Remove extra blank line.
> > > > > > =A0 * Remove 'frag_off' field unneeded init.
> > > > > > =A0 * Add function 'virtio_transport_fill_skb()' which fills bo=
th linear
> > > > > > =A0=A0=A0 and non-linear skb with provided data.
> > > > > > =A0v1 -> v2:
> > > > > > =A0 * Use original order of last four arguments in 'virtio_tran=
sport_alloc_skb()'.
> > > > > > =A0v2 -> v3:
> > > > > > =A0 * Add new transport callback: 'msgzerocopy_check_iov'. It c=
hecks that
> > > > > > =A0=A0=A0 provided 'iov_iter' with data could be sent in a zero=
copy mode.
> > > > > > =A0=A0=A0 If this callback is not set in transport - transport =
allows to send
> > > > > > =A0=A0=A0 any 'iov_iter' in zerocopy mode. Otherwise - if callb=
ack returns 'true'
> > > > > > =A0=A0=A0 then zerocopy is allowed. Reason of this callback is =
that in case of
> > > > > > =A0=A0=A0 G2H transmission we insert whole skb to the tx virtio=
 queue and such
> > > > > > =A0=A0=A0 skb must fit to the size of the virtio queue to be se=
nt in a single
> > > > > > =A0=A0=A0 iteration (may be tx logic in 'virtio_transport.c' co=
uld be reworked
> > > > > > =A0=A0=A0 as in vhost to support partial send of current skb). =
This callback
> > > > > > =A0=A0=A0 will be enabled only for G2H path. For details pls se=
e comment
> > > > > > =A0=A0=A0 'Check that tx queue...' below.
> > > > > > =

> > > > > > =A0include/net/af_vsock.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0=A0 3 +
> > > > > > =A0net/vmw_vsock/virtio_transport.c=A0=A0=A0=A0=A0=A0=A0 |=A0 3=
9 ++++
> > > > > > =A0net/vmw_vsock/virtio_transport_common.c | 257 ++++++++++++++=
++++------
> > > > > > =A03 files changed, 241 insertions(+), 58 deletions(-)
> > > > > > =

> > > > > > diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> > > > > > index 0e7504a42925..a6b346eeeb8e 100644
> > > > > > --- a/include/net/af_vsock.h
> > > > > > +++ b/include/net/af_vsock.h
> > > > > > @@ -177,6 +177,9 @@ struct vsock_transport {
> > > > > > =

> > > > > > =A0=A0=A0=A0 /* Read a single skb */
> > > > > > =A0=A0=A0=A0 int (*read_skb)(struct vsock_sock *, skb_read_acto=
r_t);
> > > > > > +
> > > > > > +=A0=A0=A0 /* Zero-copy. */
> > > > > > +=A0=A0=A0 bool (*msgzerocopy_check_iov)(const struct iov_iter =
*);
> > > > > > =A0};
> > > > > > =

> > > > > > =A0/**** CORE ****/
> > > > > > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/v=
irtio_transport.c
> > > > > > index 7bbcc8093e51..23cb8ed638c4 100644
> > > > > > --- a/net/vmw_vsock/virtio_transport.c
> > > > > > +++ b/net/vmw_vsock/virtio_transport.c
> > > > > > @@ -442,6 +442,43 @@ static void virtio_vsock_rx_done(struct vi=
rtqueue *vq)
> > > > > > =A0=A0=A0=A0 queue_work(virtio_vsock_workqueue, &vsock->rx_work=
);
> > > > > > =A0}
> > > > > > =

> > > > > > +static bool
> > > > > > virtio_transport_msgzerocopy_check_iov(const struct
> > > > > > iov_iter *iov)
> > > > > > +{
> > > > > > +=A0=A0=A0 struct virtio_vsock *vsock;
> > > > > > +=A0=A0=A0 bool res =3D false;
> > > > > > +
> > > > > > +=A0=A0=A0 rcu_read_lock();
> > > > > > +
> > > > > > +=A0=A0=A0 vsock =3D rcu_dereference(the_virtio_vsock);
> > > > > > +=A0=A0=A0 if (vsock) {
> =

> Just noted, what about the following to reduce the indentation?
> =

>         if (!vsock) {
>             goto out;
>         }

no {} pls

>             ...
>             ...
>     out:
>         rcu_read_unlock();
>         return res;

indentation is quite modest here. Not sure goto is worth it.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
