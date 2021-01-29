Return-Path: <SRS0=XmMV=HA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B96C433E0
	for <virtualization@archiver.kernel.org>; Fri, 29 Jan 2021 09:22:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF5264DDB
	for <virtualization@archiver.kernel.org>; Fri, 29 Jan 2021 09:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF5264DDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 75D5F87098;
	Fri, 29 Jan 2021 09:22:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K8PM-gjfml4O; Fri, 29 Jan 2021 09:22:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 76B808708C;
	Fri, 29 Jan 2021 09:22:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62600C0FA8;
	Fri, 29 Jan 2021 09:22:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2248FC08A1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 09:22:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1685987098
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 09:22:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hX7XzWPWPXQx
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 09:22:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C42508708C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 09:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611912127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jY8FyDpLqcLWFmfjZij8pPOXIS4EA/lvfqNuCzUfJtw=;
 b=Am7Z8gh3gW+Y+dETaciTVojCB7aUlGjbs8xPFjMrkZFwR+uKXLxsT7oLh2/VCHAVk0pjnq
 cYbVfS4CgCgIkw4EiTcl8hmCSMt0OTas24d9Hk3AnGJxej0X1gpTL4VwlSxpGLQ2NVWsf8
 ZNROCZ+hz/E7sr3TGsLtgFWaf9p++Bk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-2dOqNajWN7O8d5EeiIXPmg-1; Fri, 29 Jan 2021 04:22:03 -0500
X-MC-Unique: 2dOqNajWN7O8d5EeiIXPmg-1
Received: by mail-ej1-f69.google.com with SMTP id d15so3640453ejc.21
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 01:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jY8FyDpLqcLWFmfjZij8pPOXIS4EA/lvfqNuCzUfJtw=;
 b=Jry99TdhTdtjeIeD2aqtTzdJfu/mCLQD0VO39AX3jiHqG147m8GWopUO4avuvF9IuX
 HyqI4pyPZxKZbhYO6oaCkLNZErcWFnmrL9kqK6QSQkbrevDP9QGBUotH9Zxe3prY4oR+
 puCVMNZE0HolGZ7AdUWRKoFaPMGLAmUAMlL5ZtTQc7/h8OUa7bG3EX+565eWuc3F4fhO
 wMihQPLb0Ud3wv63t5EsLkknAepaJGpPYoVOXkusCnGQ8KIupMrrHtW7POC/uLI3jTw8
 rUR5eJeUQtxRpYiaRgYzmKaFFSn/YWIfY7rlCtRhy/Z49PRtHoyKpuoxvjW5e+7l6qpq
 Kv5Q==
X-Gm-Message-State: AOAM5322FkORYNtutQq4s+0s5QJEp5ja3RPa0DtuH+UvMbiWUptWYxfw
 giYPVSfzF7DcTQys5m5KEKKZ35y+NLEJIE1iijTg/3RQ9yaIfkrk6cvFopDzNewHgrrCBt7SGQ8
 x41Cvu5C+3N0S5hlCcA1Y/jRz0kL6ocdX/AlglIiy9Q==
X-Received: by 2002:a05:6402:1a57:: with SMTP id
 bf23mr4051388edb.183.1611912122336; 
 Fri, 29 Jan 2021 01:22:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzaOr0zZ9BCjy26IVAs+XU9b6i/n0E03C+Iwjgswvejm9cT+cXF6klByXm9N/eedm5M6+RQ4w==
X-Received: by 2002:a05:6402:1a57:: with SMTP id
 bf23mr4051377edb.183.1611912122157; 
 Fri, 29 Jan 2021 01:22:02 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id z20sm4290868edx.15.2021.01.29.01.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jan 2021 01:22:01 -0800 (PST)
Date: Fri, 29 Jan 2021 10:21:58 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v3 03/13] af_vsock: implement SEQPACKET rx loop
Message-ID: <20210129092158.tm2bdwpqufsneaxw@steredhat>
References: <20210125110903.597155-1-arseny.krasnov@kaspersky.com>
 <20210125111239.598377-1-arseny.krasnov@kaspersky.com>
 <20210128165518.ho3csm5u7v5pnwnd@steredhat>
 <5e000f18-1457-068d-10c5-0a349c938497@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <5e000f18-1457-068d-10c5-0a349c938497@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Vander Stoep <jeffv@google.com>,
 "stsp2@yandex.ru" <stsp2@yandex.ru>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "oxffffaa@gmail.com" <oxffffaa@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Jan 29, 2021 at 09:28:49AM +0300, Arseny Krasnov wrote:
>
>On 28.01.2021 19:55, Stefano Garzarella wrote:
>> On Mon, Jan 25, 2021 at 02:12:36PM +0300, Arseny Krasnov wrote:
>>> This adds receive loop for SEQPACKET. It looks like receive loop for
>>> SEQPACKET, but there is a little bit difference:
>>> 1) It doesn't call notify callbacks.
>>> 2) It doesn't care about 'SO_SNDLOWAT' and 'SO_RCVLOWAT' values, because
>>>   there is no sense for these values in SEQPACKET case.
>>> 3) It waits until whole record is received or error is found during
>>>   receiving.
>>> 4) It processes and sets 'MSG_TRUNC' flag.
>>>
>>> So to avoid extra conditions for two types of socket inside one loop, two
>>> independent functions were created.
>>>
>>> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>>> ---
>>> include/net/af_vsock.h   |   5 ++
>>> net/vmw_vsock/af_vsock.c | 102 ++++++++++++++++++++++++++++++++++++++-
>>> 2 files changed, 106 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>>> index b1c717286993..46073842d489 100644
>>> --- a/include/net/af_vsock.h
>>> +++ b/include/net/af_vsock.h
>>> @@ -135,6 +135,11 @@ struct vsock_transport {
>>> 	bool (*stream_is_active)(struct vsock_sock *);
>>> 	bool (*stream_allow)(u32 cid, u32 port);
>>>
>>> +	/* SEQ_PACKET. */
>>> +	size_t (*seqpacket_seq_get_len)(struct vsock_sock *);
>>> +	ssize_t (*seqpacket_dequeue)(struct vsock_sock *, struct msghdr *,
>>> +				     size_t len, int flags);
>>> +
>>> 	/* Notification. */
>>> 	int (*notify_poll_in)(struct vsock_sock *, size_t, bool *);
>>> 	int (*notify_poll_out)(struct vsock_sock *, size_t, bool *);
>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>> index 524df8fc84cd..3b266880b7c8 100644
>>> --- a/net/vmw_vsock/af_vsock.c
>>> +++ b/net/vmw_vsock/af_vsock.c
>>> @@ -2006,7 +2006,107 @@ static int __vsock_stream_recvmsg(struct sock *sk, struct msghdr *msg,
>>> static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
>>> 				     size_t len, int flags)
>>> {
>>> -	return -1;
>>> +	const struct vsock_transport *transport;
>>> +	const struct iovec *orig_iov;
>>> +	unsigned long orig_nr_segs;
>>> +	ssize_t dequeued_total = 0;
>>> +	struct vsock_sock *vsk;
>>> +	size_t record_len;
>>> +	long timeout;
>>> +	int err = 0;
>>> +	DEFINE_WAIT(wait);
>>> +
>>> +	vsk = vsock_sk(sk);
>>> +	transport = vsk->transport;
>>> +
>>> +	timeout = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
>>> +	msg->msg_flags &= ~MSG_EOR;
>> Maybe add a comment about why we need to clear MSG_EOR.
>>
>>> +	orig_nr_segs = msg->msg_iter.nr_segs;
>>> +	orig_iov = msg->msg_iter.iov;
>>> +
>>> +	while (1) {
>>> +		ssize_t dequeued;
>>> +		s64 ready;
>>> +
>>> +		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
>>> +		ready = vsock_stream_has_data(vsk);
>>> +
>>> +		if (ready == 0) {
>>> +			if (vsock_wait_data(sk, &wait, timeout, NULL, 0)) {
>>> +				/* In case of any loop break(timeout, signal
>>> +				 * interrupt or shutdown), we report user that
>>> +				 * nothing was copied.
>>> +				 */
>>> +				dequeued_total = 0;
>>> +				break;
>>> +			}
>>> +			continue;
>>> +		}
>>> +
>>> +		finish_wait(sk_sleep(sk), &wait);
>>> +
>>> +		if (ready < 0) {
>>> +			err = -ENOMEM;
>>> +			goto out;
>>> +		}
>>> +
>>> +		if (dequeued_total == 0) {
>>> +			record_len =
>>> +				transport->seqpacket_seq_get_len(vsk);
>>> +
>>> +			if (record_len == 0)
>>> +				continue;
>>> +		}
>>> +
>>> +		/* 'msg_iter.count' is number of unused bytes in iov.
>>> +		 * On every copy to iov iterator it is decremented at
>>> +		 * size of data.
>>> +		 */
>>> +		dequeued = transport->seqpacket_dequeue(vsk, msg,
>>> +					msg->msg_iter.count, flags);
>>                                          ^
>>                                          Is this needed or 'msg' can be
>>                                          used in the transport?
>Yes, right
>>> +
>>> +		if (dequeued < 0) {
>>> +			dequeued_total = 0;
>>> +
>>> +			if (dequeued == -EAGAIN) {
>>> +				iov_iter_init(&msg->msg_iter, READ,
>>> +					      orig_iov, orig_nr_segs,
>>> +					      len);
>>> +				msg->msg_flags &= ~MSG_EOR;
>>> +				continue;
>> Why we need to reset MSG_EOR here?
>
>Because if previous attempt to receive record was failed, but
>
>MSG_EOR was set, so we clear it for next attempt to get record

Yes, I saw later when I looked at the implementation in the transport.

Maybe better to put a comment saying that seqpacket_dequeue() can set 
that flag.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
