Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CACD36B935
	for <virtualization@lists.linux.dev>; Mon,  7 Sep 2026 22:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788819322; cv=none; b=VJScPRrvghRoQGqpVk4wLpBgvRwVpcj3bru7Z3iCfz8z0UD+pIRtryfTQFMeeoIw0ev6JVbfXC+C/KNRdi3zt9msd+6KevwhsKSeKeweWTpsm9rZTRYPlx1pEqbkMYIwRNkG9GQjjn7aK00vrgVPUnt+B4xSvFv8Fwvg6ChHzT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788819322; c=relaxed/simple;
	bh=xWQKezu4BREhy3j/blXwxCRCfvwvHIXrTtHnHeeaEXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jk+9zLsI2/mkQwV0DGlNotuJnLNLWaJkijMxwnv2j7DpMFfc5il7f5GwHr3bDosEOybsdyBy1XVC+IRArwzJwY4CCo93JNoC1L4EJX4Y8e5ekhY8PKUrvTAVFCGFRTCvDGPixrO4He0/fTSN35aSs7/wSgprAgvbHQ6QogyEqZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rvuFBTTq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvuFBTTq"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso59734545e9.2
        for <virtualization@lists.linux.dev>; Mon, 07 Sep 2026 15:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788819318; x=1789424118; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oxCw6MZUrUMQF3PxuLGYM79WzM4GNi956bvyl3WEJ2c=;
        b=rvuFBTTqMbT7HVWnkvqJREajodIpx/0NX6nQnooCiGbL4/sGRZkKF0RIWqIAAnoEgV
         m0HnAx4J0VEpqy+pKxTHvsUxjqWe+MrjJ4OifdvWyxmNlzLCmgGYczosCbX3dftC3rqI
         56ilat9Werslc+ONRASUth+5NY3quk/U4xmaEIXngzXMYM8JwnTcXAz5GqdAI3VPhrYu
         0Ul5BE9ktiO2QPJGBjrViuTv4UwiU5WSnyDzz19bcLTzFmprpkMKK0N25d0g7Jv206k6
         SrGbA6/YiG96rg2wkAGYTjvqVpEXq42IyUnvtSb3ca3mNhtUMI2QUZ5tKQ3lj/BIMHrA
         N3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788819318; x=1789424118;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oxCw6MZUrUMQF3PxuLGYM79WzM4GNi956bvyl3WEJ2c=;
        b=oENmL8l5KW4CmoS/0Vp0XpOuLvH8Me9pxxHeW7kvoQJD/SHUI7x1N2nSEYVjFyPKj/
         aZWpHBsHbCccSO92BrdwJHFq5xptMfJncJl/TLdil0KyBgbrw0XQO61E0i8lczvztH1M
         51mXYCT3YwDhIx0GBfsIYCW+++JsSPbeRWotGA77ZK70EbTP/9FkOkpLetCrDTM54g6r
         PEm0PPANJ8dG/CuI5yU4XWDdx5TWED1aXqspDHM/SGPMpl5cL4CVP6tMA+t9KtVbkw2J
         jywySJpCb4AU7crUN+ZJn5b7oBNVhb09hWhO7tIkt+xtTKzHcH19hUw6oL3irI99/oww
         +wtg==
X-Forwarded-Encrypted: i=1; AKwUvBz35cdNX5pWFnxOyhQwP44+ndjIAeByWaEuxJEDRHhn+G/MeelsOlPKYwF4Wql8n1xGrf7PXGuXqN5mhXdy9w==@lists.linux.dev
X-Gm-Message-State: AFuF++lupePQM/m1ohufE/ucofrNfAQvsgB2H+RxP8wvQEgrWP972Hby
	wjK2apQZmWXeZKAxF+iuCHAobZVjEaK55uQhOlZYfJ7TQc2IQ+nzdmYf
X-Gm-Gg: AYBFou2BD5RRtp+yYJ1nejs2wNfRSEg6h3TL4E3lbJ18ZJyRin0FllCpBK8Fo2+Q72m
	HpRtrCAJ20vveLvWvKHGjgJ9PpUba+wzGSbIvNi8gtgHHhHA6yp0ODMYTMyuWoD1wMzyx728j1Z
	OdTWDuq37ZGhMA6RJncQ8NpqiVidKE4l6IgmqWrjn1/iECR248NQ0UlhkW/t/LUJMAx0O3wdZym
	35UO43Au1d19hY1OygQrmZDbQk/jY+Twe8SZZPRn2/wjCHsOj/OcJyaG5DMLeexyv8gmFyIYhgm
	7LMSjRKY2ncCKMN6+0JVdp8fwm6JrGFT9VYh/QS+EKp5ofD3JDt4NM+Jmz0UhN7ie96PmIU6NdW
	W8zFpONCA1wj+2ddmO/D4nomj0bV8eNaf/2qW2QGvbIRvLKuHcFJm3DsNVFLALWC0S80bSVtyiv
	T9954ZfPjf6r8dFMZ7wF3QyxMCozAXNwjqsR0amUkXrAu8d8ipIl6R2JtWiuf3vG6c1wnqC3LKr
	8Xa7BzhFSmKxbCKMTtXdYkhiWpyiO3+3bIhl9XeQS69Vaz/uxqj3h63MVpR8PseHXWJ9VYldHce
	aG5RUsPMW10xKI+oT+G9Xy0UBy57OSkcdQgA3vtVvVcOQphd3s26XzjWT/txhO1ngbtr4iaM+F1
	8
X-Received: by 2002:a05:600c:8012:b0:49c:d818:8764 with SMTP id 5b1f17b1804b1-49cf826818dmr259779075e9.11.1788819318162;
        Mon, 07 Sep 2026 15:15:18 -0700 (PDT)
Received: from MacBook-Pro-von-Karl (dynamic-2a02-3100-b0c9-3601-cdce-ba4b-d0e3-dede.310.pool.telefonica.de. [2a02:3100:b0c9:3601:cdce:ba4b:d0e3:dede])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588394fa1sm29993570f8f.8.2026.09.07.15.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 15:15:17 -0700 (PDT)
Date: Tue, 8 Sep 2026 00:15:14 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rusty Russell <rusty@rustcorp.com.au>, 
	Pawel Moll <pawel.moll@arm.com>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	virtualization@lists.linux.dev, linux-input@vger.kernel.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] virtio_input: stop callbacks before unregistering
 input device
Message-ID: <ap82pFlX8enNG0gZ@gmail.com>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260905152059.89560-3-kmehltretter@gmail.com>
 <20260907174559-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907174559-mutt-send-email-mst@kernel.org>

On Mon, Sep 07, 2026 at 05:46:07PM +0100, Michael S. Tsirkin wrote:
> > Assisted-by: LLM
> 
> which llm and which agent?
> 

Claude Code and OpenAI Codex, each with their current models.

I switch between them and let one do review, the other
helps with implementation.

"Assisted-by: LLM" is the form Documentation/process/coding-assistants.rst
gives now.

Thanks,
Karl
