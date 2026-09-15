Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A6043BDA1
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494731; cv=pass; b=pYRQM/kgdpjdWG0idGmZmFHTkP+SD9SV0PymVItc9Ngi5xqxVO26Dyws1tFaEtr9sYtNIpJiGVgpE3bn1SjBzsC7TrX0++6AImXv4Nce0TeXQ0trg3XyecnTQ/kjzYi+sydy4qk1CestG/EKiR6QBHo9KkxooBQ+hrGiYC+rJrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494731; c=relaxed/simple;
	bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQjsuqpLuh89DLGq0UIMVPqGWaFF7rDlCTyx+a0nDGp7IqOWW2qfh3YyQ83QxS3k9IvJ3cTdARVbHTU8OOdLNI5Ybjk0JFhGNkFzKC6DSd2iVE/X5F3WLjqsGHnjR4PplrrS6HCXX8jNj9nNST/1Wo426slVDHB+ySEqGQIQXZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uNljqR0U; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uNljqR0U"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db425c9050so12245ad.0
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 10:52:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789494727; cv=none;
        d=google.com; s=arc-20260327;
        b=kL1hlffmDDHmQMmigsUSrTiOVZWbdgOvrlRMtWYisvTOEjxwN03Zu7uYIo0pqUx5BK
         HPHtohuvIU1LU3dACpzr1YgDlb2oxiaKiMeytfblsMdZGO8mvHIQpPGQF5YIopGeWpVy
         jsLF2KRUCScSVVLc0SesDKh2LApdDMhVzHKrUQvECnr5YyC/jCqqki1YW+9sOTZE5VPs
         OdLCEumOkb1mXHGo9d51UTbfxxagaaAJNAZwn+6foQXFA0SM38idYXE+c5m96JhQUWg4
         so/mRbR/Hqkl2wN6Ko5+N56MhQoZZCmKlg++LN97uyuNCnOTGHijSjsgvTUT7FVcqOuH
         b7sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        fh=tAfYmsU2QDMNqoKdk92uFfGlwoVUwtjTGxUs1G/WpXA=;
        b=aeEKWoMhnyqM5ykoAyUhzkDeOPKGF9MzpGzMayM37ergT9OekN3R9kqFJlTuKTPgWh
         Jr5/HWlIOIhd7FwF/CIYqfSspu3jGVJ1+Wnkjpd7Nb9vgvamQRvM0vK2YV8KIstQ9QvP
         OciGjmMY5vpG751pcKpfvQfpsh8UFMmeK9AbSACyMqvAJZVe4yBoJXwSiK3ie1R508cv
         F6B03VbcdOiRNnu4KvqIkCOblljuZFj18LgqqKt/RRGEuTBx5fpo/Swzsi0w3oT9/12X
         sIkkPZ4/suq6ns3AbLvqyW2WoGCcMRk65qx3ImfTcb8mn+VaPYfReVYAkrGef0yL+VYH
         Pzgw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789494727; x=1790099527; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        b=uNljqR0UE58fL90e3fJ9VdUeQw9yVRAiVG7IA0l9S9Z6dMbq3z69nOKXxKFuAfggiY
         4DV56FNhwPhCGUL8I5ekHMT4VB7wc7wXAp3lorw/e4kA8NVxhEKZTH6NMaxDK3iF2QTp
         fsyZUD2yA0O9Zkfd3VAScmm0omiC22pqRSg7f7D//HznxnWeBSQAkV5fRw9f+dxL5poE
         CHTQSVi998pKQDGl8IU6xHPJ3EFPmddJB8rpPIJCIEzXSxEPffznKJyfraj4Xwb5L2Eb
         FST5WpVhS3UNRTlG3k7Ql+VzjFacJX+5vt2Quv+znKtzC4gD7928LtKB3DBKSKzW/MbC
         DCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494727; x=1790099527;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        b=Rc3mufsXaChmhG4JbSfwfvbkXQmGcnKBwEAJYcE8GkmGW8A9xTVWDwPrJ+8yLIhyKV
         P7SiVmMrMyhT43wlka9SC/N3y9vQdtnqllvV98SRol1UC1lYDCsj3XvOiIaa3K+k7aBP
         Rs8Oq6BNs7YjEtB8krAAkdclHVvnF6BiTiuyvA6GsLDryK4RqNxNjcVr7lVCdGjSLRr1
         zC52kPl7WtGMypF4tNunnTCQfgCQc4gxQpccwRvqdqF8ojQwG9ATbH3LxVfzr+0/0CuF
         98Oa3fcoqb7J+Yz1PMuAYKYjlIXAoZEX6FAJ6lRj6csyDGbRl64qaa4gABBeheUE7K9W
         m7yQ==
X-Forwarded-Encrypted: i=1; AKwUvBymbO2SIwtq0OUHL9LcsBw3Eltp79Xg9i4CKtlmCZCxjGsRmqsxQV8s1xS1I0u7/npTZ8p6cBF1PZIlepMiKg==@lists.linux.dev
X-Gm-Message-State: AFuF++l4bEWrBx4mYqrik63CUjZOwZzMG4kK9soj592JU7tfMyVkznOR
	7hKfiHMNZZahNqRY2NePRaOWeivxNIYHK5rDZWzHNj9MdnCLKxEhYYlBr3nbrk3DPeJ4v1EmZue
	XyhT1FlTzfLt0NxcFKKW8vgs4Kqcdyw+wt0loM6Y2
X-Gm-Gg: AYBFou1/kYWa/3g4ubbunS50Il6V1p475bQXyzeQ/dc7OJZYPID0QABtmBpamiD8xMM
	/AiN25yuwJtCEocTXh5mM9RKTyG3Gh6NMMtQkWrilo/fuqW54gWsCEoC2dOYv1o5fSibY1Rgc4h
	OY+zmBRMj6WkQ4uJTnaiRwxnFZs/5ig0f0zp2O/MbXS4n2ceGuut6OPE2GHGZcoCyxZGP8+nmda
	ztbrjwladv3A/IXd7Jr2ZbU7RA3ZN7ovXQ1ed/9nixiSuajCiVoeAl60jdLblwpY7DWN+ZsBi9Y
	axs+jVY5gzW2JDd8bQP2GjilaUIjFXRzKZNAewkg/naJljFwPV5xebU9Rpl5oCYib6i9i24Fz3j
	FUnfftEMygHlyYIJF+84CdKKWiaW1Z6K5M7b25uBUFXh5n8LDQSE=
X-Received: by 2002:a17:902:f612:b0:2dd:5363:31ec with SMTP id
 d9443c01a7336-2dd89c0c38amr177395ad.14.1789494726332; Tue, 15 Sep 2026
 10:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 15 Sep 2026 19:51:27 +0200
X-Gm-Features: AcwNN1Vhgv53PI2-XyXtJBbVzCNkGiiWjtvOE2b-8zHim7-UybJ3H2xniPj1VUE
Message-ID: <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 1:31=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> allocates a descriptor like get_unused_fd_flags() does and records it in
> a slot on the task. fd_stage() attaches the file to that slot and
> returns the number.

I'm not really a fan but I feel like if you want to do this, you
should be using task_work so you don't have to touch the entry/exit
paths directly? (And if task_work is too inefficient somehow, you
could tinker with the task_work implementation.)

> When the syscall returns success the exit path installs every staged
> file. When it returns an error it drops the descriptors and the files.

Is this mainly about stuff like "we installed a file descriptor and
then the following put_user() failed"? Because if so, I think a nicer
fix would be to have a policy of "if userspace provides unwritable
memory to a syscall, just keep going and pretend the access worked",
and maybe have a sysctl that kills the process when this happens to
emphasize that userspace should not be doing this.
