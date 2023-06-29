Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D8EEB64D9
	for <virtualization@archiver.kernel.org>; Thu, 29 Jun 2023 12:32:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B80724090E;
	Thu, 29 Jun 2023 12:32:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B80724090E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fpkdsmWd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I7urIdzJV_q0; Thu, 29 Jun 2023 12:32:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9C9EF40189;
	Thu, 29 Jun 2023 12:32:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9C9EF40189
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F413C0072;
	Thu, 29 Jun 2023 12:32:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D274FC0037
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Jun 2023 12:32:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9C69641916
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Jun 2023 12:32:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C69641916
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fpkdsmWd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oqPe8Ic3Lnpw
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Jun 2023 12:32:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C93F8418E3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C93F8418E3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Jun 2023 12:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688041966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HYE719U1OUkNnisJmvcieL26+HWSje3lg9pLqFXWKw8=;
 b=fpkdsmWdQfQf3rdf1XNQnf939oRpnxX3qjqD0gePTgNpCR0Rs+gh9El1FxITzXqU8THOfb
 1M9NiwV12yLVnQGBoALn0FEBWHEC3h+Xvs0aVeJfpvd1P44AsRBve2hIBYppLsEru6LNc0
 xezaJErGnqsSxBwS7zfaqPqDt5pChFo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-S3o0zQjpPha4RocU2eGQqA-1; Thu, 29 Jun 2023 08:32:45 -0400
X-MC-Unique: S3o0zQjpPha4RocU2eGQqA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30e3ee8a42eso328837f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Jun 2023 05:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688041964; x=1690633964;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HYE719U1OUkNnisJmvcieL26+HWSje3lg9pLqFXWKw8=;
 b=i7taP5PzcQ9wlvIG1iXQGHCHUJkXh7dYuTNAdLCtTXm80qB8U53o2PwMsUe2Pv8DUQ
 gnjoaP59unDBsG0eXjVTwpET+bSWB9ghMPThlv87URNEiIlokGUcIsMRVEZvM/Cvknqn
 ChY3+rnHuXcii67slx6JHoRBrSBPSJvWRAbULryiXILOrAuITYZCxjsrqxvBiR/5h5uC
 xH+11vgQy7+LGViagzQ0xEygGdQg5j0EySFISl3L1/u05UmPI+/BDThsjRQ9KCEjbozy
 crTnBM470FJPws9E+1GKfsQKLwxu6yXIZHAuRhw54QIuNWtFNqjElLj7Hxg5LplwVXmk
 uJpA==
X-Gm-Message-State: ABy/qLZetkg4M1j5v5CX8wwhu6ycGIYRaxqdR5CQr/kxPXFzGkXMSDoN
 cJXzeZVQhlHmCjdVM0ZMUGD0fkict7aGIHC3U+OAh5R5AqkYste5rDZoudPuVjHpvzULMtw9AH+
 aFKwwfh4ElMWbHIqOYJeen8o3c6ZWhfslsHaRUfv7nA==
X-Received: by 2002:a5d:46c5:0:b0:314:1d88:f072 with SMTP id
 g5-20020a5d46c5000000b003141d88f072mr317991wrs.25.1688041964181; 
 Thu, 29 Jun 2023 05:32:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEtUwIW1ZrD3I9b9uT4pawJX8l8ZiV0GiqcnxSQtlSd3loTHdLCrIheG0Pd7AXzzPURuZJHKQ==
X-Received: by 2002:a5d:46c5:0:b0:314:1d88:f072 with SMTP id
 g5-20020a5d46c5000000b003141d88f072mr317966wrs.25.1688041963792; 
 Thu, 29 Jun 2023 05:32:43 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 j19-20020a5d4533000000b0030fafcbbd33sm15635349wra.50.2023.06.29.05.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 05:32:43 -0700 (PDT)
Date: Thu, 29 Jun 2023 14:32:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v4 05/17] vsock/virtio: MSG_ZEROCOPY flag support
Message-ID: <kkz3hl5ebhblyyerduybbrdcntdilsecjlhq4y5cymayw55q22@w4mph6yu2x7d>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-6-AVKrasnov@sberdevices.ru>
 <rbyt6uomvimurmgchxpuyoqjehdleqzzohzzdnajgadrwkbwsf@qwlcvzqhqxqw>
 <b25f0c4d-828c-ffe8-2780-2c954ed8770a@sberdevices.ru>
 <m5q3fqqvur4pcvkcxx36ivoqu77tsrjd4xna6zszmzq34dbqq5@6wfrhllk6tsq>
 <7bce4bbc-6549-1284-e027-05d5a9d100e1@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <7bce4bbc-6549-1284-e027-05d5a9d100e1@sberdevices.ru>
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

On Tue, Jun 27, 2023 at 11:22:52AM +0300, Arseniy Krasnov wrote:
>
>
>On 27.06.2023 10:50, Stefano Garzarella wrote:
>> On Tue, Jun 27, 2023 at 07:41:51AM +0300, Arseniy Krasnov wrote:
>>>
>>>
>>> On 26.06.2023 19:03, Stefano Garzarella wrote:
>>>> On Sat, Jun 03, 2023 at 11:49:27PM +0300, Arseniy Krasnov wrote:
>>>>> This adds handling of MSG_ZEROCOPY flag on transmission path: if this
>>>>> flag is set and zerocopy transmission is possible, then non-linear skb
>>>>> will be created and filled with the pages of user's buffer. Pages of
>>>>> user's buffer are locked in memory by 'get_user_pages()'.
>>>>>
>>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>>> ---
>>>>> net/vmw_vsock/virtio_transport_common.c | 270 ++++++++++++++++++------
>>>>> 1 file changed, 208 insertions(+), 62 deletions(-)
>>>>>
>>>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/=
virtio_transport_common.c
>>>>> index 0de562c1dc4b..f1ec38c72db7 100644
>>>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>>>> @@ -37,27 +37,100 @@ virtio_transport_get_ops(struct vsock_sock *vsk)
>>>>> =A0=A0=A0=A0return container_of(t, struct virtio_transport, transport=
);
>>>>> }
>>>>>
>>>>> -/* Returns a new packet on success, otherwise returns NULL.
>>>>> - *
>>>>> - * If NULL is returned, errp is set to a negative errno.
>>>>> - */
>>>>> -static struct sk_buff *
>>>>> -virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
>>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t len,
>>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u32 src_cid,
>>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u32 src_port,
>>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u32 dst_cid,
>>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u32 dst_port)
>>>>> -{
>>>>> -=A0=A0=A0 const size_t skb_len =3D VIRTIO_VSOCK_SKB_HEADROOM + len;
>>>>> -=A0=A0=A0 struct virtio_vsock_hdr *hdr;
>>>>> -=A0=A0=A0 struct sk_buff *skb;
>>>>> +static bool virtio_transport_can_zcopy(struct virtio_vsock_pkt_info =
*info,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 s=
ize_t max_to_send)
>>>>> +{
>>>>> +=A0=A0=A0 struct iov_iter *iov_iter;
>>>>> +
>>>>> +=A0=A0=A0 if (!info->msg)
>>>>> +=A0=A0=A0=A0=A0=A0=A0 return false;
>>>>> +
>>>>> +=A0=A0=A0 iov_iter =3D &info->msg->msg_iter;
>>>>> +
>>>>> +=A0=A0=A0 /* Data is simple buffer. */
>>>>> +=A0=A0=A0 if (iter_is_ubuf(iov_iter))
>>>>> +=A0=A0=A0=A0=A0=A0=A0 return true;
>>>>> +
>>>>> +=A0=A0=A0 if (!iter_is_iovec(iov_iter))
>>>>> +=A0=A0=A0=A0=A0=A0=A0 return false;
>>>>> +
>>>>> +=A0=A0=A0 if (iov_iter->iov_offset)
>>>>> +=A0=A0=A0=A0=A0=A0=A0 return false;
>>>>> +
>>>>> +=A0=A0=A0 /* We can't send whole iov. */
>>>>> +=A0=A0=A0 if (iov_iter->count > max_to_send)
>>>>> +=A0=A0=A0=A0=A0=A0=A0 return false;
>>>>> +
>>>>> +=A0=A0=A0 return true;
>>>>> +}
>>>>> +
>>>>> +static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 s=
truct sk_buff *skb,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 s=
truct msghdr *msg,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 b=
ool zerocopy)
>>>>> +{
>>>>> +=A0=A0=A0 struct ubuf_info *uarg;
>>>>> +
>>>>> +=A0=A0=A0 if (msg->msg_ubuf) {
>>>>> +=A0=A0=A0=A0=A0=A0=A0 uarg =3D msg->msg_ubuf;
>>>>> +=A0=A0=A0=A0=A0=A0=A0 net_zcopy_get(uarg);
>>>>> +=A0=A0=A0 } else {
>>>>> +=A0=A0=A0=A0=A0=A0=A0 struct iov_iter *iter =3D &msg->msg_iter;
>>>>> +=A0=A0=A0=A0=A0=A0=A0 struct ubuf_info_msgzc *uarg_zc;
>>>>> +=A0=A0=A0=A0=A0=A0=A0 int len;
>>>>> +
>>>>> +=A0=A0=A0=A0=A0=A0=A0 /* Only ITER_IOVEC or ITER_UBUF are allowed and
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * checked before.
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 */
>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (iter_is_iovec(iter))
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 len =3D iov_length(iter->__iov, it=
er->nr_segs);
>>>>> +=A0=A0=A0=A0=A0=A0=A0 else
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 len =3D iter->count;
>>>>> +
>>>>> +=A0=A0=A0=A0=A0=A0=A0 uarg =3D msg_zerocopy_realloc(sk_vsock(vsk),
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 len,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 NULL);
>>>>> +
>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (!uarg)
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -1;
>>>>> +
>>>>> +=A0=A0=A0=A0=A0=A0=A0 uarg_zc =3D uarg_to_msgzc(uarg);
>>>>> +=A0=A0=A0=A0=A0=A0=A0 uarg_zc->zerocopy =3D zerocopy ? 1 : 0;
>>>>> +=A0=A0=A0 }
>>>>> +
>>>>> +=A0=A0=A0 skb_zcopy_init(skb, uarg);
>>>>> +
>>>>> +=A0=A0=A0 return 0;
>>>>> +}
>>>>> +
>>>>> +static int virtio_transport_fill_linear_skb(struct sk_buff *skb,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 struct vsock_sock *vsk,
>>>>
>>>> `vsk` seems unused
>>>>
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 struct virtio_vsock_pkt_info *info,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 size_t len)
>>>>> +{
>>>>> =A0=A0=A0=A0void *payload;
>>>>> =A0=A0=A0=A0int err;
>>>>>
>>>>> -=A0=A0=A0 skb =3D virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
>>>>> -=A0=A0=A0 if (!skb)
>>>>> -=A0=A0=A0=A0=A0=A0=A0 return NULL;
>>>>> +=A0=A0=A0 payload =3D skb_put(skb, len);
>>>>> +=A0=A0=A0 err =3D memcpy_from_msg(payload, info->msg, len);
>>>>> +=A0=A0=A0 if (err)
>>>>> +=A0=A0=A0=A0=A0=A0=A0 return -1;
>>>>> +
>>>>> +=A0=A0=A0 if (msg_data_left(info->msg))
>>>>> +=A0=A0=A0=A0=A0=A0=A0 return 0;
>>>>> +
>>>>> +=A0=A0=A0 return 0;
>>>>> +}
>>>>> +
>>>>> +static void virtio_transport_init_hdr(struct sk_buff *skb,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 stru=
ct virtio_vsock_pkt_info *info,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u32 =
src_cid,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u32 =
src_port,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u32 =
dst_cid,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u32 =
dst_port,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size=
_t len)
>>>>> +{
>>>>> +=A0=A0=A0 struct virtio_vsock_hdr *hdr;
>>>>>
>>>>> =A0=A0=A0=A0hdr =3D virtio_vsock_hdr(skb);
>>>>> =A0=A0=A0=A0hdr->type=A0=A0=A0 =3D cpu_to_le16(info->type);
>>>>> @@ -68,42 +141,6 @@ virtio_transport_alloc_skb(struct virtio_vsock_pk=
t_info *info,
>>>>> =A0=A0=A0=A0hdr->dst_port=A0=A0=A0 =3D cpu_to_le32(dst_port);
>>>>> =A0=A0=A0=A0hdr->flags=A0=A0=A0 =3D cpu_to_le32(info->flags);
>>>>> =A0=A0=A0=A0hdr->len=A0=A0=A0 =3D cpu_to_le32(len);
>>>>> -
>>>>> -=A0=A0=A0 if (info->msg && len > 0) {
>>>>> -=A0=A0=A0=A0=A0=A0=A0 payload =3D skb_put(skb, len);
>>>>> -=A0=A0=A0=A0=A0=A0=A0 err =3D memcpy_from_msg(payload, info->msg, le=
n);
>>>>> -=A0=A0=A0=A0=A0=A0=A0 if (err)
>>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;
>>>>> -
>>>>> -=A0=A0=A0=A0=A0=A0=A0 if (msg_data_left(info->msg) =3D=3D 0 &&
>>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 info->type =3D=3D VIRTIO_VSOCK_TYP=
E_SEQPACKET) {
>>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 hdr->flags |=3D cpu_to_le32(VIRTIO=
_VSOCK_SEQ_EOM);
>>>>> -
>>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (info->msg->msg_flags & MSG_EOR)
>>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 hdr->flags |=3D cpu_to=
_le32(VIRTIO_VSOCK_SEQ_EOR);
>>>>> -=A0=A0=A0=A0=A0=A0=A0 }
>>>>> -=A0=A0=A0 }
>>>>> -
>>>>> -=A0=A0=A0 if (info->reply)
>>>>> -=A0=A0=A0=A0=A0=A0=A0 virtio_vsock_skb_set_reply(skb);
>>>>> -
>>>>> -=A0=A0=A0 trace_virtio_transport_alloc_pkt(src_cid, src_port,
>>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dst_cid=
, dst_port,
>>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 len,
>>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 info->t=
ype,
>>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 info->o=
p,
>>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 info->f=
lags);
>>>>> -
>>>>> -=A0=A0=A0 if (info->vsk && !skb_set_owner_sk_safe(skb, sk_vsock(info=
->vsk))) {
>>>>> -=A0=A0=A0=A0=A0=A0=A0 WARN_ONCE(1, "failed to allocate skb on vsock =
socket with sk_refcnt =3D=3D 0\n");
>>>>> -=A0=A0=A0=A0=A0=A0=A0 goto out;
>>>>> -=A0=A0=A0 }
>>>>> -
>>>>> -=A0=A0=A0 return skb;
>>>>> -
>>>>> -out:
>>>>> -=A0=A0=A0 kfree_skb(skb);
>>>>> -=A0=A0=A0 return NULL;
>>>>> }
>>>>>
>>>>> static void virtio_transport_copy_nonlinear_skb(struct sk_buff *skb,
>>>>> @@ -214,6 +251,85 @@ static u16 virtio_transport_get_type(struct sock=
 *sk)
>>>>> =A0=A0=A0=A0=A0=A0=A0 return VIRTIO_VSOCK_TYPE_SEQPACKET;
>>>>> }
>>>>>
>>>>> +/* Returns a new packet on success, otherwise returns NULL.
>>>>> + *
>>>>> + * If NULL is returned, errp is set to a negative errno.
>>>>
>>>> I had noticed this in Bobby's patches, I think it's an old comment we
>>>> left around.
>>>>
>>>>> + */
>>>>> +static struct sk_buff *virtio_transport_alloc_skb(struct vsock_sock =
*vsk,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 struct virtio_vsock_pkt_info *info,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 size_t payload_len,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 bool zcopy,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 u32 dst_cid,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 u32 dst_port,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 u32 src_cid,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 u32 src_port)
>>>>> +{
>>>>> +=A0=A0=A0 struct sk_buff *skb;
>>>>> +=A0=A0=A0 size_t skb_len;
>>>>> +
>>>>> +=A0=A0=A0 skb_len =3D VIRTIO_VSOCK_SKB_HEADROOM;
>>>>> +
>>>>> +=A0=A0=A0 if (!zcopy)
>>>>> +=A0=A0=A0=A0=A0=A0=A0 skb_len +=3D payload_len;
>>>>> +
>>>>> +=A0=A0=A0 skb =3D virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
>>>>> +=A0=A0=A0 if (!skb)
>>>>> +=A0=A0=A0=A0=A0=A0=A0 return NULL;
>>>>> +
>>>>> +=A0=A0=A0 virtio_transport_init_hdr(skb, info, src_cid, src_port,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dst_cid, dst_por=
t,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 payload_len);
>>>>> +
>>>>> +=A0=A0=A0 /* Set owner here, because '__zerocopy_sg_from_iter()' uses
>>>>> +=A0=A0=A0=A0 * owner of skb without check to update 'sk_wmem_alloc'.
>>>>> +=A0=A0=A0=A0 */
>>>>> +=A0=A0=A0 if (vsk)
>>>>> +=A0=A0=A0=A0=A0=A0=A0 skb_set_owner_w(skb, sk_vsock(vsk));
>>>>
>>>> why we are moving from skb_set_owner_sk_safe() to skb_set_owner_w()?
>>>>
>>>> We should mention this in the commit description.
>>>>
>>>>> +
>>>>> +=A0=A0=A0 if (info->msg && payload_len > 0) {
>>>>> +=A0=A0=A0=A0=A0=A0=A0 int err;
>>>>> +
>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (zcopy) {
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 err =3D __zerocopy_sg_from_iter(in=
fo->msg, NULL, skb,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 &info->msg->msg_iter,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 payload_len);
>>>>> +=A0=A0=A0=A0=A0=A0=A0 } else {
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 err =3D virtio_transport_fill_line=
ar_skb(skb, vsk, info, payload_len);
>>>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>>>> +
>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (err)
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;
>>>>> +
>>>>> +=A0=A0=A0=A0=A0=A0=A0 VIRTIO_VSOCK_SKB_CB(skb)->frag_off =3D 0;
>>>>> +
>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (info->type =3D=3D VIRTIO_VSOCK_TYPE_SEQPAC=
KET) {
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct virtio_vsock_hdr *hdr;
>>>>> +
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 hdr =3D virtio_vsock_hdr(skb);
>>>>
>>>> Just `struct virtio_vsock_hdr *hdr =3D virtio_vsock_hdr(skb);` should =
be
>>>> fine.
>>>>
>>>>> +
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 hdr->flags |=3D cpu_to_le32(VIRTIO=
_VSOCK_SEQ_EOM);
>>>>> +
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (info->msg->msg_flags & MSG_EOR)
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 hdr->flags |=3D cpu_to=
_le32(VIRTIO_VSOCK_SEQ_EOR);
>>>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>>>> +=A0=A0=A0 }
>>>>> +
>>>>> +=A0=A0=A0 if (info->reply)
>>>>> +=A0=A0=A0=A0=A0=A0=A0 virtio_vsock_skb_set_reply(skb);
>>>>> +
>>>>> +=A0=A0=A0 trace_virtio_transport_alloc_pkt(src_cid, src_port,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dst_cid=
, dst_port,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 payload=
_len,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 info->t=
ype,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 info->o=
p,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 info->f=
lags);
>>>>> +
>>>>> +=A0=A0=A0 return skb;
>>>>> +out:
>>>>> +=A0=A0=A0 kfree_skb(skb);
>>>>> +=A0=A0=A0 return NULL;
>>>>> +}
>>>>> +
>>>>> /* This function can only be used on connecting/connected sockets,
>>>>> =A0* since a socket assigned to a transport is required.
>>>>> =A0*
>>>>> @@ -226,6 +342,8 @@ static int virtio_transport_send_pkt_info(struct =
vsock_sock *vsk,
>>>>> =A0=A0=A0=A0const struct virtio_transport *t_ops;
>>>>> =A0=A0=A0=A0struct virtio_vsock_sock *vvs;
>>>>> =A0=A0=A0=A0u32 pkt_len =3D info->pkt_len;
>>>>> +=A0=A0=A0 bool can_zcopy =3D false;
>>>>> +=A0=A0=A0 u32 max_skb_cap;
>>>>> =A0=A0=A0=A0u32 rest_len;
>>>>> =A0=A0=A0=A0int ret;
>>>>>
>>>>> @@ -254,22 +372,49 @@ static int virtio_transport_send_pkt_info(struc=
t vsock_sock *vsk,
>>>>> =A0=A0=A0=A0if (pkt_len =3D=3D 0 && info->op =3D=3D VIRTIO_VSOCK_OP_R=
W)
>>>>> =A0=A0=A0=A0=A0=A0=A0 return pkt_len;
>>>>>
>>>>> +=A0=A0=A0 /* If zerocopy is not enabled by 'setsockopt()', we behave=
 as
>>>>> +=A0=A0=A0=A0 * there is no MSG_ZEROCOPY flag set.
>>>>> +=A0=A0=A0=A0 */
>>>>> +=A0=A0=A0 if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
>>>>> +=A0=A0=A0=A0=A0=A0=A0 info->flags &=3D ~MSG_ZEROCOPY;
>>>>> +
>>>>> +=A0=A0=A0 if (info->flags & MSG_ZEROCOPY)
>>>>> +=A0=A0=A0=A0=A0=A0=A0 can_zcopy =3D virtio_transport_can_zcopy(info,=
 pkt_len);
>>>>> +
>>>>> +=A0=A0=A0 if (can_zcopy)
>>>>> +=A0=A0=A0=A0=A0=A0=A0 max_skb_cap =3D min_t(u32, VIRTIO_VSOCK_MAX_PK=
T_BUF_SIZE,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (MAX_SKB_F=
RAGS * PAGE_SIZE));
>>>>> +=A0=A0=A0 else
>>>>> +=A0=A0=A0=A0=A0=A0=A0 max_skb_cap =3D VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
>>>>> +
>>>>
>>>> We use `len` very often, what about `max_skb_len`?
>>>>
>>>>> =A0=A0=A0=A0rest_len =3D pkt_len;
>>>>>
>>>>> =A0=A0=A0=A0do {
>>>>> =A0=A0=A0=A0=A0=A0=A0 struct sk_buff *skb;
>>>>> =A0=A0=A0=A0=A0=A0=A0 size_t skb_len;
>>>>>
>>>>> -=A0=A0=A0=A0=A0=A0=A0 skb_len =3D min_t(u32, VIRTIO_VSOCK_MAX_PKT_BU=
F_SIZE, rest_len);
>>>>> +=A0=A0=A0=A0=A0=A0=A0 skb_len =3D min(max_skb_cap, rest_len);
>>>>>
>>>>> -=A0=A0=A0=A0=A0=A0=A0 skb =3D virtio_transport_alloc_skb(info, skb_l=
en,
>>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 src_cid, src_port,
>>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 dst_cid, dst_port);
>>>>> +=A0=A0=A0=A0=A0=A0=A0 skb =3D virtio_transport_alloc_skb(vsk, info, =
skb_len, can_zcopy,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 dst_cid, dst_port,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 src_cid, src_port);
>>>>> =A0=A0=A0=A0=A0=A0=A0 if (!skb) {
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D -ENOMEM;
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>>>>> =A0=A0=A0=A0=A0=A0=A0 }
>>>>>
>>>>> +=A0=A0=A0=A0=A0=A0=A0 /* This is last skb to send this portion of da=
ta. */
>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (skb_len =3D=3D rest_len &&
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 info->flags & MSG_ZEROCOPY &&
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 info->op =3D=3D VIRTIO_VSOCK_OP_RW=
) {
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (virtio_transport_init_zcopy_sk=
b(vsk, skb,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 info->msg,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 can_zcopy)) {
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D -ENOMEM;
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>>>> +
>>>>> =A0=A0=A0=A0=A0=A0=A0 virtio_transport_inc_tx_pkt(vvs, skb);
>>>>>
>>>>> =A0=A0=A0=A0=A0=A0=A0 ret =3D t_ops->send_pkt(skb);
>>>>> @@ -884,6 +1029,7 @@ virtio_transport_stream_enqueue(struct vsock_soc=
k *vsk,
>>>>> =A0=A0=A0=A0=A0=A0=A0 .msg =3D msg,
>>>>> =A0=A0=A0=A0=A0=A0=A0 .pkt_len =3D len,
>>>>> =A0=A0=A0=A0=A0=A0=A0 .vsk =3D vsk,
>>>>> +=A0=A0=A0=A0=A0=A0=A0 .flags =3D msg->msg_flags,
>>>>
>>>> These flags then get copied into the virtio_vsock_hdr, which I don't
>>>> think is a good idea.
>>>>
>>>> Why not using directly info->msg->msg_flags?
>>>
>>> Ops, yes, it's a bug, You're right, this is really wrong as there are t=
wo different
>>> sets of flags - MSG_XXX passed to syscall and flags in the header of pa=
cket.
>>
>> Yep.
>>
>> What about the moving from skb_set_owner_sk_safe() to skb_set_owner_w()?
>> Was it voluntary? If so, can you explain why?
>
>Sure! here is what happens: difference between these functions is that 'sk=
b_set_owner_w()'
>sets another destructor - 'sock_wfree()':
>
>https://elixir.bootlin.com/linux/v6.4/source/net/core/sock.c#L2408
>
>This destructor also updates 'sk->sk_wmem_alloc' during skb freeing. Why t=
his is needed?
>Because '__zerocopy_sg_from_iter()' updates 'sk_wmem_alloc' if socket is N=
OT SOCK_STREAM
>or socket was NOT passed as input argument (it is not obvious why, but it =
is so):
>
>https://elixir.bootlin.com/linux/latest/source/net/core/datagram.c#L646
>
>So to support both types of sockets (seqpacket and stream) I decided to tr=
y pass NULL always
>as socket argument to '__zerocopy_sg_from_iter()', with this 'sk_wmem_allo=
c' will be always
>updated in '__zerocopy_sg_from_iter()' and then we decrease 'sk_wmem_alloc=
' in 'sock_wfree()'.
>
>May be this looks strange - I tried to understand logic of this code in '_=
_zerocopy_sg_from_iter()',
>but it requires more deep analysis. Anyway it works:)

Yep, it should require also more analysis on my side :-)

Please document it in the commit description, so if we will find any
issue in the future, we know why we did this change.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
