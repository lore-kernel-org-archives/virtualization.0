Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143EC1EC018
	for <virtualization@lists.linux.dev>; Tue,  1 Apr 2025 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743508592; cv=none; b=uN/rJuUJfdc4o5sdbifSNHEgiZWFyf5BKxHJaVrAjFbrIgDCLTpSQ69/ayHtfmGTud8ck8N5kTWzIk+rzHLVtcDyd12TtWBgY9jKTAoL75ihSs+J6a5sOJnzU+hEIzwrTU06tmOOL+MIMmIu4XO2007bGVgUIxdlOk1fz9dDvi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743508592; c=relaxed/simple;
	bh=x7czy4UI9IbqMfgh6Sv6bpB4w4cV0fLNV/AFpcTrzek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RcXORHcrbFUv6s59wgb4OuzYWZyCw0tJaOM5lnu0gs9YQ+zAcob9FsI0oPV2qsIhO9MF3nT6PY48ZnEBgezNs/Ex7kPiTdzbjKorH/kkD6etiJjI+Y3O5o4AKVXoeOE/jbNi1r5Kykms4VQow0GlzI/1kOvd7Or2U07xD6Mpl6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EP18LBcH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EP18LBcH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743508589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l9OKWbJaDtqVih7gFwHKrfvK0bj/Hx7MnBlxug/FBXA=;
	b=EP18LBcHRXouzB8xmt9iBK23m6tpVhTpk0SWzoRoL/shlOhG/VCMDpJSp5Hwz13aLeYaBe
	bWh629vm6LYZzrQXqQjuLlaqg/5AhICebqidWZJf2f86vaztuVk3zan/9x2uBvlslH+voT
	FkAONCeCxGJxlSjLqh3eNjLqRJw1BJw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-Nk_z2cZ_NgqrM3QEefzHvA-1; Tue, 01 Apr 2025 07:56:29 -0400
X-MC-Unique: Nk_z2cZ_NgqrM3QEefzHvA-1
X-Mimecast-MFC-AGG-ID: Nk_z2cZ_NgqrM3QEefzHvA_1743508588
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39134c762ebso2263734f8f.0
        for <virtualization@lists.linux.dev>; Tue, 01 Apr 2025 04:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743508587; x=1744113387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9OKWbJaDtqVih7gFwHKrfvK0bj/Hx7MnBlxug/FBXA=;
        b=aKg884NhzzpUgMbEFxSCgH0Vd/Vvp/LC6fhrilnRfQNCD16aCC0bZ+DgKzo7Xqk1lV
         rcbxytxHNgSAlBRuXBFFyX3GKR1TTta5f+oJU+BFgvslXjYHOTbGd0B9U4AKgn5AdSeY
         2zirX/DVrKtCu6bnVVTprIBF/88rE+mTd6MeGFGmpiNeaW2M6kGSqgjPwg06jn6aDqyq
         fExGpGqUmiz43VAUd0DWSIbB/X2NiBC+/p5UUPqKprn2NcWAw7T+MvnMP/gkl/9PBx7U
         K352Q3koYZFtCZzW58K47Qp4zZ8G1+kxE1/Zx9CKUx2jBY2Yy7+Bd3itMg2DdThEVsyI
         Dosw==
X-Forwarded-Encrypted: i=1; AJvYcCWKiXf5MnTpMkIwNlQrXejA5yl8UdH6vniaWtxzfjogzzM8TzLzWMPnisD2Ltsf4k0JYWfHkRdJnQiiTA4nIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzyD9iVJAYAUJc8XEMNtkUu9okcrDOP3Dmt/N7YPKZzBPeBiyPA
	GGxFEW2tM3Xf0VD4RlptzZR5UdGjpXSa3V9bPbX2JP8u7pXafWLTFhU9Np4Tcj2CRq1HBW+Z2oY
	bSPl9pkKgKG8NCM++/13iiORfhJCXD092Zm4Sp7Ce2oPEdsgLfE/4+GDQDnHPWF29Uc9GoyQA
X-Gm-Gg: ASbGncttLfeTZdUdhTgAmM50zBkX8A81URtSsWYKDO+2JR3WG9cue6pW1vR9du2qpNZ
	VE823PCpiG0tEUvLk0nsOzt5qnfMLMgmZprL2k978WxO771czMIJu1vD7E2oiNyY0qROyjocguk
	CPtLFOUgvFvxha6m/8JUO0YXDsc9/zYjrsL/R7ovJPZm7LgYfWCY02fASjZNYW9kMdSwwweO+ft
	spQuBgr+CLshWJLpcngcgdbd6Du9jPnoSXbvtPdQ8IE1mWFQzCfBwNwpsw70osYOyNr25DFH2+6
	Fh9y7G0ayP9ccWNyNjMoWFk3I5dYCa9C//xju7gNU+pltA==
X-Received: by 2002:a5d:59ae:0:b0:391:4389:f36a with SMTP id ffacd0b85a97d-39c1211cf8dmr9667238f8f.48.1743508587409;
        Tue, 01 Apr 2025 04:56:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI0izcLrOFWsXGtZJ0/0M5K+6Lci6R57w6rsNHjR4GKFA4ajpQUp1BsvVdzZaWhFVqaYV58Q==
X-Received: by 2002:a5d:59ae:0:b0:391:4389:f36a with SMTP id ffacd0b85a97d-39c1211cf8dmr9667213f8f.48.1743508586985;
        Tue, 01 Apr 2025 04:56:26 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b66363fsm14402167f8f.36.2025.04.01.04.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 04:56:26 -0700 (PDT)
Message-ID: <0a240ac2-3280-4831-8db2-214cb6e45f0b@redhat.com>
Date: Tue, 1 Apr 2025 13:56:25 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vsock: avoid timeout during connect() if the socket
 is closing
To: Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org
Cc: Michal Luczaj <mhal@rbox.co>, George Zhang <georgezhang@vmware.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 Andy King <acking@vmware.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Dmitry Torokhov <dtor@vmware.com>, Simon Horman <horms@kernel.org>,
 Luigi Leonardi <leonardi@redhat.com>
References: <20250328141528.420719-1-sgarzare@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250328141528.420719-1-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: W1SytOB9LGeL-aBAb6S0TwKPlMevsmMvPYEjXHQ1GgU_1743508588
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/28/25 3:15 PM, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> When a peer attempts to establish a connection, vsock_connect() contains
> a loop that waits for the state to be TCP_ESTABLISHED. However, the
> other peer can be fast enough to accept the connection and close it
> immediately, thus moving the state to TCP_CLOSING.
> 
> When this happens, the peer in the vsock_connect() is properly woken up,
> but since the state is not TCP_ESTABLISHED, it goes back to sleep
> until the timeout expires, returning -ETIMEDOUT.
> 
> If the socket state is TCP_CLOSING, waiting for the timeout is pointless.
> vsock_connect() can return immediately without errors or delay since the
> connection actually happened. The socket will be in a closing state,
> but this is not an issue, and subsequent calls will fail as expected.
> 
> We discovered this issue while developing a test that accepts and
> immediately closes connections to stress the transport switch between
> two connect() calls, where the first one was interrupted by a signal
> (see Closes link).
> 
> Reported-by: Luigi Leonardi <leonardi@redhat.com>
> Closes: https://lore.kernel.org/virtualization/bq6hxrolno2vmtqwcvb5bljfpb7mvwb3kohrvaed6auz5vxrfv@ijmd2f3grobn/
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>

