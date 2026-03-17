Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFD8396589
	for <virtualization@lists.linux.dev>; Tue, 17 Mar 2026 21:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773783666; cv=none; b=DzHIxeAIQabdmFHne13qF/8KYC+pAf3+U3twJPs9USe7WPZLTJ2o9z9izONur6Zn3jHQ6qIGaSuwT/0/rjoeN1D3oiSpjp3E9OBo2GkexWRdlyFKaO2ybnhZRrX4TcADjofkVYLrDgtcclTE8szHut8prsizLMuXE9TWXItv1WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773783666; c=relaxed/simple;
	bh=09hOL83tVBr/LihHmyAvXs8Awpdqkkb+fou4oZHmcko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhaXMEJJY1jlV7zeSbkv6lvo15QzV+XpffW0QJJLQceGBpoM40TKkRWbmUHWZbouzR88fBSu1aL16n5pcZNXxbXwed6PDh/I0DbkxM/potwPTJn7c0CcIXMDQm14w3kk8nF7/xz4YHLFa/UCiSwajDF8tKqiUmkPPZxncGi/P5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zy0C2IAs; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zy0C2IAs"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64ad79df972so6821460d50.1
        for <virtualization@lists.linux.dev>; Tue, 17 Mar 2026 14:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773783663; x=1774388463; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fdMk8K9gKZoM6sms8pJWkdJXlxOeTpf/a44ocaiQWz4=;
        b=Zy0C2IAs36yuX0W/LY/cRS5/a5a+YkMZRKrqxXw8HX9W88fD17jpfsl3MmwJLecq4i
         e0F/QY5kuXPMzotRmpegcMYluvd21ftC3zGKbLzE7OqeikCx6Ibl1mNOqHE3oFzPAAbl
         i7Vd0Pi0WZZT1Fpkkz8aNEx7HSfBq+knHIKpYfL3frUShH8x5BONGuYuS/Kajc9tuqQp
         mCtTBbbldkIhKDEqaCaTyTqexl0q0I9Xdu9yMSaD5JhzIj9NB9UmGwwL11K7P7ob3Odz
         Uyt+Oaqfdeo+kbVhcanh6rk+psZ6kywF9VCE6g0L3Mr21I7A6+oDbQbKokZ5Wz5NG5sK
         RRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773783663; x=1774388463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdMk8K9gKZoM6sms8pJWkdJXlxOeTpf/a44ocaiQWz4=;
        b=MyPQtLR9NSex87PixWbn9S1iwyyKIsBGwKUtsb+5hdV2NZcZTn4t+9H2fUhTHPAs/T
         uTKL74Jycpy88f29H7TdWbmRkdJ/KRvbA3sZFM/omMoG98qx3cpS9RQ7o8GVamiUMA6f
         ZhNCrqY7aTLXWoccaR6MlBSdTkvlBJ9rZcJZXzP8CbUlV6duiEp1mpFF/Zlc9h2d/iWk
         lJ1mPRfdr2ZTG+5Xy3cuRbPp+TK9e6DvZVKTNxqX897fa2/7MNVrvtLXyACBjlLzLxuO
         YbHjjpRwviKJ8o7KrJm+2qJUTWJrznteG2oZH7BGHqWN27oBkcPkEvVPkMjOPjesGEgP
         kBPA==
X-Forwarded-Encrypted: i=1; AJvYcCUgAg2tL3arU2K807Pr6MqXty9NugTat1MdzpanAn1YrIp5pwdd6ObpHxSLmvgtRVSYWclNhcalFg4h7mE1+g==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywo5K2JXwaKrP+6mfU2HPG7LlzCveu1azjNtfEohi2OqCSNTDyt
	6yEk6z8jIOl3A+wiVJ1Bmhzi0D8bjQ8XIv35v/z5hxrdbCTshRuX9CFv
X-Gm-Gg: ATEYQzzWFdHR6eNLiZf6Nb4KTAD5GJnEEuaXK1IoicT1paFXuUTRkkWjoXh5ZSY0Vsk
	hnkCkVtD3ciy6uNUtvj6G+C4C+mOte1/QZjyvs8nFWT1rfwLlXwMriTsUn/aIKJZ7NX9jodGqka
	LxbsbZpzIyRGco1ad4uqB5WKTIzQ8fsbIRDwC4flDtdSbtJHg/XG23+qQR1n+ljQhCpU4vPckQe
	5/ZM9wefcc9qWjapt4/abxX2CdnI+RomjOKdiWly8Re7ez3t+BsdKOTopQYjJ4v4ujx3tyBbKzA
	sVu4Hk7F1qMRQtJpj08ZCEHFtfDBU5s8zNK0JMuIVrI98FsQkI3F4lTPAzU90kO45XZF6typNtw
	xm+rUgG1SZXcOzOXhrEvkSDaU5nB5YuXXLyeEj1N7O5So63seBdWDHS5E99yl8jmYQUCk1YPvXl
	8D0amAdILd6wlJ/htZrupT4gMj0gynzZua+FPFRbJgVkj1fY+HgxvAVBoLQQ==
X-Received: by 2002:a05:690e:1a1f:b0:64c:2581:eed9 with SMTP id 956f58d0204a3-64e916057d2mr1018690d50.70.1773783663011;
        Tue, 17 Mar 2026 14:41:03 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:58::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e91c2b32fsm509608d50.18.2026.03.17.14.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 14:41:02 -0700 (PDT)
Date: Tue, 17 Mar 2026 14:41:01 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 1/2] selftests/vsock: fix vmtest.sh for
 read-only nested VM runners
Message-ID: <abnKbaZ0Y9cfEXcD@devvm11784.nha0.facebook.com>
References: <20260313-vsock-vmtest-nested-fixes-v1-0-d0e6274c3193@meta.com>
 <20260313-vsock-vmtest-nested-fixes-v1-1-d0e6274c3193@meta.com>
 <302d1a45-dd5d-4d50-a99c-ce73de196d0c@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <302d1a45-dd5d-4d50-a99c-ce73de196d0c@redhat.com>

On Tue, Mar 17, 2026 at 03:46:35PM +0100, Paolo Abeni wrote:
> On 3/14/26 1:00 AM, Bobby Eshleman wrote:
> >  tools/testing/selftests/vsock/vmtest.sh | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> > index 86e338886b33..c2cfcdf05d99 100755
> > --- a/tools/testing/selftests/vsock/vmtest.sh
> > +++ b/tools/testing/selftests/vsock/vmtest.sh
> > @@ -42,6 +42,8 @@ readonly KERNEL_CMDLINE="\
> >  	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
> >  "
> >  readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
> > +readonly TEST_HOME=$(mktemp -d /tmp/vmtest_home_XXXX)
> 
> shellcheck complains:
> 
> In vmtest.sh line 45:
> readonly TEST_HOME=$(mktemp -d /tmp/vmtest_home_XXXX)
>          ^-------^ SC2155 (warning): Declare and assign separately to
> avoid masking return values.
> 
> > @@ -451,11 +464,14 @@ vm_start() {
> >  		--run \
> >  		${kernel_opt} \
> >  		${verbose_opt} \
> > +		--rwdir=/root=${TEST_HOME} \
> 
> And here, too:
> 
> In vmtest.sh line 467:
> 		--rwdir=/root=${TEST_HOME} \
>                               ^----------^ SC2086 (info): Double quote
> to prevent globbing and word splitting.
> 
> Did you mean:
> 		--rwdir=/root="${TEST_HOME}" \
> 
> The first occurrence could possibly be explicitly silenced explicitly,
> but it's probably better to really address the latter.
> 
> /P
> 
> 

That makes sense, fixing both and resending now.

Thanks,
Bobby
