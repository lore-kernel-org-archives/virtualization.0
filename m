Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357DFEB64D9
	for <virtualization@archiver.kernel.org>; Tue, 27 Jun 2023 07:49:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA78F814B3;
	Tue, 27 Jun 2023 07:49:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA78F814B3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IXHj9lbM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rKW4lw0QvT7c; Tue, 27 Jun 2023 07:49:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1C8E08149E;
	Tue, 27 Jun 2023 07:49:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C8E08149E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD697C007C;
	Tue, 27 Jun 2023 07:49:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73993C0037
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 07:49:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4B58F416C9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 07:49:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4B58F416C9
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IXHj9lbM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x8mE8RXcnFSX
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 07:49:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 80239400EF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 80239400EF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 07:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687852149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QskuoK2+u8nib14YsmgjwegctAeH9ldt3GHDxrpov3o=;
 b=IXHj9lbMHIKfCIlrIBdbVv+iN4Xv4caDG2nhK9xvhvwwCWZA1Jxh37cCgyXXTTucHzfRfT
 Hj6Ag1mFHqbADpvnhb6v6WkxLvSnjWiYnZRyK/aIv6pT2GLlXeF8zPndyOtXNUexE3bpNp
 Yh3Ush1oSiNcZRdjG8iCbzj6TgVUdvI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-lMF7VBl9OB20fMzYMnDTIw-1; Tue, 27 Jun 2023 03:49:05 -0400
X-MC-Unique: lMF7VBl9OB20fMzYMnDTIw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94a355c9028so270813966b.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 00:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687852144; x=1690444144;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QskuoK2+u8nib14YsmgjwegctAeH9ldt3GHDxrpov3o=;
 b=cp/2r5ampvUfs1o+JgA8JhOybay0hHagRZq3I6dNJj/5scG7TpJwVo5YEWXXBUsY1J
 hnQwO6o0DisS5+mUeSMV8B4P7UxCsGHhVp3rJXbo42nKb+/jQyvEIUwOkJtPBn+F++Nu
 xavp+RgUI8+5PDUpbNYMAr7NTvl4HlQo7jmiGV3D2yDUIq/kRh4i2zDJu1zZ5iqPpOfW
 1LmikpLWKgoZrGm9EAkcae73vllusSTfbB4eKHfenr9bpFPR5X51+He77zkjjP/JusS4
 R+TZ4leogqHtMflyEQXvkQwcMn2sMIQ62cHzvngMSk8yJFvZb4w/6slXd9FsW5nWOgjB
 UcDg==
X-Gm-Message-State: AC+VfDwLXwpJmaY+vgWK31LSu4wr/KNC7jwMvg4Pk128KeSWDHobxrRY
 kINTh/Coyvk9kz00VwZYce+r0ms0vroMKcOupMvvQnRhTg1gplQ3fMjERDcWYFlG/C+XDdiNgqo
 Ysb3HkIBs2fEtdLoyg9A/BSdonqs49iyFkqRLgWDRkA==
X-Received: by 2002:a17:907:5c2:b0:974:55a2:cb0b with SMTP id
 wg2-20020a17090705c200b0097455a2cb0bmr27377786ejb.55.1687852144698; 
 Tue, 27 Jun 2023 00:49:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5lPeO/qla5LYI8so4+wb692OOE9l0zoDT61iV17QvGS0n+RA4RN7JnC6UwGFHGHsZN1sj4ZQ==
X-Received: by 2002:a17:907:5c2:b0:974:55a2:cb0b with SMTP id
 wg2-20020a17090705c200b0097455a2cb0bmr27377778ejb.55.1687852144363; 
 Tue, 27 Jun 2023 00:49:04 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 n5-20020a170906088500b0098963eb0c3dsm4208125eje.26.2023.06.27.00.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 00:49:03 -0700 (PDT)
Date: Tue, 27 Jun 2023 09:49:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v4 03/17] vsock/virtio: support to send non-linear skb
Message-ID: <6g6rfqbfkmfn5or56v25xny6lyhixj6plmrnyg77hirz7dzzhn@jskeqmnbthhk>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-4-AVKrasnov@sberdevices.ru>
 <3lg4apldxdrpbkgfa2o4wxe4qyayj2h7b2lfcw3q5a7u3hnofi@z2ifmmzt4xpc>
 <0a89e51b-0f7f-b64b-c827-7c943d6f08a6@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <0a89e51b-0f7f-b64b-c827-7c943d6f08a6@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Jun 27, 2023 at 07:39:41AM +0300, Arseniy Krasnov wrote:
>
>
>On 26.06.2023 18:36, Stefano Garzarella wrote:
>> On Sat, Jun 03, 2023 at 11:49:25PM +0300, Arseniy Krasnov wrote:
>>> For non-linear skb use its pages from fragment array as buffers in
>>> virtio tx queue. These pages are already pinned by 'get_user_pages()'
>>> during such skb creation.
>>>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>> net/vmw_vsock/virtio_transport.c | 37 ++++++++++++++++++++++++++------
>>> 1 file changed, 31 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_tr=
ansport.c
>>> index e95df847176b..6053d8341091 100644
>>> --- a/net/vmw_vsock/virtio_transport.c
>>> +++ b/net/vmw_vsock/virtio_transport.c
>>> @@ -100,7 +100,9 @@ virtio_transport_send_pkt_work(struct work_struct *=
work)
>>> =A0=A0=A0=A0vq =3D vsock->vqs[VSOCK_VQ_TX];
>>>
>>> =A0=A0=A0=A0for (;;) {
>>> -=A0=A0=A0=A0=A0=A0=A0 struct scatterlist hdr, buf, *sgs[2];
>>> +=A0=A0=A0=A0=A0=A0=A0 /* +1 is for packet header. */
>>> +=A0=A0=A0=A0=A0=A0=A0 struct scatterlist *sgs[MAX_SKB_FRAGS + 1];
>>> +=A0=A0=A0=A0=A0=A0=A0 struct scatterlist bufs[MAX_SKB_FRAGS + 1];
>>> =A0=A0=A0=A0=A0=A0=A0 int ret, in_sg =3D 0, out_sg =3D 0;
>>> =A0=A0=A0=A0=A0=A0=A0 struct sk_buff *skb;
>>> =A0=A0=A0=A0=A0=A0=A0 bool reply;
>>> @@ -111,12 +113,35 @@ virtio_transport_send_pkt_work(struct work_struct=
 *work)
>>>
>>> =A0=A0=A0=A0=A0=A0=A0 virtio_transport_deliver_tap_pkt(skb);
>>> =A0=A0=A0=A0=A0=A0=A0 reply =3D virtio_vsock_skb_reply(skb);
>>> +=A0=A0=A0=A0=A0=A0=A0 sg_init_one(&bufs[0], virtio_vsock_hdr(skb), siz=
eof(*virtio_vsock_hdr(skb)));
>>> +=A0=A0=A0=A0=A0=A0=A0 sgs[out_sg++] =3D &bufs[0];
>>
>> Can we use out_sg also to index bufs (here and in the rest of the code)?
>>
>> E.g.
>>
>> =A0=A0=A0=A0=A0=A0=A0 sg_init_one(&bufs[out_sg], ...)
>> =A0=A0=A0=A0=A0=A0=A0 sgs[out_sg] =3D &bufs[out_sg];
>> =A0=A0=A0=A0=A0=A0=A0 ++out_sg;
>>
>> =A0=A0=A0=A0=A0=A0=A0 ...
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (skb->len > 0) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sg_init_one(&bufs[out_sg],=
 skb->data, skb->len);
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sgs[out_sg] =3D &bufs[out_=
sg];
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ++out_sg;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>
>> =A0=A0=A0=A0=A0=A0=A0 etc...
>>
>>> +
>>
>> For readability, I would move the smaller branch above:
>>
>> =A0=A0=A0=A0=A0=A0=A0 if (!skb_is_nonlinear(skb)) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 // small block
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ...
>> =A0=A0=A0=A0=A0=A0=A0 } else {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 // big block
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ...
>> =A0=A0=A0=A0=A0=A0=A0 }
>>
>>> +=A0=A0=A0=A0=A0=A0=A0 if (skb_is_nonlinear(skb)) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct skb_shared_info *si;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int i;
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 si =3D skb_shinfo(skb);
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < si->nr_frags; i++)=
 {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 skb_frag_t *skb_frag =3D=
 &si->frags[i];
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 void *va =3D page_to_vir=
t(skb_frag->bv_page);
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* We will use 'page_to_=
virt()' for userspace page here,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * because virtio laye=
r will call 'virt_to_phys()' later
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * to fill buffer desc=
riptor. We don't touch memory at
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * "virtual" address o=
f this page.
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sg_init_one(&bufs[i + 1],
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
va + skb_frag->bv_offset,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
skb_frag->bv_len);
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sgs[out_sg++] =3D &bufs[=
i + 1];
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> +=A0=A0=A0=A0=A0=A0=A0 } else {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (skb->len > 0) {
>>
>> Should we do the same check (skb->len > 0) for nonlinear skb as well?
>> Or do the nonlinear ones necessarily have len > 0?
>
>Yes, non-linear skb always has 'data_len' > 0, e.g. such skbs always have =
some
>data in it.

Okay, makes sense ;-)

Thanks,
Stefano

>
>Thanks, Arseniy
>
>>
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sg_init_one(&bufs[1], sk=
b->data, skb->len);
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sgs[out_sg++] =3D &bufs[=
1];
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>>
>> =A0=A0 ^
>> Blank line that we can remove.
>>
>> Stefano
>>
>>> -=A0=A0=A0=A0=A0=A0=A0 sg_init_one(&hdr, virtio_vsock_hdr(skb), sizeof(=
*virtio_vsock_hdr(skb)));
>>> -=A0=A0=A0=A0=A0=A0=A0 sgs[out_sg++] =3D &hdr;
>>> -=A0=A0=A0=A0=A0=A0=A0 if (skb->len > 0) {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sg_init_one(&buf, skb->data, skb->le=
n);
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sgs[out_sg++] =3D &buf;
>>> =A0=A0=A0=A0=A0=A0=A0 }
>>>
>>> =A0=A0=A0=A0=A0=A0=A0 ret =3D virtqueue_add_sgs(vq, sgs, out_sg, in_sg,=
 skb, GFP_KERNEL);
>>> --=A0
>>> 2.25.1
>>>
>>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
