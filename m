Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9868A2253B2
	for <virtualization@lists.linux.dev>; Mon,  7 Apr 2025 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744016085; cv=none; b=cC05VcgtijTrCUigs2TcUH4bbJVx9FSvMljwBeYoDnzRUULR3TtFN0A9HNIlX0bJsXX+y/sWXtw9eZf0+ql927WjPAV31eyX+OLCQyevCtVTdh4sdcY7AAwxwFm9Kd53OYU0JnQVIJUAKiVm/6gv3YnBllgdjZHe2tNOZIKC6ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744016085; c=relaxed/simple;
	bh=R+0sWKhqbThzPkae+5wVut0fKNCyuXS4OYJ/SETg+GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DbvI/jHgp4NE8XZSsS4jjgMKmFyJZ3wQEYo69DM4rv6FxL3HMRs2n2QxLz8MhHbkwAknqXeOtflQz09ojyotbaM7YYfLf2VdNnrJBXusaQKHEKuaflM2GqR58u8LsUyd76PYML0Hepkx5leT8fGITE5KNzuqor4+3iT95e23+Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OI6D7Op7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OI6D7Op7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744016082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MAmqbLHdw+HuKBAeHI83rPkmOKB4Sfbwt9oiDo5180k=;
	b=OI6D7Op7j81Ld2tGFDWanBI/NtuPw8FNZbFIximhPKwXGVWzDfSaetmGOSkEK8pubNG4be
	sF/cT3ZJprHYxzZVSdhneM1LaaTMEXmQZDpvZ5N10uEKpMjnDe9++2Kv0bXodtdLn0KQl3
	BnI0mG3s0onTc7m/4bAtAKsBonOpVz4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-JeW5R0wbO6Cu6vrCAMsD2A-1; Mon, 07 Apr 2025 04:54:41 -0400
X-MC-Unique: JeW5R0wbO6Cu6vrCAMsD2A-1
X-Mimecast-MFC-AGG-ID: JeW5R0wbO6Cu6vrCAMsD2A_1744016080
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d0a037f97so24032985e9.2
        for <virtualization@lists.linux.dev>; Mon, 07 Apr 2025 01:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744016080; x=1744620880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAmqbLHdw+HuKBAeHI83rPkmOKB4Sfbwt9oiDo5180k=;
        b=JhJHFlJMgkwtHz1Vlss679L5LKNc8VVonMSrqwjfpcxXFjQ204AJ9CJ/s6NZjm+GU1
         Lm7IRH8DTsTBed2SDGebyCPjfzdLmcYAevSpHKZHPw0GcqRBdpu7zAFbDBIRBR/NrVAi
         WF5C/2uuxTrKSiHdZC3b5I/6hXxKzkzw7FQSJrBEsJwXWApPMlzCMxiNQ7YUTp6WVP4r
         qC/4g8yaxo46d7zKtcyBeEs+RIepGOXyhkr6FoA1CcXDkUcY/exnaVNVwMnDm7Cf4EIa
         IDSx1ckD5nk5n75YM8rYUul/FdU0GCi4WmaGMYEt6XsAMvarxiKiD4xeb8cKYLnQE2rc
         t0gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd2sFAWP2dtfjCBLERBr8ZFml+LUZUosphzsHGvxBZP6ATelhyBrZpinLvU+wz1RLUT0Q85UbR8EzQctNe2g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxxg9zEMJhhVF8V+XzD8LsHYWV4QPH3IMEzT81sfR2AGkLL6O8g
	LgiACHZ5+8wHheFbr8yl7K51lZxiyjkp0uReTgxLXGyasOvdIBUVSHg7LF06WhpciyYVxtzyTl5
	WgkTHCJbyfwam/5/57E19t1s4FBgmTLto1qOqoQFYMETM8LjShwRilTgoukuSR42Y
X-Gm-Gg: ASbGncu4Eg5yzq0tCfDRq5f3xN6maq4dAiikzmWqkBQ56uXyYnpWomThtKmrNQBfFzg
	MtkKqrMQnuo88werDZgtPB3h4ClO3BiOBUjMCycnH5YXGPVGNxBTjzYZI6m33tMG80BxpxqaO6Y
	Vi+ZGj9D8JUjg9ZcEObbj+IDqjgQIqtgPGB4pE7asSzGnK0IaYYE3uxG+NqQwfE/RWQTe0RciU4
	ohKCTZkbqgRPWEsMqNWnWR5c39lXG0ZhuJqauvXTV5KB+3CnkzLtgKYZhrRBTH92NicfYcpr4zF
	1N6UeKS0AA==
X-Received: by 2002:a05:600c:8411:b0:43d:d06:3798 with SMTP id 5b1f17b1804b1-43ecf9fe1f0mr95894245e9.20.1744016080220;
        Mon, 07 Apr 2025 01:54:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH8IW0yqzJPKyGZGPD6qVstVRgqzDFHSOjqPBtRY8GjulSPFiJgnNYxrGMbcuC1XF3d2jQRg==
X-Received: by 2002:a05:600c:8411:b0:43d:d06:3798 with SMTP id 5b1f17b1804b1-43ecf9fe1f0mr95893945e9.20.1744016079846;
        Mon, 07 Apr 2025 01:54:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34a75fcsm121633225e9.11.2025.04.07.01.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:54:39 -0700 (PDT)
Date: Mon, 7 Apr 2025 04:54:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <20250407045009-mutt-send-email-mst@kernel.org>
References: <20250402203621.940090-1-david@redhat.com>
 <20250403161836.7fe9fea5.pasic@linux.ibm.com>
 <e2936e2f-022c-44ee-bb04-f07045ee2114@redhat.com>
 <20250404063619.0fa60a41.pasic@linux.ibm.com>
 <4a33daa3-7415-411e-a491-07635e3cfdc4@redhat.com>
 <d54fbf56-b462-4eea-a86e-3a0defb6298b@redhat.com>
 <20250404153620.04d2df05.pasic@linux.ibm.com>
 <d6f5f854-1294-4afa-b02a-657713435435@redhat.com>
 <20250406144025-mutt-send-email-mst@kernel.org>
 <4450ec71-8a8f-478c-a66e-b53d858beb02@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4450ec71-8a8f-478c-a66e-b53d858beb02@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JEpqpnUtyoe2kaIJwL9YgC3ut0F4NZfW4KdneJC3Osg_1744016080
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 07, 2025 at 09:18:21AM +0200, David Hildenbrand wrote:
> > Now I am beginning to think we should leave the spec alone
> > and fix the drivers ... Ugh ....
> 
> We could always say that starting with feature X, queue indexes are fixed
> again. E.g., VIRTIO_BALLOON_F_X would have it's virtqueue fixed at index 5,
> independent of the other (older) features where the virtqueue indexes are
> determined like today.
> 
> Won't make the implementation easier, though, I'm afraid.
> 
> (I also thought about a way to query the virtqueue index for a feature, but
> that's probably overengineering)

The best contract we have is the spec. Sometimes it is hopelessly broken
and we have to fix it, but not in this case.

Let's do a theoretical excercise, assuming we want to fix the drivers,
but we also want to have workarounds in place in qemu and in
drivers to support existing ones. How would we go about it?



Maybe we want a feature bit BALLOON_FIXED and ask everyone
to negotiate it?  But if we go this way, we really need to fix
the 48 bit limitation too.




-- 
MST

