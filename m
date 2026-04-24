Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE079366820
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 19:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777058143; cv=none; b=LX47CaTbSpO+Npfe9gfUTQIZ0Dt/O6O6assXzs1vO9mcwpVRN0EJiG3hrFwC4UfUW17FF+vy9jZESZE2f1aNZuLAxXjbu3yHliLgOoB13HsA1HgqsDhalIXu6OJRzdrRHh2T8gHl9xjVhC+qshfKFvc1gakbNsZKjkYrtkIEtkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777058143; c=relaxed/simple;
	bh=JRflc675q/1idnGLrRil/l9w6yTxsq35v5W45LMDdpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raSc+lEQtttzzOMCB1yUG9GSjZ7wpZoTndD2jHjWhzabxBY9D80BLM/ayv444aLjJKTH6Jjl+P8bqy+o6JqGuR70cpMyc+/FKcH5nBdkXDL8dSUa8VlxtoHhU12DiY3j8IfpbMbWdvG1OSQJOYTBOhT3is9h8AcQe6IvgQNZ43s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpX5I2Zg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpX5I2Zg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A98C2BCFC
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 19:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777058143;
	bh=JRflc675q/1idnGLrRil/l9w6yTxsq35v5W45LMDdpw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LpX5I2Zg/FeuzoeKaWINh/E3uUcwttWiEQeYZas61EYTabJE/piVzjh40m+MZg7ML
	 2egZw8E5YYYz6I/5EL6JXUw2JKP1qA/4FTgjnrLTXGz94iUvNVFyKVaBRr0SdtJnol
	 MnWfPTLfHCAQS8B4K9Lpelxx6imh1ltQJ3Uj9NTqQMUP8OPj7jgq8dp46Y399au+nk
	 eq/MdAvRgGKdRJOfusoBi7GwN5X+7HyHuJe/rsPJh43JMJ/jB2Nf4gg8sGoqsbbZDm
	 dHjlJSEXQ9Ur5ZQ4FNntPqpJD/6qGCCxZgNRccSJSEJdCEqghqIvSYdVbiyFYU+l/3
	 GkdYoGMdsn5BQ==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bab8ae52954so542888366b.1
        for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 12:15:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8UyKvT0idU54m1+27FRBirqItndruERwCMsAcLP+ZYYvGiPTJ+MV3XcklQmsQSSuffzP8aSFk/mNy/pvXeGg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+z+5Xyi7auh+J9glw/ib9VfMQmOFXy2C2KtEdlRL8AQqMWeCX
	C+Xq6pjH9LbDbfBj5zhzQXStkrXjVH48P/M0D5dMsxGelgPsXyhNbN4serj9QykDd6/66AHU5td
	Ycdz0HkyTSaiFJmKF4fT8hCDjsWLsFCk=
X-Received: by 2002:a17:907:3c90:b0:bac:7f7d:2bf8 with SMTP id
 a640c23a62f3a-bac7f7d3864mr493581666b.0.1777058142091; Fri, 24 Apr 2026
 12:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260424062528.71951-1-lance.yang@linux.dev> <20260424063024.ce42ee6a5546e4d9337dd007@linux-foundation.org>
 <aetw4aoABYj3keMh@plex> <20260424071533.d28ce90126f05e1c6fc1b740@linux-foundation.org>
 <80ab39c2-efb9-4a23-bd56-46d9bb4e41bb@kernel.org> <20260424073145.b990fe9b925da304508aad71@linux-foundation.org>
 <644e65dc-3d39-4137-b51f-51d953b67d50@kernel.org> <CAO9r8zN1pRfyC0Rh+UdW-Lsret=z3oveT3=gnZftX-Sr_ubyyQ@mail.gmail.com>
 <20260424190141.GA3783056@noisy.programming.kicks-ass.net> <E375C69C-557E-44EB-9B3C-618C9F7BA9D8@nvidia.com>
In-Reply-To: <E375C69C-557E-44EB-9B3C-618C9F7BA9D8@nvidia.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 24 Apr 2026 12:15:30 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOTFUSXc_iZ3i9iL3v9Fw+SOFoROj0vcO_1GwBxO9CVqA@mail.gmail.com>
X-Gm-Features: AQROBzBB23MjqT6n8PBLfDaZ-XYSD37hBuqxK30W4VBXepSt-pjFbfbtLqRUj6c
Message-ID: <CAO9r8zOTFUSXc_iZ3i9iL3v9Fw+SOFoROj0vcO_1GwBxO9CVqA@mail.gmail.com>
Subject: Re: [PATCH 7.2 v10 0/2] skip redundant sync IPIs when TLB flush sent them
To: Zi Yan <ziy@nvidia.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Lance Yang <lance.yang@linux.dev>, dave.hansen@intel.com, dave.hansen@linux.intel.com, 
	ypodemsk@redhat.com, hughd@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, npiggin@gmail.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, arnd@arndb.de, 
	ljs@kernel.org, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, 
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	shy828301@gmail.com, riel@surriel.com, jannh@google.com, jgross@suse.com, 
	seanjc@google.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	ioworker0@gmail.com, roman.gushchin@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 12:12=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 24 Apr 2026, at 15:01, Peter Zijlstra wrote:
>
> > On Fri, Apr 24, 2026 at 11:50:03AM -0700, Yosry Ahmed wrote:
> >
> >> But I imagine it's useful for reviewers to see Sashiko's feedback as
> >> well (without having to go look on the website).
> >
> > That's why I have a script; if I press 'S' in mutt on an 0/n email, sai=
d
> > script goes and does webrequest to sashiko and inserts the review
> > comments into my local maildir as properly threaded replies to the
> > series at hand.
> >
> > No looking at website needed.
>
> Do you mind sharing that script? It looks like a great work flow. Thanks.

Yeah that sounds great :)
