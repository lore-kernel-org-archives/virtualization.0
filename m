Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE8E16D9A6
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 07:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176963; cv=none; b=gy332NUc4i3/NaMz6PRGXYiW+BJUM48LWMErnL/hOrJwfswFj2pph+/NOYTg25N8PzdJO+cBUO9XE68cFz1cKL2waEAnFfEymAAccXIkwp/3Dl+kH4BelS+Cr+2LyOm67BEibJGv3xeRD/EdyTX8CfkU7XeXkBBhJpWOKBbkQi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176963; c=relaxed/simple;
	bh=wkDVA2dK3+U+cA6W49NHBtQ20kiOyRc5qnKumZI2mZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beD42krBa4nL2lBTie24F73XEi1SvUVd+vUHlDWI/STN0c65VvBn7gpAQSzw1eyoEal+Di9ewyNbPeDq6iQih/s1uSYZgF5Pqxik9+T3GljkJoi6dLg8kbU906WEmJa8v+J1jkzMKKhyvmxbyg9t+kt50YhDjPt9MyPzYbZAZNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=reSjwdF+; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="reSjwdF+"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F6A9820AA
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 07:22:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Pj-kl1_t2AJ for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jun 2024 07:22:40 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::229; helo=mail-lj1-x229.google.com; envelope-from=jiri@resnulli.us; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0AC4381F15
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=resnulli.us
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0AC4381F15
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=reSjwdF+
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0AC4381F15
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 07:22:38 +0000 (UTC)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ebdfe26217so28818481fa.2
        for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 00:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718176956; x=1718781756; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XyAaGEtFFwkdm/QpmeEncAmUxjsc5CcFkHBcrT1qbjY=;
        b=reSjwdF+b2B/BxPd2JkxssG0uibfXj8GFaP6WhAkGLyjBBRmky1iLVCk2oPJ8DAlYL
         SHCyCftfIRwoLIjgN14LTYGojJZr10bsOzHBEUPF7RXAuFukn91W7E79ROeqP66iLJGs
         iawARfPyt1NsmCq0IkfnRhC4hON4tKAXD8ymqHEmksXG3+XKMmRTDg3CNNPQNrD8xfFb
         U/AP5fV2icbft1bO2+fr3pR+mhxa3/2Mbuc7vWDa3PLs1NNgWveCwMJbKqmCQwWL6LKW
         EBH2+M9EAgezNQqcfYwrT5FsnujbcKHaIS1luKH0gQZwgBUX51AyNPHmqHYFmA3FB0rd
         liyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718176956; x=1718781756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyAaGEtFFwkdm/QpmeEncAmUxjsc5CcFkHBcrT1qbjY=;
        b=EdJDGrK1V+KUgafk7vkEcKIByNFyaXT59DHvq5spJ3UUW6b+/jxaHStJLjcG+KMyxr
         pSYDk95SZxRvOd1qLVoCGqIzIMINkdUYLY7x+PpDfCQJkfThPYCuVCryNPqXDirBcwx+
         zz+IMvcGE4YrRzH3Qb/1cZD5z5swJuSZisdW63YPIPGfi2bdQU5wXf5z5yqpXE7AouWj
         HSOpJ5OLm/83ikpVPDWjNoqb1CuQU9Sexw9HW5yfajuf+NpnT5ASbOkVO1ixJeqHYH3Y
         wy5SaxhJF0HVF+9c74LwqWclVosyQFtirrKSsqHjgidpRn8Dx1hximmgnatKBoCsi29i
         Kfbw==
X-Forwarded-Encrypted: i=1; AJvYcCXlDB5ii3XphMBg7Rm1V0xJupZ+sEgw11rGDWTgd5SJZ+ify6QkAjbpJseAxS5hPth5tEa6xTbSGtupbvLlMIC4fYDq9rt5zVBFsRIbaE5dsG/SKPjCDfV3mg==
X-Gm-Message-State: AOJu0YyftF2G0WOqLzmYlWI3Fo5wDzpe98EcVHQzt+hX+ytrh2Xzxafz
	ZK+2LO+Xxm/Ll+c05ZZl0tIiszaFeIHqX6ZEaDbTJHkWwoehtXuagYr/unf2ufs=
X-Google-Smtp-Source: AGHT+IH7lMBz0iqDSWgr4Qo//hA7IRWAfAG/YjDjdEYPujMcic/KlfaHdqUt7roVwGJmVDixv7uEJw==
X-Received: by 2002:a05:651c:8a:b0:2eb:efff:7729 with SMTP id 38308e7fff4ca-2ebfc8ffa4bmr5282021fa.6.1718176955743;
        Wed, 12 Jun 2024 00:22:35 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1c958f9fsm9730922f8f.38.2024.06.12.00.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 00:22:35 -0700 (PDT)
Date: Wed, 12 Jun 2024 09:22:32 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Cindy Lu <lulu@redhat.com>,
	dtatulea@nvidia.com, jasowang@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <ZmlMuGGY2po6LLCY@nanopsycho.orion>
References: <20240611053239.516996-1-lulu@redhat.com>
 <20240611185810.14b63d7d@kernel.org>
 <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
 <20240612031356-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612031356-mutt-send-email-mst@kernel.org>

Wed, Jun 12, 2024 at 09:15:44AM CEST, mst@redhat.com wrote:
>On Wed, Jun 12, 2024 at 08:29:53AM +0200, Jiri Pirko wrote:
>> Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
>> >On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
>> >> Add new UAPI to support the mac address from vdpa tool
>> >> Function vdpa_nl_cmd_dev_config_set_doit() will get the
>> >> MAC address from the vdpa tool and then set it to the device.
>> >> 
>> >> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
>> >
>> >Why don't you use devlink?
>> 
>> Fair question. Why does vdpa-specific uapi even exist? To have
>> driver-specific uapi Does not make any sense to me :/
>
>I am not sure which uapi do you refer to? The one this patch proposes or
>the existing one?

Sure, I'm sure pointing out, that devlink should have been the answer
instead of vdpa netlink introduction. That ship is sailed, now we have
unfortunate api duplication which leads to questions like Jakub's one.
That's all :/
