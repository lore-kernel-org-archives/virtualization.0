Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83126169AC9
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 06:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718173805; cv=none; b=qEsrDSZFKl4vPkYKX32xHt39oYpCRo2T6OvnhgWy307Pm9QROs/7MBY43JRK2DBNCWbv357tAEtPLtlp2xb63aFFaFanTqkhsJ8WUMbKcshlWbvMwAWSGl/7TJ2gRElOCcOJUrCtyDz9IXPXv5sSzfR8SkyLdXerC0Vi0w0y+H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718173805; c=relaxed/simple;
	bh=Dw8KIMMn+F28OFpTAhQjzDCM2P9ytOTncCAHmd6nIHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBmFrOiD3qU8nzXBMppbAPcZeq409cI5P3pNXWUagZCX2J8UGEfKJiRqeZCFj+Pl8LF5Ey1Cb6bM1wtOVvy3VLdREbEITQY6/dtZOm0rqj80TONidVuhuA3xqKHZoYHeT70vh4jT3qzaMuMa6LTvxvekrDf2sM+ZOlV5iWbU1FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xIh97Zbq; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xIh97Zbq"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21E5B608A9
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 06:30:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FMArhDKAc_lA for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jun 2024 06:30:03 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::136; helo=mail-lf1-x136.google.com; envelope-from=jiri@resnulli.us; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 181126067F
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=resnulli.us
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 181126067F
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=xIh97Zbq
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 181126067F
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 06:29:59 +0000 (UTC)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-52c8342af5eso3652077e87.3
        for <virtualization@lists.linux-foundation.org>; Tue, 11 Jun 2024 23:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718173798; x=1718778598; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5LH8e3qpcjluJss2hNPudK/MPhEV4gW+gLGQ/ZThC0k=;
        b=xIh97Zbq5Gz6+rdXwknCTk3/CJJiDmFxyuaY2kOpq6fw1F+bxYikc7805HR43wV3EV
         a8F88XOKkNPF89F8X/86ibzEuI/hMKwKWxBpodhmm68J0UPY+Yubqe0qufurFywIIOii
         KvHTdg+qVDqo872eU0TQ+zfG7mFfsry28FUw6cwN5vzF+GyT4/ZbI6NdD0zvC7zwcL+j
         a+LEy55N2kxt7nG4Ej7YfawcBP+ZcUmtrw/wq2OWUpooZKSXTsIT5UDOLGib5JCfFSnz
         jI2+18YhdeLuDzP84dFg4uBws78IE305kCvaaBYOnXek9mHD4KemggFHRSnFZf8whXzG
         oCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718173798; x=1718778598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LH8e3qpcjluJss2hNPudK/MPhEV4gW+gLGQ/ZThC0k=;
        b=K+g55yO4/IqF5VgCGwJPaEM+G01rzVmlktE2eC1IJQafx36Z2wrdb2qjxYvEdK5AaH
         bfKwtKpnsepD/Fyy3ywReLd7K54x3tsdc6A2sJIB6L6M/C0i0vNP7aVYqNZuKnU8XFJH
         X+zJLj5z1/OAxFyl0fiIwxyXFuZINmX4LwwuIftW641/Vg094CDxCuyD4KKE0x6pMu3I
         qdsUakQqh8iEoVTUEU6QAammQLY3W4jIBUC2u59vff2rnsMAQDhE1Y/y98uX/GL9YV5A
         8yZpJiN17V0nszd/9bBd+ey0RTaEMYpKlsvCO8+hPo8LUGtwcPFzDwKVoADbY8GwB7c/
         q6cw==
X-Forwarded-Encrypted: i=1; AJvYcCUhadqisxzzsOqNZLyHoKoMNeRNOe72hdM5Sx3b/RSHwTY1tvudYxPGpFxnYKZJH38e6v2//6pl6ywkyBy6kE7EQBQHEnNsaqPfbjNzkKQ/NAKZzp4ieASeaw==
X-Gm-Message-State: AOJu0Yw5ZL8TFRGudi/poro276PO14uQop9aDRyMVzFTBNCCIUhK8lNT
	+hQt3uBZIWw0EnLfmCxxf4k2M0AFzRivCUmJ1xneFG0aX1QxcUePnpsQkJ54DzY=
X-Google-Smtp-Source: AGHT+IFp/68HMGdtt+tnnGcItdNkBhSFo46K5V4Iw0bDMZtwLsT4wVHxdkIyBopwMlohpTWvO6o3cQ==
X-Received: by 2002:a05:6512:1313:b0:52c:8abe:5204 with SMTP id 2adb3069b0e04-52c9a3dbeffmr624591e87.32.1718173797669;
        Tue, 11 Jun 2024 23:29:57 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe75ebsm12495135e9.9.2024.06.11.23.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 23:29:56 -0700 (PDT)
Date: Wed, 12 Jun 2024 08:29:53 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Cindy Lu <lulu@redhat.com>, dtatulea@nvidia.com, mst@redhat.com,
	jasowang@redhat.com, virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
References: <20240611053239.516996-1-lulu@redhat.com>
 <20240611185810.14b63d7d@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611185810.14b63d7d@kernel.org>

Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
>On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
>> Add new UAPI to support the mac address from vdpa tool
>> Function vdpa_nl_cmd_dev_config_set_doit() will get the
>> MAC address from the vdpa tool and then set it to the device.
>> 
>> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
>
>Why don't you use devlink?

Fair question. Why does vdpa-specific uapi even exist? To have
driver-specific uapi Does not make any sense to me :/
