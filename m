Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7C53B585D
	for <virtualization@lists.linux.dev>; Mon, 15 Jun 2026 19:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552926; cv=none; b=pP2DY5rEU0e+hbssv8leG6TXZF+hCOtXJofVAlr1UrNX5lz15Ttp9/tLE26MF/u+IOFK/84fB9SDFo3Ug9MMJjOAdijhlBYuzyLBH9pJh9I7kT6rO/qI6piBzbUaN6Pb97KSgq7Mb+5zjnbazQtG6JaLuoyNUyPsN06P+RUJ/ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552926; c=relaxed/simple;
	bh=HywRkiOpkQuCnAiRcy1+1nGB0pyzOVqxgczZaqgqCr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cIfJ27SkWTERktjjSALTQ+rhaP1YGFWxxilhFzQHDu40uBnjckyR2zUy8N0ASVpustF0ulhq2Pw9iAQJ9cRY1Ey2LDbm4dYv6Z1UNUw6N5I/VTHbJUAX/fOyAX1TIQE3xIAZhvIS1N7w2e8armVRS9qD2stIJP0qG4//GnZHOJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gbJcuINd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gbJcuINd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781552923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nhU6+tUSSRwqgOUkAhL3IQec07W//7LlZKU9ysLcGq0=;
	b=gbJcuINdCEDyQFAi3wvcsqAclZg2zxw3WaqYtLoHGjIJAswaJyFZL9jwF0noNAKq00Su/j
	XL1eIOv3nPZ6w+tuS0KPkL0lOqXUuJB/HpZRhmmxDGXnVYQeLY2jhKaCMgEH4Ey2aGRq/C
	a1O+XN2VWaSnl9+K8Y5TXJ+sojW/ZTY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-HKSPkeq6OKeQ9Aam5Nhr3w-1; Mon, 15 Jun 2026 15:48:42 -0400
X-MC-Unique: HKSPkeq6OKeQ9Aam5Nhr3w-1
X-Mimecast-MFC-AGG-ID: HKSPkeq6OKeQ9Aam5Nhr3w_1781552921
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45ef66cc579so1779142f8f.3
        for <virtualization@lists.linux.dev>; Mon, 15 Jun 2026 12:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781552921; x=1782157721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhU6+tUSSRwqgOUkAhL3IQec07W//7LlZKU9ysLcGq0=;
        b=Qi+4EZ4HRapp0tXwEU6P6YeBH/AU4ctIuLWf/b7zzY2Rz0OQNNB2R1ZG36yIhhjI69
         pgYy67qz7DTh31n47llmw5x8HNUy0MigJxdKA00TShF5RcRR/yvT2LJDVWfsmi8WGPdO
         g8QbVtcfe7I/+VRN7jfXVfD+JuL+AoQBSBkzb32wpxqa9PUonYpLfIqLP2JjMHvaSItm
         mD8M0mpzL2HVIbILHBeZ7igQp2rjJkmSWKbvt4M6fkzztpWHa4qEjXMPUS5carV/k0Pk
         6FktjjWFkC7Mh3YlfdfMoXVLteUi816RE0DGP41X0ifSUlpUOw6SX7HBvp8F+Wcmg+9z
         daDQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Q6m/4QObvLrXcSpYwzaI9TGGOeW6YaTv4YV+ORmKOdPK7FXpPB1LSElt5AMYMuQjCJHf9sSjj9BCPq01Eeg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdoDXaHyaD5UxRnsAfa8npEDkE6HT8lY7x+pP62LQiLPwQC3kl
	mPrjrh0eaSvOK9r5+vTYr0oatCzRGU378n+00yy94GwtnrUvZpQALHSIVeYUsxTstXDzrGEc9Im
	2aBMIlH3CpKzwG6uZZ7s6hzNlTkbA9fwG6znmW5bP7+5WKpOdrFK8IsXZ47jgNFeLsGZf
X-Gm-Gg: Acq92OH1mIBYAvU/qllJ1PxZogHF1u1dzibJ2biY30wx0757seBMNHsiW3SbaR4/VxC
	2N/gbIkqv6oTHFzMlM9/90tO5q6STYxWS614DCKcKu1tGzziEYzaeP4TjX5jhh8Ej8E2ar5uFxO
	LYgwA5O+tpGxGGgfcclo40nzddCaDg3QpNsv5/hu3pU7Vfl4OfW8+eSNbPZV57ZYukmlTjnIZTc
	7FEr6YlV20tOgMjOXXjAYigWUav9jbGCWfCYUbc8JzrV3sk92EMLUHOjILjeCVZmBsd5ixc/3tS
	fX2tD7bHc6WTQpJuxqfpZG/0b7yOVNICXggsRKKNHveNMoHRPmkfgArM2WXFdVlNGPkSu48Exxs
	C7TpyWVWCU0i+DaO313piXCbRlndYf+rpPM2fKvfHblc=
X-Received: by 2002:a05:600c:820c:b0:490:4b89:5361 with SMTP id 5b1f17b1804b1-490ec4c5984mr208652815e9.7.1781552920861;
        Mon, 15 Jun 2026 12:48:40 -0700 (PDT)
X-Received: by 2002:a05:600c:820c:b0:490:4b89:5361 with SMTP id 5b1f17b1804b1-490ec4c5984mr208652615e9.7.1781552920426;
        Mon, 15 Jun 2026 12:48:40 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2d933esm35788998f8f.33.2026.06.15.12.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 12:48:39 -0700 (PDT)
Date: Mon, 15 Jun 2026 15:48:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] vsock/virtio: fix MSG_PEEK calculation on bytes
 to copy
Message-ID: <20260615154828-mutt-send-email-mst@kernel.org>
References: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9tk-ZM9IB7gir4AZyyBLoapyCp07B3RTLpl72hC8qUo_1781552921
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 02, 2026 at 10:18:00AM +0200, Luigi Leonardi wrote:
> `virtio_transport_stream_do_peek`, when calculating the number of bytes to copy,
> didn't consider the `offset`, caused by partial reads that happend before.
> This might cause out-of-bounds read that lead to an EFAULT.
> More details in the commit.
> 
> Commit 1 introduces the fix
> Commit 2 introduces a test that checks for this bug to avoid future
> regressions.
> 
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Luigi Leonardi (2):
>       vsock/virtio: fix MSG_PEEK ignoring skb offset when calculating bytes to copy
>       vsock/test: add MSG_PEEK after partial recv test
> 
>  net/vmw_vsock/virtio_transport_common.c |  5 ++-
>  tools/testing/vsock/vsock_test.c        | 64 +++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 3 deletions(-)
> ---
> base-commit: 9147566d801602c9e7fc7f85e989735735bf38ba
> change-id: 20260401-fix_peek-6837b83469e3
> 
> Best regards,
> -- 
> Luigi Leonardi <leonardi@redhat.com>

