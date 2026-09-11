Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CDD3148CF
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 22:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789167144; cv=none; b=CcWErZml0ecidfTKXljsEPgM3uebdIaEWq7VSZGYzaze/8OnzLtkG++vjMhbGo+HferBcahBABm/+N5xr20mACed6fJ/W8rhHTXxrRKryKXJLXoLsnoNXIaMhl76tUjmMgyZwKaN05TrJTaB7NORQbk2c6652B6XWFO50IuHwHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789167144; c=relaxed/simple;
	bh=ftNgNKh9VdMtBQc1BMR6LWCIRqVgg3TsQH42M2mPoM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6z6eOqf6XcFHMzkxapbuXwFhYomP17PzfnjcGJiELjC0qMTgk0Y3OCNYk9w5jG7ZyKlVUXJI+0pVACvQHmtrpy/fovDSuFxK3rqDO6hm+1kmFCT3z6/Ak10HUzbDBcWWsd8FQ8QB+RIILjAH5nyJgSFPHfG1nXZlW+ixr48vQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MD9GP/83; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MD9GP/83"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843378fb37so40789f8f.3
        for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 15:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789167141; x=1789771941; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7lRQ7+pGNaq5SaCh0WKrw3A1f+kuNcEq+sHWBo4gNe4=;
        b=MD9GP/83EO3PXtNgMAatc6+r0epfc6aD6q885/xlf7Rvtz1rTkgF6llRXiNDaKRyDG
         n3XpV19pvw01VYaXp5PIxdgDMW57MN2fxlwPzhT6TvIT4ZJo+rMhPZSQtU97kucepJQB
         jANRSKW+gLCn+HYO4Css95sBc/qQNHeGSFor2vfng3pj8kP9xbY4hsT0MDqWKpYgaF3Z
         bY59aNkjnxZj7SoO0rBzJkL+Qyo5ijINgb457roLVfWPTiIbASqgZ0ZDwbI03P0mmPJq
         CUJ6xR1aFN3Zu40G/r3LuzsQEPErKR+y5J2Or8PCJqkueob60QXu5W1V3+r6FP5aOAS+
         4xUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789167141; x=1789771941;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7lRQ7+pGNaq5SaCh0WKrw3A1f+kuNcEq+sHWBo4gNe4=;
        b=ZNjoSWzIg0H4xySsO4HFjMcicwEmswn+QrVjluElutg2maAO5vznH4DsLjkeHLbL/v
         1nJtWTIvUXWSkER7f51GLNuuw6E7AWth095nSKuDgGmc0G3KuJ/uwJKbGMd2TNt9umgi
         0ZQJEGFczwxTR9vRfJO1tRk6f82zFeH0MNYF2VVW7zJ15NQWlwiqSEnFgJ9alkJqkbE9
         GKTIOLMp6QnWtJCo0fNWYETpImbcxHe9ac2XJFl22IQHDzUULKlBOCJ9p8l+0c9ajxQ0
         aK0wfiyVVFMMnuYh+kuZ6WtrLZKXFtpLoU+IEYSpsl8PkjIhjI5zlL1PpZK4ozh4yRuP
         sPmg==
X-Gm-Message-State: AFuF++kuX78ItZb/59BSxGeLF3qgp6SXVSO/uGqk5LGhNpS2/1BYALl0
	Xx4K+OWfGUUk8oqhZLTmuLs+P3O7O1QM+z+JGQWiWSC5taRpvjqZV2HZ
X-Gm-Gg: AYBFou1Rhhri2zD6eJKKoqZoAH5rIBKqObgEXI4RZfK7IZ5t/PoHTep1Pk4Oh26uWNX
	2wob7Ak7PmEpODyjkBTxQSedu2T0UptLIW2hjoYS5DDWET8UKwudeBVM/OwgPslQebpQ06JZSfU
	Xs0hiZk9kDkD7WdxTJpLAUM7i9efiL6SLVGRQVtGFOuiaFureDCoWIbkRHh5csHR8v4DwwLoHWl
	rKJWyigHNVvOabDg3MMpOCdHw2N0g7zxF4GiHiG0QmJJF4Nk0sWUDJX7TbMzsXqoImrXqlDSyc4
	8hJ4lmyoaTSusa+73bYY4VdLAdMicrj4V2L7eRRz8FDqG1Oba2p3gNB47VqI5TQ4IhkDB5AQTE/
	8SOGVhqV9uuajK0QWUrn7KmXKcGgcsxRes8uzPEko7ojRivIMqC+ZRiWTf7xICvLqcyCFD1csel
	3QFkspBgqaquGk1FJMgZAn/Q/h2bhI/JDVg5slonwt92dmtQWKCs2nL2Zs2GKXcqBYWK8iVfJEm
	43vnMiYNWb2E+0sR0CgROLYT3fg8Cyfma/TKSZArAZmgAVMTMlckGkuQ52k+qNWY/26/+iEGxOt
	EafU2VCjlj8o8SacZWl6+dV5yg/A6LKNhA==
X-Received: by 2002:a05:6000:2082:b0:484:3f15:15f2 with SMTP id ffacd0b85a97d-486f6c17cdbmr430823f8f.24.1789167141058;
        Fri, 11 Sep 2026 15:52:21 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-095-114-033-154.95.114.pool.telefonica.de. [95.114.33.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb357288sm8936891f8f.29.2026.09.11.15.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:52:20 -0700 (PDT)
Date: Sat, 12 Sep 2026 00:51:49 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, jiri@resnulli.us, 
	sashiko-bot@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] virtio_pci_legacy: drop callback sync on reset
Message-ID: <aqSF5m8rLza4vf05@gmail.com>
References: <cover.1789160982.git.mst@redhat.com>
 <572661b65eebb784652e5843944d284bbceb2954.1789160982.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <572661b65eebb784652e5843944d284bbceb2954.1789160982.git.mst@redhat.com>

On Fri, Sep 11, 2026 at 05:20:18PM +0100, Michael S. Tsirkin wrote:
> The virtio core now synchronizes callbacks after reset,
> so the legacy PCI transport no longer needs to do it itself.
> 

I ran 200 instrumented virtio-input reset cycles over legacy INTx under
KASAN and lockdep. All 19 callback/reset overlaps completed before reset
returned.

Tested-by: Karl Mehltretter <kmehltretter@gmail.com>
Acked-by: Karl Mehltretter <kmehltretter@gmail.com>

Thanks,
Karl
