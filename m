Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71B1EB64D9
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 04:27:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1AF0681D67;
	Thu,  6 Jul 2023 04:27:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1AF0681D67
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=I6/AatYJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OntbgOtbLQmg; Thu,  6 Jul 2023 04:27:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 91FDC81BCF;
	Thu,  6 Jul 2023 04:27:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 91FDC81BCF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6784EC0072;
	Thu,  6 Jul 2023 04:27:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BC6EC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 04:27:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 429E881D11
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 04:27:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 429E881D11
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b10pDR0AHQKG
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 04:27:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6385081BCF
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6385081BCF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 04:27:32 +0000 (UTC)
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4036507ddadso2892191cf.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Jul 2023 21:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688617651; x=1691209651;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lWn3ZmGsuOlmAkmehfw3AOignGBknyVRUgruIj3HTDY=;
 b=I6/AatYJtVquephqTGfDOLAZ095BICv1inuNDwxYqUoGQKd4Ks7xN8Sj7VthJgJHID
 UioKpjBih4zSIG+3rqBLMokxxAreB5IfSFfjYDxNI//YE1D18mFhFX26jzKS/13ZHqiS
 V5dEYnpIeaq1CRYhuYQpLXP82SQwXqaer6ASfNl70LxkzepwrQn3cZLB8J9fZy6PlchU
 +H+Q5DBGHPlD0xzalmC9UlzaNiza6/vuK+hN88nYgnWhTSTjInHvNqCM2b9+4iKn+EuL
 DSeYNSk8IsaK3DZc6ghlTZjWtLnE7oOz35A+eDgXuaEEW1/SuHifeFp608bBpOARYpEe
 bA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688617651; x=1691209651;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lWn3ZmGsuOlmAkmehfw3AOignGBknyVRUgruIj3HTDY=;
 b=VmZgIR/zMO8V+FKM981IsfAvI39m7M30y+8mWEEExZJ/EjiHTyW5ZV6ixfkPhsRCIx
 tRBWm0hLrSVExIeVoSkvMYiRV3PhW6qn8VjDb0j+Z1BSZCsQGC9XWaVEIaFmZOUJ8txy
 3EKWbTXhvxbQ1+gpOBsG3c711Y6wUAWLAal7EqM/xf7S4JsYXhRLD9/NhvvM8T3ekhm8
 eScPb7pdWN8ra3fnazb6RNERpB/0lGVlAafTJJCvMlqMNQeU/y04O6wSnbrz9Ok8fZjd
 O5gFgevrw+VA1FJPkvBMTaQZ+6z9Vi6Dx00cXFjw8dn1GXtIvGBtJxEQilhmVurN2kFW
 8OfQ==
X-Gm-Message-State: ABy/qLaC/VCBvmT5DbPHN7cfnXRigwjeXG++iDMA2G+eH4DngUryfiw2
 iaU4CkVNa2oRGrPiPIRVdwnDKw==
X-Google-Smtp-Source: APBJJlHBTMfw8j9NVv45cPqnaVRJE9Hz2jtigI6TMIiJsXSTrNrAd9L/9DAMRmi2JyXZPsLJ+H+JoQ==
X-Received: by 2002:a05:622a:c:b0:403:4fa6:a5d5 with SMTP id
 x12-20020a05622a000c00b004034fa6a5d5mr821207qtw.64.1688617651177; 
 Wed, 05 Jul 2023 21:27:31 -0700 (PDT)
Received: from localhost ([122.172.87.195]) by smtp.gmail.com with ESMTPSA id
 s2-20020a639242000000b00553c09cc795sm361895pgn.50.2023.07.05.21.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 21:27:30 -0700 (PDT)
Date: Thu, 6 Jul 2023 09:57:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 22/23] i2c: virtio: Remove #ifdef guards for PM related
 functions
Message-ID: <20230706042728.htavo5bgeygjyfau@vireshk-i7>
References: <20230705204314.89800-1-paul@crapouillou.net>
 <20230705204521.90050-1-paul@crapouillou.net>
 <20230705204521.90050-4-paul@crapouillou.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230705204521.90050-4-paul@crapouillou.net>
Cc: Wolfram Sang <wsa@kernel.org>, virtualization@lists.linux-foundation.org,
 Conghui Chen <conghui.chen@intel.com>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 05-07-23, 22:45, Paul Cercueil wrote:
> Use the new PM macros for the suspend and resume functions to be
> automatically dropped by the compiler when CONFIG_PM or
> CONFIG_PM_SLEEP are disabled, without having to use #ifdef guards.
> 
> This has the advantage of always compiling these functions in,
> independently of any Kconfig option. Thanks to that, bugs and other
> regressions are subsequently easier to catch.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> 
> ---
> Cc: Conghui Chen <conghui.chen@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: virtualization@lists.linux-foundation.org
> ---
>  drivers/i2c/busses/i2c-virtio.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
> index 4b9536f50800..c60ae531ba57 100644
> --- a/drivers/i2c/busses/i2c-virtio.c
> +++ b/drivers/i2c/busses/i2c-virtio.c
> @@ -243,7 +243,6 @@ static struct virtio_device_id id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(virtio, id_table);
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int virtio_i2c_freeze(struct virtio_device *vdev)
>  {
>  	virtio_i2c_del_vqs(vdev);
> @@ -254,7 +253,6 @@ static int virtio_i2c_restore(struct virtio_device *vdev)
>  {
>  	return virtio_i2c_setup_vqs(vdev->priv);
>  }
> -#endif
>  
>  static const unsigned int features[] = {
>  	VIRTIO_I2C_F_ZERO_LENGTH_REQUEST,
> @@ -269,10 +267,8 @@ static struct virtio_driver virtio_i2c_driver = {
>  	.driver			= {
>  		.name	= "i2c_virtio",
>  	},
> -#ifdef CONFIG_PM_SLEEP
> -	.freeze = virtio_i2c_freeze,
> -	.restore = virtio_i2c_restore,
> -#endif
> +	.freeze			= pm_sleep_ptr(virtio_i2c_freeze),
> +	.restore		= pm_sleep_ptr(virtio_i2c_restore),
>  };
>  module_virtio_driver(virtio_i2c_driver);
>  

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
