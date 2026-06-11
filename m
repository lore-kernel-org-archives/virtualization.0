Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FD7370D52
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781164710; cv=none; b=P0PZR59AMOpGrfFR/0Xs02wa0DYPLH6hpEBZwJS/0Psn9GP2I07oXj3LftiWcd6vldD0OijZFUistsxxR5uZant4bH74R8Ntt/DHPtv12T5On1urHIAHT+nNfYx97wNFC0Wh44YmqcSHaj5UpkkzfLxMLJdo1eTjMr3KYAhsMSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781164710; c=relaxed/simple;
	bh=ZEy+ssPgj7fd9v3cExsjBXsdFe2eDfx6ZME1ev+0piQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=i7vKTNGu6TuBnzGZA5wc8IUTnPcJycDxaU2SnutMsTmRZwzi9ayXXfwy2KNOTNF/73fjC/PhRbASMfIZBFIxs99a6VD4VYqQpA6Lxtzz2Z3So432ag0MaTHgD33OmcHSkUub4mL0JvFNd6KwhbmiXy2cecytA0Cl61NnDyQLPrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AyvN2diM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AyvN2diM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781164708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f9weTyP7JI1bIVxhUTkM93LkL12ISvR/eoJ6k3ozVeI=;
	b=AyvN2diMBCyVPoCE72tp+bhjpq+IjNJM/lLuZbELWLKfwsDzaRTRyC885WAVHjy2cLwrid
	8t2d/ZqN2pwhYtV5I39m6hKwmgq/a7F2u4aBIMaAtuWi6pKWHhlHLgFJthXgxsff5WMQsr
	yhT5qs1eXeimMZcipKRicaRN6xf/Yic=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-rH6Pv0L5NFuC9OxjTiL0sw-1; Thu, 11 Jun 2026 03:58:26 -0400
X-MC-Unique: rH6Pv0L5NFuC9OxjTiL0sw-1
X-Mimecast-MFC-AGG-ID: rH6Pv0L5NFuC9OxjTiL0sw_1781164705
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-46011aa5000so3365817f8f.3
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 00:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781164705; x=1781769505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9weTyP7JI1bIVxhUTkM93LkL12ISvR/eoJ6k3ozVeI=;
        b=D907pWICK3VQ1Y7NZKdhf97vzEjOHFKNtpEFBtJVQwQe023Ry+nUp1+YgEhiR3om7T
         LbiyH8NhIuVHhUPcIEGFWkYLw7eJ7cu+DjoNJ/gBG3LwyfT6EIEfFNugSaoLUd6m6yfS
         4Lh9hFU62wNRVNdKiHtALheNQcHgIJMOGBigZ6PL4Z0H9xchQLjqmV72KYYhQvd+9X9C
         ZXeCZtYMU+FomQ4wgGLvPR58yKTzXSBU1rawznXxL8WSpifV57gF2inhj3kwev2svQ1x
         sQehQn6+XepsE2yHhno2mxD/+gf+/CkWb3x7kLBq1zvHAADJe4V60wN89KXvEFUkPEr9
         Ej/g==
X-Forwarded-Encrypted: i=1; AFNElJ9R2HPnCWEzuSJddW6ybZYQL20DSu30rf0MRppMGsvdIboRJ5bDZwEuLjlKPHOiR//DSakL4oow8B4bPb/rKg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyiftFAj47l9v35gJATUX7mh8OfO41JUMau/WbVeRFRC06UomOu
	AHyzMMbpzv5ZBeaO7IhIlo/oxAkIXcaABVQK1r/RF6DLBlZsSdgjkRp2FeJsDNrErJdMggU3/0n
	fRYD6JHUK3/UiklVFbxyzyuSpQBhZOfMDHNvhc99nU2Qx4tstfljLpab0jEEQiTPRwHW7
X-Gm-Gg: Acq92OE6wCuuIC/AFxCtA+JilvGHk6/oOFQhb+EqDNmW9rTn2lLnuE7nMY+eatu1QtZ
	NRs2A7WE/4g/nHngv/3rChUtqLjHL2iCeDq1Lf9QeNOPdDyG3YYFBJl5PNtyVckLGV3bGGsk841
	gz+3A+dCvwF81ggA/nVo48dgn69MhUQKU6ygB5XzZqrLfoUq7IAhIJrqpo8VkP+11t8C3xcJVQk
	Pl2pB1YJdL5e++hCcv64okjr7HVUDAxQ0apXoFzl2LVs826STneCUg6mP6MlkeskpLd0ojgye77
	QElVSPK+bylcMfhc/T3SHHkhT3oPWku5noEMFuCYe1lDS2s9dF9lI28PmkUteJ8L2xQQAK0wlIM
	Z8GaQhlalWqJVO00gGf4kdW8zVOKt30h8Zza+8YIoAKFnD+8XkscRvGGri82y1r39nKeF6w==
X-Received: by 2002:a5d:5e08:0:b0:43d:77a8:3baf with SMTP id ffacd0b85a97d-460677d03dbmr2238679f8f.32.1781164705340;
        Thu, 11 Jun 2026 00:58:25 -0700 (PDT)
X-Received: by 2002:a5d:5e08:0:b0:43d:77a8:3baf with SMTP id ffacd0b85a97d-460677d03dbmr2238634f8f.32.1781164704969;
        Thu, 11 Jun 2026 00:58:24 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3446aesm86374521f8f.24.2026.06.11.00.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:58:24 -0700 (PDT)
Date: Thu, 11 Jun 2026 09:58:22 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, 
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next] vsock/vmci: use sk_acceptq_is_full() helper
Message-ID: <aippcmlliXpO0BXM@leonardi-redhat>
References: <20260611023830.106259-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260611023830.106259-1-rafdog35@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sMQIHNAHu7yiMOaqQge57TVLNAq6T7N0Elkj1pVho08_1781164705
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

this blank line should be dropped
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>
>---
> net/vmw_vsock/vmci_transport.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
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

Thanks for the patch!

note: according to patchwork [1] you forgot to CC some maintainers,
please be more careful next time :)

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

[1] https://patchwork.kernel.org/project/netdevbpf/patch/20260611023830.106259-1-rafdog35@gmail.com/

