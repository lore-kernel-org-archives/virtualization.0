Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E44433BA8
	for <virtualization@lists.linux.dev>; Tue, 21 Jul 2026 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784619977; cv=none; b=UrjxOebs8HefRXmK2dHU2ltZmcOabmI5wGUSX3Fie9iK6IcVP3rauGYl45ec3OmyY6PkzFTOaB5TnLD2AXOqWUSsVrHbVnHagzvVypGM4gu5q+T0vBf2U5iskjj4N4/DTWmFNQPqYHlyJuM2vMk7udHP1D8+9tM+BWl86lL/PCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784619977; c=relaxed/simple;
	bh=dau4m55i0N+huU1Tx4LV5VNIWA7SxLqAMiCgmbSBsQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=m+LpM4FBNBOzwejNlamOQ7I5h1qxBBIreAxDEp85B+m3ZAm6FYOI0vwHBM4Ie4rojmEvgSMwwhh0zJukY7qX0eSK+76d8L5CQZN0GWnWJ4fBYBOUJuk45Su5NjjzhKRFIqgRjCwieqfky2gLvz21AhHCvIZeO7ZEwUmRd0gM0/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dIlOrAVp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIlOrAVp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784619974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Ais/X6bRzcXYsevthemLaBtrh2axhIC1Q39swas2MM=;
	b=dIlOrAVp0Ji2V5uTVEmBpiea9pMbIx6M+OOB5ZyTDB9+QstjgsdxLFRwYx+IDMirRWlz3A
	I5t7Bbn21g1YWyf9E3TJo3/Ve7vdCvvZvzEhgj36aQStbhoRc9XqkdQ120s9gPrVDSdswn
	kH67gkVnw4dLHFn2v6eWHyf1mQmyLfM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-mL6fLCdvNF2pTmbpnZnTiw-1; Tue, 21 Jul 2026 03:46:13 -0400
X-MC-Unique: mL6fLCdvNF2pTmbpnZnTiw-1
X-Mimecast-MFC-AGG-ID: mL6fLCdvNF2pTmbpnZnTiw_1784619972
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-495689bfcc8so1062285e9.1
        for <virtualization@lists.linux.dev>; Tue, 21 Jul 2026 00:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784619972; x=1785224772;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Ais/X6bRzcXYsevthemLaBtrh2axhIC1Q39swas2MM=;
        b=P55upCu1ttotAqpdzhwpEFuJyP8JjmVdyLJH8efW5cRGKSl7kCzNiEopJX+00EgeRD
         TXe3HW8s2Rl9e8tkVy3WWh37oOPRZzxlUFqVg1clrLGGXXqf8pQ4q5E0mKwCqv9gh/3u
         IU9SFvF3XsMAy8kZc8Yym350L3dTFZQGVQlFRTasNlhZN8FehJYErEQbycvDgEaUjNrQ
         ldNJnkAAh0RcXZoSQtnb3s+9LB55e/+/pOU/Qpwaub0PshSm2TwPz2WULqI6B1No/vBT
         ULU0IeQwy3geDJrXoLYWSgyJo5mJ6uDxM5wl8zidy0PRWp+7GKVZIRfPoKxBA5/WLXZ9
         /v2Q==
X-Forwarded-Encrypted: i=1; AHgh+RrZor+2E4omv2pA9g0RfCNxcko+D6GR57VVgi5E54lgxDYZYZvSA16C+41ztGBVez6Xhosn0GPEw0LsRlgBqA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yym2VnkF4lVZT+knMAuxqsNyaGQDn1EpvWS/rtGtZsyj98+jsJw
	dJwU0VKlubgORSF03wHl0gJcIB6mZ5E67LLsHbsM3dbpL86WrkKxWrEvHVU/FasY09pTQTT+EBo
	YsbD/PMzpEHHCQsv1ANWNcn404v8nRQBWz2yH3eHyKKc0z/mYUhdTygAoe8CaovDmNf87
X-Gm-Gg: AfdE7clmDUoTHpYTTpyQ5ALRLPsQvYmeqXxL7pnIsr0SLEsXLbyMHnBpn/mjDZ9ibyM
	WAlJoveDN2zfPDYhyP2/EBAMkK1D0BBYWRDl+HP/kMosi23VIgKSPEdLHgIszjiiUcJB+J9jWgy
	I7O0cjgCBGyX3wqfqdIWbva7zNKgGKa+vQADg0OjyZFTNiZc3io28G4JGhR4GvbYVjhpfLSx1IP
	adQ/kDoydxVKt+5lNltxYC7gPfJsyWqma0+o3vv/tAK74LhSHYvcnhmmfYWEK1pTJuVu4kirFJt
	3dMdg74ifzAhe4E25AiYzW0VgWS3pIEhj5EflJ03EmK3rOQZ7aNoKH59vCtJr/IFFWlCjk0B6ZY
	N3NqGgMDNKig6JtJQ5lLfs+82Wv+e8vy2xsHOypcfmJARy33HdA==
X-Received: by 2002:a05:600c:3515:b0:495:5b4a:53c9 with SMTP id 5b1f17b1804b1-4955b95bfbbmr89971115e9.39.1784619971793;
        Tue, 21 Jul 2026 00:46:11 -0700 (PDT)
X-Received: by 2002:a05:600c:3515:b0:495:5b4a:53c9 with SMTP id 5b1f17b1804b1-4955b95bfbbmr89970765e9.39.1784619971248;
        Tue, 21 Jul 2026 00:46:11 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e49ce4sm37180764f8f.8.2026.07.21.00.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 00:46:10 -0700 (PDT)
Date: Tue, 21 Jul 2026 09:46:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Manos Pitsidianakis <manos@pitsidianak.is>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Peter Hilber <peter.hilber@oss.qualcomm.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, rust-for-linux@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 0/6] Add Rust virtio bindings and sample device
Message-ID: <al8isqIL6gwGlPc0@sgarzare-redhat>
References: <20260510-rust-virtio-v3-0-1427f14d67e1@pitsidianak.is>
 <tiiht3.22qk83rct1pd@pitsidianak.is>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <tiiht3.22qk83rct1pd@pitsidianak.is>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C1Eh6uBCurQhC168q4yJLhfEPW_n_Od3EgmZznprmpY_1784619972
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jul 21, 2026 at 09:21:15AM +0300, Manos Pitsidianakis wrote:
>Ping.
>
>I have a different version of the series WIP with a virtio-rng instead 
>of virtio-rtc, based on https://lore.kernel.org/lkml/20260529-rust-hw_random-virtio-rng-v1-0-b3153dd90311@pitsidianak.is/ 
>(which needs a v2 also)
>
>But since this series hasn't gotten any feedback on the virtio part, 
>I'd like to ask if there is any before respinning.

Sorry I haven't replied until now, but I haven't been able to find the 
time to take a look. I'm very interested in seeing Rust used in virtio 
drivers, and I'd be happy to help maintain them.

I'll send you my feedback within the next few days.

Thanks for your work!
Stefano

