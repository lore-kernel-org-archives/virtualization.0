Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD832AE78
	for <virtualization@lists.linux.dev>; Sat, 25 Apr 2026 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777136599; cv=none; b=gj23O7QiJe7H10+q77z55Y0af+ayVHQ9wPmIbwLFFsqZeKUeiKaF2GyO4YxS4Sh3t45zyfDjdT2lGvfiKWQwUB1PzQSIzQAfR7wE1/QvFDgHLx5+GlbfJltxMUQy77H1aroJZJLxuTHxOxlpLB+z7yGOPC8hdishIUxRekFd+wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777136599; c=relaxed/simple;
	bh=rFWJpKf2/UxIP3i+k/X72Xs6IstgW6mx17/JbpaoPLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FNDA4Q4ITiDvT3/XJDd1bHo1Y1t7CFwOBA/47yGiOKdAoveF9lagVhoMPMfErFTr8eo3OADIOZGtr9fKBPTBCUCEpVgybPpcy2BDig78PffQqWa96xpkgmBPz9MTBuO9vMKATSUlgWcik/6JF/QK9T1qtRLL0P6ZApoQu/8EEKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8j7RNNq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8j7RNNq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777136596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UydGENrV15JfC7+m6DqDLSAFqKV6Nf5fu8hzpCuZzco=;
	b=R8j7RNNqnnNaO78N7BmKPaMoEkoRAN+nMyfIEJu1OlehzFKpo7phSiTAIMG2OkhITCOqmt
	+b7ucW8oRwk9E1v/xv7OTRkAzDgv4oI1aNruwt5cWDCoz6DmvdzTZGu7LiJV1Z6p1WuH2v
	mOSXsm9iK9BKkwnvh5zDGVRxRioGCyI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-Dsb8PCjGOAyoxqEqO5p0Ug-1; Sat, 25 Apr 2026 13:03:15 -0400
X-MC-Unique: Dsb8PCjGOAyoxqEqO5p0Ug-1
X-Mimecast-MFC-AGG-ID: Dsb8PCjGOAyoxqEqO5p0Ug_1777136594
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d77286244so5924384f8f.1
        for <virtualization@lists.linux.dev>; Sat, 25 Apr 2026 10:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777136594; x=1777741394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UydGENrV15JfC7+m6DqDLSAFqKV6Nf5fu8hzpCuZzco=;
        b=ULV++d6ZV3weKc6AbJI1uXgWnw2/mDdKkGIG3bvkEmSQII9YMPuRECb1qO9PXHsuT7
         bUbCRShGM4NWz7KVqK10Uawv5U4k3937RvxgU8gMjgeML7Sqa/fUuYqC5Yzpgo75fKuu
         EENNxRvR7Ahh2W95DNvPswOMzWDcgFWUn3hd9Ep8sN6RUbFEfqi2N9yIzoxN8aMvsGML
         BGg24sH7dkQQwWx7avcSNkfEr3m3x3xxb36SB4QXdeW1/p/7BhpvdzHxrCPQDqjnee8N
         iJ9ELmJg2O3mo/87LkHmSwbpmjiTAuEcfHKMjKQPmCiVDhgeljojuS1kaL57tYBGm8b9
         VxKA==
X-Forwarded-Encrypted: i=1; AFNElJ/ZmDxfW0Ild/+IlQwFDIs87vKLPKsbU4LFc0eWhjNTURmu2sgJi9lseYhu56xTHW5w2dQzliO4rggnH348jg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRjnclvdph1fw+dGYkMRC3djzN8nrmHL8NYNf9Nw87lfZQqSYN
	sa4WNuShdR9qejtKmvtQhZDr1SKWx7b2A15+H72Ra/cPn1aFOSvce/T2XKg+pfRSM/CkjGxk7cb
	+zSQAhj9/hVYbCu3iYmvLZIVkRbjwEPbc+PqYFCvtiJm0zhw5zaJF/48KyVeVr1H1mCIL
X-Gm-Gg: AeBDieua/imKQkppZ+gk1IPxS5oMr1+Z/fi4ohqk+ALhcssA8OTYPCdkUz83STEbNkU
	3zocXR0YgRUoxaPKAxab2oMUwHVdC8GVCWfJYBO61lu8c6xz0nPxTDsJ/WNt5cZZIMj9Wqf2gCP
	+9ujRXQEvYP+KLQ+Zfn9musbSCnFz5EX+Mv4zD7UrWbBhVSoa5HvCja/+SUyeDQi+fliLUFoY+q
	LKu+ZkUJglj0NHEBcCup56fU6PxEMHhtN5Xk48QVvbwbmvPgTrTjmOXd1ZIpYF63RBiU3Bml7iR
	0c6Rwn7s8lxDYyHj4WxLDooyYH/wNIcTSI8TKG35D1n0xQ1Rv49UTxPoFS3cBnZC4OFcPMbJitn
	CeMCL3A6Qa+Hdk0F/O+DufEeV
X-Received: by 2002:a05:600c:3110:b0:487:243f:dc3e with SMTP id 5b1f17b1804b1-488fb739cf6mr533680235e9.6.1777136594096;
        Sat, 25 Apr 2026 10:03:14 -0700 (PDT)
X-Received: by 2002:a05:600c:3110:b0:487:243f:dc3e with SMTP id 5b1f17b1804b1-488fb739cf6mr533679865e9.6.1777136593661;
        Sat, 25 Apr 2026 10:03:13 -0700 (PDT)
Received: from redhat.com ([147.235.221.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4412150a092sm31800942f8f.23.2026.04.25.10.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 10:03:13 -0700 (PDT)
Date: Sat, 25 Apr 2026 13:03:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: Peter Hilber <peter.hilber@oss.qualcomm.com>, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] virtio: rtc: tear down old virtqueues before restore
Message-ID: <20260425130233-mutt-send-email-mst@kernel.org>
References: <20260425110857-mutt-send-email-mst@kernel.org>
 <20260425160906.677660-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260425160906.677660-1-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hqlFGTC074FHp5E-PEI98inV-4F4oLNokB34TcHzHV8_1777136594
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 26, 2026 at 12:09:06AM +0800, Jia Jia wrote:
> Hi Michael,
> 
> JiaJia is my full name. My family name is Jia and my given name is also Jia.
> 
> I wrote it as "JiaJia", but "Jia Jia" is probably clearer. I will use "Jia Jia"
> in future postings.
> 
> Thanks,
> Jia Jia

Beautiful. Yes, clearer, thank you so much.

-- 
MST

