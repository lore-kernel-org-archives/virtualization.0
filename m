Return-Path: <SRS0=81yh=LM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87C2C49EA3
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 15:56:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9288F611CD
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 15:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9288F611CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 465A140230;
	Fri, 18 Jun 2021 15:56:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OL5nWOv0V8u9; Fri, 18 Jun 2021 15:56:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BFCD1400DC;
	Fri, 18 Jun 2021 15:56:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BF56C000D;
	Fri, 18 Jun 2021 15:56:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74873C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 15:56:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 55981606B1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 15:56:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nsVTA6MuIc-8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 15:56:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 226D660684
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 15:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624031763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Awjn2v8qac0K7VClk6HbxoaGBdL5LeTfJlE9EQ+fOjk=;
 b=OAACkEV23Oi9tlYJ9U6BKxTTlbDgCuADiI3NKHffgpkobmiW82yyTu/8q3N8yYbpn25lYO
 nq0D3IsNHqkMs+XJxXZr4g3Hr23r4ngMGb8N0S0UYbqnXCQvomAYTXutfLQdbI6O+dhW4T
 IAuC/ma+p4ISyUZCXqAIUlmO4Tssu70=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390--xXq2hOiOBmxt5o1VujLRQ-1; Fri, 18 Jun 2021 11:56:01 -0400
X-MC-Unique: -xXq2hOiOBmxt5o1VujLRQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 k3-20020a5d62830000b029011a69a4d069so4355464wru.21
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 08:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Awjn2v8qac0K7VClk6HbxoaGBdL5LeTfJlE9EQ+fOjk=;
 b=gLmdQGwfTiZljQrbBauElNlC5WmFBL23CbOb5+C94IJ6RJp9MblqZQMzm3IN12dZ9z
 WhpXX7tS85SVDRuddOXwfM+6hTdVL4hEv9LoG/u6CyrhqAuHOxPQInpM2DzT9yG7Rn24
 69n6lXJj35bnlD4w3WM+KKQUmiyawMZHjOPnNYVFcuMNucP6MKEzlqccGILm2wwdGKxq
 l13RTAlNgUS9pi3A7FOpbr5yudvwLIysL3JasyowErRnqxjUxdE1DnvRisc6k5CdRnDT
 GQ55vrd2rPGQESfP20OmI72kVVMfktYcCLVWeNGu0pglAzBRnIIbrgMifGSyHm5Mm9rG
 xi9w==
X-Gm-Message-State: AOAM530PiI/m93Vjx1vCCA0iHobbiCjvPj3aOYKfxVekgBCnxjKc4dJo
 qAN/vhd4XIX+fXr+6hpUnZ+grLIdu5hHMFtrSjZ2tvzJgyIF5zWpieq0oXy04MqQ+1DyIXNJls5
 OnANKDHCCY1FkL+gAo3j65QPLRBzeGmUEPyVhQ7yslw==
X-Received: by 2002:a5d:6d8a:: with SMTP id l10mr13665854wrs.63.1624031760677; 
 Fri, 18 Jun 2021 08:56:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyb8+5HIJLdutX7cENNNI1/ecBZD9YW9aCIcD5DoBeecwsxaAXgeOQAGd3lSOiR1Xdg+NTIjg==
X-Received: by 2002:a5d:6d8a:: with SMTP id l10mr13665839wrs.63.1624031760459; 
 Fri, 18 Jun 2021 08:56:00 -0700 (PDT)
Received: from steredhat.lan ([5.170.128.175])
 by smtp.gmail.com with ESMTPSA id m18sm8968801wmq.45.2021.06.18.08.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jun 2021 08:56:00 -0700 (PDT)
Date: Fri, 18 Jun 2021 17:55:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [PATCH v11 11/18] virtio/vsock: dequeue callback for
 SOCK_SEQPACKET
Message-ID: <20210618155555.j5p4v6j5gk2dboj3@steredhat.lan>
References: <20210611110744.3650456-1-arseny.krasnov@kaspersky.com>
 <20210611111241.3652274-1-arseny.krasnov@kaspersky.com>
 <20210618134423.mksgnbmchmow4sgh@steredhat.lan>
 <bb323125-f802-1d16-7530-6e4f4abb00a6@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <bb323125-f802-1d16-7530-6e4f4abb00a6@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "oxffffaa@gmail.com" <oxffffaa@gmail.com>,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
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

On Fri, Jun 18, 2021 at 06:04:37PM +0300, Arseny Krasnov wrote:
>
>On 18.06.2021 16:44, Stefano Garzarella wrote:
>> Hi Arseny,
>> the series looks great, I have just a question below about
>> seqpacket_dequeue.
>>
>> I also sent a couple a simple fixes, it would be great if you can review
>> them:
>> https://lore.kernel.org/netdev/20210618133526.300347-1-sgarzare@redhat.c=
om/
>>
>>
>> On Fri, Jun 11, 2021 at 02:12:38PM +0300, Arseny Krasnov wrote:
>>> Callback fetches RW packets from rx queue of socket until whole record
>>> is copied(if user's buffer is full, user is not woken up). This is done
>>> to not stall sender, because if we wake up user and it leaves syscall,
>>> nobody will send credit update for rest of record, and sender will wait
>>> for next enter of read syscall at receiver's side. So if user buffer is
>>> full, we just send credit update and drop data.
>>>
>>> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>>> ---
>>> v10 -> v11:
>>> 1) 'msg_count' field added to count current number of EORs.
>>> 2) 'msg_ready' argument removed from callback.
>>> 3) If 'memcpy_to_msg()' failed during copy loop, there will be
>>>    no next attempts to copy data, rest of record will be freed.
>>>
>>> include/linux/virtio_vsock.h            |  5 ++
>>> net/vmw_vsock/virtio_transport_common.c | 84 +++++++++++++++++++++++++
>>> 2 files changed, 89 insertions(+)
>>>
>>> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>>> index dc636b727179..1d9a302cb91d 100644
>>> --- a/include/linux/virtio_vsock.h
>>> +++ b/include/linux/virtio_vsock.h
>>> @@ -36,6 +36,7 @@ struct virtio_vsock_sock {
>>> 	u32 rx_bytes;
>>> 	u32 buf_alloc;
>>> 	struct list_head rx_queue;
>>> +	u32 msg_count;
>>> };
>>>
>>> struct virtio_vsock_pkt {
>>> @@ -80,6 +81,10 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vs=
k,
>>> 			       struct msghdr *msg,
>>> 			       size_t len, int flags);
>>>
>>> +ssize_t
>>> +virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
>>> +				   struct msghdr *msg,
>>> +				   int flags);
>>> s64 virtio_transport_stream_has_data(struct vsock_sock *vsk);
>>> s64 virtio_transport_stream_has_space(struct vsock_sock *vsk);
>>>
>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/vi=
rtio_transport_common.c
>>> index ad0d34d41444..1e1df19ec164 100644
>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>> @@ -393,6 +393,78 @@ virtio_transport_stream_do_dequeue(struct vsock_so=
ck *vsk,
>>> 	return err;
>>> }
>>>
>>> +static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vs=
k,
>>> +						 struct msghdr *msg,
>>> +						 int flags)
>>> +{
>>> +	struct virtio_vsock_sock *vvs =3D vsk->trans;
>>> +	struct virtio_vsock_pkt *pkt;
>>> +	int dequeued_len =3D 0;
>>> +	size_t user_buf_len =3D msg_data_left(msg);
>>> +	bool copy_failed =3D false;
>>> +	bool msg_ready =3D false;
>>> +
>>> +	spin_lock_bh(&vvs->rx_lock);
>>> +
>>> +	if (vvs->msg_count =3D=3D 0) {
>>> +		spin_unlock_bh(&vvs->rx_lock);
>>> +		return 0;
>>> +	}
>>> +
>>> +	while (!msg_ready) {
>>> +		pkt =3D list_first_entry(&vvs->rx_queue, struct virtio_vsock_pkt, li=
st);
>>> +
>>> +		if (!copy_failed) {
>>> +			size_t pkt_len;
>>> +			size_t bytes_to_copy;
>>> +
>>> +			pkt_len =3D (size_t)le32_to_cpu(pkt->hdr.len);
>>> +			bytes_to_copy =3D min(user_buf_len, pkt_len);
>>> +
>>> +			if (bytes_to_copy) {
>>> +				int err;
>>> +
>>> +				/* sk_lock is held by caller so no one else can dequeue.
>>> +				 * Unlock rx_lock since memcpy_to_msg() may sleep.
>>> +				 */
>>> +				spin_unlock_bh(&vvs->rx_lock);
>>> +
>>> +				err =3D memcpy_to_msg(msg, pkt->buf, bytes_to_copy);
>>> +				if (err) {
>>> +					/* Copy of message failed, set flag to skip
>>> +					 * copy path for rest of fragments. Rest of
>>> +					 * fragments will be freed without copy.
>>> +					 */
>>> +					copy_failed =3D true;
>>> +					dequeued_len =3D err;
>> If we fail to copy the message we will discard the entire packet.
>> Is it acceptable for the user point of view, or we should leave the
>> packet in the queue and the user can retry, maybe with a different
>> buffer?
>>
>> Then we can remove the packets only when we successfully copied all the
>> fragments.
>>
>> I'm not sure make sense, maybe better to check also other
>> implementations :-)
>>
>> Thanks,
>> Stefano
>
>Understand, i'll check it on weekend, anyway I think it is
>not critical for implementation.

Yep, I agree.

>
>
>I have another question: may be it is useful to research for
>approach where packets are not queued until whole message
>is received, but copied to user's buffer thus freeing memory.
>(like previous implementation, of course with solution of problem
>where part of message still in queue, while reader was woken
>by timeout or signal).
>
>I think it is better, because=A0 in current version, sender may set
>'peer_alloc_buf' to=A0 for example 1MB, so at receiver we get
>1MB of 'kmalloc()' memory allocated, while having user's buffer
>to copy data there or drop it(if user's buffer is full). This way
>won't change spec(e.g. no message id or SEQ_BEGIN will be added).
>
>What do You think?

Yep, I see your point and it would be great, but I think the main issues =

to fix is how to handle a signal while we are waiting other fragments =

since the other peer can take unspecified time to send them.

Note that the 'peer_alloc_buf' in the sender, is the value get from the =

receiver, so if the receiver doesn't want to allocate 1MB, can advertise =

a small buffer size.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
