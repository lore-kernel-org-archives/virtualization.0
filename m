Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D133B583E
	for <virtualization@lists.linux.dev>; Thu,  7 May 2026 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169918; cv=none; b=VXgst2PxL/OElE2892aFcZJzgWq9cimZ9MdetXSqfTD/jEOLXX3Ehm0xchFFVzO45DGry6S8vAhcZtsQZ0FTCO4fGIFRyrSyyhgwKUlkyuO4mkVFlaAoIaIooLLva7cSRdQPumv/5iNlql1dpQ7plul/GIUyNn4IY5Py4/K3Wd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169918; c=relaxed/simple;
	bh=sZ79yV65rGcfZNXlNxRvakvY2Z8WmdeNfaJ+WX7yPAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Zx32J4uWoyNXwvP27IpfGhuVfHTi46FgzsZatAyL0Tn0FAcI096t636vApruYV/7vvgSurCvk1Pszd4GTfcjg8265aqlV1yfmK5542/xnbQauBvi6QfQlZRiV94DAVuE7ItoiS0m9vJkO6JBY4RK56mdaIxJNXaTWw7O6vdKMxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XGaxOrcd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGaxOrcd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778169915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SMkAzYz7L2YKNDrmJwl9k395tnV77yLFqHt9dixreVQ=;
	b=XGaxOrcdhj9tv/oASFZ4TED5Gm4l3yA1FbP9y2L0DmpH8Rhfm+DT78M536oWQobq9ORQmS
	Iy/HdFrURi/cJv/HEiyWAyZcisKI8uHI9snzBHEBnfl9etRhqFyW2Jvzaz7F816c8y6a4s
	6p/WjcEdz8yeZTR5GypMt84yEsVDKR8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-MnCyKtbWMaaiwNTlLQJ8uQ-1; Thu, 07 May 2026 12:05:14 -0400
X-MC-Unique: MnCyKtbWMaaiwNTlLQJ8uQ-1
X-Mimecast-MFC-AGG-ID: MnCyKtbWMaaiwNTlLQJ8uQ_1778169913
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48d05e7b117so9177895e9.0
        for <virtualization@lists.linux.dev>; Thu, 07 May 2026 09:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778169913; x=1778774713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMkAzYz7L2YKNDrmJwl9k395tnV77yLFqHt9dixreVQ=;
        b=R0E9XuW/A+vMrh5R8CO6d0gU+TECbCXGS5ldDZmF6CTJ0lxbpF66CHWzqVCt2UHPuC
         wVg4mkquFh244Iz4eiZFw7/X6cHRIorTVLY+obiTtHDwYyPvuXUvckhSL3fAfsRLp4jW
         bOq8NBXejG+N2XDv91oF6YGFVbeXucaS6byfSkSxW5rZfh/rSTGA4+rgmDM3blxaqv1D
         gFhZSOjfKAXA3AnwMtnxRVnay4I/PrvPwUCjTWeDhFyXgmyF4WCrcGSdSPGTEDggBeiy
         xXNjQAZUVzBgv0gbrixqPJ7s5nwQTCOAVm89lIE3+LYSHzHiLU2SnCei1v7XCSZa0gb3
         2X9w==
X-Forwarded-Encrypted: i=1; AFNElJ9CSzWc3qoATtqOD4/g6i+AZQBcHp9WBSAgJS66Ipi23FWBd/GQxmviiFePUcWhjbsZgEs5ZHNuXBQm785ZhA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7xRhOSHZpu+u5bFQTn93Xy3SiQkcTl3DCRnLdSJ/qNPSQQjJO
	Y4kJIt+cI00QAluJBfX+apsnkOabGzbJ4LCH5I5iqYIy0G8fpjg0+lkDeIJSxggrS6nOKPt9LLH
	hRqJ6k/XmZIYfwgUDWWLGj6HqTjslg3MTrXqoMzDcKS/xRIymblhgOKcA+c20fYtkXj+k
X-Gm-Gg: AeBDiesXuI9g3XxTkQ+O113r0YLgXjrQtcwyQjyGxx/3EcuVWfTtbQEq2QV1SRmZVJo
	pP2+Wpeib7qrOYb1ZMOmtAUd0g+PA+k0Mq8mUxdnRuA3OJXyQfIO2Dfvh0L1O12VcbQU96RjyIV
	ixzrI0ImyqsaEsI+YmW1LPPVtrmbqlIr8Gq3t+8bhNoHeEFC2lwTzpiXcimbhtqtLJ378oeBtKv
	bTwTRPuD0h4TaY4nc/6EpvVly49LKlTyOQgpyWUA4ZhDqol1sKScvqhCYSvD3eiZGPss3Q939V+
	G/CVDlfdC9myh0t3KS34CdjBinZpyYmLXXvLmSeX+aKq5QAKg4fTcoyzsztIDxOGF2mUglcBLrC
	6kUFTVu8cEHGeohfOL5Pw1wyJ7Hl3SU6w/1L0qH9t4eaJxDiKv7/edjQ8UFthQjs=
X-Received: by 2002:a05:600c:4888:b0:48e:526e:1012 with SMTP id 5b1f17b1804b1-48e526e10a2mr74268905e9.5.1778169913222;
        Thu, 07 May 2026 09:05:13 -0700 (PDT)
X-Received: by 2002:a05:600c:4888:b0:48e:526e:1012 with SMTP id 5b1f17b1804b1-48e526e10a2mr74268215e9.5.1778169912467;
        Thu, 07 May 2026 09:05:12 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538a547bsm145700815e9.5.2026.05.07.09.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 09:05:11 -0700 (PDT)
Date: Thu, 7 May 2026 18:05:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <afyy9CeniTBF3o2I@sgarzare-redhat>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat>
 <20260506113554-mutt-send-email-mst@kernel.org>
 <afxVH2So9BbZ3Gta@sgarzare-redhat>
 <20260507074113-mutt-send-email-mst@kernel.org>
 <afyMCyBvZpzWrLtO@sgarzare-redhat>
 <20260507073340.0604667d@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260507073340.0604667d@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jZYDBzosaWbmKNVXmeVBhas5ZGGagdkajq-FDG54ero_1778169913
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, May 07, 2026 at 07:33:40AM -0700, Jakub Kicinski wrote:
>On Thu, 7 May 2026 14:59:13 +0200 Stefano Garzarella wrote:
>> >well if you want to support pathological cases such as 1 byte messages
>> >that would mean like 100x reduction no?
>>
>> Yep, but since this patch is already merged, IMHO that is better than
>> losing data in those pathological cases.
>
>We can revert if you think that the risk of regression is high..
>Please LMK soon, we can do it before patch reaches Linus.
>

Some tests in tools/testing/vsock/vsock_test.c are failing with this 
patch applied.

Test 18 are failing sometime in this way (I guess because we are 
dropping packets):

18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch

Test 22 is failing 100% in this way:

22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed: 
Resource temporarily unavailable


With my followup patch adding also advertisement to the other peer 
(still draft locally, waiting for Michael proposal) I saw 22 failing, 
because tests expects that can use the entire buf_alloc, but now we are 
reducing it.  So IMO we should do like in `__sock_set_rcvbuf()` and 
double the buffer size, or at least digest an overhead equal to the 
buffer size set by the user via SO_VM_SOCKETS_BUFFER_SIZE (yeah, 
AF_VSOCK has it owns sockopt since the beginning :-().

With that approach tests are passing, but I'd like to stress a bit more 
that patch. I'll send it tomorrow as fixup of this patch, or if you 
prefer to revert, I'll send as standalone.

Thanks,
Stefano

