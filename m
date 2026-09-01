Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C8E3659EB
	for <virtualization@lists.linux.dev>; Tue,  1 Sep 2026 06:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788243685; cv=pass; b=Td73rcor0n0JTVHp/5YkqmfaNjnrY75KyzazULc7rUko6VJ6kcsjIcO4CRgN5DNB5ggciLMda3Du2Pv7B24nHFTwS2Yx4mxTs+C240svvrp07Agc5IaRtHbwSzaCg++nMTRrXMkBvl24n0UHxP6ZfQpcfDG2w1JK63E9KcH9zIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788243685; c=relaxed/simple;
	bh=I3lSPzdIKrqVH24xSYTfJkxcALnNqxzrGfeYxDEtYXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvuXhhsopQWJ15dH9UHwR79FH3Q2dogWFga3D5GjY/8DoPZLGK+lF/i/+df1e43IaBs1t1VlOsyCxWZ9QIzAafTg7ORHkptOdj2vmKSuzG9hS/YlU/dL2i2Zdu5hkM9yZ5a2qjhehE52F2L/Cj2V/ReDT//pPjYKnZvSxgRXt2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CR0O2RC2; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CR0O2RC2"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a63c610b8dso3178360a12.2
        for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 23:21:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788243682; cv=none;
        d=google.com; s=arc-20260327;
        b=GksH9GN1L0rTWPHgxi4bT1oJh8OdXSwSzy0cX5vXKAGvv+pGPxhKDi+4Z1+Lby2oL/
         uLikEIL+8+sSvdspQxIQYQNu/yqtQtNaLf9N+ifTBlV85EjilM7Uhi9qT3m9v3NesUGQ
         Url2+Oi/2tiFZrjTqi7e4fQmBjlGyrKrdsa7vwR6caYyyAId0bEpiwPYnzNJ2eOEhkuE
         R006tvXFdcX5it4ToZFK+4RIuD4L5AOXXwHhWCzV94cepdjoK19/+fk7CA8s2+gA72+d
         +LD7T7+oCl6qJaUjLoaFbACYftP+k29oefcczffUgciJL3KyX7t+pcSHNm5TMxuQ6BKP
         P3Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=I3lSPzdIKrqVH24xSYTfJkxcALnNqxzrGfeYxDEtYXM=;
        fh=Aj7LZ2r9mPJk4APOgGK3C4xdEoMatvN8prtnt+gQ3Zk=;
        b=GWpsY4gqRt69V+5KNWEDYE9+Yag8ypFzm5b2bRVU+GPOgNAk8+SS3UsfIhMKg0pmbH
         Hx4PFrsZYmK0i6pcBC/avs348o/eazYzxtvNLQoXxvtrUmdvQPJlKuAzOblFC/2oW+Ep
         x3rmjSQbATRkDQaOLN8Qa/vctJEFAbiPGK1VepjkcTl47EDMxMlnDodcL3s1r204s7OR
         juZvdre6lNakBjcnkQ8Vn7CZNRpr8XmkjKCp+ZchvyqmISitG1LC6ILmNf5/n2mewZNY
         AeK4wqkIqjY+7X58wwnjfNsKGJsdy0rLdxor9mxoyRvE5rLvZsIHsNhpIjYYcxfMf1iL
         Jc/w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788243682; x=1788848482; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I3lSPzdIKrqVH24xSYTfJkxcALnNqxzrGfeYxDEtYXM=;
        b=CR0O2RC2/0UQ5LN8HC4wdjKJKlH+WYi/jjw1N72LRh4s81kSAypx7IB6LqcGlCmeVC
         fw/QLP5se8O7ZtkxIx/t3FaYpPyQ/VcDrpI2Lgct2MGuWN7yWKBx1bygwPw4K/DxTQcH
         SomfOtPmswkHV3lb2cB6QAnQFaH+CIwD3j0IRpH2lv1/DxRpydf/DPUihD9uJPS+/Buh
         xhSWe99EuorDNKzFezWvuXhV8x2f8Phnz+BSBaFGh37A1RC6KsKzbWqHExHa2ORTxmD2
         o8EayBcEdjBI50A0/OrcgN0HJ3nCqu9rYQyqH965jaozbLaVyrpVzjqh1XSjGTsP4jHR
         Fi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788243682; x=1788848482;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I3lSPzdIKrqVH24xSYTfJkxcALnNqxzrGfeYxDEtYXM=;
        b=h/E6BDDFzpk/ZFjYLkW6sYxiMbsu62SqEe1BP5CG1wznyyxPlMdLapvR0m27Wmxf0L
         760iaE+sI6Vk2hOGNL8FZLURGwbJCPf8jzcInLYPqsECxL09dHJIZ2lRPO/F+DlaaHcI
         IZ8saVhA9gzaraDIV71k9NvyHGSmZf1BHWNElx/i0JcvoO6MU0QMs3YA2lY5E3zdLwYU
         08ATU8pB7d08j1hzI8ggw6uFvhIRIj8nUBZLbkFf1oMbyI1cx5DHmdRK8omphO968Zy4
         JGV+rbGNfmHAloYUDxj7HjNbaJgllm30HNBUQA6FMyLvc5crZqSfXjklsQktFFo4ht1u
         KyOg==
X-Forwarded-Encrypted: i=1; AKwUvBzMxno4GQW9iMs7qwl+ACfxbp+zQSSsfoiVd0ydg5glkKqXjCj1mA/HsqotegCIMCzsEpvJn+alhH1rUNWeVA==@lists.linux.dev
X-Gm-Message-State: AFuF++nxmXsQKi8zdW1IWgd2IImuxf7iCFFyukEBQeHRZA7xhiZNPRTs
	gdIX+EvR0g6lPWw018vcQLVsbOzgPQdQ1POmJCrvF3QGtPf6OiLlxXLSZuAMW5ARcxVN+P7ZHZj
	0YUvSlbup5tu4EoG52U9baKzTjz99RaimyuECEc6nFA==
X-Gm-Gg: AYBFou2oVP8bOiUqM5luj1ZnnE6e4WL1mFbA780TIdhLCFk36+WRxBSpi9CbX5hFuRC
	jmU1A8gnTy8L/usoQipJ+vg9dNmO/2nk6OGocB05ZzkqFcvKk0OqI2//mBQ+OvMiK22a/Vl3Njw
	D11eNSJ2LXVYJyt/82SU5fE0zooM/k0mHWBtCk7izH74TYG/9bd68nVewyutP8UwpsNQyAFSgqi
	gL91CtQzK5aCE6xK54OA3JQxUUqJJDG48QNl2InDDG6ZUkdlSyyGrFvauwIPI5KQna+3M4d4uKM
	9+6Qe5IymFJkKtcqYpEgPXlak3POT0FFWWVIUP7jeKak936eG+hbgo/LP9POSHpZ1mrsgOWhsME
	xFLNRlakOC9gh
X-Received: by 2002:a05:6402:42c4:b0:698:be4d:ca2a with SMTP id
 4fb4d7f45d1cf-6a663ac4091mr3714223a12.15.1788243681562; Mon, 31 Aug 2026
 23:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260825103855.721013-1-sshegde@linux.ibm.com>
 <20260825103855.721013-6-sshegde@linux.ibm.com> <8262d2f9-9f2f-4821-8497-991d7c8448a3@arm.com>
 <apMziCV_8y0xeIBT@yury> <53035ba4-53ec-4907-93b8-c8b957d1fa61@linux.ibm.com>
 <CAKfTPtA5Bdw89hezn1wi_p0m0dJgJJ1GYg8H93PsvsMC4bVJxA@mail.gmail.com> <apWxmL_brfi4fa4z@yury>
In-Reply-To: <apWxmL_brfi4fa4z@yury>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 1 Sep 2026 08:21:09 +0200
X-Gm-Features: AcwNN1Utuah9bS1-hCxKZcQtbUk5R5Z8_GlRW8ZBL4bnKRqxoMfIHUQt_k9sfL0
Message-ID: <CAKfTPtA4zmD=0Es2cXSHAodTZGLJPvv88s0_4QScp745PxFVMw@mail.gmail.com>
Subject: Re: [PATCH v11 05/12] sched/core: Try to use a preferred CPU in is_cpu_allowed
To: Yury Norov <ynorov@nvidia.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org, 
	juri.lelli@redhat.com, yury.norov@gmail.com, kprateek.nayak@amd.com, 
	iii@linux.ibm.com, corbet@lwn.net, meted@linux.ibm.com, tglx@kernel.org, 
	gregkh@linuxfoundation.org, pbonzini@redhat.com, seanjc@google.com, 
	vschneid@redhat.com, huschle@linux.ibm.com, rostedt@goodmis.org, 
	maddy@linux.ibm.com, srikar@linux.ibm.com, hdanton@sina.com, 
	chleroy@kernel.org, vineeth@bitbyteword.org, frederic@kernel.org, 
	arighi@nvidia.com, pauld@redhat.com, christian.loehle@arm.com, tj@kernel.org, 
	tommaso.cucinotta@gmail.com, maz@kernel.org, rafael@kernel.org, 
	rdunlap@infradead.org, kernellwp@gmail.com, linux-doc@vger.kernel.org, 
	jgross@suse.com, virtualization@lists.linux.dev, sunlightlinux@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Aug 2026 at 18:54, Yury Norov <ynorov@nvidia.com> wrote:
>
> On Mon, Aug 31, 2026 at 05:09:41PM +0200, Vincent Guittot wrote:
>
> > > Dietmar/Vincent,
> > > Do you think it makes sense to enable the driver on ARM64 now?
> > > Or you think it is better to delay it and once the feature is stable
> > > ARM ecosystem can enable it?
> >
> > It's always better to support all arch by default, unless something is
> > missing which is not the case here.
>
> ARM64 testing is obviously missed.

But the cpumask is already available not like if you need to create a new one
