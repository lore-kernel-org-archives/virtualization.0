Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3271DD523
	for <virtualization@lists.linux.dev>; Thu, 17 Oct 2024 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172587; cv=none; b=c/i+Ag3s4qCrArci3+PJ6P3HULd0zDqPYYhlkYH8ePQmrssvOxg4r+fRTIQ2UYk7VHJP2xjkNPOU1wCx/6jfKOBCNIHbxTN1OMruBwVKm/hV3TJIiuhOjQ7+gDErfjVw32Ofdb2MUDYY6EkJvFcVxXkwXOy6+ZSJP0eWURLw16I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172587; c=relaxed/simple;
	bh=KZ+DDTai52HEjeRdNqB4qNF1N8g+/cqxevuiRsuabDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umdZm/7j6mU0eA9//HVFvtZq2ItVtAX/hZK/6hwtl13ZMjzyyyE41wxSf8o7V8zRzoWiuk4LONedpWIzUclKx7Uw4uARbjZKQ1FCyLo/HvNVfGy7y8Sag6qDPfGUe0iC3QTmvfd1+eD4NxZINuMA55Iz69Mc4pNxYQ0NhVZB1jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DUeNq2yV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUeNq2yV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729172584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wyp/GRBR8xPGOtCYjjOBwoc4l6FYiJIRBvxKC1/fE/8=;
	b=DUeNq2yVYBV/x93NcA12uuvCco94Gno3KDnow3iHCsvgHBHNi3x5vbdkl6e6JLibEovRBZ
	DZ9f3bVVXbty/KSOEYZmuJeULxdCv06tC7pV3aBJUrsn10B1vvdgiDTplFqm6jea/KWEnw
	nz9pjAkoHaTZ6d5KBZrtneGGb0csJqE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-Ftvw1GG8NzKqjvaIBCvx1g-1; Thu, 17 Oct 2024 09:43:03 -0400
X-MC-Unique: Ftvw1GG8NzKqjvaIBCvx1g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d47fdbbd6so489903f8f.3
        for <virtualization@lists.linux.dev>; Thu, 17 Oct 2024 06:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729172582; x=1729777382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wyp/GRBR8xPGOtCYjjOBwoc4l6FYiJIRBvxKC1/fE/8=;
        b=XbYuWV5/75+LPIVs5WJ1Ho776pYkBEZclt6m7Rxn1zPqrzGEBaPaFzxSJhetnEQv8R
         G81EXFvBhWjjYVMEEobcbHg1qZpM3CwQkx98UZXxdVWaDhJYWj1fceiHaOQvVwPo4HJm
         FetHgWFWIp6CCWXSba0KR1qdnW60zZi1OTVIwd0HSgYRDLPuaVanNjvieml0hCDILTc+
         gHKe6Na401BcLG6inQX8ZCJ3GJF3igDbb9lFeqKhuBAbqcZe8XVVWpDrcoOeClLC/TC1
         s3htK6ARj1l75PzwZtg3TK2llnrpDhvxkc12YF8jUFq8Fyenri0zIiCoanA4K9iGEkWy
         pTAw==
X-Forwarded-Encrypted: i=1; AJvYcCWZGCbgbd2hRJIrNERw0cKryKY3Hjy7U2Rs5FVA29Kz1zyMj4tnCxEO6IyqtkHtNrJQf5XvRPJfn/JOsVt+gw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy71j+znzvurI4Zg3a2ZiDdJsrRRmwVO0KfRTsJEO1ykpSWwgaa
	J8Tap82tNzs/Vw2v/F7S5tOPJZZ+C6Jhr+YYXcVUjZsYq34K5kZfrL+IAoqKDo/1SA0Z2eSjYUW
	Ui6f0tho867wcVEDcavbTfPMDbbkEk+T3b7OhCJZbFGvSXWvxmwFZjcIPL1d91olf
X-Received: by 2002:adf:ea49:0:b0:37d:5035:451 with SMTP id ffacd0b85a97d-37d55199194mr16836164f8f.10.1729172582110;
        Thu, 17 Oct 2024 06:43:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR8cTr4aAwVoN++OeqwrgM43zxkxe6ACzmvgpcylM7pD/wNRhitVc+bDaNXzucsy+xSzBU1Q==
X-Received: by 2002:adf:ea49:0:b0:37d:5035:451 with SMTP id ffacd0b85a97d-37d55199194mr16836136f8f.10.1729172581647;
        Thu, 17 Oct 2024 06:43:01 -0700 (PDT)
Received: from [192.168.88.248] (146-241-63-201.dyn.eolo.it. [146.241.63.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c50c43sm26996795e9.42.2024.10.17.06.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 06:43:01 -0700 (PDT)
Message-ID: <6aaee824-a5df-42a4-b35e-e89756471084@redhat.com>
Date: Thu, 17 Oct 2024 15:42:59 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] virtio-net: fix overflow inside virtnet_rq_alloc
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
 Si-Wei Liu <si-wei.liu@oracle.com>
References: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>
 <20241014031234.7659-2-xuanzhuo@linux.alibaba.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241014031234.7659-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/14/24 05:12, Xuan Zhuo wrote:
> When the frag just got a page, then may lead to regression on VM.
> Specially if the sysctl net.core.high_order_alloc_disable value is 1,
> then the frag always get a page when do refill.
> 
> Which could see reliable crashes or scp failure (scp a file 100M in size
> to VM):
> 
> The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> of a new frag. When the frag size is larger than PAGE_SIZE,
> everything is fine. However, if the frag is only one page and the
> total size of the buffer and virtnet_rq_dma is larger than one page, an
> overflow may occur.
> 
> Here, when the frag size is not enough, we reduce the buffer len to fix
> this problem.
> 
> Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
> Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

This looks like a fix that should target the net tree, but the following 
patches looks like net-next material. Any special reason to bundle them 
together?

Also, please explicitly include the the target tree in the subj on next 
submissions, thanks!

Paolo

