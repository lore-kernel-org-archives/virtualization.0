Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C626D347505
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781261305; cv=none; b=uMn/RUgTY96wZi7g1RPw0juQULggt4hgr1Fy5UsnlHgrL3BOaL3RnKMk686GiLQFiM+vxM6i+dKsIb4JCuALGl4KtWdxXQzUdoIEcZp85lTktcDSwAVfRsFO5VmBsh96at3xNSu0+AJ2iXNWkner+IQNeiruoGrKyxietBQvVrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781261305; c=relaxed/simple;
	bh=nIUd4dRQc7lninJ4PQurm9K8z6iyF8PSKyxa+RhCCws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sZFZElPI9ALL5Z7c/S+pUd/rqo9jjaC9Md2LUaS2gMWZxCXfBYCOftEyHLwvyvk7PzjecgmmkUt2cMa2FRZE2xCZZnFw/xPcRN1psa1YwZZDI1RGlvIzQAp5buc/wfRkJ4pgXjNMZ6Y+feRsUil7yUYRTyj8AfXK0RNJjWvocvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lr9Hgrt+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lr9Hgrt+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781261303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pcVW7gr962xWbfB7rW7cz9KI0TlCsoEItlTo5USlTpY=;
	b=Lr9Hgrt+eqEqs0qUNw7TQu9feKHSHc2gPjuQnNC3qSmVnNW8XWy/KWb+GerHQsGkGP/3dN
	bKkhIYet0nLuw2D7ZmTfc+CExD7E7WR6536kFiwjlub/ATMvzR3/RCHFJksrZ1UAvmOy8n
	fEp7gJgdYBIcpueLgQz85+7+DJQNuyo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-w-XfFKgnPYeRl7p89ntdVw-1; Fri, 12 Jun 2026 06:48:21 -0400
X-MC-Unique: w-XfFKgnPYeRl7p89ntdVw-1
X-Mimecast-MFC-AGG-ID: w-XfFKgnPYeRl7p89ntdVw_1781261300
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490eca575d6so3316635e9.3
        for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 03:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781261300; x=1781866100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcVW7gr962xWbfB7rW7cz9KI0TlCsoEItlTo5USlTpY=;
        b=Q2N/vbbAGVGoG+be84lGm25TM8ddsBnSwhumj0FmbvNl/djmdzcyWef8aahq2ahMMX
         rAPkwWboZ/c0mLLy0TEBpFN9jMw0lYceWSuq3xF+lN/qzkX/uZZntUfsCZPPfv9fpM69
         2uqa7RE7L5+FY2kZyeYTMqOzQIV6X7NO8noFVcSDSStQhe7lcG84bhN+Rb4YH6u+8M+f
         3VZoA0bcHa8jfGoJt0NstgshJhgiz79QiHISvNcSAIdqH4+rflFcT2N31NnjWfibBAju
         Pr9QTmOXpR6K9fEYyHbhibk0C42uPhdC4JwDCF1O5ySk9DTzlig2JAoGJlZoyDzHck8M
         fAHQ==
X-Forwarded-Encrypted: i=1; AFNElJ+SzfdSq5ClK7w7S242+tHY0b/Jo07m3iW4NnL2tQvIzywCuRdecxlFqE555D1muQjrjlFmQA2oYONGMZIKgg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDImRtuWGejtNQ75y9gutC3gJzbky3tcezKItjKf0ufeqP7y7S
	dKmqZC5reLcSM2hb55yHIBrM3x8nJz/nDGghbZQVA0C/5Z6N6pMFFAAOl0pBjAAuUQIHOrrhj6K
	cyPfPJU8bG8brQ5uJS7Xt0n1UolQYj0ugG1Rv08EVzZWjeBzGbHcfjVEns+GCkiWNspzE
X-Gm-Gg: Acq92OEa9ApE3AM2ALUjx1OXJmXUvsKvtDBYr5VpOvJ7apxjKj+S/7dGiZhTYS7cFT7
	cA8SFMJXK45FhmCtUXNAxlxJX2uQLfkLT1n316tf5byoA1TZDTGPY+eSPrWXJQXTUSr+YvegCSV
	2+qrsdSK3Bc22ohiTvF3vEDVSWnRoVeb5WkGJVgfqv439oUKld3Dwd+zu8H202s5mu9j9NH0sDF
	KA68AjeHfN3SxJ91za/W8D+6Rg2kphUmvxgLtv08IlEJ9zf2mt8HowYopz9BJTBEDR6Xx4EUppT
	g3+DIwq1/GIlQpjp9oZEbb0aFu7BIa6Svz2mGNaJI1YavwEOIpyTYtn4IeOVqgXMmJQAJEioZf5
	eyX15thoj5YxHQuYoJsjR+pFUqKjbw7p15Hkti2whKSQ6VlhjyqHGNjUmzN0mIPkcfZ9yKnQ=
X-Received: by 2002:a05:600c:4685:b0:490:e190:3b50 with SMTP id 5b1f17b1804b1-490ec4d4f7cmr30972955e9.9.1781261300389;
        Fri, 12 Jun 2026 03:48:20 -0700 (PDT)
X-Received: by 2002:a05:600c:4685:b0:490:e190:3b50 with SMTP id 5b1f17b1804b1-490ec4d4f7cmr30972435e9.9.1781261299894;
        Fri, 12 Jun 2026 03:48:19 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2d046d5sm137445175e9.13.2026.06.12.03.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 03:48:19 -0700 (PDT)
Date: Fri, 12 Jun 2026 12:48:14 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com, 
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, bobbyeshleman@gmail.com, 
	leonardi@redhat.com, horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v3 4/4] vsock: fold sk_acceptq_removed() into
 vsock_remove_pending()
Message-ID: <aivjf4TZU4Q_s20y@sgarzare-redhat>
References: <20260612045216.105796-1-rafdog35@gmail.com>
 <20260612045216.105796-5-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260612045216.105796-5-rafdog35@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -I-4X1Tbnw2tOJjLelfRQ7VTsIWCywnxS2NKx7BlXYA_1781261300
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jun 12, 2026 at 04:52:16AM +0000, Raf Dickson wrote:
>Callers of vsock_remove_pending() must also call sk_acceptq_removed()
>to keep sk_ack_backlog consistent. Move the call into
>vsock_remove_pending() itself to make it automatic and prevent future
>callers from forgetting it.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>
>---
> net/vmw_vsock/af_vsock.c       | 2 +-
> net/vmw_vsock/vmci_transport.c | 4 +---
> 2 files changed, 2 insertions(+), 4 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 24916dd4e9..4a7d6d247a 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -494,6 +494,7 @@ void vsock_remove_pending(struct sock *listener, struct sock *pending)
> 	list_del_init(&vpending->pending_links);
> 	sock_put(listener);
> 	sock_put(pending);
>+	sk_acceptq_removed(listener);
> }
> EXPORT_SYMBOL_GPL(vsock_remove_pending);
>
>@@ -773,7 +774,6 @@ static void vsock_pending_work(struct work_struct *work)
> 	if (vsock_is_pending(sk)) {
> 		vsock_remove_pending(listener, sk);
>
     ^^
There is an extra blank line that we can now remove here.

BTW, the code LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>-		sk_acceptq_removed(listener);
> 	} else if (!vsk->rejected) {
> 		/* We are not on the pending list and accept() did not reject
> 		 * us, so we must have been accepted by our user process.  We
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index c2db016cca..3e6445f4e1 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -980,10 +980,8 @@ static int vmci_transport_recv_listen(struct sock *sk,
> 			err = -EINVAL;
> 		}
>
>-		if (err < 0) {
>+		if (err < 0)
> 			vsock_remove_pending(sk, pending);
>-			sk_acceptq_removed(sk);
>-		}
>
> 		release_sock(pending);
> 		vmci_transport_release_pending(pending);
>-- 
>2.54.0
>

