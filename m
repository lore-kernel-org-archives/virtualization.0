Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243A32EE262
	for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951630; cv=none; b=SjTnVq2VzqzcnAR0n3m2LlvyoU6Bq8CZk/kj30z8JrEQ5uRwZuAOcQ4YpwVQc8MjtdQTkMm7xthoraJUKJVMmH927W6PTS9nFyFuzM+j/c9/2k5CRINZP5gnIsMX2VexqDWhxupH4KwDM7iDce+Nzl2EQYAC1TGJ/l+0h0puUT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951630; c=relaxed/simple;
	bh=m9FBJRe+X2p520OLNRjPn0r024IuJutRGG32v453ZCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UWUH1BmMXsHIUYcNHn6NaVEp0jDSKiPydQin8li5CAoxmMUvb98IBP4XWiYsqIOOPKXgR2rYMJOndwnZsB4WfLCz0mQqr6dHhCFYKR2uzorn9ZEI8cS+1It+WkCicsavOR1PGaX87EJgxfy/EyEn0rHaCechS7NHOyyApzgp5gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/UkCH6+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/UkCH6+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760951628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+CiY+AxGaAwH8cinDk/I+N1xFA7FzK3pYWDF3DVwTBM=;
	b=M/UkCH6+dMGqSUd73GP8uZNXJJmP9eYJ06nlIYi3Q2HtPcUDAx9liZS9eSm+GhH47vrNi9
	+QA5gaPeUJlvFFVjBMXTSj68Ys6Lx9HB6xQLDivEadq6hs2RBPvujK8QfMVeV8kYA17NF1
	AhvbKvONxwTxkVMy68EpRCkh+YF/CZU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-vWxV5h2HMem85LpqNl5G3g-1; Mon, 20 Oct 2025 05:13:43 -0400
X-MC-Unique: vWxV5h2HMem85LpqNl5G3g-1
X-Mimecast-MFC-AGG-ID: vWxV5h2HMem85LpqNl5G3g_1760951623
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4283bf540ceso914262f8f.1
        for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 02:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760951622; x=1761556422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CiY+AxGaAwH8cinDk/I+N1xFA7FzK3pYWDF3DVwTBM=;
        b=G+sBEpwgJwc75Bmc9CUPVHQctiA/Vo0PEdcNcfzmkR+16VkT+KJBVAlIM5Ne6h5AUA
         v/925DV2FdNjXpsEhUf6GAVElZANq7n4deXEzug3IxdE9kRK7b/DW9aWNmo/OBWB7L7M
         aL4BzIgkNjCrcK9Zm0Hsg1aSVOUrLOASWZwqzLzV+fpIGXU+/WIuezCQ2VUw0fvFadoN
         GGCH3UCprFg2pED2fD3Bi9+TahoW3OLEDiqSNeEi5Kd1YDfTlOEvveGEJmn0jEu94Xi5
         Py3LXA/OHavW4495jr4QtT+3tmwqy95sNoT9XK8stzzhIPqsm61CAST8BnPTKUEIPEuX
         aASw==
X-Forwarded-Encrypted: i=1; AJvYcCXtWNN+51A79em0urJC7bRd4M5huJ0D/HpciD4cIqRTT7tmWjGCpDqfw03E1sXiQFA++O4XfGFX0i+AlO1RHg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOv4g6QSKku1HLxiwKSRdOnsudndwyAHOUSczCk6tVSrztuxZv
	rqdW+047QM293Dn4eP6ygrohuksl1KQDI2HGwUttTwL6mnC96eI4gAT3cU6yR1m8TnSh07iPOdA
	uMl3Bo+zsPt64JLlWiZVyn7Zhn5QGUL4605AekJDB7Zrd4VRfKyAFfQAay0TMXcwSZKJV
X-Gm-Gg: ASbGncuWZPlvjtT7qZKUfbTPh9Q1Mj1aBz4qhmkKLQ3iaFvHrV/OhO+WSU28MLlpen5
	Rqa3TYYvY4GiGf2f/H8ULf+lmQKPSLQzzQA66fC/BQ9QKTKcNdTKTMJ/PJlFyvvCvjj/ZjqtvKG
	YE4a0mM02WO7i+qQsMyD0H7CoLSVW/MLb/Ossik0+o94hdF/Aj/Z9fRdQrln+edKNyC98xrlsGU
	ZrKupgd0gU+NTOhdKpp5Wvtl3OuAmdYxTSQqqQNUT2KMaNdA4hGbhI/xg5pQ8cwynyCDOhhjol+
	KpNXnskEJVMW7mtvpDm2/IL0Fly2QFDo3iZCEQJXQPEp8umeLWTLUsF7HM5UKYTx1V9Q
X-Received: by 2002:a05:6000:4382:b0:427:5eb:c45f with SMTP id ffacd0b85a97d-42705ebc49cmr7637790f8f.41.1760951622538;
        Mon, 20 Oct 2025 02:13:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEYHGkhUDnSoX6UCh31K4tPMBH5YeAEBQLQ3EcyfNpCmFCTCNtaMOPbrN7bwNaL+k5GSj1pg==
X-Received: by 2002:a05:6000:4382:b0:427:5eb:c45f with SMTP id ffacd0b85a97d-42705ebc49cmr7637766f8f.41.1760951622031;
        Mon, 20 Oct 2025 02:13:42 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a9a9sm14662902f8f.29.2025.10.20.02.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:13:41 -0700 (PDT)
Date: Mon, 20 Oct 2025 05:13:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 19/19] virtio_ring: add in order support
Message-ID: <20251020051214-mutt-send-email-mst@kernel.org>
References: <20251020071003.28834-1-jasowang@redhat.com>
 <20251020071003.28834-20-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251020071003.28834-20-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XmrAm9XHPrp7yuGF_ESi2hQD-z8Ztaagp4zydeV-qTQ_1760951623
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 20, 2025 at 03:10:03PM +0800, Jason Wang wrote:
> +
> +	if (vq->batch_last.id == last_used) {
> +		vq->batch_last.id = num;
> +		*len = vq->batch_last.len;
> +	} else
> +		*len = vq->packed.desc_state[last_used].total_len;


another coding style violation

