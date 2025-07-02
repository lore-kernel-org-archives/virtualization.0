Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6136423D2B8
	for <virtualization@lists.linux.dev>; Wed,  2 Jul 2025 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450723; cv=none; b=p8Mef8N5rYgu+5vdHmg9g1Hmep37pEotA7UQOIvuRvfSbi3+7Xf72sH1pX89Ac1iwQg4lUvlxJEQtryQJRfTq3LYlHbPDOI/ZgBxyUgBZOXWtTAWSjwcdpt352fCLZX0+I0pZfqi+r27vAvpt1+MLUcpoag6hjnZB7+d90AoWMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450723; c=relaxed/simple;
	bh=BZYRZ5TFWTzUNC3kGwjRxau2NjTbkYh6g4ciUE81fiA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rRfPND9ghT88Y+ph547ksGjEpvFNFtCXzIQsbqbS4nrBUQFSR491xRR7xSGgwVd3vKLhbB0+egJf34Xzy7WO3+Z8y3EuXByNupGhNVXtauFg5GM5OC+iX9Er8qZz27IEEjn/CZ5uJbyzR5CtWA3ZtZ1RhOvCmZTUQc5+0SpGjVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IszyaG+N; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IszyaG+N"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-748d982e92cso5018457b3a.1
        for <virtualization@lists.linux.dev>; Wed, 02 Jul 2025 03:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751450722; x=1752055522; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1APMQxBHqNTDFKhYsPJPgE3N0Q/GtKtTrkho+3f+8U=;
        b=IszyaG+NEhMQq22++JfyALckKLDybR9Z2RQ0LsMElRew60rx209lu3xnxB9E7AUqK0
         cIO7hxLHvJnbADg+Xkn0uWUdk/mG8V1YvNjBfALPTvWwHqzJQ//yfkQnq+ugo1/avsZQ
         KVo+z/Hz2uCuWzdf7/YdiE69gLwc3sGHQ6pZSpHXH/JHQ/1OwX1WBcUs5zbM/utJYa34
         3LoaMcDAm8aZdoCRO6t3LQooN2IBgwIRaexcZxJ0SRW+ZsFQyhhnZtz3xGMnKf5nJmy1
         fIOQqnUj9EumaRDlwNlUpOKQ6ICih1aZYYFWSCu5IVi5PrG9iAjdJSzNUZLCuHMEBO+p
         I5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751450722; x=1752055522;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1APMQxBHqNTDFKhYsPJPgE3N0Q/GtKtTrkho+3f+8U=;
        b=V5gj8nQhL6a5T+JQAlHbS1GRLXRipqao6Qn0fkorMx3ihx7Ur7eI/dc/OLaQ3ZKrCF
         GMi7LE05Tiy2uWD49xdye6SFCsebDN3OGhnXSZthB6+fl5tHTQR+2jJm2fyee2xwJDAK
         p6ez250JFyKk8LMXaf4D0FgT7PfdvZYX3n0W4GhoLAdy+W/sAqODigoT2TMXv22U2DWV
         7u1a3DxYY7JiT5adyBQgp1wFzOxvZY+56Whq/SYhehPrlkYdghCVEI2V0Mayzv7pGLU5
         mGJ2trIdGKAwljG3I+3Iv4KugS+KCito+HA3XlArAyVS4Tfv5HcvVl+Mtk6WvNqT3s7j
         lwoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAWK5jiO4TxFMKmFdiC8eHHxLAqoRu3+kPrPxFw9j5tOoksH8VqPJE77rAnLiu5CSdUggesSfTvvawESBHuA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2b+yKh6nTXg0XaAkAP6Z8WHMwbUhkY7S5URykxE2PYxL7jMcZ
	mJ5nYvhEVJvRzxUC3Ur1zM8dBUB94wTVkNPJbWU9ztsDTNCjeik7M0sA
X-Gm-Gg: ASbGncs4Gmcse6os7pMZt1L8CvDr5qqMSOUUxBTmbfw3DaIDEj712tykHLaoysFjMMA
	PZ/6ntXHaQg4lFV7AAIs4C/qEv4N+IKv78Bwu5ACHoNi1tSCGCp7J1ulSCTtah7GCEPlI/AAVPC
	tTlk7A86i1mbM+ivLHvIcyexqZ3uilT65eBELdMumghL52VvSmaVfSehEe3yQJwHnZw3+2ELxt+
	5zP/+7NMSJBZt759K9bGmIQ2fHnpvCQ3JmtlhmxQRor/TqYot6T/nOWPsMBmY+KC9eZNuAkS9CJ
	HEWEqrEnNiC3Ai1rmDHwQsfrsXW0r/NcsUTpGtAiBz4N4u1ekll7Ed1OinLZt3LXiSjVnOA=
X-Google-Smtp-Source: AGHT+IFWOp01aw0H2f+dLbLSHH5rCRbGt+ICBReE5quNPSyRzZo0OhEWZTb45SRGcAxR8wdlx3Dh8Q==
X-Received: by 2002:a05:6a00:1411:b0:747:b043:41e5 with SMTP id d2e1a72fcca58-74b5126b4f3mr2992134b3a.16.1751450721399;
        Wed, 02 Jul 2025 03:05:21 -0700 (PDT)
Received: from smtpclient.apple ([23.132.124.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57ef4dbsm14257833b3a.160.2025.07.02.03.05.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jul 2025 03:05:20 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [RESEND PATCH net-next v4 2/4] hv_sock: Return the readable bytes
 in hvs_stream_has_data()
From: Xuewei Niu <niuxuewei97@gmail.com>
In-Reply-To: <mofyjvpvlrh75sfu7c7pi4ea6p5nkatkqqtnwpwne7uuhhl5ms@gaqcs3m6i6kx>
Date: Wed, 2 Jul 2025 18:05:03 +0800
Cc: mst@redhat.com,
 pabeni@redhat.com,
 jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com,
 davem@davemloft.net,
 netdev@vger.kernel.org,
 stefanha@redhat.com,
 leonardi@redhat.com,
 decui@microsoft.com,
 virtualization@lists.linux.dev,
 kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 fupan.lfp@antgroup.com,
 Xuewei Niu <niuxuewei.nxw@antgroup.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FDB4EF2E-60B4-4264-9F7F-3AA14A60F119@gmail.com>
References: <20250630075727.210462-1-niuxuewei.nxw@antgroup.com>
 <20250630075727.210462-3-niuxuewei.nxw@antgroup.com>
 <mofyjvpvlrh75sfu7c7pi4ea6p5nkatkqqtnwpwne7uuhhl5ms@gaqcs3m6i6kx>
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> On Jul 2, 2025, at 17:58, Stefano Garzarella <sgarzare@redhat.com> =
wrote:
>=20
> On Mon, Jun 30, 2025 at 03:57:25PM +0800, Xuewei Niu wrote:
>=20
> IMO here you should not reset the author to you, but you should keep
> Dexuan as authour of this patch.

Well, I did that. However, `./scripts/checkpatch.pl` is unhappy wihtout =
my SOB.
Perhaps I should ignore it, and will do in the next :) =20

>=20
>> When hv_sock was originally added, __vsock_stream_recvmsg() and
>> vsock_stream_has_data() actually only needed to know whether there
>> is any readable data or not, so hvs_stream_has_data() was written to
>> return 1 or 0 for simplicity.
>>=20
>> However, now hvs_stream_has_data() should return the readable bytes
>> because vsock_data_ready() -> vsock_stream_has_data() needs to know =
the
>> actual bytes rather than a boolean value of 1 or 0.
>>=20
>> The SIOCINQ ioctl support also needs hvs_stream_has_data() to return
>> the readable bytes.
>>=20
>> Let hvs_stream_has_data() return the readable bytes of the payload in
>> the next host-to-guest VMBus hv_sock packet.
>>=20
>> Note: there may be multpile incoming hv_sock packets pending in the
>> VMBus channel's ringbuffer, but so far there is not a VMBus API that
>> allows us to know all the readable bytes in total without reading and
>> caching the payload of the multiple packets, so let's just return the
>> readable bytes of the next single packet. In the future, we'll either
>> add a VMBus API that allows us to know the total readable bytes =
without
>> touching the data in the ringbuffer, or the hv_sock driver needs to
>> understand the VMBus packet format and parse the packets directly.
>>=20
>> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>> Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>> ---
>> net/vmw_vsock/hyperv_transport.c | 16 +++++++++++++---
>> 1 file changed, 13 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/net/vmw_vsock/hyperv_transport.c =
b/net/vmw_vsock/hyperv_transport.c
>> index 31342ab502b4..64f1290a9ae7 100644
>> --- a/net/vmw_vsock/hyperv_transport.c
>> +++ b/net/vmw_vsock/hyperv_transport.c
>> @@ -694,15 +694,25 @@ static ssize_t hvs_stream_enqueue(struct =
vsock_sock *vsk, struct msghdr *msg,
>> static s64 hvs_stream_has_data(struct vsock_sock *vsk)
>> {
>> 	struct hvsock *hvs =3D vsk->trans;
>> +	bool need_refill =3D !hvs->recv_desc;
>=20
> For v5 remember to fix this as Paolo suggested. Dexuan proposed a fix =
on his thread.

Will do. And big thanks to Dexuan for the great work.

Thanks,
Xuewei

> Stefano
>=20
>> 	s64 ret;
>>=20
>> 	if (hvs->recv_data_len > 0)
>> -		return 1;
>> +		return hvs->recv_data_len;
>>=20
>> 	switch (hvs_channel_readable_payload(hvs->chan)) {
>> 	case 1:
>> -		ret =3D 1;
>> -		break;
>> +		if (!need_refill)
>> +			return -EIO;
>> +
>> +		hvs->recv_desc =3D hv_pkt_iter_first(hvs->chan);
>> +		if (!hvs->recv_desc)
>> +			return -ENOBUFS;
>> +
>> +		ret =3D hvs_update_recv_data(hvs);
>> +		if (ret)
>> +			return ret;
>> +		return hvs->recv_data_len;
>> 	case 0:
>> 		vsk->peer_shutdown |=3D SEND_SHUTDOWN;
>> 		ret =3D 0;
>> --=20
>> 2.34.1
>>=20
>=20

