Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C51A51C30
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716202996; cv=none; b=lfgX/0sgR/HZWv8KxFdyit7Lsjy3V9shKUtK8rXjuKSR2gXc1zEUqXitCwQHxSQgs2IOKVP8zrWS8Xj+XSoOERn2cqi+GIQeniuLJ8pNlWGn7ssNSLngNpAZXsKJsjsKOfyV8BGYkCvPoeqqpOUAAnyfsFTNJlQVeLbtdEz3XPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716202996; c=relaxed/simple;
	bh=bmRX0Du5YIWf6EyefB9p66Yf7FLiWGJlF+AIqUB/FjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/p5C0kHzvjN42QqN2YQ7Fn3vivYEuWAdsY2FWb7xwmnouqxUzQpOl05IyNI/HY/mzMxBba5JE7eIZ+Sw4pdo7iA1nsLvA9K1LXTWFdzA/1cAIUw1/t7+8xC0IRlHtoab4/6aBGuMc0tfYq7lWCXCpXAgJy7BKoFRytlGK4jaZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MNMiuD14; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MNMiuD14"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A3D7B401FE
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 11:03:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B8A2gWBZSFCa for <virtualization@lists.linux-foundation.org>;
 Mon, 20 May 2024 11:03:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::134; helo=mail-lf1-x134.google.com; envelope-from=dmitry.baryshkov@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A362140173
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A362140173
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MNMiuD14
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A362140173
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 11:03:13 +0000 (UTC)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-523b017a5c6so6145323e87.1
        for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 04:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716202991; x=1716807791; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gDt5zL9HqHL0LNTVxzu6RK9k/3ub+zUe1M1krBVr+UI=;
        b=MNMiuD1413+w4dFYsNtKVMN91spUUNeL4togA/l5iC9ATAnkXrCNk40TzV+sGrdgcD
         mEkuzYlZkX5TjA8zHABXka+Crio9Gi05qu0eR5zuTiuBeFCH2LvOigv2gTJshgA20j3U
         1HBJFaazmtHkkzYbj07ZNiBT8VUhT18X42IDNLpiilTXMzG7bvYkmnyXwkcMn5XphEmp
         +nm8BxqW4toL7B2ZZxxyhVu+f5zbY24uMKyDZxUZFhstUuAGJh8K/1zDSRw0M4snvEtY
         u5kv+AH3qsRt6hnBkD1ZsB+urFl4kibtP5pmZT1XlmZCl5vcHmDsz9wUQjezJBuFzBoL
         MsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716202991; x=1716807791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDt5zL9HqHL0LNTVxzu6RK9k/3ub+zUe1M1krBVr+UI=;
        b=U0T6Q0GJ4dLyFt3TCgMoWyhk/IbMtC7JIYdG9Uc2i8VJSY06KJfaNAe5ySp+sABI8U
         Z9ivulZK5qcDwIrrLbF2Y7h5Xu8aJJzV0cpH7DqxVCfHuZTzhpFveXpxR34zGqlXKvtp
         GIP0F+PnZIxwqTSN6tVb7Un6/RRfm6N3jG/5FJQi/jFGsFuDQIgB1TVpoOOrKVAm8K50
         Bjmvt/4PpDIT1y77XIqsnNOKJ1bi1r7APiEzpREP7MZZttjchndoa2BzqgE15cMrp0N8
         mW4bgRL9ImFT9q5Aw3j/Txo1DD1MxO2yydsBv8/YF53dqR5lYYJnbP0bJMEPZUlMfcD5
         ar1w==
X-Forwarded-Encrypted: i=1; AJvYcCWOuIxw/aMmjZlT8534YADb0VTcdQHSA4BI1G1AjJMi5qji04PsL8E6bec0sAo2rNiVqWM2ox/fwozscVQ2jdS9knjnrGodiII0YzAD2G1VsK6GXnEHBG7f8A==
X-Gm-Message-State: AOJu0YwqwekTRB9K/4o2KXydW1tApU+HdxAzZ1yE0glS8vm3g+EwGOX1
	1p/WQuwg0s4u3BV5Rtsv368LZz4ygBnLgjYnW4kwj4NIdBcMH6606ragD0iM2/E=
X-Google-Smtp-Source: AGHT+IEACx6wIZ/owZMa9fgLdIORVLGiIVgPJ5CApXgwF8B9qZycal7wPuLLAhEdV381KLhAEa79fg==
X-Received: by 2002:a05:6512:33cf:b0:51d:9291:6945 with SMTP id 2adb3069b0e04-522102785abmr29386158e87.44.1716202991332;
        Mon, 20 May 2024 04:03:11 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5225132505csm3241339e87.116.2024.05.20.04.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 04:03:10 -0700 (PDT)
Date: Mon, 20 May 2024 14:03:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, robdclark@gmail.com, 
	david.heidelberg@collabora.com, guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	mcanal@igalia.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] drm/ci: uprev IGT
Message-ID: <4hnd6bznqsp3ve7dh6uhz3ygs7yyapqcrainnqlhfejomcdbvo@htlnfpqb3jg3>
References: <20240517092502.647420-1-vignesh.raman@collabora.com>
 <20240517092502.647420-5-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517092502.647420-5-vignesh.raman@collabora.com>

On Fri, May 17, 2024 at 02:55:00PM +0530, Vignesh Raman wrote:
> test-list.txt and test-list-full.txt are not generated for
> cross-builds and they are required by drm-ci for testing
> arm32 targets.
> 
> This is fixed in igt-gpu-tools. So uprev IGT to include the
> commit which fixes this issue. Disable building xe driver
> tests for non-intel platforms.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v2:
>   - Split IGT uprev to seperate patch.
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
