Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E7639AEE
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="noB2k/cA"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22A3C83C29
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 14:44:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 22A3C83C29
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.a=rsa-sha256 header.s=google header.b=noB2k/cA
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CXHW8XbKMwIJ
	for <virtualization@lists.linux-foundation.org>;
	Thu,  7 Dec 2023 14:44:37 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0864883BA3
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 14:44:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0864883BA3
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c0fc1cf3dso10759935e9.0
        for <virtualization@lists.linux-foundation.org>; Thu, 07 Dec 2023 06:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701960275; x=1702565075; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2X1VjbagCGmP0A1RPcv7u0Lj03h4h1kkYCRRs2Iz0c=;
        b=noB2k/cAfOp4qLCamkgw5D4U7seOxvcnx4KFq9WsVjo69G9Ys4dUQCRCqYLWN1BYl7
         9DtHTX8x6dxYY5afofsrnXQbpk4dFQ/lX9N+Lb3QjNliJKmLglW2HuN82NLp55q01hzz
         tkAEfmNzoujVx9caItskSPzqTW53OJXwe7mo3avDMxlH7r12oH4tHtNRyBLTToyjjjd/
         jNGeqFUdNL2LOqdGVCkCOSCU8Hyb5ngDMeYdBOwnKru++TrBGElMIEJOAMCYjlwtRJEH
         4o0Z2oVBWqrVODsMRpX7kOyljVIE17bKxomIkSHaGaV/U+/Ncyo6NIiaKi3L3i3JuHgR
         lLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701960275; x=1702565075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2X1VjbagCGmP0A1RPcv7u0Lj03h4h1kkYCRRs2Iz0c=;
        b=jrmYpmeJxv9mvdHmgYum6uEqeuFaYQx2cHfmKjUGCnbd/rGFQvZdf/zF6cCimLuSU/
         9Kih9i3kM9Lk3sNYw5T2k/gA5lM4uHuaNMRjN02Am6T9uA/ngHemHqT7BGZlFa/SFOYT
         Vu++CL4AgCWqKlty/6GVsgrYJ1YTDSdiQvk+UaBeJqIsRkB5gglMFhyKqL0YjbaLbRwf
         ckxN1M+I05XEooXAQQsdRVLr/GC78+qn6SkFaxqMsguep8E8mIl5yoii+S3K8pAq+4Ej
         49Gh3td0cfpeycdqzbft7jWDeqc21qtugllS16/nyDKbxwxazLEWj3/BRDpl4vxhlMT5
         JeXg==
X-Gm-Message-State: AOJu0YwYOZtVrUn9yOyM5UWZXoThnN9WFrwJtuS0AkX5UekA1YqXQr7a
	BHVXU5Fm4SkIdrM3Ucdbi4izJw==
X-Google-Smtp-Source: AGHT+IGEefXECWySBl1DPw63VSb3ikjm82ZQvh2LqQu8KuTy/Eok7OvFLg1vm/cjL9Q+g3zwWxniqQ==
X-Received: by 2002:a05:600c:3149:b0:40b:5e21:d362 with SMTP id h9-20020a05600c314900b0040b5e21d362mr1858824wmo.107.1701960275098;
        Thu, 07 Dec 2023 06:44:35 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id q9-20020a05600c46c900b0040b347d90d0sm2180722wmo.12.2023.12.07.06.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:44:34 -0800 (PST)
Date: Thu, 7 Dec 2023 15:44:33 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	virtualization@lists.linux-foundation.org, anup@brainfault.org, atishp@atishpatra.org, pbonzini@redhat.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, jgross@suse.com, 
	srivatsa@csail.mit.edu, guoren@kernel.org
Subject: Re: [PATCH v1 03/14] RISC-V: paravirt: Implement steal-time support
Message-ID: <20231207-42f318822ee01650e550c663@orel>
References: <20231205181119.207204-16-ajones@ventanamicro.com>
 <20231205181119.207204-19-ajones@ventanamicro.com>
 <20231207-kindling-upgrade-22d29116ccf3@wendy>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207-kindling-upgrade-22d29116ccf3@wendy>

On Thu, Dec 07, 2023 at 02:06:37PM +0000, Conor Dooley wrote:
> On Tue, Dec 05, 2023 at 07:11:23PM +0100, Andrew Jones wrote:
> 
> > +static int sbi_sta_steal_time_set_shmem(unsigned long lo, unsigned long hi,
> > +					unsigned long flags)
> >  {
> > +	struct sbiret ret;
> > +
> > +	ret = sbi_ecall(SBI_EXT_STA, SBI_EXT_STA_STEAL_TIME_SET_SHMEM,
> > +			lo, hi, flags, 0, 0, 0);
> > +	if (ret.error) {
> > +		if (lo == SBI_STA_SHMEM_DISABLE && hi == SBI_STA_SHMEM_DISABLE)
> > +			pr_warn("Failed to disable steal-time shmem");
> > +		else
> > +			pr_warn("Failed to set steal-time shmem");
> > +		return -ENOMEM;
> 
> btw, how come this is an ENOMEM and not a propagation of the error from
> the ecall?

Hmm, I can't recall why I did that. I think I should have used
sbi_err_map_linux_errno() to convert the possible SBI_ERR_INVALID_PARAM
and SBI_ERR_INVALID_ADDRESS errors appropriately instead. I don't much
like how SBI_ERR_FAILURE gets converted to ENOTSUPP, but I don't suppose
it matters much in practice anyway, and at least, in this case, it has a
1-to-1 mapping which is good for debug.

I'll change this for v2.

Thanks,
drew
