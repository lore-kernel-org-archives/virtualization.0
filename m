Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7673F12D3
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Aug 2026 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996597; cv=none; b=cVppxsSmM1YAcbVSQvuf1FT2EtCmK+48N7pjnGHNoTz7rpXb102lxwlHLeLlTrWS0WG3XZ1Dv13jvcvigW4+ykNm0UOYSQo16+I3S0f3TxWQGZB8T6T/Vyg2+rN9NbTwDFRfFs1BnzaDTvQB0gYa+cS03IsdPAJSZDBhGYvwCns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996597; c=relaxed/simple;
	bh=MPUMAyaoXA+ATmNEWYMduJ0U43rj2zACcDoE42A3bWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ja51vwaD9GWy3/A+huP/hRCNBP8mIhKxo6L6Vr672fFSYc+xAsTzohjJUkPEbAtTeHakYWyXWCP4iIhhgUEb74QmAAvD6HTnIPREN1f5NvBcKi2ApOncExyaFRvAsqUEpqno86lh0rSm7/dhtVXXaMERCUy6RzaoTwQIISDKwnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F3EokeXY; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3EokeXY"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57A2C8111A
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Aug 2026 19:56:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.794
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oehJrq_fr-U4 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Aug 2026 19:56:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8C669810F8
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8C669810F8
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F3EokeXY
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C669810F8
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Aug 2026 19:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786996534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m6qoLRi3d/qgKme1hLFtPPwOyg4guDiZooOy9zIyOW4=;
	b=F3EokeXYvbtfCSjdzzFNrD3qxjr+Jr+23DPjLXO9M7i7wXlgQPEddoF2JuvNI9c0IQ97mV
	o5e2el2/eQT2ob3JwvGvGH/wC4iAihc/ryRMtXgMUX7ptxaaCZF52DZirxBZY8N2iBLBA7
	xh743jO5QV27gEcY96fBPH/0ZAeBylM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-MT0vbMPFO_W57B0TB0Ir6Q-1; Mon, 17 Aug 2026 15:55:21 -0400
X-MC-Unique: MT0vbMPFO_W57B0TB0Ir6Q-1
X-Mimecast-MFC-AGG-ID: MT0vbMPFO_W57B0TB0Ir6Q_1786996521
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4954fd771baso1043265e9.0
        for <virtualization@lists.linux-foundation.org>; Mon, 17 Aug 2026 12:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786996520; x=1787601320;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m6qoLRi3d/qgKme1hLFtPPwOyg4guDiZooOy9zIyOW4=;
        b=owc3Y4pOhkDjx4lM38ld6aCXpTG7JZWhwGnsWLQdmJnbz0JMElYiXu89Qu86FFK3og
         /S+D/zPsCkcJ0GprIhhp3Vue/Sgx3aIPBGM2EqFsK1q91zwvPOtYjaMSJj+K6ElflI5q
         nwKPSD7Dy1mKwSrDoXEfiwx53dK+pwLZalfCdJ8JKuFuLLn/AkjjI67QbblKQqPmizl8
         lrbr5CzFY0pcBPPgsRuXjue/UEQkRr7GWrFx+yWcU6q9Qc6qXmSrE3H0/tgkmP/Wckd+
         9KD0mV30TOP+2QlhZiM0nTJG31zl8X5tFMKoTW+3WGObmTvwOR5mkFvZXqwuCOTNoW0Q
         XoSA==
X-Gm-Message-State: AOJu0Yx2w7lH3mIBKT0C456uVMH4JXJ7/xrY9ryuNJtgQ5HnHBNdh7+D
	vRuaNFTGn7W7NDD+y+fX/9gJYvo2SF0uoeqNnZHeKx88fq/I5U9G6v8vd/3knEwqLlijNx8OQZp
	Fu/q2VYQMcnY7GowI44a6MjV2/Sf36LukGQZXGY62SXqsfNzyTxOag4a+97zrPxAFzuQ60m2HMq
	aO5ih4AEQ=
X-Gm-Gg: AR+sD10z76PTgEBxVsWJDsCZMhtUmpgxRFxxmzFIvCe3DxcCq+U1/+eNiymbQretgEm
	N+rDwqrz9CKIrf2ONTp5NsqPIMY+i8Ow/x0vfbCMKw+FtYczp7xbNtUrl8QospgxP/c72Q6+eZG
	Mb19Zbj8uKI14AE1rI2lBlDQiEs+ASqZ5NFqiEoZzOyFqCnKFX8W9XgwKi5dMMCPcNiORB4Tjvk
	zWIgixM8DUeirrAeJB3EEfgaw12vx9/FFxYgw3HMcFtHYZwOHj4O0HRVnqcLIMf8UVWFlnC1nkj
	q8JakIKVOOHY9KIRGJC9hKRDLq7zLtWBecU7E+c5gQek+BYox8fXZUg46h4uo6bVq6g8tW8WQsC
	hqCKtcgxMjjqrLd4PJZiZPfbx
X-Received: by 2002:a05:600c:468a:b0:499:596b:2e91 with SMTP id 5b1f17b1804b1-499a205b082mr2234165e9.3.1786996520331;
        Mon, 17 Aug 2026 12:55:20 -0700 (PDT)
X-Received: by 2002:a05:600c:468a:b0:499:596b:2e91 with SMTP id 5b1f17b1804b1-499a205b082mr2233655e9.3.1786996519868;
        Mon, 17 Aug 2026 12:55:19 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-107.inter.net.il. [80.230.47.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996100184sm215978925e9.1.2026.08.17.12.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:55:19 -0700 (PDT)
Date: Mon, 17 Aug 2026 15:55:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mirza Ishan Beg <seedandsyntax@gmail.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH] virtio_pci_modern: replace msleep(1) with
 usleep_range(1000, 2000)
Message-ID: <20260817155125-mutt-send-email-mst@kernel.org>
References: <20260816173806-mutt-send-email-mst@kernel.org>
 <20260817170331.219615-2-seedandsyntax@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260817170331.219615-2-seedandsyntax@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VMoAu11kcQNe8gJ0swd2eCPZCdPQcJV-V-woRj6Z0cI_1786996521
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 17, 2026 at 10:33:31PM +0530, Mirza Ishan Beg wrote:
> On Sun, Aug 16, 2026 at 05:38:06PM -0400, Michael S. Tsirkin wrote:
> > why do we care?
> 
> Hi Michael,
> 
> The motivation originally came from a checkpatch.pl warning, but looking directly at Documentation/timers/timers-howto.rst,
> there is a practical penalty here.
> 
> The documentation explicitly notes for the 1-20ms range: "msleep(1~20) may not do what the caller intends, and will often sleep longer (~20 ms actual sleep for any value given in the 1~20ms range)."
> 
> In these queue reset loops, using msleep(1) means each iteration may be extended to 10-20ms depending on HZ and timer slack. The document recommends using usleep_range() to avoid this overhead and provide the intended precision.
> 
> Let me know if you'd like this explanation folded into a v2 commit message.
> 
> --
> Mirza

I don't think we care anyway. We probably just want fsleep?

