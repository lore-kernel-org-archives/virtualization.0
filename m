Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F608C83F33
	for <virtualization@archiver.kernel.org>; Mon,  4 Sep 2023 08:22:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B3EC340963;
	Mon,  4 Sep 2023 08:22:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B3EC340963
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SsfIrUOn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f6e4Ow-DChqH; Mon,  4 Sep 2023 08:22:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C28B040950;
	Mon,  4 Sep 2023 08:22:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C28B040950
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D1AEC0039;
	Mon,  4 Sep 2023 08:22:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1667CC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Sep 2023 08:22:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D0AFD60E96
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Sep 2023 08:22:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D0AFD60E96
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SsfIrUOn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bZ-4utF8zNgy
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Sep 2023 08:22:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E20A760E07
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Sep 2023 08:22:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E20A760E07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693815720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=58CDt7MpBY+8uswKMe/+/g7ssjQGWAe8uPZZeAFNnOg=;
 b=SsfIrUOnlrLnRFjr8ajIJWc2EBBIl8yKu6pA1Qaxbt8V6MSiMbqZkKxOk7QZr9ygNm0DEP
 437yitdRjI6N+n4+OFJR9FwHZLZrHkjlZv3OTO9MfJhi5VtjrGShYNAp2VGb03eBcRV9PD
 n+XHItEd7sftkiiTtMsFc5YBDaA2IWw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-kErwm-7uNrCdIBOuWqZ-Og-1; Mon, 04 Sep 2023 04:21:58 -0400
X-MC-Unique: kErwm-7uNrCdIBOuWqZ-Og-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31f3cfe7269so587146f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Sep 2023 01:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693815717; x=1694420517;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=58CDt7MpBY+8uswKMe/+/g7ssjQGWAe8uPZZeAFNnOg=;
 b=V6/vqEBbsGY26bAqUqPPtbAFNBBl9ndINdFesL6VR9mtUemPwVAMCMrUMJnR1OgWtA
 lqTPhs+pFLbl/kTq5xv2WClnxobBwsMRY1pxpy9zzizD98TPYWFa3pEWVpTmnid7JRpm
 Q9mWXAFNqASNBzIDaHEYgBrxVBRsTgEzTeJUSMRIlkJoyRJbPVkc6jdYs4PRaPQ/CW/w
 C6lH3+VWFqFigaEO6N0A82Lmdm4y7viv2qwxO7NTyjoqDGOBT4ga6OxLG3ipOQlfuI15
 W/bIYwS0soJxgx2cON49wWSFWwa0wL5IeanhXXtZ5KOoYFq1X6DWiSFOfUYl6ONjgD4A
 BgTw==
X-Gm-Message-State: AOJu0YxLhhLVye3IvWtxPFsttMP8ehytYu6t4hYDejvBI8DaCsgKy4U3
 FOHRWk6OO2NVJYwc0t7xeBBN5QMi1yl8/ffFA+GolGkuc+/QheMp7vKbanWmkYOrbiUYpcaEi/8
 yI6yO/VVp0lf/pzlghEAjPF+v52t3odCjzJbLiVhBvg==
X-Received: by 2002:adf:f0ca:0:b0:31c:804b:5ec3 with SMTP id
 x10-20020adff0ca000000b0031c804b5ec3mr6824544wro.67.1693815717775; 
 Mon, 04 Sep 2023 01:21:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtvlQmvpxtAtQ0RXZWHxi9cuCDi1ONniVj1m3Lt/gu3c78Hd/LstB4eBmnfMtLXc/X7qNKFg==
X-Received: by 2002:adf:f0ca:0:b0:31c:804b:5ec3 with SMTP id
 x10-20020adff0ca000000b0031c804b5ec3mr6824530wro.67.1693815717437; 
 Mon, 04 Sep 2023 01:21:57 -0700 (PDT)
Received: from sgarzare-redhat ([46.222.123.165])
 by smtp.gmail.com with ESMTPSA id
 k1-20020adff5c1000000b0031ad5a54bedsm13851459wrp.9.2023.09.04.01.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 01:21:56 -0700 (PDT)
Date: Mon, 4 Sep 2023 10:21:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v7 4/4] vsock/virtio: MSG_ZEROCOPY flag support
Message-ID: <h63t6heovmyafu2lo6x6rzsbdbrhqhlbuol774ngbgshbycgdu@fgynzbmj5zn7>
References: <20230827085436.941183-1-avkrasnov@salutedevices.com>
 <20230827085436.941183-5-avkrasnov@salutedevices.com>
 <p2u2irlju6yuy54w4tqstaijhpnbmqxwavsdumsmyskrjguwux@kmd7cbavhjbh>
 <0ab443b5-73a5-f092-44a3-52e26244c9a8@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <0ab443b5-73a5-f092-44a3-52e26244c9a8@salutedevices.com>
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

On Sun, Sep 03, 2023 at 11:13:23AM +0300, Arseniy Krasnov wrote:
>
>
>On 01.09.2023 15:30, Stefano Garzarella wrote:
>> On Sun, Aug 27, 2023 at 11:54:36AM +0300, Arseniy Krasnov wrote:
>>> This adds handling of MSG_ZEROCOPY flag on transmission path: if this
>>> flag is set and zerocopy transmission is possible (enabled in socket
>>> options and transport allows zerocopy), then non-linear skb will be
>>> created and filled with the pages of user's buffer. Pages of user's
>>> buffer are locked in memory by 'get_user_pages()'. Second thing that
>>> this patch does is replace type of skb owning: instead of calling
>>> 'skb_set_owner_sk_safe()' it calls 'skb_set_owner_w()'. Reason of this
>>> change is that '__zerocopy_sg_from_iter()' increments 'sk_wmem_alloc'
>>> of socket, so to decrease this field correctly proper skb destructor is
>>> needed: 'sock_wfree()'. This destructor is set by 'skb_set_owner_w()'.
>>>
>>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>

[...]

>>>
>>> -/* Returns a new packet on success, otherwise returns NULL.
>>> - *
>>> - * If NULL is returned, errp is set to a negative errno.
>>> - */
>>> -static struct sk_buff *
>>> -virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t len,
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u32 src_cid,
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u32 src_port,
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u32 dst_cid,
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u32 dst_port)
>>> -{
>>> -=A0=A0=A0 const size_t skb_len =3D VIRTIO_VSOCK_SKB_HEADROOM + len;
>>> -=A0=A0=A0 struct virtio_vsock_hdr *hdr;
>>> -=A0=A0=A0 struct sk_buff *skb;
>>> +static bool virtio_transport_can_zcopy(struct virtio_vsock_pkt_info *i=
nfo,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 siz=
e_t max_to_send)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ^
>> I'd call it `pkt_len`, `max_to_send` is confusing IMHO. I didn't
>> initially if it was the number of buffers or bytes.
>>
>>> +{
>>> +=A0=A0=A0 const struct virtio_transport *t_ops;
>>> +=A0=A0=A0 struct iov_iter *iov_iter;
>>> +
>>> +=A0=A0=A0 if (!info->msg)
>>> +=A0=A0=A0=A0=A0=A0=A0 return false;
>>> +
>>> +=A0=A0=A0 iov_iter =3D &info->msg->msg_iter;
>>> +
>>> +=A0=A0=A0 if (iov_iter->iov_offset)
>>> +=A0=A0=A0=A0=A0=A0=A0 return false;
>>> +
>>> +=A0=A0=A0 /* We can't send whole iov. */
>>> +=A0=A0=A0 if (iov_iter->count > max_to_send)
>>> +=A0=A0=A0=A0=A0=A0=A0 return false;
>>> +
>>> +=A0=A0=A0 /* Check that transport can send data in zerocopy mode. */
>>> +=A0=A0=A0 t_ops =3D virtio_transport_get_ops(info->vsk);
>>> +
>>> +=A0=A0=A0 if (t_ops->can_msgzerocopy) {
>>
>> So if `can_msgzerocopy` is not implemented, we always return true after
>> this point. Should we mention it in the .can_msgzerocopy documentation?
>
>Ops, this is my mistake, I must return 'false' in this case. Seems I didn't
>catch this problem with my tests, because there was no test case where
>zerocopy will fallback to copy!
>
>I'll fix it and add new test!

yep, I agree!

>
>>
>> Can we also mention in the commit description why this is need only for
>> virtio_tranport and not for vhost and loopback?
>>
>>> +=A0=A0=A0=A0=A0=A0=A0 int pages_in_iov =3D iov_iter_npages(iov_iter, M=
AX_SKB_FRAGS);
>>> +=A0=A0=A0=A0=A0=A0=A0 int pages_to_send =3D min(pages_in_iov, MAX_SKB_=
FRAGS);
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 return t_ops->can_msgzerocopy(pages_to_send);
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 return true;
>>> +}
>>> +

[...]

>>> @@ -270,6 +395,17 @@ static int virtio_transport_send_pkt_info(struct v=
sock_sock *vsk,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>>> =A0=A0=A0=A0=A0=A0=A0 }
>>>
>>> +=A0=A0=A0=A0=A0=A0=A0 /* This is last skb to send this portion of data=
. */
>>
>> Sorry I didn't get it :-(
>>
>> Can you elaborate this a bit more?
>
>I mean that we iterate over user's buffer here, allocating skb on each
>iteration. And for last skb for this buffer we initialize completion
>for user (we need to allocate one completion for one syscall).

Okay, so maybe we should explain better also in the code comment.
>
>Thanks for review, I'll fix all other comments and resend patchset when
>'net-next' will be opened again.

Cool, thanks!
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
