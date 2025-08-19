Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07948321F38
	for <virtualization@lists.linux.dev>; Tue, 19 Aug 2025 11:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601976; cv=none; b=XfY26NSM4Q1VAAwntCsV1JZI4579FNrM2LonZhc+Uv3vy7ATPQK7w+SvfJ5/+ANyunBcPW5kBfnc+QLKAtNUn1cERnqXjSwMAhAwBu8uqZ9ZEB1A6kOvgPSyxa/KItBQW7bhwciAsTNETRilDvzOxIywTv7833s476vz8yq4nd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601976; c=relaxed/simple;
	bh=KPRuQ4WAAeo3vRtFpuFdkkdL0MiYgm8EWUFk0JOscqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YZAE2MkBzmc4FZiAJuoMxB3DBKfPW3xJBO0f27xOUnY/LimaZTsWelirnHqr/0fB8Ww9u07eeaDLYYgzUtUWsB0RWZ3j+urreCdEh6ZMm4BUe4wtDBwxz6sZvvR/Z7BkvnemCUNzBE9R7dkBxk+/D/Go9gYQDpbtbKtmUlT6eUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SsrEUl4u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsrEUl4u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755601973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gwiysIJN+lj5NXCn81q0LCDHU+2Tt8hxnK1g8vZiVas=;
	b=SsrEUl4uPZmD0x19cTrrcLFNMV+rTK1kOPcGAGOU/2QYk/AxKcleqGSOnNGNBWGFbS3III
	XQ/XSKlUamIXhh24cfIbSw1WWDh8UE5xxDAXzgEQY2iTyYeW/JNr705SK4ZNew616W2jZZ
	jfd8e346o45SqnNDsiSyfy9PsI1TxE8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-t1wakw7RMyC0BmcFrD9hrg-1; Tue, 19 Aug 2025 07:12:52 -0400
X-MC-Unique: t1wakw7RMyC0BmcFrD9hrg-1
X-Mimecast-MFC-AGG-ID: t1wakw7RMyC0BmcFrD9hrg_1755601971
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a28ff4793so12031335e9.2
        for <virtualization@lists.linux.dev>; Tue, 19 Aug 2025 04:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755601971; x=1756206771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwiysIJN+lj5NXCn81q0LCDHU+2Tt8hxnK1g8vZiVas=;
        b=dUktgx5gxmoQKdTjnS5IqRDmTXnvn1g5nqjnqu8oD3rYQ0JEi9m1IgFOzNBH0z8bXB
         kKKBSYBos3yE4MoumJsRRKzYwwjXL4NZVmIzHwE+B7bJl4k8JXGe472LtZ/JmVSPiSbN
         JpZQFxJuUVfv+7YEMkVp+tE1YXgj5FaqlVpDnP00EBVOct9giAJAgAGc7/bfagrn/G7L
         FSeg++ZZ2Bws2Bxjn+uVEkQLrrr9UkeIZwpbjy3ZkdlWSejAaZx5fRek08hwGl4eJqT/
         fbT4aDhKF6xapfJyhIY+6/RFi5Fzncxz1W3oWSaX3W8Mu6YhdieWp5YDUiTyZJUBlstC
         S+6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEletINgODvmhBDClLa6cT/Wfa1nsCFaHSan1k18GZbp4wr8Y+RjcPH3JT4X7LJO4VfEGYZ6irjrgEIMkqjQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdxeZA6JnQW217qU+XVVVsr2hweQz/6KbVP1PXVg7al7w/y3sO
	kg8tBIzThyVVP1cRGYbP0f90uq30iP5T3+36XF/QYfNXEWRRU5dwxQTUlQLTV0LNH8ezuZnwVAy
	o1V0KUxku/rZf8LdFnySSdycmMgBu7nHlJU+fm3Nfw88xJC6OReZC1J+TM8HDWQBcB/9c
X-Gm-Gg: ASbGncsRm2ZUqTZsDjU+MiVnjqV6ERkYsM5eyevcvnOIqfIRf2pY7fIY/LNy/UtoEEr
	XZhsALVEcD4w+3S05KloY0DwmFaAgP6NXwbFPZy2meH1u4+tt77nMNrLVBPPtzJctUocaW47Ypm
	oDxo6pBRxnlpPyQSKfCnxQcY/qdKtpMV8Jrx5wbR/en63kEPWdeqqqs3Xc0ko8BW+yjnZReofWG
	Noj3nznA/Fqe2ngmswZ7IXBf9sJDnDlzvf/55x2gBK0zwKUXgqBvOE6JBP9ytfhxk45fvaCL69s
	JNX/qApOIMxPSrh0bferm2UiQEjDEre2
X-Received: by 2002:a05:600c:4f0a:b0:459:d5d1:d602 with SMTP id 5b1f17b1804b1-45b4602acfcmr8598725e9.3.1755601971345;
        Tue, 19 Aug 2025 04:12:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsW3Tv+6q61sN/85hX28Egss5FzOAF8rmCmjNaTCZprfcs4Nki01Y6mv2kY7kjtPxcgy+NXw==
X-Received: by 2002:a05:600c:4f0a:b0:459:d5d1:d602 with SMTP id 5b1f17b1804b1-45b4602acfcmr8598475e9.3.1755601970920;
        Tue, 19 Aug 2025 04:12:50 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c1677sm3355109f8f.39.2025.08.19.04.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 04:12:50 -0700 (PDT)
Date: Tue, 19 Aug 2025 07:12:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Hillf Danton <hdanton@sina.com>,
	Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 0/2] Fix vsock error-handling regression introduced in
 v6.17-rc1
Message-ID: <20250819071234-mutt-send-email-mst@kernel.org>
References: <20250818180355.29275-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250818180355.29275-1-will@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SVe5imz3UmovDdIrXAgE3iiUOLgDncHpo93Rf-j7dmk_1755601971
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 18, 2025 at 07:03:53PM +0100, Will Deacon wrote:
> Hi all,
> 
> Here are a couple of patches fixing the vsock error-handling regression
> found by syzbot [1] that I introduced during the recent merge window.
> 
> Cheers,
> 
> Will
> 
> [1] https://lore.kernel.org/all/689a3d92.050a0220.7f033.00ff.GAE@google.com/

Acked-by: Michael S. Tsirkin <mst@redhat.com>





> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> 
> --->8
> 
> Will Deacon (2):
>   net: Introduce skb_copy_datagram_from_iter_full()
>   vsock/virtio: Fix message iterator handling on transmit path
> 
>  include/linux/skbuff.h                  |  2 ++
>  net/core/datagram.c                     | 14 ++++++++++++++
>  net/vmw_vsock/virtio_transport_common.c |  8 +++++---
>  3 files changed, 21 insertions(+), 3 deletions(-)
> 
> -- 
> 2.51.0.rc1.167.g924127e9c0-goog

