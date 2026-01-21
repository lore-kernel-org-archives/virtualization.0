Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E912D5936
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 06:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768978007; cv=none; b=iMxtNDqBekwywg4CZiX64MRYdZDfcXWq3OLnXVZ8RqsQyccp/AIo4S7u9IgxLkC3C769Mps1CbKpWx+kus8rf/0TQ77GALwGiCRVuihp4rTFqYXDJmJjGT4E6EK2ZNXYID6MrB9MT3TbfOQJ49U9GRFj0543IY75kU36KDiktpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768978007; c=relaxed/simple;
	bh=BjEonW32c5YOMq0hqq7Xvkwknsp7bLBK5sRV2QqHoDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3DVO6105e2ofBK3Ptb0uwLnVz1dSetmKxqVg+hYLJNg/eeNwTwjEcXXoRaVMHK3Go8ftiAnpy+/1SJxFvZqQ2JQ2L3RSdljMqo1S3oLMFZpEHu9QxGxzv4jaI6JQHwphMDTi/0Hihxs6g61LUoHpbdVajbKgrqdkzZXVFJZTug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GE5OuXV/; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GE5OuXV/"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c531473fdcso822442785a.3
        for <virtualization@lists.linux.dev>; Tue, 20 Jan 2026 22:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768978005; x=1769582805; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dr4ikofTW2/lOylz+wqvxKyTxo3lmrOIQRlztmAAggk=;
        b=GE5OuXV/u++61fS3M3Koqy4sbmPcFS3d+44ezAvcJZIFNJr+33fd2i43iY7bObHd+C
         s649T1nK2/2T/+mz9OVFZWMnOJhkXl8xtFDKQUgZ2g9AlydSfERAWYwl8fr03Gg+mOlW
         XHObQED4qAHh/Im+jycqVFKrKeS1ImNakpiMrWNZi0bcUlQbee5c7dEVfBFILHDX9JiX
         4hrP4xZpjxhoH+Gi4FASd604EAOq/grq2LmAlGh6Qx86d35OZqzhzrCLEoiBIs01Adjm
         eOdOJmKOm5TCqgWOnnvYz3VPWlVU/yyEB3TchXy1PieQQyun43UprdytLehUWDlG2ygZ
         4NDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768978005; x=1769582805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dr4ikofTW2/lOylz+wqvxKyTxo3lmrOIQRlztmAAggk=;
        b=aovx8NllAG3jp8TXcr1OQgxuLWO/6bEoeuEixr97qEdrNn8pJUk32xL7UGtgHE1kpP
         RgBFbdcSdPrlD+/cIWYmcD10hmwuPn4wzngR9H8taHEthpLywwW9B+ls2r78F43PH51P
         wyJterPOZPfnmtTEXmPN5wwOaj6nXLQ2Ts31GtShfo5g7Kw73eGloy816rLkq5RWY5ZY
         JDPBHQxmLAfRbApuwT8Rj1rT6R0XJn0j4t1VhRitIw1XNdIUYP2YP7mh2EYSXXF3D3kp
         Cs91F6fe7drrb/zZxkLzMH/Te3R4BTdUroE6bT2bi3ZOzKIB86DhhW4ybVWCBTc2XPL0
         8KRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2H/V9PNprCjq9w8clQXRKwiqo6YYgJHxOZWyyXIrhJq3ZOUU+IKjvcZvSf6qyAxt83yBOVLnSpUqPLTLF7A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJt4AIT9ANQwGEfoN7c+wbJ8R9aazWbmOTSkai0Da8D8AwLtFq
	cUHwfbB2nEZrYpyNZjoDUDwgmRu6Rg3e/6TWbq9jpOO+LGtY0fB22vLQFhxb9Q==
X-Gm-Gg: AZuq6aJ43V2OhNVqFOhzVJoLl2OrhHI1hO8hq1aACBaR9aHNH4J7xUiTqMF2mqhQh/T
	rI0qZSk50iUVSuE6oWxG6wDDLdjFlGeWR0XX9B+vDulTK3EX1n4n10mr4pH1QXdultZIxcYvTy5
	ibHnl85K+HTl1kTzHW13yQCcnhvdR8tBIBVqzqkzKjgs+aKs7iabvmBk9sf9nvr/zWgLyczG3uQ
	8W/y3u3E6z0Y8WN2srtkcZl+8vc5eVkwsHcyYKIG0M0J/aVJ6FgX/kRPBsVM2cw5TOrh4u97sIq
	GkLRYEKJNSlZbNz2tTyDKcKwRzFZNt0cyvJVH07ryle2ItlmMQb4lq+kkpweSqa3nOu5+y5dxHQ
	hpDmtknaw+uRkCGCv4iMXa17Ox6bp75NnpoIgGg1uyp3X33ZR1gdacqSsQRu7ufQiEW3lLXZePH
	zQO1MUdat6fZcKS9H4Sa/chbnfucTha9r9rrQ=
X-Received: by 2002:a05:690c:ec4:b0:788:1086:8843 with SMTP id 00721157ae682-793c66b7cd1mr130884437b3.2.1768972588159;
        Tue, 20 Jan 2026 21:16:28 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c6888b83sm60922327b3.48.2026.01.20.21.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 21:16:27 -0800 (PST)
Date: Tue, 20 Jan 2026 21:16:26 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: sgarzare@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	mst@redhat.com, horms@kernel.org, bobbyeshleman@meta.com,
	corbet@lwn.net, xuanzhuo@linux.alibaba.com, haiyangz@microsoft.com,
	jasowang@redhat.com, linux-hyperv@vger.kernel.org,
	pabeni@redhat.com, kys@microsoft.com, vishnu.dasa@broadcom.com,
	longli@microsoft.com, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	stefanha@redhat.com, berrange@redhat.com, decui@microsoft.com,
	bryan-bt.tan@broadcom.com, eperezma@redhat.com, wei.liu@kernel.org,
	davem@davemloft.net, shuah@kernel.org,
	bcm-kernel-feedback-list@broadcom.com, edumazet@google.com,
	virtualization@lists.linux.dev, sargun@sargun.me
Subject: Re: [net-next,v15,06/12] selftests/vsock: prepare vm management
 helpers for namespaces
Message-ID: <aXBhKlAxxAkvr4/u@devvm11784.nha0.facebook.com>
References: <20260116-vsock-vmtest-v15-6-bbfd1a668548@meta.com>
 <20260121025420.1999992-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121025420.1999992-2-kuba@kernel.org>

On Tue, Jan 20, 2026 at 06:54:21PM -0800, Jakub Kicinski wrote:
> In case you need to respin..
> 
> This is an AI-generated review of your patch.
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> selftests/vsock: prepare vm management helpers for namespaces
> 
> This commit adds namespace support to VM management helpers and wrapper
> functions, requiring callers to explicitly pass "init_ns" for the init
> namespace. The commit message states "No functional changes for existing
> tests. All have been updated to pass 'init_ns' explicitly."
> 
> > diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> > index c2bdc293b94c..1d03acb62347 100755
> > --- a/tools/testing/selftests/vsock/vmtest.sh
> > +++ b/tools/testing/selftests/vsock/vmtest.sh
> > @@ -135,7 +135,18 @@ del_namespaces() {
> >  }
> >
> >  vm_ssh() {
> > -	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
> > +	local ns_exec
> > +
> > +	if [[ "${1}" == init_ns ]]; then
> > +		ns_exec=""
> > +	else
> > +		ns_exec="ip netns exec ${1}"
> > +	fi
> > +
> > +	shift
> > +
> > +	${ns_exec} ssh -q -o UserKnownHostsFile=/dev/null -p "${SSH_HOST_PORT}" localhost "$@"
> > +
> >  	return $?
> >  }
> 
> The vm_ssh() function now expects a namespace as its first argument, but
> run_shared_vm_test() still calls vm_ssh without this parameter:
> 
>     vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
>     vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
>     vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
>     vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
> 
> When called as "vm_ssh -- dmesg", the "--" is interpreted as the namespace
> argument. Since "--" does not equal "init_ns", the function sets
> ns_exec="ip netns exec --" which is invalid. The shift then consumes "--"
> and the command becomes "ip netns exec -- ssh ... dmesg" which will fail.
> 
> Interestingly, the v9 version of this patch on lore correctly updated these
> calls to pass "init_ns", but this change appears to have been lost between
> v9 and v15. The fix for this regression is present later in the series in
> commit 3ae984505e00 ("selftests/vsock: add vm_dmesg_{warn,oops}_count()
> helpers").
> 
> [ ... ]

Got it, thank you.

Best,
Bobby
