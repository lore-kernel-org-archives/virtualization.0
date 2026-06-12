Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D48369219
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255019; cv=none; b=RaqQvtBIvVPZtOr4rrHhQ+MMLhNogU2GsfJEjSsCYeagxPVCi5SHBipGisYCM4E9a87IUMogmaCnu1JX2CmNulADZq7u0ozl9kKRfpaeZpkTMDR2zCIa7PFNvTTvchWzXWmN0EGlLMycMRnuZP1GqZQPcxkBlmRTtZ7JIhfOXeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255019; c=relaxed/simple;
	bh=a533Q3FFH3yo2KCYqFz2PEDlL5vMphhfhil7WUq/Fp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kHkTJN2cuL0RUCgG99TW5EjP+iUQlN9DiQgbROqT+eeV9/1d6kNYTDfOgM00U1peOmsR2lQOyhLllGcNkBCQ96OhobRXJVbQzd5pk6i/Q3FKmwjg/3FP+fewvGMXdIDKS6XrZxTi6yrVK276Soka9X3rsnNXgWWh2Z21G1Mer6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LjtXiemF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjtXiemF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781255017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DfJ3aCD49y+MemH4pLy7wHKCQnfYLBost5pxkmr2d4M=;
	b=LjtXiemFcb6Mf7Fo/K+UCLrz3g7zG6gV+X2KqUxgryY3hyG4lDcidmZ5t0UxVsHwWwQGqA
	So6tJlsYa+lVdJPqaK1e4m9wbIGXbdWkw2CLIz5p5CbsGwx5kYOqd6CKar811r8wEeyyu3
	EQwppc/+jLHa1eUjtqQ2cAgUuHtOT6U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-vT02k9IlNJOVlizxiw-xVQ-1; Fri, 12 Jun 2026 05:03:35 -0400
X-MC-Unique: vT02k9IlNJOVlizxiw-xVQ-1
X-Mimecast-MFC-AGG-ID: vT02k9IlNJOVlizxiw-xVQ_1781255013
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-460198535bcso468659f8f.3
        for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 02:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781255013; x=1781859813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfJ3aCD49y+MemH4pLy7wHKCQnfYLBost5pxkmr2d4M=;
        b=ZeD1CWapeYghZ06W/2W/n/8jPO+nPx3TUjSVale9a8n/i4n/BSdlkKZSjxsZil8YC3
         HlCmVp2JztQdyrnOISK4VESzEMdd9ZuBx1FiTZ6WtqKGFF6xTbV16ACdWSEmawUEg8ih
         ppGg4ZrUAh/8eywKaVbDSqC58+OfqD1TcvqgwVuxd/R26f+9gBuZC7aAkqcws0TXjIks
         hn9ESVERoJu2LzYTySiAFokf/5ZBHMJReZHmZNLAjTCGkjZenyLYWDLU8Vp1Eo+gteKy
         liQytMdqYJVAMJLcTWqRvtFh4W0ZMfpEtzfvq3k99YRiDRpmsgv57wpdsJC057d+RoHs
         7JGQ==
X-Forwarded-Encrypted: i=1; AFNElJ8hm8ndsOd+9gv3sRam+hv7moSXQ5Eipfh8jcHZ2/oVCaPkyviCvsezI08cszicr8iUcNGzYBJcURE+MdbA6g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4jU95QR5MHq2TGmKuaNHhKVeqjW5R4MpSc3EtEnKo9oG9L61v
	TP7baYOfferLfZMeD0QBT8dW1I6F5LmFU4op41T5DYQhLV7w7Jvwdwxj4xpp3/XwU4rbvwMxBD1
	RbPdEa54iNY5iVBicQ6Ni8oxRnqbq8fgARJ9KeyQpxqVcZ6xw0wmUL75Z6QU4EQQD9xxmsMpOsc
	mU
X-Gm-Gg: Acq92OGDp8L5jeW7O5C4wvRIqrJhtQxv3Wt6+xwUmG9J4/zptMLlAuECxai6ZAyVA+O
	r++u0cJREMlKb+lx1KjH0r8Gu462fuKGYG15NCbgBTKd3+VFZWQfnPbKW/KbTyhx3DUWcLGso6d
	6TcWABnxENIV8RTiax+pLMw2rpVBY5zhnqSkx/Rcm4O38iLRgeFV5f6WIwujeVbMuLb56Wxos3k
	AioDRaxtYQgKqDjUwt98UogxHg396e0NlkAYwu61MD2v/pcbJmdxz/7zg+IMuWg6d235tidq+Ul
	hqsu7oaDUDQF7Tly5s18sh4V+ENdmhpPJG8QIzHNwi4/trdHo6g179KYLhiddAEzVunUhvvckoa
	7DGRKoG6y37l65GnT17S5GEwhxsXUxvLobQO8tVQoerP6pxycb1Ufiq7EZ5KYcGv7y1cXG/U=
X-Received: by 2002:a05:6000:4387:b0:43b:498f:dceb with SMTP id ffacd0b85a97d-4606db965f0mr3187077f8f.9.1781255012823;
        Fri, 12 Jun 2026 02:03:32 -0700 (PDT)
X-Received: by 2002:a05:6000:4387:b0:43b:498f:dceb with SMTP id ffacd0b85a97d-4606db965f0mr3187011f8f.9.1781255012353;
        Fri, 12 Jun 2026 02:03:32 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f4f6sm4076902f8f.16.2026.06.12.02.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 02:03:31 -0700 (PDT)
Date: Fri, 12 Jun 2026 11:03:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com, 
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, leonardi@redhat.com, 
	horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v2] vsock/vmci: use sk_acceptq_is_full() helper
Message-ID: <aivKma8mRjTXV0BM@sgarzare-redhat>
References: <20260612045842.122207-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260612045842.122207-1-rafdog35@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6oD3JBC_wAf94cFMdX0Odotsn0TinM7Sy4lgCz9dbSM_1781255013
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jun 12, 2026 at 04:58:42AM +0000, Raf Dickson wrote:

nit: title should be updated since now this is not just vmci
(e.g. vsock: use sk_acceptq_is_full() helper in all transports)

Not sure if it can be fixed while applying by netdev maintainers.
Wait a bit and in case this is not queued, resend with the title fixed.

>Replace the open-coded backlog check with sk_acceptq_is_full().
>The helper uses > instead of >=, which is the correct comparison
>per commit 64a146513f8f ("[NET]: Revert incorrect accept queue
>backlog changes."), and adds READ_ONCE() for proper memory ordering.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>
>---
> net/vmw_vsock/hyperv_transport.c | 2 +-
> net/vmw_vsock/vmci_transport.c   | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)

That said, the patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index b3394946b2..e6adbc4701 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -323,7 +323,7 @@ static void hvs_open_connection(struct vmbus_channel *chan)
> 		goto out;
>
> 	if (conn_from_host) {
>-		if (sk->sk_ack_backlog >= sk->sk_max_ack_backlog)
>+		if (sk_acceptq_is_full(sk))
> 			goto out;
>
> 		new = vsock_create_connected(sk);
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

