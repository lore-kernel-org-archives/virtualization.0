Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F6525C817
	for <virtualization@lists.linux.dev>; Tue, 20 May 2025 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747731713; cv=none; b=ZnGXhvZA7zBOrabnlqYhTMIV+MFcuJxIFkXEAHYVXWyTE/mhqG5gpB3xQIAyw4TKQZ7wIlTTiXJ7NBwIVbI+BKYI6orenCcRXDoZ2gZxGI1rYYkemNW/JahQMMki/lxo2o70vGdtIUPsAt//B6cSxBr6TxVaUVZk9Lc6v3M3CdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747731713; c=relaxed/simple;
	bh=f4PFfUo3CVYvxjRWKlbGvRUOQy86q4nrR07UPkeiNIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrxoubp5Gaa85sF8zLPaUxWtJ8wcbtHmVCvdQQuu7DWq/5JsGrzPSmEoc1LzkjTW9FdWIcLybOPH/xb9sQEwx4O1/rUgYQvLiJdSt1mXqTmQXyZde04/cNHrhcHRDEKCXpVbgk0OrdU8V5bAPrLEBP1v5kew7ljqffZeZdQLnxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e5UbIz43; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5UbIz43"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747731710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f4PFfUo3CVYvxjRWKlbGvRUOQy86q4nrR07UPkeiNIk=;
	b=e5UbIz43/TxMziGRFrCaSr+zLZ7CtvOeiZcrnZkG5qumeNP1cntRTW0Licd3o9QhQb/kCb
	pZ+bPN1eqkG+hCC9dVdpTQ9tmEivW2wiCz7zh8sNRq4H/W89AfdGgOEyLP8mvFwRTeHa5q
	NEbWiP55vYLe4xK+DAbf8ALLQ4Bjvo8=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-zjUu7h9eM5itaEbup6bcsA-1; Tue, 20 May 2025 05:01:48 -0400
X-MC-Unique: zjUu7h9eM5itaEbup6bcsA-1
X-Mimecast-MFC-AGG-ID: zjUu7h9eM5itaEbup6bcsA_1747731708
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-70de25bb419so8058827b3.1
        for <virtualization@lists.linux.dev>; Tue, 20 May 2025 02:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747731708; x=1748336508;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4PFfUo3CVYvxjRWKlbGvRUOQy86q4nrR07UPkeiNIk=;
        b=OdgtyFsKPFGWpHjTNXaMhcOQuKiNJR+BMB5EC5/IBbrI4RJPhauQAZa5w70hg/4TLK
         NoHmjQtoXKlI/zgwKl8Ay+V+Np346A90hQq7oDRC0Gb5kn2dIpmPsCVIMp4NWT+aD9Zk
         nGJriHs0UxR4TP9adWP+scgYmqsF3pWxxs1jjkcLoXfWjfyC2IAVw3YS5CSvPfpTBwEb
         tJYLuHSeFnOW8200xtLHIccN54xtNfpnMxYhutdCoLhXHDPkFvKTeMIskauFtX/vSdMK
         G/ARmlo3wjflm5XXxDQI7h49UV6yzyQZMTdVp7gn3UuZy/qM6HC0VS9zym7oHXQHYle5
         AIHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+FR91Z5Z3JR/+RM2vDMcdM2kNt7GeBrj32yBLwB49Q/rIRTETxgxC7HQG4SuVMhiRHUdsJ6FuGImkz6FtKw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9v7GLfd4GTt8sN0gmMxYuOdnA/W6YcgclIb8I7mYE9vBERhFu
	EcK+q3ze4yJ/N0Uoes8+TSjF214APCIzcaaJrWEb4sYRqh8fLPNBNXQehWxSnpydxeYEx1HepDc
	X0nvMN+NdapsnO4mF1Os3ZaMq25v4l44h5YPIwVSKy0szS4HMwiLLqh6yJSoXMzv2KXTuHGzEN9
	Q4pkuEFgZDrdx03bb1frOz+kz8PG7/3wKC4c3iC3TMdAw=
X-Gm-Gg: ASbGncsKMCayRLVjLf37229jc6gIBd8efGmWjs5qOrxnsNklzg3nvpjU1bo+CMycke4
	EF58QwqLUg6tb26HW2v2H3Q6eqkOrPG0m/rsxeHhaptNvqsDHDDA5yTQEDj/bdjod3fE=
X-Received: by 2002:a05:690c:6f03:b0:700:a988:59dc with SMTP id 00721157ae682-70ca7babbb1mr240866057b3.31.1747731707611;
        Tue, 20 May 2025 02:01:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3XkPTDHC2bT/+30vHIfK94LVFwuyNrNbVOqdnshE4e5m8CfpmTKyeL6GG9M8oi09my2f4OCE0WTxgWx8PWBs=
X-Received: by 2002:a05:690c:6f03:b0:700:a988:59dc with SMTP id
 00721157ae682-70ca7babbb1mr240865377b3.31.1747731707035; Tue, 20 May 2025
 02:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250501-vsock-linger-v4-0-beabbd8a0847@rbox.co>
 <20250501-vsock-linger-v4-3-beabbd8a0847@rbox.co> <g5wemyogxthe43rkigufv7p5wrkegbdxbleujlsrk45dmbmm4l@qdynsbqfjwbk>
 <CAGxU2F59O7QK2Q7TeaP6GU9wHrDMTpcO94TKz72UQndXfgNLVA@mail.gmail.com>
 <ff959c3e-4c47-4f93-8ab8-32446bb0e0d0@rbox.co> <CAGxU2F77OT5_Pd6EUF1QcvPDC38e-nuhfwKmPSTau262Eey5vQ@mail.gmail.com>
 <720f6986-8b32-4d00-b309-66a6f0c1ca40@rbox.co> <37c5ymzjhr3pivvx6sygsdqmrr72solzqltwhcsiyvvc3iagiy@3vc3rbxrbcab>
In-Reply-To: <37c5ymzjhr3pivvx6sygsdqmrr72solzqltwhcsiyvvc3iagiy@3vc3rbxrbcab>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 20 May 2025 11:01:35 +0200
X-Gm-Features: AX0GCFvwufUSjICCevkhSa4UF6ys3CpGsz9VU3OXC4m_4xblOUg6kg956W_4nJw
Message-ID: <CAGxU2F4ue9UxZd1_wB2D=Oww6W9r7kTBPVjjbnm24Lywz+0wSA@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: 0-I2Yv5HLkI39n3AfhRPNRybnGEvk_MYVsmUCic1B4Q_1747731708
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 May 2025 at 10:54, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Mon, May 12, 2025 at 02:23:12PM +0200, Michal Luczaj wrote:
> >On 5/7/25 10:26, Stefano Garzarella wrote:
> >> On Wed, 7 May 2025 at 00:47, Michal Luczaj <mhal@rbox.co> wrote:
> >>>
> >>> On 5/6/25 11:46, Stefano Garzarella wrote:
> >>>> On Tue, 6 May 2025 at 11:43, Stefano Garzarella <sgarzare@redhat.com> wrote:
> >>>>>
> >>>>> On Thu, May 01, 2025 at 10:05:24AM +0200, Michal Luczaj wrote:
> >>>>>> There was an issue with SO_LINGER: instead of blocking until all queued
> >>>>>> messages for the socket have been successfully sent (or the linger timeout
> >>>>>> has been reached), close() would block until packets were handled by the
> >>>>>> peer.
> >>>>>
> >>>>> This is a new behaviour that only new kernels will follow, so I think
> >>>>> it is better to add a new test instead of extending a pre-existing test
> >>>>> that we described as "SOCK_STREAM SO_LINGER null-ptr-deref".
> >>>>>
> >>>>> The old test should continue to check the null-ptr-deref also for old
> >>>>> kernels, while the new test will check the new behaviour, so we can skip
> >>>>> the new test while testing an old kernel.
> >>>
> >>> Right, I'll split it.
> >>>
> >>>> I also saw that we don't have any test to verify that actually the
> >>>> lingering is working, should we add it since we are touching it?
> >>>
> >>> Yeah, I agree we should. Do you have any suggestion how this could be done
> >>> reliably?
> >>
> >> Can we play with SO_VM_SOCKETS_BUFFER_SIZE like in credit-update tests?
> >>
> >> One peer can set it (e.g. to 1k), accept the connection, but without
> >> read anything. The other peer can set the linger timeout, send more
> >> bytes than the buffer size set by the receiver.
> >> At this point the extra bytes should stay on the sender socket buffer,
> >> so we can do the close() and it should time out, and we can check if
> >> it happens.
> >>
> >> WDYT?
> >
> >Haven't we discussed this approach in [1]? I've reported that I can't make
>
> Sorry, I forgot. What was the conclusion? Why this can't work?
>
> >it work. But maybe I'm misunderstanding something, please see the code
> >below.
>
> What I should check in the code below?

Okay, I see the send() is blocking (please next time explain better
the issue, etc.)

I don't want to block this series, so feel free to investigate that
later if we have a way to test it. If I'll find some time, I'll try to
check if we have a way.

Thanks,
Stefano

