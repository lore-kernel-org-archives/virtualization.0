Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1159D14A60F
	for <virtualization@lists.linux.dev>; Fri,  1 Aug 2025 06:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754028160; cv=none; b=tyV43K0XeGsnevHDnwsDkhZuMCjtxFrS78J82MeQo/hHM+H+jZQ3OiGVvxQa3C3yQgbTVP2AgwVdnfxRZLL4o8yNqFsPIrUHi8HvdfyCetsz+8/rNDeYPEiQaJkbyraGepGYijACV0Lg0J0VNmtqCTDgE0bZ8FtV2mgif3PBnyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754028160; c=relaxed/simple;
	bh=//2vQw+cUbGbrW44zq/SOMI+CYziL7FvtoNZUM7AIYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksKiZd4l4vYVK1xS7yOo4xkbBAqXqtLdM75nP/Cx0lMtpxpBWc3mx8yFmxuTtnJgh9mRf0d/gq63/sCNDbhR0CO10MmcblBrkqRHRYhJyO+v0LLtM5B2LfLcOO95IVv/xpHK0hjCUYM5bcldEpv1QgkzthRVhOpzRdkRSNCuASQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WkPWTcou; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WkPWTcou"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2405c0c431cso18095145ad.1
        for <virtualization@lists.linux.dev>; Thu, 31 Jul 2025 23:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754028158; x=1754632958; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YLSiyGnrFJyz6l0vLF59aMG7JUJUfV+my1hPfRT96tU=;
        b=WkPWTcou85Isct13SVsadKPgEPLie0jll8RPOxdRoRqEg/IIC0tikvw3TFet7o8CAz
         Ik/AaKCLVNJhH4dhgWg0xcFUQh62d7pI+hG7VkKgmTeeF2bfpPYMJ3RgIWlQU48B5SFU
         O8SLtMJNAuvun9uTmRNlgMg2B9kLqB1UWfn/xf7IWrWWcU1Dm8WEiH4+52ijHK98gUFt
         hL1rVTHr6NI0zcb0F5fzp+rZbVYggCvKGkTzyExKxfwIHh0Td3XVWfBXQtsRRXoFaEAz
         0SH6FgK/tVD3tWu53XB/Xj5AMwJgDLHyIFa9wjddAccS7G2Fnwc+IAHMJsN3UkY5wvcm
         RW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754028158; x=1754632958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLSiyGnrFJyz6l0vLF59aMG7JUJUfV+my1hPfRT96tU=;
        b=YJARjrEyVm5pTsjTAeSDsyvNrSTulnd908zFKpv+omVmGla6QsJamOzm5x2qvQE0Wb
         Y/nyUHP7rnDwddBV05/DuD1zkttKNuZX6/H7CW/vNN5ZrlMFJWhQYkSK/kKxcTa6WMKq
         m8oNoXCUGunyw0NZYNl6u/ID3iAqlrxOcHsmN7DY37EV6k37DxJpeIzfKg5N2iXA3Aju
         osZkVQ3o9IH8cnLcnTAEu+aFWXDp07Z3rUBk7WwZPbtzxZGgjfSiiUOij4pobOkhigy5
         KWVEJ1GHvhHZKXI+AMUyCEl2S/j5LLup3K5n8T4cBRlf1dVUFLBOJ2RAH5Lwf4zSdEyW
         Tq3w==
X-Forwarded-Encrypted: i=1; AJvYcCUNBqiaaU+tqJL1yFZARAQTFFkJUaPGPF7J6wfzdkKNKol0raBBJqweyA204Mi4tYrUJbvlhoCSg3syW6FHmg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwL0wY/wfTUywJdKZl5eZbn7ZP2mGabHfhaRQW4zWGVH0ksPU5c
	DEFZ+5HR6AsCY9/K0bgeccLDIoC7YM7+ag/s86AODuuiT55JzepoiNG/LtE48LF+YjU=
X-Gm-Gg: ASbGncuaOuGJAofmJptGt2+vikT36dHf70flqxRcaw5F98hELsUh9F5YfUX8nyxPBRP
	fvxUyUSDGcSO9eHcPpGe2/FCLcvZKv5q0Yd+NruNSceh1kMIdDtcqOYMyB0PMzX7sNeL7A/eQ5D
	3QAGZKZMb8hXwuPUvuD1VM1Gl8Y7tGgYYaFeb/O0SpurmGXPMnWHByWhDtfAX6gh1CIenDD6Fsp
	YEwEShThtFnxH+4iNoSeM3CM8Bcf4Pe1x5RgND6bOU9FQlMNQ0KI/8iiwi1y0Wsh/PcalgcIlaJ
	QUyn8Gn4oyvY2ndDyWSEmieh3Hf7eRiVF/+wBKp0VBfXnZrykZDmd1dpHM2lf8hbFA3vZVMwp9m
	pqtYQ/L9FMDESK8OmJ0F9wqU=
X-Google-Smtp-Source: AGHT+IG+rKm59m6f7TtpkJkR7eXRlTess2vFcE5Gxxpl8KSw3MlEUn76oh5vAQyq+9JPBKJ01jTdYQ==
X-Received: by 2002:a17:903:198d:b0:23f:b112:2eaa with SMTP id d9443c01a7336-24096b23962mr151086215ad.41.1754028158240;
        Thu, 31 Jul 2025 23:02:38 -0700 (PDT)
Received: from localhost ([122.172.83.75])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8977345sm33273115ad.108.2025.07.31.23.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 23:02:37 -0700 (PDT)
Date: Fri, 1 Aug 2025 11:32:35 +0530
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
Message-ID: <20250801060235.coascv4ynfmlzbqt@vireshk-i7>
References: <cover.1753865268.git.viresh.kumar@linaro.org>
 <feb4591cc48c70f9790c3f4d37c149fc336c3110.1753865268.git.viresh.kumar@linaro.org>
 <b32b9698-0254-43b3-8109-ee8e37482bae@kernel.org>
 <20250730105744.w5arednoluxufvio@vireshk-i7>
 <462402ce-22cf-492b-bc40-bd9dbc3a2f16@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <462402ce-22cf-492b-bc40-bd9dbc3a2f16@kernel.org>

On 30-07-25, 13:24, Krzysztof Kozlowski wrote:
> I am speaking about coding style. It's explicitly requested to use only
> the full constructor syntax (see long time Linus' remark or just read
> cleanup.h docs).

Ahh, I wasn't aware of the interdependency problem. Thanks.

-- 
viresh
