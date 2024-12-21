Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44231AAA3D
	for <virtualization@lists.linux.dev>; Sat, 21 Dec 2024 04:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734757062; cv=none; b=jw+/ovdgW+oILOdAN4sePZl7d96ZM3tdPWW/sDn44Ss7EcKUDXeGQqzL70tLnGNcMsYau7QYD9GVI08yGy0oNXNtAbT6Hglh7YAeg6RF1nVC7D4fDmJrwz5Nyj6GChRvzsOcRCRyu8O0OlYXBWbnY822NDJoTFllgRIX5G7CD7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734757062; c=relaxed/simple;
	bh=1TbBP933VVm6DFt5zwnwojHrXlx9MRKIcAMq2Q24PRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jk3yvWep7aviH8RZncOgNWmPs6A9NdmjpTdmyVj8AUI8/OUq13lo5ZQvFh2vpqusSCdvL27y/9T2ddtky/b4jAUjJedp3pN/PQUGrYusZvt+B8h2Yzf1kaynMwDoPGHni5GgbNNy2E7utdkzVlUYlAEIQPWOsQRhRg3pnpDsf/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnRzczfI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnRzczfI"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2163dc5155fso23934045ad.0
        for <virtualization@lists.linux.dev>; Fri, 20 Dec 2024 20:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734757060; x=1735361860; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bqv1ZszYehiDYgEKLjMsBt3fQMyet+8+2qfk3kv/l5s=;
        b=JnRzczfIqdWvSyfcNowbn4D+HlSC0lvF695whDqRS/JVS53eXpJkVWEcwHHbz8+WP3
         EczrnYotbd6fD7wg9wq1tF6JGY9lRBCwj5QZyIthNCnY7ezCXNqWHKzK9Z63f5zZYGTt
         1/i2zaw7fm3TXfS5/x19659dfFnsoW/YkEm7JPsgUY/eXA9ELXasrDXhLUao+PXWm0Zz
         1bD9crNOvv2PpYCqGqAGQaGxvf3xw5tz+AzMURnu8Fi4ie6dbo+fpV23O6wbQjyGfbGG
         mobtiIWQQAsm6xNKYJILC7eduT3F6YjQv193bfFqOnkPEJP7W/Ed6rAA3cdwjjJj+n/A
         YuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734757060; x=1735361860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqv1ZszYehiDYgEKLjMsBt3fQMyet+8+2qfk3kv/l5s=;
        b=sxdc3eHLcRpeypYYss6DwS9e+iYQbevyCLOIWl2n1wrr+SwJu2msppXGWnNZBsTP1T
         VtoGbiDVO1eTz2GI/jraP0Yyae926ere+Uexx3Rf05R5UZvK56Gksexc6XZHncwpKrV9
         XpvtXcPvZTsp37+Zsmtt6znzMjk4Kyr6MXw+VpxJzqQBkDV5j99yC5MWZS8BvylKdyrx
         Sw5cPMO3ycj1LJvsoDD7ZAOHX6tPhVjWoYXwwUCWXKR5Ggc8ox99HW357T48kjjWXj0Z
         PMYI1u7kHzC0pLW3YOzrRS2oOUa/S/iKb8z6CRWBGmGiADP4tyP5/qLQo3obVaHLl6Bl
         aQPA==
X-Forwarded-Encrypted: i=1; AJvYcCXPAiIJddIyCNNnbReOTnduM5dA9dhvntN8W9HAxn5LLUeXSDLZPIePevZHVLeWgrB0ZSSuHM+/WoogKkimUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkNJB+rBz1MKo8AvBWqs0zW+j9NTwUN8DbxHRzFGZYL+eOqMN/
	LwOaVlqx9lEKzllrsFNcSXCXRzWwcE022VM/UVDNnLSY3AK9Mr0=
X-Gm-Gg: ASbGncvWKCi7j0Yot9Chuox0jszVGB8RXs/iOcxcuq1whR49TMH97eRldNQOvsTcmyU
	xutEEgoRDQ5xX6EVZFjduDow6IGdgX5h5uoFWaCtiiN9fMXA2cATbnaGc7z2Xu8+rDlCoKOdOkK
	xqFvFa+/MfD5DyYn2FHPGLE2Bwq+d2qQ/pZYis2QKO0xm/kT3uQXmx1iHVekMKjVnHVEwmhj4l0
	RxNS6h237Oad1nDqRW7rsgtQuZvskA7WIT1pjMyB6UOxZbtgy9JkbT1
X-Google-Smtp-Source: AGHT+IG6FSPopi6xlzdqkbYcTmn3BmRFpq5te9eTJ720B4DBzo4y3NotsWuyWaPDlRJsgb5CqmCuag==
X-Received: by 2002:a17:903:94d:b0:216:46f4:7e30 with SMTP id d9443c01a7336-219e6f11764mr84025545ad.43.1734757060132;
        Fri, 20 Dec 2024 20:57:40 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96e76fsm37133515ad.65.2024.12.20.20.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 20:57:39 -0800 (PST)
Date: Fri, 20 Dec 2024 20:57:39 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Kaiyuan Zhang <kaiyuanz@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joe Damato <jdamato@fastly.com>, dw@davidwei.uk
Subject: Re: [PATCH RFC net-next v1 2/5] selftests: ncdevmem: Implement
 devmem TCP TX
Message-ID: <Z2ZKw-k133QxigOx@mini-arch>
References: <20241221004236.2629280-1-almasrymina@google.com>
 <20241221004236.2629280-3-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241221004236.2629280-3-almasrymina@google.com>

On 12/21, Mina Almasry wrote:
> Add support for devmem TX in ncdevmem.
> 
> This is a combination of the ncdevmem from the devmem TCP series RFCv1
> which included the TX path, and work by Stan to include the netlink API
> and refactored on top of his generic memory_provider support.

Do you plan to include python part for the non-rfc series [1]? Or should
I follow up separately?

1: https://github.com/fomichev/linux/commit/df5ef094db57f6c49603e6be5730782e379dd237
