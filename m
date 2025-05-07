Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B95221739
	for <virtualization@lists.linux.dev>; Wed,  7 May 2025 08:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746606387; cv=none; b=GJ/AZSI86dWKOjE5Z+Q39cr/PB681czD6ItSf6Lg3h5YlRtjgJRHvmyJLKRTfS+t9TrcH7mRNRt8njwQdOeNbP9RKie8EHjcIcxIqYrKbQ1UTYI8HUA7pRu8w3r/0w31Bi1GpYEZ6VbKcj+gMPrS8Q5aBcVKB/27CpYV8kHvFEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746606387; c=relaxed/simple;
	bh=kI/+C74UWcLguN5EGGJ+R2TAzXqsPpk/1uAJ5swPJvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/axT/MHwGZUqOqo9y0ilE2n+mphJp0sMQDC9iSCp8sbUxiSS5IqUZn0Lxoagwd9KuAOfOmyDE8FWYbRSsIAajwx9tOxkZa+mrOrYFHyNQ4DAav9IBy4JNZebczTn0N6SG9yy7Jwa9pL9D1c2NsBzcC0EXeQk+jD3cubE+6fMag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QFUxIS8L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFUxIS8L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746606384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kI/+C74UWcLguN5EGGJ+R2TAzXqsPpk/1uAJ5swPJvk=;
	b=QFUxIS8LqNsgSBy5wrcCc0FLx/jEE0q9mNcbv/l+hkTCxMWB0XArRkjDHY60KB1lK0DZjc
	fGgG2+37iAi6llI7UDyf8xMK6jDfHllZzPpi79hhgy4ZaQXgzP8HoNABiZUMn8hROGjbJn
	XDFH8uWRpaNFwtjpG/RHZaW9gIUCgHs=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-K7a2EzgjNO2Xs78UvxmYhw-1; Wed, 07 May 2025 04:26:21 -0400
X-MC-Unique: K7a2EzgjNO2Xs78UvxmYhw-1
X-Mimecast-MFC-AGG-ID: K7a2EzgjNO2Xs78UvxmYhw_1746606381
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-708ad18b8daso86232287b3.1
        for <virtualization@lists.linux.dev>; Wed, 07 May 2025 01:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746606381; x=1747211181;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kI/+C74UWcLguN5EGGJ+R2TAzXqsPpk/1uAJ5swPJvk=;
        b=X4CFLegUJJdFeLF8d1qxqpzj3yx63DmJkQndYj6iuxxd+23ihIzuw12IzQl1lkp5KA
         tIqf36roCdcNZBca4uGrmofUkBWLRLXeAlzD5Dcz2IDV6MxhdiXtGMbuABYYo88lM/dW
         vhIxjZ597UJPdXJSBo9+XyJLeQRtBxPxKrQ+mWEA/Yafszmb0lG3l5Wds9s0tozz6mV4
         2TL3U3WkKASe5nlJx44kUXvk7iBActtHaBEg2yA5VBQ6mY3vCqjC2mvqIfsB+3s4gvBj
         CQwdDgLxWlzrf6vsJM6bWBrqpHufcGFYtLIQqfUQezyh+sQNzNU19QZ7uvcxyBjUguwQ
         ceHw==
X-Forwarded-Encrypted: i=1; AJvYcCWTqXidyRT3h0vkrc1IO2V9XtorBFbRKbzIcMKEU83vZbe7kWoj3apf+6SzvzibrHl2ukMMarQ5/xtTnrEcjg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMGmsHE0256z2pFubbMTYOR7gydtn+5MGx6YwVGCR3qxasoXKq
	izzUiKhuBUHQiiRejFz7qSsvaPJ4fy74A0r/1Y5WHJFxRzinFqKyqjnDAOC4Z6BMdNs3Wp5LfwZ
	dGXeoN2+VN1kuRVkxauZLgHPjDreDNCOvAgzUz92QZoKZPjWI23Cn1s3bTwB/QTywje+rHs1R9c
	u1kzxckjQIi/0R4/pDgbB1KYwCAS12Wxo0EVjEHv8=
X-Gm-Gg: ASbGncvqPnf7ZyOGlFvPbwsjyAiQrmPzVjVZk8uJJd7c++IbNvCe9egnk0T0ooFSMgz
	mybjxA7f8hflh7F8dWyZYO7PGJoBc73n7WOldIh7ltXsxgNI/x9HogDYeG7jAbJnZUS3stA==
X-Received: by 2002:a05:690c:370a:b0:6fb:1c5a:80ea with SMTP id 00721157ae682-70a1db49713mr32558757b3.32.1746606380989;
        Wed, 07 May 2025 01:26:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpSC+1ia23pV+uJD2D52bGeABFvUueMfJwumFcd11s+v7+rdS8w8k4nrnN2Jgii7JxOzEH02Xj8URwB0gtc2E=
X-Received: by 2002:a05:690c:370a:b0:6fb:1c5a:80ea with SMTP id
 00721157ae682-70a1db49713mr32558377b3.32.1746606380608; Wed, 07 May 2025
 01:26:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250501-vsock-linger-v4-0-beabbd8a0847@rbox.co>
 <20250501-vsock-linger-v4-3-beabbd8a0847@rbox.co> <g5wemyogxthe43rkigufv7p5wrkegbdxbleujlsrk45dmbmm4l@qdynsbqfjwbk>
 <CAGxU2F59O7QK2Q7TeaP6GU9wHrDMTpcO94TKz72UQndXfgNLVA@mail.gmail.com> <ff959c3e-4c47-4f93-8ab8-32446bb0e0d0@rbox.co>
In-Reply-To: <ff959c3e-4c47-4f93-8ab8-32446bb0e0d0@rbox.co>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 7 May 2025 10:26:09 +0200
X-Gm-Features: ATxdqUFUbB7EP5EYdD3-nw2ShhvzgoAnjnkJi00OTnfe2xCzejcrLy_1225Kq5I
Message-ID: <CAGxU2F77OT5_Pd6EUF1QcvPDC38e-nuhfwKmPSTau262Eey5vQ@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: vTSUNJJayZ68Qo9y45sXAge2vBcjsDMnwrNYATikeos_1746606381
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 May 2025 at 00:47, Michal Luczaj <mhal@rbox.co> wrote:
>
> On 5/6/25 11:46, Stefano Garzarella wrote:
> > On Tue, 6 May 2025 at 11:43, Stefano Garzarella <sgarzare@redhat.com> wrote:
> >>
> >> On Thu, May 01, 2025 at 10:05:24AM +0200, Michal Luczaj wrote:
> >>> There was an issue with SO_LINGER: instead of blocking until all queued
> >>> messages for the socket have been successfully sent (or the linger timeout
> >>> has been reached), close() would block until packets were handled by the
> >>> peer.
> >>
> >> This is a new behaviour that only new kernels will follow, so I think
> >> it is better to add a new test instead of extending a pre-existing test
> >> that we described as "SOCK_STREAM SO_LINGER null-ptr-deref".
> >>
> >> The old test should continue to check the null-ptr-deref also for old
> >> kernels, while the new test will check the new behaviour, so we can skip
> >> the new test while testing an old kernel.
>
> Right, I'll split it.
>
> > I also saw that we don't have any test to verify that actually the
> > lingering is working, should we add it since we are touching it?
>
> Yeah, I agree we should. Do you have any suggestion how this could be done
> reliably?

Can we play with SO_VM_SOCKETS_BUFFER_SIZE like in credit-update tests?

One peer can set it (e.g. to 1k), accept the connection, but without
read anything. The other peer can set the linger timeout, send more
bytes than the buffer size set by the receiver.
At this point the extra bytes should stay on the sender socket buffer,
so we can do the close() and it should time out, and we can check if
it happens.

WDYT?

Thanks,
Stefano

