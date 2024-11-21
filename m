Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445691D9329
	for <virtualization@lists.linux.dev>; Thu, 21 Nov 2024 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732197744; cv=none; b=fiFw/ALCgrRVvimA/qpr+/jFuinvb5aPdYjQS7s3Gr3TFxt0hCRizLHO1NVydUFSSQUm0qfYZEAySlQBR40TN7t8yWkmff8fASIN18E5ABTUjZnbmaXJjCLZX1jTSuuKwxTxAXQF+BJUOtku90OVwPFbbr2vVLtgWoxGlpWqxv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732197744; c=relaxed/simple;
	bh=5Oh/o/XpH8bZVGM+tUQ6gST6nT2DOSuTqrYyQ8HuFRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMSFjkS29vdA+pUYbo7cqyGtHnx+6EW7Iw1jxWQ4t7iMJ8d+Y5Xv5sxafRCr6c9EOOD8tlOLfikTJoXco876bmxwB53OGtamHQfdF4Gj2/BtdpZ6uWKSN8CljlYbkNHvhbT1TYNhESu9H4UNql5ZDkPB7yjTe2J3tr0JFW6ql+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fWa8m1Cs; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fWa8m1Cs"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so7930725e9.1
        for <virtualization@lists.linux.dev>; Thu, 21 Nov 2024 06:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732197739; x=1732802539; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pAE+A77cEW+RSvRAmSY+g8z45cph7MbMcujqpsZd4q4=;
        b=fWa8m1CsfUiI2E6MrHqNo/5+4XjKhdVOZfJHpYuL9nMUt9j0hPVeRs+H2KmkQE3Ifz
         na8LJ8ZFFAdPs7oOJoOqCFyUYwGIaC1hh+Aqk2V56xd/+5EyOeV0rWIs/vw/Lu1jIBMF
         QO0pRvmH4pthr3WxCWyHGh5L2aOEmTsZ6EOVIo8G7a0N61SbrbmrjZ/b4NFwv0OVf4hG
         KLc9LdKS8YTPj5YskcFxxhhJHaASYL4t6qvmfnKm5wqdaM5jTqsHvQhxD1cWr88Qf9am
         FtGgeGQYMfhBIVUiwtQ567d62qW7s4XLi358LhVHGMbcBqX9z+jQDw/TXWRvSUEl89Gt
         hRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732197739; x=1732802539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAE+A77cEW+RSvRAmSY+g8z45cph7MbMcujqpsZd4q4=;
        b=GoL8ZCkgiQZZjr4aCV6w3J3XHlwTvH2J7Xn9lyOi79RAIvH/JsBZVjj9QlOJ0IznvM
         ED0iADQ+zK3hepdAwIxqXIl+TFg3YGbm2G7ktpv7o5B2S4KXyPJ+XQtMlykyQNJR9Trv
         Zw28NIg1Gz5v59ham8Pn06SIyMV9EQJ19VRJNVzABsfzCZxenlDPVzD4lt/I8Y5D9kHF
         gKB6AhENKf6tYe9UjZTB4slNRHDadp3wgMJIV2Wi7/GMwPftS2zmM6Yg+bbY+pbPkpH6
         y+jms/9fHujrZCx2POvWoLtLnoxwZAJimenl4h9JW3OFz1zDd2S5U+t8K4c5IRBmd6Q7
         oN1g==
X-Gm-Message-State: AOJu0YwtQ6c/4dSJKvV/WWKsZMkLooWHhe8uovbt2/f22Y9hY5m56L8U
	LhJqfHiJBK37JhU5X6YHCw68oeT1A1CJbg0DPGuR7c8D66g3aBJE9SZ+UtucsdQ=
X-Gm-Gg: ASbGncsnP/17zKR59Ktrb/UDQyRVOj8kawJ3rP98tSqpxVqGSsloKZ40EJpmRYmexNF
	1Pm/wgyqIFbEJ0JOFroJOugXvDPEpzCTch+Fq9bgKeJaFVGyu+s6M/swxclhUcB4cK+m2miRO85
	ZZDvPTFK6/1IQJUETdj5xs0W+7dJnYysmhaecNSZlb4Jnj5zYLZWY/1vSrPiVzUzdt5x2tKR6q6
	7PIa09zXTjgrKXXMLRApqa8sQC3gnuzpqydQ96nrTiDQSbx8g1bMqo=
X-Google-Smtp-Source: AGHT+IGXHHsC3lb110ltSt3NkQeKjUO+qIDnI9Se0KIThUXBQ1o/5uVK01vMM3fGteaPzmjmgPzfgQ==
X-Received: by 2002:a5d:64cb:0:b0:382:4c57:c415 with SMTP id ffacd0b85a97d-38254b20bc9mr5002355f8f.56.1732197737685;
        Thu, 21 Nov 2024 06:02:17 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825493f36fsm5104693f8f.97.2024.11.21.06.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 06:02:16 -0800 (PST)
Date: Thu, 21 Nov 2024 17:02:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shijith Thotton <sthotton@marvell.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowang@redhat.com,
	schalla@marvell.com, vattunuru@marvell.com, ndabilpuram@marvell.com,
	jerinj@marvell.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Satha Rao <skoteshwar@marvell.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] vdpa/octeon_ep: enable support for multiple
 interrupts per device
Message-ID: <2d7c846c-31fa-4f63-984e-d46670c1dfed@stanley.mountain>
References: <20241121134002.990285-1-sthotton@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121134002.990285-1-sthotton@marvell.com>

On Thu, Nov 21, 2024 at 07:09:43PM +0530, Shijith Thotton wrote:
> Updated the driver to utilize all the MSI-X interrupt vectors supported
> by each OCTEON endpoint VF, instead of relying on a single vector.
> Enabling more interrupts allows packets from multiple rings to be
> distributed across multiple cores, improving parallelism and
> performance.
> 
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> ---
> v1:
> - https://lore.kernel.org/virtualization/20241120070508.789508-1-sthotton@marvell.com
> 
> Changes in v2:
> - Handle reset getting called twice.
> - Use devm_kcalloc to allocate irq array.
> - IRQ is never zero. Adjusted code accordingly.
> 

Thanks.  That takes care of all the issues that I saw so I'm okay with this now,
but I'm not a domain expert.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

