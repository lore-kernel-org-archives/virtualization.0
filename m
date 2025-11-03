Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E009153BED
	for <virtualization@lists.linux.dev>; Mon,  3 Nov 2025 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154280; cv=none; b=g+RJZvuZN+xG48FEr3mrjdyOX2Iwl8SayZjAGelV32xmVaMyL7D7fwS6cqBllc4KmsyDuOO9/VAATMEU2940vTmZKw565bLY8bFYJF0Lv5+An2GSH8TowpYdPo0E40sDhO4CCpI5+rraHfimK3h90MEwbsLzC6C0wCNprFONqPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154280; c=relaxed/simple;
	bh=u2RitBJJYcOeGrXcJN16D/BkVV6lr7NwWHkSsUefBtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7fdU356zhn+QvO5Wjit6D1DtEYqqWXmVjfLUJr3lioPESsctVHj4N4wYjrVqKbVp/CQP6MeFTHyKM51mtnu36eAMuzgFluetcUFAOaiWYAWEcWoNcbePXZJox4tRyMjSQZbdttXGHwdWFfw4987NgxTejkQqn43lXlmof9C8zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bopi43CY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bopi43CY"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2959197b68eso193755ad.1
        for <virtualization@lists.linux.dev>; Sun, 02 Nov 2025 23:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762154278; x=1762759078; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fkl25q/g8s7OS88Wbysk4mwVIyDLafMsvz/s+Uj9Ki4=;
        b=bopi43CYPgEKKK0+6/gQ2GihYCtTGt1GYv+IORJRUS/ZTi437e1Jd/ZahN9BsZjGiL
         TtevQQ5ISCXy/fP0YpUvP/UD8oByIAi0M7Kj2Z5+Wmw235jN2rE/qu+EISGy7FRs0OIb
         QeeI6COBCCP7mgg4DhizCpz4unKWwwm++87JwOCIdQdHTbjiDy8exkz0aP8GsL67Toto
         aWFSNHtTnPiArfLEc6BqyLBtyhOgeZqwLavUKaWvLECm1/+2jyOTNQq+QWjdK+1hIG2G
         BpaFuBQTBj46fntL6hvPXuU+bSFBfdBBtZDclH2bNAERS46jtvcC+0GsP6xQpDZAOkS7
         CzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762154278; x=1762759078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkl25q/g8s7OS88Wbysk4mwVIyDLafMsvz/s+Uj9Ki4=;
        b=TpjjCnHGgtk4TTlcLywz3C8oirs8wcrMKTNtflSUkYPuLmsTnDGEkov4PrElWzhywA
         FMoqu14LFxJw31eCpffyju2ojCdEsr8ReZj8W3dcLjX2BbAz2q0InVYRFeIzQf9bAuri
         iHs12Ct8pt5vVjt0eGRxZmomsy73bu8JJ60+nQizPD7wJsMgiYhJPRl4ZHSnrUnncQDK
         utEFb+YLzEN8zLQaeVFs2tWgx0M0ZZiD+KGoc/yKwYQGXzgaRMrmNhBSnAChX/a9xaTO
         GAj7lQ/2Y/cOIWkgu7XlIRKf3jACjq7TVQpyEbql0jmfNVM/pH35DHnK6b9bzb4uA/39
         uGDA==
X-Forwarded-Encrypted: i=1; AJvYcCUlAReFYtvWqhxL7MbD1+RHNXQZpxTRul2iUTDyuFmIyE2nTmL81FUniXio6PpT1bKdg5pBlp63GutnxARpDg==@lists.linux.dev
X-Gm-Message-State: AOJu0YydqNDW4GupmGopg3LcOOgrY7GJg6XpCkLXCvtXvZ4fwj0i+AH6
	PthGQQbC/B1f8+Lza3CQQ5l7hGh3AE/PK4wypjz7hu13ocT7z1UfrHOgCoDyJjWElw==
X-Gm-Gg: ASbGncuC2Clce0BY5tg8HXhxfnnnhpegC8XCe85jiUIU38DbX+kTRh22PuftfCoL6S0
	DfNoljpPpU6AmpxphR+Dxy3ta+ShGVQKwZ1qrfGOwH7jEo3zD9rsT0gl9ZPYFlSt6CbZja/I/Xr
	xMnEY26XQF4uFn6PkUz5jEFOvzNxyOztCjjqX5w7FF6BVqzjNc51/V0yrF4hw9Qmzmms8JMmnVr
	SA0Hd5vajWq3uscJcMvgnLGdhTeS5oIZxOUbT0q46i5dFLPbi9hekjG7+fmwjeoX9Xb0sK1vpqP
	pQFGte+Hx/0Xspvb45z2rgEL94A2f9ZESEuTL6rEvbwKZbPJ8z+BnE3T8x+VZrnfZJpT0KctZKl
	FA9WSLRTlb6nArJNkFrUJ6OaT7LzGtPzCXrIiGU8m3zFoGLqnyYO6m0Wb7WHz24Mm1Tmevw0cR7
	UZg+3pRVyA1YH1Dd0tUAeEMxhMkFwH+3612pp7mf8z/aKqayaO
X-Google-Smtp-Source: AGHT+IHfDR3pQIMSIQjN/GyrpnHhW694vgQCyWpAq5GaAMMYhNpX5IKRikqyk5tXJtqoi708RLXBcA==
X-Received: by 2002:a17:902:e88c:b0:290:d4dd:b042 with SMTP id d9443c01a7336-29554bc5206mr6800415ad.16.1762154277664;
        Sun, 02 Nov 2025 23:17:57 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93b7e19ea0sm9634160a12.5.2025.11.02.23.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 23:17:57 -0800 (PST)
Date: Mon, 3 Nov 2025 07:17:47 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	David Airlie <airlied@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Brett Creeley <brett.creeley@amd.com>,
	dri-devel@lists.freedesktop.org, Eric Auger <eric.auger@redhat.com>,
	Eric Farman <farman@linux.ibm.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, intel-gfx@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
	Kirti Wankhede <kwankhede@nvidia.com>, linux-s390@vger.kernel.org,
	Longfang Liu <liulongfang@huawei.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>, qat-linux@intel.com,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	virtualization@lists.linux.dev,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhenyu Wang <zhenyuw.linux@gmail.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>, patches@lists.linux.dev
Subject: Re: [PATCH 06/22] vfio/mtty: Provide a get_region_info op
Message-ID: <aQhXGwlxZrZl5GMN@google.com>
References: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <6-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>

On Thu, Oct 23, 2025 at 08:09:20PM -0300, Jason Gunthorpe wrote:
> Move it out of mtty_ioctl() and re-indent it.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  samples/vfio-mdev/mtty.c | 53 ++++++++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 24 deletions(-)
> 

Acked-by: Pranjal Shrivastava <praan@google.com>

-Praan
