Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAB1347BC1
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171028; cv=none; b=eJ9OgwnidwoL5RdqbBMrsFoeEoROcDbpAblefqOEptwXdCdurXMGum9yKdU5KMVMv3MomY2ZpSkiY8GJO3JWT9yVKD8zcMZbEINJBlc3bH87TmDQkPzxKdXtIKenzI7wTX4j9Htvxx8sAgblLQiEqHm7/811rZ+F8w/Lq8ooCog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171028; c=relaxed/simple;
	bh=zwJe9NjwLeRXB4kvfswnxtmZRmzK+isV+tjs2OXPeAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fvpcXMkZS3VqAXvRM4KE5EqIDQjEYEJL2FifrDZ8UqsfADB8bq0Lplva/uHRp2B8GdNyQcdlo1xdzP/AdBhJjy8ucLVqTmciZo32gbUDWLKBmYXDhxFoFqmPV9XdQxrKV+RYEnQmfGfeKhmdrE2a4gfzNZpqXL/0m9o/lOivFos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NsFKionA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NsFKionA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781171026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HwzXzJxi4t01YG2LmZXdRwxBBtGHBaEKZaxu6bnugsA=;
	b=NsFKionA9Naua45MnjE1ZYaU6GWXM+gE0QA43aiMwbvkpjWuoUIDEqIOABrQ6cnkKbLiNl
	aElacbU/Q4odSs5WStoS+nm5N1bq/7SqjfAy+j+ZBCs2GWMs9Lt6CT+idXwsfMN+1dmSa0
	UbW3/HQs/rW5TXk49VX1DAo52uioRSw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-EcKuqwwKOiCNE-05Z1s1TA-1; Thu, 11 Jun 2026 05:43:45 -0400
X-MC-Unique: EcKuqwwKOiCNE-05Z1s1TA-1
X-Mimecast-MFC-AGG-ID: EcKuqwwKOiCNE-05Z1s1TA_1781171024
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490b37e1f47so66200865e9.0
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 02:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781171024; x=1781775824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwzXzJxi4t01YG2LmZXdRwxBBtGHBaEKZaxu6bnugsA=;
        b=ZWplvDWtGEKfzFBkXwdVWyQxugpqL3mQiQPrNaroUrhVWbCaTf6ZjoX9rc7yW3Ctu3
         CxEpNcuPI3MzgAOTHukpImYVbM7WabiRd3Jr6plQqcjNO/m2CP3RB/BstD436Q4rdEK+
         14/q7YglkuQAaKRd4+yHw/urEr3x3sEANi6JAWgUvvVfOxDYywkIKxsi6bzwwaDxwegr
         X8/xnrvOujLRE60sCl07PIQ54qN8QbnaVTvdS1qt0lZqugS6mYCirU//GzCOKXVGBmRg
         eVx7rH3ixjF3L8aIWgM0mOHw2Ca+Z8aiM8iqHaFu0KsfK1O+2mKrOKtDhnXCic/xIGLN
         GmGg==
X-Forwarded-Encrypted: i=1; AFNElJ9I0VyMHkOM7D288K+ufjWHPzY3HX6TtvxOHASzzhc68MoTogF9ijjzDi3qkYQWfOtEOHggskmjYPdHMv3Wdw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBuCMNSqEkL7GJfOY3TgSfdyQrqT9eyIBjNIdY5eJoTq6FdKaZ
	uw/GFzufe6vMkNIH7Dy7wL43z80nbbBFG94XqD3WPKdl8czQ60ioTCLh0QK3OzZ3VMer5qWoUVy
	A2YJagwxOKMMOUR285opFzaI8u3ejTOr/71/eAAMQ1Gw6EHlM+62JLLxHWmXL0pFNvrCL
X-Gm-Gg: Acq92OGRpTrEIQ5AgQ4wpH/GJZnWjZL2GsNY28cU/dyvafYfUfvyTR2ajNORmxBF7C6
	f2HxkgDV/cDWEaF9huYBcMcwxrkKoUFW00g8uW86FzCuR2Nl/8zuqU/1a/jHmwdXsq1tl0HA+6x
	fmfZ0IJKQizYj9KrJm2NFZE5IW8hpD/4NZpIdicsc3QIq/Pj1m4cwUQoxrqzykbiGevYfDVjCjF
	M6ajgAodJuL3kTi/r0uUCY9WBeb+T6Tn8DOgsIpibF4qcop3D1Cq7afeJ8RWNLikj2iAa+HkLqh
	K5tY4dBuzguGXi9b7s/Pak4xkoAtnZhroXlFTtc+2fyFQYk1UhvtY2RkDC9Sb6cMcN2e8kBk39D
	JMOzGd/0TWuMAiuubgcPEqH82k6dbX7w/J8zz1fWMzaUwZzU6FJHw+BDCAzxT7QPdLO/xeFtsTf
	/X3F4SSA==
X-Received: by 2002:a05:600c:4e52:b0:490:958f:2a5c with SMTP id 5b1f17b1804b1-490e5604df5mr24266555e9.17.1781171023920;
        Thu, 11 Jun 2026 02:43:43 -0700 (PDT)
X-Received: by 2002:a05:600c:4e52:b0:490:958f:2a5c with SMTP id 5b1f17b1804b1-490e5604df5mr24266035e9.17.1781171023418;
        Thu, 11 Jun 2026 02:43:43 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2ca21f4sm51473605e9.7.2026.06.11.02.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:43:42 -0700 (PDT)
Date: Thu, 11 Jun 2026 11:43:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com, 
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, bobbyeshleman@gmail.com
Subject: Re: [PATCH net-next v2 2/2] vsock: fold sk_acceptq_removed() into
 vsock_remove_pending()
Message-ID: <aiqC6U87G0FSabtY@sgarzare-redhat>
References: <aipyNh_qseEUxj6Y@sgarzare-redhat>
 <20260611085603.626387-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260611085603.626387-1-rafdog35@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g7bWHhCSjQl1AxxSE5IE1E6hxewWTnylDu4dKQzku_Q_1781171024
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jun 11, 2026 at 08:56:03AM +0000, Raf Dickson wrote:
>On Thu, Jun 11, 2026 at 10:35:23AM +0200, Stefano Garzarella wrote:
>> Maybe we can keep these patches separated (which I like) if we
>> introduce the vsock_pending_to_accept() I suggested with an initial
>> patch of the series.
>
>Agreed. Will restructure as a v3 series:
>  1/3: introduce vsock_pending_to_accept() for vmci
>  2/3: fold sk_acceptq_added() into vsock_add_pending()
>  3/3: fold sk_acceptq_removed() into vsock_remove_pending()

IMO would be nice to have also a patch to fold sk_acceptq_added() in 
vsock_add_pending().

The rest LGTM.

Stefano

