Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9221B224AF1
	for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767092931; cv=none; b=Li/4l+3RrD5/CA38wt3T1A5VXuO84mfdVj0usCPQFCtb2IMX97LuXVSUqikT0cRKZUHeqJ52TcUR1otyWuEqwbJX4j7ZvdiinmsZ9Dt++38DjYQCMMcMJnU0Rw30V01KCAA6gg90HdGdtj3FtRCwulzWrHjdcFMVF/JwcDu2/aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767092931; c=relaxed/simple;
	bh=7WV1PZwRg8d86JRoDSV9VFcy4y30d3R/nzioVeXQIYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srbyvhYtFmL+Gu8MyuNPUID3ectnxSmyhZlOApdBnEFNqFlm+5bNoDU92qMylU07BbULFvch9V7mkesTdOtveDioNwzgwmc5eHwW7w7fGM1KqIefzDjPSwSbYHENMRxuAyoK2bzqp3aqdTK8azhf9fY1+Fe8vvR3YZK3bTp/+fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WvYQO0Rn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvYQO0Rn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767092928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbpyEXxO7AQ8ncQp3gMzfo3NBZfU4UPQDsE56wXQgSw=;
	b=WvYQO0Rnwkse+xnNE+ITLZg+3WTMlTrJO4ES95wv4g+IDpzB2MGS/G/wDDXergpc4ZvO86
	HqvF/ZmCVqPOpdaWHf78jKemQzcrM81csFIlYb0+9cvxLRmMslJCEZlurzSeKk28uLBRmQ
	cV/pdrd7cp4ozJFHnkCUdHySUQ+SYVw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-cMeDVbpMNQOTzyWESiPhLw-1; Tue, 30 Dec 2025 06:08:47 -0500
X-MC-Unique: cMeDVbpMNQOTzyWESiPhLw-1
X-Mimecast-MFC-AGG-ID: cMeDVbpMNQOTzyWESiPhLw_1767092926
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4775d8428e8so82839305e9.0
        for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 03:08:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767092926; x=1767697726;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbpyEXxO7AQ8ncQp3gMzfo3NBZfU4UPQDsE56wXQgSw=;
        b=BvXBRmhV48qBqPrxuab/hXOgnMbE98be1plLR2MuZt/gDZkXEDZLcujRkzdpvFZIB9
         3VbaPV6Jw4hUJAnkeedB8nbl0tiOuohdUwfKr74uqQcRJu5bDCZyLo/62SzftvVykjwS
         BUL3cGJXHg9AjkzJej6hJK0+4J2g7BmFUqHkvya0Mouns//BEA/JqZzSQsK0vUCIRUBx
         4RIwuFcDBqgCLYXHqxbV3l0JNrCAoYGoojQyw+4pLHWVakfnOzfgVHNKYAOKJ6gIueUn
         /haL7uumwSBxJibCAD9S9Dd4uiD4VJMzFfHDAI/L93l74H5+5HX6fD1OCx0WLuBH3Aio
         h30g==
X-Gm-Message-State: AOJu0Ywv2+XhLzmwm159Cb25WerSl7vt2X84djOveeMlD7lG+8Ik/TAZ
	EuvAsgge/tBt/pYgtKrWSXBZ85hIeOG2Fsgl9R6R7EI2htTqwSIEO84NHwfHl9zc0MJNPIneOng
	Gs/gWQ6V8/2Mu7akTMBKC7f8EopySbG2PzFs1fhEwqtRkBQDFbCkGeXGIVxgMjGYG7leR
X-Gm-Gg: AY/fxX5PHQE2LXaGBFKocVENYQlCGfH6wkNsJBL0Jyzr6p+p6sQVjvgFcbtTyf7gyWj
	XLG9rLuonAnWNjhl7uEQT5g0cPKxpgiDXpGn5gzzFUJ+ogKTWmCxUmndenY/KkVbFFcYp+cAhA6
	WnAPES9+hWVdJiBsN8mJk9DGT0baJsk+RocYkCWF8pPdskUisH/zeNWNEuJy4hZVRJaiJUoZw5y
	hVyTXAW2yXL1w9SBLKyhsZXMfoEWoSevBcHkNRkv9ZspwJOYWWdASQj82cd3zA8Vr68w0mJwn/b
	C1Q1/GXa1rRdRK73LOlQ0N1ATSpeJkEHonZWJ8C6EKyRCUqnncq6kOAcgqYYsOTHG/eOGIh2vGs
	B2SFLEDEOwFOc
X-Received: by 2002:a05:6000:2503:b0:431:a33:d872 with SMTP id ffacd0b85a97d-4324e4c1219mr30137335f8f.8.1767092926068;
        Tue, 30 Dec 2025 03:08:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvPff9z6bqnDX5VSu+V0AnQlnkoT9d++5M0UZ40DRX8SqSuj0lySJzumC+58CSjPjJ0/D32g==
X-Received: by 2002:a05:6000:2503:b0:431:a33:d872 with SMTP id ffacd0b85a97d-4324e4c1219mr30137314f8f.8.1767092925654;
        Tue, 30 Dec 2025 03:08:45 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4327778e27bsm34741801f8f.12.2025.12.30.03.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 03:08:45 -0800 (PST)
Message-ID: <9bde9e8e-3ae2-4199-b416-ae3fdaf090f5@redhat.com>
Date: Tue, 30 Dec 2025 12:08:44 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] vsock/test: add a final full barrier after run
 all tests
To: Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251223162210.43976-1-sgarzare@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251223162210.43976-1-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4U3iVluFaTXzVpQvHt1fpHjCVl0RVDPQxGPvu-RFods_1767092926
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/23/25 5:22 PM, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> If the last test fails, the other side still completes correctly,
> which could lead to false positives.
> 
> Let's add a final barrier that ensures that the last test has finished
> correctly on both sides, but also that the two sides agree on the
> number of tests to be performed.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Net-next is currently closed; still this looks material suitable for
'net', with a proper Fixes tag.

Please repost for net if you agree.

Thanks,

Paolo

