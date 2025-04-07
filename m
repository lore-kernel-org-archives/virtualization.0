Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFE8224B1B
	for <virtualization@lists.linux.dev>; Mon,  7 Apr 2025 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744012367; cv=none; b=A7/9tJ2eGQ6kajVCKgCVwHEB2565TK6wFWE/tsl3xwouduJ1wrkiDead757wy1W9AxBX1FVkfib5njVXt3qMtYP7psm6OC7JHx3imtf/xLeA11bvzBp4v1bPFdfV+f25Ks+VSJu7WPhDBRrhs68H6R3DoRnAEOMM5rbIAahicXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744012367; c=relaxed/simple;
	bh=rUX6kwf2jcF8ugrawlFPTy7xjQXkwZR1IvpwRwX1AmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WyZny77l3kPFULIr9z7swRFn+PcbCI/VQ8Talf0huggHCzvlCBgxOWaEe2CD0sDfpBggLVUisw9w6RG/hjcrbG6JCSc2fOJxlIP8HYMf2xapdFgAX3l4eTHttj9rTjCUYktARAckaPMHT1sE7Z8ZP5X9BHaMirjJiXfC+dIXZNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dEfPSiMi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dEfPSiMi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744012364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SWeyxgVRp5P7mOHz2eAUtnv3gFTxLpkuE25ons4rBo4=;
	b=dEfPSiMiA2EKUviZFjwC6pQ1BjlCBHkoWLN0QiZiLBRDBtu8ODJRfqK+S0mvSzKnkkMxye
	lhMHEuU3h1i1mzRWq4vawDJUwJd/GBPdP+eMDSafijSrO/Nx7pyi9xtZB8NIcUqTNcSUFE
	vUCZv4FCoZT0NvfMVvkrvb7/Yzzj7wo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-H_FszktTOIWIKg5OMNBbUg-1; Mon, 07 Apr 2025 03:52:43 -0400
X-MC-Unique: H_FszktTOIWIKg5OMNBbUg-1
X-Mimecast-MFC-AGG-ID: H_FszktTOIWIKg5OMNBbUg_1744012362
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-391345e3aa3so2336047f8f.0
        for <virtualization@lists.linux.dev>; Mon, 07 Apr 2025 00:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744012362; x=1744617162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWeyxgVRp5P7mOHz2eAUtnv3gFTxLpkuE25ons4rBo4=;
        b=tas0RHyD8Lfz7T7VWLaBUWCfbRk5Z0A7JSrLA/OnUJg41tFhy90DelFBMw2j/1cmzm
         t7vefCcrBQOT7X3ljCNC+M8ZKxu0v94yPcWJaonWu6ftDzofWTozC0OOGxq++psh5LJl
         GePCL9qC/ldVXprEh9TCKiSCrKxQSljJ0kLFFUOeMv69I4VMDOUzcFO+s4bVQyBjFWVj
         87cf+rpTJmWHL/i38mNFJvWA7qnmXsaiqKDoqlS1Mapl8S9UodUSAKosKp70daGu1MVP
         ZeuxVH+p8pNB5+Cixwx7xyWpEbgX3CYCrFZp54lOiwbHpKTfnTzmXYeF3/iTAYJJ0khu
         kzWw==
X-Forwarded-Encrypted: i=1; AJvYcCXWbZxSQYjIwqEvlFXPQnlJl8EMjCZ47SBnup+g4Nlft9sYkOQOHHowj/1eYwgqUuOJRQrNI63b2rvETivFVw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0cOFNmI61G3T7wpJSTt6Va/bWpvBgjmYmrejTv3xImWdG2qbI
	HUpNE1H5k7MjHxyn6l3emGffmq26btSar1/l8IKm4Xi7pIeMq82mNJlXvfyqcCDq6KSqylP3mwA
	hLBYTvhcqAzLEYTNfMkAaB3HMHDY/hYq0xH0O9fuUCozIChw8HUnEZ4f8obgVSFws
X-Gm-Gg: ASbGnctBAQKoACqLuyAPdYKbpqcSeDyb0ZfY4DeslMFEoApB1sVVH0qDYJKiZ1BKL8J
	FF5uvPZhJ5XqgSnKHwMm1YnlzoC57G1CfDR3CnZaVkIeeUb7q6b+NZn9eJ9cwbudSYMx5fqXuRX
	fp25EFP9mnadai5LBn8U24EKGey+IwdC9TsrzLwQI4RcHDkQoLqwO+6nOPz2pwNuvbzqLPhR1Xj
	3Shn1jUbuWleaH+adXoo258zuV1YDdJndB/bJH8NZ69U1gcSfTJR2pfSijIiThpiS2IHV/fRXYD
	Bn7oE/F04w==
X-Received: by 2002:a05:6000:2ca:b0:39c:30fd:ca7 with SMTP id ffacd0b85a97d-39d6fc0c02emr6572087f8f.7.1744012361839;
        Mon, 07 Apr 2025 00:52:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJsYAXUaNdpV/VhhZQQ5RxLgg/gr/bn4kaQg3vnQsXyz4+tvGKcyIi12k0f6ULNipYdQ/RcQ==
X-Received: by 2002:a05:6000:2ca:b0:39c:30fd:ca7 with SMTP id ffacd0b85a97d-39d6fc0c02emr6572064f8f.7.1744012361448;
        Mon, 07 Apr 2025 00:52:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d75ac6d66sm4958408f8f.14.2025.04.07.00.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 00:52:40 -0700 (PDT)
Date: Mon, 7 Apr 2025 03:52:37 -0400
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
Message-ID: <20250407034901-mutt-send-email-mst@kernel.org>
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
X-Mimecast-MFC-PROC-ID: TKCsENa-DO4V5ICOgtg7SVno3V3Jr1yHqIGRosLoZes_1744012362
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 04, 2025 at 05:39:10PM +0200, Halil Pasic wrote:
> > 
> > Not perfect, but AFAIKS, not horrible.
> 
> It is like it is. QEMU does queue exist if the corresponding feature
> is offered by the device, and that is what we have to live with.

I don't think we can live with this properly though.
It means a guest that does not know about some features
does not know where to find things.

So now, I am inclined to add linux code to work with current qemu and
with spec compliant one, and add qemu code to work with current linux
and spec compliant one.

Document the bug in the spec, maybe, in a non conformance section.

-- 
MST

