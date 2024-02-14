Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669CF1DDC1
	for <virtualization@lists.linux.dev>; Wed, 14 Feb 2024 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950768; cv=none; b=MP5moL4NlPniu7CVGQqo09JaJa1mH+pdL0ZtoCtqXqLZWlxR+i5CIrFrzWPSWuwox2KHLkNxWKBAIEnIxmMxhJg9RBF/4v90QhXtXjmThRnUi/d8yJZ3uWI89qF6MIwnXQ+bD61koSKhjJBGkgAcM4XEKBVHCujCy+awwlayDdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950768; c=relaxed/simple;
	bh=8bT3amGiS3fLKoyxXO7JZcJjrrEaDQwfviHZsFxAkb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSRfmShiAjLSWWJQQyJ5s6/xAYRy4mn9A+dmWqZyBmIrWa/NccalLEwvnddPjraTQp26J6f163thSVOfyo0AyUrPcfK1o/JZJsReALUUfxZFGD2wjDnse9ZsATVUJzZ225YQteGVgg/YhvpcdbDUenEwQl+45mIdmcVIyhNtIEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dbjJFQwr; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dbjJFQwr"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso226174a12.3
        for <virtualization@lists.linux.dev>; Wed, 14 Feb 2024 14:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707950765; x=1708555565; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZP+BxUxePmCLWZ8ZfOeiaW4IXKd0KvZFg6WZ8fL0so=;
        b=dbjJFQwr8VLH4copG+d40N1qNV399ciz2di1/U4ldt04aUsYcse0og5FzQfpKJmL2A
         9YUWcqitRa1Cba8Iky+hM27ct2THs08pVCk3OwTGPL6+lyNNCWgwKNSEAsH4EdVW/0XF
         TdGb9A/RW4IYZaZnXRwL9c8likKYyTWwCd1vQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707950765; x=1708555565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZP+BxUxePmCLWZ8ZfOeiaW4IXKd0KvZFg6WZ8fL0so=;
        b=fXHfml+HD8AkErWs0AMpdGF+GzBpGC//6Uu0k+HzcsZJNMGvOFyilruinoXf88hIVG
         5sQwEv3BEC8CfgpBOmuRkJswzrk8CXCuLwHl0VjWegGIHNpoPI5tMjEwqZ8QhKzj2+OW
         1d0/bqObxE/8TZaNb2KH/JxSIHLnQxJz1Lo7i0155VwOjjWWN5mdCkjWGJgrhlefoUBA
         Y5yxqded09CDggi8dCIKarsCH00z89kWs1T7FbSvqzk2gA9csM1O2OlkfChnYq5fanai
         jdE0Z8mF2Sdxu349crU2MQk/lkrBJdMa5HsnD795odOEndqLhbpi2S6Nz7V7J6iwktsV
         ahbw==
X-Forwarded-Encrypted: i=1; AJvYcCUTNfSZFRCjtjkEy6M31GYkbRN/AGG3K2KOGyW0EVko18TtKnJ6222Q1D+hsLgfAZG6YmcaIQLJ5f2SF12AxGKTgxFzzmrrrLQeujgsDxc=
X-Gm-Message-State: AOJu0YwE8QlI4CaCuOzuXhpwbTV9tAQhmxEM2RlwYPZfU49I8UW2IjKl
	sYK4LWL0QPoIJZskXiesVFhRfwmj2cG3MQL8WcIwUJTyzpCQ4jlf1PhDPQYrVA==
X-Google-Smtp-Source: AGHT+IEwKqfIdExn5GXKXrbxOA/cEMTv4gqm1KamsNHD/d7odYizVrN8PnY95/ALxTdDxMyMcTnEUg==
X-Received: by 2002:a05:6a20:c702:b0:19e:b9a8:bc7a with SMTP id hi2-20020a056a20c70200b0019eb9a8bc7amr256992pzb.60.1707950764884;
        Wed, 14 Feb 2024 14:46:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXUGkaK+uG2HYDYpAKvRgJiRcIWuMgkS/9TgsR66J3nWtHqH9sZHwNHgaLV+Aw5I+5Yho+5LbjqF8WB7N2Ph3FGaG04qfiX5QSW7kmtzs5fyp0+pnVsK2+EfOXM7A8h9CUEhYuH8ztUU6gvjoHDgG8ZFkOG4w4mxDvvkYX1zzkjjzbu2uil2DaCQkewklC5noE8NtF2a36TymKP6b36GAD19eg25KxsFC0voQhzwQqjoDGrzhYs5v334PjeVpU1+m9rcgmsVBQ8FDh+pxGBjGUUKCGQk2vpZjj9j1PfF/7wJziaIGF3PdcMWCbQXb9pzJ5XoIAH058/e8a9vWQu4MX9n9FdQokJvA7jfyf2ZI1mzQz8xM5JryGztpVJddSUITqxQjIWsZHEti2kDugz+Prl2/Awio4EURa09W9UG3QIzXZ+M48m/Dp7Pi9RlMRXQO4YvvyK+ZGSSYER2RPjfYSjPGeTewRJItDlUIyHhoQp19SCBj2U1/IN3KCSE37kzpZ5VrE3mAnTjD0Y/J72QxkuvPBskpwFXlC6w0RWQBGeeYUeZFukAt3A253vVftrPFmwd1ozzR+ElMzLA9NdZkSYEhGJ8Pc=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j20-20020a056a00175400b006e04553a4c5sm9894509pfc.52.2024.02.14.14.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 14:46:04 -0800 (PST)
Date: Wed, 14 Feb 2024 14:46:03 -0800
From: Kees Cook <keescook@chromium.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Theodore Ts'o <tytso@mit.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Carlos Bilbao <carlos.bilbao@amd.com>,
	Avadhut Naik <avadhut.naik@amd.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, tech-board-discuss@lists.linux.dev,
	workflows@vger.kernel.org
Subject: Re: [PATCH] Documentation: update mailing list addresses
Message-ID: <202402141445.F9E9116E9@keescook>
References: <20240214-lf-org-list-migration-v1-1-ef1eab4b1543@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214-lf-org-list-migration-v1-1-ef1eab4b1543@linuxfoundation.org>

On Wed, Feb 14, 2024 at 03:09:53PM -0500, Konstantin Ryabitsev wrote:
> The mailman2 server running on lists.linuxfoundation.org will be shut
> down in very imminent future. Update all instances of obsolete list
> addresses throughout the tree with their new destinations.
> 
> Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

Thanks for this! I had just updated the TAB's internal docs for the list
changes too.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
