Return-Path: <SRS0=vACO=LP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D43C4743C
	for <virtualization@archiver.kernel.org>; Mon, 21 Jun 2021 10:23:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE749611C1
	for <virtualization@archiver.kernel.org>; Mon, 21 Jun 2021 10:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE749611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7306B400A9;
	Mon, 21 Jun 2021 10:23:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 31fBZUCTG9wz; Mon, 21 Jun 2021 10:23:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DBA32401C4;
	Mon, 21 Jun 2021 10:23:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0F9FC000E;
	Mon, 21 Jun 2021 10:23:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93E5BC000C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 10:23:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7581B82F50
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 10:23:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HTC_hwItDFWE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 10:23:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C34982F3D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 10:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624271006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=17jrUzT4jshvnBr/GQQE2JZlgBMr8a3t05HmI0DNTg4=;
 b=AJmnOAq+jmNmfyYJ72L0s8qgjDHwT7fxoD88WCbGIrcaLImbM84LHQa9rHWBs/y851XLRk
 6Al0WIssDlH2a3ar5R5ZLSoRlcpGHPIwF+kjuYuPXGqfxGAZ/0E87asJT8Ov0xVJUu7tZE
 u/kx/theVZWkp5PDYXWYAubhJcOfNTU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-6xrvMqCLN1-HAaWm3AGMCg-1; Mon, 21 Jun 2021 06:23:24 -0400
X-MC-Unique: 6xrvMqCLN1-HAaWm3AGMCg-1
Received: by mail-ed1-f69.google.com with SMTP id
 f12-20020a056402150cb029038fdcfb6ea2so5689235edw.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 03:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=17jrUzT4jshvnBr/GQQE2JZlgBMr8a3t05HmI0DNTg4=;
 b=dUzSCJvOhFhsL4YqrPaZsKKG3065HzcAlT/r+RdnPFvkCvDAg7tTsAnRcvQS4ZcR20
 Fx8GGFW6Ux4pcmyzs8FHsKbkQk0HtBvCuk3BxKOzVS4GGP0wS3QDfsHC05LYhNxg/0fR
 WTivLMa8wK9GloA3yE9EcVDTabhHmBivPIuNn4EnYUqgORbGaRF/GD3fEY2/4Is6RfXp
 vbFWkSLuZ/BoUk01aiMsKuCBMUR34oAZy2HgCuckDpHoJxP0KQeL2vv48cLWe8ZcYDid
 bwrhH39Npne99npkzp9lqTbfaF4WLNjBlxODEcDxXA9taevw4nO2xQFDLIz/1K2yGKr5
 GfOA==
X-Gm-Message-State: AOAM5331mfAPDj6Z6Q8XFAKtCbLtpv+Sc4mN+S+eE/lgK1/aqNokcFXX
 vUstADuJyxbWrq5igHoOSz0Md8vVzmNGBjCcZ4+mDBEOXuFgfYwqI2QJwRv7poeygaVsgfaFDf5
 sRUXismH2GGBwSzrQqcbpwDGrx3Dqb/Rgb/KpOF4MCQ==
X-Received: by 2002:aa7:cd9a:: with SMTP id x26mr20286042edv.185.1624271003551; 
 Mon, 21 Jun 2021 03:23:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCpoPvlmrYqsoTqeuc70ych3y5ZMPCLAOlDvljTKxKtpookqp3Z/KFfPo8f0D5bYXz/2+t4w==
X-Received: by 2002:aa7:cd9a:: with SMTP id x26mr20286013edv.185.1624271003350; 
 Mon, 21 Jun 2021 03:23:23 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id ch17sm10434983edb.42.2021.06.21.03.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jun 2021 03:23:22 -0700 (PDT)
Date: Mon, 21 Jun 2021 12:23:20 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [MASSMAIL KLMS] Re: [PATCH v11 11/18] virtio/vsock: dequeue
 callback for SOCK_SEQPACKET
Message-ID: <20210621102320.4uaqaee74yynnn2q@steredhat>
References: <20210611110744.3650456-1-arseny.krasnov@kaspersky.com>
 <20210611111241.3652274-1-arseny.krasnov@kaspersky.com>
 <20210618134423.mksgnbmchmow4sgh@steredhat.lan>
 <bb323125-f802-1d16-7530-6e4f4abb00a6@kaspersky.com>
 <20210618155555.j5p4v6j5gk2dboj3@steredhat.lan>
 <650673dc-8b29-657e-5bbd-2cc974628ec9@kaspersky.com>
 <20210618162509.yppkajmvcbzvidy4@steredhat.lan>
 <31f58b17-02e6-4246-5ad8-7e8d7892ecb7@kaspersky.com>
 <b27d3fd1-fa8a-97ff-9035-cf3f525d5866@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <b27d3fd1-fa8a-97ff-9035-cf3f525d5866@kaspersky.com>
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

On Mon, Jun 21, 2021 at 09:55:13AM +0300, Arseny Krasnov wrote:
>
>On 18.06.2021 19:26, Arseny Krasnov wrote:
>> On 18.06.2021 19:25, Stefano Garzarella wrote:
>>> On Fri, Jun 18, 2021 at 07:08:30PM +0300, Arseny Krasnov wrote:
>>>> On 18.06.2021 18:55, Stefano Garzarella wrote:
>>>>> On Fri, Jun 18, 2021 at 06:04:37PM +0300, Arseny Krasnov wrote:
>>>>>> On 18.06.2021 16:44, Stefano Garzarella wrote:
>>>>>>> Hi Arseny,
>>>>>>> the series looks great, I have just a question below about
>>>>>>> seqpacket_dequeue.
>>>>>>>
>>>>>>> I also sent a couple a simple fixes, it would be great if you can r=
eview
>>>>>>> them:
>>>>>>> https://lore.kernel.org/netdev/20210618133526.300347-1-sgarzare@red=
hat.com/
>>>>>>>
>>>>>>>
>>>>>>> On Fri, Jun 11, 2021 at 02:12:38PM +0300, Arseny Krasnov wrote:
>>>>>>>> Callback fetches RW packets from rx queue of socket until whole re=
cord
>>>>>>>> is copied(if user's buffer is full, user is not woken up). This is=
 done
>>>>>>>> to not stall sender, because if we wake up user and it leaves sysc=
all,
>>>>>>>> nobody will send credit update for rest of record, and sender will=
 wait
>>>>>>>> for next enter of read syscall at receiver's side. So if user buff=
er is
>>>>>>>> full, we just send credit update and drop data.
>>>>>>>>
>>>>>>>> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>>>>>>>> ---
>>>>>>>> v10 -> v11:
>>>>>>>> 1) 'msg_count' field added to count current number of EORs.
>>>>>>>> 2) 'msg_ready' argument removed from callback.
>>>>>>>> 3) If 'memcpy_to_msg()' failed during copy loop, there will be
>>>>>>>>    no next attempts to copy data, rest of record will be freed.
>>>>>>>>
>>>>>>>> include/linux/virtio_vsock.h            |  5 ++
>>>>>>>> net/vmw_vsock/virtio_transport_common.c | 84 +++++++++++++++++++++=
++++
>>>>>>>> 2 files changed, 89 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_v=
sock.h
>>>>>>>> index dc636b727179..1d9a302cb91d 100644
>>>>>>>> --- a/include/linux/virtio_vsock.h
>>>>>>>> +++ b/include/linux/virtio_vsock.h
>>>>>>>> @@ -36,6 +36,7 @@ struct virtio_vsock_sock {
>>>>>>>> 	u32 rx_bytes;
>>>>>>>> 	u32 buf_alloc;
>>>>>>>> 	struct list_head rx_queue;
>>>>>>>> +	u32 msg_count;
>>>>>>>> };
>>>>>>>>
>>>>>>>> struct virtio_vsock_pkt {
>>>>>>>> @@ -80,6 +81,10 @@ virtio_transport_dgram_dequeue(struct vsock_soc=
k *vsk,
>>>>>>>> 			       struct msghdr *msg,
>>>>>>>> 			       size_t len, int flags);
>>>>>>>>
>>>>>>>> +ssize_t
>>>>>>>> +virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
>>>>>>>> +				   struct msghdr *msg,
>>>>>>>> +				   int flags);
>>>>>>>> s64 virtio_transport_stream_has_data(struct vsock_sock *vsk);
>>>>>>>> s64 virtio_transport_stream_has_space(struct vsock_sock *vsk);
>>>>>>>>
>>>>>>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vso=
ck/virtio_transport_common.c
>>>>>>>> index ad0d34d41444..1e1df19ec164 100644
>>>>>>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>>>>>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>>>>>>> @@ -393,6 +393,78 @@ virtio_transport_stream_do_dequeue(struct vso=
ck_sock *vsk,
>>>>>>>> 	return err;
>>>>>>>> }
>>>>>>>>
>>>>>>>> +static int virtio_transport_seqpacket_do_dequeue(struct vsock_soc=
k *vsk,
>>>>>>>> +						 struct msghdr *msg,
>>>>>>>> +						 int flags)
>>>>>>>> +{
>>>>>>>> +	struct virtio_vsock_sock *vvs =3D vsk->trans;
>>>>>>>> +	struct virtio_vsock_pkt *pkt;
>>>>>>>> +	int dequeued_len =3D 0;
>>>>>>>> +	size_t user_buf_len =3D msg_data_left(msg);
>>>>>>>> +	bool copy_failed =3D false;
>>>>>>>> +	bool msg_ready =3D false;
>>>>>>>> +
>>>>>>>> +	spin_lock_bh(&vvs->rx_lock);
>>>>>>>> +
>>>>>>>> +	if (vvs->msg_count =3D=3D 0) {
>>>>>>>> +		spin_unlock_bh(&vvs->rx_lock);
>>>>>>>> +		return 0;
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>> +	while (!msg_ready) {
>>>>>>>> +		pkt =3D list_first_entry(&vvs->rx_queue, struct virtio_vsock_pk=
t, list);
>>>>>>>> +
>>>>>>>> +		if (!copy_failed) {
>>>>>>>> +			size_t pkt_len;
>>>>>>>> +			size_t bytes_to_copy;
>>>>>>>> +
>>>>>>>> +			pkt_len =3D (size_t)le32_to_cpu(pkt->hdr.len);
>>>>>>>> +			bytes_to_copy =3D min(user_buf_len, pkt_len);
>>>>>>>> +
>>>>>>>> +			if (bytes_to_copy) {
>>>>>>>> +				int err;
>>>>>>>> +
>>>>>>>> +				/* sk_lock is held by caller so no one else can dequeue.
>>>>>>>> +				 * Unlock rx_lock since memcpy_to_msg() may sleep.
>>>>>>>> +				 */
>>>>>>>> +				spin_unlock_bh(&vvs->rx_lock);
>>>>>>>> +
>>>>>>>> +				err =3D memcpy_to_msg(msg, pkt->buf, bytes_to_copy);
>>>>>>>> +				if (err) {
>>>>>>>> +					/* Copy of message failed, set flag to skip
>>>>>>>> +					 * copy path for rest of fragments. Rest of
>>>>>>>> +					 * fragments will be freed without copy.
>>>>>>>> +					 */
>>>>>>>> +					copy_failed =3D true;
>>>>>>>> +					dequeued_len =3D err;
>>>>>>> If we fail to copy the message we will discard the entire packet.
>>>>>>> Is it acceptable for the user point of view, or we should leave the
>>>>>>> packet in the queue and the user can retry, maybe with a different
>>>>>>> buffer?
>>>>>>>
>>>>>>> Then we can remove the packets only when we successfully copied all=
 the
>>>>>>> fragments.
>>>>>>>
>>>>>>> I'm not sure make sense, maybe better to check also other
>>>>>>> implementations :-)
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Stefano
>>>>>> Understand, i'll check it on weekend, anyway I think it is
>>>>>> not critical for implementation.
>>>>> Yep, I agree.
>>>>>
>>>>>> I have another question: may be it is useful to research for
>>>>>> approach where packets are not queued until whole message
>>>>>> is received, but copied to user's buffer thus freeing memory.
>>>>>> (like previous implementation, of course with solution of problem
>>>>>> where part of message still in queue, while reader was woken
>>>>>> by timeout or signal).
>>>>>>
>>>>>> I think it is better, because=A0 in current version, sender may set
>>>>>> 'peer_alloc_buf' to=A0 for example 1MB, so at receiver we get
>>>>>> 1MB of 'kmalloc()' memory allocated, while having user's buffer
>>>>>> to copy data there or drop it(if user's buffer is full). This way
>>>>>> won't change spec(e.g. no message id or SEQ_BEGIN will be added).
>>>>>>
>>>>>> What do You think?
>>>>> Yep, I see your point and it would be great, but I think the main iss=
ues
>>>>> to fix is how to handle a signal while we are waiting other fragments
>>>>> since the other peer can take unspecified time to send them.
>>>> What about transport callback, something like 'seqpacket_drain()' or
>>>>
>>>> 'seqpacket_drop_curr()' - when we got signal or timeout, notify transp=
ort
>>>>
>>>> to drop current message. In virtio case this will set special flag in =
transport,
>>>>
>>>> so on next dequeue, this flag is checked and if it is set - we drop al=
l packets
>>>>
>>>> until EOR found. Then we can copy untouched new record.
>>>>
>>> But in this way, we will lose the entire message.
>>>
>>> Is it acceptable for seqpacket?
>>>
>>> Stefano
>> Hm, i'll check it. At least for unix domain sockets - it supports SEQPAC=
KET
>
>Hello, i've checked AF_UNIX and AF_AX25 SEQPACKET implementations,

Great! Thanks for checking!

>
>in both cases:
>
>1) Datagram is dequeued first, then copied to user's buffer.
>
>2) Datagram is also freed when copying to user's buffer fail
>
>(it is not reinserted back).
>
>
>But, in case of virtio vsock, i've got the following concern in

>this approach: in cases of AF_UNIX or AF_AX25 there is maximum
>
>datagram size, strictly limited by spec, so no 'setsockopt()' call allows
>
>to exceed this. Also these limits are significantly smaller that current
>
>amounts of RAM. But, in our case, there is no such limit: peer could
>
>say 'i want to use 100MB datagram', and receiver just answer 'ok',

The receiver sets the limit of its receive buffer and tells the =

transmitter that it should not exceed it. The default should be 256 KB, =

so IIUC this scenario can happen only if the receiver do a =

'setsockopt()' increasing the limit to 100MB. Right?

Maybe we should limit it.

>
>=A0as there is just variable assignment to setup new limit. Now, consider
>
>that there will be 10 peers, 100MB each(no one limit such request,
>
>because each socket doesn't know about each other). I think we get
>
>out-of-service in this case - all kmalloc() memory will be wasted for
>
>pending record.
>
>
>I still think, that approach when we copy data from packet to user's
>
>buffer without waiting EOR is better.

Okay, in this way we can remove the receive buffer limit and maybe if we =

receive a signal, we can set MSG_TRUNC, return the partially received =

packet to the user, but we must free any next fragments.

So, as you proposed, we need a `seqpacket_drop()` to tell to the =

transport that if we were copying an uncompleted message, then it should =

delete the queued fragments and any others until the next EOR.

>
>
>Also i'll rebase QEMU patch today or tomorrow.

Great, please CC me, this is something high priority to test =

SOCK_SEQPACKET with a guest.

>
>
>What do You Think?

I'm fine with both, but I slightly prefer the approach we implemented =

because it's easier to handle.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
