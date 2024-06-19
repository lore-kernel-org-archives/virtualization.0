Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4FC7868B
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718784401; cv=none; b=k07qu/CL5o8JXRcYhpZD+6xhwQDhWbAghEQwFi/2rbjuPMlaUA71Uw2hho4OVp2CtIgW+XEaLZKkkhaakCIZt8eghbxJH2CdykMo4MPIz02DtP1k6RyayoeQ2ilF74QhVNIsa18/HiPV4AkRtnaaf4ReGQvYMUqoC6HV07juzws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718784401; c=relaxed/simple;
	bh=NF+TDxOLimYcbEw6uAQv07j9ve818qQDwoSpSKg5yro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZUvKsB2E2wLwd3jnQVKp46F1uc8tExvU4fxHs6ViFmUHASpSEARy41cQyMwq6Eu4nqvLW9MerTcAD5G/tZYdxgb81DERFJt+QjdcSLZ4+Iw5kCy3qKwuFHXEnFjJJhVoAIBhQc6Wm/wQYM329lFOkhsg+RI0dRNThH/bNe9rxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=slwZ+ynj; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="slwZ+ynj"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3608e6d14b6so2628169f8f.0
        for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 01:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718784397; x=1719389197; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NF+TDxOLimYcbEw6uAQv07j9ve818qQDwoSpSKg5yro=;
        b=slwZ+ynjn+YgPQVl4HspqI2qOCvHHZt+3G2sjsdnfrMpQMGvvMxiYaIoTJelWrKqRG
         ijPlQIfy5UwLlSRS4Eg2rhzajd/UttyU46IAc82s3LCGXNQNKbPdnw3D5Qt91i9mv7j2
         FdmF0R1aBnV2tltQD2vm9phtavJJEtgAu1TrQxOe3Qwv7DkTMVYeIsgMe8i9VYAAx7hH
         Mi1ELUhesq+mh4kP2mt6gtnF1jKjCy8DEMoHafeXZAt5RCb09tu31Vdvhc0aLlkxZMe1
         0Ayc8zPbaL806DCvLzUSYjRKOGN05h7V8746pYPROsokQgrMR3dBrf3YfNzAgAkG/SW2
         JaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718784397; x=1719389197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NF+TDxOLimYcbEw6uAQv07j9ve818qQDwoSpSKg5yro=;
        b=gbfc29+43RJtfRSJ95UUQbGmjjyhPU4dX0YzmzRuypFW3aMg2NoDrITBL0c0VfE8EG
         6hgloRAP2XJ6icW2dkkufsYHpmAeKP4jtBlcXcGhuawM0hDCjwdeHRCPkEfC0U6qPUxI
         NwuGXx1x8cUoFBJtDoSz9RxzhlDFwxmETf3DbJzMKoMFx0nPxv+EfzVjqFCyRElPTQJ1
         Nl249BgmfcqntD/tv1IyFSADsZWy35zAhLQUytRb5XjEAJF+5MXqZiWZlNs1liIYyYX0
         +1ULoTLX1ZyRNQXzHCmuRlrtw5d4AEzBNz8CS6J5ywMYPRgG3cruZubqvzNhBmiYe3tl
         hwoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+D381Wzi9NtW0J9odSBjOV9a8/gBcWeC/toysMJ4Cv6WEK2h+lZUu0IVqDHU4Q83SUGqRq6Cp2b06904nJdapy1ct2zajFzDZgLRa+eQ=
X-Gm-Message-State: AOJu0YyK58iM5aGq61Jk7YGufAIa2w45ESHFLCdcgaPP/nLwvYzc5WlN
	i8ZPYgjO3tQJRRV09ECvRiZEM9hejmtrHUMqSzfdipe9SD2/id8j9vEAUZ/ESv8=
X-Google-Smtp-Source: AGHT+IGzOs2ulFgxkg+FZprEYB2KC36mJOMw5IsLgMQeCTrwaE19hcWY83ADjSMbQvpq2823z2q5VQ==
X-Received: by 2002:adf:e88d:0:b0:362:2e9b:f10d with SMTP id ffacd0b85a97d-36319990553mr1404317f8f.62.1718784397283;
        Wed, 19 Jun 2024 01:06:37 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3608e6d1524sm10533654f8f.81.2024.06.19.01.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 01:06:36 -0700 (PDT)
Date: Wed, 19 Jun 2024 10:06:33 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Li RongQing <lirongqing@baidu.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, hengqi@linux.alibaba.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH] virtio_net: Use u64_stats_fetch_begin() for stats fetch
Message-ID: <ZnKRiSeXxXpPgqfC@nanopsycho.orion>
References: <20240619025529.5264-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619025529.5264-1-lirongqing@baidu.com>

Wed, Jun 19, 2024 at 04:55:29AM CEST, lirongqing@baidu.com wrote:
>This place is fetching the stats, so u64_stats_fetch_begin
>and u64_stats_fetch_retry should be used
>
>Fixes: 6208799553a8 ("virtio-net: support rx netdim")
>Signed-off-by: Li RongQing <lirongqing@baidu.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
