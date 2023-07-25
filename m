Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C69DC001DF
	for <virtualization@archiver.kernel.org>; Tue, 25 Jul 2023 12:28:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A8C5040169;
	Tue, 25 Jul 2023 12:28:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A8C5040169
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XzC04xNa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FopOHqukffmW; Tue, 25 Jul 2023 12:28:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 816C840022;
	Tue, 25 Jul 2023 12:28:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 816C840022
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 515D8C0072;
	Tue, 25 Jul 2023 12:28:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E699C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 12:28:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 24EFC40169
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 12:28:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 24EFC40169
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sApDcYko190t
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 12:28:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7DFF540022
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 12:28:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7DFF540022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690288092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KRuNVN4vDWtFOmpNTL3q0LJ3egvHGzZjRczvr8+lSKw=;
 b=XzC04xNa6clyjTLz4vC1MD3owM3i0iNR0+NZ4G5p5hr9PAmg5coYRaRizFzPYkXyTDlPv9
 8hYt07XeBH3pzDg/FvUOTq8NR247rUghm9LSFdSuedvi8n/4EmqA1GJVXnV/fQmmmC+2ee
 YwR6/N0S5a+lwsl5rFWFZiJ2EgoEJjk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-cTCyAeSLMRO85gQ4eGvweg-1; Tue, 25 Jul 2023 08:28:11 -0400
X-MC-Unique: cTCyAeSLMRO85gQ4eGvweg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-98843cc8980so452822366b.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 05:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690288090; x=1690892890;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KRuNVN4vDWtFOmpNTL3q0LJ3egvHGzZjRczvr8+lSKw=;
 b=RWeADD6t5OvnHtey86hd9abwPNIxrq5HzInFwSUGY2kfcXZ0564RjMCB982AwBM/vi
 p5A7F/LAKIhJx8G2btwLsw3bHO9Ao/zbgViuU00FXQmYxXMxxgHFQW08BrNYE+kjYwqM
 4ZOv4GiON9yz0ax/hMaxsb0jN4ESjtpNC2EPy2l9cYvAcu3wbXNHS4ZR5dZ3DfzXrYJ9
 mGp1+14W+Gon6EU5aJWGAv+iAdJ7bkDKB0IV1qR6I+XzKaKPqa2bHh2Qd7F83EgEeU2q
 tgZsS859nsEv0kvQ715Hfm+5H45Sc9O7oAYX6XAj15SUEM8ZqTJ8yuMHzqBe2g6tu7sj
 Lq+w==
X-Gm-Message-State: ABy/qLaKWMPBx3DMQOKdCrkfAmR9uwmCWyutB7OhYwIMEZQQqFACrSjs
 dXTxptigTrPd/9B3nmsDqNLwE8P0NCYbrQqlqjQni9DYNiassYzkiSS9PugNHn4r2hodgd/ZHfN
 mw8VfnXKZso8Ju2+ymYo5y64TY40WHoBNwcx6hqjYfw==
X-Received: by 2002:a17:907:7750:b0:997:c5c3:32cc with SMTP id
 kx16-20020a170907775000b00997c5c332ccmr12074501ejc.66.1690288090390; 
 Tue, 25 Jul 2023 05:28:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH7eIZeFH5IjvfarJNALhdAQrdiBM4hV1FJml2i9oqnT8oD77IwAL4WgvsyxuZvYQC7l2wk+w==
X-Received: by 2002:a17:907:7750:b0:997:c5c3:32cc with SMTP id
 kx16-20020a170907775000b00997c5c332ccmr12074483ejc.66.1690288089992; 
 Tue, 25 Jul 2023 05:28:09 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.213.93])
 by smtp.gmail.com with ESMTPSA id
 qc12-20020a170906d8ac00b0098866a94f14sm8139748ejb.125.2023.07.25.05.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 05:28:09 -0700 (PDT)
Date: Tue, 25 Jul 2023 14:28:02 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [PATCH net-next v3 4/4] vsock/virtio: MSG_ZEROCOPY flag support
Message-ID: <o6axh6mxd6mxai2zrpax6wa25slns7ysz5xsegntskvfxl53mt@wowjgb3jazt6>
References: <20230720214245.457298-1-AVKrasnov@sberdevices.ru>
 <20230720214245.457298-5-AVKrasnov@sberdevices.ru>
 <091c067b-43a0-da7f-265f-30c8c7e62977@sberdevices.ru>
 <2k3cbz762ua3fmlben5vcm7rs624sktaltbz3ldeevwiguwk2w@klggxj5e3ueu>
 <51022d5f-5b50-b943-ad92-b06f60bef433@sberdevices.ru>
 <3d1d76c9-2fdb-3dfe-222a-b2184cf17708@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <3d1d76c9-2fdb-3dfe-222a-b2184cf17708@sberdevices.ru>
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

On Tue, Jul 25, 2023 at 12:16:11PM +0300, Arseniy Krasnov wrote:
>
>
>On 25.07.2023 11:46, Arseniy Krasnov wrote:
>>
>>
>> On 25.07.2023 11:43, Stefano Garzarella wrote:
>>> On Fri, Jul 21, 2023 at 08:09:03AM +0300, Arseniy Krasnov wrote:
>>>>
>>>>
>>>> On 21.07.2023 00:42, Arseniy Krasnov wrote:
>>>>> This adds handling of MSG_ZEROCOPY flag on transmission path: if this
>>>>> flag is set and zerocopy transmission is possible (enabled in socket
>>>>> options and transport allows zerocopy), then non-linear skb will be
>>>>> created and filled with the pages of user's buffer. Pages of user's
>>>>> buffer are locked in memory by 'get_user_pages()'. Second thing that
>>>>> this patch does is replace type of skb owning: instead of calling
>>>>> 'skb_set_owner_sk_safe()' it calls 'skb_set_owner_w()'. Reason of this
>>>>> change is that '__zerocopy_sg_from_iter()' increments 'sk_wmem_alloc'
>>>>> of socket, so to decrease this field correctly proper skb destructor =
is
>>>>> needed: 'sock_wfree()'. This destructor is set by 'skb_set_owner_w()'.
>>>>>
>>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>>> ---
>>>>> =A0Changelog:
>>>>> =A0v5(big patchset) -> v1:
>>>>> =A0 * Refactorings of 'if' conditions.
>>>>> =A0 * Remove extra blank line.
>>>>> =A0 * Remove 'frag_off' field unneeded init.
>>>>> =A0 * Add function 'virtio_transport_fill_skb()' which fills both lin=
ear
>>>>> =A0=A0=A0 and non-linear skb with provided data.
>>>>> =A0v1 -> v2:
>>>>> =A0 * Use original order of last four arguments in 'virtio_transport_=
alloc_skb()'.
>>>>> =A0v2 -> v3:
>>>>> =A0 * Add new transport callback: 'msgzerocopy_check_iov'. It checks =
that
>>>>> =A0=A0=A0 provided 'iov_iter' with data could be sent in a zerocopy m=
ode.
>>>>> =A0=A0=A0 If this callback is not set in transport - transport allows=
 to send
>>>>> =A0=A0=A0 any 'iov_iter' in zerocopy mode. Otherwise - if callback re=
turns 'true'
>>>>> =A0=A0=A0 then zerocopy is allowed. Reason of this callback is that i=
n case of
>>>>> =A0=A0=A0 G2H transmission we insert whole skb to the tx virtio queue=
 and such
>>>>> =A0=A0=A0 skb must fit to the size of the virtio queue to be sent in =
a single
>>>>> =A0=A0=A0 iteration (may be tx logic in 'virtio_transport.c' could be=
 reworked
>>>>> =A0=A0=A0 as in vhost to support partial send of current skb). This c=
allback
>>>>> =A0=A0=A0 will be enabled only for G2H path. For details pls see comm=
ent
>>>>> =A0=A0=A0 'Check that tx queue...' below.
>>>>>
>>>>> =A0include/net/af_vsock.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 |=A0=A0 3 +
>>>>> =A0net/vmw_vsock/virtio_transport.c=A0=A0=A0=A0=A0=A0=A0 |=A0 39 ++++
>>>>> =A0net/vmw_vsock/virtio_transport_common.c | 257 ++++++++++++++++++--=
----
>>>>> =A03 files changed, 241 insertions(+), 58 deletions(-)
>>>>>
>>>>> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>>>>> index 0e7504a42925..a6b346eeeb8e 100644
>>>>> --- a/include/net/af_vsock.h
>>>>> +++ b/include/net/af_vsock.h
>>>>> @@ -177,6 +177,9 @@ struct vsock_transport {
>>>>>
>>>>> =A0=A0=A0=A0 /* Read a single skb */
>>>>> =A0=A0=A0=A0 int (*read_skb)(struct vsock_sock *, skb_read_actor_t);
>>>>> +
>>>>> +=A0=A0=A0 /* Zero-copy. */
>>>>> +=A0=A0=A0 bool (*msgzerocopy_check_iov)(const struct iov_iter *);
>>>>> =A0};
>>>>>
>>>>> =A0/**** CORE ****/
>>>>> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_=
transport.c
>>>>> index 7bbcc8093e51..23cb8ed638c4 100644
>>>>> --- a/net/vmw_vsock/virtio_transport.c
>>>>> +++ b/net/vmw_vsock/virtio_transport.c
>>>>> @@ -442,6 +442,43 @@ static void virtio_vsock_rx_done(struct virtqueu=
e *vq)
>>>>> =A0=A0=A0=A0 queue_work(virtio_vsock_workqueue, &vsock->rx_work);
>>>>> =A0}
>>>>>
>>>>> +static bool virtio_transport_msgzerocopy_check_iov(const struct =

>>>>> iov_iter *iov)
>>>>> +{
>>>>> +=A0=A0=A0 struct virtio_vsock *vsock;
>>>>> +=A0=A0=A0 bool res =3D false;
>>>>> +
>>>>> +=A0=A0=A0 rcu_read_lock();
>>>>> +
>>>>> +=A0=A0=A0 vsock =3D rcu_dereference(the_virtio_vsock);
>>>>> +=A0=A0=A0 if (vsock) {

Just noted, what about the following to reduce the indentation?

         if (!vsock) {
             goto out;
         }
             ...
             ...
     out:
         rcu_read_unlock();
         return res;

>>>>> +=A0=A0=A0=A0=A0=A0=A0 struct virtqueue *vq;
>>>>> +=A0=A0=A0=A0=A0=A0=A0 int iov_pages;
>>>>> +
>>>>> +=A0=A0=A0=A0=A0=A0=A0 vq =3D vsock->vqs[VSOCK_VQ_TX];
>>>>> +
>>>>> +=A0=A0=A0=A0=A0=A0=A0 iov_pages =3D round_up(iov->count, PAGE_SIZE) =
/ PAGE_SIZE;
>>>>> +
>>>>> +=A0=A0=A0=A0=A0=A0=A0 /* Check that tx queue is large enough to keep=
 whole
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * data to send. This is needed, because whe=
n there is
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * not enough free space in the queue, curre=
nt skb to
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * send will be reinserted to the head of tx=
 list of
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * the socket to retry transmission later, s=
o if skb
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * is bigger than whole queue, it will be re=
inserted
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * again and again, thus blocking other skbs=
 to be sent.
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * Each page of the user provided buffer wil=
l be added
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * as a single buffer to the tx virtqueue, s=
o compare
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * number of pages against maximum capacity =
of the queue.
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * +1 means buffer for the packet header.
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 */
>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (iov_pages + 1 <=3D vq->num_max)
>>>>
>>>> I think this check is actual only for case one we don't have indirect =
buffer feature.
>>>> With indirect mode whole data to send will be packed into one indirect=
 buffer.
>>>
>>> I think so.
>>> So, should we check also that here?
>>>
>>>>
>>>> Thanks, Arseniy
>>>>
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 res =3D true;
>>>>> +=A0=A0=A0 }
>>>>> +
>>>>> +=A0=A0=A0 rcu_read_unlock();
>>>>> +
>>>>> +=A0=A0=A0 return res;
>>>>> +}
>>>>> +
>>>>> =A0static bool virtio_transport_seqpacket_allow(u32 remote_cid);
>>>>>
>>>>> =A0static struct virtio_transport virtio_transport =3D {
>>>>> @@ -475,6 +512,8 @@ static struct virtio_transport virtio_transport =
=3D {
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0 .seqpacket_allow=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=3D virtio_transport_seqpacket_allow,
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0 .seqpacket_has_data=A0=A0=A0=A0=A0=A0 =3D vi=
rtio_transport_seqpacket_has_data,
>>>>>
>>>>> +=A0=A0=A0=A0=A0=A0=A0 .msgzerocopy_check_iov=A0=A0=A0=A0=A0 =3D virt=
io_transport_msgzerocopy_check_iov,
>>>>> +
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0 .notify_poll_in=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =3D virtio_transport_notify_poll_in,
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0 .notify_poll_out=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=3D virtio_transport_notify_poll_out,
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0 .notify_recv_init=A0=A0=A0=A0=A0=A0=A0=A0 =
=3D virtio_transport_notify_recv_init,
>>>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/=
virtio_transport_common.c
>>>>> index 26a4d10da205..e4e3d541aff4 100644
>>>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>>>> @@ -37,73 +37,122 @@ virtio_transport_get_ops(struct vsock_sock *vsk)
>>>>> =A0=A0=A0=A0 return container_of(t, struct virtio_transport, transpor=
t);
>>>>> =A0}
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
>>>>> -=A0=A0=A0 void *payload;
>>>>> -=A0=A0=A0 int err;
>>>>> +static bool virtio_transport_can_zcopy(struct virtio_vsock_pkt_info =
*info,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 s=
ize_t max_to_send)
>>>>> +{
>>>>> +=A0=A0=A0 const struct vsock_transport *t;
>>>>> +=A0=A0=A0 struct iov_iter *iov_iter;
>>>>>
>>>>> -=A0=A0=A0 skb =3D virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
>>>>> -=A0=A0=A0 if (!skb)
>>>>> -=A0=A0=A0=A0=A0=A0=A0 return NULL;
>>>>> +=A0=A0=A0 if (!info->msg)
>>>>> +=A0=A0=A0=A0=A0=A0=A0 return false;
>>>>>
>>>>> -=A0=A0=A0 hdr =3D virtio_vsock_hdr(skb);
>>>>> -=A0=A0=A0 hdr->type=A0=A0=A0 =3D cpu_to_le16(info->type);
>>>>> -=A0=A0=A0 hdr->op=A0=A0=A0=A0=A0=A0=A0 =3D cpu_to_le16(info->op);
>>>>> -=A0=A0=A0 hdr->src_cid=A0=A0=A0 =3D cpu_to_le64(src_cid);
>>>>> -=A0=A0=A0 hdr->dst_cid=A0=A0=A0 =3D cpu_to_le64(dst_cid);
>>>>> -=A0=A0=A0 hdr->src_port=A0=A0=A0 =3D cpu_to_le32(src_port);
>>>>> -=A0=A0=A0 hdr->dst_port=A0=A0=A0 =3D cpu_to_le32(dst_port);
>>>>> -=A0=A0=A0 hdr->flags=A0=A0=A0 =3D cpu_to_le32(info->flags);
>>>>> -=A0=A0=A0 hdr->len=A0=A0=A0 =3D cpu_to_le32(len);
>>>>> +=A0=A0=A0 iov_iter =3D &info->msg->msg_iter;
>>>>>
>>>>> -=A0=A0=A0 if (info->msg && len > 0) {
>>>>> -=A0=A0=A0=A0=A0=A0=A0 payload =3D skb_put(skb, len);
>>>>> -=A0=A0=A0=A0=A0=A0=A0 err =3D memcpy_from_msg(payload, info->msg, le=
n);
>>>>> -=A0=A0=A0=A0=A0=A0=A0 if (err)
>>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;
>>>>> +=A0=A0=A0 t =3D vsock_core_get_transport(info->vsk);
>>>>>
>>>>> -=A0=A0=A0=A0=A0=A0=A0 if (msg_data_left(info->msg) =3D=3D 0 &&
>>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 info->type =3D=3D VIRTIO_VSOCK_TYP=
E_SEQPACKET) {
>>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 hdr->flags |=3D cpu_to_le32(VIRTIO=
_VSOCK_SEQ_EOM);
>>>>> +=A0=A0=A0 if (t->msgzerocopy_check_iov &&
>>>>> +=A0=A0=A0=A0=A0=A0=A0 !t->msgzerocopy_check_iov(iov_iter))
>>>>> +=A0=A0=A0=A0=A0=A0=A0 return false;
>>>
>>> I'd avoid adding a new transport callback used only internally in virtio
>>> transports.
>>
>> Ok, I see.
>>
>>>
>>> Usually the transport callbacks are used in af_vsock.c, if we need a
>>> callback just for virtio transports, maybe better to add it in struct
>>> virtio_vsock_pkt_info or struct virtio_vsock_sock.
>
>Hm, may be I just need to move this callback from 'struct vsock_transport'=
 to parent 'struct virtio_transport',
>after 'send_pkt' callback. In this case:
>1) AF_VSOCK part is not touched.
>2) This callback stays in 'virtio_transport.c' and is set also in this fil=
e.
>   vhost and loopback are unchanged - only 'send_pkt' still enabled in both
>   files for these two transports.

Yep, this could also work!

Stefano

>
>Thanks, Arseniy
>
>>>
>>> Maybe better the last one so we don't have to allocate pointer space
>>> for each packet and you should reach it via info.
>>
>> Ok, thanks, I'll try this way
>>
>> Thanks, Arseniy
>>
>>>
>>> Thanks,
>>> Stefano
>>>
>>>>>
>>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (info->msg->msg_flags & MSG_EOR)
>>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 hdr->flags |=3D cpu_to=
_le32(VIRTIO_VSOCK_SEQ_EOR);
>>>>> -=A0=A0=A0=A0=A0=A0=A0 }
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
>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (!uarg)
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -1;
>>>>> +
>>>>> +=A0=A0=A0=A0=A0=A0=A0 uarg_zc =3D uarg_to_msgzc(uarg);
>>>>> +=A0=A0=A0=A0=A0=A0=A0 uarg_zc->zerocopy =3D zerocopy ? 1 : 0;
>>>>> =A0=A0=A0=A0 }
>>>>>
>>>>> -=A0=A0=A0 if (info->reply)
>>>>> -=A0=A0=A0=A0=A0=A0=A0 virtio_vsock_skb_set_reply(skb);
>>>>> +=A0=A0=A0 skb_zcopy_init(skb, uarg);
>>>>>
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
>>>>> +=A0=A0=A0 return 0;
>>>>> +}
>>>>>
>>>>> -=A0=A0=A0 if (info->vsk && !skb_set_owner_sk_safe(skb, sk_vsock(info=
->vsk))) {
>>>>> -=A0=A0=A0=A0=A0=A0=A0 WARN_ONCE(1, "failed to allocate skb on vsock =
socket with sk_refcnt =3D=3D 0\n");
>>>>> -=A0=A0=A0=A0=A0=A0=A0 goto out;
>>>>> +static int virtio_transport_fill_skb(struct sk_buff *skb,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct =
virtio_vsock_pkt_info *info,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t =
len,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bool zc=
opy)
>>>>> +{
>>>>> +=A0=A0=A0 if (zcopy) {
>>>>> +=A0=A0=A0=A0=A0=A0=A0 return __zerocopy_sg_from_iter(info->msg, NULL=
, skb,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 &info->msg->msg_iter,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 len);
>>>>> +=A0=A0=A0 } else {
>>>>> +=A0=A0=A0=A0=A0=A0=A0 void *payload;
>>>>> +=A0=A0=A0=A0=A0=A0=A0 int err;
>>>>> +
>>>>> +=A0=A0=A0=A0=A0=A0=A0 payload =3D skb_put(skb, len);
>>>>> +=A0=A0=A0=A0=A0=A0=A0 err =3D memcpy_from_msg(payload, info->msg, le=
n);
>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (err)
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -1;
>>>>> +
>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (msg_data_left(info->msg))
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
>>>>> +
>>>>> +=A0=A0=A0=A0=A0=A0=A0 return 0;
>>>>> =A0=A0=A0=A0 }
>>>>> +}
>>>>>
>>>>> -=A0=A0=A0 return skb;
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
>>>>> -out:
>>>>> -=A0=A0=A0 kfree_skb(skb);
>>>>> -=A0=A0=A0 return NULL;
>>>>> +=A0=A0=A0 hdr =3D virtio_vsock_hdr(skb);
>>>>> +=A0=A0=A0 hdr->type=A0=A0=A0 =3D cpu_to_le16(info->type);
>>>>> +=A0=A0=A0 hdr->op=A0=A0=A0=A0=A0=A0=A0 =3D cpu_to_le16(info->op);
>>>>> +=A0=A0=A0 hdr->src_cid=A0=A0=A0 =3D cpu_to_le64(src_cid);
>>>>> +=A0=A0=A0 hdr->dst_cid=A0=A0=A0 =3D cpu_to_le64(dst_cid);
>>>>> +=A0=A0=A0 hdr->src_port=A0=A0=A0 =3D cpu_to_le32(src_port);
>>>>> +=A0=A0=A0 hdr->dst_port=A0=A0=A0 =3D cpu_to_le32(dst_port);
>>>>> +=A0=A0=A0 hdr->flags=A0=A0=A0 =3D cpu_to_le32(info->flags);
>>>>> +=A0=A0=A0 hdr->len=A0=A0=A0 =3D cpu_to_le32(len);
>>>>> =A0}
>>>>>
>>>>> =A0static void virtio_transport_copy_nonlinear_skb(const struct sk_bu=
ff *skb,
>>>>> @@ -214,6 +263,70 @@ static u16 virtio_transport_get_type(struct sock=
 *sk)
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0 return VIRTIO_VSOCK_TYPE_SEQPACKET;
>>>>> =A0}
>>>>>
>>>>> +static struct sk_buff *virtio_transport_alloc_skb(struct vsock_sock =
*vsk,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 struct virtio_vsock_pkt_info *info,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 size_t payload_len,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 bool zcopy,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 u32 src_cid,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 u32 src_port,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 u32 dst_cid,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 u32 dst_port)
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
>>>>> +
>>>>> +=A0=A0=A0 if (info->msg && payload_len > 0) {
>>>>> +=A0=A0=A0=A0=A0=A0=A0 int err;
>>>>> +
>>>>> +=A0=A0=A0=A0=A0=A0=A0 err =3D virtio_transport_fill_skb(skb, info, p=
ayload_len, zcopy);
>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (err)
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;
>>>>> +
>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (info->type =3D=3D VIRTIO_VSOCK_TYPE_SEQPAC=
KET) {
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct virtio_vsock_hdr *hdr =3D v=
irtio_vsock_hdr(skb);
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
>>>>> =A0/* This function can only be used on connecting/connected sockets,
>>>>> =A0 * since a socket assigned to a transport is required.
>>>>> =A0 *
>>>>> @@ -222,10 +335,12 @@ static u16 virtio_transport_get_type(struct soc=
k *sk)
>>>>> =A0static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st=
ruct virtio_vsock_pkt_info *info)
>>>>> =A0{
>>>>> +=A0=A0=A0 u32 max_skb_len =3D VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
>>>>> =A0=A0=A0=A0 u32 src_cid, src_port, dst_cid, dst_port;
>>>>> =A0=A0=A0=A0 const struct virtio_transport *t_ops;
>>>>> =A0=A0=A0=A0 struct virtio_vsock_sock *vvs;
>>>>> =A0=A0=A0=A0 u32 pkt_len =3D info->pkt_len;
>>>>> +=A0=A0=A0 bool can_zcopy =3D false;
>>>>> =A0=A0=A0=A0 u32 rest_len;
>>>>> =A0=A0=A0=A0 int ret;
>>>>>
>>>>> @@ -254,15 +369,30 @@ static int virtio_transport_send_pkt_info(struc=
t vsock_sock *vsk,
>>>>> =A0=A0=A0=A0 if (pkt_len =3D=3D 0 && info->op =3D=3D VIRTIO_VSOCK_OP_=
RW)
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0 return pkt_len;
>>>>>
>>>>> +=A0=A0=A0 if (info->msg) {
>>>>> +=A0=A0=A0=A0=A0=A0=A0 /* If zerocopy is not enabled by 'setsockopt()=
', we behave as
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * there is no MSG_ZEROCOPY flag set.
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 */
>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 info->msg->msg_flags &=3D ~MSG_ZER=
OCOPY;
>>>>> +
>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (info->msg->msg_flags & MSG_ZEROCOPY)
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 can_zcopy =3D virtio_transport_can=
_zcopy(info, pkt_len);
>>>>> +
>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (can_zcopy)
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_skb_len =3D min_t(u32, VIRTIO_=
VSOCK_MAX_PKT_BUF_SIZE,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 (MAX_SKB_FRAGS * PAGE_SIZE));
>>>>> +=A0=A0=A0 }
>>>>> +
>>>>> =A0=A0=A0=A0 rest_len =3D pkt_len;
>>>>>
>>>>> =A0=A0=A0=A0 do {
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0 struct sk_buff *skb;
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0 size_t skb_len;
>>>>>
>>>>> -=A0=A0=A0=A0=A0=A0=A0 skb_len =3D min_t(u32, VIRTIO_VSOCK_MAX_PKT_BU=
F_SIZE, rest_len);
>>>>> +=A0=A0=A0=A0=A0=A0=A0 skb_len =3D min(max_skb_len, rest_len);
>>>>>
>>>>> -=A0=A0=A0=A0=A0=A0=A0 skb =3D virtio_transport_alloc_skb(info, skb_l=
en,
>>>>> +=A0=A0=A0=A0=A0=A0=A0 skb =3D virtio_transport_alloc_skb(vsk, info, =
skb_len, can_zcopy,
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 src_cid, src_port,
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 dst_cid, dst_port);
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0 if (!skb) {
>>>>> @@ -270,6 +400,17 @@ static int virtio_transport_send_pkt_info(struct=
 vsock_sock *vsk,
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0 }
>>>>>
>>>>> +=A0=A0=A0=A0=A0=A0=A0 /* This is last skb to send this portion of da=
ta. */
>>>>> +=A0=A0=A0=A0=A0=A0=A0 if (info->msg && info->msg->msg_flags & MSG_ZE=
ROCOPY &&
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 skb_len =3D=3D rest_len && info->o=
p =3D=3D VIRTIO_VSOCK_OP_RW) {
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
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0 virtio_transport_inc_tx_pkt(vvs, skb);
>>>>>
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0 ret =3D t_ops->send_pkt(skb);
>>>>> @@ -934,7 +1075,7 @@ static int virtio_transport_reset_no_sock(const =
struct virtio_transport *t,
>>>>> =A0=A0=A0=A0 if (!t)
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0 return -ENOTCONN;
>>>>>
>>>>> -=A0=A0=A0 reply =3D virtio_transport_alloc_skb(&info, 0,
>>>>> +=A0=A0=A0 reply =3D virtio_transport_alloc_skb(NULL, &info, 0, false,
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 le64_to_cpu(hdr->dst_cid),
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 le32_to_cpu(hdr->dst_port),
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 le64_to_cpu(hdr->src_cid),
>>>>
>>>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
