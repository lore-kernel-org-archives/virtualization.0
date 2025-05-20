Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65B72701DF
	for <virtualization@lists.linux.dev>; Tue, 20 May 2025 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747740290; cv=none; b=ZYiY1wLQJlV4XNl+Akw8yFBV5o1AaStPizof0tN87MaxizqbsGfjGHCAEcUG0xLeds1/CRj28wtg+nJDA2ztMfXIZ7sEsqScYm7qzCDYxDSKRl84GhnJ2hOMylzx5uv80yDZStoGjDtT6CHFF+jx9yLJ1YNIkOmJxWZZjd2NI9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747740290; c=relaxed/simple;
	bh=TuAIH9bfwGkhs90AUwbat8H9o+RJq1imxYa/lL35UsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cfEYYPeA0mtbdJGn1k3PJj98F0FONvJ/GzPzZjxzDyaUv7/z6JBYWvafmfGoJnqpnayC2ZimF65e2u1L4sXkYkzRLsd4cTbgth5Hucx9erefo5UmDfZqWZ39J5Q+vL5VcKdImdC0tQv44phMvMsQR3qh5jCvGwC/JMQuqGfZ3Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=So5Z+G/k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="So5Z+G/k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747740287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fe9XgeFRrKR14t48Y5t/+VDl1Nkl0xKTWni0QoyTko0=;
	b=So5Z+G/kboV42mNWEuw9o90/UDzI7cL2WjNHNVqWUu5oh+SEdO+7wF6rBZtVHFgvORy+ON
	qZF1LQVU/1dt4O+I2XCYZLOzdnyij8l0CeFR0MOXAX4ETYm5pidLXqVDiiXjiGqawCSdq/
	zAGBW/E5H7vSVpeEF0zAdAKG7gq1un0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-Nu09yHFaO_at-VV_AnANKA-1; Tue, 20 May 2025 07:24:46 -0400
X-MC-Unique: Nu09yHFaO_at-VV_AnANKA-1
X-Mimecast-MFC-AGG-ID: Nu09yHFaO_at-VV_AnANKA_1747740285
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a364394fa8so1702405f8f.0
        for <virtualization@lists.linux.dev>; Tue, 20 May 2025 04:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747740285; x=1748345085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fe9XgeFRrKR14t48Y5t/+VDl1Nkl0xKTWni0QoyTko0=;
        b=ktldbRbD9S1qvs0RL56qlcHWm/lAqBpJUQrvA+1i1tXAzM/R8JiAukANnR18fhG4W3
         ZsM626Cpy1mYJhX5BbA3qEM/hAEHOpOl3jxWvDXzlJ37jtNG62QhWayhizBZZ8CGbo7N
         65Yfku9n4nW0XGVkyHLaoU5wApLRc8+bbfXoNWvB8U4rD8TrnIKku/HorvSvsaQJXMJ9
         bZJX7/NI31385+s6jAZ0p/GS6sC+1UpaJbPAiDHRNeK7LAaGcDNoId5eqytVZvinTysJ
         tbTzZIqPETC/1Z2kqvaGBZDmRY+Dj/GiRlMy9FJLYI8fF1txBR9xhgY+L+doLoA98WFX
         o/Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVJE4vn1+K8vGwknrEMk1zbGWCHGe2JerhMrdFb4//tks4CY6I3hxEAF4giiRba7Mn/id4mWu5h7+bG5Xqbww==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyn+IAcVYZoDft5BA1e5Tfbnpm7LS+R/DAvxRDALuwmn1Sg+uw7
	d7g3T5zrQNpw6vgVEltF40t/5R08+jN6CIalK5uYJLvNczQOKUMsLhhq4hswXFxWLQwZK2lkliH
	9c+rY3ThgHB3U246/JiX9fbaXCwXUkqqrLiEzwTAz4AWq2+WjrU+FMIAe1yt8RYf/1u/+
X-Gm-Gg: ASbGncugaFbNYWvG8QSpsznGkVPgHe6f6CM6lh4uRF3vGV9U3wGvNjAZhwVW+LQ08k9
	WNrRYhhuOo7PoVTAN87ejaZL8ycQu82QNQ2tyzJVvuyLmhYbAzfRWMY0+hvWhDKzmaZsLOQK4lN
	6lYBSC7zTxPwgrn9FjSJ3QCDhvzBv9XRwTJpCLc3rS1Xu73gmUR1MMqpoA0LzFIsG0GQJ7s70Lx
	YIqSNtlgqaNIbm5Vg3F+NWBcePFYlTuURHQgo4iABXoX5D431bJNNoglkhi4rrfj97f+TGI/zoD
	vRXw5I22WVFNcBfkNbg=
X-Received: by 2002:a05:6000:2304:b0:3a0:b521:9525 with SMTP id ffacd0b85a97d-3a35fe65fb8mr12718953f8f.1.1747740285495;
        Tue, 20 May 2025 04:24:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEofFs1HXEriOPCetmLcj952oc2+OEDOvFvT2d4euNrXMvEB2EHBEoF9oG/uDbOigZv9W8Xdg==
X-Received: by 2002:a05:6000:2304:b0:3a0:b521:9525 with SMTP id ffacd0b85a97d-3a35fe65fb8mr12718940f8f.1.1747740285150;
        Tue, 20 May 2025 04:24:45 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710::f39? ([2a0d:3344:244f:5710::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca6254bsm16428674f8f.52.2025.05.20.04.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 04:24:44 -0700 (PDT)
Message-ID: <0d3a3a42-4141-4c4d-b25a-3c9181d5842e@redhat.com>
Date: Tue, 20 May 2025 13:24:43 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7] selftests/vsock: add initial vmtest.sh for
 vsock
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250515-vsock-vmtest-v7-1-ba6fa86d6c2c@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250515-vsock-vmtest-v7-1-ba6fa86d6c2c@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WVqVo5CJ8vYkMxhR0D9YlV5NIqLz_A4Xy5ZBovqtWXQ_1747740285
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/16/25 12:00 AM, Bobby Eshleman wrote:
> +tap_prefix() {
> +	sed -e "s/^/${TAP_PREFIX}/"
> +}

I think there is no need to the tap prefix to the output you intend to
'comment out', the kselftest infra should already add the tap prefix
mark to each line generated by the test,

> +
> +tap_output() {
> +	if [[ ! -z "$TAP_PREFIX" ]]; then

AFAICS TAP_PREFIX is a not empty string constant, so this function is
always a no op. If so it should be dropped.

Otherwise LGTM, thanks,

Paolo

