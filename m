Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EB926A1B8
	for <virtualization@lists.linux.dev>; Tue, 29 Jul 2025 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780305; cv=none; b=Bjs4nI966jChIAst2oFtEu63QNNQOwIMWmgw8K8WOG9NeNueN82OoM+zTpo4O8f5AAXK73u64lJPq91ySmH384iDiYtk31za4FEPCvbFVDW/joiVg+TF5Ffupwf8tgM4g8c2caQToHj4Jxb8T8zxO+WKWa0O0Yd/QoFoHvYfius=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780305; c=relaxed/simple;
	bh=AooAinBEhVQgX4xQPKEnqfkbfDa2o/pfSJaoO6cyeHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryBWMy5bPmckrtSPAmaS7BITikF7iCEYgNZIPS1PpzOwBniVI7syy+o0pWa++595NtEcp81N/n0cDXcA1SjHre+jaWMK97yGr49vhwsxAMvVMNmoJswZelY2OffMtjBQw6mSHBcVWEyLf0zoQTU3IFATrqeN53WS/Cvf1AkUYEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61553a028dfso1982049a12.0
        for <virtualization@lists.linux.dev>; Tue, 29 Jul 2025 02:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753780302; x=1754385102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTe0pbkq2BTo76Iwyv7UU0Sc/vWsm4BTTYdkBS408H0=;
        b=tdq5sxTC5e4v4AQCCj8E9/eVM4TnzU+nVDB9ZhoirkDcKIkhR/+mNbzx1KV0YxiGTJ
         0GQpWkcIQlQ1oibHkqK+jUQ2N+SGd7BJXM/yfjfWNYiWE1+pE2nwHMdDRvHdZrUDH6Yv
         /Wb9F+4aW0nT2xLfoWfos955s5m7P2tIGFTupVZxY7gAMhAplXGZ+M9YZ741Ljp0EdX8
         VNeIW9/4cAeP93s9r50g7kR6GmlT9hs3F2Je80KqPFVhCfmuMflWaOpIW5VQzKItKVQl
         aMX3CLq6JM24aJO1HogNn6JWEOJ8+H9UlWiPui34GNqevO9/Bz8AwmkPuxjzX6CcITpO
         vgIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7oV9YR8yAG1CKc9dHjs+hGwQzyCreC3m26Gics3KjfvJElWXHq09yAEnisSbsGAUUeE0NfGGyxYomMSuyYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxjliFYn1DE5tqzaVPT4mZhOgptznRYlO3G5ioKFEemF3XTy5Rl
	sTFetPpmjdYCtKllVG56KI2nXEz+C+S9fN2Lboupr25nGS8RS+rFM5e/
X-Gm-Gg: ASbGncuWXtlaUReGsN+Cly6WgK91jsk5XFLxH6giV6j5sROOJeP2I4TRUIg6j+I3yIK
	xH0sOUl1Q+ZbK+cMAwpoJryWcNI02p34rugWvrJMJv2AoeP56QNNAgR6ps/tZfzcsdaQ8mmKoa/
	0janubUeV+tC5aMUS/xZ6VPQDIVTdRhS6q+TZ49JNyoOoqwkeP9umSkTiJXs69ZcuymnHowSG+w
	xyWQjTIXvf0LvOmoN4w15FIrppiGD9qtHYfsQLmNy4hrG6uy74f3bZG4XohMkwoptMWgfRISof6
	jDJoNJUsmMmpA22Et13wnSq/y6R0i5VQBbjCL+EP9nofdPAYXwYUxlwLRUxdjF1qWx59/Pd10hl
	jGWCq6W7JRu2eh3fWefo0kDeb
X-Google-Smtp-Source: AGHT+IHiUSyBteGKx3hNSMSmlbFFC29cVQsp80PeSD3fki0Wu7eWgmkZiAy6HP138mxj1vsKT47V7g==
X-Received: by 2002:a05:6402:2348:b0:615:357d:5630 with SMTP id 4fb4d7f45d1cf-615357d569dmr8322665a12.28.1753780301941;
        Tue, 29 Jul 2025 02:11:41 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61542a59c99sm2146959a12.1.2025.07.29.02.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 02:11:41 -0700 (PDT)
Date: Tue, 29 Jul 2025 02:11:39 -0700
From: Breno Leitao <leitao@debian.org>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sgarzare@redhat.com, will@kernel.org, JAEHOON KIM <jhkim@linux.ibm.com>
Subject: Re: [PATCH] vhost: initialize vq->nheads properly
Message-ID: <nswdjfxtogobamp7bqktyrihl4w6xs2jnvxjofdvqoxqtvjp5s@vrsdmzuvsvx4>
References: <20250729073916.80647-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729073916.80647-1-jasowang@redhat.com>

On Tue, Jul 29, 2025 at 03:39:16PM +0800, Jason Wang wrote:
> Commit 7918bb2d19c9 ("vhost: basic in order support") introduces
> vq->nheads to store the number of batched used buffers per used elem
> but it forgets to initialize the vq->nheads to NULL in
> vhost_dev_init() this will cause kfree() that would try to free it
> without be allocated if SET_OWNER is not called.
> 
> Reported-by: JAEHOON KIM <jhkim@linux.ibm.com>
> Reported-by: Breno Leitao <leitao@debian.org>
> Fixes: 7918bb2d19c9 ("vhost: basic in order support")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Tested-by: Breno Leitao <leitao@debian.org>
