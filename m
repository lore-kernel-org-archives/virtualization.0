Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD4D220F34
	for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208154; cv=none; b=qJAk/xZT7iedanACkMqri/hgeOHX777HH/Akx+fWeTdLv3USF3q5HmYgCZxDctV3Fo8IGhNPM9yc4FxmxL4iFNuxeHYt5HIq6Mf17OYs6cdgRO2heAJO0nvWUhU89SgVg5VqwnFyj6kZNOzTim8CImGFefbqYV/IJ/Ct92pf+JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208154; c=relaxed/simple;
	bh=48WfDspnNYYwY+nqsrybAAO10uUojF00QMRofRzWMNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZNPHU4olcUYEBFG26RqgxPIlukoziTSAsiCSd0g3YxGUAILQNoQZZS1BMmgaCYJbSW6ObM9JdicQFBHWvlFL4f0O5TFWRj+TNyHTgMr58cvFhKB+2K4WAwuJEGLPjXYu0gdGYPcBFnfIy0KHXjTa4v18N2VGRmN1CIicqtnG4ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CbjL9Her; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbjL9Her"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758208151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Okp6kP9+YlujH23hoSs0Wy/CFE9uS+Y/4tNJyV9DleU=;
	b=CbjL9Her5yuI5edkX7ROGHGFTq0qx5K0LDnUBUY5j368MEszgg0Zf3LmT5AeBBgZX5I9BK
	y8GC9uw6fOPYUiQiCESOkpAPbdiMPGOTDBsh2zz5HWjuQYNjw6zfVZTWUnKEqBVtjQyTPf
	4Sm2qyqCkT/o51h5hTfLWsoZcPXaM+c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-4FWXzCx2OyyxwHuJmMIBcg-1; Thu, 18 Sep 2025 11:09:10 -0400
X-MC-Unique: 4FWXzCx2OyyxwHuJmMIBcg-1
X-Mimecast-MFC-AGG-ID: 4FWXzCx2OyyxwHuJmMIBcg_1758208149
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45de18e7eccso6279765e9.0
        for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 08:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758208149; x=1758812949;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Okp6kP9+YlujH23hoSs0Wy/CFE9uS+Y/4tNJyV9DleU=;
        b=b0W8N1Q1U0i+2qSCv4jEbkF2UfojPj1ImCO+Nl08shalyCzaJ8tkH1NBBhrNdVERzt
         MyGykKNH0vYC+ne5SW4FtatUp1BkA9o7yfJcYp5eRdLSIas0F8twIc3kCseq4hU1SgMb
         RRMfGCG+Taloug1IfdihwppkXPe9Z+2xjSfq1FHt9cZaIAkjaTXRnVbRFFrPMFa4O9qI
         2RdtOAPGD5zN6Vl9HlkJ+ic8lTZmA+G0JCuA+I3sGKtdq76sy5M8xsasrUCgP9kJgIBJ
         inEPjXlV8KkFG0YuoJlFAVddQ59bHB1GqBSd4CZ8Zakz3psMvFC6iTG3VJP7OaiVBqcJ
         k1Lg==
X-Forwarded-Encrypted: i=1; AJvYcCV04dpX66omtgGvk6RGkC9aoiALpmpSbQ2chrR9LTFuqf7nqkyO5+hUzpCxyDeFf1PnqjmarH/jem0Id88bhw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQj4soCDPSFKIi019NkCZcjvlnddNT3y0uatE586honVNo0xDb
	NX7u3iaupkYEXCCclzx3fdSF6DJBdXJoyP6wQKN+xmiZgHp6NunH/nTqAv/H8v0Qvf7zOX/1HbF
	VXEWXDuo+AD0azSonrkKqVJNNAM0OJZPi10XkQugKneazJRuXwMiRK/gJ70lSZRow6uTe
X-Gm-Gg: ASbGncv5NQ8sJfQCWyRdXujX7sIxMy0FJT6cm4VaFayKzmlGXgLe0AC/w5SOynMb7Wz
	Sq3qsIGtG3w3iKuNjpxukbERHlbtqgjqvPovtgGVfcd5YU1+cXH6RvQSzbHTpc18lFoU4EWwI0+
	5wjKi71uAx878LvJsZiQuKDZsDRLqBcXV4s4WO1YnS/SJ6XNJU5WjJUISOLrqYDvBff0zFUk07+
	UI309cX34ktdAoUcNN6iqhY9LF9H9yI0FS3qPmXdr7LOSd3TLSz/Ycx1xZyBxublFESyMWcslb7
	QIbIqBgjgBixqyMt/xd1PwNfK66+ga/3xdI=
X-Received: by 2002:a05:600c:3b0f:b0:45f:28c9:c4aa with SMTP id 5b1f17b1804b1-46202a0e8b9mr57240895e9.9.1758208149053;
        Thu, 18 Sep 2025 08:09:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4pxOb15HbXf6kQkik0F3fAf2Q1845KsjAT75QUOI8d0zEUi3a3iP8sUQbUJhBuS6AvT6fxg==
X-Received: by 2002:a05:600c:3b0f:b0:45f:28c9:c4aa with SMTP id 5b1f17b1804b1-46202a0e8b9mr57240595e9.9.1758208148642;
        Thu, 18 Sep 2025 08:09:08 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f4f9f41csm52209105e9.15.2025.09.18.08.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:09:08 -0700 (PDT)
Date: Thu, 18 Sep 2025 11:09:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited
 task
Message-ID: <20250918110828-mutt-send-email-mst@kernel.org>
References: <20250827194107.4142164-1-seanjc@google.com>
 <20250827201059.EmmdDFB_@linutronix.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250827201059.EmmdDFB_@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7huRcSeT0KrInOF2Sj2-YX9gW8t8_oih9y32_Cjcm10_1758208149
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Aug 27, 2025 at 10:10:59PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-08-27 12:41:04 [-0700], Sean Christopherson wrote:
> > Michael,
> 
> Sean,
> 
> would the bellow work by chance? It is a quick shot but it looks
> symmetrical…
> 
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index bc738fa90c1d6..27107dcc1cbfe 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -100,6 +100,7 @@ void vhost_task_stop(struct vhost_task *vtsk)
>  	 * freeing it below.
>  	 */
>  	wait_for_completion(&vtsk->exited);
> +	put_task_struct(vtsk->task);
>  	kfree(vtsk);
>  }
>  EXPORT_SYMBOL_GPL(vhost_task_stop);
> @@ -148,7 +149,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void *),
>  		return ERR_CAST(tsk);
>  	}
>  
> -	vtsk->task = tsk;
> +	vtsk->task = get_task_struct(tsk);
>  	return vtsk;
>  }
>  EXPORT_SYMBOL_GPL(vhost_task_create);
> 
> Sebastian


So how about switching to this approach then?
Instead of piling up fixes like we seem to do now ...
Sean?

-- 
MST

