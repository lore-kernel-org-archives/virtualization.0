Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF023248F48
	for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763984520; cv=none; b=Z/qjm/BYenjv0lq1T0ZQ1qUWCUWEsPtdk2XRk+kzVZ7qe6WauE/dqNvsN+W0q2BGPtMyy0uebW0APhgmar6YbBurwZneKmqGEg7fbBuvorn2tzqlpEWAODtnE03lvH8PMHRjLbGmrDcsdXuaa+BTPhlc2YEeETnoV22rPPbiswE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763984520; c=relaxed/simple;
	bh=uRfp2lW2gNOwFoOfgY6ePrvjcAHpd92TJ4csW5PyI+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XnSfIHtRSz2mqPwRHUsrLPjAwhjzWO9zYGunvYJjKV/N261d1A6deWsMek1geMIykcUcb0nCp+zEPyWITfO6HJS458z/7Od0pGJMTcFtwu6pGvrbXRiz8xVeAVJPHw/mSyjFMe2wT4J5M2+u2Gdd+Uc+bXeBkrGhREj4xcCx4Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gNi5xsmY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNi5xsmY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763984516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=59ffXYnHIKK4VAVsmKOed/k3AlpgsniAKYK68betyEk=;
	b=gNi5xsmYeG43L1OI5yTeNrF9Foi8P6pSPJx4pOSvYWT0RmNPO85ehTtAFIzsBGISOxkjmh
	zFuehaT1LYFWR/OLjUp/Y+A04Oy3S2QQcjA/p+hX9crWSLkHsJuXr/RT7KVGRJWLEoW+nu
	B9pcitnYhtchGmVGbXocUDaVIIFYNM8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-D7pEnTIbNTO0kQR8XDzf0Q-1; Mon, 24 Nov 2025 06:41:55 -0500
X-MC-Unique: D7pEnTIbNTO0kQR8XDzf0Q-1
X-Mimecast-MFC-AGG-ID: D7pEnTIbNTO0kQR8XDzf0Q_1763984514
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477939321e6so24518545e9.0
        for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 03:41:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763984514; x=1764589314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59ffXYnHIKK4VAVsmKOed/k3AlpgsniAKYK68betyEk=;
        b=LAM6Cmg/MdT5/9swQ/sM3G/YWsN13ObNjzAtiXUAJkEEXi4tOJlt8604Bzpnpb6HeQ
         dhL0gkFFdyZiaKs0zJAMuKP20nERFK/nJb5Hf4D8ei0uPUquP69YQzOfFYbIGX5mlTVP
         azP1TqbizedDRu6Oq9newWGtbWE5PLkkR16q2KQtkxsc09dLNslW5WlHNlX72iqvYSa4
         8s/XUHQlVvAa2CQHEnUYsIsW0vj8klrCoqpyEkwGZ0yN2sG0vCwHABvy7Iuql7JvommV
         nakhrVks5Cyq+XsC94s9AE2A9N8nzFL6wUUSp/niU4JttZpUjA1L3vCDj7GZIINOvkwG
         ODcQ==
X-Gm-Message-State: AOJu0YyuJ9YzRfOatp3ag59/PGYT/b1Mkd3tCFdM1V7AV+5hjNQJzF8p
	aZJ4BbN7gkk2+EvVfLExqqowaO0MacKUuUtRBH7LWamNvZQ8T6RhGPrIIC2Zdef93jrYtIpJzqz
	nOaW/+aArgB8FFQ3dPkRYY2LEKoHJGDeN6mjy2xD2JyqMicNWhgsi6MPEkI9A457mGXg6
X-Gm-Gg: ASbGncv4hs4Icix8/JgX106Enlr2KzDa5Gn1BqphI2u81XB4NddXa8CY+BcmkrwwxQG
	OcKcBTY3xIteiB+ekG0tR9BjREGEN5M6i776V6zZQgVqoRsOTdRSxrXozHa+wljNjWY40hQplap
	gQx94vnZFmu6rSt6ip1vlRGZqxhhVr6DBp2O7s4rA5TJQYaIwABxiXOLiy1IDndaJQTG6IFdhes
	yhaQyqw73r4zFj6mC9M2Y4RRdUMuFEWTb312oORDkd8LwDcOp5PwVzGG7CQylBh+Ik7TV9DtA+9
	lAi4ntMdHLS9uypq90iQ6EdWyaajE8LGoMKpu74g9aqG0vmgkZGOJs8fnBBnLTKg3RHqmqAK3Ct
	DoYVaT8VzsEdsxZS0hH6zYrRJnNltbimeTPDrxn/pIjMmnYHoLgrhdmt6TfG0dQ==
X-Received: by 2002:a05:600c:470e:b0:477:79f8:da9d with SMTP id 5b1f17b1804b1-477c01e9dbemr135366985e9.24.1763984513948;
        Mon, 24 Nov 2025 03:41:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHv4eKEkWdkYcAT5ZU1Xz7TGXfRh0Hl/AgIDLxFq57bGT0pkgRagAd1ruOd0IJFZ3Ag0iuVxQ==
X-Received: by 2002:a05:600c:470e:b0:477:79f8:da9d with SMTP id 5b1f17b1804b1-477c01e9dbemr135366655e9.24.1763984513501;
        Mon, 24 Nov 2025 03:41:53 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dcbca9sm148486715e9.6.2025.11.24.03.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 03:41:52 -0800 (PST)
Date: Mon, 24 Nov 2025 12:41:50 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/test: Extend transport change
 null-ptr-deref test
Message-ID: <ndtaldhrxi7vkqw3vidy7yzs3e3td2jf5q7uystv5ctjbcaw2i@lcutm3s5qsfk>
References: <20251123-vsock_test-linger-lockdep-warn-v1-1-4b1edf9d8cdc@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251123-vsock_test-linger-lockdep-warn-v1-1-4b1edf9d8cdc@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: x48qwSpyf9sOHd4bnNYZapaCv9ewdD17kW37UiAI72o_1763984514
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sun, Nov 23, 2025 at 10:43:59PM +0100, Michal Luczaj wrote:
>syzkaller reported a lockdep lock order inversion warning[1] due to
>commit 687aa0c5581b ("vsock: Fix transport_* TOCTOU"). This was fixed in
>commit f7c877e75352 ("vsock: fix lock inversion in
>vsock_assign_transport()").
>
>Redo syzkaller's repro by piggybacking on a somewhat related test
>implemented in commit 3a764d93385c ("vsock/test: Add test for null ptr
>deref when transport changes").
>
>[1]: https://lore.kernel.org/netdev/68f6cdb0.a70a0220.205af.0039.GAE@google.com/
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index d4517386e551..9e1250790f33 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -2015,6 +2015,11 @@ static void test_stream_transport_change_client(const struct test_opts *opts)
> 			exit(EXIT_FAILURE);
> 		}
>
>+		/* Although setting SO_LINGER does not affect the original test
>+		 * for null-ptr-deref, it may trigger a lockdep warning.
>+		 */
>+		enable_so_linger(s, 1);
>+
> 		ret = connect(s, (struct sockaddr *)&sa, sizeof(sa));
> 		/* The connect can fail due to signals coming from the thread,
> 		 * or because the receiver connection queue is full.
>@@ -2352,7 +2357,7 @@ static struct test_case test_cases[] = {
> 		.run_server = test_stream_nolinger_server,
> 	},
> 	{
>-		.name = "SOCK_STREAM transport change null-ptr-deref",
>+		.name = "SOCK_STREAM transport change null-ptr-deref, lockdep warn",
> 		.run_client = test_stream_transport_change_client,
> 		.run_server = test_stream_transport_change_server,
> 	},
>
>---
>base-commit: 73138ebe792b9af2954292cc5cfa780a5e796d97
>change-id: 20251121-vsock_test-linger-lockdep-warn-e4c5b8dea5e0
>
>Best regards,
>-- 
>Michal Luczaj <mhal@rbox.co>
>

