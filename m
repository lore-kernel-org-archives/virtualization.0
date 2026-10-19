Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30D14EF15C
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792412525; cv=none; b=AjAVbYsg51rBT17sHFFzfaxtWDVq53qepS+r+W9nfzDKfkaAjRwymIlNNB91WD2dp/P/S6I90fKw1jr5J5q7K1tQ51AXit1avi/9/DWnE1DTG1rVEw49NwPcLOWFRzbdLv7xOnXrBA4tqhn9iw8ynY3G0LZxnebr1HXtjntjFQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792412525; c=relaxed/simple;
	bh=sIALCuzmK5MrLm1WN32r3MHvew38w9LvE/9jWk8EGbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GIJ4KuuECMVZRMr3AoEcnjQRDfxs0SD1ZLi9dYUoG/ARIocJpdmHyku2pyJ1IvlCTlurgSPNDx3wB8LuUn+jWvyB6dteg6Wss2XdRHcaC0Qh8aFHy40PdIz74YW5mHxApNQfpR3Z+Ba2H3OAdwJ33SEZ7GmeVpVXUb0HDzQ1oQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FJmnQWay; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJmnQWay"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792412521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HvmVJ/YjUjexXZFkRD2KfE4ivd3D2olHrXzSUsWnuRc=;
	b=FJmnQWayqh+ttlrfKdjb4jDMlSoHy/YSUuPNqeYEXkQz6xpEU5miEzf1fVv/+qb56nTu55
	6RjEYnIeDIsAJzXSZkfNmnLuC2q9ZzklOox6JveTzJSgZ0dzadEItOjIOIXYloVzytXpUa
	NAdNZJuVSnP0bpbeEl0xkjlVuxUYn/s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-Uw-2pjjcNBCvX6LiJuurWQ-1; Mon, 19 Oct 2026 12:21:58 +0000
X-MC-Unique: Uw-2pjjcNBCvX6LiJuurWQ-1
X-Mimecast-MFC-AGG-ID: Uw-2pjjcNBCvX6LiJuurWQ_1792412517
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a009f82bedso16221395e9.0
        for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 05:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792412517; x=1793017317;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HvmVJ/YjUjexXZFkRD2KfE4ivd3D2olHrXzSUsWnuRc=;
        b=IzUUj3V1a724h6EwYw8cmVeH0gbu2pOXp8iti2xXnxVW4KqB3DwLgFtkmEvWa5KLcx
         VFaroFeMqAxCnVDDFLGE3YX5oQxX/VSvBVxE1GVnbUpMl0TFc6DRiU3gFEnOP8Aw64D2
         kU2NtfukcqVYvYq2pC4AAeATTpHA9ZDQQgaNtynjBQytOhoZ5LIi4YmIb1QkrylX1i2+
         hsffPictic+56MxKHHViY0RpcFiY9Yd85wd0mQW9da1Q7rqdMBKXgbU7KDPPvtRLXOWp
         0Rhal1s3JP2HyDvUfSdBuKIfsv9xTjyh0IqgEZjcbofEC1SfGPfYt3TvfRq/ZEMvLWpb
         qvMw==
X-Forwarded-Encrypted: i=1; AKwUvByBrvGAfnvxVaN+juDOy/9YBPVWwpEm0VLSBWvr9JoxNI7bKoHiP66F1cfGHxWYJeLewlvnwYVM9WrjVKIGDw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJXj5hl4B3sFq7TZuOKep9PoUp6yPbgEQonv8P1tVQcr3ocMdz1
	wQy4jbGJ8gkOwMX/+L1OjebIFpTE14xnK2ZX5avkm+raTCs51vOiK495qXZCRagRJjYrEk2x1gt
	Mk/Igzon/e1BZL0GU01PrUNMC2/wjlsrOA4RFCX8JhYK2ZrkzEyGDFY0NtHxVPmOSymDB
X-Gm-Gg: AYBFou0W0qfOYc6p/tft5h7Sovy/3LZRcBGsDAUKUuuHEv8h6kYo8RXGnC0tHYH5zRT
	Q+6jk4L8IJxhQlel5G26MLeApqq3bhHRGBJWv2NqS9XxR9P8iKw62bJ7jwCy+5BpvX0smp05Raj
	tSWC4AiAdgT4FkrdRb7lUjQ6czo2+5qUtNpOPTAa24pr5OHw9BtLSBhoB2HVetK0g+XNDB2mB1d
	d99HGjifuUluKN32Afnmqg60b/9LEO0SMP2wkChx/L/JB0ndL8zqgJTXko34cm0U1sKXwXdRGVK
	0ARqRS5TGzF1HC/U76AIoazk4j24IaKDykV8mBpQPHQzmEFs2+f0A9rng+3MMpG9DAixtg==
X-Received: by 2002:a05:600c:4e03:b0:49c:fa20:cbfc with SMTP id 5b1f17b1804b1-4a1d75ffbdamr177431505e9.19.1792412517086;
        Mon, 19 Oct 2026 05:21:57 -0700 (PDT)
X-Received: by 2002:a05:600c:4e03:b0:49c:fa20:cbfc with SMTP id 5b1f17b1804b1-4a1d75ffbdamr177430755e9.19.1792412516569;
        Mon, 19 Oct 2026 05:21:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8a81587sm524058155e9.1.2026.10.19.05.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:21:55 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:21:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: netdev-bot+sinfo@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Chris Arges <carges@cloudflare.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH net v3 0/8] more virtio-net csum hardening
Message-ID: <20261019081218-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <179241175916.3290.3107334544259481724@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <179241175916.3290.3107334544259481724@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Qaoqe4AsqSo2ue_UCPiXRwah23eAGZG76xY2h2yPYX8_1792412517
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 19, 2026 at 12:09:19PM +0000, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

To answer the question, the virtio header is checked at input by
Eric's patch. I'm not aware of a way to bypass that, but given
the amount of pain and work this is causing, it seems prudent
to validate at several levels.

Patch 4 is a bugfix - i reproduced it easily but it is not normally
encountered in the field - the combination is non practical.

-- 
MST

