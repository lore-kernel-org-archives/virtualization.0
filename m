Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0463621C9F8
	for <virtualization@lists.linux.dev>; Mon,  7 Apr 2025 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744060815; cv=none; b=qjcnahUYEyoVcHozOEql02G4kZo0FeVAyqmY9f/ki0JuOFYTagIM7rvYI/NMzGL4ZtH7q7pw2hNRk4MmnxrgLrYvb1ISlHYLxI5nHIXSpuKtnii2MNNDM8ILJRA7gxlS/mnAEOCQaEh2l7A3K6Z9Sx//9TGfZuvhneW9ZbyHpTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744060815; c=relaxed/simple;
	bh=D44uPz9eheA7kkPhO8XxXusezFNcHg7xlYRPONW/cJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=C14ONBO9ArbA5vsi5U//K2SpHCJ/EKiULubw7t16SJmKfcclJJ4ZoPl4cp58ke6KppZg7IdVX9PXKFB6a2RH4Ti1tuIiY146jPp6faJ9zTDHJ2Rm+rEr5SnlH9FJH5MMyRuDmhFZsAZDh4s5nPIDsgGCCZJbB7W1zaOsWRUz+84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DR52gbD3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DR52gbD3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744060812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SSsX1dq63c6Sd4M1C8Om043J0hULe8kAcy41TIjjkwo=;
	b=DR52gbD3uWPuuTq/FQPXEAJrvvm2kzdnYAO2m/cz14QEXJl5UAiCiWG2V6Bum6F0wBplkK
	LDUj0nC5U3u7AioYjRpsvandjGi9L7aAlK5MHN3JYEq53C5NdZM1H+zWQQY9dq9BPZzHSD
	1z6ow+BpAj1B5J1CXDl2bz5j6wJSI30=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-8UbzROBhPe2k7BO8iY--TA-1; Mon, 07 Apr 2025 17:20:11 -0400
X-MC-Unique: 8UbzROBhPe2k7BO8iY--TA-1
X-Mimecast-MFC-AGG-ID: 8UbzROBhPe2k7BO8iY--TA_1744060810
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3912e4e2033so2199013f8f.0
        for <virtualization@lists.linux.dev>; Mon, 07 Apr 2025 14:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744060810; x=1744665610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSsX1dq63c6Sd4M1C8Om043J0hULe8kAcy41TIjjkwo=;
        b=RNKfBWuvEAsdsRR0n4rUQU9VyH5nOP64WggbwdBn9QOO7CTMtqbobUB4b0NGQyM4sq
         wK8v0K8XRk1fUvSVDpSk2a8K1pl+yIbY8rfL2LdVGCE0JrAeiBi4NB4xUV4/PD2lvpcQ
         H4Sa1QH5+IK4gc7RBK3+FtdGIHVn2OjcYi3LQUSc67L+9szJDe9Fbexlj1SB9lj04ycd
         KSO8ekGBaI+DgT0nQSHC6sD9Q9VWjPfhpltQatsH3mmbYIszhFjRqGEYGnPFbCkzwNqF
         vlPbZCATNzEJaEsPZg8FttUbIhnHP19O+9GSnu1CmmUwsk32ZezseFcmmVzxqTohYzNJ
         3z1g==
X-Forwarded-Encrypted: i=1; AJvYcCUJ+qCQ4n3v7/swzg202LuQqfOUdCYt2KlVjKfsXoK5WgOqwQzoxxE2X4yQ5OUV435O9gnR4YCIazIC9DDhVg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxHn0/dtq04ZOAhVLETSPsE/jCOrsrxdWEt2ks5H4T+ZEcOozl
	paWNVeQAeGNJGfkAYQVpRADAGa/m/X8BsV+aXD5V7YiKI8++iXA1guL6ovNxKEdHkAjSPiQD+EK
	wwg2YkDNTyeLwLL6Vm8MIJOGb5p3aiw9C8Ej84BLa7tIJHsOFYCb9EJ3F004dOctb
X-Gm-Gg: ASbGncuf60CeeH3yoAIVh3OtUJgrmk3WGrUqcfEg1gPSDZzsyqiGG5Nzt7jHvJuNrln
	dLbnVFoviD8gu9fw/Co1SSNV5FamzYRH1juh3Iwa0t58Ve26SQuMg4vPhYNr7JOyYxuGXCU3voa
	mPCOste+qOzbfeVIxLT+ph6PQmWdH8BLqKOHQHh6Zp/AZkKiWuimZwct2aE9yuqaEzTVKQEI6TV
	wrKSrcmfvuF4yyjBPHMNscRtqAno8ld29iwtZmc9T1sqschZKMVF+XB/EPetkp8PWQZ2ecS/wM8
	1FXhuwoJHA==
X-Received: by 2002:a05:6000:1847:b0:39a:ca05:5232 with SMTP id ffacd0b85a97d-39cb3575befmr12282706f8f.5.1744060810332;
        Mon, 07 Apr 2025 14:20:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7YJ3OkxxdjofaKEYzWTRjjkkLHkcDI8DZkVD+3A0SRfbIhe0O3F820zBX+uC97qfAn2pPXw==
X-Received: by 2002:a05:6000:1847:b0:39a:ca05:5232 with SMTP id ffacd0b85a97d-39cb3575befmr12282687f8f.5.1744060809960;
        Mon, 07 Apr 2025 14:20:09 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34a7615sm140530535e9.9.2025.04.07.14.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:20:09 -0700 (PDT)
Date: Mon, 7 Apr 2025 17:20:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Daniel Verkamp <dverkamp@chromium.org>,
	Halil Pasic <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <20250407170239-mutt-send-email-mst@kernel.org>
References: <20250407042058-mutt-send-email-mst@kernel.org>
 <0c221abf-de20-4ce3-917d-0375c1ec9140@redhat.com>
 <20250407044743-mutt-send-email-mst@kernel.org>
 <b331a780-a9db-4d76-af7c-e9e8e7d1cc10@redhat.com>
 <20250407045456-mutt-send-email-mst@kernel.org>
 <a86240bc-8417-48a6-bf13-01dd7ace5ae9@redhat.com>
 <33def1b0-d9d5-46f1-9b61-b0269753ecce@redhat.com>
 <88d8f2d2-7b8a-458f-8fc4-c31964996817@redhat.com>
 <CABVzXAmMEsw70Tftg4ZNi0G4d8j9pGTyrNqOFMjzHwEpy0JqyA@mail.gmail.com>
 <3bbad51d-d7d8-46f7-a28c-11cc3af6ef76@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <3bbad51d-d7d8-46f7-a28c-11cc3af6ef76@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eDmAD6bROYSe7LJxzA7tZI9tVZXrNCR8LNRIKKdt95M_1744060810
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 07, 2025 at 08:47:05PM +0200, David Hildenbrand wrote:
> > In my opinion, it makes the most sense to keep the spec as it is and
> > change QEMU and the kernel to match, but obviously that's not trivial
> > to do in a way that doesn't break existing devices and drivers.
> 
> If only it would be limited to QEMU and Linux ... :)
> 
> Out of curiosity, assuming we'd make the spec match the current QEMU/Linux
> implementation at least for the 3 involved features only, would there be a
> way to adjust crossvm without any disruption?
> 
> I still have the feeling that it will be rather hard to get that all
> implementations match the spec ... For new features+queues it will be easy
> to force the usage of fixed virtqueue numbers, but for free-page-hinting and
> reporting, it's a mess :(


Still thinking about a way to fix drivers... We can discuss this
theoretically, maybe?


-- 
MST

