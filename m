Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98857E76D
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290025; cv=none; b=ucHMM6dcLQN64ufgiaSEIZPZ4QunHr0qBtKikMETik+C3kXHZa1hBMuSdUaPYYPad38kknzj14rULgMZ2hUKZInmUF4Zy/mncg07IFuzj/3kiYfMnUbIX+oKn4OWswNeNxs2Lbq+TeFFYnV7u6amGzZdanwYGn8wb+FkVdgPYLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290025; c=relaxed/simple;
	bh=1MArYuP6I1dClO6hSyL6b2nGGuXkYlYntxPoE89mMzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrxKKKD4Yk1j3svu5g6PxLmaDixkTui7ZldtFEkyeQdU5KtpqRp7Jzqzu1xtv3M4tOx/I6oWv1zEvRrj78gVtRn1x1BRhlGYCC6SiS6OQNnEHzGRQ1tiLawSJ3xzMJRMT1+gunoj+Mt7p8AoARcg4mlW3zU21HtPkGCdSracnpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=m569HGNZ; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="m569HGNZ"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 605AB402A2
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 14:47:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d-x8N-q_pG-r for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jun 2024 14:47:02 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=jiri@resnulli.us; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BB60B40157
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=resnulli.us
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB60B40157
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=m569HGNZ
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BB60B40157
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 14:46:59 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-35f27eed98aso1047681f8f.2
        for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718290018; x=1718894818; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tEhA82aLo515aHuKOusFSDP7HypmZDcV4M3zBsA32mk=;
        b=m569HGNZ1SWKECSKLKppuLBNq9+66imVzYzrjUIFWv82gHPhEF5I7cPIhGkYecLkUN
         ZXa5oSvdrEYJnpJyPOSADwU3k+y4cRXEORtbJ2mNvlyEqMfLa6Rt65hZMG92Yd+gv7NK
         8ohjbZbySZimiM3ub5gmlTLoC7y2h5XhR4lURT8a2Rb69HzdG4sMM0jougnMZOt/umwX
         T9y/Lte8xhAmYINiM7I2HkhF7L7WVqoGE4r6DFWK81gQUXQ67AiJ5W6z7KZ0lSZaL0QC
         UQuTPnRg73bSUSBREEKS7rumtT2drRosPelc5CMqwqusOJiDP8X1mYE876oqTrkpuLys
         DVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718290018; x=1718894818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEhA82aLo515aHuKOusFSDP7HypmZDcV4M3zBsA32mk=;
        b=Ooy34pNIYiAgcAEsAupQu0ZIf/1nyXZz/YllHYh+5VUWD5j+8HZZOYIGRcZy0Ss06M
         AzySj1MoR7q62C3423MGxF1f4nMTncAjoFjSrujGiImO8IURrwO+2b9Lye4MyXPMoUr8
         nNG9I1QRol6k4+aSfr00qDMzxyhPpj07aoXDN1nx1whQJEzrTZvLKBuU8uAA7l4ehQvi
         eotm7u47mIPLmNb5376c7azQMFOM+AqP4YryxTToBOYoPeU6e5EKQG2RVHfeyPBrgMps
         EJ5hv1fmUfe0lDtSO3RCxEgiu3qtCN/Z1/I99XeiGrsa+eWjnFE+DtADQAc822IsErQr
         ehQg==
X-Forwarded-Encrypted: i=1; AJvYcCXeZSFOvfZZ+by4gsMeSqX0gcqH+9V4PfG05uCGDSNM0NM2hb0l3saPp8af3ivnAZotmSutNlu/GuVC/3E+F56TRGznliJhOkc0A/duaCa4I+5eoiqqKbwlQQ==
X-Gm-Message-State: AOJu0Yz7pDdhO0eonUTND/3cUSr0gPkupRAc8UMOw4ffjFoGgrr9CJtU
	jFvwtufD8pgXclmIGLheLYaY/FEJdji8rcXP1G2v45U7L+4kmGFLMRuyYJZDW8A=
X-Google-Smtp-Source: AGHT+IFslhxHNDMgZ32+cIy2OchmE6E7iuuKQlnGpNTfS9dQJEFOYr+dynThX3TNYtBBkCIb1pwd6g==
X-Received: by 2002:a5d:648f:0:b0:35f:2550:e276 with SMTP id ffacd0b85a97d-35fdf779d20mr5238834f8f.5.1718290017479;
        Thu, 13 Jun 2024 07:46:57 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750ad10esm1888491f8f.64.2024.06.13.07.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 07:46:56 -0700 (PDT)
Date: Thu, 13 Jun 2024 16:46:53 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Cindy Lu <lulu@redhat.com>,
	dtatulea@nvidia.com, jasowang@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <ZmsGXRrSgUbccoHp@nanopsycho.orion>
References: <20240611053239.516996-1-lulu@redhat.com>
 <20240611185810.14b63d7d@kernel.org>
 <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
 <20240612031356-mutt-send-email-mst@kernel.org>
 <ZmlMuGGY2po6LLCY@nanopsycho.orion>
 <20240613024756-mutt-send-email-mst@kernel.org>
 <Zmqd45TnVVZYPwp8@nanopsycho.orion>
 <20240613034647-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613034647-mutt-send-email-mst@kernel.org>

Thu, Jun 13, 2024 at 09:50:54AM CEST, mst@redhat.com wrote:
>On Thu, Jun 13, 2024 at 09:21:07AM +0200, Jiri Pirko wrote:
>> Thu, Jun 13, 2024 at 08:49:25AM CEST, mst@redhat.com wrote:
>> >On Wed, Jun 12, 2024 at 09:22:32AM +0200, Jiri Pirko wrote:
>> >> Wed, Jun 12, 2024 at 09:15:44AM CEST, mst@redhat.com wrote:
>> >> >On Wed, Jun 12, 2024 at 08:29:53AM +0200, Jiri Pirko wrote:
>> >> >> Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
>> >> >> >On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
>> >> >> >> Add new UAPI to support the mac address from vdpa tool
>> >> >> >> Function vdpa_nl_cmd_dev_config_set_doit() will get the
>> >> >> >> MAC address from the vdpa tool and then set it to the device.
>> >> >> >> 
>> >> >> >> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
>> >> >> >
>> >> >> >Why don't you use devlink?
>> >> >> 
>> >> >> Fair question. Why does vdpa-specific uapi even exist? To have
>> >> >> driver-specific uapi Does not make any sense to me :/
>> >> >
>> >> >I am not sure which uapi do you refer to? The one this patch proposes or
>> >> >the existing one?
>> >> 
>> >> Sure, I'm sure pointing out, that devlink should have been the answer
>> >> instead of vdpa netlink introduction. That ship is sailed,
>> >
>> >> now we have
>> >> unfortunate api duplication which leads to questions like Jakub's one.
>> >> That's all :/
>> >
>> >
>> >
>> >Yea there's no point to argue now, there were arguments this and that
>> >way.  I don't think we currently have a lot
>> >of duplication, do we?
>> 
>> True. I think it would be good to establish guidelines for api
>> extensions in this area.
>> 
>> >
>> >-- 
>> >MST
>> >
>
>
>Guidelines are good, are there existing examples of such guidelines in
>Linux to follow though? Specifically after reviewing this some more, I

Documentation directory in general.


>think what Cindy is trying to do is actually provisioning as opposed to
>programming.
>
>-- 
>MST
>
