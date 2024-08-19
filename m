Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA9916CD1B
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724076086; cv=none; b=FnyJZxf5HBFJgo/3asjK6qJByuEUCXCY1sCl8Ivy0sipKbV/vwkFbU9DQsSNe4Qdl0OHXKzsQcNjfsqZnYu+bIANre9UcMbby5xnj66mg9qCtBdEoKFfuIU3ohm1a4Pg27mk6IXNMDxkPPyOG+uO7MYKrT1cpgwZzX80g2LzfCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724076086; c=relaxed/simple;
	bh=dynZuTUbyVb96NznS7xWcxJlZkqiF0rEO4JkGViRJRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxyTXyrTFS1LEYDujM8D913GEgpGoWkK1A0xF7GvEFyTZJ8cW0gHghZjKdE9xRFy6Jc24a5OUtvnsg37oddJXnIfWavbx/02uqkmpW15AnqlU2o0XfsRN0ArwNn1rymfozjrSlzp0exXCJUAa+ho/UL6zAkj+/ky/YBYHy6icH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Nb+h1E92; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Nb+h1E92"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bec7d380caso3500926a12.3
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 07:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724076083; x=1724680883; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I8+bzKwXHufMQYVUvAH9gPrjcYzjw493S7h8wjt/jsQ=;
        b=Nb+h1E92Q+DNB/Ose5CyX26wB3kZPnFXtNg5C0yHLH38bCizN+vs8nsHSf6oPcXM9v
         R76pLUE552PIMQa6onln/Yd8hMNQRYp3jj2quyxp0t6VlUhc6rIn/L9tywZJjGUUbOzt
         AYYAPC4TGEsk6N+faZznMaWt5TgqRtcLSPOdbDPS70r/L5ZlhGil9WUgbATd4Q3hqCY/
         GSiJVmm1nMuroQJcIq56QLfjuCDX5VeMRmghvpJTKcCDzFPR43DjXbvEQCTFwXFRpRsK
         9SBnJz/gDO+Fsaecx/deAuexLkqxe5PaK9QQK/g+Fv8av/TimTjtvEdVKahdegbCJuRz
         tnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724076083; x=1724680883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8+bzKwXHufMQYVUvAH9gPrjcYzjw493S7h8wjt/jsQ=;
        b=dIQmTvfdhIQyusrpwXoWuISeg9srdDUcuPlSmss7pEC3jQ7rK1WORZJiqW87s+HYAz
         vFHKwd9C9RxyrtXDekzSw0NIvHh4b+BpRkxWxhvWQGc2C3gJxZTC5RtDiXrqcyfar1Z9
         QURlMYElNiL0Lr5+pHbPv3encmZj9iVsvpUKFBg5t6mbTlE0G22yWZwRQd1wk9wbGPcx
         jZ8uQCimi4hkYSeyaOQdN+C5C5mso5GmDgICTJ/kTzwwjBsUITCyF80eZtc13eHPt+us
         qReue4pvm2FVdLMBBhw9kQwxXlGX1/dcxlC1rV7AABgnzMzmAM0/cmuFioDAR0f5o6kj
         bKRA==
X-Forwarded-Encrypted: i=1; AJvYcCVopYPdQ8fRFxM+QWfhBpcpjx0YBGwM2W++2xr9JUS43VHAmqcplFLcCV1B7Hvcv5OkpEJB66nTzr6jhxCcTklcdULE4Dml7l2NNCD0qHQ=
X-Gm-Message-State: AOJu0Yx1P//v/hLI90UoQpjdNxqZ553nctbZDtr79gJiva7JFXU/4ZMe
	Fx2rxA43l+8KSqk2A9wtqHa+7hSisqV8yq+eGw9/1ziIHk3f/LNze7HJ8WRnDVU=
X-Google-Smtp-Source: AGHT+IFLvD0W3+Czucom6QjzOWDd/NDtdhs111riyem50tFjfWW/Hcrf0B3pEvI3LVNIS+wSFbL0Xw==
X-Received: by 2002:a50:8dc9:0:b0:5ba:8ad7:4859 with SMTP id 4fb4d7f45d1cf-5beca52aa7bmr6882293a12.14.1724076082378;
        Mon, 19 Aug 2024 07:01:22 -0700 (PDT)
Received: from localhost (109-81-83-72.rct.o2.cz. [109.81.83.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbde4964sm5610388a12.24.2024.08.19.07.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 07:01:21 -0700 (PDT)
Date: Mon, 19 Aug 2024 16:01:21 +0200
From: Michal Hocko <mhocko@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com,
	hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com,
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
	torvalds@linux-foundation.org, urezki@gmail.com,
	v-songbaohua@oppo.com, vbabka@suse.cz,
	virtualization@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Kees Cook <kees@kernel.org>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3 4/4] mm: prohibit NULL deference exposed for
 unsupported non-blockable __GFP_NOFAIL
Message-ID: <ZsNQMe8hSKLVa-yG@tiehlicka>
References: <20240817062449.21164-5-21cnbao@gmail.com>
 <CALOAHbD-npQmchiRJpGvOBVOM-Li6oRyMnKAjgiHq3DasiXMUQ@mail.gmail.com>
 <ZsL5LSK8R3B1HsR1@tiehlicka>
 <CALOAHbBtB40Qth3k2yXM7riPaf3nxP0p4W-Ur=h2UK0BvPg4QA@mail.gmail.com>
 <CAGsJ_4yS=8kXruzVxzx+u+nyXG-5OfdjxSZeq_WzyOGfpu5btw@mail.gmail.com>
 <CALOAHbDKwmtRcowx=V9Qfk2AF5=gg6_kTZC=jfPcB7=fmd65LQ@mail.gmail.com>
 <CAGsJ_4yyYaPSG+aRQdFqh+Yk-gN4Ah=d7FxmUVdSU5H3Aeo7pw@mail.gmail.com>
 <CALOAHbCG=_W9rrf+hgkFYF6+1LZuEeEjpyiexu9iseGOaDJ+QA@mail.gmail.com>
 <ZsM2De5v06eJsiG3@tiehlicka>
 <CALOAHbDCpxV=5raOB=t8Xtnxb9fZu_uaC3TmKvY767SDRJQvPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbDCpxV=5raOB=t8Xtnxb9fZu_uaC3TmKvY767SDRJQvPw@mail.gmail.com>

On Mon 19-08-24 20:17:36, Yafang Shao wrote:
> My question is why is that ? Why not let it loop around the allocator?

Because of 2 reasons. It is much easier to see NOFAIL allocations when
they are annotated properly (try to grep for all sorts of endless loops)
and also the allocator can make sertain heuristics if it knows that
allocation must not fail. 
-- 
Michal Hocko
SUSE Labs
