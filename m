Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A4D1F5821
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167061; cv=none; b=fyFDpJljU4jt6VEsHLQ/Tve+GArgZmXkL5z6ATwlnivIfoTNpedBFsQzuQYrmJsMpJAzxC2XVjUbo3i7MHfwMHHT+OMqnGZwIvicEoywir1bDTaDgdjzy8KITl1FTjT09PYWXm4WrZmujxQ9mBbSwX1WiULTrM0XotDnbo2vFaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167061; c=relaxed/simple;
	bh=NvlAo8p3VOJuEX4siqyneWFfrKAEXaYb/m2XwzdYDcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lIZeV9otoqIjOrr5OD0jPKHm/3N60tVWsBsxTyN+Dl2zymmKU+w4gxLSnDnwwCVBFWUBAsb+yfibqGVjWpOnTxelpeNUCQytAPsYHVbKuM3cgNmRkXCiUCRJ3VJu/stTA36IiyiKRXCcVD9ZfynuJ+DPbhC0w02ouZ0dzbZep0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WSL2P5T8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSL2P5T8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781167059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lS7ZmG5aZMc+d97NydJ9B0CqAYrDHmwAPTt7zF38280=;
	b=WSL2P5T8g552qqas/kDW8Q6ZEM06kWufWrUmtQ34enAtq+bDzr8zwYCOUaEoxdnaZFzwkx
	1hTr1EQ8Gu5Un+F7XNeUm/mdf/sIyQ9M4+ex1WW7b38iPZCRHL0QqZgoUzWTfJj1+kIZr/
	HDmGePnkWgeeZlq99TxkqeLd5C7hoKQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-Hk1f8LkHObSJHGZLdrwjUw-1; Thu, 11 Jun 2026 04:37:38 -0400
X-MC-Unique: Hk1f8LkHObSJHGZLdrwjUw-1
X-Mimecast-MFC-AGG-ID: Hk1f8LkHObSJHGZLdrwjUw_1781167057
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490b3ec3f7fso48921085e9.1
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 01:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781167057; x=1781771857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lS7ZmG5aZMc+d97NydJ9B0CqAYrDHmwAPTt7zF38280=;
        b=spvqe2lMmulLf8za7pRBn/8aI6TBrTFSk/BW8EcJRmi5P6cg9QnVvjOfThQJMhB/fk
         FylldTay3AYhRah+ahjntpuw5RD7if2/gffWOQCaa1JaekZnpUgHvg02WyajGWXFFk2m
         NhCaJ+GJhkA+3QIk62M4UO0W/1IM3bCMmhgUcdDBQ0YZ/gNCGFednw66ROFGdvGrp1hm
         yhUrLzugeOGmN1u7JFiHVrsD0lSkA+dErD/GkTvPTKDs9iBnlEz2PNjJ5euH5hZQHnXJ
         ByB3lZjd8+NXPRrhkPoZU1bk8Y8GRGdvKyo78SD+HAoR5uqt5W2LbZPkTvb4l2jXRVpp
         fSdg==
X-Forwarded-Encrypted: i=1; AFNElJ+AiwKQQXJ+mH9vHiF0gtWeKRGuALidH3jZuqp6d/PBRwVFHQzjrTWqaTLHf24svbB+MNPtkRQOkvMrwDUL5A==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywae/yQebmn5X34ALCQr+48buZYkpwgoLZa27kTrvtAtaGOfTus
	lzhxXeMIO8YwdzyJNg4qS2D+3I0iFTT7+2kcgw4rqUJQ+z4lg8NdTdl8G9Mf7Xqz3JQmEa4SPTh
	NEbu9HpUnZYtZgHVgPaRlzI0pMjuaxFS0b+ETqoi9z5/ht+1tF3djzF6Dn8sLJURAl5US
X-Gm-Gg: Acq92OGZ7oN4TByXb6ueFDl9fJJUlOceeveKVx/42kZCiH7F22G3pDTR6g8KeHOI6yt
	36CFhzD2dh12zzvmoCsxEZtXFyGniS+6APyHmW/IkiNXjIEbEeoqMv5Wyd8uEY1mkzxOdt7XWUH
	5faBihK0N1tbMLbdE0w1CoIXg6xCTPb8fgJ6RIEiw5Z9x/zJjgBbi3X6RcyuZw3z3DV93BJoj9j
	v+tDF5M/vNt5ClTAksnfC/TKFVeFs5I/cHYfnmAM9VNrrrqieA+CPvkUkziQHiqxcakLyLM1vn8
	YDpwPsC2V6oSK7fspTIT91HdBRkwGHJSqUBmF5hw1OocW8eBPlHW8Eira6gVucYX5qSlvgHUknA
	FIZW7ve8AYLuGG6Kljaj6M1t4G1T0bKjYpOxtce6ZyhSgltLrqAgjyWjOerVaIjoK4bylTwSeyB
	zupyHCVA==
X-Received: by 2002:a05:600c:a211:b0:490:9d1b:f05c with SMTP id 5b1f17b1804b1-490e5629f6dmr13969795e9.33.1781167056691;
        Thu, 11 Jun 2026 01:37:36 -0700 (PDT)
X-Received: by 2002:a05:600c:a211:b0:490:9d1b:f05c with SMTP id 5b1f17b1804b1-490e5629f6dmr13969415e9.33.1781167056231;
        Thu, 11 Jun 2026 01:37:36 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46028a6dcbdsm66492257f8f.7.2026.06.11.01.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:37:35 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:37:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com, 
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next] vsock/vmci: use sk_acceptq_is_full() helper
Message-ID: <aipzlgTKa1OuKrwg@sgarzare-redhat>
References: <20260611023830.106259-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260611023830.106259-1-rafdog35@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OpSz7Mado1zCAC_7r-kWmxRItdOgvC3_jh1f0i68xWs_1781167057
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jun 11, 2026 at 02:38:30AM +0000, Raf Dickson wrote:
>Replace the open-coded backlog check with sk_acceptq_is_full().
>The helper uses > instead of >=, which is the correct comparison
>per commit 64a146513f8f ("[NET]: Revert incorrect accept queue
>backlog changes."), and adds READ_ONCE() for proper memory ordering.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>
>---
> net/vmw_vsock/vmci_transport.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks for this, what about fixing also hyperv_transport ?

Stefano

>
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index 91516488a7..56503bee31 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -1010,7 +1010,7 @@ static int vmci_transport_recv_listen(struct sock *sk,
> 	 * reset.  Otherwise we create and initialize a child socket and reply
> 	 * with a connection negotiation.
> 	 */
>-	if (sk->sk_ack_backlog >= sk->sk_max_ack_backlog) {
>+	if (sk_acceptq_is_full(sk)) {
> 		vmci_transport_reply_reset(pkt);
> 		return -ECONNREFUSED;
> 	}
>-- 
>2.54.0
>

