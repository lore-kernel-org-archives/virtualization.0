Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A6B2288EA
	for <virtualization@lists.linux.dev>; Mon,  7 Apr 2025 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744015316; cv=none; b=DYG7k2fxUwpjFtvzEeu9r8j9N2cDKRymotosGvqJQitu8G19vzF2ZPNhyQIm2E+f3KtGzuIjzoCTAOwRYTDkfKQeS63m4q2Ju/E7b0ToIxaC2xZdVfM/cEkj/zEokhnpTec9rYUyi6bqHhNj9oot2CaVkcj+uFAV3kAUCTo+zm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744015316; c=relaxed/simple;
	bh=dubat8tCLJKpXwu98mOgPZCaGLWjN3X5sHoHO7zCnlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZrriNgqCOmOdAmzsHPFNr/uIhvTYAitcAWfhqAnpg1iWamV+fuGzQkC8v1GIDTBx7DVpqqfjPUSGCEhhoRw3tdY9Z6aEu38Vz39h3Wvm4rrmsP79TTRKahc7bhSADSPVBQhLshjYrhyKkRoNs8joG4AEljYNgSvtVAdsZcOVbvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RQutNH+3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQutNH+3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744015313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m3pK6yIdPNYZ4p3nnxwbYWeXbQyAyM0EzrK62OMGx28=;
	b=RQutNH+3gj66LIQoYG903N0K2VeIMj/UZn+Ud6woJiGQox/i88hZytQCKaE1l21TSSP28z
	xP5dpKzTIoochi1764oHIQBgh7EmHauotXU2cEUcu5fHQZk8Wm1K1UdVNBQPM7feHd1cId
	aNWHaUBFLPV0pjouu/M21FK0YTa/fxk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-IkJUp99fMEW8CNXPYTp_qg-1; Mon, 07 Apr 2025 04:41:50 -0400
X-MC-Unique: IkJUp99fMEW8CNXPYTp_qg-1
X-Mimecast-MFC-AGG-ID: IkJUp99fMEW8CNXPYTp_qg_1744015309
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cec217977so26286075e9.0
        for <virtualization@lists.linux.dev>; Mon, 07 Apr 2025 01:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744015309; x=1744620109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3pK6yIdPNYZ4p3nnxwbYWeXbQyAyM0EzrK62OMGx28=;
        b=KqOwrSdsXobFoLQFAp628WXZZQOp5hP7/4G+RnYqLtQnmXCh5j3NVji/1Rxbxcjmtv
         6kC1M/Mpmg8hL5vurgEvyQtbXhj9a7+MQO6heL84cVb0/c8egdxC8Ba8sUvDZWCQe27e
         F9ugxQbJjl7GJ7Yt9V7hDSb+voOBCVAKwLgrkb1PBTcVWZCpmi/UCq3RsFKUzewUN5ay
         x6x2Fjenkm+FlI0MlfVvQw1/e6XS0G5TrJj5E0v77kyAgcM7pQjYh18+m/RWoA0gUQ4a
         9OIdYAlnMnImmJ4hd6r9yZnxylz4PN1f2SnPIe9WYF4nY0GaAt3S0lsoyr6i+/u4iAW7
         dVLw==
X-Forwarded-Encrypted: i=1; AJvYcCXfz6FZ4BQ3nnWAeOfBzR5pJcELGYDoZb3cSCUB8OnoEyJ+OUAJcxROcHLLrYXs9VdemdwIxlIlbkAj+aoglg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzqyRZxU1/k0RzQP18AlOv8p34/ovHn+FbeCpaAOmScDLB7A9W
	AtBq6lt40s2iA07hbv+qcuT8GnwwwWmIpTFSI2KrptFiSWn9Dg60MaGR+5yvSCmwC1EgaDT6n+G
	Id1zflwnI75N7mIsbodMYfQdfz2WbOdRK1B9JPeGwJI6pi+e5PckN7D+Nf5Osj9GM
X-Gm-Gg: ASbGncuLDO3MSVGGSApM8fQ27zzQ9UhV/OGZHPp8aX7GlXeU04EwqqmlrUpns3Hc39h
	us+Vx3nkDOKp6aFTwFeC4ZLfQTwXcwwiDdP36knOMLmLi9EaEyTBPBfI0aaQwD1XD6jX9AtMz2K
	SfDskm1wE6SLaFxuSgNPxHD2yYqWeMRQmzhPAaW3sYfOLiulbYI1ZHK2lmPE9vJNVSpgAoXjDBh
	nzqSwkCm29oQvAKyVKe0XdOIF8a7w9EIQdNn7nK1051cRrdKSBDscISFq/9BFIrTO3Kf5KgQc9C
	IwNo4Dp+0Q==
X-Received: by 2002:a05:600c:5248:b0:43c:eeee:b70a with SMTP id 5b1f17b1804b1-43edf8a28d1mr45333005e9.22.1744015309267;
        Mon, 07 Apr 2025 01:41:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnMOiX9O9gk9kURjhnnuCNT1UVrytArjtGV7ecRUIBKrJSc0PSzOsjWjaDnmkVaY/+rUOMfQ==
X-Received: by 2002:a05:600c:5248:b0:43c:eeee:b70a with SMTP id 5b1f17b1804b1-43edf8a28d1mr45332875e9.22.1744015308965;
        Mon, 07 Apr 2025 01:41:48 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c302269a2sm11484143f8f.91.2025.04.07.01.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:41:48 -0700 (PDT)
Date: Mon, 7 Apr 2025 04:41:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, Chandra Merla <cmerla@redhat.com>,
	Stable@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
Message-ID: <20250407044029-mutt-send-email-mst@kernel.org>
References: <20250403161836.7fe9fea5.pasic@linux.ibm.com>
 <e2936e2f-022c-44ee-bb04-f07045ee2114@redhat.com>
 <20250404063619.0fa60a41.pasic@linux.ibm.com>
 <4a33daa3-7415-411e-a491-07635e3cfdc4@redhat.com>
 <d54fbf56-b462-4eea-a86e-3a0defb6298b@redhat.com>
 <20250404153620.04d2df05.pasic@linux.ibm.com>
 <d6f5f854-1294-4afa-b02a-657713435435@redhat.com>
 <20250404160025.3ab56f60.pasic@linux.ibm.com>
 <6f548b8b-8c6e-4221-a5d5-8e7a9013f9c3@redhat.com>
 <20250404173910.6581706a.pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250404173910.6581706a.pasic@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LUqr0mLJ85AkUnb3JJIbDIqH78e6JjFHhchWXkFutmQ_1744015309
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 04, 2025 at 05:39:10PM +0200, Halil Pasic wrote:
> That basically means that if I was, for the sake of fun do
> 
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -1197,7 +1197,6 @@ static unsigned int features[] = {
>         VIRTIO_BALLOON_F_MUST_TELL_HOST,
>         VIRTIO_BALLOON_F_STATS_VQ,
>         VIRTIO_BALLOON_F_DEFLATE_ON_OOM,
> -       VIRTIO_BALLOON_F_FREE_PAGE_HINT,
>         VIRTIO_BALLOON_F_PAGE_POISON,
>         VIRTIO_BALLOON_F_REPORTING,
>  };
> 
> I would end up with virtio_check_driver_offered_feature() calling
> BUG().


I mean, yes, this is exactly to catch drivers that use
features without negotiating them first. 


-- 
MST

