Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BC018C340
	for <virtualization@lists.linux.dev>; Wed, 16 Oct 2024 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070575; cv=none; b=O9XdfaeA+r57Xi+Vg32Rxc9+N+S0RiHLxxTHpfTXxNMUf9toqrxTuF+SUBCNF/0XWYN4Wc3Y250bpU8x+4u+gFTH+w26iO4erW2aow6GYU8cS1wsculO20jj63cIl3CUz/JiQbWaplTtPERh3GfK6Pjnr+msLzFR6QECSfaWGrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070575; c=relaxed/simple;
	bh=7NHqxy8z9St5srRirP40JQGjKhgMJDkdXyhJQwFf7RY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jWgybXdcFV5cM/isRTGAyfZec9g2cHI/oAiiAns2LmoQOcCO/jdjNjmegNXYHpGDPTYN/G1hg5hSrpDKHwDoAbgDgTdiScnGdk7bmiVih29zapEmRzCYFJREXWOb3Ie8REIoPRAa20yZgXhAVI1gpLD6EeM4tcQXByrwl0xcdY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EZ4+M72o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZ4+M72o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729070572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7NHqxy8z9St5srRirP40JQGjKhgMJDkdXyhJQwFf7RY=;
	b=EZ4+M72oXR141XvVyE07bAcxijmOdmprknlNSRKYrSqWyDsGdDYjFgymhSHr3voFvXo2YF
	ZIOxvJ8Ert8hYgeuqjvYh42q2+539IHjmwo+JyNEN5H8qzmQE7v4g/IkmBEIlq0M5OlE5K
	iBM2Cmy8QuBknD7yIbRL3uOr0exBVpg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-6jtcm8AQOTeHJC9fK0tb4A-1; Wed, 16 Oct 2024 05:22:51 -0400
X-MC-Unique: 6jtcm8AQOTeHJC9fK0tb4A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d533a484aso331178f8f.0
        for <virtualization@lists.linux.dev>; Wed, 16 Oct 2024 02:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729070570; x=1729675370;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7NHqxy8z9St5srRirP40JQGjKhgMJDkdXyhJQwFf7RY=;
        b=FbeYrmh5DPr91PYUcTma9BvjPJaIPqbsJf5tQxGcqopRyT3PUJHyuaQPUdZ+1ykWnK
         52gvUrtWE/FsR8396sIgZ6e/SHp+qkvA9GBzGVpoIYhBZbxslZe2artvJV68RSbVPq2X
         HMgCd2Dbo5wZf/e8tR7mSzaRpbdhhWSLF2pk8+hFFkCCo6Igt2+zQsn5y8aWX/rBpk5Y
         /FsFUh7cE4ci7LQksJm89k49O/6RVZ/tvIR6QAe10xtFRpi6IuuimM7My+uz9jSN53i7
         4Pz7t3n2POKnxZbV0BiW+wlpi8H/uEyH/JNSu2aejXxD3LVKKH/a7tvayhfvpmoaCjY8
         +q9g==
X-Forwarded-Encrypted: i=1; AJvYcCUVf57SSk2+qU8keZbFkkPJMYjcZqnz9Ia2HbAqxvVPSyIrH9OyGrzvR8PcLg8vKDaVuUX3FJGngFQldneL2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJy0tBnkXAFAZSXC5YNGVvLvK7sWIIfWdG22jYDSf1yfsKH4kU
	AHs8NM2+BTQzbACicg2zdb7udNtbvMyxIUvjKhqT4ml1Tn7Szn2itL0b06FABf/7lqu150UFDxW
	HrHksGzWyaRmncPGMPJN2PkAlsvEk9Ai6cCnaCYhbzLYP7SQuPV3mzwYr2tvkHTVS
X-Received: by 2002:a05:6000:ac1:b0:37c:f561:1130 with SMTP id ffacd0b85a97d-37d551fd967mr16230974f8f.18.1729070570113;
        Wed, 16 Oct 2024 02:22:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYuIRB3SOz3zBfW+1TrVdJdzEMd1HnJYU2msz5wLlhJ2CtVCce9o3U7IRhaBXskyCKsIvrxQ==
X-Received: by 2002:a05:6000:ac1:b0:37c:f561:1130 with SMTP id ffacd0b85a97d-37d551fd967mr16230952f8f.18.1729070569691;
        Wed, 16 Oct 2024 02:22:49 -0700 (PDT)
Received: from dhcp-64-113.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa9077dsm3825575f8f.55.2024.10.16.02.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 02:22:49 -0700 (PDT)
Message-ID: <17b0528bb7e7c31a89913b0d53cc174ba0c26ea4.camel@redhat.com>
Subject: Re: [PATCH RESEND] vdpa: solidrun: Fix UB bug with devres
From: Philipp Stanner <pstanner@redhat.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael S. Tsirkin"
	 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	 <xuanzhuo@linux.alibaba.com>, Eugenio =?ISO-8859-1?Q?P=E9rez?=
	 <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Christophe JAILLET
	 <christophe.jaillet@wanadoo.fr>
Date: Wed, 16 Oct 2024 11:22:48 +0200
In-Reply-To: <Zw-CqayFcWzOwci_@smile.fi.intel.com>
References: <20241016072553.8891-2-pstanner@redhat.com>
	 <Zw-CqayFcWzOwci_@smile.fi.intel.com>
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2024-10-16 at 12:08 +0300, Andy Shevchenko wrote:
> On Wed, Oct 16, 2024 at 09:25:54AM +0200, Philipp Stanner wrote:
> > In psnet_open_pf_bar() and snet_open_vf_bar() a string later passed
> > to
> > pcim_iomap_regions() is placed on the stack. Neither
> > pcim_iomap_regions() nor the functions it calls copy that string.
> >=20
> > Should the string later ever be used, this, consequently, causes
> > undefined behavior since the stack frame will by then have
> > disappeared.
> >=20
> > Fix the bug by allocating the strings on the heap through
> > devm_kasprintf().
>=20
> > ---
>=20
> I haven't found the reason for resending. Can you elaborate here?

Impatience ;p

This is not a v2.

I mean, it's a bug, easy to fix and merge [and it's blocking my other
PCI work, *cough*]. Should contributors wait longer than 8 days until
resending in your opinion?


P.

