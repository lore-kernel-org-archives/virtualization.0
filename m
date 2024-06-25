Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874F87344F
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719302512; cv=none; b=T4FQ4sJeuCTbAaJSyzLnHQ3eBUyeey1oidcZUnOW8R2h4GKRVZv317snwXq+EYvPAoe0HM+Ee7p+wlYHTR3AWW6rUGhZogTy5h6cAU5+n5rr3yodQ2+q+HuYtATqWSFyaI4AFk+di89Mrc3u0QBfPvhAKEZ/9a4MlXMuB3Ql+po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719302512; c=relaxed/simple;
	bh=0fhGObxG9tVPvis3PgH9PC9k8qlnj5mkCtcm4WjCr+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbMmsdc9E6OydD12JxXMc5wXhZ5juCcMLJzc9WoIVouEMHz+XM7UHeDp16Raht99bQriGEFNcRnnOcI54Zf2mGNk2ZEuSdLN9wEv6HSY+qEAqCF5nNRLtRTxXMl2UbQcCK1w61N5aJ/Gj3cUGIjBp+6Xmkg5u+1z6IxPAD+NqW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=O9TYX9Le; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="O9TYX9Le"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-424720e73e1so42968875e9.1
        for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 01:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1719302508; x=1719907308; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=faZMm6wn9oNi+6uOI1MFNszvuhnnMH3enCbMeB8AFcA=;
        b=O9TYX9LeBOgweR6escNRVuw0r5UwaVbhkMVR3AhCczhu0ZagPVD4XwXKKz35vhl7iI
         9v41yla72uub+gGWyG+eeI6Z1HvNSBhwSXwS+SzcS6SR0Bo3Ir8jrWqVH4NLYcUQInv3
         HG3obfbV3BOPOd+fOL7sbbJtAIeWHI+sSaw94Jb79CQ++JoHSKXIRvCtVOKTFw0ZUT1d
         ceQA0PkD3nK5nKLiC+uvCHBlYgTdeaG11JdvJbQsa4lc5TUnl54meVTWk7ysHo+LfPsg
         aPoA3olPnT4h0piFXZWUGYWZNcZbJokJBhISaDNUyeDNimYqDPn493rNVyOtwXbjaxYB
         6/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719302508; x=1719907308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faZMm6wn9oNi+6uOI1MFNszvuhnnMH3enCbMeB8AFcA=;
        b=poLNmdwCc6qyuBXwRSQJFZDcVLk4LA3mPST2KqaKvsbSekzYLXBo20IGWrYb6zJKEL
         nSrObtRxY7Ups+C7Be7TXa9n4dOwBFLxIF9eSCX/5lp8mhRRyo3qRYA7R0RrH5Xi4ydL
         1cYITgAkos7VZsPGH/QvJWRSXWeY8h8RC41oxF+CxdTjRiYK948I4ol1rYY76VThV+Gu
         A2upG/Sjn1ClMW0fvNATJOLvY7B1zc51vwgVxb10gsfFcnyj6hnBWDguRVmwxtPnkuX9
         Z3r2h6EYdfIKIGsUUsE8NNbZutQ0LOrIgmvxhr7HS5QS7QiU3+MQfj3zcoV6FN/cHimO
         t9yg==
X-Forwarded-Encrypted: i=1; AJvYcCVhC2xcrw2N6xaYpQmJF+VKPBvr2SP+i9Nf0/W0Wu+yNJiHz940e0g+2YZqTuZU5ZGz1dqOzHPQlagJtdYU7xCm8BlTaP1ubH8ptFCtqxc=
X-Gm-Message-State: AOJu0YzDsYp7b1+KWQ8P+NcXcIKPNTrsZV2tjRleU7NzXk2Crzdoy9w5
	LpoqXFqlQXZKNsKCdcir7ApT+UmjzvZSvUrcj/U5/Y7xJ0A3vB5yFcmMqMKAapA=
X-Google-Smtp-Source: AGHT+IGtcNNBg8Szf0G2M9VtLznt4Er4DyA+ZNTVPHwGNlqgJattYea/PQ2VGo6hhozOeRF2fOqX1g==
X-Received: by 2002:a05:600c:3589:b0:424:8f97:8069 with SMTP id 5b1f17b1804b1-4248f978134mr35944265e9.30.1719302507488;
        Tue, 25 Jun 2024 01:01:47 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424819227a8sm167916235e9.48.2024.06.25.01.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 01:01:47 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:01:40 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, Heng Qi <hengqi@linux.alibaba.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	Feng Liu <feliu@nvidia.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: Re: [PATCH virtio 0/8] virtio_pci_modern: allow parallel admin queue
 commands execution
Message-ID: <Znp5ZF16FZOcr61X@nanopsycho.orion>
References: <1719222832.5704103-18-hengqi@linux.alibaba.com>
 <20240624070832-mutt-send-email-mst@kernel.org>
 <Znl4q_ArglG1aqPv@nanopsycho.orion>
 <20240624095239-mutt-send-email-mst@kernel.org>
 <ZnmH-eMBfsPkDpkd@nanopsycho.orion>
 <20240624111347-mutt-send-email-mst@kernel.org>
 <1719281486.8829272-20-hengqi@linux.alibaba.com>
 <Znpl3lrArGU8EdFQ@nanopsycho.orion>
 <PH0PR12MB5481409E517CD45449CAE1FCDCD52@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20240625032753-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625032753-mutt-send-email-mst@kernel.org>

Tue, Jun 25, 2024 at 09:29:25AM CEST, mst@redhat.com wrote:
>On Tue, Jun 25, 2024 at 06:41:52AM +0000, Parav Pandit wrote:
>> 
>> > From: Jiri Pirko <jiri@resnulli.us>
>> > Sent: Tuesday, June 25, 2024 12:08 PM
>> 
>> > I'm working on a fallback where admin queue and cvq would share config
>> > vector. Lets see.
>> 
>> Cvq or avq resulting in performing more MMIO reads of the config space is not good.
>> CVQ and AVQ sharing irq is good, but it should not share with config change interrupt.
>
>Well if a hardware vendor doesn't want that, allocate enough vectors
>and all is well. Your requirement is harder to implement because
>ATM cvq isn't special from virtio core POV.

Yeah, it's just a fallback.

>
>-- 
>MST
>
