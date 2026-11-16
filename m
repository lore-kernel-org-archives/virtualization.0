Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858736;
	b=hjTf1UfzK2aVTPG4yNN0cGsvxMU78OSS/JUS09DDwWI4sJibJh/DAmgYeXZMNpgm8Gc8
	 nZgn+yhwoHBD8Pn6vXQL+gkMFovXPYu0nbAHcRfh841fV6/xI/iTbOp5xQdp140zKIcCL
	 3fPH9zGGE4FOnkCMf4VNYbmAw6AjeHVVrotkK4rxnBR61HW2E1lvVmO/K0alnnRRcXZ8c
	 KWPbnmw50B6bQlweUQVc7pWVujkYgKwyRWeMNKpDyD/ySE46cqx5Z3nFQ4L0c6KXl/Mwt
	 hiomODrPnu+MFLcID1wOkBf2QH3xLrsFgbEMwmT9aOQwr6eB06Lk57l26ai0l5os09Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=jqnrRoTh5TcWr/Py+gEgzzX7wdMhzTlFxFkfLcpGuJM=;
	b=XOFt0b0tgEpeZjltQTPty+potu80EglKa6X3/EygZ5SZmpT36y1FHmcmJPVuItmenBlv
	 aeMpORUJAFzj/MoJG1zSZ1XY2xm/mVvL8CKRXV0jjOnidpeYYJRCMmCNd9b9zaqLatCSs
	 ow5KYOoNwcI12/cuJ3KuscvOpxvuyOCItw6VCJlLAxG3VmeBJQCvnN2s64FqdkvVEXtT5
	 m/p6M4PMxQnKnGNjKEqMdr8vQN1yL6oA9KJBU8o7c4KI24v6RcbdWEGNHzC8c37fmB+Oa
	 Ef+7wCk6fBTOY3KQRzG+CZJRSzGyroBQgZj6A8lLiAdhrn1mEo3yp1W0u9xZZcj4GXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=kpxOkCT+;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2290D606A336
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 19:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2290D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=kpxOkCT+
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-55d3563e50eso21365941cf.0
        for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 11:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794858735; x=1795463535; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jqnrRoTh5TcWr/Py+gEgzzX7wdMhzTlFxFkfLcpGuJM=;
        b=kpxOkCT+pWM2TGyut5O2+Ru+0lOZm56CgX7wTMMvKGwvUXf11CFtEKxq+aJt3Dbwwb
         pvOcAl30XQLNNLN456CuvUMdJzRpg2P3QlewFHSvcj1qZgx5IarEN/mM7mW4G3kPIlMJ
         Xk+/LtSvsv3sL3luFKFKbVqPL1CxE03Rrqma885QibbVysOD4cQxD+AXO5312yA7/A+z
         qOAYmBHj1xiiGhLeJt9PTH6DwlTnn6CPBvfwAgfQfyJQRp3yPja8F6avaClCHgfJzV+a
         sbTKc6jQyAODlgldvzvlcEwENNU/h+KKCELkDNGLXHCafRzmZWnD+ZqUU0lPkZzigPdq
         fzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794858735; x=1795463535;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jqnrRoTh5TcWr/Py+gEgzzX7wdMhzTlFxFkfLcpGuJM=;
        b=Ofb5A/JS1aYyE1YKF32DADO8laoFd3FXqv93ljIQkZHYcjgzwCg0RWjAPkNSBh83FO
         JlWlnvzXAstas6QW/sFGkCfMQTcom4ZdRllEzpVeoMpT4pl1gTe9HWHhla5OpJaWeURH
         8OdT+kWcuoo3qW3mIV782lB/mp4ZiulUtmhI5e0BBxLukIAe+Q3mOZmWOr1QO1InzJ9O
         rdeMJPLeGL10hyr8z6LB/UTqzEP03qwnh5Mx8F8ik3vLVbC4Mom5GNuEarfBA14iU+Jo
         +VcEQiqHxNA5JLz13BjphyaNnGKVLpTJsJT4TucvSWlM+5T72JW0K8ViAFTJqJ52TRWG
         JzpA==
X-Forwarded-Encrypted: i=1; AL+hErGvihVZ5oCQYDLRmwfXnXgX/pzTSXDp0Bd6Ta1g+d5Yq7bB+t1XZVt62qc3vKTwjzQwPZbif/+SN53olm8kcg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8LZf2SEg6oOsYABlbm8VNHANz6j3m9Mn7348HCmOQCB1K1juuz
	ta3wSvuZuzsnhwAevXaitIFARVhzp6q0OWlSkfLouWyU3s0kvYAezJr5gLNWbAkrGh0=
X-Gm-Gg: AYBFou2c4yzPMFNpLSvy/DHHdvY4D/w7K+kGocBsuNuMhskDrW0BDnauu5G+aQhG+1k
	D3/zS/YhBfZhTlJlTlDwsJtvcGd29zqUuZTyBTzLexrZhPpS9NgnDRjfY4OSGrs39mCwrCohH2u
	dZereVHY9os1qlPrefoAW2G6fr5Wu7b4c6w58rrpBLJAZspzvcfkhtv4hvFA/tVv2nc4mW8yt0m
	0bsBfDRi2Eb9Dglvn/e/i3rBW4iBg2XDJUYGuFzSklk8uB4E4Wcl4ZOXwQLf0eD5mQmvlGZFMTn
	ouPVMcxw4dTA+fkPa9Ez86DW+HC6ODTcZMTI5k4B5G2AlXejCBuDsdR3CqoEkaj8ZJda3c4FVtl
	GFL6QbLVaoRJnfA7aGPrZRzCXKU3bBkjLKVtMaAswBCD08lsTF5I65RKg5XrWO8mRsK3iJboH/a
	R9dDHv6ywaauTvLtD/+RHNlfxANfMfMMoEgrsPUP/b7I28S3A9iiqmXQp7iERYMweSP8D0bZ+Fw
	sag1xSWImwITdHC7CIZQyT+raGzaBqn++XjPjTW9KmBYS3hiI8DqEPLXHbf29caiTCVCpCf7lpR
	C/3h3A==
X-Received: by 2002:a05:622a:13c6:b0:55c:c7ab:4445 with SMTP id d75a77b69052e-55cc7ab469bmr121785021cf.29.1794858734926;
        Mon, 16 Nov 2026 11:52:14 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f8319d44bsm48973876d6.4.2026.11.16.11.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 11:52:14 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xT2kP-0000000ALbT-12cG;
	Mon, 16 Nov 2026 15:52:13 -0400
Date: Mon, 16 Nov 2026 15:52:13 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tao Cui <cui.tao@linux.dev>
Cc: akpm@linux-foundation.org, dgilbert@interlog.com, mkp@kernel.org,
	loberman@redhat.com, jmeneghi@redhat.com, kraxel@redhat.com,
	vivek.kasireddy@intel.com, mst@redhat.com, jasowangio@gmail.com,
	eperezma@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
	rostedt@goodmis.org, vdonnefort@google.com, mhiramat@kernel.org,
	kevin.tian@intel.com, axboe@kernel.dk, linux-mm@kvack.org,
	James.Bottomley@hansenpartnership.com, sumit.semwal@linaro.org,
	christian.koenig@amd.com, phasta@kernel.org, joro@8bytes.org,
	will@kernel.org, linux-scsi@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
	iommu@lists.linux.dev, io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org, bobbyeshleman@meta.com,
	mathieu.desnoyers@efficios.com, robin.murphy@arm.com,
	mason@kernel.org, aesteve@redhat.com, tjmercier@google.com,
	harry@kernel.org, vbabka@suse.cz, cuitao@kylinos.cn
Subject: Re: [PATCH 5/7] iommufd: account the hw_queue page array to memcg
Message-ID: <20261116195213.GF2452510@ziepe.ca>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-6-cui.tao@linux.dev>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106131829.3228926-6-cui.tao@linux.dev>

On Fri, Nov 06, 2026 at 09:18:27PM +0800, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> IOMMUFD_CMD_HW_QUEUE_ALLOC pins up to max_npages pages just to check
> that a user supplied queue region is physically contiguous, and the
> page array for that check is plain GFP_KERNEL.  The size comes from
> cmd->length, a u64 that is only overflow checked, and the array is
> freed again as soon as the contiguity check fails, so the allocation
> can be repeated concurrently: a 1GB region costs about 2MB of
> uncharged memory per attempt.
> 
> Every other iommufd allocation that scales with user input is already
> charged, and the pinned pages charge the mapper at map time.  Charge
> this array like the rest.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  drivers/iommu/iommufd/viommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
