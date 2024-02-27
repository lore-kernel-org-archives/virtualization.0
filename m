Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A671535AE
	for <virtualization@lists.linux.dev>; Tue, 27 Feb 2024 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049603; cv=none; b=LjoWp61lxAzpa/iBowlSeNwPbDEFm3y8QkOWruy8TWQiMGHmwcrIicCLowFbQ8+SZ8XEK1oc2KCDDA89yjJK6GokRTR87utGdAJGwNhmR4he+e5FA8tT0bTDF0S9xt5Dl+o3P458jp+t2QsLUXzR0vwi0PPukIMMLFVSihoGRiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049603; c=relaxed/simple;
	bh=tKB3i2ULzUxqcZteb4ZQczEAibcM9FOTotdV80h3GfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YR9ivHxfhpA0uPE+kaZmLUH0zl4efCItk7SQSAO+Ds0TcWvs7I7iBPWLmbAUxeE0dqjq/PBYzQuOsmjNLSx1m/2F454wTdM9QK5LyrpajePFMEMNseusoedSNTk6leF7Fw6OAGnccLxrlFI6KOp/6Afw5d7f3MWwNS+5dvAgl1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NajQPw57; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NajQPw57"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412a3903586so18677555e9.3
        for <virtualization@lists.linux.dev>; Tue, 27 Feb 2024 08:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709049600; x=1709654400; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3y4We/I/OAkRE57RPqipAeKw/rV+o/vnjOiV2Pndg08=;
        b=NajQPw57PmnYV1qYRlnbRg2Hud+F1UDrryHbSGOsNsa7rIGmPk1AQPi3hEmyWBvIq7
         EJlwd2TMgmx8injL7EQkqGNNu+WEcIbA/0nc+8Ba3Bbfdb5NY9ox6t+paG0rPzfe+k0A
         rg/K5NLBlXgikBSFcGxJhOhMO/XTNc4U49MMMK4RHJN6cdkcvm0KmbAupt+zlU7chb4W
         XeLWnhGEQf6jh8NLtmUoFviKL9CWN5kZ8iVW9pzLjHFJJh1k71ku0Axmq7JiNSdWG2wJ
         grsoAtQ+7QQ9JYztLA39nuFTKZLAFBN30yXAWyKdo9MT/EHCoItPcpPOIzAFsk6xMcPw
         2fsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709049600; x=1709654400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3y4We/I/OAkRE57RPqipAeKw/rV+o/vnjOiV2Pndg08=;
        b=MRCodTVj8qQPj/ydrtW4RsiP8EG8gvOsfl66E1gKa4qxV1XGugOCi9LyuvsX640kPG
         BdP3bAQwPW6B41xHKJGxtMDV+VO63wCaoM9Bgl/6IxWxr3yk3bYlbFok4Id33FVqZItJ
         GMUEH6NsL2BXrh1zA3kneXokUo8did0Y4pBw870oVFKGw6hwyMCCr5ydu1LnM+m0RFUc
         t55yUHzBzJA+p1/eIDx9htZy0wbHiKVB1Re4ZiB5oZjimWg6tLNbNtg9E088YaxnJCJS
         gsOCP4Ce66E5ECEqLq+bugqtbP6DRYgQfUDn4l0J+ub/FbwLBymJW+aSP89OBlUveT8d
         D0Vg==
X-Forwarded-Encrypted: i=1; AJvYcCV6VPEkhjNcUdf9IgvOw6Zbdi0gfl1RFZW8CsF6jeQGakggOugr/p4zS1j+FH7m8anj7oY5nl8BJy0dZVn/AbJNCzZO9AcWLlSWun20628=
X-Gm-Message-State: AOJu0YxWjTmKw5tzCH7RspeMg/qO6J3X7KcfsXdVyMnmt73iQsJnlU85
	Lww1Xh99iGZ69YJtOgjOz6eI6pegQtzTjtOkZ1AXp2XGQsNcZjreTGOIuu9OyRI=
X-Google-Smtp-Source: AGHT+IFN22/PPS0qL2fxWHOrSnH0K36g5mA/lXRY/+/guJN2/bh1+PTY0kVY+08pzvReMFEyRZLSSw==
X-Received: by 2002:a05:600c:1c8d:b0:412:afa6:cf3a with SMTP id k13-20020a05600c1c8d00b00412afa6cf3amr1073126wms.32.1709049600456;
        Tue, 27 Feb 2024 08:00:00 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 20-20020a05600c22d400b0041069adbd87sm15255037wmg.21.2024.02.27.07.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:59:59 -0800 (PST)
Date: Tue, 27 Feb 2024 16:59:56 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v3 5/6] virtio_net: add the total stats field
Message-ID: <Zd4G_GttG0XtQ0wz@nanopsycho>
References: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
 <20240227080303.63894-6-xuanzhuo@linux.alibaba.com>
 <20240227065424.2548eccd@kernel.org>
 <Zd36oZMvIvqtNSzr@nanopsycho>
 <20240227074117.128af8ca@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227074117.128af8ca@kernel.org>

Tue, Feb 27, 2024 at 04:41:17PM CET, kuba@kernel.org wrote:
>On Tue, 27 Feb 2024 16:07:13 +0100 Jiri Pirko wrote:
>> >Please wait for this API to get merged:
>> >https://lore.kernel.org/all/20240226211015.1244807-1-kuba@kernel.org/
>> >A lot of the stats you're adding here can go into the new API.  
>> 
>> Can. But does that mean that ethtool additions of things like this
>> will be rejected after that?
>
>As a general policy, yes, the same way we reject duplicating other
>existing stats.

Makes sense.
