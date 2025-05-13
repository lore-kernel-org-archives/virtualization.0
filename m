Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F70213259
	for <virtualization@lists.linux.dev>; Tue, 13 May 2025 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747132884; cv=none; b=ahrGCtpjPMki250UBIdcCPipWsz6HS87ZvIqUUY1CvvXpzieLuFYVAFDuJoWJ11tLLqwcWiOE00JsZ0CY6AWOXEaA9e3pBdKh9hAHvzvdfve1WuBAw1ZE6PwQ8+jSfoqBbeSUxQvlrX5oUs9s4wyp+VOADBqlFHUn3e/JIt8QlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747132884; c=relaxed/simple;
	bh=CzXbJtVm+kfPx2wU0kxbzltwOiI2Rq/axwGhJhgRpjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/sBHLtHf6Re+pmbfX6kODYMuTXNqqM+SEYhYqo7XpgqyYImHHWxR6p4KIPW3u3Hd/lzo9VC9IDyEXVn1PInIJ/o/vWtEXtAtZooYme0HTnoR7ETgGd8Q9f6vzBw1uNUQ9aQSxUGGw9LgT/NkAr+U/tgSga5ZIRwcPA6AgE4TAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PFgnNLWy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFgnNLWy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747132881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJeKw16z9gukuPHYO36IGk1ktHWHQEMVdMrmzMhOzO8=;
	b=PFgnNLWyssieO4x89SMSobbUJg7XI1qfODespef5o+BCa/1ivi1iRV6EZfoBn3Hfo8Tbji
	Lck6tGU1ZaGwyRNaPmQSBbbd21StQDcOaF529yyAiyvLev+Skw0P+LD545DJB3xTHl/MZf
	F2s1oFSyQ9a+PRDQdyByQBIWn00TzKg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-6fLzExGYOEexGefGSOTXOQ-1; Tue, 13 May 2025 06:41:20 -0400
X-MC-Unique: 6fLzExGYOEexGefGSOTXOQ-1
X-Mimecast-MFC-AGG-ID: 6fLzExGYOEexGefGSOTXOQ_1747132879
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-442cd12d151so37001685e9.1
        for <virtualization@lists.linux.dev>; Tue, 13 May 2025 03:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747132879; x=1747737679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJeKw16z9gukuPHYO36IGk1ktHWHQEMVdMrmzMhOzO8=;
        b=ofnXG96sJWKqWjdf0KcTEc0j1fiiRvxnyFEpFa85hLjcsHbBgiKDUtxx1UPnsqurBh
         lywO9UIFzYzYcDd6WZId6uIhbc+8Jrh1Sn7oQtVZ1o16N+DqRyNt7QG3PH2CJ/d/YVEo
         yygOQzM6KBvU7V7CZscSFsTZbrmJAxBCjf72jLiy5aAMYd0tuKiSyvyUDDIk5iexNlq7
         8jKIKPv3zLGcudbeTy/YV/ptk2Hc7wqfPLOhaPDSjFyScGJ2zJKrvGvJtkSM3htwpNLp
         nY/s/7f3NgJSftu1KqPfukxtUCLxNaf4ed8f5Fq/mHTziArkZlv6sRbB0J0+ZTbdgRqP
         UFUg==
X-Forwarded-Encrypted: i=1; AJvYcCX+VNFe3bGURX6IVPKC3RPxn5oVqTyNdF0HfvZAOwL/SPvwnMuig7WKFttIJNkbTzCnZBT6NjZEStID796grA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwS25RiflYwUwF5OSdiIDg8qQoiA6wEw9lnWL7HNm6SWSRROJIB
	0giIY7bnbnHYezUZUevJ/JEC8PHi0Z2mqlR+4Y+mLqF2fFE2bnaUHjOfzD2vCTk6NVWtcj80QdW
	xiVP3XcuCRc1EnCZj77qCBQc1XR5+/744NKZ5BxaRc8ZfcSk3HCfZ3Zse8JoqYo3c
X-Gm-Gg: ASbGncsTQqynMtTNF3uOHSifIWtvj1YjQWrrXi53ukfmVF4+bZuW9wZdB1iKF9n6z7M
	QhLPCbXdVw7Up/d5YKPwueC0XF/mcZ6ixmZJfgk7BElgwjitOj4yTJx8MlaIAhZHJlIOGlenYHP
	dOyMSqwvpoKAdVLPTgMqlZ94gWnVzH/1N18Ezj9bp+s4QohSE2q4U2mn9kOpgD4Ygr22hXWUhwO
	KE8I/ZGY+wkfSuxrdFfSZrQsAo4WnobbqYAZCHjBlfxVSGVsEKkgHh1GuQ/Wp1ASdoXLiLRkxsH
	oe4nTeEfxE5QTkmCNVQ=
X-Received: by 2002:a05:600c:46c3:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-442d6d0a9f6mr139315945e9.4.1747132879363;
        Tue, 13 May 2025 03:41:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl4gdyqUK+UhO8XqkYELW23efHSZ7ANt+SKdLL7x2md+luIlfmn/ndhYYAarVKcIiNK0vd+Q==
X-Received: by 2002:a05:600c:46c3:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-442d6d0a9f6mr139315655e9.4.1747132878948;
        Tue, 13 May 2025 03:41:18 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc59:6510::f39? ([2a0d:3341:cc59:6510::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecadfsm15609566f8f.22.2025.05.13.03.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 03:41:18 -0700 (PDT)
Message-ID: <8d1206d1-1b62-48a4-a304-23e13c1316a3@redhat.com>
Date: Tue, 13 May 2025 12:41:17 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] vsock/test: check also expected errno on
 sigpipe test
To: Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
References: <20250508142005.135857-1-sgarzare@redhat.com>
 <20250508142005.135857-3-sgarzare@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250508142005.135857-3-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xAJyieI80hzI0zJsScZauYdN0PuNI9nZa3GwnsOOnKU_1747132879
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/25 4:20 PM, Stefano Garzarella wrote:
> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> index 7de870dee1cf..533d9463a297 100644
> --- a/tools/testing/vsock/vsock_test.c
> +++ b/tools/testing/vsock/vsock_test.c
> @@ -1074,9 +1074,13 @@ static void test_stream_check_sigpipe(int fd)
>  	do {
>  		res = send(fd, "A", 1, 0);
>  		timeout_check("send");
> -	} while (res != -1);
> +	} while (res != -1 && errno == EINTR);

I'm low on coffee, but should the above condition be:

		res != -1 || errno == EINTR

instead?

Same thing below.

/P

