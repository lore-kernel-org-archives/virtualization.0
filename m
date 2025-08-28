Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6693C1373
	for <virtualization@lists.linux.dev>; Thu, 28 Aug 2025 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756372250; cv=none; b=qqLm8ymkL6u6Y2EJ3C1cNWheNaoYTnmOYhPPwqZygfWJBbnl81LxvkdUJ5TuupM4Of3kAldKmPSsKcBAnvpLXpouaNZeMSPPaEz6Xn/2Uvb5SVuwKF8DEmtpm+frEFI+E6AriOBdIPztX42dwH2Z7cd1enYdXvmUKIWXIR3xQmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756372250; c=relaxed/simple;
	bh=w6SANh9M41Cz/FJdilTI2rNWrEJavLzRaQZtNc9gy9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mSqy17RPLuaDzw2rADkABjVepFdAxUtEwCWF0dPNNxUisgDi15GHK+bdSjFYyydkRmyEuIwW96h933FOgUehZBlcYDqOBgdHlNQ4DFqzgNkGldAp2a6qYFMqWwctAgf/cmcCucu0stwoC+dqQrgATqkIxlSPdTzHZIr/cvIXOMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HOp7+ne1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOp7+ne1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756372248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nKlwPKezbuO9xwAGZFmpWVmFnAyIOSinJ2mEOrJ9HXU=;
	b=HOp7+ne1UuIug9gUp5+AqQKsKNuNSs56RQV8FdlPUKgG9JfT9Hj37dMWDe+Nwszs913UZu
	48v8XxjzHZzsh2RcKivOqIzvbE5XzGAbAUDJ/7gt1agJO+RcprV8tK+pJGCMGYVgBVAG9W
	dZ2H3SygqSeO0T6QA/SSyUjSNicF6EI=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-Fx9EnSI_NdmeT1qEPWTxxA-1; Thu, 28 Aug 2025 05:10:46 -0400
X-MC-Unique: Fx9EnSI_NdmeT1qEPWTxxA-1
X-Mimecast-MFC-AGG-ID: Fx9EnSI_NdmeT1qEPWTxxA_1756372246
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7200a6aa975so10872987b3.2
        for <virtualization@lists.linux.dev>; Thu, 28 Aug 2025 02:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756372246; x=1756977046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKlwPKezbuO9xwAGZFmpWVmFnAyIOSinJ2mEOrJ9HXU=;
        b=oo/BK5+CZpv1CU8SaJ0/EbGpJdVaBaBXQ+nNMxHleRbiLJcz3j9I2NfdmYef+FB7n/
         3zx6RAF6sdazmyrlJd2ocVvqGSx1Miq5kr1VfABVoIgSHuxLdyTrTQzEZ5vZn2fHQHcV
         LDH8I0jyKpnLN2K16eIJxQuHGqbWLRq3pJql+3nN/6tSxWYzJgSmjPotNLnymHOWyQrF
         33uQp/45H42mgLStAwTEsk66mmDD/l6z4PjNaoYr7bBqOJ26NfAN6vajsyZUIKDHg3/X
         ECtMJPWwQR3IZBDFF0HL7biW2cYDFjBZvtPezvxzOpSa1DjnUQHhaLXrcQM8xy1v5khk
         rlug==
X-Gm-Message-State: AOJu0YyAvhtzr7Wc+LGRP2ExH2ckyEf/jcANLWmTpPi3eREM2JjwvjO5
	eLPR5t18l99IzE28ikCzb9hv8hDNiyyKVtXCT3lVGqOSXt27oLzHd+Xl5bUr8Amy5p8jeqUqrZI
	j9GeMq9S5ixiMml++U4H4Ti9QiVn816Na4DOw/Ub292VAqaP50pVYa7tagEINcX4Q6K/5
X-Gm-Gg: ASbGnculAIrQLw1aYDxIltRLRMEyWMJqVIAZ5HDqUlqZYkC6EwfX/HUomDwQ4BdMa+9
	J+6PxCJ0SMYGqyacZ9i6yhzxPHy61q02DzSl9WYnpgroJ0u1GSv+hRq6gtzEOevJuDy1bNcwPS4
	aK99XStGkLBIiJ2iTON2MoYAjJU/NIgeT4N8M9TpUNQDw2KtuZWQwjkQRFofLNxdZ2c11ZsCc9I
	t2COw5Su/l0n9k50Kul/8DKdNqI88AdKZHwmTjcitgTNy5cwzOXcXgwxVe9XLi/NRVGdtAM+WTG
	uSBwf348s9IP4WBlL8W0nTirVZfPtXPKAywsb0Nsm/+IncT81SoGgqePdr2HS3iI55X+PNkb+N9
	FWASBVcqLsV1H8jo=
X-Received: by 2002:a05:690c:ec8:b0:71e:7ee9:839a with SMTP id 00721157ae682-71fdc2f17e3mr254131087b3.2.1756372246202;
        Thu, 28 Aug 2025 02:10:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6sWncGKqn1v4/1RP9QN/2CTRKrNYh1qBsv09tOJjEFxNBC/SRSbycXZhflbiMWoycIj9R3Q==
X-Received: by 2002:a05:690c:ec8:b0:71e:7ee9:839a with SMTP id 00721157ae682-71fdc2f17e3mr254130717b3.2.1756372245672;
        Thu, 28 Aug 2025 02:10:45 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it. [79.45.205.118])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-721583892efsm5988377b3.2.2025.08.28.02.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 02:10:45 -0700 (PDT)
Date: Thu, 28 Aug 2025 11:10:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: "open list:VM SOCKETS (AF_VSOCK)" <virtualization@lists.linux.dev>, 
	"open list:VM SOCKETS (AF_VSOCK)" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] vsock/test: Remove redundant semicolons
Message-ID: <rz5brbahjthbpdl7k4g47zugrofw3wj4fijl5aejwteumtsjiu@3nl2sfyvbp24>
References: <20250828083938.400872-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250828083938.400872-1-liaoyuanhong@vivo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ER0YxQghb1ax0wutTAk4BtcpPNK7ZI-DL6fc_MBjraI_1756372246
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Aug 28, 2025 at 04:39:38PM +0800, Liao Yuanhong wrote:
>Remove unnecessary semicolons.
>
>Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
>---
>Changes in v2:
>	- Remove fixes tag.
>---
> tools/testing/vsock/util.c | 1 -
> 1 file changed, 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 7b861a8e997a..d843643ced6b 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -756,7 +756,6 @@ void setsockopt_ull_check(int fd, int level, int optname,
> fail:
> 	fprintf(stderr, "%s  val %llu\n", errmsg, val);
> 	exit(EXIT_FAILURE);
>-;
> }
>
> /* Set "int" socket option and check that it's indeed set */
>-- 
>2.34.1
>

