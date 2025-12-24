Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C5A2652B6
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766582308; cv=none; b=ucHh9LlPt34OSr42BDToY6PzEjYmueecySiqJrG3SQr2VAhdA4hhsKYjwjoNw2Ln9QLjvP4sPKPrEnYJgoRv3F0OvdpAhQicOG5wPTdD0o1Z0vOC+ue0badbUqyovVhp1aV/5waCkQ/vnvCcglubcBflcTFGwWPdiaP6/tu4ROs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766582308; c=relaxed/simple;
	bh=Z1vwCpy3xpWeWvKjBKC069x7b13vg9BDJ+FjLOjAjPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Gar6ANCOs8QmaDXZVljgdDlCFS5KQayiinhKIij6Qi2HTbEhzJmN4+fk1QWWt1m2xfeqkMP258qRmOwbXNK0Fso1kVmcsPVGTx6tiQoXD/a7tH14m3BrrZ5bM7FBzqT0kDIkuJ3DAoB+/2hbmC6UMbhsYhU7xjOR9mVSmBz8UsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gHk0gwKU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gHk0gwKU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766582303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pnyVa0gL9PqRyxoGgad9ZgIf7TrhLDmrnLDL5gmFISs=;
	b=gHk0gwKUC4+MKK9ny/Fz/hPjg9snSdywOoSsDIGKQyXJII8lFdp1Pm5vKCm5JOxRL4FMfL
	m+jjYe9CQZ9leLuBK3hrJdLLRieGMLAbRRHidw1ykJhoT0dxT3aSYEzTKuSKRUYpt4PcDA
	cyI8p5+yjjL5mQkbSi0lRL61dft7ofQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418--kSYwD-1MgCK4Q-Xpvqe6A-1; Wed, 24 Dec 2025 08:18:22 -0500
X-MC-Unique: -kSYwD-1MgCK4Q-Xpvqe6A-1
X-Mimecast-MFC-AGG-ID: -kSYwD-1MgCK4Q-Xpvqe6A_1766582301
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4776079ada3so55739355e9.1
        for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 05:18:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766582300; x=1767187100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnyVa0gL9PqRyxoGgad9ZgIf7TrhLDmrnLDL5gmFISs=;
        b=FzBIFhwKI0X847H8HtylnLlzqmUnxscJUam9aqwMEw/yah3LKJZtVvamjKBUA6iaHa
         FrE/uL90YXrfLTnsNin/0lvLNyVIEEZZf7seaYVChfi7xbjXXWxpivuZq6YpJa+eCYKD
         PyBc5tpmebE8i7+DtkXX1LphxNVv2FlQrSK2xQLSDjWfRiak3Vre1n8EtynLbqfFekQR
         aDt90ua09Ipy/P/glJHnD/leOEzdncTStnvRauEAm9KPkaLhECsvfC2uhOsMK5U3xtfi
         Ie83Z/I1vLsTV7zeHb75Ljl3dsoP6jIIbsCWzCKxZwtLcTR+2TS+N0CdwyRL6tKX9g9P
         7zwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmmve2Mz/Tgjrl3fJXJ1xlQJ4ny/5VtlAwAyeFj51KyhoHFPMCSzDK+Y+gc1S9iqYveGNg3cxMwHrnvWDkfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSoAc6FrgNJNqgcx/byy52Bb3S3T6aeLg2No9+SBoBBZu3xtys
	zIOwnibKRM8tAHRfbLV7CjIGwm+xgXPItymbRYcUl1O36x3/29k/E1lxB1JTj74PnkjBcT7DzyD
	KXFudo3FnbmRuWLhiAzq8VI3zLDO2YS2cu4VgxTjb/d555u+Z92YBLgBiRNJG0aq/Sr3uGsVedn
	Of
X-Gm-Gg: AY/fxX71Bi/r951nHUiHsftZ/1erXspwXAe04oRhMdqhZWkRDjn3zGIdUyucz4Qxjtw
	AOhYVIUtO+NaUXTo91RcWePFz7em8E2w5ZkgLYTrfGMjxTUqh9R3eSpBYKDTBiXiHd/TJzmYcli
	e2qww3tBGf/882YzW0nYBJ3wVULHtFkPqycbTEuS0NbUJA4MPS6gPXKIPgynljQkmGOz6tub+gJ
	guRTJOn/UNiZZ5am3woO65JCIbrm/MCn8BfSZ1gAHuZoB5j8EuESKkCzb8eB/2GiiffuBYitYkP
	t++EcsWzbNrG96sMTlA7m+O4km6r64j5YD806d9icEKHrmOLhH01TH3F6iLdQMXa/RzH94ZxBC0
	MejjWpgeNtpvtt9o=
X-Received: by 2002:a05:600c:1f84:b0:477:5c58:3d42 with SMTP id 5b1f17b1804b1-47d34de4cb7mr63019735e9.10.1766582300584;
        Wed, 24 Dec 2025 05:18:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/SlkuvhiTEvzYbTpBDDuJpHJEzzSjm3eiNJ/Fe6ZgvJBNGCeEN2QpRSXh5vQwgRwhpvCKLg==
X-Received: by 2002:a05:600c:1f84:b0:477:5c58:3d42 with SMTP id 5b1f17b1804b1-47d34de4cb7mr63019525e9.10.1766582300181;
        Wed, 24 Dec 2025 05:18:20 -0800 (PST)
Received: from leonardi-redhat ([176.206.16.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa64cesm34326729f8f.35.2025.12.24.05.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 05:18:19 -0800 (PST)
Date: Wed, 24 Dec 2025 14:18:17 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/test: add a final full barrier after run
 all tests
Message-ID: <aUvn7yVoSPG_FIiD@leonardi-redhat>
References: <20251223162210.43976-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251223162210.43976-1-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RePysVK63wX4Z66e2LZ9QKRyV_n5WPCHHWEu2Qz82Pw_1766582301
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Dec 23, 2025 at 05:22:10PM +0100, Stefano Garzarella wrote:
>From: Stefano Garzarella <sgarzare@redhat.com>
>
>If the last test fails, the other side still completes correctly,
>which could lead to false positives.
>
>Let's add a final barrier that ensures that the last test has finished
>correctly on both sides, but also that the two sides agree on the
>number of tests to be performed.
>
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> tools/testing/vsock/util.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index d843643ced6b..9430ef5b8bc3 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -511,6 +511,18 @@ void run_tests(const struct test_case *test_cases,
>
> 		printf("ok\n");
> 	}
>+
>+	printf("All tests have been executed. Waiting other peer...");
>+	fflush(stdout);
>+
>+	/*
>+	 * Final full barrier, to ensure that all tests have been run and
>+	 * that even the last one has been successful on both sides.
>+	 */
>+	control_writeln("COMPLETED");
>+	control_expectln("COMPLETED");
>+
>+	printf("ok\n");
> }
>
> void list_tests(const struct test_case *test_cases)
>-- 
>2.52.0
>

LGTM!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

