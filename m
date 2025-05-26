Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B271E104E
	for <virtualization@lists.linux.dev>; Mon, 26 May 2025 07:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748246054; cv=none; b=J1eU9R7syq93E5B23DOKYTn5RzSKc1NCu3nkb+Qb+ttIcmuLR1gNdP6Q4T//lAX81Z6c40HoqvYU2jz2b4/KRTw9/dfWDCfcC8ZAC98SU8dNLpZ5OjvuYvDX7i4ySY2liVqblUNVEpv8h2unwFrUaRJbPFHapnaUG/A/TOn6JaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748246054; c=relaxed/simple;
	bh=ICHW/uN1OvSvaGQ7jIZodYWZnLa0EL03cumMRfWphYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BrWrRKXNikylQbfem2jKBSIkHXF+vQ6Wr6RsCtvzxiBHIKqzKAj9R4GwtqCNALT6nMlj9BndxudZUWZIrNI9pCiGiLVBTjwbisFGgYLRk4tNGsSxc24pUGqHpWwUyAjWbKbOyaMdJDQ1lVQjzud5GFQT7i1JiBj6sO3DSwoO/nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EfQgBNOi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfQgBNOi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748246051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xr52sKmwroB97DOF/8SzXO2IZSVBxqAkPJsvVxhDFw0=;
	b=EfQgBNOiq4Kmm/NDtGYSmGHXwLr8Gmjwd/DYrIIJT/ovYa5pVbo25WpKrFKFg3ijclJcGb
	yrd8XKnqjr2XPMXM6ONSNfkVyqMmkydFfIxVtqRvUEsF2LzN/B3mRD39OL5e+EdFnddI8B
	p1I8raS9GoGjPdazshEZCABfRgFM75k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-kQllZ5ZgNdmBo7xjw_78rQ-1; Mon, 26 May 2025 03:54:09 -0400
X-MC-Unique: kQllZ5ZgNdmBo7xjw_78rQ-1
X-Mimecast-MFC-AGG-ID: kQllZ5ZgNdmBo7xjw_78rQ_1748246048
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ad55a32b7afso114117166b.3
        for <virtualization@lists.linux.dev>; Mon, 26 May 2025 00:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748246048; x=1748850848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xr52sKmwroB97DOF/8SzXO2IZSVBxqAkPJsvVxhDFw0=;
        b=iPyzpJd2i1cJfnc2W9tdKQao9euKfGwW9pf0HuQ58PnqLCFC+vPrnwV8ags9+xnHZp
         O8+gGTvWmW3b5IMXE9noNa6e+dD6Q7aMaTkt4YKOzen7R40QLquoVjg7Pbt5OY8juo0Z
         eNx9UGHbEpZX0hCkRDfUSpXAjcmJc6U5JnaMqLf6pJ2Cz30wrcmjAoyeqP1fVbSQLy2W
         bTeL0c7qNSW/U7owP0otxkyO2xPKn76zLWo5UCFXqT85poux5bNEewM51uIxqoHLDEdM
         3gHcs+zCsG/2I3cB+9b5t7dOAiZYn0BW1M7O88rBDGy5x6uJf7597+5TCxyG733X8oci
         3eIg==
X-Gm-Message-State: AOJu0YyV3CwEMs/MF0sFZqWyj7AUVdGa13rzBnGQv/VqJiv0rXfeo4nc
	D5Dz6jkowl3ABup+dyWcoSX4LSPqXHQguG9L5dW0q610Krb6icvV7rvkmP6vurdX4MiiwDf9PkS
	uU7LK4x1ALilagu2a8Nu8UHhzYu1T1a9KhTynkdruVe7kHGWMa1cVEfQaKjAXLs4DkWQe
X-Gm-Gg: ASbGncvAWCvab2L5o8qq2KaoG0YfiEowoerxEfpLLkkJRMusrbqwEmOM0g7QaWHL+cV
	Nx8wd6YF+qEfSJyU+s2a/mNEXIr3goNuKMYZjRoOwr9dxUnyecB3EBgJH1vRoCluTDZZH3tC6wL
	H9VcwAEEZkowmPkMCcNBZRWQMu/DyNwVRPsszm+wcnjQuYJD0fLislVSZ5SuCznjhIXUSLYg2rP
	hS6J/Wp1nTBGUPZ/s5NkGRjA/8XuPsgpcqr5cytLAVYoAfY+cD1uaguJkZquTq5/mtwqimk0kwg
	6mQKY/aGuph2PVw9W+io9yCzeC9VipGFTxFAfugIqTy3d6TvNHXj4d14O+BU
X-Received: by 2002:a17:906:dc89:b0:ad2:4e96:ee11 with SMTP id a640c23a62f3a-ad85b03b73dmr652294666b.8.1748246048093;
        Mon, 26 May 2025 00:54:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXDorcGibcC8mJCNU0lHQiUbuXJHSvC/4551ubBzHRPqBuymTAUbX8ir3OqGUx+Fn5tp1GUA==
X-Received: by 2002:a17:906:dc89:b0:ad2:4e96:ee11 with SMTP id a640c23a62f3a-ad85b03b73dmr652292866b.8.1748246047597;
        Mon, 26 May 2025 00:54:07 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4e8afdsm1652640066b.176.2025.05.26.00.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 00:54:07 -0700 (PDT)
Date: Mon, 26 May 2025 09:54:02 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH net] vsock/test: Fix occasional failure in SOCK_STREAM
 SHUT_RD test
Message-ID: <2y6v7vog4dylnnu7j625gkijth7lnznvgcjl4kg2q3xy5ht6fe@uikdt45mmocp>
References: <20250526043220.897565-1-kshk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250526043220.897565-1-kshk@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bbu7QqxDK9FPSUqxpLv2C7SK4bNpcsjEBTCExeuPxrs_1748246048
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sun, May 25, 2025 at 11:32:20PM -0500, Konstantin Shkolnyy wrote:
>The test outputs:
>"SOCK_STREAM SHUT_RD...expected send(2) failure, got 1".
>
>It tests that shutdown(fd, SHUT_RD) on one side causes send() to fail on
>the other side. However, sometimes there is a delay in delivery of the
>SHUT_RD command, send() succeeds and the test fails, even though the
>command is properly delivered and send() starts failing several
>milliseconds later.
>
>The delay occurs in the kernel because the used buffer notification
>callback virtio_vsock_rx_done(), called upon receipt of the SHUT_RD
>command, doesn't immediately disable send(). It delegates that to
>a kernel thread (via vsock->rx_work). Sometimes that thread is delayed
>more than the test expects.
>
>Change the test to keep calling send() until it fails or a timeout occurs.
>
>Fixes: b698bd97c5711 ("test/vsock: shutdowned socket test")
>Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>---
> tools/testing/vsock/vsock_test.c | 25 +++++++++++++------------
> 1 file changed, 13 insertions(+), 12 deletions(-)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 613551132a96..c3b90a94a281 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1058,17 +1058,22 @@ static void sigpipe(int signo)
> 	have_sigpipe = 1;
> }
>
>-static void test_stream_check_sigpipe(int fd)
>+static void test_for_send_failure(int fd, int send_flags)
> {
>-	ssize_t res;
>+	timeout_begin(TIMEOUT);
>+	while (true) {
>+		if (send(fd, "A", 1, send_flags) == -1)
>+			return;
>+		timeout_check("expected send(2) failure");
>+	}
>+	timeout_end();
>+}

I'd move this in util.c like we did in 
https://lore.kernel.org/virtualization/20250522-vsock-linger-v6-3-2ad00b0e447e@rbox.co/

And I'd rename following the other functions we have there.

Thanks,
Stefano

>
>+static void test_stream_check_sigpipe(int fd)
>+{
> 	have_sigpipe = 0;
>
>-	res = send(fd, "A", 1, 0);
>-	if (res != -1) {
>-		fprintf(stderr, "expected send(2) failure, got %zi\n", res);
>-		exit(EXIT_FAILURE);
>-	}
>+	test_for_send_failure(fd, 0);
>
> 	if (!have_sigpipe) {
> 		fprintf(stderr, "SIGPIPE expected\n");
>@@ -1077,11 +1082,7 @@ static void test_stream_check_sigpipe(int fd)
>
> 	have_sigpipe = 0;
>
>-	res = send(fd, "A", 1, MSG_NOSIGNAL);
>-	if (res != -1) {
>-		fprintf(stderr, "expected send(2) failure, got %zi\n", res);
>-		exit(EXIT_FAILURE);
>-	}
>+	test_for_send_failure(fd, MSG_NOSIGNAL);
>
> 	if (have_sigpipe) {
> 		fprintf(stderr, "SIGPIPE not expected\n");
>-- 
>2.34.1
>

