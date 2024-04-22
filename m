Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AA21BDC4
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 20:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713819485; cv=none; b=UUI+bOhxyLTeUY7u4WF7Ia8UyKwzAHiz7qpGDJAghj/5AFf1c2uVVQ20ohfSAg1jZB7kabEzASWEdvqTiRUc091Vrp9dRzqedtUwwSyVcLHgWcwjaYw28KXT/dlqGey8iMWj7lDcBX4uTqoi2DF2kBNPruj5YJZyu+YJGhvFgz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713819485; c=relaxed/simple;
	bh=X/XSvnsrPoXupaSH/bXPRLAjaVq3ammbbc8eQs4MfSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Z1Jp4RKnacv2zO5s5KV12FKg08VOzLLKZkxwopxpondBgfh5FlNUkCgvL3yoa5tALrWzSNlaFo0xDmr2/4i7CTU0IFfRc58wphQsWIqBe/2hmEB5P9xjboEPIApgRrC2OudleWmINwB/pLDBq4ldQ2EtyfoyVPGkjN5ZUoA3ppE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hy+u3dvj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hy+u3dvj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713819483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gvn7f/v2fMtGre/U+zH+5pEbKnBwIFIuOe2b+sOiT/k=;
	b=hy+u3dvjpimENB6wVtFl6XYR0yfd+YO7HQXtKD/Gy2dKzSj9fUuX8jFVIewB9XRX78BzvM
	0oiUHhS5aP0lwTgG0JUu2h5XzmhRSiJbVqOb8fvB6bh5HvAM2093YZT5JFywD9gaNY2AGP
	UOAylu7oxsWowxBDPDhuVQJq3kRp+ng=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-lr0lUDnmNwiTD8yNM3vU0Q-1; Mon, 22 Apr 2024 16:58:01 -0400
X-MC-Unique: lr0lUDnmNwiTD8yNM3vU0Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-418f18458a0so24833575e9.0
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 13:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713819480; x=1714424280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gvn7f/v2fMtGre/U+zH+5pEbKnBwIFIuOe2b+sOiT/k=;
        b=okrajgUiw0OGOhoq2TxKF7PCw1kqfyNqbxDzJ8dItpvylmfYStI8rmf18/1V3ZXTr/
         1oPC96czC8FS+c9XqkCH4Wi6ZwE9IkpTkEJUHoL1P4yux//aqarp1n3AjbVDb0ziaX+h
         CzWB7rmOzDdKbWQ5v3L28lU+s00Fu5rSBD8wahOVcJVnINaciPhQPecz2IFXRgDyx1ig
         sSErs1A30ZOS9ZbH+UEip5VEVKdrBPWzTDwwF7nHVszwPUl1wbz1wrVaCcgyQh/g7hXw
         5R5lrDgo4Wua6fpi9CECzXOULrbMqicCKJAbYai3y0FQ5QZjFFvNtUwmAsbUSO4z0Mqe
         B89g==
X-Forwarded-Encrypted: i=1; AJvYcCXc3d0eRSaKOol9Alh/dHEGTakrteMVSg7k2/jxjBPGU1q8IypXn4rITZr8N9l/ncOIZjTYnrch6gGqq1UL1FGfsOrraSIbG6CTidfuy3c=
X-Gm-Message-State: AOJu0YyTyYizbPjXIYtWGeJXm30806G2JGpKvW5CCVxfKFf67q7eExeN
	Kep2/suY+q24jBzhsKsFYlTvQa4Vs76yCGyMT2Ic6P1cG3lIppTJ3b/+yCouKLlGZAQEY9wG834
	xQx6p0JbOm0FC/Umi6Vt59oBvlfhF4WMlVShJii20QEPeb1ugSmOi596GPYbtddCX/W3GAbqU
X-Received: by 2002:adf:cb83:0:b0:343:75eb:bb79 with SMTP id q3-20020adfcb83000000b0034375ebbb79mr9063482wrh.49.1713819479971;
        Mon, 22 Apr 2024 13:57:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaK9k8slPED7kfQkV9Sd6NAWhb6FMzKP31WDFt1alwrqQlr5TJJICpDtQqR4i0OM22+/Wo8w==
X-Received: by 2002:adf:cb83:0:b0:343:75eb:bb79 with SMTP id q3-20020adfcb83000000b0034375ebbb79mr9063472wrh.49.1713819479441;
        Mon, 22 Apr 2024 13:57:59 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id h15-20020a056000000f00b003434c764f01sm12887597wrx.107.2024.04.22.13.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 13:57:58 -0700 (PDT)
Date: Mon, 22 Apr 2024 16:57:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	virtualization@lists.linux.dev, david@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	akpm@linux-foundation.org
Subject: Re: [PATCH 0/3] Improve memory statistics for virtio balloon
Message-ID: <20240422165725-mutt-send-email-mst@kernel.org>
References: <20240418062602.1291391-1-pizhenwei@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240418062602.1291391-1-pizhenwei@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 18, 2024 at 02:25:59PM +0800, zhenwei pi wrote:
> RFC -> v1:
> - several text changes: oom-kill -> oom-kills, SCAN_ASYNC -> ASYN_SCAN.
> - move vm events codes into '#ifdef CONFIG_VM_EVENT_COUNTERS'
> 
> RFC version:
> Link: https://lore.kernel.org/lkml/20240415084113.1203428-1-pizhenwei@bytedance.com/T/#m1898963b3c27a989b1123db475135c3ca687ca84


Make sure this builds without introducing new warnings please. 

> zhenwei pi (3):
>   virtio_balloon: introduce oom-kill invocations
>   virtio_balloon: introduce memory allocation stall counter
>   virtio_balloon: introduce memory scan/reclaim info
> 
>  drivers/virtio/virtio_balloon.c     | 30 ++++++++++++++++++++++++++++-
>  include/uapi/linux/virtio_balloon.h | 16 +++++++++++++--
>  2 files changed, 43 insertions(+), 3 deletions(-)
> 
> -- 
> 2.34.1

