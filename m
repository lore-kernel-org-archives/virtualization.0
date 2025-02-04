Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB82E216617
	for <virtualization@lists.linux.dev>; Tue,  4 Feb 2025 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738692377; cv=none; b=mHt0xTUYOCaBQ78vKs1XcnfsvJ3/u9f2PvjfjjEnrsg/WqKt0Os/Dg01DJFNBJ9c/4+0IEQ1DMwBGcdV4X211pGiLmstwF7OfNYVqPxhacflvyVbUk1zzSSr9bCiO2HJy8XL69921xd4B6rp5E/RYV/Jer0oyyVJEL0U9x5ZUoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738692377; c=relaxed/simple;
	bh=WNANZU+kfpdMeHPgf7iTwjf4f37XwN5zh6QwchBR714=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfOICBN2KKQngEOQTax5SC0KQ4esqaUSyQV90HiP4mAJWvwNRfTaN6mgPKaiiN1AvlbauJpJeNQYHHTks4sHIqgW3ZLoQbY8IbWeH+wTDFs1QGZRsDMgbhuL9NW+JohGoWs4A5/3Orc02mIbd8l+Pg27aZa0rLnVQ7D4gVfRdqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJd7Wp1l; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJd7Wp1l"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-215770613dbso81041285ad.2
        for <virtualization@lists.linux.dev>; Tue, 04 Feb 2025 10:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738692375; x=1739297175; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GrRDiNWwoEOAF9DAZE2HXZqTxhwU3nG+MjD2lSOs8U4=;
        b=gJd7Wp1lFJfK49uhqeN97idOri8ON2bTZLi8KFAbMAam85K+fTUgyz57mmqX3Umyu3
         jjwA8iHK8sVdTB+/Wyzhfkv7JBHVvEh3r+i6j1Sftg1xOy9BwYsBPCHEnGIZuHh9y/7P
         o5Pm41NZJltxJmR4rDkRjq4XtY8dCY0szhJql/sAgnyJZ0NY43Ch3NQTqU7STh7Nee4g
         onC9pAXEfvHcR8uU5I5b3vPrkZJsVjKeE2wX5F5GRUYQKF7XwLaanKc0CwyNxXTn8UHT
         8VQ78Zhnd6+DM9rmjXZUkkYvaJufS15uVkjRdO0wQYMkiIBTpdVnhiC1fxlyNu7hNmWr
         N99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738692375; x=1739297175;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GrRDiNWwoEOAF9DAZE2HXZqTxhwU3nG+MjD2lSOs8U4=;
        b=svtQpn5UQw5FQdnuPNH4mAZnfaFkFeOZoBAPbroZs26OAqi+4AHbWDQteTlkQppUoY
         K2QTCnXfPY3OHv/Ssy9v6QB+OAAs8Pw+LYg0u8Zwwn9azp3fZzmCh0MU6iRirUQAEdWx
         9yPm+kX16qYe6SkDMKn+2gPVgtLhq5hfLQM/GbLQn1NXHbyq104udb0RWAoH1Izr0mAO
         FKhaH/Tna6bPbmL/V3oIW817ny9zAen8+n3znakw5NIV2aBJCf2Fs2WwS32O4Sr6QCcE
         N3bm3iDCH5fh+01asBSkqc1ASfeqiaAps4uApUrYYCOUn1BilMfnMTR4dejKJCwRBSpX
         h9ZA==
X-Forwarded-Encrypted: i=1; AJvYcCX3oDSpUJUsxotRyDchHF8hEwYTRJDjFPNYn0kBlk3Xian3cQFnzq6VlQakuuFwf7rxncR2cRs340EXucrn3A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnetHrf4ZJIE62p/MK+HGnF3Ju34eB/ax3xmK25UgsVQuioQ94
	SuIkFriP92jSAjzvV8/zMjKJQTwTptKndPws7+ceIZG0wZ/FDgw=
X-Gm-Gg: ASbGncuahiJOzyYmlqAYGwTeSOcvaeQtQY1gNKRERDTaLtfKSa5scpcs6aLNeA1frk+
	yFoSkjhwEtkTyKVXqSbUIqgnCh4cQGHz/TWizZ125arvHP7RB7d/VLNpUH9jat8TbNV5RMDZ4H2
	+kZEg69QgzgQZ9k8/Ck80swG46Pgpt10x4P5fJ0FDBrF5WfLmbyxg+kT4RGdhdqLciGXtk3Wnuy
	N+JWX6BtPf3NPYYL9YYziSl2ey+UKY54nLtfcgmM/NeGiEKGnfgihAV9Aer8Zl0A8D1JMcuuzqv
	+RUU+2PwndrMUdU=
X-Google-Smtp-Source: AGHT+IFYT9NcRGLLxVnZIbZhoBZTMQVypif42AJDxoHppKnt1MhQTNKBNnnBYX3HBXh5CANfjLqcdA==
X-Received: by 2002:a17:903:2a8b:b0:216:6283:5a8c with SMTP id d9443c01a7336-21dd7dd240bmr373053575ad.39.1738692374716;
        Tue, 04 Feb 2025 10:06:14 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f1363a257sm3297675ad.119.2025.02.04.10.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 10:06:14 -0800 (PST)
Date: Tue, 4 Feb 2025 10:06:13 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v3 0/6] Device memory TCP TX
Message-ID: <Z6JXFRUobi-w73D0@mini-arch>
References: <20250203223916.1064540-1-almasrymina@google.com>
 <a97c4278-ea08-4693-a394-8654f1168fea@redhat.com>
 <CAHS8izNZrKVXSXxL3JG3BuZdho2OQZp=nhLuVCrLZjJD1R0EPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNZrKVXSXxL3JG3BuZdho2OQZp=nhLuVCrLZjJD1R0EPg@mail.gmail.com>

On 02/04, Mina Almasry wrote:
> On Tue, Feb 4, 2025 at 4:32 AM Paolo Abeni <pabeni@redhat.com> wrote:
> >
> > On 2/3/25 11:39 PM, Mina Almasry wrote:
> > > The TX path had been dropped from the Device Memory TCP patch series
> > > post RFCv1 [1], to make that series slightly easier to review. This
> > > series rebases the implementation of the TX path on top of the
> > > net_iov/netmem framework agreed upon and merged. The motivation for
> > > the feature is thoroughly described in the docs & cover letter of the
> > > original proposal, so I don't repeat the lengthy descriptions here, but
> > > they are available in [1].
> > >
> > > Sending this series as RFC as the winder closure is immenient. I plan on
> > > reposting as non-RFC once the tree re-opens, addressing any feedback
> > > I receive in the meantime.
> >
> > I guess you should drop this paragraph.
> >
> > > Full outline on usage of the TX path is detailed in the documentation
> > > added in the first patch.
> > >
> > > Test example is available via the kselftest included in the series as well.
> > >
> > > The series is relatively small, as the TX path for this feature largely
> > > piggybacks on the existing MSG_ZEROCOPY implementation.
> >
> > It looks like no additional device level support is required. That is
> > IMHO so good up to suspicious level :)
> >
> 
> It is correct no additional device level support is required. I don't
> have any local changes to my driver to make this work. I think Stan
> on-list was able to run the TX path (he commented on fixes to the test
> but didn't say it doesn't work :D) and one other person was able to
> run it offlist.

For BRCM I had shared this: https://lore.kernel.org/netdev/ZxAfWHk3aRWl-F31@mini-arch/
I have similar internal patch for mlx5 (will share after RX part gets
in). I agree that it seems like gve_unmap_packet needs some work to be more
careful to not unmap NIOVs (if you were testing against gve).
