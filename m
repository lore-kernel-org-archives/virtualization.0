Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6749A23ABAF
	for <virtualization@lists.linux.dev>; Thu, 14 Aug 2025 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186036; cv=none; b=DkEooaIsrKKwrOWVh4trPyL+0SXR3BVSS6l/ZVdlMhaxA7jn4LeF2Z6TSmRdzxBFgzOj2V+D1RyJY5ohDokKgKVcoanTzeT8ipHqVWvNXloF1uOLYpI6/d5aiBKUOTID0dustPWK5bAcg8oIAzG4JrEBO5Oo21h7ve4ecqhcaGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186036; c=relaxed/simple;
	bh=yaSYWXyGxJ/9XhopS6Hw1gTGGNBA7I4gi0bSsDYE9rU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qW81Lgwa+hOzT0rYbjgDqv5ao9RMwkJfWni9tK45SXk7VS0j0Jy0UjxPe9HpKdfeTUSh3SxVQcRuu9cIbyEb7s4Z5Gq8erdOlK8rvjOcZ4IpDktEzazRdU+77To09Iy1i5LgUcmAcOhO9ercpamJFTJuQTv1iZ/CR0EtKCmy/+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S8ceUGX5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8ceUGX5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755186033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yaSYWXyGxJ/9XhopS6Hw1gTGGNBA7I4gi0bSsDYE9rU=;
	b=S8ceUGX562nUVVE0UXPXNip6CLFVw+GjnzJv4WHPqmz95rheZbuCdD7fIGebn6LdAwmGxv
	JGXxGyAGsiMdLZntH1q+cnU7qeT8VskQtrPxRMHXEcEbCDXmd5cTgjmQJo2Pkag6+bbruN
	TBDXq5MFw9jYYxmIONlJQHVwGeCe/JE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-KH-byDijPLigDVjFUhw7aA-1; Thu, 14 Aug 2025 11:40:31 -0400
X-MC-Unique: KH-byDijPLigDVjFUhw7aA-1
X-Mimecast-MFC-AGG-ID: KH-byDijPLigDVjFUhw7aA_1755186031
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0b14daso3488295e9.2
        for <virtualization@lists.linux.dev>; Thu, 14 Aug 2025 08:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755186030; x=1755790830;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yaSYWXyGxJ/9XhopS6Hw1gTGGNBA7I4gi0bSsDYE9rU=;
        b=lz8cbK+Cmo120Xzy7ufXt0QYK/khiQBIYXJUKU5ZhwkMLC/jEqaUmeSpCgc7A/AYXJ
         bmU9NaVUvjcM83ab31v4wkcSPEs12kr9zuN62z3Km3A4EIpKGzq5hfKhdiw2pElA5ckL
         KLead0oZUn4GMpV1KV/NuZmt8wCDufNcZAWlELVMF13Rze74j3Am77o8TIlicb/LHMK8
         CDIGBJ5HrpW53el2DY8OJo9MvJw4MYTUvJgEI5pKC1HYvs93oHm5cOfvZQ3WisJMQ8Ej
         +VFDpvzaNeAIZQg3yqVU/rDOg0sErlkMoey4h4L6QE2CEiNE6H/fh+qFZhxVq8TePZI4
         aB5A==
X-Gm-Message-State: AOJu0YyDWJyNaWKFmrpNT7Y6D81TrNGI+ST6g5VL8XPfFNvbkqd+iyB7
	2hdYqgan81Nj6TUAIJmhN5W9k5/w09g0qF7KGZFpUW+OS+4XGJxAGeTl5UHIfQZdHb8h3+/Ok3p
	cigN7of89RGXqGO5GDxDKaqtTSQp01/fmgmds86D7OiGMdRTA6+6nqPUZpm1LwYTk6M7LSnV2Ia
	8q
X-Gm-Gg: ASbGncur5wOlSWHyeX00LmHAdKsN4bIsepHnqjeu+VTidTMPHmgERpY3CkvBbiK3lEZ
	VIcXhXtHB8mFtdoS9ZayYnqP21+UkiRUyk2hoF1qwMXlpFmkUJe04O5pMjKj2xtoSXqATXKhTlE
	7+ahKEifgZAodYi297/t56dkSGu0TCL+PFhY/VNvs3ZpQGUh4F2moay5HouPmib7icyRtPk/his
	8fUOAr5HiIGijAaQW06TiB8JQ+Vn6iHFht+12x2y23mKObYLqrjEEfD+AF2bbfEJxWp/fsbhRr0
	auA+fgEkPWWGfvdSL8HD7LvW5h6BJ0PqIpVG5saN6xTXpLkM0qMG/pBMD+t7JVl5O39E4vKt4CS
	GM+yp5WWTKSQ=
X-Received: by 2002:a05:600c:1390:b0:459:dba8:bb7b with SMTP id 5b1f17b1804b1-45a1b60f926mr33912805e9.13.1755186030033;
        Thu, 14 Aug 2025 08:40:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO8j0bl06t8kLqVusdd2gtWRvt7hDatkEzclPmxcaIlT06nd+NntfwSiemJ8UjNqI6qlg2+Q==
X-Received: by 2002:a05:600c:1390:b0:459:dba8:bb7b with SMTP id 5b1f17b1804b1-45a1b60f926mr33912485e9.13.1755186029551;
        Thu, 14 Aug 2025 08:40:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1fe2c019sm5608825e9.17.2025.08.14.08.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 08:40:28 -0700 (PDT)
Message-ID: <c25f924f-a66b-47cc-819d-5ed241a4bac6@redhat.com>
Date: Thu, 14 Aug 2025 17:40:27 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Virtio networking issues on v6.17-rc1
From: Paolo Abeni <pabeni@redhat.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
References: <aJycJvs3xztfD5Rm@pluto> <aJzU1JsV5we-QqgQ@pluto>
 <aa46dd09-a450-4633-a647-b04781599c87@redhat.com> <aJz1_HzPsEyvY6HN@pluto>
 <146fd5f7-c694-4606-afa5-522c5c05d9ff@redhat.com>
In-Reply-To: <146fd5f7-c694-4606-afa5-522c5c05d9ff@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pOAElw7lCgyD3nQip6g78DV9RcxzsPCX2WE1-7upX3g_1755186031
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/25 10:41 PM, Paolo Abeni wrote:
> Thanks for the detailed reproduction steps.

They definitely helped to reproduce the issue here. It took a little
time because I'm a complete noob WRT kvmtool.

Apparently it was indeed a kvmtool issue.

I just posted a patch that addresses the issue for me:

https://lore.kernel.org/kvm/ed62443b8fd3fef87bd313a54f821cf363f647a5.1755185758.git.pabeni@redhat.com/T/#u

Cheers,

Paolo

