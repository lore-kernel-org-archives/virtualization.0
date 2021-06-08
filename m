Return-Path: <SRS0=nkKT=LC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAA9C47082
	for <virtualization@archiver.kernel.org>; Tue,  8 Jun 2021 10:40:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C658D61278
	for <virtualization@archiver.kernel.org>; Tue,  8 Jun 2021 10:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C658D61278
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9419A83BCB;
	Tue,  8 Jun 2021 10:40:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 88Bz2u2ZxGBi; Tue,  8 Jun 2021 10:40:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4845883BCE;
	Tue,  8 Jun 2021 10:40:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BFBFC000D;
	Tue,  8 Jun 2021 10:40:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6982C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 10:40:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D0EBB6078E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 10:40:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yru9FQIw9Ucv
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 10:40:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A88FA606E7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 10:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623148806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nYNCs3JrvkX8VAnIEcTWaVkYHbhrJx9YKWDfXBQ1+cM=;
 b=JqhiS9cOtCcOCn8+9jbmJfzrDqT9dPfzVFCPycE3rPPa23kAHaupzNA404CS4RIspqnwTS
 3THpHOOaLWG4uA1fU7mMa03Y9Ea7ZdHzF+1KoSCr2pWiPlxNp8hvywvzaX7KzBJ1gQHBNR
 NAxHngwNZtIt1eikfS4smkp2r3mWHLk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-snlCkzkXP--N6uHZtW1lFQ-1; Tue, 08 Jun 2021 06:40:03 -0400
X-MC-Unique: snlCkzkXP--N6uHZtW1lFQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 q7-20020a1709063607b02903f57f85ac45so6573688ejb.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Jun 2021 03:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=nYNCs3JrvkX8VAnIEcTWaVkYHbhrJx9YKWDfXBQ1+cM=;
 b=HHIKaavNCbrP7Hfa9Q3zOk7B/bQC3flySFH61FvYfP3nd2z9xaPklHiwb4ZMatEIgt
 hRLXz9Sq9oaalcylqhLMgUM4PpBTZP93/G8GAlYHc5ft5kh0DE8U5XKsn2ggaaasvVdk
 8WMIyCJPN+Uqa1PDQ4bMdEmoPff1iIopOviLfb34G3MJjpX6BkJW/T3dWjHmmCIc9dr/
 VjeYhr5IEiSDo3NBOpsUPtn2P9JKp2mhN4Kx4KBw22Z/4lwItyGVvDZVcmRtKX1e1jbm
 CfXyvxiTrHOMyCvRPph/aEwmeQXso9DrI1fokHgQMyn8OP7EmhO6nVWFo6aTTkvYnyJW
 nxxA==
X-Gm-Message-State: AOAM532qIMtVFOt5k8E4OPH9xlE7w1dWTMKZ7nDrMa7XTLGb8KvCTBtK
 vg3kMGN4fkDfkquUGfoSVxvN7ek4CzS5vbTbSyavl/f6YhNwySdGug6SuVvdq5OTFz98jIL4UGJ
 Jd7vCUDDJY/EAo4bXT031Y14eYYNt5ppRTHhWs6BFOQ==
X-Received: by 2002:aa7:d590:: with SMTP id r16mr25088233edq.355.1623148801777; 
 Tue, 08 Jun 2021 03:40:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlQjlTOLOUv+CTcpQo85ShyVO8Hm6Jf6YQcKP01+YfXsWs3sS1DIB86mFlcYsubeJp29IuCA==
X-Received: by 2002:aa7:d590:: with SMTP id r16mr25088212edq.355.1623148801544; 
 Tue, 08 Jun 2021 03:40:01 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id g11sm8789689edt.85.2021.06.08.03.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jun 2021 03:40:01 -0700 (PDT)
Date: Tue, 8 Jun 2021 12:39:58 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [PATCH v10 11/18] virtio/vsock: dequeue callback for
 SOCK_SEQPACKET
Message-ID: <20210608103958.5oqkqr2ydanfxx2s@steredhat>
References: <20210603144513.ryjzauq7abnjogu3@steredhat>
 <6b833ccf-ea93-db6a-4743-463ac1cfe817@kaspersky.com>
 <20210604150324.winiikx5h3p6gsyy@steredhat>
 <a81ae3cb-439f-7621-4ae6-bccd2c25b7e4@kaspersky.com>
 <20210607110421.wkx4dj7wipwsqztj@steredhat>
 <8e2eb802-7c5d-70b0-82b5-ec8de4fdc046@kaspersky.com>
 <20210608082320.vs2tzgpxgr2dhxye@steredhat>
 <3c35f04a-8406-d26f-27d0-becbd3c43c1b@kaspersky.com>
 <20210608101952.6meiasy7zqp474sf@steredhat>
 <8ca7fe68-81b7-8984-bf0f-db2384985988@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <8ca7fe68-81b7-8984-bf0f-db2384985988@kaspersky.com>
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
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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

On Tue, Jun 08, 2021 at 01:24:58PM +0300, Arseny Krasnov wrote:
>
>On 08.06.2021 13:19, Stefano Garzarella wrote:
>> On Tue, Jun 08, 2021 at 12:40:39PM +0300, Arseny Krasnov wrote:
>>> On 08.06.2021 11:23, Stefano Garzarella wrote:
>>>> On Mon, Jun 07, 2021 at 04:18:38PM +0300, Arseny Krasnov wrote:
>>>>> On 07.06.2021 14:04, Stefano Garzarella wrote:
>>>>>> On Fri, Jun 04, 2021 at 09:03:26PM +0300, Arseny Krasnov wrote:
>>>>>>> On 04.06.2021 18:03, Stefano Garzarella wrote:
>>>>>>>> On Fri, Jun 04, 2021 at 04:12:23PM +0300, Arseny Krasnov wrote:
>>>>>>>>> On 03.06.2021 17:45, Stefano Garzarella wrote:
>>>>>>>>>> On Thu, May 20, 2021 at 10:17:58PM +0300, Arseny Krasnov wrote:
>>>>>>>>>>> Callback fetches RW packets from rx queue of socket until whole=
 record
>>>>>>>>>>> is copied(if user's buffer is full, user is not woken up). This=
 is done
>>>>>>>>>>> to not stall sender, because if we wake up user and it leaves s=
yscall,
>>>>>>>>>>> nobody will send credit update for rest of record, and sender w=
ill wait
>>>>>>>>>>> for next enter of read syscall at receiver's side. So if user b=
uffer is
>>>>>>>>>>> full, we just send credit update and drop data.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>>>>>>>>>>> ---
>>>>>>>>>>> v9 -> v10:
>>>>>>>>>>> 1) Number of dequeued bytes incremented even in case when
>>>>>>>>>>>    user's buffer is full.
>>>>>>>>>>> 2) Use 'msg_data_left()' instead of direct access to 'msg_hdr'.
>>>>>>>>>>> 3) Rename variable 'err' to 'dequeued_len', in case of error
>>>>>>>>>>>    it has negative value.
>>>>>>>>>>>
>>>>>>>>>>> include/linux/virtio_vsock.h            |  5 ++
>>>>>>>>>>> net/vmw_vsock/virtio_transport_common.c | 65 ++++++++++++++++++=
+++++++
>>>>>>>>>>> 2 files changed, 70 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/include/linux/virtio_vsock.h b/include/linux/virti=
o_vsock.h
>>>>>>>>>>> index dc636b727179..02acf6e9ae04 100644
>>>>>>>>>>> --- a/include/linux/virtio_vsock.h
>>>>>>>>>>> +++ b/include/linux/virtio_vsock.h
>>>>>>>>>>> @@ -80,6 +80,11 @@ virtio_transport_dgram_dequeue(struct vsock_=
sock *vsk,
>>>>>>>>>>> 			       struct msghdr *msg,
>>>>>>>>>>> 			       size_t len, int flags);
>>>>>>>>>>>
>>>>>>>>>>> +ssize_t
>>>>>>>>>>> +virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
>>>>>>>>>>> +				   struct msghdr *msg,
>>>>>>>>>>> +				   int flags,
>>>>>>>>>>> +				   bool *msg_ready);
>>>>>>>>>>> s64 virtio_transport_stream_has_data(struct vsock_sock *vsk);
>>>>>>>>>>> s64 virtio_transport_stream_has_space(struct vsock_sock *vsk);
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_=
vsock/virtio_transport_common.c
>>>>>>>>>>> index ad0d34d41444..61349b2ea7fe 100644
>>>>>>>>>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>>>>>>>>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>>>>>>>>>> @@ -393,6 +393,59 @@ virtio_transport_stream_do_dequeue(struct =
vsock_sock *vsk,
>>>>>>>>>>> 	return err;
>>>>>>>>>>> }
>>>>>>>>>>>
>>>>>>>>>>> +static int virtio_transport_seqpacket_do_dequeue(struct vsock_=
sock *vsk,
>>>>>>>>>>> +						 struct msghdr *msg,
>>>>>>>>>>> +						 int flags,
>>>>>>>>>>> +						 bool *msg_ready)
>>>>>>>>>>> +{
>>>>>>>>>>> +	struct virtio_vsock_sock *vvs =3D vsk->trans;
>>>>>>>>>>> +	struct virtio_vsock_pkt *pkt;
>>>>>>>>>>> +	int dequeued_len =3D 0;
>>>>>>>>>>> +	size_t user_buf_len =3D msg_data_left(msg);
>>>>>>>>>>> +
>>>>>>>>>>> +	*msg_ready =3D false;
>>>>>>>>>>> +	spin_lock_bh(&vvs->rx_lock);
>>>>>>>>>>> +
>>>>>>>>>>> +	while (!*msg_ready && !list_empty(&vvs->rx_queue) && dequeued=
_len >=3D 0) {
>>>>>>>>>> I'
>>>>>>>>>>
>>>>>>>>>>> +		size_t bytes_to_copy;
>>>>>>>>>>> +		size_t pkt_len;
>>>>>>>>>>> +
>>>>>>>>>>> +		pkt =3D list_first_entry(&vvs->rx_queue, struct virtio_vsock=
_pkt, list);
>>>>>>>>>>> +		pkt_len =3D (size_t)le32_to_cpu(pkt->hdr.len);
>>>>>>>>>>> +		bytes_to_copy =3D min(user_buf_len, pkt_len);
>>>>>>>>>>> +
>>>>>>>>>>> +		if (bytes_to_copy) {
>>>>>>>>>>> +			/* sk_lock is held by caller so no one else can dequeue.
>>>>>>>>>>> +			 * Unlock rx_lock since memcpy_to_msg() may sleep.
>>>>>>>>>>> +			 */
>>>>>>>>>>> +			spin_unlock_bh(&vvs->rx_lock);
>>>>>>>>>>> +
>>>>>>>>>>> +			if (memcpy_to_msg(msg, pkt->buf, bytes_to_copy))
>>>>>>>>>>> +				dequeued_len =3D -EINVAL;
>>>>>>>>>> I think here is better to return the error returned by memcpy_to=
_msg(),
>>>>>>>>>> as we do in the other place where we use memcpy_to_msg().
>>>>>>>>>>
>>>>>>>>>> I mean something like this:
>>>>>>>>>> 			err =3D memcpy_to_msgmsg, pkt->buf, bytes_to_copy);
>>>>>>>>>> 			if (err)
>>>>>>>>>> 				dequeued_len =3D err;
>>>>>>>>> Ack
>>>>>>>>>>> +			else
>>>>>>>>>>> +				user_buf_len -=3D bytes_to_copy;
>>>>>>>>>>> +
>>>>>>>>>>> +			spin_lock_bh(&vvs->rx_lock);
>>>>>>>>>>> +		}
>>>>>>>>>>> +
>>>>>>>>>> Maybe here we can simply break the cycle if we have an error:
>>>>>>>>>> 		if (dequeued_len < 0)
>>>>>>>>>> 			break;
>>>>>>>>>>
>>>>>>>>>> Or we can refactor a bit, simplifying the while() condition and =
also the
>>>>>>>>>> code in this way (not tested):
>>>>>>>>>>
>>>>>>>>>> 	while (!*msg_ready && !list_empty(&vvs->rx_queue)) {
>>>>>>>>>> 		...
>>>>>>>>>>
>>>>>>>>>> 		if (bytes_to_copy) {
>>>>>>>>>> 			int err;
>>>>>>>>>>
>>>>>>>>>> 			/* ...
>>>>>>>>>> 			*/
>>>>>>>>>> 			spin_unlock_bh(&vvs->rx_lock);
>>>>>>>>>> 			err =3D memcpy_to_msgmsg, pkt->buf, bytes_to_copy);
>>>>>>>>>> 			if (err) {
>>>>>>>>>> 				dequeued_len =3D err;
>>>>>>>>>> 				goto out;
>>>>>>>>>> 			}
>>>>>>>>>> 			spin_lock_bh(&vvs->rx_lock);
>>>>>>>>>>
>>>>>>>>>> 			user_buf_len -=3D bytes_to_copy;
>>>>>>>>>> 		}
>>>>>>>>>>
>>>>>>>>>> 		dequeued_len +=3D pkt_len;
>>>>>>>>>>
>>>>>>>>>> 		if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOR)
>>>>>>>>>> 			*msg_ready =3D true;
>>>>>>>>>>
>>>>>>>>>> 		virtio_transport_dec_rx_pkt(vvs, pkt);
>>>>>>>>>> 		list_del(&pkt->list);
>>>>>>>>>> 		virtio_transport_free_pkt(pkt);
>>>>>>>>>> 	}
>>>>>>>>>>
>>>>>>>>>> out:
>>>>>>>>>> 	spin_unlock_bh(&vvs->rx_lock);
>>>>>>>>>>
>>>>>>>>>> 	virtio_transport_send_credit_update(vsk);
>>>>>>>>>>
>>>>>>>>>> 	return dequeued_len;
>>>>>>>>>> }
>>>>>>>>> I think we can't do 'goto out' or break, because in case of error,
>>>>>>>>> we still need
>>>>>>>>> to free packet.
>>>>>>>> Didn't we have code that remove packets from a previous message?
>>>>>>>> I don't see it anymore.
>>>>>>>>
>>>>>>>> For example if we have 10 packets queued for a message (the 10th
>>>>>>>> packet
>>>>>>>> has the EOR flag) and the memcpy_to_msg() fails on the 2nd packet,=
 with
>>>>>>>> you proposal we are freeing only the first 2 packets, the rest is =
there
>>>>>>>> and should be freed when reading the next message, but I don't see=
 that
>>>>>>>> code.
>>>>>>>>
>>>>>>>> The same can happen if the recvmsg syscall is interrupted. In that=
 case
>>>>>>>> we report that nothing was copied, but we freed the first N packet=
s, so
>>>>>>>> they are lost but the other packets are still in the queue.
>>>>>>>>
>>>>>>>> Please check also the patch where we implemented
>>>>>>>> __vsock_seqpacket_recvmsg().
>>>>>>>>
>>>>>>>> I thinks we should free packets only when we are sure we copied th=
em to
>>>>>>>> the user space.
>>>>>>> Hm, yes, this is problem. To solve it i can restore previous approa=
ch
>>>>>>> with seqbegin/seqend. In that case i can detect unfinished record a=
nd
>>>>>>> drop it's packets. Seems seqbegin will be a bit like
>>>>>>> VIRTIO_VSOCK_SEQ_EOR in flags
>>>>>>> field of header(e.g. VIRTIO_VSOCK_SEQ_BEGIN). Message id and length=
 are
>>>>>>> unneeded,
>>>>>>> as channel considedered lossless. What do You think?
>>>>>>>
>>>>>> I think VIRTIO_VSOCK_SEQ_BEGIN is redundant, using only EOR should be
>>>>>> fine.
>>>>>>
>>>>>> When we receive EOR we know that this is the last packet on this mes=
sage
>>>>>> and the next packet will be the first of a new message.
>>>>>>
>>>>>> What we should do is check that we have all the fragments of a packet
>>>>>> and return them all together, otherwise we have to say we have nothi=
ng.
>>>>>>
>>>>>> For example as we process packets from the vitqueue and queue them in
>>>>>> the rx_queue we could use a counter of how many EORs are in the
>>>>>> rx_queue, which we decrease in virtio_transport_seqpacket_do_dequeue=
()
>>>>>> when we copied all the fragments.
>>>>>>
>>>>>> If the counter is 0, we don't remove anything from the queue and
>>>>>> virtio_transport_seqpacket_do_dequeue() returns 0.
>>>>>>
>>>>>> So .seqpacket_dequeue should return 0 if there is not at least one
>>>>>> complete message, or return the entire message. A partial message sh=
ould
>>>>>> never return.
>>>>>>
>>>>>> What do you think?
>>>>> I like it, i've implemented this approach in some early pre v1 versio=
ns.
>>>>>
>>>>> But in this case, credit update logic will be changed - in current im=
plementation
>>>>>
>>>>> (both seqpacket and stream) credit update reply is sent when data is =
copied
>>>>>
>>>>> to user's buffer(e.g. we copy data somewhere, free packet and ready t=
o process
>>>>>
>>>>> new packet). But if we don't touch user's buffer and keeping incoming=
 packet in rx queue
>>>>>
>>>>> until whole record is ready, when to send credit update?
>>>> I think the best approach could be to send credit updates when we remo=
ve
>>>> them from the rx_queue.
>>> In that case, it will be impossible to send message bigger than size of=
 rx buffer
>>>
>>> (e.g. credit allowed size), because packet will be queued without credi=
t update
>>>
>>> reply until credit allowed reach 0.
>>>
>> Yep, but I think it is a reasonable limit for a datagram socket.
>>
>> Maybe we can add a check on the TX side, since we know this value and
>> return an error to the user.
>
>E.g., to before sending message=A0 using SEQPACKET socket,
>
>i need to call setsockopt with SO_VM_SOCKETS_BUFFER_MAX_SIZE/
>
>SO_VM_SOCKETS_BUFFER_SIZE params to setup maximum message size,
>
>if user tries to send message bigger than it, return -EMSGSIZE ?
>

Yep, I mean the receiver side must set it (IIRC default is 256K).

In the transmitter side we can check it using `vvs->peer_buf_alloc` and =

return the error.

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
