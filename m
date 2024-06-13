Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC846A34F
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263279; cv=none; b=nnxjMsNbyzB1DY8K2b4lCPFUJHm98IGrWLepASd/jacSRqVbn5hGBDdtCSciU9/av3JFGhnJ7Dl9DBzwSfrei+Crce2lHdHMglM3024mv8SSlLxxlKBDN1eAP6Og5C/JzbF8EDI4jqd06HkN+F1O+GF12oyzIq3ZYhyWGwQ8jeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263279; c=relaxed/simple;
	bh=l80RjXdZw7gxCEOaUJxc6adU9RUoluvmfgHKiXUbHxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5a+s265uyoJGXiY6eO1pE0alk6DQetLnudkJzug//m25hGvPhYQ8afNKcoRpcnFlO7hso5UEwmf2tszhCtKdlXJjxPrSbyQwVUpUQdJV3EsFnH229UBbu3l81ZA8mF96U5Wr0G0gRfXS7EF/uBH0QEVGhcavsTpryW5m5ThrmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=PtPPFIJn; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="PtPPFIJn"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6283340BE4
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 07:21:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iO7QEbwFLSoP for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jun 2024 07:21:16 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com; envelope-from=jiri@resnulli.us; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A3BA94016D
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=resnulli.us
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A3BA94016D
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=PtPPFIJn
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A3BA94016D
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 07:21:13 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-35f2c0b7701so396810f8f.0
        for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 00:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718263272; x=1718868072; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nhdTMjtoIXZFugvUtXucLNLZ+wuL3jj/Mf2FujAvEdI=;
        b=PtPPFIJnrHMXcLbaDKn1/r7VmaPd5Fq0mvs/+C6/teLCSChrLsUWSQ1o3nMXKlkOyr
         Tgy0xI5QadlbXld6ssjPWfnPbXex7J86qH84TgnC5RQ5ZkHkJ+Ai+MoPdlsi9sfbdUCJ
         LjHw3Iyfj4TrEjV5B3yEV3xKMt7v+aiOMwxQZyOM+2CfBlcyoxHGY8ezjg5LKnDKFLjT
         C0HyI3Nzps3lWddND+QV3oO1wz7aJR7fF2zuqA5gvparrIGuWz2H69M6m4tqsTJQAIiE
         +xSgfxFIyk+Hb2WfLd1P3//Y1Xe0+CjmeU+gd809i6xcaOTeFefkRC96RCYHMnyM/gKA
         XMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718263272; x=1718868072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhdTMjtoIXZFugvUtXucLNLZ+wuL3jj/Mf2FujAvEdI=;
        b=mkQBIltPGYsfFQogO+RL9p+547EKnLYmjtNVHIxsLrI4O6M8I0pvRbUgzxvIjzeI7M
         K6ByV9wL6prQ/uys5EKE/BtYD6QoMlhtIiPSXqKxOy1zyDiA5wAcXES8wWt+rnJvDeKu
         8m/TJeC+CtpuR3oPqZk3EiRQedpyve4HuQw2Axp8i62qfXk8ojTRoymfD6zClJmgzugF
         6NFgumyp8aylJh5IUKb23IL1/dK6UBC7wg7WXKwt0DkLSY7RGfb9QHimIGsgvWvwXUM6
         gp/yKVVyyMVPlHhlYWPHPe2YhcyqpRMH6sEZ76uk3dcJwVoJpvc+Pk67iJaa7cwcRO0y
         ex4A==
X-Forwarded-Encrypted: i=1; AJvYcCXwy/ZRk3BiSbgGDnfaNgFlMxY//lUQ0zNsLjd/wr1oxnmNeu+Uu7ZhyFARL5VqEYfG0rnzBzW4YDnpdan8npfHcOISmE+xzWFgqEkAN0cnetZhJX8T5q7qSQ==
X-Gm-Message-State: AOJu0Yyq/54RJiZdUAT9It48otsJZWMwmD8CqDSHGaeaFve+OJhHA/Dy
	gIrZe/f18BU+TXU/1L/niHDAKEgTAWDF4Dh8m+H4pVLZNIxweHedQJgGsIksKaM=
X-Google-Smtp-Source: AGHT+IEhPIOPdXqAxFfHuuOD1kWxW9YlJJ2QDiJYUAHkDsdB9olUY85yrXKWxCO/8TkZGGaYlxO5Fg==
X-Received: by 2002:a5d:45cc:0:b0:35f:d07:d34 with SMTP id ffacd0b85a97d-360718e5232mr1590625f8f.27.1718263271467;
        Thu, 13 Jun 2024 00:21:11 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750ad20bsm821833f8f.54.2024.06.13.00.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 00:21:10 -0700 (PDT)
Date: Thu, 13 Jun 2024 09:21:07 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Cindy Lu <lulu@redhat.com>,
	dtatulea@nvidia.com, jasowang@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <Zmqd45TnVVZYPwp8@nanopsycho.orion>
References: <20240611053239.516996-1-lulu@redhat.com>
 <20240611185810.14b63d7d@kernel.org>
 <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
 <20240612031356-mutt-send-email-mst@kernel.org>
 <ZmlMuGGY2po6LLCY@nanopsycho.orion>
 <20240613024756-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613024756-mutt-send-email-mst@kernel.org>

Thu, Jun 13, 2024 at 08:49:25AM CEST, mst@redhat.com wrote:
>On Wed, Jun 12, 2024 at 09:22:32AM +0200, Jiri Pirko wrote:
>> Wed, Jun 12, 2024 at 09:15:44AM CEST, mst@redhat.com wrote:
>> >On Wed, Jun 12, 2024 at 08:29:53AM +0200, Jiri Pirko wrote:
>> >> Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
>> >> >On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
>> >> >> Add new UAPI to support the mac address from vdpa tool
>> >> >> Function vdpa_nl_cmd_dev_config_set_doit() will get the
>> >> >> MAC address from the vdpa tool and then set it to the device.
>> >> >> 
>> >> >> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
>> >> >
>> >> >Why don't you use devlink?
>> >> 
>> >> Fair question. Why does vdpa-specific uapi even exist? To have
>> >> driver-specific uapi Does not make any sense to me :/
>> >
>> >I am not sure which uapi do you refer to? The one this patch proposes or
>> >the existing one?
>> 
>> Sure, I'm sure pointing out, that devlink should have been the answer
>> instead of vdpa netlink introduction. That ship is sailed,
>
>> now we have
>> unfortunate api duplication which leads to questions like Jakub's one.
>> That's all :/
>
>
>
>Yea there's no point to argue now, there were arguments this and that
>way.  I don't think we currently have a lot
>of duplication, do we?

True. I think it would be good to establish guidelines for api
extensions in this area.

>
>-- 
>MST
>
