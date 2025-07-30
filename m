Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31241F4E4F
	for <virtualization@lists.linux.dev>; Wed, 30 Jul 2025 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753873069; cv=none; b=Vb2lXUtscoUcAjtejrljjGZpFSXjdIkGUKrZGyO4KlDimyl1CDQu13UDSvaacn6bKM9TiGdJ8uv+6RQYdbIqKGCoJqxD7w6Sfzuc/x+SoMjv9kDca52y/KtCV+BLInXpu6Lq71kmjaVD2AYX25n2D0GURAzGzB4m9GkIxQ2x+gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753873069; c=relaxed/simple;
	bh=DQmcKnGKJN5RrMHBWyXbcinOiyM7f1vIIndXQ5oJZhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm/17X7ykbp8CUZ4nEpCV/aO80lTz9cEteUJgeS4tKwx757YQsLsfqjR7dGkznhMR438wzi3W/t4FivjXXNpQVrs5s3Y8no8AUxgj5nFMgRgP02bM6s9XN2fEraC13P/jnFErob42dtkP/gNq5nWphmeiN6MoMoN+aV8zzs8cOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e87Ex1Sh; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e87Ex1Sh"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b3bad2f99f5so745965a12.1
        for <virtualization@lists.linux.dev>; Wed, 30 Jul 2025 03:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753873067; x=1754477867; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dey3O+8JYJ0+DC9nws58D9CFVLsgCTJwkc0ezpPGS4U=;
        b=e87Ex1Sh6bHqn5y8oQcQf5JE7dAVN8VJLq2fK3YiZgCyP0vfAl1dYtfl2rBEH+2CiX
         xKTvxtXr0zJKVqKILhubvHTwwvcerA/6TlmRHYwiLHQZBlDTzu3ntEtXBbayfVCCxGLh
         CvLJ7PS11zO47AiEaRdwvR/gWweb97SwDW2FoRTN1zJvJbSMnw1bwOc3/BntnS0wDdw4
         tjW7rZXGOfayjWDfJVJoPtAT26DrWfj50x6pH+s8YAkqgXHBJCWUgE9M2tDCZu7ORL88
         v04IEZ3wLfHudW9MbnvQiVG7yQ2x06hLSF5kmnGHJ0aEkCgOMA2dVcpJQo7G6crM9Dpd
         Bqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753873067; x=1754477867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dey3O+8JYJ0+DC9nws58D9CFVLsgCTJwkc0ezpPGS4U=;
        b=eflTeLRupKBEchKc+BH8EoJkv9FlkDm8tfi3SdscNX8FvodN8JC0J20lFy2wY68o7w
         sgFFi7JatLgchTtBcnL1O7ZEcbVAUt2nV3oIwpIglm/cycNiZHH+iveXqHODQSOvaEII
         MY/vuemmKg8/I2g13A/j2uzI9/4Pxd9AR2z/W9eaU/WccUFLdEjlflKnfKw+GqZK9Tqz
         GmfJFwezjLm/eFP+AnoJtwdSIXYToku9MF2hKW7MJBjCtFymP+Hk/egB8x8/dI1KAXB+
         XLeIiGoLuuuSpO6rPWaGAG7AXfx/T0cASss7p6QceuCWV1ZzYyj9waSQhb2T4XEufnms
         TZoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO4khFOyTDyX/qlNjZoniENY9i/SOpgihLdmUl54uhQAVCVwlscc0lpixAjpyb9R1y+Q7kmcfTzTo3wW2Kgg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2qXM8+GrfXAfu0KpAfcZG77gKiwAOKdb6M+JybwbBEzV7SXYZ
	C7x6FCmYfpr+5X9OzDBzFi4Jxy0UpMqPgPCGvQnG7WPj9g6o5rs7myMCRBAGMEilIIU=
X-Gm-Gg: ASbGncsGvsm713rNlTXgnowItLKXB8MlcFjF6x5XBDAdUrHqXi+WwkFLk1n9Sti5VmQ
	mD9bnXh0XMxuDn+R1jfDbd2lzJ/bz4IdKjLqm/HAxPMcjFFsvdCxRv2JYdRVIqjmYc/NMC8IXjF
	AFSnfrCs8vJlcp7rScIbWfSl0WoJFgzKEWltqsavkaWj/xCyJqCTIv72LJbtNXHLhf3B8HWZpHz
	oIUOaNWa/henFToFORw3wTSVZgh8Gy//OyO9Quy63hNPaWzxLPdzflRmsgM58XdpHxxsgGe85Jd
	NUhEqBzxSoDCfkIULVZ7JK+lrylXnp1DVzapSIlWlQBUC69e52pdeRN/mC2YRjJ9Ud4CtkshycY
	A+eLfLtkL1T0kadZO60ON9R4=
X-Google-Smtp-Source: AGHT+IGLMQbx3bVJOXpmSkSx907QNjU8+Ld7Du3dzmjXKj+AuNh+yN+/PiipqFf54/jcg5ZF+q9LkQ==
X-Received: by 2002:a17:903:90f:b0:234:9fe1:8fc6 with SMTP id d9443c01a7336-24063d8ba20mr111820815ad.18.1753873067186;
        Wed, 30 Jul 2025 03:57:47 -0700 (PDT)
Received: from localhost ([122.172.85.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ff1edf4cbsm83526835ad.184.2025.07.30.03.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 03:57:46 -0700 (PDT)
Date: Wed, 30 Jul 2025 16:27:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Bill Mills <bill.mills@linaro.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev, Sudeep Holla <sudeep.holla@arm.com>,
	Bertrand Marquis <bertrand.marquis@arm.com>,
	"Edgar E . Iglesias" <edgar.iglesias@amd.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [RFC PATCH 2/6] of: reserved-memory: Add
 of_reserved_mem_lookup_by_name
Message-ID: <20250730105744.w5arednoluxufvio@vireshk-i7>
References: <cover.1753865268.git.viresh.kumar@linaro.org>
 <feb4591cc48c70f9790c3f4d37c149fc336c3110.1753865268.git.viresh.kumar@linaro.org>
 <b32b9698-0254-43b3-8109-ee8e37482bae@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b32b9698-0254-43b3-8109-ee8e37482bae@kernel.org>

On 30-07-25, 11:46, Krzysztof Kozlowski wrote:
> On 30/07/2025 11:29, Viresh Kumar wrote:
> > +	struct device_node *child __free(device_node) = NULL;
> 
> This should not be NULL or this should not be cleanup. Follow coding
> style for cleanup - constructor must be real here.

I may have misunderstood how cleanup works, but this is what I
thought:

The cleanup is defined in of.h as:

DEFINE_FREE(device_node, struct device_node *, if (_T) of_node_put(_T))


Doesn't this mean that it handles the case where `child` is NULL, by
not calling of_node_put() ? So it should either be a valid constructor
or NULL and not some stale value.

> You probably wanted scoped loop below.

Ahh, didn't realize we have that available.

-- 
viresh
