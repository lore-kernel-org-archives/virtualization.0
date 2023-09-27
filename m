Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3DEE80A9A
	for <virtualization@archiver.kernel.org>; Wed, 27 Sep 2023 07:35:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6FCA882280;
	Wed, 27 Sep 2023 07:35:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6FCA882280
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DxqZbid8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hjrgJaGf6n6t; Wed, 27 Sep 2023 07:35:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B08E582281;
	Wed, 27 Sep 2023 07:35:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B08E582281
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DD12C0071;
	Wed, 27 Sep 2023 07:35:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78137C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 07:35:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 534EC40567
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 07:35:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 534EC40567
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DxqZbid8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xI4_1VUMyT9E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 07:35:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 83C9E40128
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 07:35:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 83C9E40128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695800137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ap6jvf8/2CoqbMpAwThp0QoWymIsVaHbvqKSWQ1uNLM=;
 b=DxqZbid8+SG9xtUkotqnGYLLppNEf+Q7lITn0rNcTt4RqNFfk4TQ9tu9PI1fme8nrXa1cA
 150h+wGO8tagfGOGSLfqzs74ibdwKMQ1Gsr7g35SwoW9DmMuxQ21G/p+qOuCqFjos5m2HV
 r3yP+dOxVXMtwNHf5QlnB9E+oBIMxGQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-zKNEtOeQNE6ph8IZ2rhp2A-1; Wed, 27 Sep 2023 03:35:36 -0400
X-MC-Unique: zKNEtOeQNE6ph8IZ2rhp2A-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-405629826ccso72873995e9.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 00:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695800135; x=1696404935;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ap6jvf8/2CoqbMpAwThp0QoWymIsVaHbvqKSWQ1uNLM=;
 b=IYSPuuSrlsEPQntSNpmrpXGCiePZkHDvYeyAlGLhrh8cYvjvW7ZxoSNSF8cvIJi0hZ
 WQZlyHpIy/3kasyB8bWmdAoCuuRyIDAIqB3g02kTtARcuPrNyZZxkjG8N8BjAdHri4KY
 0aBR/YgyJE9knqka8Ojxok0jUPwzwA2cyB3FsABa/VLp3s7p5MzyUy52OWohX08fyAwI
 hnNekandlZO5cV4nHBEh4GbBLhix98tGQsmAXN17NDm+eoaeAljmbeeQD5HiP3A8+pA/
 VgM0ZtQ90exfDVR4eOlLT+peMiX2RRKUzAHiTuyOdPF+Ntix2CZwHZkAnMsXKHcx4MCF
 4pjg==
X-Gm-Message-State: AOJu0Yz5PbhERV0UyfC+aiR8o2N5JoSW2U2IXbGzCm+JfTG7vL2GBd6v
 6ecUpUU2+oWtCWybfMovw9/rtkbUHLM5uZp4mcr+32pz3CCkDIaT8PIQ1TlXJj7cVrVSSbQ4TBo
 3fJrFpQ2qc+YyUrXQeXsKbH7rEDDDoYrE/e0gAGde7Q==
X-Received: by 2002:a7b:ce94:0:b0:401:c944:a4d6 with SMTP id
 q20-20020a7bce94000000b00401c944a4d6mr1190424wmj.28.1695800134935; 
 Wed, 27 Sep 2023 00:35:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNeo+a3D1T3OSxeUepQ732xUxuE+Jh5ew/NsV6Yu1nas54YVkW3cnsBtEB4qZvL4QfCzEH8w==
X-Received: by 2002:a7b:ce94:0:b0:401:c944:a4d6 with SMTP id
 q20-20020a7bce94000000b00401c944a4d6mr1190398wmj.28.1695800134503; 
 Wed, 27 Sep 2023 00:35:34 -0700 (PDT)
Received: from sgarzare-redhat ([46.222.19.70])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c029300b004060f0a0fdbsm4495926wmk.41.2023.09.27.00.35.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 00:35:33 -0700 (PDT)
Date: Wed, 27 Sep 2023 09:35:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v1 08/12] vsock: enable setting SO_ZEROCOPY
Message-ID: <n4si4yyqs2svmvhueyxxyev2v3wxugzjjb25wpyveg3ns5nv6i@cfb4fyq5kdaf>
References: <20230922052428.4005676-1-avkrasnov@salutedevices.com>
 <20230922052428.4005676-9-avkrasnov@salutedevices.com>
 <ynuctxau4ta4pk763ut7gfdaqzcuyve7uf2a2iltyspravs5uf@xrtqtbhuuvwq>
 <d27b863d-8576-2c9b-c6a6-c8e55d7dad68@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <d27b863d-8576-2c9b-c6a6-c8e55d7dad68@salutedevices.com>
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

On Tue, Sep 26, 2023 at 10:38:06PM +0300, Arseniy Krasnov wrote:
>
>
>On 26.09.2023 15:56, Stefano Garzarella wrote:
>> On Fri, Sep 22, 2023 at 08:24:24AM +0300, Arseniy Krasnov wrote:
>>> For AF_VSOCK, zerocopy tx mode depends on transport, so this option must
>>> be set in AF_VSOCK implementation where transport is accessible (if
>>> transport is not set during setting SO_ZEROCOPY: for example socket is
>>> not connected, then SO_ZEROCOPY will be enabled, but once transport will
>>> be assigned, support of this type of transmission will be checked).
>>>
>>> To handle SO_ZEROCOPY, AF_VSOCK implementation uses SOCK_CUSTOM_SOCKOPT
>>> bit, thus handling SOL_SOCKET option operations, but all of them except
>>> SO_ZEROCOPY will be forwarded to the generic handler by calling
>>> 'sock_setsockopt()'.
>>>
>>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>>> ---
>>> Changelog:
>>> v5(big patchset) -> v1:
>>> =A0* Compact 'if' conditions.
>>> =A0* Rename 'zc_val' to 'zerocopy'.
>>> =A0* Use 'zerocopy' value directly in 'sock_valbool_flag()', without
>>> =A0=A0 ?: operator.
>>> =A0* Set 'SOCK_CUSTOM_SOCKOPT' bit for connectible sockets only, as
>>> =A0=A0 suggested by Bobby Eshleman <bobbyeshleman@gmail.com>.
>>>
>>> net/vmw_vsock/af_vsock.c | 46 ++++++++++++++++++++++++++++++++++++++--
>>> 1 file changed, 44 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>> index 482300eb88e0..c05a42e02a17 100644
>>> --- a/net/vmw_vsock/af_vsock.c
>>> +++ b/net/vmw_vsock/af_vsock.c
>>> @@ -1406,8 +1406,16 @@ static int vsock_connect(struct socket *sock, st=
ruct sockaddr *addr,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;
>>> =A0=A0=A0=A0=A0=A0=A0 }
>>>
>>> -=A0=A0=A0=A0=A0=A0=A0 if (vsock_msgzerocopy_allow(transport))
>>> +=A0=A0=A0=A0=A0=A0=A0 if (vsock_msgzerocopy_allow(transport)) {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 set_bit(SOCK_SUPPORT_ZC, &sk->sk_sock=
et->flags);
>>> +=A0=A0=A0=A0=A0=A0=A0 } else if (sock_flag(sk, SOCK_ZEROCOPY)) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* If this option was set before 'co=
nnect()',
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * when transport was unknown, che=
ck that this
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * feature is supported here.
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 err =3D -EOPNOTSUPP;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;
>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>>
>>> =A0=A0=A0=A0=A0=A0=A0 err =3D vsock_auto_bind(vsk);
>>> =A0=A0=A0=A0=A0=A0=A0 if (err)
>>> @@ -1643,7 +1651,7 @@ static int vsock_connectible_setsockopt(struct so=
cket *sock,
>>> =A0=A0=A0=A0const struct vsock_transport *transport;
>>> =A0=A0=A0=A0u64 val;
>>>
>>> -=A0=A0=A0 if (level !=3D AF_VSOCK)
>>> +=A0=A0=A0 if (level !=3D AF_VSOCK && level !=3D SOL_SOCKET)
>>> =A0=A0=A0=A0=A0=A0=A0 return -ENOPROTOOPT;
>>>
>>> #define COPY_IN(_v)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \
>>> @@ -1666,6 +1674,34 @@ static int vsock_connectible_setsockopt(struct s=
ocket *sock,
>>>
>>> =A0=A0=A0=A0transport =3D vsk->transport;
>>>
>>> +=A0=A0=A0 if (level =3D=3D SOL_SOCKET) {
>>> +=A0=A0=A0=A0=A0=A0=A0 int zerocopy;
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 if (optname !=3D SO_ZEROCOPY) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 release_sock(sk);
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return sock_setsockopt(sock, level, =
optname, optval, optlen);
>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 /* Use 'int' type here, because variable to
>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * set this option usually has this type.
>>> +=A0=A0=A0=A0=A0=A0=A0=A0 */
>>> +=A0=A0=A0=A0=A0=A0=A0 COPY_IN(zerocopy);
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 if (zerocopy < 0 || zerocopy > 1) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 err =3D -EINVAL;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto exit;
>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 if (transport && !vsock_msgzerocopy_allow(transp=
ort)) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 err =3D -EOPNOTSUPP;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto exit;
>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 sock_valbool_flag(sk, SOCK_ZEROCOPY,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 zerocopy);
>>
>> it's not necessary to wrap this call.
>
>Sorry, what do you mean ?

I mean that can be on the same line:

	sock_valbool_flag(sk, SOCK_ZEROCOPY, zerocopy);

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
