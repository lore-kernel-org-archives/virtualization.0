Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC16246BA4
	for <virtualization@lists.linux.dev>; Wed,  5 Nov 2025 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354103; cv=none; b=dU2pK52A6XgF6AEMK8PG3GOu2L4zjsOavstt6wvB+HBFb/wtVwujSBFBfhzZOZyDhhQhPCdbvtMXfO0DZNVS50Qh/vQNBUdZFO4+/3whKmPXQo/gdCaccU3jfph/6P9iOHXf1ogSg7/fwgNTY+kfq62AOCIrLswPefY2QtHxXkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354103; c=relaxed/simple;
	bh=vSOblu1TYmytU32Afj1JpSAwMW78+1eufiWSTZpAYPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GAwtlxneakdSmRAE8IQqj7hUyNTfCahOn6K5xA9OKHwAfNv4LE9PgHAbUT23aYi74KITIqV/Nppr1A1EGCFU7DY+5dStBP3uDvVp2HI3IPfu9acFc/b5yWV7KAK/eacKCjEgHac8tsQfijABTAPamIwWtI2hWdKo+d0ta5MaKLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FpJ60Q0R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FpJ60Q0R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762354100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CALwuHsQmFBRZ9UMoQkNa65lCmf3uyfowmB88gX3QjM=;
	b=FpJ60Q0RIPNVXpxnt7RX/LCqlLLf5JH1gXZHjEAtscw5qKxrDTjPzOJFaRhkuIfUDxmslp
	GbmI2Zl1S3qnbSEyy+UyQF8YyDqudXOP6atBPJwD52HMwZULQ/TTmGx6jZ1RL18hHicth0
	V2ppGWmUD7sSbNk9DD+DtGB/8DWdJUU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-G8fN2mSCNsm-Oja8O1WUrA-1; Wed, 05 Nov 2025 09:48:17 -0500
X-MC-Unique: G8fN2mSCNsm-Oja8O1WUrA-1
X-Mimecast-MFC-AGG-ID: G8fN2mSCNsm-Oja8O1WUrA_1762354097
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-426d4f59cbcso758656f8f.1
        for <virtualization@lists.linux.dev>; Wed, 05 Nov 2025 06:48:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762354096; x=1762958896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CALwuHsQmFBRZ9UMoQkNa65lCmf3uyfowmB88gX3QjM=;
        b=G7HjyYBzZyuICP16QbeHbotAf8i7P1oX41h9QAonbiGVgnAl3Fessmvq0JMJz9ZgZr
         ncdMQP3YgY+bERoKkJw3usu2iDsdS7OAUcH8K/pjEY+b22uZm9FPAP4gn0DfUnK5jY1h
         bYm+js1wH5TdpvF10cgBpGIMEK135/AxeM3lBqcWCH3Wp5KItoWP5NU6wSLPW22x/hKI
         9XRoHPmSkr9QO4ChrOHn4c+gcybdivZrmOtcz2xUuI8ERaCTmI06raffRTUZw9LMO4zX
         4P41nZQbfD9V8ZPHnxppXL+n6s8ZNPOF3WLdqQHNc90FW9rKGptQDMkDTDcPxQRJz6su
         /f1A==
X-Forwarded-Encrypted: i=1; AJvYcCVNIV0tsLHkxMkAgsyDVLD/e97NkslDg9BmrrjknOKuIQFRp8x+SBupEVymsntgKyrFQYQTzePibpvhlYZynA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPV+gb28obfXmp4EACF6CGxGWGAEKskI/yp7VxfGYq1itU7evE
	ietA4wgY4owIlzGXWdLnH5njPaYJJ8eUAWAlGuzCGczYxU0aG5gOzSypFqmFnhhOPrN8KQ+hQDm
	163ggSlc1MzHfyXE6WzSckqP1+9RwnIDHeF7rOda4WE+iykUbkxZ1KJpz2WQwp4Yc4U7m
X-Gm-Gg: ASbGnctqrgJOZ7gaOS6qUfEc00QWHkslrUXs0MmpFEpRH1JZIeUIiLCwpugclIYV2Wx
	mRM+m0oxW/VDiy3jZoEdHWzOb7ETa8E606tsLE4ISYFhiWUDWLoxrfSGKSq1k8EedVnORTIWzEO
	q9ZH867PuAtoMyqpG21UuNLXQxAfhNjlwFyOK6BnPoKz7YiZwU4XAyGln285r7NN5yNOhgvNcnF
	y9N2yKPPPAV1JIbDTGWcR8KBBlqpcOhyrfu58WdQ/2CU6D25hukViDoT3y/1HX0uQzqI2grm43k
	kkzFQI3j2nPIMsEIVc4mODIdz5ieHZ9rHymzLttYbLG7k2px82QbpFfRvKUdUmP6TW7tp/lIw/Q
	=
X-Received: by 2002:a05:6000:184e:b0:3ec:db87:ff53 with SMTP id ffacd0b85a97d-429e2d91fe1mr3951410f8f.12.1762354096637;
        Wed, 05 Nov 2025 06:48:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrOCNYKDLHdDqnsKK5PIOXbPko9O2ocFPx7Xxpk9jaY5/59QMJwT5e74pWkY0THQmdo2gCiQ==
X-Received: by 2002:a05:6000:184e:b0:3ec:db87:ff53 with SMTP id ffacd0b85a97d-429e2d91fe1mr3951385f8f.12.1762354096174;
        Wed, 05 Nov 2025 06:48:16 -0800 (PST)
Received: from sgarzare-redhat ([5.77.88.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc18efb3sm12092871f8f.3.2025.11.05.06.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:48:14 -0800 (PST)
Date: Wed, 5 Nov 2025 15:48:09 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 10/12] selftests/vsock: add 1.37 to tested
 virtme-ng versions
Message-ID: <csgl7tb7jxlmbkn5jqjoiraa4a5vatmd3t4fv4duue5ftukphy@tem4fwdinmti>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
 <20251104-vsock-selftests-fixes-and-improvements-v2-10-ca2070fd1601@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-10-ca2070fd1601@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Qnfh8coBXImi9rXbTkITBQct4w6ux94vFScCB19UF6E_1762354097
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Nov 04, 2025 at 02:39:00PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Testing with 1.37 shows all tests passing but emits the warning:
>
>warning: vng version 'virtme-ng 1.37' has not been tested and may not function properly.
>	The following versions have been tested: 1.33 1.36
>
>This patch adds 1.37 to the virtme-ng versions to get rid of the above
>warning.
>
>Reviewed-by: Simon Horman <horms@kernel.org>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

I'm just worried that the list will explode. Perhaps in the future we 
should just define the minimum version that we are sure we can support 
and the maximum that we have tested.

Stefano

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 3ba9a0dfdd01..0657973b5067 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -152,7 +152,7 @@ check_vng() {
> 	local version
> 	local ok
>
>-	tested_versions=("1.33" "1.36")
>+	tested_versions=("1.33" "1.36" "1.37")
> 	version="$(vng --version)"
>
> 	ok=0
>
>-- 
>2.47.3
>

