Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A015207DE3
	for <virtualization@lists.linux.dev>; Wed, 12 Feb 2025 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739360506; cv=none; b=SDQ7ne3o/mUUg3wj58VUJ9hkM/m2zc9OZZDV0Dsv264DfYZMMzVfR9YZSOtZGlKEVpX7H5is96a7qxngyBRLunn8A3c0xveg4B99MN9af7vM7AhOS0CKRyUEfzPrrUxRa1wHzS5iv3wWzrGY6DJv/TYDmDOPb5ipVyO6gQlLVSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739360506; c=relaxed/simple;
	bh=JeJ2jv2BwBrIa809Su81UECkCgacincdGK1guJn4zFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbRDp1Np3SB592+gNChaGj7zWATnLKhZ4+R/t9YzQjPJDykwZNhKrhxCwpvc1WAgX6qtkmymfOXFkTEeipfXQ6EX7iQnzqblm7fozhozZGoYPOUTMixZ67wBr0M2v9GS2WcNbBDpaGyxxxqRykdnjuhd9v7bhpybCwyC/FWtv5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nUg7uXmJ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nUg7uXmJ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab771575040so145285966b.1
        for <virtualization@lists.linux.dev>; Wed, 12 Feb 2025 03:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739360502; x=1739965302; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w0j3HfohIwJISbsXU0pbsmUuYrw+P0a5WGZgVgQVxGg=;
        b=nUg7uXmJIUCrERG3bjVNPl37T2ZgJ5zN4zU/nJGt90LAYWhwk7NDAYEjgMOvczwfUD
         oiNG1hWDQES82AJ9KBgpDWyLzLjzDEdSr+74+2zA9wQKhe8nlanGUk9l50g+TZX40P51
         q+91SFG5r9O79FssedaApFqmDUud/zq7s91QsrLNzELJ0fccmMOZinTxl+AxpQKOLIA8
         8UMll2uui2QvCojA/kyEgHqxpP3tiqtpyeG7nOtYrRCECPNhq54xTwc/Fy7UfrUOuxin
         RkCuRmxWBxJ444uMxWdCn3yp8uYBYcXfBaztexgGNVblZAVOuYy7fnnibMZZMk/Fy2e/
         8v+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739360502; x=1739965302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0j3HfohIwJISbsXU0pbsmUuYrw+P0a5WGZgVgQVxGg=;
        b=UrYQDvj3bpI9GZToFtD0aO+rH4W771kQdxcdAv0rzKriQViDXjZElpPTJXMJ8e8hyH
         RE/mZ8ugUgp/5NqaEZiH4n2jEAwZ9016swFWm/G4Kz3TknklsZdOZN91s3bVXeFkdVaX
         CvAbxYqlZU5R4g4ayAxUi24dgZHK5LEoEZXiUoQKigMo6tHb2ugmuIJwEptVj5QfzvjK
         pk8Nl6QU1+h0M30Ler0bpcYrZVeC+uR4kY1a7AjWWyL1PJkwRB+byYCdkbXPtd2/CqRH
         fwp+t8HzdOV+eld1Ynl6z+/yBUx/UK/MBDq/0cxAbEpfPrCO/xbr4yDIfnrv0PHBUHwC
         FEqg==
X-Forwarded-Encrypted: i=1; AJvYcCWFLNKx7zdH5Yf7eiC6+2HQVD4MA3/B9zx5XmYTwKb730ctmxZ4V1EOTvY9IZ0NNYayRfi0x/uHUL0HiH4IIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzC2q8SSPf9y7CzKWgdVay0Jd80b2epzefKMwG7fryye5Jx+0G0
	fhKgpjsyeIWMROjPZLvwGi+/fTa/uWD/bNhovvi/rcYdeVHKEr/PEwCX6x8egKc=
X-Gm-Gg: ASbGncs5D4D+191S3yOwlNC1EI26KVj7s3WYo/zsTeKbqyYZbFUY00YiA/ZdNbYhrps
	HDM2LeRlLWEbE22oI6d1TRDHpt8703E+LZYCzIogDAytAfhDhDHLI006HwxFwcW92rQGgY2zCvZ
	qwCFdOnat1+Qy1IuMOfzj8KRS1wcMIBP/QsZdOqcb+y137Wq1mXeog9oexQShdh457exaxYlrsV
	ZTM1GJ/IG5+qW/rK+hGa+WL11zM8WrSglrhHRYWXfIGRJtMRYAtFz9PA2MJQOiWs42nHVee8heS
	HsyCnNJQl476bzcU8lQf
X-Google-Smtp-Source: AGHT+IGjOAjmf6XjmHjeaqxJH3+fWyGiM1rw3hi7aac7PC39lxHRaWXOjo/vo6+0foG0vbJvgDt8bQ==
X-Received: by 2002:a17:907:724c:b0:ab3:992d:d98d with SMTP id a640c23a62f3a-ab7dab331c9mr726269366b.0.1739360501945;
        Wed, 12 Feb 2025 03:41:41 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab772f893e9sm1267296966b.65.2025.02.12.03.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:41:41 -0800 (PST)
Date: Wed, 12 Feb 2025 14:41:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, kvmarm@lists.linux.dev,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	virtualization@lists.linux.dev, Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: kvm: nVHE hyp panic at: __kvm_nvhe_kvm_hyp_handle_sysre
Message-ID: <3902208d-8814-46fe-ba98-3db833b9a886@stanley.mountain>
References: <CA+G9fYt6Cuu6=OO9w80yhJbZB77Q0qf7nzYdvjbgDbgAw6t1jw@mail.gmail.com>
 <8634gku30g.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8634gku30g.wl-maz@kernel.org>

On Tue, Feb 11, 2025 at 11:36:31AM +0000, Marc Zyngier wrote:
> For the crash at hand, which clearly shows nVHE, can you report
> whether the following hack fixes it for you?
> 
> 	M.

No luck, I'm afraid.  It still crashes the same way.

https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/anders/tests/2steTT4f2J8ZJjc3jNJFMuow9Cb

Click on "Logs: html" for the dmesg.

regards,
dan carpenter

> 
> diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
> index f838a45665f26..cb57420a07de2 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
> @@ -556,7 +556,7 @@ static bool kvm_handle_cntxct(struct kvm_vcpu *vcpu)
>  		return false;
>  	}
>  
> -	val = compute_counter_value(ctxt);
> +	val = compute_counter_value(kern_hyp_va(ctxt));
>  
>  	vcpu_set_reg(vcpu, kvm_vcpu_sys_get_rt(vcpu), val);
>  	__kvm_skip_instr(vcpu);
> 
> -- 
> Without deviation from the norm, progress is not possible.
