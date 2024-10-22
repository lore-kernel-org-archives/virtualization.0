Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF4A15B102;
	Tue, 22 Oct 2024 09:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590349; cv=none; b=GLp6zTMR6esL8dRn8nKt7s1qN9Vl0FYo3BbNOvRFgLzbAIUP2PuwFxRcMw6NrwP/tuKaSzrHquEvv2Qj+n0OXMXqxfYAcpO+K7OF2Xf1zjP0/+ViTVwYfjqNlc0cXIQ2pf69MTOj/SDNEaP2ovZJOhkWOYuTcDapQYuC6EGOz5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590349; c=relaxed/simple;
	bh=/EM5Wlnzp5qyIo+gkuTwuN/TfFFLXBMYaQ36Rg6KXbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPCr09Mh1YvRq7GmREXAv5ybsgVL5/TJIGYDTeHh11vHi58g3j68RTMZlbcj1TK0uYKmxUCdhItQNxformhGmzpeAvV99lc8xrFBMjpfTMORnn/9OJV6v3XxKLkWjGTUO7kfG8nMSg/1L3cuT4J7zbOd2atsOjdCi3Y7wUuC5DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTZqzY+8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTZqzY+8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26481C4CEE9;
	Tue, 22 Oct 2024 09:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729590349;
	bh=/EM5Wlnzp5qyIo+gkuTwuN/TfFFLXBMYaQ36Rg6KXbw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CTZqzY+8JHzK1mlUk7ymZpOglyOzo3/3W7eCay3Woe50NBiaTV18cAfVNxbSNAQ5r
	 wdE4cJPJ+nOC6/QvnDXE5/AhZ93s0qajjeclZJpSG4uZBMRVmFeZjeIUSwvLKGq2tu
	 Z/V8gaa449+HZZf7EB4PhWUZwMOmZ0YBwbm6hfM0j4eREbE1FkczszbATjc98lDL3Y
	 t8zhuXM8o73kanz1TiagjbtskmuTJOAWNDYIMG4eh7jkgS5exowywh3NYMstBFnwzh
	 BGW9RkOMRlAFyVKoV2wVOhDzORNys+0loK1RqQGi+CSNUdA/QpTcCu06etkvo9y7pG
	 a5b+RjAQHrNLw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1e63so6310279a12.0;
        Tue, 22 Oct 2024 02:45:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZOLCM2tr+JffUGNg2gttG50rQ2ktop3+GFa+856sj+zE1Fy4XpXfrAEpYg4Q0j5rigkZfMOP5ctY=@lists.linux.dev, AJvYcCVqWIUNu8C1tXbsW2ncUHMucSeZMJHjukXdO8apepOgWeAtlkbxyB4mcymprQiUJuU/WOfvKfCalANGd7ooKVs=@lists.linux.dev
X-Gm-Message-State: AOJu0YwTrS7Pd4K+M0ws7YWJiqzma+5I2Qy9bjjtx947i9A4Fay562Zv
	Ge3BZvsjr3c9Rhpeoz6qR81RIiy3xBrJrDlP+c9jBBSB2iV8xjYWANs4mnyvxNA5Sw0DY3A/NRT
	YwtoBYNoE9pckkhLkXlTCRTcniM0=
X-Google-Smtp-Source: AGHT+IGV+67ot6l201z6JTI0YHqTnxyfX0J6auFooUvHxusqUOfc7MNkh7L9q1Bt+vbb4ZHLs8A/xAHMIvaz8U6SOy4=
X-Received: by 2002:a17:907:96a1:b0:a9a:67a8:4c0b with SMTP id
 a640c23a62f3a-a9aad3dc7d3mr188856866b.60.1729590347646; Tue, 22 Oct 2024
 02:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240830093229.4088354-1-maobibo@loongson.cn> <20240830093229.4088354-4-maobibo@loongson.cn>
 <CAAhV-H4W4LwL3U2HT+-r+6nH5ZSBBbPYL2wdZJqQF7WNkhOgMw@mail.gmail.com>
 <878qv6y631.ffs@tglx> <2fb27579-5a4d-8bcc-db08-8942960dc07e@loongson.cn>
In-Reply-To: <2fb27579-5a4d-8bcc-db08-8942960dc07e@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 22 Oct 2024 17:45:34 +0800
X-Gmail-Original-Message-ID: <CAAhV-H52kC_-ehzxmT5ye+XVNm5Lm=psSfAv6xqnQpkOHTMFdA@mail.gmail.com>
Message-ID: <CAAhV-H52kC_-ehzxmT5ye+XVNm5Lm=psSfAv6xqnQpkOHTMFdA@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] irqchip/loongson-eiointc: Add extioi virt
 extension support
To: maobibo <maobibo@loongson.cn>
Cc: Thomas Gleixner <tglx@linutronix.de>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org, 
	Song Gao <gaosong@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 5:17=E2=80=AFPM maobibo <maobibo@loongson.cn> wrote=
:
>
> Hi Huacai/Thomas,
>
> Sorry for the ping message :(
>
> Can this patch be applied int next RC version?
Queued for the next release.

Huacai

>
> Regards
> Bibo Mao
>
> On 2024/10/2 =E4=B8=8B=E5=8D=889:42, Thomas Gleixner wrote:
> > On Wed, Sep 11 2024 at 17:11, Huacai Chen wrote:
> >> Hi, Thomas,
> >>
> >> On Fri, Aug 30, 2024 at 5:32=E2=80=AFPM Bibo Mao <maobibo@loongson.cn>=
 wrote:
> >>>
> >>> Interrupts can be routed to maximal four virtual CPUs with one HW
> >>> EIOINTC interrupt controller model, since interrupt routing is encode=
d with
> >>> CPU bitmap and EIOINTC node combined method. Here add the EIOINTC vir=
t
> >>> extension support so that interrupts can be routed to 256 vCPUs on
> >>> hypervisor mode. CPU bitmap is replaced with normal encoding and EIOI=
NTC
> >>> node type is removed, so there are 8 bits for cpu selection, at most =
256
> >>> vCPUs are supported for interrupt routing.
> >> This patch is OK for me now, but seems it depends on the first two,
> >> and the first two will get upstream via loongarch-kvm tree. So is that
> >> possible to also apply this one to loongarch-kvm with your Acked-by?
> >
> > Go ahead.
> >
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> >
>
