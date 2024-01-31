Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C554169943
	for <virtualization@lists.linux.dev>; Wed, 31 Jan 2024 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706694198; cv=none; b=eRxhXOoNaQ+G2iMKuYXLk8nYmfRE/72AibjCCJALRL/XsLwsLbdRLnDu4+c3pz25v01e1c5OTkhU7DfT4Kkm87IfLMeakkzEjZsvE255kX9AD8aLm7EXEhE/ZqZbF55glgfBxEFqHrM2d4ka25vOt3DPmPAY6HLso8vVlO4cM5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706694198; c=relaxed/simple;
	bh=gkIae8l+H2+F/jXvpvISUQcIXBcbsucEp1aonIBdbjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bU4KWtcQMxtIbi6O8Ml9A4Rz4n3/0LdQRLFEvOr+Py4Qtsc6s3T3h+C6YPnOnut9Z3n5t5QWATphbc9G9BvEpTD+lYooVseuqI7EIIVZAkXUyAhM9qNt2/bCAF5MiKaBIIwWxY3X6BpfE5sc7SRMtIIfNXJOOCaTLSJgbSfTCU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L3m4ZT/M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3m4ZT/M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706694195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oza1LRHp/M5RIj8Nm47urKrF572FUv22z3v7KOgdQu8=;
	b=L3m4ZT/MnCj95zLgHqAIuvyEQV3J2uK9pTMdOn7J29lBYHg+JKtmCaISdpn5LRGM5HHupG
	G3gfU8fb+W9zfEuTCzGVbIMPFmSt+U013Bz+aHb5IYSZU18bAfT0xys/D8fSPY+nVkFwEA
	WAE5bT6s2lwOhhe/1qyIlKZ1wrkHxac=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-fZdgshpXM0GaPvWmajiwKw-1; Wed, 31 Jan 2024 04:43:14 -0500
X-MC-Unique: fZdgshpXM0GaPvWmajiwKw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33ae2d2fffaso1753026f8f.2
        for <virtualization@lists.linux.dev>; Wed, 31 Jan 2024 01:43:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706694193; x=1707298993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oza1LRHp/M5RIj8Nm47urKrF572FUv22z3v7KOgdQu8=;
        b=RdraT+e9wRrWxYUHS23hdAVmSsme+q5rK3pwsE2fVxbbPGRREnF8+HX7PKtLF/oJyy
         +HbFuxzB4nz8hVcthtLPtAitbCC1pHCrjJ2aVXGFsJlP0JQW1BNw9kQPkujYahnk5UnL
         aDHuKVTWCNwfy0dBWXrQNvxkbX2uL8Kf9GYkywPN2xnqJxFsnd2v6B3CxHd1wCl+s+Zd
         jbh3mVIfcPECm05U1JPf5bQJ5DxwNxrruVUXufLBRYaEJh0RxBaqfVNV/qONLyO1WiJu
         VEObmUSKTTyJzKFrkT/McMFAfZ6v2J2UloR23InE1YL6TEv6bpgFZvkP5xhigxJjDJM4
         44Gg==
X-Gm-Message-State: AOJu0YxGhjHBVQj+5nQvZZpse9Tzh36UTCOtuAUIRvDMiR9REeHrRnS6
	lbkuDM6TQ4/rH1qouzf5V1ZDNQhQj65ToxszcsHoBhjVV6N+lCBsB8bp797m93otgkaKPxKuepe
	l6zQ8Kru2vBp07p3iqVMaYwL2EzImbhXTz/eoYdFh0GUlNfty13SfgrWuXglQUopF
X-Received: by 2002:adf:fa05:0:b0:33a:e919:f406 with SMTP id m5-20020adffa05000000b0033ae919f406mr679879wrr.52.1706694193229;
        Wed, 31 Jan 2024 01:43:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3NLeG1aMawKGEQVu/0aqBjSNNGqzZmjOJyBzgiQ4QC6+fT4S4tC5TcuNgzowV5ynPiQEAwQ==
X-Received: by 2002:adf:fa05:0:b0:33a:e919:f406 with SMTP id m5-20020adffa05000000b0033ae919f406mr679860wrr.52.1706694192871;
        Wed, 31 Jan 2024 01:43:12 -0800 (PST)
Received: from redhat.com ([2a02:14f:1fb:b2de:3c63:2a5e:5605:4150])
        by smtp.gmail.com with ESMTPSA id cx18-20020a056000093200b0033935779a23sm12937651wrb.89.2024.01.31.01.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 01:43:12 -0800 (PST)
Date: Wed, 31 Jan 2024 04:43:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Yang Li <yang.lee@linux.alibaba.com>, linux-um@lists.infradead.org,
	netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH vhost 04/17] virtio_ring: split: remove double check of
 the unmap ops
Message-ID: <20240131044244-mutt-send-email-mst@kernel.org>
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com>
 <20240130114224.86536-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEs-wUa_z_tGYEwBf7EVJAtuJdkX4HAdjqMXHEM1ys-gKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEs-wUa_z_tGYEwBf7EVJAtuJdkX4HAdjqMXHEM1ys-gKQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 31, 2024 at 05:12:22PM +0800, Jason Wang wrote:
> I post a patch to store flags unconditionally at:
> 
> https://lore.kernel.org/all/20220224122655-mutt-send-email-mst@kernel.org/

what happened to it btw?

-- 
MST

