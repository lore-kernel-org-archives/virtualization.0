Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298911F543B
	for <virtualization@lists.linux.dev>; Tue, 21 Jan 2025 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737480629; cv=none; b=Z8+KM2EYm5mZGoGm2fN4oDAwr1aiBZo4E6ZNmgwHuWGG+VgLmPEQPGtzc3QNVYJVIAfM5F9ESe6Fq8ViFDwBLPAzwYKFVV88HDb3YefYBy2F1ZR1i3S60SSjVxtjBUlDTY+mxBJ+QqJInnMpuScp5KgaLII6lP4zDNzw711lBOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737480629; c=relaxed/simple;
	bh=+XqZ2mIVewpWYnLioiQaGxFPazonOEuVdIMJXoMPQ2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jr671w94EeWqiCHCKflD8wLGXf/Ws7QIQcAI8pMrn08PONAUbJgSvmO584u6UfktgRGhaXGplAoBDihyJHDz8ijBcz+qbAXchH6z33qLFF30GsZ9vdKllHXFJdSMZ3DhNRVi9TRXJIjq62lASIRmfMRWjdhi6qjaGcOqb4DHHYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XCKQbcJv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCKQbcJv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737480627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Ohl61oQvrjRs6MMIBMI/1E+/f+GFIL7csbNfKFkQbk=;
	b=XCKQbcJv9lT5QorBXPb1FYfvOqrOsFC1Y/WkNtg0hbMlhrG70iLWwMEVzt8LBtxrDDLJkT
	8irVrC/gQH2AIbo6avkRoYpO0tVvi+A8T6zA6uHkX4ldt8xodP2TWCRtj7bMsj/3xZyrTm
	WGcyyFtVgZgjW5D11nxOMOfBkpIVuqs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-5yoWfAX-NSSM1dfqwKpN3A-1; Tue, 21 Jan 2025 12:30:23 -0500
X-MC-Unique: 5yoWfAX-NSSM1dfqwKpN3A-1
X-Mimecast-MFC-AGG-ID: 5yoWfAX-NSSM1dfqwKpN3A
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43624b08181so43325e9.0
        for <virtualization@lists.linux.dev>; Tue, 21 Jan 2025 09:30:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737480622; x=1738085422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ohl61oQvrjRs6MMIBMI/1E+/f+GFIL7csbNfKFkQbk=;
        b=ltMWwPUwqWOQiE6HginruUFXB1xx5hJyYwaoXnGYsBfE2o73CsC9/Zi0UPqJgc8P+t
         748rAmd/ENYH+9MB/VqPj+bLtIyVcsG2PcM+iAyHw+UK/n8JJ3uEmeMXh0rG4KQqpGtF
         fUyTnourAJRhi1pZ2rJcuNu2pNf4whcPzmJWhYcxqU8hTJx5lPFFG9UgSkwJKGeLS15Y
         sZvpWiKN1TjRkjTcS6uTmaYIfO7WvjCM/zJeSFOm3u/bMVDTM7pZ6uoUfrNN634J2mOd
         OeWYvfgqEUDD4qBt3ymn4la5PpTTEt+BrtqCl+6KyWNhW/DsQYg+6RtT8GMPzgKOyZMM
         ZMvA==
X-Forwarded-Encrypted: i=1; AJvYcCX92FiBWnxT5pUtwoQ6n3WPXGoi70uhhxLeNG9ngIvpAgFD665xvffO6Y2icM+6OePsp3eqU/sZVggE4AQJUg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTV8Gp3/vCDrg8nClyZ4Q8638War0xLiFKgKhb3a8lYergGv23
	NO/Oq/tqMNY1yts6ycXLfmVP4fuP8RZCtdxYDCFwhq/eLA5m7Shd80tlV023DgZjuzm66SYHWOE
	uPNwbZRfHHkqnR4cRqQ6PvDfxeJ6XocQZhgUoMPQZybyLF6DUh6t+RPIl5YBvUdAk
X-Gm-Gg: ASbGncuJzZlBtn+m+BxTnSRB1AeZTmoGhA5E2UtnbVYstV60XlR80Eijc0WsOeXWDEg
	+FxKIZKbOoOpNUz2ZSDGH6AGVAnVaHE7rHQO4eJuMVt6kBLphHPBkEftByAPW0qd/i8mqsT/xAR
	cBTv0dFHki7vfR70geFpH5YRF6wZCXAxfcVC1C+uBWVFJPQXSIVGUZI6eHQDhKkO/FN06rhj20M
	lgg0SyWXZTazrH0bvSGrcma9bu/bixH5gEoZsd+XwvyRfmJPF6De+nL+YeOKcdGvOgNh1/BVA==
X-Received: by 2002:a05:600c:3d89:b0:438:9280:61d5 with SMTP id 5b1f17b1804b1-43892806237mr136001225e9.5.1737480622515;
        Tue, 21 Jan 2025 09:30:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOXs9Ya5kOuP/W2rM4xk+vm5PSiTxIW1zce/YaupUUzohswvYEtJM6u59IjkgPls10nttGDQ==
X-Received: by 2002:a05:600c:3d89:b0:438:9280:61d5 with SMTP id 5b1f17b1804b1-43892806237mr136000975e9.5.1737480622163;
        Tue, 21 Jan 2025 09:30:22 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890408a66sm190273065e9.5.2025.01.21.09.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 09:30:21 -0800 (PST)
Date: Tue, 21 Jan 2025 18:30:19 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Wongi Lee <qwerty@theori.io>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
	virtualization@lists.linux.dev, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Hyunwoo Kim <v4bel@theori.io>, kvm@vger.kernel.org
Subject: Re: [PATCH net 1/2] vsock/virtio: discard packets if the transport
 changes
Message-ID: <blvbtr3c7uxtbspbfwrobfk7qdukz6nst2bnomoxbltst2yhkm@47k6evsdceeg>
References: <20250108180617.154053-1-sgarzare@redhat.com>
 <20250108180617.154053-2-sgarzare@redhat.com>
 <2b3062e3-bdaa-4c94-a3c0-2930595b9670@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2b3062e3-bdaa-4c94-a3c0-2930595b9670@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ifAqMikX6hErN-wDd9566n7FpO8NBL_YkXhheLCde3g_1737480622
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jan 09, 2025 at 02:34:28PM +0100, Michal Luczaj wrote:
>FWIW, I've tried simplifying Hyunwoo's repro to toy with some tests. 
>Ended
>up with
>
>```
>from threading import *
>from socket import *
>from signal import *
>
>def listener(tid):
>	while True:
>		s = socket(AF_VSOCK, SOCK_SEQPACKET)
>		s.bind((1, 1234))
>		s.listen()
>		pthread_kill(tid, SIGUSR1)
>
>signal(SIGUSR1, lambda *args: None)
>Thread(target=listener, args=[get_ident()]).start()
>
>while True:
>	c = socket(AF_VSOCK, SOCK_SEQPACKET)
>	c.connect_ex((1, 1234))
>	c.connect_ex((42, 1234))
>```
>
>which gives me splats with or without this patch.
>
>That said, when I apply this patch, but drop the `sk->sk_state !=
>TCP_LISTEN &&`: no more splats.
>
Hi Michal,

I think it would be nice to have this test in the vsock test suite.  
WDYT? If you don't have any plans to port this to C, I can take care of 
it :)

Cheers,
Luigi

