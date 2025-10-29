Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65771325487
	for <virtualization@lists.linux.dev>; Wed, 29 Oct 2025 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757265; cv=none; b=gjd5CxKrQuNy4GUKv4pIzDaehKsVi3izz1h8A6STRnchAWQHBJgV82tkJ0oGl2/REWMq5sA2D/krWUG/0beJZz5NSGcp4pZNfyZKxZ30ERdrMrL47kAGxHHtX4aEYrj1F9KZEMD8f18sSnyteQtjlcjohNamYHLwEA7mc7HGN3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757265; c=relaxed/simple;
	bh=Wp3fVL7+QadEa8IzaGlhGIUgVnY7Jv4oi0qCeRl/zp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwMANKilypWah6UJpo3AdCkzyrtXDY7wFob/fThfu8f7YJn0hCS0KZV4RdSmXmmC0Xla41j2v/Ni01agxl9bNpbuJL2Xitb59q1s628/vrauveUKnOsShMBnHxKSFUqX+S37f2/WiqM8ZwLoXPm/eUisxqyL31vqOhcYU6fAif0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wo+qLB00; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wo+qLB00"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63d8788b18dso175253d50.2
        for <virtualization@lists.linux.dev>; Wed, 29 Oct 2025 10:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761757262; x=1762362062; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YmVcWnyP/D/4k/CbvF/9x81DJvhDtu1WPzap00TJ1+I=;
        b=Wo+qLB00GtdnaP+i1Jbve3TmSPabHF4yYtQ5jUKuU8ik+vBu3/YVto5DmRoKHGaQrz
         NiuMXwGO/h/dd7bstwJrudzUhqjpEfDH8t+lcmqpHSbEcNMEMZRvQMOBgULI+1RdFNyn
         TxGJng6BhrosH8rfvpFUyURJXsufFfF2sllR9psLokd2XcW3CH/3Onw3XBA/0Qrh9hSc
         MPY+mLLZ2eVYzkaTkhTbyrHE886WP1gdTkr8rBVE8QMdQJccxaanlahOX+uCcu2cTcI6
         mhcwxFeU1kfegjaXMElgAWGfLUdl2KegXf7ZQhQ+nU93h1Scvd8JWNhwLnM2OMACTK+d
         4FsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761757262; x=1762362062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmVcWnyP/D/4k/CbvF/9x81DJvhDtu1WPzap00TJ1+I=;
        b=A6tTc62FDUe2EficAN2CWEW/AI03y+Gxhdhj812SBh9zvAhNHnkyShye9IK89Zh1a7
         oyGUkIqrJIB7SqCLR9IE4rHP6MnzXyqbIcGERCxEQIYi1i76nIqzlv1ul/Lc3GKkj9nI
         db6ylNktSHHRNegIGqS9ypSGHVdbG0Zh7unY2t/Ccjr80j3FRquLSR3q3F6oqDV68fSG
         ev3ryhGSw8P7lcCmWKf6VlVIbO8fKyN42gVEThgKUaLKLsbpsSZtvZZaL6wg/4psiNtQ
         MMbEUc3VFfoKD7hahhcW3B3JLbHGZ5xHP0GxfQHubFLz61lF4SfB3BmXpdOoePR9wHm1
         yUVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5u81FbNVcXWl2D7xvFYmQy/J8UI5uhvQvI18QLKuZvAkpkKXsgqqtvM+MvGYocVYMyGOQ/ZgDvD8jgUghdg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjkHrRocnLAlLCIFhqxQ6Qdo18UX0RJA/UVqLRaubJ4y0xLIMn
	N//xR45HfrbGQ/Ea4AfSZN+YV4hpx5iEzVz0kKHdPyT4RRZdKPoimEK2
X-Gm-Gg: ASbGncuQcr9WOh/rUmVi/0IfxlqTp8QOvy3qubTjuuhyPZ5IOEOOd5yGto7QiZaLp+T
	sOUbqovC8oma3uheoch2R+Znc0zAQSo17HmEOTf9DxnIcGJdeCi6N68Zme+EZzGOSEJB1A/jUMD
	Z3NFkev4GhggOE+lPjRcs/GSXpvP11wshEOIOcNiu5v1fnayx7ZL0JhI4oq7Qq2Q2ktEPwHp9B3
	GHcub/YJYK9Lpk4qQO6fqHFGJUaTGdCTS7EevoAunLAMNxSR9osQb/JxtwKPNnmtKgKTYAAThog
	dnCRoqkhIkORAS114vVthlzx6yntVGgNU/p4LYioQ1kBQl5YqHB6wT0M25X4uNnTkjQ3nVzfRDp
	gaOUa7w4QEUB+XA138ccUDegsmRz3xfjUzkbMI76lNuZghK7AiDRA1Dv3Uzbgy9kRm9odOD8YPy
	G7OLGumwsUublB0ngiHMYxji2X+jX6ew+R60RL
X-Google-Smtp-Source: AGHT+IEnBgJLEOgPmmjd5Fa15mG3hNg+BcjR7XG7Mp5aLAnnOx9JAcZcMN6DeI5kKixpSyz6Fvx1Zw==
X-Received: by 2002:a53:b0cb:0:b0:63f:4b02:cc7e with SMTP id 956f58d0204a3-63f76d6734dmr2393937d50.29.1761757261825;
        Wed, 29 Oct 2025 10:01:01 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:45::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f4c4724b9sm4377534d50.27.2025.10.29.10.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:01:01 -0700 (PDT)
Date: Wed, 29 Oct 2025 10:00:59 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 03/12] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Message-ID: <aQJIS4waEjTCL/hI@devvm11784.nha0.facebook.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-3-edeb179d6463@meta.com>
 <aP-kmqhvo4AFv1qm@horms.kernel.org>
 <aP+zgF7zF9T3ovuS@devvm11784.nha0.facebook.com>
 <aP/DQLcX9uaY6kXN@devvm11784.nha0.facebook.com>
 <aQJHnfsWll7Di-V0@horms.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQJHnfsWll7Di-V0@horms.kernel.org>

On Wed, Oct 29, 2025 at 04:58:05PM +0000, Simon Horman wrote:
> On Mon, Oct 27, 2025 at 12:08:48PM -0700, Bobby Eshleman wrote:
> > On Mon, Oct 27, 2025 at 11:01:36AM -0700, Bobby Eshleman wrote:
> > > On Mon, Oct 27, 2025 at 04:58:02PM +0000, Simon Horman wrote:
> > > > On Wed, Oct 22, 2025 at 06:00:07PM -0700, Bobby Eshleman wrote:
> > > > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > > > 
> > > > > Add wrapper functions vm_vsock_test() and host_vsock_test() to invoke
> > > > > the vsock_test binary. This encapsulates several items of repeat logic,
> > > > > such as waiting for the server to reach listening state and
> > > > > enabling/disabling the bash option pipefail to avoid pipe-style logging
> > > > > from hiding failures.
> > > > > 
> > > > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > > > 
> > > > shellcheck has some (new) things to say about this patch too.
> > > > Could you take a look over them?
> > > > 
> > > > ...
> > > 
> > 
> > It looks like the errors are SC2317 and SC2119, but are false-positives.
> > Invoking a program as a variable (e.g., "${VSOCK_TEST}") is tripping
> > SC2317 (command unreachable), and SC2119 is due to log_{guest,host}()
> > being passed zero arguments (logging its stdin instead).
> 
> Sorry about that, I thought I saw something meaningful in there.
> I guess I was mistaken.
> 

No problem at all, it brought my attention to shellcheck and the need
for exclusions, which I honestly did not know we used formally upstream.

Best,
Bobby
