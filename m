Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF7B329C43
	for <virtualization@lists.linux.dev>; Fri,  7 Nov 2025 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529716; cv=none; b=ps2TD3eXAuacD0hNnx4AllZa1eKnGlWvJa6e6HTugtAUDFMlrsN6M6ow1cwFbhPJ3lg8Qjy1KOquAvkyzIAh6LdPeFbo8lTyknwsDomQTudwFCIPeGctjQXL8t+HdCAaXEO8NLpAuOpSbV+uifQTpjyHWTMSWkl/dYt4iRdEt8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529716; c=relaxed/simple;
	bh=7m90U4fRlmTtbaduAz/n40bucosBtxg2Nlzb525AIWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zli1NZdInpqk0BWXq+R1T/HShKcI0ketG/6CtZ+vWwG8q7sT4wRQ6mx2pjZkAESLJ3NxB640LPdOooU9pazxrDia/0DtcXDzoo2NXGiftkeZNmyEkDx/6PligtumN+5MrQmHb6kjRE+HhiUA02wZiwl5d5n1iaGCYdZNG1DNtpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dm41dxIg; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dm41dxIg"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7814273415cso6809517b3.1
        for <virtualization@lists.linux.dev>; Fri, 07 Nov 2025 07:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762529711; x=1763134511; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hg5UfzPKclS12jZ/MM0cVARNy4+o8xhJZIOiFJg4L64=;
        b=Dm41dxIghWsW/X+weMBu0DSzHvXknpsy5WsouoPPUteVan3fsvRxncb1QlS+Yt0vhN
         0HEg05QLDkrqAh/UUrD7inNHFiN0KBksBVYYVRrM7vwxbtlkvY5Qm8Jfyge2X4fw9h0c
         4sarYUMkLZNBDv9opXUNI33osGRa7kUYB9s5wYB/DCrMPwW/2FiCneYxRE8yfzDmho1X
         QtlShH35fN0zLOsjCBpkjIB7x4FRCbYO42BS42QyMCPQoiOHMAXKCJ8c47RAFoV+HsXh
         HRq4B2rLdYGcoXmwTyd6veF0NoKjTCsFQF0jtcuMD9uYT5IZBSWEMQc2/ZMHc5xUcqaH
         DPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762529711; x=1763134511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hg5UfzPKclS12jZ/MM0cVARNy4+o8xhJZIOiFJg4L64=;
        b=CCCVp96zLXZsSBT/5r3umAQMpR9uK4Yz+nn25gL1NkKMDqGEwscNZ51hxyG8jRG9G6
         K9ovVBNKOIpJG8kdpEbO25BcLsgRZSbpc4O0TU5+iYGWHIq63XBsA5ozLoTmBsA+fhaL
         iXnqjITPqK/KwmgbT2XRMIrbYgRPkYix+RSsJgulawkFB/UgAxXs9bW1D2L2mUT/JqwO
         A3Bjuris+WAh6wmkEdeclynZc1QX5U0ly1yTEg9IE0oSWHxKIveSWvtFQYFpoSZZGDw3
         EFSbKgvdHD0amF4YKQyGbp3TPRCIFmwP4IUT4sMnF7lAU88sKegK5wCp3eqG4JkzgRSU
         xcGg==
X-Forwarded-Encrypted: i=1; AJvYcCXbqPoG/Ur69veBNE21SJD6D68PPmil1iJPp3Z7AEysvUHW+YdzQ5h7OD6vKXu87geZeycmgXtjjV0bIj2i3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YymF6nw6ceGcWcoBE+u+flGkMDVtJnA8GjBvSwMfb51GLn7o2vC
	OmjkLzSCnSyk1bu4k8K33RnSWu2uVxoRIJAjDOsvKQYu39u4OQJ+Pru8
X-Gm-Gg: ASbGnctwcr0w2Ne4DzQ/vBBEH6Iel2VZXxXGiqpnAc91zTM5ntOJiEGcn51xDLleice
	V6kmZ8kHRr6vJCbL4ZqAhUeq61yWMDn7aTTk/a74xYbMsilsbIlQs2gt+y3/OjbOaFKew0X8TXO
	+DGJrH/2XW5GWmL7Gs5eTv/Ij4VNhoQ9H7cdysk/2aB0ednO4lC4ozIRdVirghte4m1l0qAOXaN
	D8vsnKkoD9ALJypghQ9LF2fcmZtqFp51ny7yE+GHRk10s0nLvj2L9O7/5DYwwDze1+FK0iXUMV6
	XnpXF7nB27tR2GsMc8mr8S5u8MDef8mIRioFfZlvckCtQhkFxbDr7xhc9RFB4WnGWN6C9SpaVES
	hxhlZChyg3zX3EJphS30OPsR+M2wXLMt8puMkiOsntK6VbKIUEksYO4GfVhHqtdEUcRPlGzzcoJ
	LJqXSKKBSqLOslqfsP+VfH+MdFrLdJYh4L0/YF
X-Google-Smtp-Source: AGHT+IFwUXomSgFrXOP5T+Zd2zXzyVOrxyGJXDnXPE08lhO8nln1/YwLRBm5iwzEweMUqR/HaaHj6g==
X-Received: by 2002:a05:690c:360e:b0:786:a984:c064 with SMTP id 00721157ae682-787c53f0603mr27190947b3.35.1762529711161;
        Fri, 07 Nov 2025 07:35:11 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787cb4db618sm4770327b3.32.2025.11.07.07.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:35:10 -0800 (PST)
Date: Fri, 7 Nov 2025 07:35:09 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 04/11] selftests/vsock: avoid multi-VM
 pidfile collisions with QEMU
Message-ID: <aQ4RrcB0tzMWch1S@devvm11784.nha0.facebook.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
 <20251106-vsock-selftests-fixes-and-improvements-v3-4-519372e8a07b@meta.com>
 <aQ4LaUi9wTnEN8KA@horms.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ4LaUi9wTnEN8KA@horms.kernel.org>

On Fri, Nov 07, 2025 at 03:08:25PM +0000, Simon Horman wrote:
> On Thu, Nov 06, 2025 at 04:49:48PM -0800, Bobby Eshleman wrote:
> 
> ...
> 
> > @@ -90,15 +85,19 @@ vm_ssh() {
> >  }
> >  
> >  cleanup() {
> > -	if [[ -s "${QEMU_PIDFILE}" ]]; then
> > -		pkill -SIGTERM -F "${QEMU_PIDFILE}" > /dev/null 2>&1
> > -	fi
> > +	local pidfile
> >  
> > -	# If failure occurred during or before qemu start up, then we need
> > -	# to clean this up ourselves.
> > -	if [[ -e "${QEMU_PIDFILE}" ]]; then
> > -		rm "${QEMU_PIDFILE}"
> > -	fi
> > +	for pidfile in "${PIDFILES[@]}"; do
> > +		if [[ -s "${pidfile}" ]]; then
> > +			pkill -SIGTERM -F "${pidfile}" > /dev/null 2>&1
> > +		fi
> > +
> > +		# If failure occurred during or before qemu start up, then we need
> > +		# to clean this up ourselves.
> > +		if [[ -e "${pidfile}" ]]; then
> > +			rm "${pidfile}"
> > +		fi
> > +	done
> >  }
> 
> Hi Bobby,
> 
> This is completely untested, but it looks to me
> like cleanup() could be implemented more succinctly like this.
> 
> cleanup() {
> 	terminate_pidfiles "${PIDFILES[@]}"
> }
> 

Oh right! I reverted the deletion and completely forgot about
terminate_pidfiles().

> >  
> >  check_args() {
> > @@ -188,10 +187,35 @@ handle_build() {
> >  	popd &>/dev/null
> >  }
> >  
> > +create_pidfile() {
> > +	local pidfile
> > +
> > +	pidfile=$(mktemp "${PIDFILE_TEMPLATE}")
> > +	PIDFILES+=("${pidfile}")
> > +
> > +	echo "${pidfile}"
> > +}
> > +
> > +terminate_pidfiles() {
> > +	local pidfile
> > +
> > +	for pidfile in "$@"; do
> > +		if [[ -s "${pidfile}" ]]; then
> > +			pkill -SIGTERM -F "${pidfile}" > /dev/null 2>&1
> > +		fi
> > +
> > +		if [[ -e "${pidfile}" ]]; then
> > +			rm -f "${pidfile}"
> > +		fi
> > +	done
> 
> I think it would be useful to remove $pidfile from $PIDFILES.
> This might be easier to implement if PIDFILES was an associative array.
> 

Using an associative makes sense, this way we can trim the set.

> > +}
> > +
> 
> ...
> 
> > @@ -498,7 +529,8 @@ handle_build
> >  echo "1..${#ARGS[@]}"
> >  
> >  log_host "Booting up VM"
> > -vm_start
> > +pidfile="$(create_pidfile)"
> > +vm_start "${pidfile}"
> >  vm_wait_for_ssh
> >  log_host "VM booted up"
> >  
> 
> > @@ -522,6 +554,8 @@ for arg in "${ARGS[@]}"; do
> >  	cnt_total=$(( cnt_total + 1 ))
> >  done
> >  
> > +terminate_pidfiles "${pidfile}"
> 
> I am assuming that there will be more calls to terminate_pidfiles
> in subsequent patch-sets.
> 
> Else I think terminate_pidfiles can be removed
> and instead we can rely on cleanup().
> 

Indeed, later patches will use terminate_pidfiles() in between spin up /
shut down of multiple VMs.


Thanks again, will incorporate your feedback in the next!

Best,
Bobby
