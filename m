Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EB73E451B
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107503; cv=none; b=ccT+5c3CkNj3Rv7rpPb8gy0xPnRnbBVPtx6LBAfAdUyBST7yk5FnXExZ+nexmXbol5jk/FnM0VqWWFCOklqIU2pgvwzB5L9c7g1YEgZ9i/JX9p4lby/9U+4mPcdFeUXEqLZo+DfGpO8/qfWg/C5n35VQrVTNkRgAUf5YJoPGlvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107503; c=relaxed/simple;
	bh=iPWrmkF61hhgDrfdhx2sDEgmxSHFvgrtBMkqLn5NWM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnC/BVnjthfAY9e/+WjZCr72CsRA08eQBCw/xHkQNoMQb3+I3n0hmu00X1XN83XA40+EneVDN0tTb7seHywdTCB+NP/ogGLto75fkx1KL78DvDDUrgzy5hH8Kzdhyg+DTa8XNAR6gOsTcqBsBs6PRLm739l3Nqwrr5rh/IcNWj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vc+JFGA/; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vc+JFGA/"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6a183eb9689so1159645eaf.1
        for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 02:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784107501; x=1784712301; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/fwrvNCfOtzaCne3uNFOCI3Grgc/63aOZ4fSOfRp38E=;
        b=Vc+JFGA/pOlCz29tL3rgk8pIw+H5LuTlp0zLCHDnvqjaEQeUnN9ezHCMD8dHP74Xpu
         xRBta6M/BPKV8FVIoTJnLaH0dP2av1NlhsJ7/4zDf6y1yLjqJN4qtftTo37BkhRSZt1w
         BT9vNmTN+Zssrizg/4V/9DfeDMCvkhgKrglGEhzjbk9G1uXoSHWJNseVUFm8A0RfdXEH
         WN2WaFsfCnqa8BhpfyFT3tQ5eLctngwoqT+053nIRMVkX4KOubf+qh4rkGVfTLPyrI+C
         qJzOKwj6zzQUweNW6Nx+NV7z2jM3LmpDQs8scf42OScRL+Gnx8n/lUQIj8AU9MsCtP3u
         4gdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784107501; x=1784712301;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/fwrvNCfOtzaCne3uNFOCI3Grgc/63aOZ4fSOfRp38E=;
        b=QqB55AGoATxmEeS9eevdSo3TaHvco47iyOHP/I/Ah4alBjhb9MNGx1gvME25PjWfsh
         UylR8dzHqkvKrC0+t+bK6G4MDWrQLNetqHWHKIZyG3fZ8bayjF/znLPlCOZFnfc7w6RL
         LNAA9fguYtGGcBIO/DM2Px3J9SWlBtVKZOaXwkMC/VwtiJNjTa8iQ1m9XfjE04ILUqLX
         MaXDHTvRzmG8MHZIDiU0ihRqCe4X+cBJRmANttHAbtmx0Y+ddr+2OijOGofa5pg/7N13
         9EQ6adK2zlHM7PEpkSDSnGT3ZWYSSyAaM7gSKRcgqHOGaG+s9wJI+9nJz9D2bH3JbRc5
         XuIQ==
X-Gm-Message-State: AOJu0YwCClOJ4jfuYpGsYi6X1AFCQywwTEjLgiOEYl7UZuSF9AcklcxO
	8hk0qn1CqkrpoUUGBlFndW6Sjmo7ZBFQZOhnCQmC8+AdLurou0Hakmbf
X-Gm-Gg: AfdE7clF2MH0KGEeVDikcr/xCJ5w8p1nG7V17dIVRD0MqEnUHaxZrYpLHr5xMoNo7Zy
	8se7nAMDjX42PR43/KBoX8GeuvF3e6ncXX6sssDcS+5u9pycBh8AL6R7cfuCNl7IxRBTmJBH5Da
	Sbl4Y9+wkBIF2y3GafiZ1mw3fnUyC8EV60fZiWHlH0N/x8vWyT2KTffy1gs/aDBA2g75dUuGZk2
	1VsDHK8Ya15NUCtfJrxbtaNrFGCwSNgFwAt7wecSqZ/jZ3hiNCRF/OjGc9/h5DdS0NgqUoobf8N
	YZsegb49DpHeWqvU3w3EfJbvKhhwP+/ExfUC6hrz5XU5vmfH1pop8kPIxEhxHokk/7pwhYKXzmb
	4Twkg3DfZNFONSDMKfvfB61sgAy7d92Xppxk7jrwr7/zkwjaGhcb0czGq869Jwx+Jpoymy+4mso
	r5XD3HBX7D3+A+Ym4Aai58t4mCblnJDNRmUQ==
X-Received: by 2002:a05:6820:1ca7:b0:6a3:1063:1a8f with SMTP id 006d021491bc7-6a39a6692aamr9828821eaf.19.1784107501071;
        Wed, 15 Jul 2026 02:25:01 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:4b::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a38a4bd734sm9815568eaf.4.2026.07.15.02.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 02:24:59 -0700 (PDT)
Date: Wed, 15 Jul 2026 02:24:53 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Weimin Xiong <xiongwm2026@163.com>
Cc: virtualization@lists.linux.dev
Subject: Re: [PATCH 01/12] vhost-scsi: improve BIDI operation comments
Message-ID: <aldR5cNr3SlVoBX/@devvm29614.prn0.facebook.com>
References: <20260715080906.21689-1-xiongwm2026@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715080906.21689-1-xiongwm2026@163.com>

On Wed, Jul 15, 2026 at 04:09:06PM +0800, Weimin Xiong wrote:
> From: xiongweimin <xiongwm2026@163.com>
> 
> Replace FIXME comments with clearer Note comments documenting
> that BIDI (bidirectional) operations are not yet supported.
> 
> Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
> Co-authored-by: Cursor <cursoragent@cursor.com>
> ---
>  drivers/vhost/scsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 9a1253b9d..81e905c4c 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -1047,7 +1047,7 @@ static void vhost_scsi_target_queue_cmd(struct vhost_scsi_nexus *nexus,
>  	struct se_cmd *se_cmd = &cmd->tvc_se_cmd;
>  	struct scatterlist *sg_ptr, *sg_prot_ptr = NULL;
>  
> -	/* FIXME: BIDI operation */
> +	/* Note: BIDI (bidirectional) operations are not yet supported */
>  	if (cmd->tvc_sgl_count) {
>  		sg_ptr = cmd->table.sgl;
>  
> @@ -1168,7 +1168,7 @@ vhost_scsi_get_desc(struct vhost_scsi *vs, struct vhost_virtqueue *vq,
>  
>  	/*
>  	 * Get the size of request and response buffers.
> -	 * FIXME: Not correct for BIDI operation
> +	 * Note: Size calculation is not correct for BIDI operations.
>  	 */
>  	vc->out_size = iov_length(vq->iov, vc->out);
>  	vc->in_size = iov_length(&vq->iov[vc->out], vc->in);
> -- 
> 2.43.0
> 

Hey Weimin,

This series is probably going to be ignored. Comment-only changes are
almost never merged, and the code changes here don't look like genuine
bugs.

In the case that there are some real bugs, I'd recommend to setup a
system and trigger a bug, and provide a reproducer.

Best,
Bobby
