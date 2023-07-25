Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C0CC0015E
	for <virtualization@archiver.kernel.org>; Tue, 25 Jul 2023 12:46:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B17D4188B;
	Tue, 25 Jul 2023 12:46:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0B17D4188B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WP+CdbCU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AhYIaSFSr9EU; Tue, 25 Jul 2023 12:46:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E59AC41873;
	Tue, 25 Jul 2023 12:46:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E59AC41873
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC422C0072;
	Tue, 25 Jul 2023 12:46:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E08FC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 12:46:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1DE2C60F13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 12:46:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1DE2C60F13
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WP+CdbCU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MX3Y66yYkyvA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 12:46:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C3CEB60F10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 12:45:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C3CEB60F10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690289158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t+eENG+rkrOZJfNjBoNDuehMjca3+lXf+FSwHNM6NvM=;
 b=WP+CdbCUmC/Fid+VeYZopxudRVIHYl/oYkUBxRI7DchOVKqMWr9vWrnSqtbKmUt6QLPmEm
 Q4ptQQnYI0bngsBY1vnoonhHMQuVn5lInJlGN/wQNR2af8drU2RAjlM3YfJ5YbcyuoaIjp
 gouAap2OQ2tSfUICG6rjT4NGMcYXfRA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-bUgOl2rIMcKtyXn1v94WZw-1; Tue, 25 Jul 2023 08:45:54 -0400
X-MC-Unique: bUgOl2rIMcKtyXn1v94WZw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-98df34aa83aso283336666b.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 05:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690289153; x=1690893953;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t+eENG+rkrOZJfNjBoNDuehMjca3+lXf+FSwHNM6NvM=;
 b=Tn6weKms9g5xwE9QUaBAa8PXihiyOZkC6XT8y/jxXUy0sDOWdcF17ECFNdVkTBVtMj
 2MYmUL/2guE4Hty5SgO8XKzAsGZMZWbrii16hM6d8bNcXqE1mLG82ZB7ihSJdUX9oHUM
 twixohfEPzRApYlzdMXmVfaO0HaifhC34qHeQoYT11OYc60AW8SkR4Bqu38GMMzVNg0I
 5ofszl7t+GxIBrx6KvNDqWkd/6DR6uf9/RGmaobiqRYuopFcoQJKKhlWCyrELz7h3hET
 srYYX3mivw7YjT+vO/GT5ad/6dfhcmUuy5xiDBeFiOIQ4GrVV8qpUssz9iK4r0/TAlPZ
 k6Fw==
X-Gm-Message-State: ABy/qLYA6+WqJQ0VoAnSyrScsfaD5qrIWlvdB0LFkxt17IjCtnr3dmSl
 gfkBGGS1WO322L5df7JeJsX4ki+6jCuU/1HZ2/e4Wr2lbKHyqzX8htSjvzL0Q+ydrpndOa2LoYw
 BswQ45OybIQsstiMXrI6NxxFb7loDVSkqbZY4qkHyKw==
X-Received: by 2002:a17:906:3f1a:b0:998:de72:4c8c with SMTP id
 c26-20020a1709063f1a00b00998de724c8cmr2222683ejj.35.1690289153280; 
 Tue, 25 Jul 2023 05:45:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGeHiAYNGInnQAlVCX6nTI06/NOjTDYIJ/hUEthWuPlIk7sS6sNyToq0hN/g++ZIu00x02Vnw==
X-Received: by 2002:a17:906:3f1a:b0:998:de72:4c8c with SMTP id
 c26-20020a1709063f1a00b00998de724c8cmr2222669ejj.35.1690289152923; 
 Tue, 25 Jul 2023 05:45:52 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.201.198])
 by smtp.gmail.com with ESMTPSA id
 se10-20020a170906ce4a00b0098dfec235ccsm8106374ejb.47.2023.07.25.05.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 05:45:52 -0700 (PDT)
Date: Tue, 25 Jul 2023 14:45:48 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next v3 4/4] vsock/virtio: MSG_ZEROCOPY flag support
Message-ID: <fwtkhndptzz42r23p622zggr5yxyfms7ymylelahmofw2zr26z@ygd7wyhfi7fs>
References: <20230720214245.457298-1-AVKrasnov@sberdevices.ru>
 <20230720214245.457298-5-AVKrasnov@sberdevices.ru>
 <091c067b-43a0-da7f-265f-30c8c7e62977@sberdevices.ru>
 <2k3cbz762ua3fmlben5vcm7rs624sktaltbz3ldeevwiguwk2w@klggxj5e3ueu>
 <51022d5f-5b50-b943-ad92-b06f60bef433@sberdevices.ru>
 <3d1d76c9-2fdb-3dfe-222a-b2184cf17708@sberdevices.ru>
 <o6axh6mxd6mxai2zrpax6wa25slns7ysz5xsegntskvfxl53mt@wowjgb3jazt6>
 <20230725083823-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230725083823-mutt-send-email-mst@kernel.org>
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Jul 25, 2023 at 08:39:17AM -0400, Michael S. Tsirkin wrote:
>On Tue, Jul 25, 2023 at 02:28:02PM +0200, Stefano Garzarella wrote:
>> On Tue, Jul 25, 2023 at 12:16:11PM +0300, Arseniy Krasnov wrote:
>> >
>> >
>> > On 25.07.2023 11:46, Arseniy Krasnov wrote:
>> > >
>> > >
>> > > On 25.07.2023 11:43, Stefano Garzarella wrote:
>> > > > On Fri, Jul 21, 2023 at 08:09:03AM +0300, Arseniy Krasnov wrote:
>> > > > >
>> > > > >
>> > > > > On 21.07.2023 00:42, Arseniy Krasnov wrote:
>> > > > > > This adds handling of MSG_ZEROCOPY flag on transmission path: =
if this
>> > > > > > flag is set and zerocopy transmission is possible (enabled in =
socket
>> > > > > > options and transport allows zerocopy), then non-linear skb wi=
ll be
>> > > > > > created and filled with the pages of user's buffer. Pages of u=
ser's
>> > > > > > buffer are locked in memory by 'get_user_pages()'. Second thin=
g that
>> > > > > > this patch does is replace type of skb owning: instead of call=
ing
>> > > > > > 'skb_set_owner_sk_safe()' it calls 'skb_set_owner_w()'. Reason=
 of this
>> > > > > > change is that '__zerocopy_sg_from_iter()' increments 'sk_wmem=
_alloc'
>> > > > > > of socket, so to decrease this field correctly proper skb dest=
ructor is
>> > > > > > needed: 'sock_wfree()'. This destructor is set by 'skb_set_own=
er_w()'.
>> > > > > >
>> > > > > > Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>> > > > > > ---
>> > > > > > =A0Changelog:
>> > > > > > =A0v5(big patchset) -> v1:
>> > > > > > =A0 * Refactorings of 'if' conditions.
>> > > > > > =A0 * Remove extra blank line.
>> > > > > > =A0 * Remove 'frag_off' field unneeded init.
>> > > > > > =A0 * Add function 'virtio_transport_fill_skb()' which fills b=
oth linear
>> > > > > > =A0=A0=A0 and non-linear skb with provided data.
>> > > > > > =A0v1 -> v2:
>> > > > > > =A0 * Use original order of last four arguments in 'virtio_tra=
nsport_alloc_skb()'.
>> > > > > > =A0v2 -> v3:
>> > > > > > =A0 * Add new transport callback: 'msgzerocopy_check_iov'. It =
checks that
>> > > > > > =A0=A0=A0 provided 'iov_iter' with data could be sent in a zer=
ocopy mode.
>> > > > > > =A0=A0=A0 If this callback is not set in transport - transport=
 allows to send
>> > > > > > =A0=A0=A0 any 'iov_iter' in zerocopy mode. Otherwise - if call=
back returns 'true'
>> > > > > > =A0=A0=A0 then zerocopy is allowed. Reason of this callback is=
 that in case of
>> > > > > > =A0=A0=A0 G2H transmission we insert whole skb to the tx virti=
o queue and such
>> > > > > > =A0=A0=A0 skb must fit to the size of the virtio queue to be s=
ent in a single
>> > > > > > =A0=A0=A0 iteration (may be tx logic in 'virtio_transport.c' c=
ould be reworked
>> > > > > > =A0=A0=A0 as in vhost to support partial send of current skb).=
 This callback
>> > > > > > =A0=A0=A0 will be enabled only for G2H path. For details pls s=
ee comment
>> > > > > > =A0=A0=A0 'Check that tx queue...' below.
>> > > > > >
>> > > > > > =A0include/net/af_vsock.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0=A0 3 +
>> > > > > > =A0net/vmw_vsock/virtio_transport.c=A0=A0=A0=A0=A0=A0=A0 |=A0 =
39 ++++
>> > > > > > =A0net/vmw_vsock/virtio_transport_common.c | 257 +++++++++++++=
+++++------
>> > > > > > =A03 files changed, 241 insertions(+), 58 deletions(-)
>> > > > > >
>> > > > > > diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>> > > > > > index 0e7504a42925..a6b346eeeb8e 100644
>> > > > > > --- a/include/net/af_vsock.h
>> > > > > > +++ b/include/net/af_vsock.h
>> > > > > > @@ -177,6 +177,9 @@ struct vsock_transport {
>> > > > > >
>> > > > > > =A0=A0=A0=A0 /* Read a single skb */
>> > > > > > =A0=A0=A0=A0 int (*read_skb)(struct vsock_sock *, skb_read_act=
or_t);
>> > > > > > +
>> > > > > > +=A0=A0=A0 /* Zero-copy. */
>> > > > > > +=A0=A0=A0 bool (*msgzerocopy_check_iov)(const struct iov_iter=
 *);
>> > > > > > =A0};
>> > > > > >
>> > > > > > =A0/**** CORE ****/
>> > > > > > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/=
virtio_transport.c
>> > > > > > index 7bbcc8093e51..23cb8ed638c4 100644
>> > > > > > --- a/net/vmw_vsock/virtio_transport.c
>> > > > > > +++ b/net/vmw_vsock/virtio_transport.c
>> > > > > > @@ -442,6 +442,43 @@ static void virtio_vsock_rx_done(struct v=
irtqueue *vq)
>> > > > > > =A0=A0=A0=A0 queue_work(virtio_vsock_workqueue, &vsock->rx_wor=
k);
>> > > > > > =A0}
>> > > > > >
>> > > > > > +static bool
>> > > > > > virtio_transport_msgzerocopy_check_iov(const struct
>> > > > > > iov_iter *iov)
>> > > > > > +{
>> > > > > > +=A0=A0=A0 struct virtio_vsock *vsock;
>> > > > > > +=A0=A0=A0 bool res =3D false;
>> > > > > > +
>> > > > > > +=A0=A0=A0 rcu_read_lock();
>> > > > > > +
>> > > > > > +=A0=A0=A0 vsock =3D rcu_dereference(the_virtio_vsock);
>> > > > > > +=A0=A0=A0 if (vsock) {
>>
>> Just noted, what about the following to reduce the indentation?
>>
>>         if (!vsock) {
>>             goto out;
>>         }
>
>no {} pls

ooops, true, too much QEMU code today, but luckily checkpatch would have
spotted it ;-)

>
>>             ...
>>             ...
>>     out:
>>         rcu_read_unlock();
>>         return res;
>
>indentation is quite modest here. Not sure goto is worth it.

It's a pattern we follow a lot in this file, and I find the early
return/goto more readable.
Anyway, I don't have a strong opinion, it's fine the way it is now,
actually we don't have too many indentations for now in this function.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
