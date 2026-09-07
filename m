Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9398367B92
	for <virtualization@lists.linux.dev>; Mon,  7 Sep 2026 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788816204; cv=none; b=eOFQCUO2v90cxOtNp9DXr7oKxb0g/M6OoEFoDhW851of74v9JL5Xsykk7XPDMzEbGtVhRjjaG/VgQ9Zfp5AX5cfjjHa3pAp1cu0Naj3Gl8zKdfRisTb5MakigiOzdZ/kZKZqQjw2j320CYQr8LroINMuKgQBh4uSu+ai6H8aLpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788816204; c=relaxed/simple;
	bh=Gzcz3Zkq6mIgF9nN+/RZpdn2G6QVcg2SErOL9iM3Lwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/cTtrO03d/LeH8Hx1Ums9GxXjKlsQDKvuhQHFLUm17YH8Z7nOuKUE9UGcc+wjjZCVSKqofKje1NjuSNn63yTTGZLonleZrMPHHjtYjcjC+p+IuuIfBAdzGkSVKtNCGUAF8RY1Q00ct1bswdmW1CJopSyowHsQ7MfEldc+1PLQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qvzZOEJs; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvzZOEJs"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4843efcbdb2so2139038f8f.2
        for <virtualization@lists.linux.dev>; Mon, 07 Sep 2026 14:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788816201; x=1789421001; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zj4alWZ0+Z5ViHZ+ZCYKHStoDMFk30/0JNVi4/sJSpo=;
        b=qvzZOEJs20VzsybKDjd5VmCD5r494oAPex2E2ulQBPOuqPgDKwxC92qsW2lix3qh0s
         M8Guyrlnn0+XOXayi+WkjKD4kQtwKV2S8EYc5zT1tmIR4dccDvKB11TMqpSeuuiXX1ts
         6W2XOAUemVdd4ZLxuYPMQk3NT1Kg2sWjEA3OLv9X96SQWCYK2S4Kj4EYVsgeHwYiGLh/
         Lstew+DJuTj61umVVaTCZqlgmjCSknXVsmlKg1BJWFC1VTXXAJSruMmtxPX6ckRm8Sp+
         uPS/20Rdt50vlwKoZLb7MYBEzO0m2AHbpnFIECcyk2+evX6uu8WjSvR2Fqoc+tK3r0mX
         FN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788816201; x=1789421001;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zj4alWZ0+Z5ViHZ+ZCYKHStoDMFk30/0JNVi4/sJSpo=;
        b=AWry4nqRP4epY8qXwx7GJgzvwQRslC7UlyXKwDuDQdPpJcZ3zuQHcpPoAq6pjOm1Gs
         Sw1VfbhpGtKVblcREsTomgDLmaVwwbG7UjR+SX1z5qKcDpLSnlbcYkEWwKOhOHz3yNgg
         bc/AdafyhN+/WyM1xZZThS47QezFgLt5xoD59/SMJ4NyBKU9THYgQrsiLxvuXM9O9KYL
         YkymZxq3U+SVDrk7BimtrJSy67EXJFPJPqmwBPYJhos3khZiGNYMw3bNOOOzRzZ2Ab5m
         rocKItCP4uGrhTrM4Oj62FqlW0CrShvuX1RKj466VCf9ou2VCCVA7gWk/V/N7Cw3pjrz
         GT4w==
X-Forwarded-Encrypted: i=1; AKwUvBwVCQXeneWEXQ+j/L4ogAQYB8wcP/gDKLthcMTSp1hcd02wqyeEwGkbTnAs6Uh2ufhnF7MSs3Ys39e6OZjsWQ==@lists.linux.dev
X-Gm-Message-State: AFuF++n2RtR+/j7YQt8y66ROrbYimmmQaFfyqH75B+/v9ADKpqA7oWQv
	oagNzjODwPJBvmuHdZRJjSmbVIbvVVHvNDnooQa13XkLdQKQq+YLmM4e
X-Gm-Gg: AYBFou1Tkfhs6XUgPJXsASQFrvHHgZQwhnCTXyzBLrd9TYxgjDEfs4qliuxNO1tRoFM
	9w+lFkwUXoGn5q9SnkZZCfmdcZ+coiqtvlwpM5LeGELPKKrXh99k5s10CZGtNB80SzjO2bcQwA/
	vMlQDoF4WW9QqwTChg1POx3LsFfMhe8SAKPQt/6wQdIk1Q7QFVIcXR8Ipb1lItpUG8Ohhm5EqR7
	5GP4QN2olQhGvYe+hhjyIETptqGaALBKOqUtf7qhN6WPCxVP0fy+HgWrO+PxJQuzZxv4s3jtaa7
	Ces8Oj0Q1AmPN2CCw74InXz50TXca6J6wGUarWwHhcgy7PCgVPGXC3z1O8Njqwa33GJlYSVp6gL
	deWlMvo7ywWeFUy4OM4cZNT9QPhkvzDV9PXazQFL9BNgZTgEg4Q+4pK7Av6s3v+WexL3O8lbl1X
	HZxMTL98dKCxMxzaDO0a/IvSlmVF3sxu2ky9x4peSgcsZb89GpCBJU3l+WxAnTsdiEtjhYUJht9
	S7/fqvY4unf/MlR/+aoWds5WCL1DId1N/xdBns1xK+4DXmqo7nfbPKpMq2KUiyjqZJxcrTdZjwW
	al76UEL8DvL/ASkQK5epW8hZwru8803BAtxNIHJ6SHaWb6X4IP6u9EtZp8sHF1i/ybyu4v3RJH6
	lAzuoK2A4LQw=
X-Received: by 2002:a05:6000:4a0a:b0:484:3310:f39b with SMTP id ffacd0b85a97d-485872e05f9mr26354952f8f.28.1788816201067;
        Mon, 07 Sep 2026 14:23:21 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-b0c9-3601-cdce-ba4b-d0e3-dede.310.pool.telefonica.de. [2a02:3100:b0c9:3601:cdce:ba4b:d0e3:dede])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858ac2b4cdsm29964718f8f.16.2026.09.07.14.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:23:20 -0700 (PDT)
Date: Mon, 7 Sep 2026 23:23:19 +0200
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
Subject: Re: [PATCH v2 0/3] virtio: synchronize callbacks during device reset
Message-ID: <ap8rCQII9fASEosZ@gmail.com>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260907091033-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907091033-mutt-send-email-mst@kernel.org>

On Mon, Sep 07, 2026 at 09:13:28AM +0100, Michael S. Tsirkin wrote:
> got all 3 patches now. it's a good start, thanks, but they need
> a bit more work, in particular addressing sashiko comments.
> I'd also prefer patch 1 to be split: moving code from pci to core
> is separate from ccw fixes.
> 
> Pls write or at least edit commit log messages yourself,
> after reviewing Documentation/process/coding-assistants.rst
> 

Thank you for the review and feedback. I'll work on a v2 now.

Karl
