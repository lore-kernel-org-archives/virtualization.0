Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD4A3FBEC9
	for <virtualization@lists.linux.dev>; Thu,  9 Jul 2026 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588686; cv=none; b=KkY+HTjve7v7Xx2BlzXDmYlUgAJ766SnNX6GLawRCs1HJJO7/MnMbg7+JYi8NTymzUver58J7IeVYM85W0JL0pE/RiikFyEOtM3r2Kb2Pqgj/Zq7IyY689vVrjtmWKE/PzODqqQTF0rxA7ydRN4vPRYaX8qB4gxKRekIr10xO/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588686; c=relaxed/simple;
	bh=FjpUXsvhXEAkUlVQP4tEH1Ee2iSdcpYkelan5p5vzPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tgFH/+y/OuIwDJeq1sekrcjWDz0buCL1SQhfuWACAT1Qda7CskVhtV1+66IybJX9kMyXzbjsie6rpU/aUhBFol9Q3i4MbhK0hPf+NKlKGDQLimF8vcHz1QA6EFE7urVuFJ7K7vRLpD+CE77y7mB+JsX0Ao26OBlo2d3gkn82BYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0C8P9f4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0C8P9f4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783588684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lcgAW3wWwD+CDc95tyrJwQ6t0jD3GIhvTCB6YDG1NyM=;
	b=F0C8P9f4PCpYe67uxZ2dquAVNhcBCKlBshRLmIblMnlq7VjR6m9MjHAiiQiKTNTqaH0itS
	CCByddcGbZkU4OQkPrs88JSfV689igPe8TunaZmTdiFSyQflvrnOiTicQ0LEenhECHwmYc
	Fghza4DH9JOfapbjALd1TQ3yJF5/dNk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-jZIgTfzNNt-50yN3JbdzHQ-1; Thu, 09 Jul 2026 05:18:00 -0400
X-MC-Unique: jZIgTfzNNt-50yN3JbdzHQ-1
X-Mimecast-MFC-AGG-ID: jZIgTfzNNt-50yN3JbdzHQ_1783588679
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-474170b59dfso1094259f8f.3
        for <virtualization@lists.linux.dev>; Thu, 09 Jul 2026 02:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783588679; x=1784193479;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lcgAW3wWwD+CDc95tyrJwQ6t0jD3GIhvTCB6YDG1NyM=;
        b=SywWxs98KLTSrLKBQSzGihTsvwtle4Ay99ieBMKd6vTxSOzFJBy5KfzIykXP0k8fJ8
         f3GW4zPTdhJ/2o1EF9zVF9mFBvjIWxK/CBQ2ZlyDfkLvQFvgtifJYoPfvy1ORdbluwJs
         1+zQSap9Euf6Jr7TpnjQgROzGCTksI+cTTCIPO5dKCRImO1JUzrslk3otFRD6Sp7Ydns
         lgIHeSTDxTjMTg2+o7OJsdq8P+Al2yaXe1KowAvbb7x8GaclxNS05055Rv0vO0BKoa3o
         Mtu0qq8EIcOhZEzGpNOqtaCDUHUN0YvjAZtU5HqfDMMCs20p4O1Er4sXyF40pR3W1vyC
         ZZXA==
X-Forwarded-Encrypted: i=1; AHgh+RojG3Lf7slsuN76j5CfGkUIBRS2qUn9zs5dteXuIvvuzozp0l1GcR8Ou4MAlOLcaOoLkGoxuVjWt2bHWA4C8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjJeBdqyG477KJgBcdhW7nO75DYfLKw3Ght22+pj8/s81gDITD
	RCquPeMX5rNoGqkXlub4qS5TOSSTw4gbtKs7O2MaeFVtfK4NLYFKSUXzpOmbdupB3OPvdo3yjZ1
	TwKiFXSo05Dyyr6i21Pbx3xkeaHInWbM0RUtdELGLRshpQ4BLM7GWs62dTBK7iF0copm8
X-Gm-Gg: AfdE7ckq6cpoLvQaXmvcavWqTfwh6o8MSgAC5THTUeQAdMgOhdSt2q++isvVvwKy1fY
	lpSeSeMayNmmDT7+DNn85inEeKSw+GmGHur7H29WKTMLahmC7pA1CNiIyxnlMbh1/NtSLNA8NCO
	ZecDnY9qe9orX9zl3sHijhlTr6Y58VP0tSlule+4ZmBQquZcKVk8WjmSXUwhyNJWEdlfAt0R7nh
	ahI4ZZnZAHePy0viVI6M7Snq8SAzS+555OOlaybApoSNXdnEVv3LKaFFtY4nxNlLFsYDUGjR+9y
	e2EYV2Xk0h95VLQCCoc+Ds3zHu+ZEIoxo2W30JH+9a+So3gwMziqV3DpGOeaOwmqEkw1YrVrlcD
	6v5Uw2E24DXZHUpdObH9DBJxb+TuUippye+EKeok2zDBUpRQ/YB5UvrJdP4Zk
X-Received: by 2002:a05:6000:1a85:b0:460:1223:a044 with SMTP id ffacd0b85a97d-47df06c10c9mr6983275f8f.0.1783588679370;
        Thu, 09 Jul 2026 02:17:59 -0700 (PDT)
X-Received: by 2002:a05:6000:1a85:b0:460:1223:a044 with SMTP id ffacd0b85a97d-47df06c10c9mr6983241f8f.0.1783588678905;
        Thu, 09 Jul 2026 02:17:58 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d910sm48486557f8f.6.2026.07.09.02.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:17:58 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:17:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowangio@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	virtualization@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>, 
	Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net v2 2/2] vsock/test: add test for small packets under
 pressure
Message-ID: <ak9h1kWcLmpP74PI@sgarzare-redhat>
References: <20260708102904.50732-1-sgarzare@redhat.com>
 <20260708102904.50732-3-sgarzare@redhat.com>
 <20260708065853-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260708065853-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3T1z2JAYXPYpKukRfGOjVSP1z-oHvzMDAZ24ff00d2s_1783588679
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jul 08, 2026 at 06:59:41AM -0400, Michael S. Tsirkin wrote:
>On Wed, Jul 08, 2026 at 12:29:04PM +0200, Stefano Garzarella wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> Add a test that sends 2 MB of data using randomly sized small packets
>> (129-512 bytes) over a SOCK_STREAM connection. Packets above
>> GOOD_COPY_LEN (128) bypass the in-place coalescing in recv_enqueue(),
>> forcing each one into its own skb.
>>
>> Without receive queue collapsing, the per-skb overhead eventually
>> exceeds buf_alloc and the connection is reset. The test verifies
>> that all data arrives and that content integrity is preserved.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>maybe cut down SO_VM_SOCKETS_BUFFER_SIZE? will make it easier to
>trigger?

Currently, with the default value, the trigger is practically immediate 
for packets between 129 and 512 bytes, but yes, a smaller buffer size 
certainly makes this effect even more pronounced.

>
>anyway
>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks!

If I need to post a v3, I'll add it; otherwise, I guess we can leave it 
as is or send a follow-up for net-next.

Thanks,
Stefano

