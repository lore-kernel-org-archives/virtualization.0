Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006C33546E3
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166940; cv=none; b=EIMghtD9mxKnV2npOzM19Jx4dkKFEZ524Lcn7/50lGlm2npb+DknfSyjmdG4RTtMMNxlrJgUcJDapnkc2l2aWSkTNW4HcVgR1oQoHb9kgwwrv/wMBXKRCH1hS2pb7of+X1s6fgIosE+vO4Rvta91Wlpm7ctuqeaVRrLC77o21GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166940; c=relaxed/simple;
	bh=3rO17jRlAOsrSbJB0ZIw2moUqwsxu1pGNuVPbz2lh0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JEQWBzqC6V6KMDsPqy3uP6LbUvAqVKKgaOid96GLYlkyCcKfTu5ERxu5HN94yG/7R7/v300uA31kemf8+rr3bU9+PhiOl96PQlWIzYzdcoe6ELn1hFSlw1ICgMhk1uLBZJLLyywc2VCk6PNCsEFl7ECoMHjv2aHxtBCd+cB40Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQd905sx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQd905sx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781166938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S0nATCJiZ4/9NOe9aaTS6Uk2On+QYrgr6XLP0GHNht0=;
	b=eQd905sxt+UISW28ysjpWkSRZUz0c3VmCyg4C+yf5gG+jku9ZR2EZNOG0dpVsHQ1YTIsom
	4MhUjFA6a7SD8T0IoB4SjNiSU/pCYoLmiLZPnLkZ4pSn6bPKtm4VpBwL6EX/T5fihRqwDI
	zBEevU0VykaY0GsUj1UaWUb0/TZiZTY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-ZaL7QOaXMdSBYoBcRrnwKA-1; Thu, 11 Jun 2026 04:35:36 -0400
X-MC-Unique: ZaL7QOaXMdSBYoBcRrnwKA-1
X-Mimecast-MFC-AGG-ID: ZaL7QOaXMdSBYoBcRrnwKA_1781166935
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5aa607bbfe2so4538621e87.3
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 01:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781166935; x=1781771735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0nATCJiZ4/9NOe9aaTS6Uk2On+QYrgr6XLP0GHNht0=;
        b=FIoiGvgNQZGrVSlGmSWb+nUby5DhcySqWujXAC99ZlVq2ecg0vVlWkv/oXwOgyO7G3
         kUACEwN3FsVAHtfv3FKCKlJ+bEmOUN1g7xVSHYY1+/mTr5MJc8il7jR3fImnouxzbc7k
         RXNSWQTzL7+7B6Fc8e1y8G2pE3U1bv0+URgoOf0pUK55jYx9/plzsDSdq3G6tdld4Jm+
         ePKhGPgm7ysQurbkgwlFopmJlw8FmKMCQ/vn7mhsXfGWBL+myvVKq1sNYQZwS72Trg1d
         EDeqevQVaEJrvkqywYvdtJF+9iiIdXqx0cKeqoKKoaxWonlFj3whWzV0IarQYxFM6QV3
         VZ9g==
X-Forwarded-Encrypted: i=1; AFNElJ+sCpFisFu79AsvZIdoByL6WSkCYSiKF3rks8WD6/1bif09NN13lhPUxPWe3n8R4WanmSU7qMZwxjQGUp3D4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzG9HScrrwAuleKYYxgA/21HI8fqs10pUX1lTN54NH4mPrnKtZ
	nFSId4t9HWG9xvUCtBkZX28a68Rb6ox5LhQW/5kRTqLZw4rOGxsc4Lmfj3DqxEdioq+szPwkpAu
	/GIW392VphRbhxQu3017EIGbqkPAGYmNmjbnjoLYWx5kuwNGXrzDYDOzEYhy3uoSVIoNe
X-Gm-Gg: Acq92OFmlLte2cZrJwUiYfpyga7pawk/CGB3jzxlpktaftY2rcaT+jd57CogmkcTtvx
	AqbttSMK8ZwSO76jhgmBP+sUTwJ0+Kwt//WewZFqSEHFQdAKmpL6vwM9vOfJG8SKVTL2raAq1QY
	J837WEi+mniMAEVXwtO6oRjdiO7+hyLCzXB/7734k5ffC3WZGnauOWpFp09s1sI8MGsOcErItbO
	By96kWSs65sPVyYAyZvgpACdh4pywyXdKAq49ZnJXJZoXLSMmiQhZsPixbTPEnjgbEELrykuwFc
	9nbnuX+yQ2Cps0ajY/ZZ4pqUc6ha+57RZ9q9qxnlPYzarT+X6E6rjmpJcRD8TLnHBoJ9C5YkAlQ
	45viGaEVJGleqy8fuSCcXxnJ27mihX1lzgW4HjaoYbZPorviIENi4Gcp2KQsl+ZFi+2f35mt3L3
	5li1rotA==
X-Received: by 2002:ac2:51cd:0:b0:5aa:77b2:fec8 with SMTP id 2adb3069b0e04-5ad27fb70bfmr571636e87.27.1781166930410;
        Thu, 11 Jun 2026 01:35:30 -0700 (PDT)
X-Received: by 2002:ac2:51cd:0:b0:5aa:77b2:fec8 with SMTP id 2adb3069b0e04-5ad27fb70bfmr571612e87.27.1781166929711;
        Thu, 11 Jun 2026 01:35:29 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b97b042sm6167879e87.47.2026.06.11.01.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:35:29 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:35:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com, 
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, bobbyeshleman@gmail.com
Subject: Re: [PATCH net-next v2 2/2] vsock: fold sk_acceptq_removed() into
 vsock_remove_pending()
Message-ID: <aipyNh_qseEUxj6Y@sgarzare-redhat>
References: <20260611021317.69362-1-rafdog35@gmail.com>
 <20260611021317.69362-3-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260611021317.69362-3-rafdog35@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Fk_IAkkC70FsjY7mX_vw8lofIHVV0mNWIDa4iDHqDzw_1781166935
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jun 11, 2026 at 02:13:17AM +0000, Raf Dickson wrote:
>Callers of vsock_remove_pending() must also call sk_acceptq_removed()
>to keep sk_ack_backlog consistent. Move the call into
>vsock_remove_pending() itself to make it automatic and prevent future
>callers from forgetting it.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>
>---
> net/vmw_vsock/af_vsock.c       | 3 +--
> net/vmw_vsock/vmci_transport.c | 5 +----
> 2 files changed, 2 insertions(+), 6 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 73e6416ee9..b9772a0205 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -493,6 +493,7 @@ void vsock_remove_pending(struct sock *listener, struct sock *pending)
> 	list_del_init(&vpending->pending_links);
> 	sock_put(listener);
> 	sock_put(pending);
>+	sk_acceptq_removed(listener);
> }

I'm unsure about the ordering of patches. Now that I'm looking at this, 
it's clear that 2 patches are really related and can't be split without 
breaking the bisectability.

Maybe we can keep these patches separated (which I like) if we introduce 
the vsock_pending_to_accept() I suggested with an initial patch of the 
series (feel free to chose another name, I'm not great at naming xD).

Thanks,
Stefano

> EXPORT_SYMBOL_GPL(vsock_remove_pending);
>
>@@ -761,8 +762,6 @@ static void vsock_pending_work(struct work_struct *work)
>
> 	if (vsock_is_pending(sk)) {
> 		vsock_remove_pending(listener, sk);
>-
>-		sk_acceptq_removed(listener);
> 	} else if (!vsk->rejected) {
> 		/* We are not on the pending list and accept() did not reject
> 		 * us, so we must have been accepted by our user process.  We
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index 91516488a7..a417403c8d 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -980,11 +980,8 @@ static int vmci_transport_recv_listen(struct sock *sk,
> 			err = -EINVAL;
> 		}
>
>-		if (err < 0) {
>+		if (err < 0)
> 			vsock_remove_pending(sk, pending);
>-			sk_acceptq_removed(sk);
>-		}
>-
> 		release_sock(pending);
> 		vmci_transport_release_pending(pending);
>
>-- 
>2.54.0
>

