Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5671A9FAA
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775551546; cv=none; b=e01WWZF8/P3HXwoXRSg0Nyfvoo3hxT5w5YI6/BcfSniiMzDSBoIr92apPWSgFWbjWWMJ6GAhaVKyxaUET3yfpgkJiLzZlAETTdnbePlN6tMoBvSVgkiKB4hYack76rnKnD3dUHyyE4Bh8MNIbBlz9NkqsmZZgSXrRGgSiZGU30E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775551546; c=relaxed/simple;
	bh=z7XMqNzqbaQp3YVbNCSinxYvK5mXLBbHoHlDC+DisRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SIDsmDc/DbQ/EQTODsNG313xg/YZBtwSvokgRZ0qENZuz5o5z5sWlfG5dlHrcxmR0O5QYShE6XLF58tvOej9/vi2BEJBBJO415xuCUEC0tbf3efAbimDzeJCUrw25qLWk05fIdVeML/JQA9SclE3yB424AgDgARt5eQXmUz4jQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EpR1qZte; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EpR1qZte"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775551543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=90Dv0Gfd1H3V0FF0ZZTa8jkFYwFCJbiDQpupdqGKTx4=;
	b=EpR1qZteUq0PYnuTPxMkc2pRa/PE3v+B0+5AA5VsvPDV1M7BVAfGGxUf9xe19UQ36gUl0X
	VBENqumC1/GDdQKSmWPsCxVMlGXlwi0gsB0xBmO9zFGq1U69uWWN/De57Qz8IQPZ9y+Kwc
	QAOUVSQyyNI362Hc73Jpxvv1nCSXPjg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-A_EKEtPkNBKypdtkU4nGWA-1; Tue, 07 Apr 2026 04:45:42 -0400
X-MC-Unique: A_EKEtPkNBKypdtkU4nGWA-1
X-Mimecast-MFC-AGG-ID: A_EKEtPkNBKypdtkU4nGWA_1775551542
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488b6feb9beso6483825e9.3
        for <virtualization@lists.linux.dev>; Tue, 07 Apr 2026 01:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775551541; x=1776156341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90Dv0Gfd1H3V0FF0ZZTa8jkFYwFCJbiDQpupdqGKTx4=;
        b=YXti5+j9A6YrqePEnUp5OBw6FO7dOBNlzfLlzAwxsK4WOaDQbIGcDXEHoIiVELBzWG
         3ctwc152P4gNhbexT3YsozjMdj5S5WLlz4HUPYwTw7+hsKP/zCrEPpdFYPcmDRsaEyqG
         CZUYd0k8EVEduv+7kzRLdvSmkocNKTutKoLs0WhCEipU27cxKjQd7siBudFmx6GV+Dg0
         9ePrrBS3OhyZnn0zIgP3VNYC5DNfAC5bSKSXb+1T6zpgvzcT13Gbr8V9/UJMEkbYkgq6
         IZ5Oxd1a1/or4kaHl/r7XOH9fHplacrv/2M1ZU1eUBlaDmeNi9mBFH9B2Q3atFaraa0e
         aiMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ+3PgMSIrbODI0Dce607bcgLf06nkTahJuoEeTUJ4aqCGT7frZP8jvKjFPaLuaNQoNSkRRVXIPPQgZhSFOg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLw4bIS9p46eJby72nstXDb03xVb0nAcQUaYmFw0dN3ALV1u5O
	osy+0axqWc5PRFvr+jeoXjeIcmldYCyb7lJIICdI0ebFfGspr11mRHAaC/p8tsoSn45r1/K/ti6
	exXvA5cR+SclC/LufznR9/mRGu2oCZw12YzB/BDwGfENuEj9KGEZB6e7JXVy+RVfCdXHY
X-Gm-Gg: AeBDietfS6TtmKYeD/e4HGKFeMRTdK6IB12eZwUt5pa/RiGKNblPvrzFypK53x6MdkK
	V+jxJFQs+KbswRM6K25lQkxEYuV7zmmS4o1ZGW/UyAxWp5PBL7B3FWM/Y81lf6TFpqpvVeiRAk+
	FFaoDe0ciLc7lI1GP0jVv7GKYVX4wfaC0n5mdLMlukIkrv2lJL8kVt2xvqJ7a6Y+sSuIP+xIMv9
	DB9xYcAPQD3J7Y4gBEpg3LukMBl3fcy3w2ZUUMSp6OTzEFja1QAVSbbOy+9WvmsxZfrRLeaR/Q9
	9EwF8/CJ92Xqq/6xBBYiLuiutr1JPI7VYssBbujyr18G3fLXln8QTUhTYKNSseT7nL9V9zAc7G/
	MgBg5If+oApLNFFJR7a2+hHBCxW0=
X-Received: by 2002:a05:600c:4f15:b0:488:945a:ed63 with SMTP id 5b1f17b1804b1-488995cbaa7mr243063785e9.0.1775551541499;
        Tue, 07 Apr 2026 01:45:41 -0700 (PDT)
X-Received: by 2002:a05:600c:4f15:b0:488:945a:ed63 with SMTP id 5b1f17b1804b1-488995cbaa7mr243063245e9.0.1775551541043;
        Tue, 07 Apr 2026 01:45:41 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a7165aasm527048625e9.14.2026.04.07.01.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 01:45:40 -0700 (PDT)
Date: Tue, 7 Apr 2026 10:45:37 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] vsock/test: add MSG_PEEK after partial recv test
Message-ID: <adTEDKJZklJgdcop@leonardi-redhat>
References: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
 <20260402-fix_peek-v1-2-ad274fcef77b@redhat.com>
 <2521971f-798d-4560-b2d8-bb540591d4b1@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2521971f-798d-4560-b2d8-bb540591d4b1@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FhrPGOMlQeWq1GodgSHj760kTc-gaY4HX_gZE-d1tXc_1775551542
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi Arseniy,

On Sun, Apr 05, 2026 at 10:14:26PM +0300, Arseniy Krasnov wrote:
>
>
>02.04.2026 11:18, Luigi Leonardi wrote:
>> Add a test that verifies MSG_PEEK works correctly after a partial
>> recv().
>>
>> This is to test a bug that was present in the `virtio_transport_stream_do_peek()`
>> when computing the number of bytes to copy: After a partial read, the
>> peek function didn't take into consideration the number of bytes that
>> were already read. So peeking the whole buffer would cause a out-of-bounds read,
>> that resulted in a -EFAULT.
>>
>> This test does exactly this: do a partial recv on a buffer, then try to
>> peek the whole buffer content.
>>
>> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>> ---
>>  tools/testing/vsock/vsock_test.c | 64 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 64 insertions(+)
>>
>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>> index 5bd20ccd9335caafe68e8b7a5d02a4deb3d2deec..308f9f8f30d22bec5aaa282356e400d8438fe321 100644
>> --- a/tools/testing/vsock/vsock_test.c
>> +++ b/tools/testing/vsock/vsock_test.c
>> @@ -346,6 +346,65 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
>>  	return test_msg_peek_server(opts, false);
>>  }
>>
>> +#define PEEK_AFTER_RECV_LEN 100
>
>Hi, may be we can just reuse MSG_PEEK_BUF_LEN which was already used in MSG_PEEK tests ?
>

yep, good idea!

Thanks!

