Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D8DC6FD1D
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 08:29:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCB4B40354;
	Tue, 21 Mar 2023 08:29:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CCB4B40354
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MGSjrHKE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c8IKHb0-WWEf; Tue, 21 Mar 2023 08:29:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C2CB44038C;
	Tue, 21 Mar 2023 08:29:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C2CB44038C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71F82C0071;
	Tue, 21 Mar 2023 08:29:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4828BC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 08:29:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 22DA58141C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 08:29:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 22DA58141C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MGSjrHKE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BiqlPwIAR3CY
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 08:29:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 22D4381414
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 22D4381414
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 08:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679387344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VdAkEc4+Jc17UFo+IFspyWLrKMsHzFG0fne7hcDGYj8=;
 b=MGSjrHKE9MduzQRUmNwRV7KkuPBQmZNT6YD1KUJZ/42qM+WZ6/++dI53qJRUKWLRtb/Ogo
 P9N1hf8Wj+CLGENWRvrX/zd/CxuUjZMDGNEQSpTtKqE7rPzUp+Dn9A05lqV7NajY7KBI7I
 bf1tji7frtx2KxgAXvyY5DNDP80xnTo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-8ecPUUAtN2S_HAJtUsIgfA-1; Tue, 21 Mar 2023 04:29:02 -0400
X-MC-Unique: 8ecPUUAtN2S_HAJtUsIgfA-1
Received: by mail-qv1-f70.google.com with SMTP id
 jo13-20020a056214500d00b004c6c72bf1d0so7245847qvb.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 01:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679387342;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VdAkEc4+Jc17UFo+IFspyWLrKMsHzFG0fne7hcDGYj8=;
 b=gJNdepNjpVZfgFpvdRUlDwlXwn6jgvMpXb1irR07n9M3Fb0bo51HsXQjZqCg9v0oxl
 DDofurjYUGM3kc0Y2tXUHjqQwSW2dAolKPOolhv3ikdZNa63nG2afnimPmed8NvYf6me
 rfwHvoLedaWidh9WsOtMiUQhUJt+t8kWFO3tlv9wGRAaBUkMpnNa6CkkbbsC8UljOHl8
 NmyZ7upYZw/BCsNK6cxUzVmWeQYqE8QVkU2BT+zHLhMtCSprBtnz3ZQGPi+WOKnpfjJx
 nt+HC4UmPICucyKM5Dd1hcH+HkquYYrVThNcfH3jx9TIQNvxxwmlnEW2T1CZtCifw0rq
 31kg==
X-Gm-Message-State: AO0yUKVYSlksHzwXOqF7H1e1h1PldI/LCyK2RoXoYkdlZOCAMYExgEus
 IRPE7RB2soaOFZs/oLQ29IqgSijrnKURX8c/bqFqdm2APXylT45GisE1y2IveNBmSpoAh64IZSt
 T1pVw5zQI4JcUTVjzPgRnm02gex9XBoUmEG04tOlJAQ==
X-Received: by 2002:a05:622a:1051:b0:3d4:eb79:744f with SMTP id
 f17-20020a05622a105100b003d4eb79744fmr3461685qte.24.1679387342097; 
 Tue, 21 Mar 2023 01:29:02 -0700 (PDT)
X-Google-Smtp-Source: AK7set8+9mH/ASsttF6m8QpFD8AJ5PwroH0B+Mwvj5O0naMIvFjj0iJ1GdQ1UqCQuemzR8tKily5qQ==
X-Received: by 2002:a05:622a:1051:b0:3d4:eb79:744f with SMTP id
 f17-20020a05622a105100b003d4eb79744fmr3461667qte.24.1679387341779; 
 Tue, 21 Mar 2023 01:29:01 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 i19-20020ac87653000000b003b9a73cd120sm279816qtr.17.2023.03.21.01.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Mar 2023 01:29:01 -0700 (PDT)
Date: Tue, 21 Mar 2023 09:28:54 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2] virtio/vsock: allocate multiple skbuffs on tx
Message-ID: <20230321082854.jluiqjyc4n5k2vza@sgarzare-redhat>
References: <ea5725eb-6cb5-cf15-2938-34e335a442fa@sberdevices.ru>
 <20230320142959.2wwf474fiyp3ex5z@sgarzare-redhat>
 <2be688af-89a6-d903-017b-dafee3e48c33@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <2be688af-89a6-d903-017b-dafee3e48c33@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
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

On Mon, Mar 20, 2023 at 09:02:19PM +0300, Arseniy Krasnov wrote:
>
>
>On 20.03.2023 17:29, Stefano Garzarella wrote:
>> On Sun, Mar 19, 2023 at 09:46:10PM +0300, Arseniy Krasnov wrote:
>>> This adds small optimization for tx path: instead of allocating single
>>> skbuff on every call to transport, allocate multiple skbuff's until
>>> credit space allows, thus trying to send as much as possible data witho=
ut
>>> return to af_vsock.c.
>>>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>> Link to v1:
>>> https://lore.kernel.org/netdev/2c52aa26-8181-d37a-bccd-a86bd3cbc6e1@sbe=
rdevices.ru/
>>>
>>> Changelog:
>>> v1 -> v2:
>>> - If sent something, return number of bytes sent (even in
>>> =A0 case of error). Return error only if failed to sent first
>>> =A0 skbuff.
>>>
>>> net/vmw_vsock/virtio_transport_common.c | 53 ++++++++++++++++++-------
>>> 1 file changed, 39 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/vi=
rtio_transport_common.c
>>> index 6564192e7f20..3fdf1433ec28 100644
>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>> @@ -196,7 +196,8 @@ static int virtio_transport_send_pkt_info(struct vs=
ock_sock *vsk,
>>> =A0=A0=A0=A0const struct virtio_transport *t_ops;
>>> =A0=A0=A0=A0struct virtio_vsock_sock *vvs;
>>> =A0=A0=A0=A0u32 pkt_len =3D info->pkt_len;
>>> -=A0=A0=A0 struct sk_buff *skb;
>>> +=A0=A0=A0 u32 rest_len;
>>> +=A0=A0=A0 int ret;
>>>
>>> =A0=A0=A0=A0info->type =3D virtio_transport_get_type(sk_vsock(vsk));
>>>
>>> @@ -216,10 +217,6 @@ static int virtio_transport_send_pkt_info(struct v=
sock_sock *vsk,
>>>
>>> =A0=A0=A0=A0vvs =3D vsk->trans;
>>>
>>> -=A0=A0=A0 /* we can send less than pkt_len bytes */
>>> -=A0=A0=A0 if (pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
>>> -=A0=A0=A0=A0=A0=A0=A0 pkt_len =3D VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
>>> -
>>> =A0=A0=A0=A0/* virtio_transport_get_credit might return less than pkt_l=
en credit */
>>> =A0=A0=A0=A0pkt_len =3D virtio_transport_get_credit(vvs, pkt_len);
>>>
>>> @@ -227,17 +224,45 @@ static int virtio_transport_send_pkt_info(struct =
vsock_sock *vsk,
>>> =A0=A0=A0=A0if (pkt_len =3D=3D 0 && info->op =3D=3D VIRTIO_VSOCK_OP_RW)
>>> =A0=A0=A0=A0=A0=A0=A0 return pkt_len;
>>>
>>> -=A0=A0=A0 skb =3D virtio_transport_alloc_skb(info, pkt_len,
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 src_cid, =
src_port,
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dst_cid, =
dst_port);
>>> -=A0=A0=A0 if (!skb) {
>>> -=A0=A0=A0=A0=A0=A0=A0 virtio_transport_put_credit(vvs, pkt_len);
>>> -=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;
>>> -=A0=A0=A0 }
>>> +=A0=A0=A0 ret =3D 0;
>>> +=A0=A0=A0 rest_len =3D pkt_len;
>>> +
>>> +=A0=A0=A0 do {
>>> +=A0=A0=A0=A0=A0=A0=A0 struct sk_buff *skb;
>>> +=A0=A0=A0=A0=A0=A0=A0 size_t skb_len;
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 skb_len =3D min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_=
SIZE, rest_len);
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 skb =3D virtio_transport_alloc_skb(info, skb_len,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 src_cid, src_port,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 dst_cid, dst_port);
>>> +=A0=A0=A0=A0=A0=A0=A0 if (!skb) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D -ENOMEM;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 virtio_transport_inc_tx_pkt(vvs, skb);
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 ret =3D t_ops->send_pkt(skb);
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 if (ret < 0)
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>>>
>>> -=A0=A0=A0 virtio_transport_inc_tx_pkt(vvs, skb);
>>> +=A0=A0=A0=A0=A0=A0=A0 rest_len -=3D skb_len;
>>
>> t_ops->send_pkt() is returning the number of bytes sent. Current
>> implementations always return `skb_len`, so there should be no problem,
>> but it would be better to put a comment here, or we should handle the
>> case where ret !=3D skb_len to avoid future issues.
>
>Hello, thanks for review!
>
>I see. I think i'll handle such partial sends (ret !=3D skb_len) as error,=
 as
>it is the only thing to do - we remove 'skb_len' from user's buffer, but
>'send_pkt()' returns another value, so it will be strange for me to contin=
ue
>this tx loop as everything is ok. Something like this:
>+
>+ if (ret < 0)
>+    break;
>+
>+ if (ret !=3D skb_len) {
>+    ret =3D -EFAULT;//or may be -EIO
>+    break;
>+ }

Good for me.

>
>>
>>> +=A0=A0=A0 } while (rest_len);
>>>
>>> -=A0=A0=A0 return t_ops->send_pkt(skb);
>>> +=A0=A0=A0 /* Don't call this function with zero as argument:
>>> +=A0=A0=A0=A0 * it tries to acquire spinlock and such argument
>>> +=A0=A0=A0=A0 * makes this call useless.
>>
>> Good point, can we do the same also for virtio_transport_get_credit()?
>> (Maybe in a separate patch)
>>
>> I'm thinking if may be better to do it directly inside the functions,
>> but I don't have a strong opinion on that since we only call them here.
>>
>
>I think in this patch i can call 'virtio_transport_put_credit()' without i=
f, but
>i'll prepare separate patch which adds zero argument check to this functio=
n.

Yep, I agree.

>As i see, the only function suitable for such 'if' condition is
>'virtio_transport_put_credit()'.

Why not even for virtio_transport_get_credit() ?

When we send packets without payload (e.g. VIRTIO_VSOCK_OP_REQUEST,
VIRTIO_VSOCK_OP_SHUTDOWN) we call virtio_transport_get_credit()
with `credit` parameter equal to 0, then we acquire the spinlock but
in the end we do nothing.

>Anyway - for future use this check won't be bad.

Yep, these are minor improvements ;-)

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
