Return-Path: <SRS0=81yh=LM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90D7C48BDF
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 16:25:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C9E9613B4
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 16:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9E9613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6AADD83CBB;
	Fri, 18 Jun 2021 16:25:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VyYvXWfOR81z; Fri, 18 Jun 2021 16:25:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C8D0683906;
	Fri, 18 Jun 2021 16:25:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AECA0C000D;
	Fri, 18 Jun 2021 16:25:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84F18C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 16:25:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 661724024C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 16:25:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DJpJFcgZj7Rt
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 16:25:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 52BA9400DC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 16:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624033522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fPUXuwIIMubJnCMUYIbK/KDXv25S7tj9NL4K7WirAU0=;
 b=cZkSNcGsVK5P8WW6+OG9IrKjlptzfx94sWLHV5SeHKHtbiNJ0JcG+yK3E4b/dQroQMWZon
 n1jSotJsNWC2jM47vORKq/lqrsg9TREYB8aZoMwaawQsih4JxcAbau89n0pkDrcUVeEDNu
 8xyQwUQePNNMa8jl2wZjHsIU0lv2qcU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-Kv6GnCL4Nr-YirrQ0NS_yg-1; Fri, 18 Jun 2021 12:25:20 -0400
X-MC-Unique: Kv6GnCL4Nr-YirrQ0NS_yg-1
Received: by mail-wm1-f71.google.com with SMTP id
 i82-20020a1c22550000b02901d64e84b3c9so2386541wmi.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 09:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=fPUXuwIIMubJnCMUYIbK/KDXv25S7tj9NL4K7WirAU0=;
 b=HUuH74fE1LljqK36WFCK7Y2sRb2xlZeTgYNCd+RXHrMBke1v4aPLKnezVuvJiHU8q0
 Hii3B4RKIhhxFfcymy1O3Ct6epgxwFfBJ2hZl5RhynUQCKYwiVwUCq1txSc2Ndfhl1vZ
 8PaU0cChdEmw6qv7omEF3uij40P7VVJWggdHYH3oH5BOmZE75PpEhgAMqb26Wls0rvOH
 /NL8izFuAzcRqt+g4NM8a57Aw+rgfqhTT3++jSwZ53J13ZMYcy9Nt/ko5nQrqY6EwT/d
 KnwObbVn8JuMqP09D7+ahXI8Mk1ckVoUC1xsuAB80ExzSCd6X1X4SmHq2y81YSJNCZGF
 HtLA==
X-Gm-Message-State: AOAM532D9JhUQ8MPwr1AZYkrxoVMhM2z9vgqKI6s126wcnu/ieCNknPT
 4nxovfPbQHlyPuFOwuOw8cD8Bunn0EqeG/7UzJdsrgZ9gdqshqhxkDOlJ/XbxS35vUAK+kNw3Rh
 neE4JsDKZPSQ60c/kt2Kz6nW/D2D6YdtbJMSOSHEK9g==
X-Received: by 2002:a7b:c24a:: with SMTP id b10mr12434121wmj.25.1624033519685; 
 Fri, 18 Jun 2021 09:25:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwypvvAg3317DbyVnwhInIuaBYNfidXY9XCDlEhFKWAq87Ip2EXKAD5iESujtcowWxg2zw+hQ==
X-Received: by 2002:a7b:c24a:: with SMTP id b10mr12434092wmj.25.1624033519510; 
 Fri, 18 Jun 2021 09:25:19 -0700 (PDT)
Received: from steredhat.lan ([5.170.128.175])
 by smtp.gmail.com with ESMTPSA id z12sm9045409wmc.5.2021.06.18.09.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jun 2021 09:25:19 -0700 (PDT)
Date: Fri, 18 Jun 2021 18:25:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [MASSMAIL KLMS] Re: [PATCH v11 11/18] virtio/vsock: dequeue
 callback for SOCK_SEQPACKET
Message-ID: <20210618162509.yppkajmvcbzvidy4@steredhat.lan>
References: <20210611110744.3650456-1-arseny.krasnov@kaspersky.com>
 <20210611111241.3652274-1-arseny.krasnov@kaspersky.com>
 <20210618134423.mksgnbmchmow4sgh@steredhat.lan>
 <bb323125-f802-1d16-7530-6e4f4abb00a6@kaspersky.com>
 <20210618155555.j5p4v6j5gk2dboj3@steredhat.lan>
 <650673dc-8b29-657e-5bbd-2cc974628ec9@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <650673dc-8b29-657e-5bbd-2cc974628ec9@kaspersky.com>
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

On Fri, Jun 18, 2021 at 07:08:30PM +0300, Arseny Krasnov wrote:
>
>On 18.06.2021 18:55, Stefano Garzarella wrote:
>> On Fri, Jun 18, 2021 at 06:04:37PM +0300, Arseny Krasnov wrote:
>>> On 18.06.2021 16:44, Stefano Garzarella wrote:
>>>> Hi Arseny,
>>>> the series looks great, I have just a question below about
>>>> seqpacket_dequeue.
>>>>
>>>> I also sent a couple a simple fixes, it would be great if you can revi=
ew
>>>> them:
>>>> https://lore.kernel.org/netdev/20210618133526.300347-1-sgarzare@redhat=
.com/
>>>>
>>>>
>>>> On Fri, Jun 11, 2021 at 02:12:38PM +0300, Arseny Krasnov wrote:
>>>>> Callback fetches RW packets from rx queue of socket until whole record
>>>>> is copied(if user's buffer is full, user is not woken up). This is do=
ne
>>>>> to not stall sender, because if we wake up user and it leaves syscall,
>>>>> nobody will send credit update for rest of record, and sender will wa=
it
>>>>> for next enter of read syscall at receiver's side. So if user buffer =
is
>>>>> full, we just send credit update and drop data.
>>>>>
>>>>> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>>>>> ---
>>>>> v10 -> v11:
>>>>> 1) 'msg_count' field added to count current number of EORs.
>>>>> 2) 'msg_ready' argument removed from callback.
>>>>> 3) If 'memcpy_to_msg()' failed during copy loop, there will be
>>>>>    no next attempts to copy data, rest of record will be freed.
>>>>>
>>>>> include/linux/virtio_vsock.h            |  5 ++
>>>>> net/vmw_vsock/virtio_transport_common.c | 84 +++++++++++++++++++++++++
>>>>> 2 files changed, 89 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsoc=
k.h
>>>>> index dc636b727179..1d9a302cb91d 100644
>>>>> --- a/include/linux/virtio_vsock.h
>>>>> +++ b/include/linux/virtio_vsock.h
>>>>> @@ -36,6 +36,7 @@ struct virtio_vsock_sock {
>>>>> 	u32 rx_bytes;
>>>>> 	u32 buf_alloc;
>>>>> 	struct list_head rx_queue;
>>>>> +	u32 msg_count;
>>>>> };
>>>>>
>>>>> struct virtio_vsock_pkt {
>>>>> @@ -80,6 +81,10 @@ virtio_transport_dgram_dequeue(struct vsock_sock *=
vsk,
>>>>> 			       struct msghdr *msg,
>>>>> 			       size_t len, int flags);
>>>>>
>>>>> +ssize_t
>>>>> +virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
>>>>> +				   struct msghdr *msg,
>>>>> +				   int flags);
>>>>> s64 virtio_transport_stream_has_data(struct vsock_sock *vsk);
>>>>> s64 virtio_transport_stream_has_space(struct vsock_sock *vsk);
>>>>>
>>>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/=
virtio_transport_common.c
>>>>> index ad0d34d41444..1e1df19ec164 100644
>>>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>>>> @@ -393,6 +393,78 @@ virtio_transport_stream_do_dequeue(struct vsock_=
sock *vsk,
>>>>> 	return err;
>>>>> }
>>>>>
>>>>> +static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *=
vsk,
>>>>> +						 struct msghdr *msg,
>>>>> +						 int flags)
>>>>> +{
>>>>> +	struct virtio_vsock_sock *vvs =3D vsk->trans;
>>>>> +	struct virtio_vsock_pkt *pkt;
>>>>> +	int dequeued_len =3D 0;
>>>>> +	size_t user_buf_len =3D msg_data_left(msg);
>>>>> +	bool copy_failed =3D false;
>>>>> +	bool msg_ready =3D false;
>>>>> +
>>>>> +	spin_lock_bh(&vvs->rx_lock);
>>>>> +
>>>>> +	if (vvs->msg_count =3D=3D 0) {
>>>>> +		spin_unlock_bh(&vvs->rx_lock);
>>>>> +		return 0;
>>>>> +	}
>>>>> +
>>>>> +	while (!msg_ready) {
>>>>> +		pkt =3D list_first_entry(&vvs->rx_queue, struct virtio_vsock_pkt, =
list);
>>>>> +
>>>>> +		if (!copy_failed) {
>>>>> +			size_t pkt_len;
>>>>> +			size_t bytes_to_copy;
>>>>> +
>>>>> +			pkt_len =3D (size_t)le32_to_cpu(pkt->hdr.len);
>>>>> +			bytes_to_copy =3D min(user_buf_len, pkt_len);
>>>>> +
>>>>> +			if (bytes_to_copy) {
>>>>> +				int err;
>>>>> +
>>>>> +				/* sk_lock is held by caller so no one else can dequeue.
>>>>> +				 * Unlock rx_lock since memcpy_to_msg() may sleep.
>>>>> +				 */
>>>>> +				spin_unlock_bh(&vvs->rx_lock);
>>>>> +
>>>>> +				err =3D memcpy_to_msg(msg, pkt->buf, bytes_to_copy);
>>>>> +				if (err) {
>>>>> +					/* Copy of message failed, set flag to skip
>>>>> +					 * copy path for rest of fragments. Rest of
>>>>> +					 * fragments will be freed without copy.
>>>>> +					 */
>>>>> +					copy_failed =3D true;
>>>>> +					dequeued_len =3D err;
>>>> If we fail to copy the message we will discard the entire packet.
>>>> Is it acceptable for the user point of view, or we should leave the
>>>> packet in the queue and the user can retry, maybe with a different
>>>> buffer?
>>>>
>>>> Then we can remove the packets only when we successfully copied all the
>>>> fragments.
>>>>
>>>> I'm not sure make sense, maybe better to check also other
>>>> implementations :-)
>>>>
>>>> Thanks,
>>>> Stefano
>>> Understand, i'll check it on weekend, anyway I think it is
>>> not critical for implementation.
>> Yep, I agree.
>>
>>>
>>> I have another question: may be it is useful to research for
>>> approach where packets are not queued until whole message
>>> is received, but copied to user's buffer thus freeing memory.
>>> (like previous implementation, of course with solution of problem
>>> where part of message still in queue, while reader was woken
>>> by timeout or signal).
>>>
>>> I think it is better, because=A0 in current version, sender may set
>>> 'peer_alloc_buf' to=A0 for example 1MB, so at receiver we get
>>> 1MB of 'kmalloc()' memory allocated, while having user's buffer
>>> to copy data there or drop it(if user's buffer is full). This way
>>> won't change spec(e.g. no message id or SEQ_BEGIN will be added).
>>>
>>> What do You think?
>> Yep, I see your point and it would be great, but I think the main issues
>> to fix is how to handle a signal while we are waiting other fragments
>> since the other peer can take unspecified time to send them.
>
>What about transport callback, something like 'seqpacket_drain()' or
>
>'seqpacket_drop_curr()' - when we got signal or timeout, notify transport
>
>to drop current message. In virtio case this will set special flag in tran=
sport,
>
>so on next dequeue, this flag is checked and if it is set - we drop all pa=
ckets
>
>until EOR found. Then we can copy untouched new record.
>

But in this way, we will lose the entire message.

Is it acceptable for seqpacket?

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
