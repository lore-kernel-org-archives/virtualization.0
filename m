Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521422C11C2
	for <virtualization@lists.linux.dev>; Mon, 27 Oct 2025 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586124; cv=none; b=ee+D7GtcMMQBzdTZ+WS8POQeupdlZD1q97ovlgUlDHmE6bzHdE4zvb8QHbeqf167GC9vBotF8ZEDAXrW4CJ3GokfB0KlZQHq37UKGWsdzmf5YpFlgf/d37wbTwqAmmC8lryHfSWt9sXGAiFRi2yYI3277VsENUmJ7l8apI7OMeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586124; c=relaxed/simple;
	bh=n15GkVGRlM82y8bsXWGWKv4Ru0ouDE1mhKQda2Lxd3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZND0E3wzzEfaL73kx45GIrbbM6f4yYBLPKFp7ZQUb+ktEZ1Kf0cUw7iXkUfJ+Fdls8ApTohcSXxXW0NjK4aBup2Pt/bjn8KloSqkzEyGYrl8ynlfM3Y4PRiOvT2EKxcmRvy84NiXMVl+YO1EUoOBCmz3Z7npoaDZXO51zCDw+gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6vdDxQi; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6vdDxQi"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-783fa3aa582so56073247b3.3
        for <virtualization@lists.linux.dev>; Mon, 27 Oct 2025 10:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761586122; x=1762190922; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gKbTf0ElmduUelZrYEJiaRrNvJO3TsTMSPfSoF30NGQ=;
        b=i6vdDxQi2SdLQo3HP+p68KakNG35l/8Rj4AWGIba+MZNede22vyWvTAnSMFMM42eTE
         8wCQbIQPguOacEYIZprbNutAvWFhn3Ut7KceRKMq2ISmrqUI3Q4IorXwlWK3YjnP+K8P
         bo4+UbBwldfF7tLDDr6hDv64NTK5oqMzbtg0adCirSi9M3/KMGBm/k5sZe8S59RmcwqB
         wxKe3grChZ8F1aTZMGoPxPxBRec7oIR3H8FV7SXHFKUBxE6pbfiYnW+XeNBH7qiiZOFI
         LCslZj/560b14F54yxJGlKKgmJqTjlYdMRiBgZbyrtdnCiVeOnsqSpL8B7JlfMyUDG0m
         nE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761586122; x=1762190922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKbTf0ElmduUelZrYEJiaRrNvJO3TsTMSPfSoF30NGQ=;
        b=jZzacIT6SPJKFFPfVujbbZboloihTf+SLVxk0SRMxPr6nyrS2ZJFwuRUlyc/e0qrxw
         +V8nZgEk4AIr2WXIFv0dSatFrXJNcJDgpUpERe3h7q4NXDk63Vt+qSGZpEmKd/qiZ5/m
         uKPrCQGoALDUSpv8Dr8HUSCwdAWg6KvYdqWhwg3GueQ0inbB3T12qe5J0ZAeu4CEMtCr
         g//vnq3iQ2L+hN9vKlQNCgAsn7uEpEoAB/wIOlVkzkwyUUXxauV8bjWMUxiEB2zUByjf
         cYZ5ZgxHOQNJnNn8VxnLJYVBuHHSqVrnTA50eyi7sp/GXzKpld0AmnvG7Hu/2jbnwE/6
         GwyA==
X-Forwarded-Encrypted: i=1; AJvYcCVFYGKMdzIrEYzI/DBqr30rCa/lDFXnJciLH3Qd+81C2sXAgStcGec7h/gtStde64WLLdvq7jDeRSw9szBu4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGAEuSgMZqOG3A6vcdNmF3te419md2xVWbvqiIkHf/oUYfmxdA
	EehYiQGEyIerOv39Omn7JBc/rR3LexoyrIqfgB5OnBIMxYwBaWMFVAho
X-Gm-Gg: ASbGncvSTi20Y+Nx7FpFXhZt8LMnaOM7CMQ4wNJEgjT8AAEygiHY14kXAo6iGW//elA
	BFrexvM/znYN1/17AmJPbYG0pqNTySMC2bTXrJIrCfZjtk2/iu0A6Q2GHp3iflMScadG5NtAa7Y
	24B5bYIMgPu5Cash0h9Nvj6TEGtx1tX8tUlOuIA8Ai3EOvUJxog1xPsxGKPejrrP6Rw/8HlHbiX
	+nPk16vIsXGggDk4BDm1WBFsURL+rnY2ghbPtKV4lOtVeAhDhP+jjtz5SzII29NK0GJbmkuHb8S
	2CYGG8qBA4KXbfV2ylcwRuO5t/O4Dvbugoyl63wyWxmJxyPdtecx+hENza9y38OQaLDJSMPm9Ee
	OF/kdEYMHkZCCQ6iykrCnucIYviSS4X6VKHDImji9UwbA1sevndDL5DMIrLx1pbG6NLzQ1dBZ8d
	tYoQOzJIaaU5QStU/sFrDGO7yV23ll6wcYEb/faUTA/0cn9A8=
X-Google-Smtp-Source: AGHT+IHM1NI9jlgl7YyHEw6xfZ2NvWKARzYo9jjqycdlEoc48MLVHrBBixAozXkHMEqVBYRHZIgJww==
X-Received: by 2002:a05:690c:9312:b0:785:eb11:647b with SMTP id 00721157ae682-78618357840mr4674427b3.33.1761586122152;
        Mon, 27 Oct 2025 10:28:42 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed1a4391sm20417647b3.33.2025.10.27.10.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 10:28:41 -0700 (PDT)
Date: Mon, 27 Oct 2025 10:28:40 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 01/12] selftests/vsock: improve logging in
 vmtest.sh
Message-ID: <aP+ryNxS2A45WT7f@devvm11784.nha0.facebook.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-1-edeb179d6463@meta.com>
 <aP-hpxMgB5tN7KJ3@horms.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-hpxMgB5tN7KJ3@horms.kernel.org>

On Mon, Oct 27, 2025 at 04:45:27PM +0000, Simon Horman wrote:
> >  log() {
> > -	local prefix="$1"
> > +	local redirect
> > +	local prefix
> >  
> > -	shift
> > -	local redirect=
> >  	if [[ ${VERBOSE} -eq 0 ]]; then
> >  		redirect=/dev/null
> >  	else
> >  		redirect=/dev/stdout
> >  	fi
> >  
> > +	prefix="${LOG_PREFIX:-}"
> > +
> >  	if [[ "$#" -eq 0 ]]; then
> > -		__log_stdin | tee -a "${LOG}" > ${redirect}
> > +		if [[ -n "${prefix}" ]]; then
> > +			cat | awk -v prefix="${prefix}" '{printf "%s: %s\n", prefix, $0}'
> 
> FIWIIW, I would drop cat from this line.
> 

sgtm!

> > +		else
> > +			cat
> > +		fi
> >  	else
> > -		__log_args "$@" | tee -a "${LOG}" > ${redirect}
> > -	fi
> > -}
> > -
> > -log_setup() {
> > -	log "setup" "$@"
> > +		if [[ -n "${prefix}" ]]; then
> > +			echo "${prefix}: " "$@"
> > +		else
> > +			echo "$@"
> > +		fi
> > +	fi | tee -a "${LOG}" > ${redirect}
> >  }
> >  
> >  log_host() {
> > -	local testname=$1
> > -
> > -	shift
> > -	log "test:${testname}:host" "$@"
> > +	LOG_PREFIX=host log $@
> 
> shellcheck suggests keeping the quoting of $@.
> This seems reasonable to me. Although in practice I don't think
> it will change the behaviour of this script.
> 

Ah right, makes sense to me.

> >  }
> >  log_host
> >  log_guest() {
> > -	local testname=$1
> > -
> > -	shift
> > -	log "test:${testname}:guest" "$@"
> > +	LOG_PREFIX=guest log $@
> 
> shellcheck also points out that log_guest is never passed
> arguments, so $@ can be dropped. If you prefer to keep
> it then, as per log_host, it seems reasonable for it to be quoted.
> 

Quoting it sounds best to me, in keeping with log_host().


Thanks,
Bobby
