Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C78482FF
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721827907; cv=none; b=TCcbHhEkrYyp8GW+xcV2p0VbYT5UKVLSBxI+DAbFSRMhtC6hLZ4r0oC3XFOvCGGDdNpgLdAeryUVaDiDuYwVQJzHJOC1vlcaL383wo/jNLGhBlfVclFLxRrbYo1P1KBdOZcVk3slnUEuNJZP9fx6EYczm9qIkVKbaHJgok2/eMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721827907; c=relaxed/simple;
	bh=t6ChO3fSZBq4A+bk/VtmR0TrYze5+9xzCM+zeaNubrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKBlFTpQ6JXl3pqP9B6AIQqcJDpYvKSYeQuG86PKoxm7o9vXhFA/RwaIuGCCVncRrA0h6q9ZDqGquskI9LuiZqUe5aFtwZUqRSSR0LLjZK6zE1qnMxD/5HA8JM5R1E9AzLiGMO+JZvgTlwP1PRTUe/A17MQEaKG35DHThDSt1zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J5FY0/By; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J5FY0/By"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-36865a516f1so5098568f8f.0
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 06:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721827904; x=1722432704; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WSfYisDMKyyNbaFoXRKXpQXDo+DAca3imu0Bb+sSmaE=;
        b=J5FY0/Byg0VnX2CwX4lZvqmMBHfuqwSaNf7b3c1s1KHekXWOSeWMnI2+PjYHaH/5w2
         LhoddJR/t/dwHUO/zIZ4D0PiQHPH2BucYCXyprmDHtoalWMCmqcIzt820Zyyc2/eJqGo
         AxlLRevlWF60MucmjYX4i/Mg28AdsFFaDb64gRzJNWCGjX+7ESvDhM42n00tU+OYTdDF
         VP6iYgqiJnDr2Bq3gtY0O2p7VBFqeNoJ0rA3VmR/QRgf+O7QwUVq2YgBhyCLn48vIPZt
         FnxaJzaxjgyoDTlC9051aNi3UrGnWLK6mZdlquO5uzaJehgun7xN9Q4Fhiaj3Daok/SV
         F5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721827904; x=1722432704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSfYisDMKyyNbaFoXRKXpQXDo+DAca3imu0Bb+sSmaE=;
        b=IrGDP+28TZHzZhH4gM3eqsuLC2uWR3l0t3+puYvIxm+1Gg1ujpAXnktOF30dQ4ZHjH
         zCMYfUE9C5d7PV7mmw8VCgbLZvfeToINGX1wUS8h6mxkJgwQRDq1dUQhaIFpJz22HVoB
         BomnF2vq9CxR/maGO5MVxmcLAWQzB5lWZMtOb2ck9K40yH+IDoodcRAqiiR8GDg6j49x
         3QJQwjK+qwlwBIW+EL+MrGJ886/HGyr0ArtkAoCSra4gDOkGnqM8bJDhvtkwq145BtYj
         9qL3qgZk3K3i1y8iYm4x7ht6pCyhkCVuoO15F5h0lvODNBqZM/dBzkC8QL2DUKhP7p2Y
         Ar9g==
X-Forwarded-Encrypted: i=1; AJvYcCU63a9uKq5fSQE6Kq44KfHsPruMVLO3A2epuwlFOoMwB02tH3dB3Ld+ycIKwvE1arDRPMWyWNtmZyHiT08WZXtxTuhKwW7h4bsIFzCFvtU=
X-Gm-Message-State: AOJu0Ywj1z7zxUQALL3ce9JsjeDIAfx8j6/2IAFoFJafyYMtetSoxxpA
	Rhas+5mmRdPlg7gBrSbiUqFOF+Ntq0C9ohcsaqcPlgNfgGteOGDQPK1yi+8ASMY=
X-Google-Smtp-Source: AGHT+IHcpJsmz2ydsm16JRiNPP4t59OI4fFowg9dM2Yl35HY4V7Uo7p3vrg8EjIWCIZ3+t3H/G7HtA==
X-Received: by 2002:a05:6000:e4e:b0:366:efbd:8aa3 with SMTP id ffacd0b85a97d-369f09aa98amr2690108f8f.2.1721827904141;
        Wed, 24 Jul 2024 06:31:44 -0700 (PDT)
Received: from localhost (109-81-94-157.rct.o2.cz. [109.81.94.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c78611asm649739666b.45.2024.07.24.06.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 06:31:43 -0700 (PDT)
Date: Wed, 24 Jul 2024 15:31:42 +0200
From: Michal Hocko <mhocko@suse.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Barry Song <21cnbao@gmail.com>,
	akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com,
	cl@linux.com, iamjoonsoo.kim@lge.com, lstoakes@gmail.com,
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
	urezki@gmail.com, v-songbaohua@oppo.com,
	virtualization@lists.linux.dev, hailong.liu@oppo.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH RFC 5/5] non-mm: discourage the usage of __GFP_NOFAIL and
 encourage GFP_NOFAIL
Message-ID: <ZqECPiU-3fJozzpB@tiehlicka>
References: <20240724085544.299090-1-21cnbao@gmail.com>
 <20240724085544.299090-6-21cnbao@gmail.com>
 <68ee812b-3b96-4c8b-9a54-70d4742488bb@suse.cz>
 <ZqD9-yzGxQIFlxGQ@infradead.org>
 <ZqD_ydjhUI_GCgSg@tiehlicka>
 <ZqEAUbtkIMCwVpgB@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqEAUbtkIMCwVpgB@infradead.org>

On Wed 24-07-24 06:23:29, Christoph Hellwig wrote:
> On Wed, Jul 24, 2024 at 03:21:13PM +0200, Michal Hocko wrote:
> > Scope API is tricky here. Exactly because the scope itself could have
> > opportunistic GFP_NOWAIT allocations.
> 
> Really, where?  That just sounds f**cked up as callers using any kind
> of nofail API can be broken by a caller higher in the stack.

I do not see this a problem. There is no real reason to have a NOWAIT
allocation down the stack that has a different fallback strategy.
I am not saying that this is the current practice because I do not know
that but I am saying that this is not impossible to imagine and it makes
scoped NOFAIL context subtle and error prone.

> And that's totally independ of adding a NOFS/NOIO helper, so it'll need
> to be fixed.
> 
> Adding more NOFS/NOIO wrappers while we're trying to kill the flag just
> is not helpful going forward.

NOFS, NOIO scopes are both compatible with NOFAIL and NOWAIT contexts.

-- 
Michal Hocko
SUSE Labs
