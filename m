Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD5643BDB1
	for <virtualization@lists.linux.dev>; Mon,  7 Sep 2026 22:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788820378; cv=none; b=Xtzn2tG7c/SjexozKqthdE5XxzJ1r60vmAhmaFWVTvnxVcauXaDcpr4epXCIEokYe6/qDwBc3Eb2L6rFMuDAe4H4b+JNtCRHjUHHCCyMrM9DDgdj8Xnobh6B26GNNVWIbEsDgmLmNmfUDny0xkYL6N+deDH9lhNQxm8LZdJPtLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788820378; c=relaxed/simple;
	bh=9RNlViBMP5gSfl6YGM7J6Ko4HkVsFl5+nPinarDZvEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blAdLGw2hXyT6hZXuV6Jem+L3UYt0bMeNCONp7YoTrb27XGeMM362lR61oyptZODAM82KVn5rO3ju1+WR9NJyR1H/YgedT3vrb9X4dBHKYj4S/2a+K0W9+mVQmmYg7CX9ELWyk67FDvS0sJr5oNZwJjyhfglYY96keYNWx7BE0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q/XdmrLx; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/XdmrLx"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-499ae1c6471so38885235e9.3
        for <virtualization@lists.linux.dev>; Mon, 07 Sep 2026 15:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788820374; x=1789425174; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mnujOlryOcOB2B/LvIPxTaLmbwXh/kZV9FXNR3oxSFM=;
        b=q/XdmrLx+RNiz2caNuUiH9rkzd0iZSa/a2iES0Tu1VRWEEB9DY9WsGm/8QKr+KdITm
         X9nqEu6YEwAofTGbcMdfteNGFJ1z8CajiHPxMl6GwGWN2bf5eWnu48BqXTkyP7JfKRx9
         Aa7fWKx9tMjqeD9tmLkw07qERIy+Knhch30Nfczm5yCRubaF3DA+rwA9MYGsXpyDLv0Z
         aF9XrhEiHM8USSNSRa4gufBJCxCxWACdouVH7b2cfgqoafu307Anb6a+LZ3SCcGoernC
         ThzIocSYnNDDV5C2+wNDdjVYJzhm5DeqGwTJDHgBQCt4WM9OUzKhCNVP60dyk5nDdEtP
         tkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788820374; x=1789425174;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mnujOlryOcOB2B/LvIPxTaLmbwXh/kZV9FXNR3oxSFM=;
        b=KESgyRptQ5qEN4/74vi9IV1clyBAyAn73Un2frfRZ87GCNd+vDNrO099qI495IC/tL
         zjsPszs3gBLMUwHi+akrLiO3O7M0F+ECg2fWnRccouOd8tobEdKEZFE9CLfSCjw/FCXW
         iQV/Pi2kRsLyy1O6tRGxx37PPT5jYlnatGS8/FMkGx4cWddYOouarmADxh5JCe5kZlN+
         ynSBf+qmjyQj4dLYMJXqLxu/IwEiUUFMOMJtyz7mQs7703PUsdsL9VzOe6Vl1xxXULtQ
         DZy1n8f1IZfsXuswyEBg8qGZMnf/qVyMCKCRQc90QtO0vLqYJStt2xzbD0ML+TnKSRL6
         aPqQ==
X-Forwarded-Encrypted: i=1; AKwUvBwpkcvW++bwZydJmW0GRGMHt65XH7ywEPsnJlNFN2OKJJZaXkncPPpm7+sswu+8uHPPpL6bR9cxRlToTfVpFQ==@lists.linux.dev
X-Gm-Message-State: AFuF++n+H6eUXQVKH6EGHw8QioX71YWlKyeiwayeCOp0K1kt6hYKqRUs
	DDTjusMzR9+C1gfoIVXDJGzL//xx+n9JuZ9CapPm+/9ly18pfeul08YM
X-Gm-Gg: AYBFou1Lqj/Esj9nVID72lLLf04Ewr4E2FIdnQpyGYgPx2Az07LPXZJ6ZSfzncMVHqu
	9FI2l50Pm/loRqZ/qJIGWimwpHROc0WaY/vjrQte9oicZc1W4BFSYAnh+HkY2uu2ojct4kAk5Fw
	H7Lp/er4Ac34vret9UVjQwhWpJ+PCBWr8zi7pFsQun/2KHrhdpAxGYeN/lBXQGjsxynDrW7SwcR
	JdZfCY8yEsaxxxoyh0eaGE2mT2NeTUKW+1/gexMfP0R5JOxj4H41mBnoYgMtsQAQjfS5ynQ9lI4
	RT5/D/tNsFd5Z8U7s+4CmHYSx3OAjV+LT1/DgX9ePibwFb0IvE6S7kOaQllQGLa1Bu6h/TC06Ii
	YuFOiF8G0fdUapMyo3U4D38wPKlG7iGbOho03SHfMzTo6TT0FdeO9V5Np6T5IbyHAzl1ry60RGj
	Rbq2/YJsxuC12yp4sk/AneTYtFOVNwY/EdtQW4H2Pic8KjFO9RrIm5XwpuiXst/NbD69kOHMbNS
	PPLnK4fVFNd9mQ9rGqXoc5RIQH6QymXw9H+5SHRx4AKwaRvnKAckK6cnEji6DQKTvPg5N5iOe5H
	/Yxnd2oG2QN/Bph3LhF3Ml0c8wnZpM8pEYkomFJeMF+CY8Eth4nQeYajmQUKh4RYvSsbxxbOw4N
	J
X-Received: by 2002:a05:600c:a0a:b0:49c:e1f1:3dd5 with SMTP id 5b1f17b1804b1-49cf81e6cebmr448618745e9.4.1788820374459;
        Mon, 07 Sep 2026 15:32:54 -0700 (PDT)
Received: from MacBook-Pro-von-Karl (dynamic-2a02-3100-b0c9-3601-cdce-ba4b-d0e3-dede.310.pool.telefonica.de. [2a02:3100:b0c9:3601:cdce:ba4b:d0e3:dede])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce551bf7asm289518525e9.2.2026.09.07.15.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 15:32:53 -0700 (PDT)
Date: Tue, 8 Sep 2026 00:32:47 +0200
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
Message-ID: <ap87JrBAxjbPe_jX@gmail.com>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260905152059.89560-3-kmehltretter@gmail.com>
 <20260907174559-mutt-send-email-mst@kernel.org>
 <ap82pFlX8enNG0gZ@gmail.com>
 <20260907182153-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907182153-mutt-send-email-mst@kernel.org>

On Mon, Sep 07, 2026 at 06:22:09PM +0100, Michael S. Tsirkin wrote:
> > 
> > "Assisted-by: LLM" is the form Documentation/process/coding-assistants.rst
> > gives now.
> > 
> 
> really? not what i see. in which version?

Since v7.3-rc1. Christian Brauner proposed the change here:

https://lore.kernel.org/r/20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org/

which became commit 816d9992d9ed

Thanks,
Karl
