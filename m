Return-Path: <SRS0=jANb=LB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F8DC47094
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 10:48:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AA1E611ED
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 10:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA1E611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED02D605DE;
	Mon,  7 Jun 2021 10:48:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C0ZH1N0zJxv5; Mon,  7 Jun 2021 10:48:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id A72A9600D1;
	Mon,  7 Jun 2021 10:48:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B949C000D;
	Mon,  7 Jun 2021 10:48:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E5AEC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 10:48:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8BC7D40123
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 10:48:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 07Wm0ZSgSgmP
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 10:48:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A298F4017C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 10:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623062902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jct5jDPBwVGouvEG6T9uxDTmUAeintJpH2Ni5SzlADU=;
 b=Xg70oxEoKxfY7hRgCQxPLZb0GSGGxb8g0f5kIwjRd3DF5oNJnq4SWz/7z3D5E44MiLVQEI
 mWrxPzAVA674IdFx91YwTPm9Pyz2DSXWS0eRNMJ1iS4GEAPSxeg09nCHCvUamHEimdOkZx
 mfaVGBEEbHYmgZ1q1ANzvXusohcRE/k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-PLt_Ll1iOlaE0AxTOlXxJg-1; Mon, 07 Jun 2021 06:48:21 -0400
X-MC-Unique: PLt_Ll1iOlaE0AxTOlXxJg-1
Received: by mail-ed1-f72.google.com with SMTP id
 k25-20020aa7d8d90000b0290392b78ab340so4426187eds.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Jun 2021 03:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jct5jDPBwVGouvEG6T9uxDTmUAeintJpH2Ni5SzlADU=;
 b=OtECJor1xHyKLMj8NWLCELnsMw+zjsIpuzX7kMLJM29ZJOrbsFE+fiOqTJhjVZOKWF
 yzStWo4DzlC6tragNIghBZsBaMH6gBrXW+DiaCHIhQwKR5mqFQt9V/11pIaMLyJHmUi2
 0adjMJmc+aRQY1IJlaAnJQkhOA9iPnbjwLDMgFfjW9JajXEibBIa8i40X/FCxqI4BS5O
 +TjFevcHwU6I9fQKSq2nSY/PmnNooRATt9UtJGuIYW2Tw9cgFgHEvEV2VW50I2CTipWW
 fZRr6ycZLgj2iWKCVUNQ3rgmu1kmZ7i75AnQmn9AsT7b0yK6vGai8Js8QrO5o35G/7kd
 5gTg==
X-Gm-Message-State: AOAM5330eKHHF011A/JmUgqqJDpBSPC+l4O6ZRyzQrDftrx7Zvmf8ipP
 IMAR2LYqMvCcxzv6dRD7ueA5OrQ2VelqAvad7J1bmQKZYbYDOdzr8+1EXhYd7JSrwg5nVKqY0uP
 x0gxRaT5lhfmcp23RrCqpYZke7xsyVvACHlVHS9HhvA==
X-Received: by 2002:a17:906:4483:: with SMTP id
 y3mr12066333ejo.92.1623062900057; 
 Mon, 07 Jun 2021 03:48:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwizncCzZX0wXobce1qloNdamnSpU1qN9Pao+WfbZkPsVt7Cu+4dW5Cnsjng8anwUO8txGDTw==
X-Received: by 2002:a17:906:4483:: with SMTP id
 y3mr12066316ejo.92.1623062899816; 
 Mon, 07 Jun 2021 03:48:19 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id bc4sm7385200edb.63.2021.06.07.03.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jun 2021 03:48:19 -0700 (PDT)
Date: Mon, 7 Jun 2021 12:48:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [MASSMAIL KLMS] Re: [PATCH v10 04/18] af_vsock: implement
 SEQPACKET receive loop
Message-ID: <20210607104816.fgudxa5a6pldkqts@steredhat>
References: <20210520191357.1270473-1-arseny.krasnov@kaspersky.com>
 <20210520191611.1271204-1-arseny.krasnov@kaspersky.com>
 <20210604150638.rmx262k4wjmp2zob@steredhat>
 <93254e99-1cf9-3135-f1c8-d60336bf41b5@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <93254e99-1cf9-3135-f1c8-d60336bf41b5@kaspersky.com>
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

On Fri, Jun 04, 2021 at 09:00:14PM +0300, Arseny Krasnov wrote:
>
>On 04.06.2021 18:06, Stefano Garzarella wrote:
>> On Thu, May 20, 2021 at 10:16:08PM +0300, Arseny Krasnov wrote:
>>> Add receive loop for SEQPACKET. It looks like receive loop for
>>> STREAM, but there are differences:
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
>>> v9 -> v10:
>>> 1) Use 'msg_data_left()' instead of direct access to 'msg_hdr'.
>>>
>>> include/net/af_vsock.h   |  4 +++
>>> net/vmw_vsock/af_vsock.c | 72 +++++++++++++++++++++++++++++++++++++++-
>>> 2 files changed, 75 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>>> index b1c717286993..5175f5a52ce1 100644
>>> --- a/include/net/af_vsock.h
>>> +++ b/include/net/af_vsock.h
>>> @@ -135,6 +135,10 @@ struct vsock_transport {
>>> 	bool (*stream_is_active)(struct vsock_sock *);
>>> 	bool (*stream_allow)(u32 cid, u32 port);
>>>
>>> +	/* SEQ_PACKET. */
>>> +	ssize_t (*seqpacket_dequeue)(struct vsock_sock *vsk, struct msghdr *msg,
>>> +				     int flags, bool *msg_ready);
>>> +
>>> 	/* Notification. */
>>> 	int (*notify_poll_in)(struct vsock_sock *, size_t, bool *);
>>> 	int (*notify_poll_out)(struct vsock_sock *, size_t, bool *);
>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>> index c4f6bfa1e381..aede474343d1 100644
>>> --- a/net/vmw_vsock/af_vsock.c
>>> +++ b/net/vmw_vsock/af_vsock.c
>>> @@ -1974,6 +1974,73 @@ static int __vsock_stream_recvmsg(struct sock *sk, struct msghdr *msg,
>>> 	return err;
>>> }
>>>
>>> +static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
>>> +				     size_t len, int flags)
>>> +{
>>> +	const struct vsock_transport *transport;
>>> +	bool msg_ready;
>>> +	struct vsock_sock *vsk;
>>> +	ssize_t record_len;
>>> +	long timeout;
>>> +	int err = 0;
>>> +	DEFINE_WAIT(wait);
>>> +
>>> +	vsk = vsock_sk(sk);
>>> +	transport = vsk->transport;
>>> +
>>> +	timeout = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
>>> +	msg_ready = false;
>>> +	record_len = 0;
>>> +
>>> +	while (1) {
>>> +		ssize_t fragment_len;
>>> +
>>> +		if (vsock_wait_data(sk, &wait, timeout, NULL, 0) <= 0) {
>>> +			/* In case of any loop break(timeout, signal
>>> +			 * interrupt or shutdown), we report user that
>>> +			 * nothing was copied.
>>> +			 */
>>> +			err = 0;
>> Why we report that nothing was copied?
>>
>> What happen to the bytes already copied in `msg`?
>Seems i need to return result of vsock_wait_data()...

I'm not sure.

My biggest concern is if we reach timeout or get a signal while waiting 
for the other pieces of a message.
I believe that we should not start copying a message if we have not 
received all the fragments. Otherwise we have this problem.

When we are sure that we have all the pieces, then we should copy them 
without interrupting.

IIRC this was done in previous versions.

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
