Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966B9314A87
	for <virtualization@lists.linux-foundation.org>; Tue, 25 Nov 2025 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764068650; cv=none; b=DVHEvlyJSd+Vklc0Du283ojetKLpOIukP+yUnp76YSMyf44ntuRg48qMZHOjnWnKVOdnUA4fZHi1F95FWGEoxq7I/7V1CATgEbr5OL65jdVOw4LbveHgC4t1lWUnWib5TtNJkTs4aC/KCa7sc+mHEPftZVUcrspOlj73MNqlF4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764068650; c=relaxed/simple;
	bh=iXKpiuNQlb6X68ZweO+BOUjOZ+bKXmHmii0jmBG3APg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9JM5J+ijiP3fuzibIvTY7XlRiuoN8CI+25jrLE6jdCrjFIFP4GymLDvyDfskzWpKKkWFP6MfKdyco54U7j71dUb6V31e6crnBBOe6Aaboi+zCL2CSkwObynhxdeLy9oNfRSCsqXkOGEMJ0Ov1bERRMcT3f3JggJuHHEnCmVKok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GlfFe7j5; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GlfFe7j5"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F0A66089F
	for <virtualization@lists.linux-foundation.org>; Tue, 25 Nov 2025 11:04:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.795
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CJuJacYF3Zjr for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Nov 2025 11:04:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F23366083A
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F23366083A
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GlfFe7j5
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F23366083A
	for <virtualization@lists.linux-foundation.org>; Tue, 25 Nov 2025 11:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764068641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2jX8nyV/wRTc5eESPtXjGF1WJi21h6fkrbY07+2SJ7E=;
	b=GlfFe7j5djGvVcy5VW0Sui70GxQPjxkbErEyTM+pumYgABPILRXlWSeBeoHN2gJKQGAa+C
	4vwIBqPBMo2s8VRLvCrqeTx4z1Lkc7U8pjvqvXTOSXdgylAuuRRKyEmdp2hsQIDIudkel/
	CtKD5XVscwEXji6USgdHSaeDS1ebf4c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-0E-C0pqhOreHOpr9AGU_CA-1; Tue, 25 Nov 2025 06:04:00 -0500
X-MC-Unique: 0E-C0pqhOreHOpr9AGU_CA-1
X-Mimecast-MFC-AGG-ID: 0E-C0pqhOreHOpr9AGU_CA_1764068639
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b2c8fb84fso2852356f8f.2
        for <virtualization@lists.linux-foundation.org>; Tue, 25 Nov 2025 03:03:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764068639; x=1764673439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2jX8nyV/wRTc5eESPtXjGF1WJi21h6fkrbY07+2SJ7E=;
        b=tiwQ20W4OOuQNr3475P2SptgGC/SdjBkE4OS4taCOIDi1uxD8OE+AVWi/HMPUI4SQH
         OUPua/KA0NqscgbEdaxX8QxdMgj3KQdzSN6QV+0rU9FwyeD/vm0llZDc/DqBHfDiNoA7
         W17ERdN7HfspexW1eja/u0mC/y1T81O4l05Pje7pkR7OfVV6Yqb2WtGjr3YWKChLlBYO
         pEeZ+NcMrJ0Gff7iFSHM1yfZQOC3YYExt9rWqR1ZgnC/EQr+CzPPlZ1ERrOnGzeDmZb+
         q7gXMYP8ssI+V7w+2nWLUtRHSMeSMo27DdpKrPrdAdmyxsWo0GKMMIwX5Jkcb03pxkkC
         iQAw==
X-Forwarded-Encrypted: i=1; AJvYcCXPAhfEzbu+li83meLXz3KreImZpLlZmFX6JUPl3yKaHLvDwrujiysxRyfbWm9JeEIhHKKjaVc+eb57cs5rrQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzCxmmjtbxXMCbShO8OonWJZ7/xU21b0Y6W+AbEQTYA7Bk8HbHO
	mLauZNa+tNDFwmsiTR25EI7rqvrrLXyHyVavlGEe29Mrogt7c4BAxfYVzVIUUvGS6xkHWKo0F0I
	5VNMi05wvqub2nz2nb+7XzyCSdGB8ldp46keL2kGTdEhII2YN7sWWH3SyYiAkiy41AhUJ3tY8+2
	OLxSUdqnM=
X-Gm-Gg: ASbGncsQEa69pMNzVS933iLyuDmPqFTLQbBAHfelq6w3irGiDPZXy5IwAzzE19fWMbH
	bj9O3fKKGNP2VklP54HYvRQZtOYDWYT6yNdz3Zz6E7HAnL7rJmIIXRnAtE04jjHM4sjYCARGNOL
	KbRzEuHVX2qyCdKiOSQayTkeYseGVYnb4GHw5n/fyxqCFGjQfM3teEVN1eRZ+89+qmLqNI0K54E
	4uuRugJa5aAz7bw0VvVVDBGreoS49IMAjIFwjcrpSt2WVM1yHvdR6DNoi1522i0bkgErRbsjie7
	wMcJTpfysQwJzAZYWON+9ogvYLKEER8O3HiXyIwNyaFGWywwfA6NHdHzT86yueUqhwmEcQJy+EQ
	V0gJeg0CTxYfBbA==
X-Received: by 2002:a05:600c:1547:b0:46f:d682:3c3d with SMTP id 5b1f17b1804b1-47904adff1cmr19046385e9.13.1764068638814;
        Tue, 25 Nov 2025 03:03:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoT6Pfw7CHSt37IswgwvDmurDiD6Zw/XOCayfoPPARGoD0QI10X//Yl97sd3GIIuQ+9cHtCg==
X-Received: by 2002:a05:600c:1547:b0:46f:d682:3c3d with SMTP id 5b1f17b1804b1-47904adff1cmr19046025e9.13.1764068638268;
        Tue, 25 Nov 2025 03:03:58 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf22ea00sm246531145e9.14.2025.11.25.03.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 03:03:55 -0800 (PST)
Message-ID: <323a8b07-6df3-4cc4-960a-994649fb03e3@redhat.com>
Date: Tue, 25 Nov 2025 12:03:54 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio_net: enhance wake/stop tx queue statistics
 accounting
To: liming.wu@jaguarmicro.com, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, angus.chen@jaguarmicro.com
References: <20251120015320.1418-1-liming.wu@jaguarmicro.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251120015320.1418-1-liming.wu@jaguarmicro.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7N3VtgLUvGmB1ce5cVSnsPjbN_atdVJulTdImNl8tyA_1764068639
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/25 2:53 AM, liming.wu@jaguarmicro.com wrote:
> @@ -3521,6 +3526,9 @@ static void virtnet_tx_pause(struct virtnet_info *vi, struct send_queue *sq)
>  
>  	/* Prevent the upper layer from trying to send packets. */
>  	netif_stop_subqueue(vi->dev, qindex);
> +	u64_stats_update_begin(&sq->stats.syncp);
> +	u64_stats_inc(&sq->stats.stop);
> +	u64_stats_update_end(&sq->stats.syncp);

Minor non blocking nit: possibly use an helper even for this increment.

@Michael, Jason, Xuan, Eugenio: looks good?

Thanks,

Paolo

