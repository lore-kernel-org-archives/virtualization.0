Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFECDEB64DC
	for <virtualization@archiver.kernel.org>; Tue, 27 Jun 2023 07:48:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4738B60F4E;
	Tue, 27 Jun 2023 07:48:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4738B60F4E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MaK30Nah
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q1JjNLcf7ejt; Tue, 27 Jun 2023 07:48:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9649160E02;
	Tue, 27 Jun 2023 07:48:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9649160E02
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B701C007C;
	Tue, 27 Jun 2023 07:48:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59EBEC0037
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 07:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 34E5782117
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 07:48:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 34E5782117
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MaK30Nah
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PHNetj2zk1gA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 07:48:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E64CB8210A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E64CB8210A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 07:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687852093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=whaOhWVIaKHzUbZWclTPzFtnTVD/3jITld51dEdWQ0A=;
 b=MaK30NahsOXLpiw5LuaBIl0FvjQ3hcZBApEg0T+GxeU6Ap8qca17buBL2veYiJgVaCw1gs
 ATUU20Z6IjPcM0vhbj4cEh4+xB6/A80oJjfwgOYChlGQHVBjBKzs+n4SJhVMQ/vJ54H6fv
 cIPmLIxLfNfFGUZ6gKFeQJR38cYcci4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-DPS8xZzYPReW0dzbKqECtA-1; Tue, 27 Jun 2023 03:48:11 -0400
X-MC-Unique: DPS8xZzYPReW0dzbKqECtA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-94f7a2b21fdso378411066b.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 00:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687852090; x=1690444090;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=whaOhWVIaKHzUbZWclTPzFtnTVD/3jITld51dEdWQ0A=;
 b=Q/xeKdtajoPsSqRhrqxe162PqM0hgTcZK3u2Efb6gHzxvLm2eXQpyBGBQ0Tq9LNtPd
 Quy35QXqetC5kBgJDlb/H1hTh9RdA9r9yq6QzBMbBA9plPJ3JjxJ0VMdgJ1QZXGRJy3q
 qviiuaDT0OIsT93NEIrfo43LxqhwVcZYTuFyv0S7S823pPhAdjXRdKbWnj+q4JKYqSMm
 khYsHQFzoc3hFSKMl3XBAE/MZGTyfGk09vg7Tcrua+Hx0EoAi6TTmMaP2qxewXURwL0Y
 dBXliWxEDwzwVLiqm4hCxl6PelXM3QLTQpERAf/GgsYqWDJ2Ng5jXLmIaiY5VguGlDRW
 AaPQ==
X-Gm-Message-State: AC+VfDwlxYhui41nxWeUKyJPcfgQTg9cu4RIMkwYWgcM3u2B4eMYRLzA
 4H3oeCrAytFFb5wx7eR9V16vpvuXvbGubOGnhDVlu+y8aGzb9xhdgEQiiMadxOfdRIQrj9uZhhd
 hbFeI5qSb1EUHTGvTjBONqsaYCA7ItDUXu2SV6ZqI2Q==
X-Received: by 2002:a17:906:da84:b0:988:f307:aea7 with SMTP id
 xh4-20020a170906da8400b00988f307aea7mr21595732ejb.7.1687852090424; 
 Tue, 27 Jun 2023 00:48:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ob/ReyhK7BIZNcKDNmnYWuzv3zeM/wIdMcpgjlvuvypLCy8x/HUywv68r17c73ooOglaGQw==
X-Received: by 2002:a17:906:da84:b0:988:f307:aea7 with SMTP id
 xh4-20020a170906da8400b00988f307aea7mr21595713ejb.7.1687852090093; 
 Tue, 27 Jun 2023 00:48:10 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 s16-20020a170906355000b00991ba677d92sm2190941eja.84.2023.06.27.00.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 00:48:09 -0700 (PDT)
Date: Tue, 27 Jun 2023 09:48:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 2/4] virtio/vsock: support MSG_PEEK for
 SOCK_SEQPACKET
Message-ID: <4pcexfrdtuisz53c4sb4pse4cyjw7zsuwtqsnnul23njo4ab5l@4jvdk6buxmj3>
References: <20230618062451.79980-1-AVKrasnov@sberdevices.ru>
 <20230618062451.79980-3-AVKrasnov@sberdevices.ru>
 <yiy3kssoiyzs6ehnlo7g2xsb26zee5vih3jpgyc7i3dvfcyfpv@xvokxez3lzpo>
 <9553a82f-ce31-e2e0-ff62-8abd2a6b639b@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <9553a82f-ce31-e2e0-ff62-8abd2a6b639b@sberdevices.ru>
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

On Tue, Jun 27, 2023 at 07:34:29AM +0300, Arseniy Krasnov wrote:
>
>
>On 26.06.2023 19:28, Stefano Garzarella wrote:
>> On Sun, Jun 18, 2023 at 09:24:49AM +0300, Arseniy Krasnov wrote:
>>> This adds support of MSG_PEEK flag for SOCK_SEQPACKET type of socket.
>>> Difference with SOCK_STREAM is that this callback returns either length
>>> of the message or error.
>>>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>> net/vmw_vsock/virtio_transport_common.c | 63 +++++++++++++++++++++++--
>>> 1 file changed, 60 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/vi=
rtio_transport_common.c
>>> index 2ee40574c339..352d042b130b 100644
>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>> @@ -460,6 +460,63 @@ virtio_transport_stream_do_dequeue(struct vsock_so=
ck *vsk,
>>> =A0=A0=A0=A0return err;
>>> }
>>>
>>> +static ssize_t
>>> +virtio_transport_seqpacket_do_peek(struct vsock_sock *vsk,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct msghdr *=
msg)
>>> +{
>>> +=A0=A0=A0 struct virtio_vsock_sock *vvs =3D vsk->trans;
>>> +=A0=A0=A0 struct sk_buff *skb;
>>> +=A0=A0=A0 size_t total, len;
>>> +
>>> +=A0=A0=A0 spin_lock_bh(&vvs->rx_lock);
>>> +
>>> +=A0=A0=A0 if (!vvs->msg_count) {
>>> +=A0=A0=A0=A0=A0=A0=A0 spin_unlock_bh(&vvs->rx_lock);
>>> +=A0=A0=A0=A0=A0=A0=A0 return 0;
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 total =3D 0;
>>> +=A0=A0=A0 len =3D msg_data_left(msg);
>>> +
>>> +=A0=A0=A0 skb_queue_walk(&vvs->rx_queue, skb) {
>>> +=A0=A0=A0=A0=A0=A0=A0 struct virtio_vsock_hdr *hdr;
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 if (total < len) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t bytes;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int err;
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bytes =3D len - total;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (bytes > skb->len)
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bytes =3D skb->len;
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spin_unlock_bh(&vvs->rx_lock);
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* sk_lock is held by caller so no o=
ne else can dequeue.
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Unlock rx_lock since memcpy_to_=
msg() may sleep.
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 err =3D memcpy_to_msg(msg, skb->data=
, bytes);
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (err)
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return err;
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spin_lock_bh(&vvs->rx_lock);
>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 total +=3D skb->len;
>>> +=A0=A0=A0=A0=A0=A0=A0 hdr =3D virtio_vsock_hdr(skb);
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_E=
OM) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (le32_to_cpu(hdr->flags) & VIRTIO=
_VSOCK_SEQ_EOR)
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 msg->msg_flags |=3D MSG_=
EOR;
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 spin_unlock_bh(&vvs->rx_lock);
>>> +
>>> +=A0=A0=A0 return total;
>>
>> Should we return the minimum between total and len?
>
>I guess no, because seqpacket dequeue callback always returns length of me=
ssage,
>then, in af_vsock.c we return either number of bytes read or length of mes=
sage
>depending on MSG_TRUNC flags.

Right! We should always return the total lenght of the packet.

Thanks,
Stefano

>
>Thanks, Arseniy
>
>>
>> Thanks,
>> Stefano
>>
>>> +}
>>> +
>>> static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 struct msghdr *msg,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 int flags)
>>> @@ -554,9 +611,9 @@ virtio_transport_seqpacket_dequeue(struct vsock_soc=
k *vsk,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int flags)
>>> {
>>> =A0=A0=A0=A0if (flags & MSG_PEEK)
>>> -=A0=A0=A0=A0=A0=A0=A0 return -EOPNOTSUPP;
>>> -
>>> -=A0=A0=A0 return virtio_transport_seqpacket_do_dequeue(vsk, msg, flags=
);
>>> +=A0=A0=A0=A0=A0=A0=A0 return virtio_transport_seqpacket_do_peek(vsk, m=
sg);
>>> +=A0=A0=A0 else
>>> +=A0=A0=A0=A0=A0=A0=A0 return virtio_transport_seqpacket_do_dequeue(vsk=
, msg, flags);
>>> }
>>> EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_dequeue);
>>>
>>> --=A0
>>> 2.25.1
>>>
>>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
