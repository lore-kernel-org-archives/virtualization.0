Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEE73624C8
	for <virtualization@lists.linux.dev>; Thu,  8 Jan 2026 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767871684; cv=none; b=N3/qo5GJZbqGkKRBtwibaBuNwwgqh3WPhM8Ojy72IEgYHtkT3/1xF/bQisLTP5OcHZ6R9AM6Rlf5ZbAKvr1fG2qCtyuIk2XA3k+WIBvaBpUDCc16NeOqPLbdyZndK6aAOIOhbZfgmj3q62JchC/QjaGT1nLYl02i0JVB9upR2kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767871684; c=relaxed/simple;
	bh=DXVRxgEjQyIFhLiJRSIIYHf6s0Xh3efyK6PB23H68Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VCHjo9EbyWA9I4bJLJgh0SB7tMby0U3Ee5uGJVPoArCmg5ehF5ATCI+P8f3jDBHfAGHbGuasjTgFB9tkDgWuLBztQcSZp7FFb3zaaNwbDWlhfcKfY67UG0AXF1kdWrlsvOYjVOYHj3D14DBlw3bzSR8PayZuBZKCUqtMtAXLNcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L5NxOPGI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5NxOPGI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767871677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7OLB5of9LH4Xgr0g/cKdpkyNCBxF+ZVgPMqVenfELd8=;
	b=L5NxOPGIiRdF2bZSmPpKqG5VIrOJj3g4HoqpVpmFuYRvQI3Jp+l4qkYEtm0NPSkAWb+k/m
	phAeB7Mie74CWqmiFWe/XjPBIfaLyIKDsChELWRFdLIkg/Tcirlgd6iTmlYx0+tH48s36p
	gEnFTHuCRTdmlzqxZ3KFt4nbXP91DwI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-q_ur3TSmO8SN_Oko_qcuFA-1; Thu, 08 Jan 2026 06:27:54 -0500
X-MC-Unique: q_ur3TSmO8SN_Oko_qcuFA-1
X-Mimecast-MFC-AGG-ID: q_ur3TSmO8SN_Oko_qcuFA_1767871672
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477cf2230c8so29268335e9.0
        for <virtualization@lists.linux.dev>; Thu, 08 Jan 2026 03:27:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767871672; x=1768476472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OLB5of9LH4Xgr0g/cKdpkyNCBxF+ZVgPMqVenfELd8=;
        b=HaexyTjFs51O1GcetR5c1/0WBBgEM5kwfMata3S/hp3/dQW6fcGS2ynt3u3z1giCZ5
         RPVg/z5uyDiFg9VIPcY4b3KHXmcm0BeGDBG0taJR+wrFICyRSmJAJ2GIbvJPTmYPjK0o
         PXyIOPJJCnVlnuiLCUQFl+9yqayev0aWmAovbOgKH8B5izU70dB53Yg20+GS1Kp9PSI1
         Yg6pT4GB3HqNRPssvFadZxdb/K1bUTOfrcZ1p6+NmAq+dmQAb4CGkVanLRcGjXnDIGAI
         cJoH32EJ2jwRoKj6rs3ouFfN7UOANmioLKephzd0zTP5q+UNRibIUg6oQlFOvH9ezY/Y
         JfPg==
X-Forwarded-Encrypted: i=1; AJvYcCWVr9SUGh+mCRRK7JpZAfSq2VjtYFaLqf7Xg42meZKC60/VEjG+h/eAz5SJOOV2+S7wTlwvvPA+DlGzTXd1og==@lists.linux.dev
X-Gm-Message-State: AOJu0YyxjRI4tNuSgthW2QcCNDqQ/0jO30X4ScyJg3i5tyhLm2RxMfT2
	zWyFy6ny5j5Ag4Va9otxvTD2DxsXs2vsaTBYiCc4cFpqklWwuuK1BXbL5LVV+W36XxDlHlt/3Cg
	RpYyWRWlKnjfM24d9mtn0J+s2takyu6zbIyPdOljuvIbiOmpCd8DZ2T2Tk4SLXuvuiRPx
X-Gm-Gg: AY/fxX7Uxw7nXM+IdJn4N+4tiUJiEwpqpNAL4goC9uIqd8186oCcE+eK2gtAZt6GigC
	BjzEnAYMn8Hi+qVLNiCCQ4b5ox7HEkZvkl/fvGPldy5257AIVqAMHuG1/QMUQxjnNU86Un/T8Ei
	E1q2JuLS+YTdR+9yKr11c7WkiQBJ5hX2UZrKY25WPDdTNPVggeqJbt0nssCEGz01caPDjyT0gFm
	+mYTw1bdSXWJWz+WVg3KqY0K3syYiHJKlcThGbCujU36W7mUzYt7v1JJsRB1OpMpF9fykA4Kwyg
	Vmm2lD662I6FiyzgvanOJrKnBKe0Nuy+xtYTzfw+SZBfnvUpWsbU7Ut+binrZypGF0vyv/k1dnZ
	awRHJtBlll5VWMPyl
X-Received: by 2002:a05:600c:648a:b0:47a:9560:ec22 with SMTP id 5b1f17b1804b1-47d84b17ae4mr64276225e9.14.1767871672376;
        Thu, 08 Jan 2026 03:27:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCrhVJUOXGI01OCCuWHNzKXAge7t6WHbeU8FiHMv65fBH2sXqaXVpMSUa0Er0tnD1FeKLcmw==
X-Received: by 2002:a05:600c:648a:b0:47a:9560:ec22 with SMTP id 5b1f17b1804b1-47d84b17ae4mr64275905e9.14.1767871671965;
        Thu, 08 Jan 2026 03:27:51 -0800 (PST)
Received: from sgarzare-redhat ([193.207.178.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f668e03sm154398805e9.14.2026.01.08.03.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 03:27:51 -0800 (PST)
Date: Thu, 8 Jan 2026 12:27:41 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org
Subject: Re: [PATCH net v4 0/4] vsock/virtio: fix TX credit handling
Message-ID: <aV-UZ9IhrXW2hsOn@sgarzare-redhat>
References: <20251217181206.3681159-1-mlbnkm1@gmail.com>
 <xwnhhms5divyalikrekxxfkz7xaeqwuyfzvro72v5b4davo6hc@kii7js242jbc>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <xwnhhms5divyalikrekxxfkz7xaeqwuyfzvro72v5b4davo6hc@kii7js242jbc>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qmVDCG7qFMQ2Pl3_RR3T1K2dhllVV2FLQXkRcL4R_c4_1767871672
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi Melbin and happy new year!

On Thu, Dec 18, 2025 at 10:18:03AM +0100, Stefano Garzarella wrote:
>On Wed, Dec 17, 2025 at 07:12:02PM +0100, Melbin K Mathew wrote:
>>This series fixes TX credit handling in virtio-vsock:
>>
>>Patch 1: Fix potential underflow in get_credit() using s64 arithmetic
>>Patch 2: Cap TX credit to local buffer size (security hardening)
>>Patch 3: Fix vsock_test seqpacket bounds test
>>Patch 4: Add stream TX credit bounds regression test
>
>Again, this series doesn't apply both on my local env but also on 
>patchwork:
>https://patchwork.kernel.org/project/netdevbpf/list/?series=1034314
>
>Please, can you fix your env?
>
>Let me know if you need any help.

Any update on this?
If you have trouble, please let me know.
I can repost fixing the latest stuff.

Thanks,
Stefano

