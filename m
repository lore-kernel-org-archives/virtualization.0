Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5683093CF
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781272068; cv=none; b=qYZp71ShtMNivCVqDoOZQ4MgWmnr7thur2cgheY0GXPFtXo5v8EaGKHPNnei3aaaPF2DETx6wVQCgVinsRcBHksvaJJj7RT+jed/quIhDLgAsQSXhD69jEHnDHs8UbzAAsq37Gjq6R2grLU2/b1dE5JeVvxmVMGTvTXk4rg2GAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781272068; c=relaxed/simple;
	bh=ADqmMMmHrnd6NU1LxNaUGBwtollz8clLsTpmV2+P658=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=afLON0QyNGneL97M2b0XHnmxrqTqiXTyPEEix7hrjWQZOejZkiqGn/+btk9BWCtVSXdxlbazjfp5U6mErRStHPSo1RbarYqPiEFMuGqv2tmXKlNAa3odeqRgyVmYwCLxGoyn5cn0MB0xXsq2O9mDpRFxKlcJNO+StwnOHCuJMdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rrjfo+Kt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rrjfo+Kt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781272065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ADqmMMmHrnd6NU1LxNaUGBwtollz8clLsTpmV2+P658=;
	b=Rrjfo+Kt+Kl4f726hZ4jahXCZso7LaTLDRzUb2SdBCktsBiPvNhyA/wjEuGWfZcBC9xPDg
	sSC05kTcFN/FT9Ye94OX5cUQEVGaBedaxHsNXBkB23VSv1PeuYYlkS0A6rDKrolJmiP9PF
	TzZ+4i7aQJA/4hYSXdGj1zI1ykN05Ns=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-TZphUFk9MECYgxVuLSrcNQ-1; Fri, 12 Jun 2026 09:47:44 -0400
X-MC-Unique: TZphUFk9MECYgxVuLSrcNQ-1
X-Mimecast-MFC-AGG-ID: TZphUFk9MECYgxVuLSrcNQ_1781272063
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-460153ce644so724436f8f.0
        for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 06:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781272063; x=1781876863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADqmMMmHrnd6NU1LxNaUGBwtollz8clLsTpmV2+P658=;
        b=rK7uZgKkwjkOSPnZNNjVsBa6kv06IB24jh1o/FCih+VYd9aJGoorCeNc4qrjC+E5Qc
         Z7M7UYOkoOUwuELNfniLQmS+NMdODiUOM1XJs+66Fo+NAJ75jcBSAgf/EaTQBSs1Jxoy
         l48FqBLQEKOj/wh1gjcSQno4DniasolwyA9R88iFtfkNcL9ue4qKQYv4ZHjCypzAf1Mi
         y/P9jU3fAmJLVbpSeBjnxobUX3c3Pisp/9WvU0k/fqF7OryG3MmytUo4/+2mbgDmEcCB
         sPYTWn2eXSNy8iAjRWBlm5AJx3o/qeQmLVH7A9LvRS61CkqHrCUhBmEKpmRFLLxUO9LF
         t4Iw==
X-Forwarded-Encrypted: i=1; AFNElJ+jxra5IKMnIgnQX7SBh3jUNOO4XWS6olagWQcTFRs3mg6wXwOgCO6NCrbdFUi/6kso8sHNaSTRjTIcCwxp1g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHZjVwDVj4/4mhNK1X8ZTfwFRZipBOMbEtLvuMgBkm0Q5kO895
	QFPPkq82HXVZ8QeiiVqJ2ff/JPtb0CADdnZIN5iP0PTgXmQcEXhSCJ9jf4RG40Vs3oJUln/uxju
	STXcJqPKEfK+NA2uUj6xWBfdeSJI+2XyXAQcOcaYoisYmYhh8VgvI+XLfjT6jn4WOiW+/
X-Gm-Gg: Acq92OH93rG0IkQDt716ObMCksHOO7yNMjytTcyBr7vStpQKEl9zZi92p3x6Hebxj9U
	oxBuXpvNr5oM444ogQBlUU699j699IPxgHvv6sSZiQtoAmnQHNwJJe3o8mE+TMppyOmsiqHsxYq
	olMPwc+S5LcmTCCaWri80mhi3y7f87lllwaCM81JXH9BHZJPKekkIV+4ajKEZ0olS3W9qOL8cu7
	N+VoXPX6CxIv0O8Gd6z43cAYxm1JC0WdFIEnN4CBQskTgQE6O7lYUOP2Ln1Sg80C/UPcp0+4/XZ
	FoctSe05K9zsVOMFjP/xXniCxPa7J8V3dLGcckpmo7ckUE5bhZYqOC/RSUghZsT+Xdt6NgogQpU
	M362n9ey/g6tjEPN7rsMAkO+UX/FWTU1+Dvh0ZpOr1VFkt98pVi5NLjZVcWo=
X-Received: by 2002:a05:6000:2982:20b0:43f:dbbf:6d93 with SMTP id ffacd0b85a97d-4606db98392mr3413008f8f.27.1781272062793;
        Fri, 12 Jun 2026 06:47:42 -0700 (PDT)
X-Received: by 2002:a05:6000:2982:20b0:43f:dbbf:6d93 with SMTP id ffacd0b85a97d-4606db98392mr3412986f8f.27.1781272062395;
        Fri, 12 Jun 2026 06:47:42 -0700 (PDT)
Received: from leonardi-redhat ([176.206.21.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f3dcsm5879863f8f.13.2026.06.12.06.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:47:42 -0700 (PDT)
Date: Fri, 12 Jun 2026 15:47:39 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, 
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	bobbyeshleman@gmail.com, horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v3 4/4] vsock: fold sk_acceptq_removed() into
 vsock_remove_pending()
Message-ID: <aiwN7Uf7X5lMQurn@leonardi-redhat>
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
X-Mimecast-MFC-PROC-ID: lyWBxllir4SRksPnGI8Qb59bZKZIwix66y9BXVIKf30_1781272063
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

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

