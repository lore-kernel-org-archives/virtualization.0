Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6696F60885
	for <virtualization@lists.linux.dev>; Wed, 31 Jan 2024 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692395; cv=none; b=KsC6U9D+3wl+9xwES4GUV80VSDchFdIoVvRmM0STgg9X64eivcbXISUZRm1P6tmtfjU9Yb2Ka1B/vbf6+2nIpl77GHBEqrqxRtqNJ6Xeoj2bdWzuRwNEN8wO2OB1qGGXpzdZ4O+xoKI20lDabfHkICBjI8fPa4XD+mrjNAf6dRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692395; c=relaxed/simple;
	bh=GFZDXlK/s4D6vSBTxs5Uj6beZ7wLcQBUCOrs3aA1zrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ooaQgTR/T+NONygmPmn1/HqHisOsDxeJro/X4/7mHYfZ//URbfbO0SPDY2J9ajD1by1dssDCJQRnrbdeP3fo99Zv30H8yeN6c7oHBYIyIeuNUPJIlyFwGxriXWFweR6RhK6gry1oG0MSiVdBH3oXrJNtGEAwfhbm5BODCa9FEUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YwV2fmEB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwV2fmEB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706692393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GFZDXlK/s4D6vSBTxs5Uj6beZ7wLcQBUCOrs3aA1zrk=;
	b=YwV2fmEBLg9RLNldLFTYZ1yePFMkNLWCZBydgPdsrXSoiqjEe/Pd98twu9NeUQrEh9eauO
	2tca5msH4wcay3WutxfldJY8/y73tBtNIipLAzFiQLczfjfsQ7H7BqTZOIHW02qbnJlUeU
	pzUHXJB7U5jgr4SIWJU81zYNLHokF4k=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-TjAwtJrvMKuNZtaSawxBxQ-1; Wed, 31 Jan 2024 04:13:12 -0500
X-MC-Unique: TjAwtJrvMKuNZtaSawxBxQ-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-46b32362dbbso1279325137.2
        for <virtualization@lists.linux.dev>; Wed, 31 Jan 2024 01:13:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706692392; x=1707297192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFZDXlK/s4D6vSBTxs5Uj6beZ7wLcQBUCOrs3aA1zrk=;
        b=U9oufhdg+Ux/z4WACPsyEBQBnAQVE9nEFGcMERxBiLzCPDs9z5TGFes4GHGUfBlDaA
         QpWa+zu5qG6rm7lhSoxJ7hNtEjGxRympSMJ5saE5fl6roIOU10o0c7GBa1H8dBeDmhfo
         vb3cEaGmDtUue5IbDZdTya0apkIVjvV3nUzwgH7VUdk7kWxWDAYagl9/B7bvQwBcPnMH
         lgbWlHRYPIUEUi175yysaWg57P38OVBOXz6vEJYbaf+mHVW0jq/OlVnfmXjF1xPMs/Dq
         otF5wXeKFZ8BvQ4+k5tVKd18cKMB8C01F2EndorPkMD3vxH+y3jKZihyIynP6qCGLpMQ
         qdgA==
X-Gm-Message-State: AOJu0Yx2fEUw5+1XgwasVfL2uueYS1kMCQubO4ylk3yCg2s/hpUTGISI
	M4jG1MVhQ3tHoMAlCFbQAbNAtfHT2Ok6oVl/7oDRoCUdzUnABbOsF4SoByiC8zRasRokuYgkEbD
	X1eJzU4T5aavbg4G7swQ633mH9JgvxfBqhtpho6Pwltll1ZXTeaA/30uK34UdC1sM2n5CXABmLm
	JfgcrkirXX4qQmK9Ll9q1xU6bM/YwMQP+seoQASVI=
X-Received: by 2002:a67:ec18:0:b0:469:96dd:4a93 with SMTP id d24-20020a67ec18000000b0046996dd4a93mr924039vso.10.1706692391852;
        Wed, 31 Jan 2024 01:13:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/cR50d4YHDD+w1IZRT3VXxyAnkVgoZf6Jvq1cGXaHp7Wnd5AI92yFzXhl3he/qD1ctU9FKOVMa+BK0TXujPo=
X-Received: by 2002:a67:ec18:0:b0:469:96dd:4a93 with SMTP id
 d24-20020a67ec18000000b0046996dd4a93mr924015vso.10.1706692391631; Wed, 31 Jan
 2024 01:13:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com> <20240130114224.86536-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240130114224.86536-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jan 2024 17:12:38 +0800
Message-ID: <CACGkMEsOR-Sz6tZC_Lm-Qxdh4Ugjyn4APsX28rkL6nA87oa_Yg@mail.gmail.com>
Subject: Re: [PATCH vhost 08/17] virtio: vring_new_virtqueue(): pass struct
 instead of multi parameters
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Benjamin Berg <benjamin.berg@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-um@lists.infradead.org, 
	netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:42=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Just like find_vqs(), it is time to refactor the
> vring_new_virtqueue(). We pass the similar struct to
> vring_new_virtqueue.
>

Well, the vring_create_virtqueue() is converted with a structure.

We need to be consistent. And it seems better to use a separate patch
for vring_create_virtqueue() as well.

Thanks

