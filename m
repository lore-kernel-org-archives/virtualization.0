Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7BF25F785
	for <virtualization@lists.linux.dev>; Mon, 23 Jun 2025 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750698121; cv=none; b=C1jhLDmAaqrkNJXlHmHgRZAr7cFoaZ7jt9uO2bUqRXUVwqHQpEIqt53uRDsvXYK/l+2bCr8xRTLJdjsm6VaN/l98RGM1xzV3msTJWwyVldTnIFjvGYB7DhZ5HiDI6/AlH7Z1eIKtWp5Q1iiBEKZfZcmNSZwmwih5WI5Yu1Kpsfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750698121; c=relaxed/simple;
	bh=taqM6M2yCTAkigZXwCzc8+OLPoroFfNThxW7WCtpr+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YWkVOKFjpw9muYbJ1ZLo+ZmVEJQ4sFyjFkCZg8UFr1itG9c0YyypWSUw9h4Xs5an04m5VX5KmfbBCXQd5k3Nz/W5wyhxZMuBR5XyRyMl2j/zBf7ehyY3Fp4i2i7rSL67ViUCbM+wP/wTOyBWWAOGtfp5O4A0Ofy14KDiA+kzLRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i9rsixuM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i9rsixuM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750698119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jq5JtTNSTi3UbB2t2zf1v906mYuPWMRbjCVCINzsyvo=;
	b=i9rsixuMtn6d1NBMY5QUQvZu4B0D2Fp+aNwhbcrqIUIO2FVnAdmSzM346S6cOm+x/sG5bn
	wbODPe8kQVU7xe8lgKqASZfKq5sDS4Izl0OxTOJwpAL9uioMD83rYNaP1qrIegeXuvwCFJ
	wMeuHpctX7RGsQAv1obAHZfLEWD28ZE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-P_qRHCj7MIehJv3iYgQx7w-1; Mon, 23 Jun 2025 13:01:57 -0400
X-MC-Unique: P_qRHCj7MIehJv3iYgQx7w-1
X-Mimecast-MFC-AGG-ID: P_qRHCj7MIehJv3iYgQx7w_1750698115
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a50816ccc6so2757387f8f.1
        for <virtualization@lists.linux.dev>; Mon, 23 Jun 2025 10:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750698115; x=1751302915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jq5JtTNSTi3UbB2t2zf1v906mYuPWMRbjCVCINzsyvo=;
        b=aU3J+5vpqtSTWBcPV4NJ4RSoixNPKdX12KUFQPiNkt0cV1uKxn6xPWg2JGAZ25Zs+c
         +j+khemjllkgC7WB9mRumtkz9DsCFKpQGkABA7uFIhOy7JfDFA6ViwaTjm6fwVqhxO8n
         5kaAz1ZYG8Kf7BhLdO33/RQN5eLYFOiz52q3OyiWSDE5cX2FL1REPWsKQ++WY3rz5JUh
         yYCyeQNLr4pSMIcUSlLWdhYZIYhmFt6qjqfKBaXeVbjYBNGSB+4X88LCmA7LkOfKD57s
         G7o6Q/7jG2oUVbG//t1ljGtp2FZDXHVZKRwHj4KhuIHp9qT2NlZuHxYfULW6mbzv63+H
         DFag==
X-Forwarded-Encrypted: i=1; AJvYcCX/EvTZE3vB3tqRjzIhHAlWHm73lhV+vlxQanw+KCtztx3ITL9ARnbF1ISsKclY7ZMOUQof1ERLiuwofyMftw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhkoE5dbsxmPurh2PTxDA71VrdIHX7UjnpJbvBAKKD3C9RzWmr
	NZab9Wvk5TemGKJEkhepHx9Xb3cCrqVsdmSTkmeNPoO1GIBKYE8EC/BPwUYSiupIf/7yNpZx0N+
	j9mynBe9zjuMMlujhbs6/WsfrxxoWVJChZezHx9eLhYCeGXTAa9GNgfw/I5SLl+Vw8kPd
X-Gm-Gg: ASbGncvDk/v5Mbi/KCGZLWUnNy5JqHE9zRWgyl2em/U4iqS8PpaQPOYofRyfyugUM/M
	F/C1Y/cw2eljHE1Pb5GAD3RxQo6MuTgo0ZGCx6KPJPAPcOXZVyxpCfESUJaQP2JKqo3xlpMqy8Z
	7FBfa06xAAjRu29LijNPSeRgnNH3/4cfNtoMslGvpzQJ4dunj7cRsb0dwDMpWL39omtJJbQXfle
	0EoreJBqXL5ZMpZRwc5/82gB1HNkntb4MsPVd/fjNEKQtU/zAFCUFk/1+LVsciWPkDL9NIwmRbU
	VhBft5LuNM9OA8YgwrlWoAHgYvo=
X-Received: by 2002:a05:6000:288d:b0:3a5:8905:2dd9 with SMTP id ffacd0b85a97d-3a6d1331316mr11150048f8f.51.1750698114874;
        Mon, 23 Jun 2025 10:01:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgLc1G5fHA+5OCdohy+RX20t3SZJ3zi/U76KcD2RoeCTL1jtFDfjcLkndhINDFJCXPqEyFPQ==
X-Received: by 2002:a05:6000:288d:b0:3a5:8905:2dd9 with SMTP id ffacd0b85a97d-3a6d1331316mr11149981f8f.51.1750698114073;
        Mon, 23 Jun 2025 10:01:54 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.144.60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f10411sm9667235f8f.1.2025.06.23.10.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 10:01:53 -0700 (PDT)
Date: Mon, 23 Jun 2025 19:01:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: davem@davemloft.net, decui@microsoft.com, fupan.lfp@antgroup.com, 
	haiyangz@microsoft.com, jasowang@redhat.com, kvm@vger.kernel.org, kys@microsoft.com, 
	leonardi@redhat.com, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mst@redhat.com, netdev@vger.kernel.org, niuxuewei.nxw@antgroup.com, 
	pabeni@redhat.com, stefanha@redhat.com, virtualization@lists.linux.dev, 
	wei.liu@kernel.org, xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net-next v3 1/3] vsock: Add support for SIOCINQ ioctl
Message-ID: <opt6smgzc7evwrme7mulwyqute6enx2hq2vjfjksroz2gzzeir@sy6be73mwnsu>
References: <y465uw5phymt3gbgdxsxlopeyhcbbherjri6b6etl64qhsc4ud@vc2c45mo5zxw>
 <20250622135910.1555285-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250622135910.1555285-1-niuxuewei.nxw@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tcEpJNSCVGE-4o9t3lXqWPh6Eh6hq-lY3Uhfgn_00Nw_1750698115
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sun, Jun 22, 2025 at 09:59:10PM +0800, Xuewei Niu wrote:
>> ACCin hyper-v maintainers and list since I have a question about hyperv
>> transport.
>>
>> On Tue, Jun 17, 2025 at 12:53:44PM +0800, Xuewei Niu wrote:
>> >Add support for SIOCINQ ioctl, indicating the length of bytes unread in the
>> >socket. The value is obtained from `vsock_stream_has_data()`.
>> >
>> >Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>> >---
>> > net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++++++++
>> > 1 file changed, 22 insertions(+)
>> >
>> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> >index 2e7a3034e965..bae6b89bb5fb 100644
>> >--- a/net/vmw_vsock/af_vsock.c
>> >+++ b/net/vmw_vsock/af_vsock.c
>> >@@ -1389,6 +1389,28 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
>> > 	vsk = vsock_sk(sk);
>> >
>> > 	switch (cmd) {
>> >+	case SIOCINQ: {
>> >+		ssize_t n_bytes;
>> >+
>> >+		if (!vsk->transport) {
>> >+			ret = -EOPNOTSUPP;
>> >+			break;
>> >+		}
>> >+
>> >+		if (sock_type_connectible(sk->sk_type) &&
>> >+		    sk->sk_state == TCP_LISTEN) {
>> >+			ret = -EINVAL;
>> >+			break;
>> >+		}
>> >+
>> >+		n_bytes = vsock_stream_has_data(vsk);
>>
>> Now looks better to me, I just checked transports: vmci and virtio/vhost
>> returns what we want, but for hyperv we have:
>>
>> 	static s64 hvs_stream_has_data(struct vsock_sock *vsk)
>> 	{
>> 		struct hvsock *hvs = vsk->trans;
>> 		s64 ret;
>>
>> 		if (hvs->recv_data_len > 0)
>> 			return 1;
>>
>> @Hyper-v maintainers: do you know why we don't return `recv_data_len`?
>> Do you think we can do that to support this new feature?
>
>Hi Hyper-v maintainers, could you please take a look at this?
>
>Hi Stefano, if no response, can I fix this issue in the next version?

Yep, but let's wait a little bit more.

In that case, please do it in a separate patch (same series is fine) 
that we can easily revert/fix if they will find issues later.

Thanks,
Stefano

>
>Thanks,
>Xuewei
>
>> Thanks,
>> Stefano
>>
>> >+		if (n_bytes < 0) {
>> >+			ret = n_bytes;
>> >+			break;
>> >+		}
>> >+		ret = put_user(n_bytes, arg);
>> >+		break;
>> >+	}
>> > 	case SIOCOUTQ: {
>> > 		ssize_t n_bytes;
>> >
>> >--
>> >2.34.1
>> >
>

