Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73927267B15
	for <virtualization@lists.linux.dev>; Tue,  6 May 2025 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746524795; cv=none; b=NRdQGD9Vi8HpE50opBJtnKHNwCCwkVaI/F2atI1xnIzy55jj9KSrpkTMeKS07CvuCa7VBDeev2ZoiwJcWveggUNONAzPQsUeXFW1GBEF/VlYigGwhr7wEaFRZ7Xx/V62OAsIgA/LX0GAqqmr6R22AbfQvLB7gTdq1t4bof8ftaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746524795; c=relaxed/simple;
	bh=tA6N3YnyAi4SY4a6Jf1gNb1Di0YDjYwF9O0IKocrk4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcoLtB2qovC09xCvWpG4qeciJuy/GVyqFbc57mx8vgYwIwWsIUhMSUPLVAfCKcvYlPFrzOaK0PSyzAbCquMI3dGevkbvM1mhaC9vOT0rQokXWQPHtMXfvPS3zUPjwbaFid9SkxwcPSGGwpNpmV4sYVCz3uzOfw/cuxXyX6/NzrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XBgPFrZH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBgPFrZH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746524793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tA6N3YnyAi4SY4a6Jf1gNb1Di0YDjYwF9O0IKocrk4Y=;
	b=XBgPFrZHgi7kIzFg08Q6cni/KKcT4+WWcbRLzQHP6suDYGZUjX30o0M8fRvPEb4765hG35
	mR9McwNYUvCPpozww89znLesju/2COhzXqfgliUoUIttUdKAapgesI99oCQdKmRczbIvPp
	x8Icz70M7CsQXDDVyN4vcpKYycFVPTs=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-swLoKJjsOryzWWbqY2kYpQ-1; Tue, 06 May 2025 05:46:30 -0400
X-MC-Unique: swLoKJjsOryzWWbqY2kYpQ-1
X-Mimecast-MFC-AGG-ID: swLoKJjsOryzWWbqY2kYpQ_1746524789
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7082d8db9bcso70222987b3.3
        for <virtualization@lists.linux.dev>; Tue, 06 May 2025 02:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746524789; x=1747129589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tA6N3YnyAi4SY4a6Jf1gNb1Di0YDjYwF9O0IKocrk4Y=;
        b=gr92EG+xW1JnIgCtllwrgKt21HM8DElV0llLBObu8Gg6JZR91FwsFOxLU2OxzPLC2+
         I/GVxa9PaTlr7a5mSai7YyYozec6eIBQR9y7PLLLb3VH4TkztsGtZhCX3gMDibVAuBSP
         Y44CgAYHt4wVJucB3IrqvJTLU64tFohJJJzFXMPrNp4aOBsDdKsuax8fs4XMLIgjZwQ2
         Ty9C2OtLjCSUp5Btjt3Pe2zblU9vkuXuozNGjU8oaAJLmEvp1NMOhtngFT5Yz8iTFJSH
         8W78e4ub4kFZ+U8//FnUiUuGB02fonj02MIRfCOkZnAvu8Vu4XmTPjRmv5LP6eMlnNe3
         k+Sg==
X-Forwarded-Encrypted: i=1; AJvYcCU5k5tbwrHiGm+iVuFgKWXGjzo5JSa+ox6j+IhCLGP3pdfzJ8HUEkg34GHwvKnab4QLbJyCyplb6tAh5yWrPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzowQHjgPiLdo6Gaq3b3Kx/Bx51/MWKbYnCXoBLZio07yxuAulN
	87nC0UUcTCmIsNrZNLGuFs4qtPgBfSiLNwUwWZ0klZJ0pVBJMJp9jltjEwx9lj09/UY60xr6nZh
	VGLKnrc5AU+ykfErjT45ninh/peUMFnXrTBshLyMgcoge6jE79Lb49Kwy33XlyIjtIxxxiL35K7
	Cd5i91xPUImGYCCz8RUP/TVqxVMFT4zg7sujWA3BA=
X-Gm-Gg: ASbGncvTVmRYRiRRMOxpN7XQNPsoIGj4+tjGqDdqsWCgWL83N1PisqKAKm0t8uOO42f
	cgP9IveMRdYVDu2D4DGZ3ZSmj+BAwTjOTPQuSGn0+q4/fhA8iEY95c0CelpWluMty/OlCWN0=
X-Received: by 2002:a05:690c:881:b0:708:b7c4:89d9 with SMTP id 00721157ae682-708eaed228dmr161341827b3.11.1746524789550;
        Tue, 06 May 2025 02:46:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8SnKlOiGYxAIgFjpIz/3a6Amq4RJJRae2tHMUWHhFAEAWBZQzJ97jvAOQKqp6vtJokq7tr543XXcIaZE89NQ=
X-Received: by 2002:a05:690c:881:b0:708:b7c4:89d9 with SMTP id
 00721157ae682-708eaed228dmr161341627b3.11.1746524789214; Tue, 06 May 2025
 02:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250501-vsock-linger-v4-0-beabbd8a0847@rbox.co>
 <20250501-vsock-linger-v4-3-beabbd8a0847@rbox.co> <g5wemyogxthe43rkigufv7p5wrkegbdxbleujlsrk45dmbmm4l@qdynsbqfjwbk>
In-Reply-To: <g5wemyogxthe43rkigufv7p5wrkegbdxbleujlsrk45dmbmm4l@qdynsbqfjwbk>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 6 May 2025 11:46:17 +0200
X-Gm-Features: ATxdqUGB2JgQGBx1SBATpWkN34LfUWNEz6bg2h7UGX2v3-s9HEuTp1ypMzGQ-9I
Message-ID: <CAGxU2F59O7QK2Q7TeaP6GU9wHrDMTpcO94TKz72UQndXfgNLVA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/3] vsock/test: Expand linger test to ensure
 close() does not misbehave
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: P9MCYxcCkiZXo24LhvjnyTmas-XPiOyIiETeZmL3De4_1746524789
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 May 2025 at 11:43, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Thu, May 01, 2025 at 10:05:24AM +0200, Michal Luczaj wrote:
> >There was an issue with SO_LINGER: instead of blocking until all queued
> >messages for the socket have been successfully sent (or the linger timeout
> >has been reached), close() would block until packets were handled by the
> >peer.
>
> This is a new behaviour that only new kernels will follow, so I think
> it is better to add a new test instead of extending a pre-existing test
> that we described as "SOCK_STREAM SO_LINGER null-ptr-deref".
>
> The old test should continue to check the null-ptr-deref also for old
> kernels, while the new test will check the new behaviour, so we can skip
> the new test while testing an old kernel.

I also saw that we don't have any test to verify that actually the
lingering is working, should we add it since we are touching it?

Thanks,
Stefano

