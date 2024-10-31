Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A75B19993C
	for <virtualization@lists.linux.dev>; Thu, 31 Oct 2024 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730371869; cv=none; b=a8Hr5Y30P1nlc95lFaE14vQcBlmdE6c2hWwFMtAZ2MkHF2oQytPs9M+3Q9lEmIcWXke25wy25NHTyrzDpbsugxTeTFYtenUgU75XBzMGMIjb17/n28qRG+IwU+mmd7Lg8Z536/4ebO9KAb2WK95FG7ouUUQLaUf0u8S+gL9Gi2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730371869; c=relaxed/simple;
	bh=uh9+w29J7T5ImrWhnSAaEfztZF7N3Bb4bZAX+Lkmx1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSnnoL0SWngkzhs9VLz6emCNBDdCaq+dtAa7QptM3gn8ESW1m/FihO8vQaI1whI+Zl+xl2DUTbjK/9WSqULvmLVrPXILc18O4kqn0bukc0zwuVr1TwS3AlezIn6RlGerA5FKpDqUP0i0C5b3k1EYSZBaCcrT2cK5RwQdTN2DJoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dKF1OA+j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKF1OA+j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730371866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/AXLe6BNzWvyIS2X556SHcAm5RhCKXQ2/dARiTIO1wE=;
	b=dKF1OA+jVKImLzoO93mlteGO8sAnZp8eKtln6P0Z0EmbkIrz/o+ONZu6UVCd1UHyHB7sSU
	7ExB7uVRrCxn706A2wWclkNYUlHQEpiGiiKFZN4nAEFC69+3YMN5zC2/0JgGq8AompGWsI
	XF6J3hc98rtIQjh74rYERjnJaQ8C/RU=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613--JPeSA2uOHOiRlak6egAng-1; Thu, 31 Oct 2024 06:51:04 -0400
X-MC-Unique: -JPeSA2uOHOiRlak6egAng-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-84ff1850a9dso168309241.3
        for <virtualization@lists.linux.dev>; Thu, 31 Oct 2024 03:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730371864; x=1730976664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AXLe6BNzWvyIS2X556SHcAm5RhCKXQ2/dARiTIO1wE=;
        b=eavOkOwtfLUsX9g+pRgcYStg2wsS87cZWMgw7+OIs5y9kgTbWUMYL/pEPxqIfI67hB
         F54mjANvg+wRz+/32sLHk7zdHUyPa73erPgE88iFduK3ZWviCeCoI72rFUdM5uCp2AEN
         FQ0D8DIPWEAz5DBKWUeCu6/S2AKFXT9YSm+UVw7poWsiX4MsAarPHepX2mW94INEB39W
         m7WAgnD6U2ROG9wVw6QI/5yrpJ6/5Bjp7uz2eP8aOt/qDhPTIcdhC7/GGvdfWsLP5cAI
         60TX+4NVLPSUrb70w12iulAfrRgo9i/4hmFtSjY9ptqgSCe2pxERm3n98+sl8/E5LDI0
         XOjA==
X-Forwarded-Encrypted: i=1; AJvYcCXgEPf7PYPkfh46Rky/DR3tcPHMI+mNm7dfhEiN46QcHT9EeRwnWe1Y9ZnKqz5aD+wG41iHQREKiNW9VmuXZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwT000018Y+UOrR1TTwK/Im9ku6jKItSbdKHp+JiSwyNNPNlVts
	pImng2/Oa6il9upsPaslI1p9MMl2wU95sq3nLt96wuGB1fqq3AgvmG4UzSv6Wcg8DQ7vMRXXB2T
	wGcwybHzFUG9ZPZyxaZke0Tf2/8LSsxHGjWf1OK4EJBdE+HLWSfAlbk66Tqp7c8usEvSNKsO9Ei
	WnMdIVhRsuoDR/N1/bDZq7uR4xhLoBJl9yi6kT49k=
X-Received: by 2002:a05:6102:e0e:b0:4a4:72f0:793e with SMTP id ada2fe7eead31-4a95437210amr3812156137.20.1730371864240;
        Thu, 31 Oct 2024 03:51:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwfzEyODsd5Ja8ZyzC6TH+ukrerObDa1tg1mi7WbgzDduWTc2C+QNy9WoO6WjMViQRFfbhvhDuBNxMti+84S8=
X-Received: by 2002:a05:6102:e0e:b0:4a4:72f0:793e with SMTP id
 ada2fe7eead31-4a95437210amr3812123137.20.1730371863840; Thu, 31 Oct 2024
 03:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241031074618.3585491-1-guanjun@linux.alibaba.com>
 <20241031074618.3585491-2-guanjun@linux.alibaba.com> <87v7x8woeq.ffs@tglx>
In-Reply-To: <87v7x8woeq.ffs@tglx>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 31 Oct 2024 18:50:51 +0800
Message-ID: <CAFj5m9KZRjupM+bsuc-r_kTu1h8+wtc_fdmkHWS=cNbg4aU03g@mail.gmail.com>
Subject: Re: [PATCH RFC v1 1/2] genirq/affinity: add support for limiting
 managed interrupts
To: Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>
Cc: Guanjun <guanjun@linux.alibaba.com>, corbet@lwn.net, axboe@kernel.dk, 
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, vgoyal@redhat.com, stefanha@redhat.com, 
	miklos@szeredi.hu, peterz@infradead.org, akpm@linux-foundation.org, 
	paulmck@kernel.org, thuth@redhat.com, rostedt@goodmis.org, bp@alien8.de, 
	xiongwei.song@windriver.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 6:35=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Thu, Oct 31 2024 at 15:46, guanjun@linux.alibaba.com wrote:
> >  #ifdef CONFIG_SMP
> >
> > +static unsigned int __read_mostly managed_irqs_per_node;
> > +static struct cpumask managed_irqs_cpumsk[MAX_NUMNODES] __cacheline_al=
igned_in_smp =3D {
> > +     [0 ... MAX_NUMNODES-1] =3D {CPU_BITS_ALL}
> > +};
> >
> > +static void __group_prepare_affinity(struct cpumask *premask,
> > +                                  cpumask_var_t *node_to_cpumask)
> > +{
> > +     nodemask_t nodemsk =3D NODE_MASK_NONE;
> > +     unsigned int ncpus, n;
> > +
> > +     get_nodes_in_cpumask(node_to_cpumask, premask, &nodemsk);
> > +
> > +     for_each_node_mask(n, nodemsk) {
> > +             cpumask_and(&managed_irqs_cpumsk[n], &managed_irqs_cpumsk=
[n], premask);
> > +             cpumask_and(&managed_irqs_cpumsk[n], &managed_irqs_cpumsk=
[n], node_to_cpumask[n]);
>
> How is this managed_irqs_cpumsk array protected against concurrency?
>
> > +             ncpus =3D cpumask_weight(&managed_irqs_cpumsk[n]);
> > +             if (ncpus < managed_irqs_per_node) {
> > +                     /* Reset node n to current node cpumask */
> > +                     cpumask_copy(&managed_irqs_cpumsk[n], node_to_cpu=
mask[n]);
>
> This whole logic is incomprehensible and aside of the concurrency
> problem it's broken when CPUs are made present at run-time because these
> cpu masks are static and represent the stale state of the last
> invocation.
>
> Given the limitations of the x86 vector space, which is not going away
> anytime soon, there are only two options IMO to handle such a scenario.
>
>    1) Tell the nvme/block layer to disable queue affinity management

+1

There are other use cases, such as cpu isolation, which can benefit from
this way too.

https://lore.kernel.org/linux-nvme/20240702104112.4123810-1-ming.lei@redhat=
.com/

Thanks,

