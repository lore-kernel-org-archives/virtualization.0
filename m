Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2631077F1B
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870343; cv=none; b=oSE6H89aO9IOFwGsXa+xouj7TxLqw42rCvGvz49/zytIdGDWkh6P2DtcfjELUfVucRD8Lg2oeipvwJL0FghRYVA8rIc0mSMBFry++q3aKp0dTZ7ka4f1L7t4UzPCsN70kbXx+qhioaOjSHTmwHH0WI+viivbOcnjW+H/AzUrgMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870343; c=relaxed/simple;
	bh=FHeGv2YLNVirWB6r1WEf+deKuxbcZlAeA3VH07AC2js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaVlgzJzMgrPEouE1t9/D7sTyYrUZgqSV3qDdcSIUui0oJfSCB+UFDBWdTU5KaCT6Ziir/T5Ugz15wLsQy8zLg3RVLJhFgTSSzRXiIPPZbdBHyfMfNIN7QKB2H9n3lfzkA3O/GmRP8PkMnLXcpSIAVKuIKfiTDON9/cZvkiTcAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=FaxCvhD4; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="FaxCvhD4"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a524ecaf215so559236666b.2
        for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 04:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713870340; x=1714475140; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FHeGv2YLNVirWB6r1WEf+deKuxbcZlAeA3VH07AC2js=;
        b=FaxCvhD4DFOS04IsbDYV8l96nd9aJ4ro/BQi2MoAWpMDn8TQbApAJu/7bDBhb6l8UJ
         s/ZqgERsvAGSsMohr44W90WMTu00QVCZmEpk3Db3RkOKHaiFwdHJCpcH19RB0jnO1ums
         VBGOjhCb3jvOpvzsmmZvT6CPWKU1UWqoOzK2f5eK0FPQsgGSzmkgVQaeVcvdSx0WcjyC
         ZqxgEIwv2ttvOVzBP6MBYs4lZsu9LVKf1ghuhYIXoPHzvnyyNE43NFgC6bDWNtKwIGjM
         sFpOhnmwY5JB/pxdEsyoLfkmHlgYNGY8j58hXP0TXFj+X7g20+rLWyEaEasIbXmfT5oY
         YNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713870340; x=1714475140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHeGv2YLNVirWB6r1WEf+deKuxbcZlAeA3VH07AC2js=;
        b=Qu88ckSrvtCMH34Hit/kquWO8RvUNfEO1LrNdardkryo1IWNgfPxMZS6IuTfT9S6lK
         tQUU0lJU11jnKOL24/+5AdXuf89ceVwGzK3+haHyNcs/0CsyqXexLP1HZqMER+UDM5NE
         BrrOF1sxCli4LQAD0p70x18fV+WFjLwF24hfRIPR6SggaL/2R2Y1/sAm0GHcNkOTfIRL
         uEaELQ2a4ug9EN1aF/ucYgzu8s4MuAZGhewzHf8pO4+H+fPfov/Hm0SV8yfVt/oSn+nq
         xnkLZpnTs34kljKyiwoFG4Gd0tidMihk/yvX0uwJMULmuyrXGuZYRizpxeXyhYzldf3j
         dk1A==
X-Forwarded-Encrypted: i=1; AJvYcCUSMC5S0iI0FsI1YG0oGeh3mU8jaP3xN57IUPDg2dIZYu4/nb1PG8sv4zc2GADw5rMSy9dXjccAdE5kAqd3vtcdwecuwFfX8MR160B0Iwk=
X-Gm-Message-State: AOJu0Yy5dS3/w84BCHdimM077KRUtO77xAAsJStTKA9i/At30TBsyGEm
	HBOxwsBwFJTNySP489Vrjfr/T6RiZ1UOFLV5lfj0ZAmeQoFR8wvJ85nedGU8Q14=
X-Google-Smtp-Source: AGHT+IEMcFz/QSj8GzY/L5b8JyCjXa2e5imQLO79iWsFiejOl6cuc6LfL+IZRllbwNiKhQ7f03Q4yw==
X-Received: by 2002:a17:906:3897:b0:a52:42ce:7da6 with SMTP id q23-20020a170906389700b00a5242ce7da6mr6837988ejd.10.1713870340375;
        Tue, 23 Apr 2024 04:05:40 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id c26-20020a170906d19a00b00a55662919c1sm7049435ejz.172.2024.04.23.04.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 04:05:39 -0700 (PDT)
Date: Tue, 23 Apr 2024 13:05:37 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, parav@nvidia.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, shuah@kernel.org,
	petrm@nvidia.com, liuhangbin@gmail.com, vladimir.oltean@nxp.com,
	bpoirier@nvidia.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v5 repost 0/5] selftests: virtio_net: introduce
 initial testing infrastructure
Message-ID: <ZieWAdmg8xfIyKiu@nanopsycho>
References: <20240423104109.3880713-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423104109.3880713-1-jiri@resnulli.us>

Please ignore, I messed-up. Will send v6 tomorrow. Sigh.
