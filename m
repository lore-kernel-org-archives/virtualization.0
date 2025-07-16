Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453232EF671
	for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 08:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656262; cv=none; b=cJ4DJynakXCzp+FS5YNvZ7bVNhDUCQOaa78MZJ+igZMuKkcCC5a+Abd8ie4gw+XdoNwaNjp3+AOOxyvAKQBFJw9Qq8aGUATp9wYeT8SjXNkcWIwD9Dj297AHnVe5f14MMu5P564XTGpFbJBvDtMQthZg9UFEvXqCGoil61YzHXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656262; c=relaxed/simple;
	bh=bSZvmxVaLzzIexlJjfqAQuaa2x0fZVD8/09A4vIGlmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Xz1wl8MP+aGY/hO+iAAna9fMwjOw1kMyZcMNRDPhRxSVp7RbhpRGbHf6JtqDTFviWbjSg3RGehc9LN01MWIbiQE23nPI0XefbbRb6fbmIbQP5PnAau/jMyHXzoSQIEFXGdWUabvncukbJ35iSFZ9GtQaARwfNZGUjfoYAtuCHQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LQdTDtPx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQdTDtPx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752656260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T0pk9pyfgDC9oxEgYm8PZjm4tzUcUb0Zdw4AkU7+zzw=;
	b=LQdTDtPxQMQQm0CjVO6mtE9TLildw8cLFWU9vh1Wpk5tqw4H5cBsjr2Mh00yVxBS1jstSg
	Cg12aRergmYU9Ipu3AfbDwr1PJ7hTWVMuKIW4XVmUeXwNgdDHHW1IwSfFy3siK8qvxIpdV
	DFxlI2H1gUVVwdyDQjw/uU/+tmjodBo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-s8rWh3WzP6uF3MytdlpDNA-1; Wed, 16 Jul 2025 04:57:38 -0400
X-MC-Unique: s8rWh3WzP6uF3MytdlpDNA-1
X-Mimecast-MFC-AGG-ID: s8rWh3WzP6uF3MytdlpDNA_1752656257
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4560f28b2b1so12931075e9.2
        for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 01:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752656257; x=1753261057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0pk9pyfgDC9oxEgYm8PZjm4tzUcUb0Zdw4AkU7+zzw=;
        b=S11GeTI5FvhfgpqwjBuzBfEXPLGQCelY4L8PtFcNMMM373fwK+FtSQ8KCozliItbM3
         JDBcVw4fd2GdoG9OAb0/riO0DSMoE5wqemGQHosT2ZIWjx8zUU+8s2W479WEvtq1+jen
         fqAA75tuMFqcT9a/tbb9VqRgzdGkT/cRAoUBLPUKvjG2W7n2LvrsIK0/a9pmuxwTSali
         9XluQ+qfxIAX7g2ExdNCRf+cBUlmEV6M84U3xpoWb1AKaSJRRd+D804/HYwRBulN5Jbs
         2OzyUKTA8AHIgY5MN1MrJIvthkwhXF58n4IKPeRzTVWJgVfS9HRAUwn+oJrTlS9Z0dbo
         auBA==
X-Gm-Message-State: AOJu0YyAqZn/Jlr0gT3taESP9Y60Hzmuhd8EPEujb6DXIvQpRv7P546O
	/IQUCU/l3+y6qsQbCuVaKGiO8F60Uh20OYknhQo00W6selok8usf4s9mdnPAd2IdlBLBEX2miDp
	7HoB++WUFKDoto886D/s6wiAtV4Ij7YMiv1NiVr5togz0AyUNhs49pumYRFDLMBKnIsSZpqRF7O
	uF
X-Gm-Gg: ASbGncsz9inEILStq+n/5GH1Z30WNDa9NdM5Md23l26zxhTzMCQZmdlFi7KoQyzxUEv
	L6MaWk/sP0SeJVGZU0Y47mPJ2HpLmgWE7q3W+LgoSeS/Sv7XD+Wa+znlnyl8on6mJNSRiPxkrdd
	wEBtN5tk2ojE/362ysWV1RqRh8FXz14X0yFxtwVEH7RU94hGOCI9m4X+Zi1TZQO67bco8UFphDA
	9Y+ORGmygoWt5eJqUPbiYoRs9W3GjMuem0kVsN6aCP81ovhbE8f6oOG3VAg+WqXdKvbnAtzk9mA
	m2lQrZDRL3bVEyOVlzrRi+cNc+cQgAO7
X-Received: by 2002:a05:600c:4586:b0:456:2142:7fa6 with SMTP id 5b1f17b1804b1-4562e03df81mr20025035e9.12.1752656256766;
        Wed, 16 Jul 2025 01:57:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPMQ1MbDi1mPyamg5hDacuZGeQ/q7zkCeqn5pVA9BWS/Ht5qJqtjeEvWW81loE7yxAUxIfwA==
X-Received: by 2002:a05:600c:4586:b0:456:2142:7fa6 with SMTP id 5b1f17b1804b1-4562e03df81mr20024795e9.12.1752656256365;
        Wed, 16 Jul 2025 01:57:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e802afasm14522575e9.12.2025.07.16.01.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 01:57:35 -0700 (PDT)
Date: Wed, 16 Jul 2025 04:57:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH] vhost:  Use ERR_CAST inlined function instead of
 ERR_PTR(PTR_ERR(...))
Message-ID: <20250716045617-mutt-send-email-mst@kernel.org>
References: <1a8499a5da53e4f72cf21aca044ae4b26db8b2ad.1749020055.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1a8499a5da53e4f72cf21aca044ae4b26db8b2ad.1749020055.git.xiaopei01@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eLGYSHjXDc_jhqrD9_u-rEl7QcCGCJGMjLIXPGs0DwI_1752656257
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 04, 2025 at 02:55:48PM +0800, Pei Xiao wrote:
> cocci warning:
> ./kernel/vhost_task.c:148:9-16: WARNING: ERR_CAST can be used with tsk
> 
> Use ERR_CAST inlined function instead of ERR_PTR(PTR_ERR(...)).
> 
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  kernel/vhost_task.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index 2f844c279a3e..8c4a82c0bdbe 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -111,7 +111,7 @@ EXPORT_SYMBOL_GPL(vhost_task_stop);
>   * @arg: data to be passed to fn and handled_kill
>   * @name: the thread's name
>   *
> - * This returns a specialized task for use by the vhost layer or ERR_PTR() on
> + * This returns a specialized task for use by the vhost layer or ERR_CAST() on

ERR_PTR is the type so it's appropriate here, I think.


>   * failure. The returned task is inactive, and the caller must fire it up
>   * through vhost_task_start().
>   */
> @@ -145,7 +145,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void *),
>  	tsk = copy_process(NULL, 0, NUMA_NO_NODE, &args);
>  	if (IS_ERR(tsk)) {
>  		kfree(vtsk);
> -		return ERR_PTR(PTR_ERR(tsk));
> +		return ERR_CAST(tsk);
>  	}
>  
>  	vtsk->task = tsk;
> -- 
> 2.25.1

