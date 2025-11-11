Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F757352FA9
	for <virtualization@lists.linux.dev>; Tue, 11 Nov 2025 21:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894917; cv=none; b=pF2HKMWzeYtf4zfGbof6ZhmPnQqWX7t0CRiIu1z570U/kENdM818s3bz3jweGlvIRCT4+qmQkynavDCmxFoYS/RxC14G+tCuvS7IV9XItKb7NZwFDA8hZP3E8/bWk2J0OCOuf7FXZnqaFntTLwYpomxIy8ebq1UGu7wxogJer4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894917; c=relaxed/simple;
	bh=m2/ll1uTQe3vdYyhgsBOhN/isiT4ncOezX9iuBFvWf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtGLQmwTGy9lcbBtk4lgKhGYjDY5Y8p4ysW+x84nGV0x18o0uoyqob5jWZZb2/wIQv50ouqznwGuJlL0egIbrBMAIRRrl9z1AZL4YhBvQ39qmnJ2L7Dv94qNcPYogWhT69YVN/cl7xHXXCVBR7+v41YSjBdKsYOWaIc5KI63mbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dymszY/6; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dymszY/6"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-640f88b873bso157791d50.3
        for <virtualization@lists.linux.dev>; Tue, 11 Nov 2025 13:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762894911; x=1763499711; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bDPq8KvClJvWwDQMfmOhMgSMTNNkWL2W9UB4UAss5Bg=;
        b=dymszY/6GnYMoZQICc9oUnA6HBBwTrtD1IMSgOVDNWNXtcj6d6HEjXycmWq+zTjYXh
         vMAIpwGRadlGzuot19J6mGWQk3Qzz3Hx8PRGg2JbeaMuJLVa+R5YrB12eZIwLr4CMVz7
         x1dssF0gCbhppSyjMmsZJg1IGlCNgPEf/Xrv/e5gA7NPtLk87v3lY4EzJ8AeGYEgDYRs
         agZ250k1b+F9EXBAWbY61Qa1gjsSlYuHg1WpqGB9CNMQuTJxkQhQwowkCI1I8qC+xZ3t
         JF+zTXuLZOUKsERlw74CJGr5K4m2hDroWjIJ/kVXnTJRvzXYKyEEqTcQ/uS2g2WqWkJw
         owIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762894911; x=1763499711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDPq8KvClJvWwDQMfmOhMgSMTNNkWL2W9UB4UAss5Bg=;
        b=WDhTReehgaOiTT8RPS1xJh8gURwPsTvoGw25BFPOl0anEl5+mE+ofg32XVYUo+7iC4
         3toXN5h2hlmzVOXD9hXtkFw58+7F/MwUCIhf6lWu3GLxiZh8bTo7/EijbQ9rrLU6/sVm
         yqcsvwD5crYzFkr3Ktct2iMxYi4S3m4MFIM/0PvUR9DgaDVNNNlexi/loEEwf84K5bYY
         TJEpbRn08QX7h8u6uOC+ifMDpcyI/N9VDFWzNgPzjTXNYj1kucYgAczgerAaqsOyeexK
         sDkiGD3csPbeZsc6FvxlrJrCZl7dZGlI6TWCln7sABiG/G1AHPG1qJ8CEfAg7nkeZFPD
         u7Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVivjxLnnCNI+e0LkuwyYWTl+xk7D1Rrvrl0cnNpEkPbrhEeAvNRIpvyPqrxnvCefkNDAq4w0srMVBZdin9JQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yylgp2VYZobtuMUmMYOuXQdrWXRbPMcLk9F+xL4ai4kJirbVZjn
	LAU9yIwxQld//E5FFhdFRM//Fn1RgKooP1z6DwczsTF425ejgQOiswqg
X-Gm-Gg: ASbGncsjok3jBWT8/xdpDqO/JvtGgmS0TdVt38bDOijDbOcREGODfMA65O0o4STt9Ge
	8IwOLQ/fGYggD90GpATFl9Co0bQQqky7SEhlbQus7D+4+qPAfabuG8GSMMPuJ1omWjSblX8/XRB
	NSFhr7fwy1os6/+DHmCMiPwR853F5bqilzG5yWZgiapYYbkOzN1k8PwzluOf14TCMs1Sqsf8dZG
	RgB7qmIshbsxFB5HtNulUcQGa7liVJuXeYvQ5eRuZT5TAONKcN9jYho1qK+WKuRP3Kdlnqb4PXM
	i4f95Ef3AZ3xj0gNs1N0BeaMal7IIMAFbINZO6a0TyXIyY+hXZgx76K6j9mKw3jmLJQGWeiSbaW
	jRwqm3qtw/4n1cwKHtwKyEzgT91y3Pn2gqTflSloj4UTLy3/Q+wQqdzhM5fKE1uG7rL77u3CPuF
	rgt0bj2PYttV11VmA27C+Fupq0GSybPpTQmrDw0MDJdhP27A==
X-Google-Smtp-Source: AGHT+IG5pLwkGsZ+eCK296l8q5rg85wfM1wAQ8NbbJwGyjxk6/mldP/Q7Z6BLYOivEyqJVyS1VY/EA==
X-Received: by 2002:a53:c048:0:20b0:63f:a165:b9ed with SMTP id 956f58d0204a3-64101a0ab45mr674439d50.6.1762894911625;
        Tue, 11 Nov 2025 13:01:51 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d684218dsm36167807b3.21.2025.11.11.13.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 13:01:49 -0800 (PST)
Date: Tue, 11 Nov 2025 13:01:48 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 07/11] selftests/vsock: add check_result()
 for pass/fail counting
Message-ID: <aROkPIIeGq3Tb0I6@devvm11784.nha0.facebook.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
 <20251106-vsock-selftests-fixes-and-improvements-v3-7-519372e8a07b@meta.com>
 <aRMjeZVqsnc1BNr-@horms.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRMjeZVqsnc1BNr-@horms.kernel.org>

On Tue, Nov 11, 2025 at 11:52:25AM +0000, Simon Horman wrote:
> On Thu, Nov 06, 2025 at 04:49:51PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Add check_result() function to reuse logic for incrementing the
> > pass/fail counters. This function will get used by different callers as
> > we add different types of tests in future patches (namely, namespace and
> > non-namespace tests will be called at different places, and re-use this
> > function).
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Changes in v3:
> > - increment cnt_total directly (no intermediary var) (Stefano)
> > - pass arg to check_result() from caller, dont incidentally rely on
> >   global (Stefano)
> > - use new create_pidfile() introduce in v3 of earlier patch
> > - continue with more disciplined variable quoting style
> > ---
> >  tools/testing/selftests/vsock/vmtest.sh | 95 +++++++++++++++++++++++++--------
> >  1 file changed, 72 insertions(+), 23 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> > index 557f9a99a306..05cf370a3db4 100755
> > --- a/tools/testing/selftests/vsock/vmtest.sh
> > +++ b/tools/testing/selftests/vsock/vmtest.sh
> > @@ -46,6 +46,8 @@ readonly TEST_DESCS=(
> >  	"Run vsock_test using the loopback transport in the VM."
> >  )
> >  
> > +readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
> > +
> >  VERBOSE=0
> >  
> >  usage() {
> > @@ -79,6 +81,28 @@ die() {
> >  	exit "${KSFT_FAIL}"
> >  }
> >  
> > +check_result() {
> > +	local rc arg
> > +
> > +	rc=$1
> > +	arg=$2
> > +
> > +	cnt_total=$(( cnt_total + 1 ))
> > +
> > +	if [[ ${rc} -eq $KSFT_PASS ]]; then
> > +		cnt_pass=$(( cnt_pass + 1 ))
> > +		echo "ok ${num} ${arg}"
> > +	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
> > +		cnt_skip=$(( cnt_skip + 1 ))
> > +		echo "ok ${num} ${arg} # SKIP"
> > +	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
> > +		cnt_fail=$(( cnt_fail + 1 ))
> > +		echo "not ok ${num} ${arg} # exit=$rc"
> 
> Hi Bobby,
> 
> Should num be cnt_total above?
> 
> > +	fi
> > +
> > +	cnt_total=$(( cnt_total + 1 ))
> 
> It seems that cnt_total is being incremented twice.
> Once seems like it ought to be enough.
> 

Indeed. FWIW, this was fixed in the newest (v4). I messed up a rebase,
and my eye didn't catch it before sending out.

> > +}
> > +
> >  vm_ssh() {
> >  	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
> >  	return $?
> 
> I'll confess that I didn't notice these myself, but
> Claude Code with https://github.com/masoncl/review-prompts/ did.

Thanks for the note, I'll give it a try. I'm trying to build out my
pre-send workflow atm, and this looks pretty useful.

Best,
Bobby
