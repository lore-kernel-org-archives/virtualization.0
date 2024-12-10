Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDCF1D0F7D
	for <virtualization@lists.linux.dev>; Tue, 10 Dec 2024 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733819701; cv=none; b=uOZ7Qrs6pXClgEY2mdM+MYFBxbnd7q4vzS9O59C6sIgFIJseCw+i7RIpJuZ9aHZU9e3+ll2d/R5pTT/CjEIar3m3vCxSi+NmRHjmF+pbjoz2C77dYhvmO+X5w6MuOYSN4MRO5EMSBhjyL3jCjt1UR7SlnYWL+/zYWuTQYeiQXug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733819701; c=relaxed/simple;
	bh=wtEErwm73cQ2rOGj9k9xrv4m4nhthfX4sbNep7CqSEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iR9rmQmd059M3w5mGBxrE73/3vHNALjQ3NU66xIYjfmW0NHDo9DSWgvvRxZbY1tU24UyT5GEHZHi9x9844WvH0V65t1jnU+OTy373ABZ/WDS48gGmn9jc7njBBrpOLwsu7a0MuoJ/zFRT2r0HpK5NZYV0VoiXjZnqb3u937OgwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ngcqqcDt; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ngcqqcDt"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434fa6bf744so10742935e9.2
        for <virtualization@lists.linux.dev>; Tue, 10 Dec 2024 00:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733819698; x=1734424498; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yrf+WvkOKiGkMqw3dviA29flRd+xELZ0zbYVi2hrty8=;
        b=ngcqqcDtADDBJgjoR28q3gsZ5r95y4XEHbf81hKKAsGViwQboTsIa6uu9Qzksxoos/
         e2+krEwEKwwoPvCexH+SIPmMQ/D5WqN9D8CVEIw5qF26Asb22N4P/TqZHjFltYX+W2yw
         OeXoXXzt3SC0DDRzjMFWzKxs6aysJpFabQ4/SMtRKSFSdj+0JJLbbiRQgI77Q2qRxmPv
         KiiRJKcbN9wsIlxTIRprvWWiw4/u9MVmEgR3roFWJtlgeM3ONZWzsdoPXq0ugyanOqxC
         vhmyyScHcOsPtUTMwzvSWDbiCV1KEm3SN03s3xR2HPKFmEdSW53ZsQqXaAfM6KuCtLMO
         Bawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733819698; x=1734424498;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yrf+WvkOKiGkMqw3dviA29flRd+xELZ0zbYVi2hrty8=;
        b=HpeopUCXUjp05ZuJaX5clNXIFsX/t4mxZwNL14eUp9iWFTxprZ/+72dCl/03M4r73V
         YGP0IzB8d54vqLUEuCi317AxSR2RFahClZa6DSNri8OpueiI2fVX7FGrJanDS9bk5Ad7
         xqDht7FchOgpxUX6o+jqlSY8bl+DdqE9KO6mvz9wTggFnAZWXZjGnAx6aVCIwkdB29ZE
         KKZ7Yod9l9h7V3VFFU4OCHNZVQTlekMXcUS4UcKjxzDlWP2N3TSp+pKogQdP6TafR3tx
         kVbMBmYpxnGmdu0xYqA9MhJS3LFe1sdM5b3ptWkxqOH6Vp9izgqO3bgn+aTK+aNfRXnV
         XPYA==
X-Gm-Message-State: AOJu0YwjlJaVeir6qH0oVBqpTdDk3ZfbeTNK8VFLxqqhv6UP7/iwpPaq
	Ey+IPkXYw1OGBo+H5vMzzCacq/fuclh6FIxTQP0hQ0vbtoDrYh4GIBDrlGP+dL8=
X-Gm-Gg: ASbGnct+PGiTqGoIWNiZ99/Lk0TStObf69H/7v8b7Wr0itUa8IZv/Xq+0pVsk/Q221G
	34rYTlRzPi22DjhLc+W4WeI4+J79tftnjAa5+Pgzl7TFZuhSbcw1369Anss1HccYlu+iKLMf/uB
	1DciH6pavxobooYNGFxG2gUPuj0YqeYrAdjbWIEPboFwgf5ucBX2omjlxo6H1tH6b7PmrbFlBc/
	3vVAsjWdx2mwadMrs0VKtawepBops2n6j77HqzVgrNaMlND2jSNeN8ssx8=
X-Google-Smtp-Source: AGHT+IG1S1xDlXh/m0/nFP593nGognxwAcIzU/2L7kz1te4essYbZdEnexsjXA/jdQwiAiRSDcIaew==
X-Received: by 2002:a05:600c:3503:b0:434:a902:97cd with SMTP id 5b1f17b1804b1-434fff6f8c0mr30408055e9.12.1733819697763;
        Tue, 10 Dec 2024 00:34:57 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f7ec35b0sm52265315e9.1.2024.12.10.00.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 00:34:57 -0800 (PST)
Date: Tue, 10 Dec 2024 11:34:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: virtualization@lists.linux.dev
Subject: [bug report] drm/virtio: Add helpers to initialize and free the
 imported object
Message-ID: <11eadf70-bba1-45ee-8d28-8d40b196a442@stanley.mountain>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Vivek Kasireddy,

Commit 2885e575abc7 ("drm/virtio: Add helpers to initialize and free
the imported object") from Nov 25, 2024 (linux-next), leads to the
following Smatch static checker warning:

	drivers/gpu/drm/virtio/virtgpu_prime.c:206 virtgpu_dma_buf_free_obj()
	error: dereferencing freed memory 'attach' (line 205)

drivers/gpu/drm/virtio/virtgpu_prime.c
    187 static void virtgpu_dma_buf_free_obj(struct drm_gem_object *obj)
    188 {
    189         struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
    190         struct virtio_gpu_device *vgdev = obj->dev->dev_private;
    191         struct dma_buf_attachment *attach = obj->import_attach;
    192         struct dma_resv *resv = attach->dmabuf->resv;
    193 
    194         if (attach) {
    195                 dma_resv_lock(resv, NULL);
    196 
    197                 virtio_gpu_detach_object_fenced(bo);
    198 
    199                 if (bo->sgt)
    200                         dma_buf_unmap_attachment(attach, bo->sgt,
    201                                                  DMA_BIDIRECTIONAL);
    202 
    203                 dma_resv_unlock(resv);
    204 
    205                 dma_buf_detach(attach->dmabuf, attach);
                                                       ^^^^^^
attach is kfreed here

--> 206                 dma_buf_put(attach->dmabuf);
                                    ^^^^^^
use after free

    207         }
    208 
    209         if (bo->created) {
    210                 virtio_gpu_cmd_unref_resource(vgdev, bo);
    211                 virtio_gpu_notify(vgdev);
    212                 return;
    213         }
    214         virtio_gpu_cleanup_object(bo);
    215 }

regards,
dan carpenter
