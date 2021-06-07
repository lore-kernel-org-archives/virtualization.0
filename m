Return-Path: <SRS0=jANb=LB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E35AC47082
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 11:04:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5604D61107
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 11:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5604D61107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1CC3982DE6;
	Mon,  7 Jun 2021 11:04:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MbxBJE7HRqaB; Mon,  7 Jun 2021 11:04:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9BE16828DE;
	Mon,  7 Jun 2021 11:04:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C5B4C000E;
	Mon,  7 Jun 2021 11:04:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25259C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 11:04:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0584582DE6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 11:04:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dEaX1JQk65DQ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 11:04:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9DAED828DE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 11:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623063867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QdD5x4dg80ZW0QDtXcMbPwZDhNJK7IbUOr1MPhIjbVg=;
 b=KemB1Dj5bf3VqtBbBYBEjtgjdMWSgKUIq9CabQLVio3Uw8HREpA9IleS4Un3j/B08k7oW8
 30qf2o16QNDJkR9JxcY/bkaPrjBSezINiDBNbDb3Tm1dEUk1dZFSUk3lN3ctbX9o208f0z
 F3ek7JDv38gpV7ZAk8VQSUxi/a2xWvI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-7c1ACxoZMySpj4zsL0BJfQ-1; Mon, 07 Jun 2021 07:04:26 -0400
X-MC-Unique: 7c1ACxoZMySpj4zsL0BJfQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 b8-20020a170906d108b02903fa10388224so5165798ejz.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Jun 2021 04:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QdD5x4dg80ZW0QDtXcMbPwZDhNJK7IbUOr1MPhIjbVg=;
 b=WlLJkD6kyammd30NFIvd7UcIDE6XxbkYeZoPN2zgVOaBWR5NdlyjrQ+s9MCWGWW9tS
 hDs8iPdXVI8j2e4xP67Dy8Q9+ku11lH7TeViUAbZYW+ATrhb2j7/9CG8RtWVtTvoehTL
 YRd7mYE3TCRxfE+vjMl+eEyXL+DGHmpdkc3FNyEWHj911NYAlR5RjilEb5U/cRMEB+qu
 3ibgRIxcCQbv1tyUYPzlrt0I1M0Z9Iva7W42jE6oFBXD8ycUs9oqb4tFw+ChdvKxE99a
 HNEPkGCRRnp6sOZxBZmq1GcCXMRQ45GEjtjpp9ZnbA9jp3igyeHfoxRiy5Nksd/N0zOD
 lzsg==
X-Gm-Message-State: AOAM5313IGxCiC/m/OSfjz3iKH3fjxYSw07lQaCtn0iiwhEfhuAVcCB4
 nisweBXVI8K7YnMuhYd4WPvZXx9cxWIxtus7ZIGFe+bW1Ij0pE0mZD/ijRqOsr+BbUXwtlD7O3l
 VVrTaThuK0eIza0EXnrYQNoW2/Nc+iBye0G2MD2dlkA==
X-Received: by 2002:a17:906:994d:: with SMTP id
 zm13mr17020367ejb.427.1623063865031; 
 Mon, 07 Jun 2021 04:04:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxe2C5l6pwY4urzIdLQAn60YhXhUzveWgvT8RFovl8hn5PZSOYXyfjQJxvksW7MzE7qHJSGxA==
X-Received: by 2002:a17:906:994d:: with SMTP id
 zm13mr17020326ejb.427.1623063864755; 
 Mon, 07 Jun 2021 04:04:24 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id bd3sm7565931edb.34.2021.06.07.04.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jun 2021 04:04:24 -0700 (PDT)
Date: Mon, 7 Jun 2021 13:04:21 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [PATCH v10 11/18] virtio/vsock: dequeue callback for
 SOCK_SEQPACKET
Message-ID: <20210607110421.wkx4dj7wipwsqztj@steredhat>
References: <20210520191357.1270473-1-arseny.krasnov@kaspersky.com>
 <20210520191801.1272027-1-arseny.krasnov@kaspersky.com>
 <20210603144513.ryjzauq7abnjogu3@steredhat>
 <6b833ccf-ea93-db6a-4743-463ac1cfe817@kaspersky.com>
 <20210604150324.winiikx5h3p6gsyy@steredhat>
 <a81ae3cb-439f-7621-4ae6-bccd2c25b7e4@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <a81ae3cb-439f-7621-4ae6-bccd2c25b7e4@kaspersky.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Jun 04, 2021 at 09:03:26PM +0300, Arseny Krasnov wrote:
>
>On 04.06.2021 18:03, Stefano Garzarella wrote:
>> On Fri, Jun 04, 2021 at 04:12:23PM +0300, Arseny Krasnov wrote:
>>> On 03.06.2021 17:45, Stefano Garzarella wrote:
>>>> On Thu, May 20, 2021 at 10:17:58PM +0300, Arseny Krasnov wrote:
>>>>> Callback fetches RW packets from rx queue of socket until whole record
>>>>> is copied(if user's buffer is full, user is not woken up). This is done
>>>>> to not stall sender, because if we wake up user and it leaves syscall,
>>>>> nobody will send credit update for rest of record, and sender will wait
>>>>> for next enter of read syscall at receiver's side. So if user buffer is
>>>>> full, we just send credit update and drop data.
>>>>>
>>>>> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>>>>> ---
>>>>> v9 -> v10:
>>>>> 1) Number of dequeued bytes incremented even in case when
>>>>>    user's buffer is full.
>>>>> 2) Use 'msg_data_left()' instead of direct access to 'msg_hdr'.
>>>>> 3) Rename variable 'err' to 'dequeued_len', in case of error
>>>>>    it has negative value.
>>>>>
>>>>> include/linux/virtio_vsock.h            |  5 ++
>>>>> net/vmw_vsock/virtio_transport_common.c | 65 +++++++++++++++++++++++++
>>>>> 2 files changed, 70 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>>>>> index dc636b727179..02acf6e9ae04 100644
>>>>> --- a/include/linux/virtio_vsock.h
>>>>> +++ b/include/linux/virtio_vsock.h
>>>>> @@ -80,6 +80,11 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
>>>>> 			       struct msghdr *msg,
>>>>> 			       size_t len, int flags);
>>>>>
>>>>> +ssize_t
>>>>> +virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
>>>>> +				   struct msghdr *msg,
>>>>> +				   int flags,
>>>>> +				   bool *msg_ready);
>>>>> s64 virtio_transport_stream_has_data(struct vsock_sock *vsk);
>>>>> s64 virtio_transport_stream_has_space(struct vsock_sock *vsk);
>>>>>
>>>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>>>> index ad0d34d41444..61349b2ea7fe 100644
>>>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>>>> @@ -393,6 +393,59 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>>>>> 	return err;
>>>>> }
>>>>>
>>>>> +static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
>>>>> +						 struct msghdr *msg,
>>>>> +						 int flags,
>>>>> +						 bool *msg_ready)
>>>>> +{
>>>>> +	struct virtio_vsock_sock *vvs = vsk->trans;
>>>>> +	struct virtio_vsock_pkt *pkt;
>>>>> +	int dequeued_len = 0;
>>>>> +	size_t user_buf_len = msg_data_left(msg);
>>>>> +
>>>>> +	*msg_ready = false;
>>>>> +	spin_lock_bh(&vvs->rx_lock);
>>>>> +
>>>>> +	while (!*msg_ready && !list_empty(&vvs->rx_queue) && dequeued_len >= 0) {
>>>> I'
>>>>
>>>>> +		size_t bytes_to_copy;
>>>>> +		size_t pkt_len;
>>>>> +
>>>>> +		pkt = list_first_entry(&vvs->rx_queue, struct virtio_vsock_pkt, list);
>>>>> +		pkt_len = (size_t)le32_to_cpu(pkt->hdr.len);
>>>>> +		bytes_to_copy = min(user_buf_len, pkt_len);
>>>>> +
>>>>> +		if (bytes_to_copy) {
>>>>> +			/* sk_lock is held by caller so no one else can dequeue.
>>>>> +			 * Unlock rx_lock since memcpy_to_msg() may sleep.
>>>>> +			 */
>>>>> +			spin_unlock_bh(&vvs->rx_lock);
>>>>> +
>>>>> +			if (memcpy_to_msg(msg, pkt->buf, bytes_to_copy))
>>>>> +				dequeued_len = -EINVAL;
>>>> I think here is better to return the error returned by memcpy_to_msg(),
>>>> as we do in the other place where we use memcpy_to_msg().
>>>>
>>>> I mean something like this:
>>>> 			err = memcpy_to_msgmsg, pkt->buf, bytes_to_copy);
>>>> 			if (err)
>>>> 				dequeued_len = err;
>>> Ack
>>>>> +			else
>>>>> +				user_buf_len -= bytes_to_copy;
>>>>> +
>>>>> +			spin_lock_bh(&vvs->rx_lock);
>>>>> +		}
>>>>> +
>>>> Maybe here we can simply break the cycle if we have an error:
>>>> 		if (dequeued_len < 0)
>>>> 			break;
>>>>
>>>> Or we can refactor a bit, simplifying the while() condition and also the
>>>> code in this way (not tested):
>>>>
>>>> 	while (!*msg_ready && !list_empty(&vvs->rx_queue)) {
>>>> 		...
>>>>
>>>> 		if (bytes_to_copy) {
>>>> 			int err;
>>>>
>>>> 			/* ...
>>>> 			*/
>>>> 			spin_unlock_bh(&vvs->rx_lock);
>>>> 			err = memcpy_to_msgmsg, pkt->buf, bytes_to_copy);
>>>> 			if (err) {
>>>> 				dequeued_len = err;
>>>> 				goto out;
>>>> 			}
>>>> 			spin_lock_bh(&vvs->rx_lock);
>>>>
>>>> 			user_buf_len -= bytes_to_copy;
>>>> 		}
>>>>
>>>> 		dequeued_len += pkt_len;
>>>>
>>>> 		if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOR)
>>>> 			*msg_ready = true;
>>>>
>>>> 		virtio_transport_dec_rx_pkt(vvs, pkt);
>>>> 		list_del(&pkt->list);
>>>> 		virtio_transport_free_pkt(pkt);
>>>> 	}
>>>>
>>>> out:
>>>> 	spin_unlock_bh(&vvs->rx_lock);
>>>>
>>>> 	virtio_transport_send_credit_update(vsk);
>>>>
>>>> 	return dequeued_len;
>>>> }
>>> I think we can't do 'goto out' or break, because in case of error, 
>>> we still need
>>> to free packet.
>> Didn't we have code that remove packets from a previous message?
>> I don't see it anymore.
>>
>> For example if we have 10 packets queued for a message (the 10th 
>> packet
>> has the EOR flag) and the memcpy_to_msg() fails on the 2nd packet, with
>> you proposal we are freeing only the first 2 packets, the rest is there
>> and should be freed when reading the next message, but I don't see that
>> code.
>>
>> The same can happen if the recvmsg syscall is interrupted. In that case
>> we report that nothing was copied, but we freed the first N packets, so
>> they are lost but the other packets are still in the queue.
>>
>> Please check also the patch where we implemented
>> __vsock_seqpacket_recvmsg().
>>
>> I thinks we should free packets only when we are sure we copied them to
>> the user space.
>
>Hm, yes, this is problem. To solve it i can restore previous approach
>with seqbegin/seqend. In that case i can detect unfinished record and
>drop it's packets. Seems seqbegin will be a bit like 
>VIRTIO_VSOCK_SEQ_EOR in flags
>field of header(e.g. VIRTIO_VSOCK_SEQ_BEGIN). Message id and length are 
>unneeded,
>as channel considedered lossless. What do You think?
>

I think VIRTIO_VSOCK_SEQ_BEGIN is redundant, using only EOR should be 
fine.

When we receive EOR we know that this is the last packet on this message 
and the next packet will be the first of a new message.

What we should do is check that we have all the fragments of a packet 
and return them all together, otherwise we have to say we have nothing.

For example as we process packets from the vitqueue and queue them in 
the rx_queue we could use a counter of how many EORs are in the 
rx_queue, which we decrease in virtio_transport_seqpacket_do_dequeue() 
when we copied all the fragments.

If the counter is 0, we don't remove anything from the queue and 
virtio_transport_seqpacket_do_dequeue() returns 0.

So .seqpacket_dequeue should return 0 if there is not at least one 
complete message, or return the entire message. A partial message should 
never return.

What do you think?


Maybe we should start using skbuffs for seqpackets as well, but that 
might take some time, so that might be okay for now.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
