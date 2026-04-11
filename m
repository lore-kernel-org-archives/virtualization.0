Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9413A1F4C96
	for <virtualization@lists.linux.dev>; Sat, 11 Apr 2026 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775911950; cv=none; b=ErPx9PWxwXWawSL+NLrholUnJWCGMMCcw8au9c1JUnhX2+Rey+gfSHACjtPT97RL8N2+eCkHHvv2f0n0MSFS47ql+ZBxhpQB8BTl6JnpprNq+g5kbOBizmMAstlDP1juqtUdDGUi2BM14tCsV+X0MUOZ4Ke8B+KHHvUA/JUy2vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775911950; c=relaxed/simple;
	bh=ZDCD7TMmMBU4ptro5VqHZHIwf1F5zUtyaHM3OL4FbJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m560d/hJ6znEeL7kIaPkrynozsdDBukbDbZ0kkrLCglGNtj3DWfk0HkU3VrWYrGdGPNuxWc1rZ1QitSXTd0MkjMRHnlWrP4dvvXHUMGi/pdECZA51N1f+Xrj3kBrbGJb0F+El1c+xKSa/b7bBWAp1s6x1m/dhNORDiinGDnk4Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKY5Ckec; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKY5Ckec"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9b1df1a6b3so339580866b.0
        for <virtualization@lists.linux.dev>; Sat, 11 Apr 2026 05:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775911947; x=1776516747; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HzOvPiW8ztwbs3wF3jjs1dxbj2pwYigEFa9b+mMyiMw=;
        b=OKY5CkecjMVyVDAV5opy/TXVzz83uri48mXmkoCYGjqsLE2lVZUpnTzgZXypsllLTh
         pcju9uzSp/xMfVhw4hwkdo1ViD4DRA3cHO9vCm8meCXZhBGnHLymCGX0Caqyf8eCWgAN
         fRYlNpCGnXyVI7EPzwtd3S00lWC6xSxlmD5zzjYcH+mTZUXpWucS64C5Jf2UETW0daH1
         sUuHXj2raReEJu/M5dL3pB4HqPRRh1OdxTvLWmhXc5AsOD2RSV3jkB2kwKKVw1yGHKX2
         PS8Wzhj4iJmyb3QW/nB4znsLX/vHkhN4bYFSx5mNRoo26PxFVeUOaEgqwlTyHxfhCc8D
         iIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775911947; x=1776516747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzOvPiW8ztwbs3wF3jjs1dxbj2pwYigEFa9b+mMyiMw=;
        b=P+XzzHwlKXk5L/VoHgKcZY5b7gi/j7obFe9+YhgGaOKn02K2hu85pUaQr1r+ZzETDW
         GY7z40cftDkGnqUp0FlBjz2r6vIyNkeeKw86b4IJZfEtPMM40pCLkY8nZyDJJjdiVYxH
         7bcZTKSiAefef34EvSAq4GC3oyHir63ayfPH8pSG+0xBEQ0t2riaywrmlaolJNI7eDqo
         rNDU97G8r9t2IaooKSex4CFOgnkBWYz+4r89AVrrsoCUr/edsja8/XF9Hr42djWdNWWj
         KCf9patxawWX3TNkmXIDMMc8QD4vDkjaZK4bPxRySUAOyIvmztgfuV3Vk79tScAmo6ED
         aO8w==
X-Forwarded-Encrypted: i=1; AJvYcCX1psKR+hgn2JTs2prjMsgWb+zjyE73BEDY40SUinTp1KTlA8vcJElmyLN/5zCuFM3uoVmbgbEfmNkcg/tDHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJTgjbRTJKWL+uHKiGCYCNfoC1vOG1Gv9y0q+iKwwlN6938rdf
	hiWaItN8iLTy4kMeewdAaTO6YcH2py2vLl7TS+mSOFb+u83aFGhuk6xE
X-Gm-Gg: AeBDievnbbQXwe+hOWbbQee+KFQ+CjaYHecHDHQ76GvlKZgSX5HJL+5qyjmrvhkNRgp
	7t0ppTdaqUjXgg+HT/wC4PgBK/kwI/bs+wfHgL7sI4pAAgNj6AoI0Y1KbCyLXoYcm2y2r3uBQe6
	i7xVM/PI3GRphfCFJyXwgkD6tIEGjEIglgzLbHJdEJp389JCLhvrZwWQyOqE6kyWqIVR7YXC46k
	Fsnf+Y9mnvUqjeBCxOSMp/hOTIvOStWGiK+B8u//fJ28RPf4z5dx2e1O+pVFvZXk8g303VRkSX4
	1jSGyQOhES82RVXGLrZ0+FRFOv48v9TaK9jcT8vcw2Cu4XYpWgatvwaBq4P7n++AiGW1ZZ5glRY
	5vLVZGBektdxgKcJA0A19UjfaOvR1qMoNEK8U66x5Y1MSESNr0A7C7CjF+TSy9ZdA3Mfveuf/Z+
	zJBTP+BI0alESe8ZPqtigK3vvkRvS/iuatBFbn6zgkddO6A968lGXZ4DXaKe1HNc56xbRPogTIY
	/WEAXqG
X-Received: by 2002:a17:907:8b98:b0:b87:d09c:1825 with SMTP id a640c23a62f3a-b9d72792c0cmr382274666b.13.1775911946574;
        Sat, 11 Apr 2026 05:52:26 -0700 (PDT)
Received: from fedora (185-147-214-8.mad.as62651.net. [185.147.214.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7f1e87sm159883666b.61.2026.04.11.05.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 05:52:25 -0700 (PDT)
Date: Sat, 11 Apr 2026 20:52:00 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me, mst@redhat.com, aacraid@microsemi.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	liyihang9@h-partners.com, kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
	chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com, suganath-prabu.subramani@broadcom.com,
	ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com,
	tglx@kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com,
	bigeasy@linutronix.de, yphbchou0911@gmail.com, wagi@kernel.org,
	frederic@kernel.org, longman@redhat.com, chenridong@huawei.com,
	hare@suse.de, kch@nvidia.com, steve@abita.co, sean@ashe.io,
	chjohnst@gmail.com, neelx@suse.com, mproche@gmail.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
Subject: Re: [PATCH v10 13/13] docs: add io_queue flag to isolcpus
Message-ID: <adpD8M8cNu3IZzEL@fedora>
References: <20260401222312.772334-1-atomlin@atomlin.com>
 <20260401222312.772334-14-atomlin@atomlin.com>
 <ac8l-w8ERG1YN2Wm@fedora>
 <nxe24ixebb4lm2d5w4aubhtwr23df6mumqd663axj35oswdiyv@amtqhtsidyr4>
 <adMoon3Zf6gO-UbA@fedora>
 <zawhqvn53mcp4wf7axsmuq4cg73upxs5h2zgrfta5dpat3sfy4@zctfbz2ttz5m>
 <CAFj5m9JE5e4DRGbzQFxDdZWU76ZPQ3G+C9JpLu0mhTB6aesZ9g@mail.gmail.com>
 <a566smu6morqeefqal23eek4ibezfuiwhs774xtxhyyclpbtsx@uzzwgbzmwdjd>
 <adhj_w11cpMfeEgN@fedora>
 <dzpxscrhibmi5okkozf5jfull4dcajgpctldvdyfcjgmpeetk5@tkeyqouyabzy>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dzpxscrhibmi5okkozf5jfull4dcajgpctldvdyfcjgmpeetk5@tkeyqouyabzy>

On Fri, Apr 10, 2026 at 03:31:22PM -0400, Aaron Tomlin wrote:
> On Fri, Apr 10, 2026 at 10:44:15AM +0800, Ming Lei wrote:
> > For unmanaged interrupts, user can set irq affinity on housekeeping cpus
> > from /proc or kernel command line.
> > 
> > Why is unmanaged interrupts involved with this patchset?
> 
> Thank you for your continued engagement and for ultimately supporting the
> progression of this series.
> 
> To clarify the handling of unmanaged interrupts, while it is entirely true
> that an administrator could attempt to manually configure "irqaffinity=" or
> via procfs after the fact, this series actively address unmanaged interrupts.
> 
> > > CPUs, thereby breaking isolation. By applying the constraint via io_queue
> > > at the block layer, we restrict the hardware queue count and map the
> > > isolated CPUs to the housekeeping queues, ensuring isolation is maintained
> > > regardless of whether the driver uses managed interrupts.
> > > 
> > > Does the above help?
> > 
> > As I mentioned, managed irq already covers it:
> > 
> > - typically application submits IO from housekeeping CPUs, which is mapped
> >   to one hardware, which effective interrupt affinity excludes isolated
> >   CPUs if possible.
> > 
> > I'd suggest to share some real problems you found instead of something
> > imaginary.
> 
> If we trace how mpi3mr sets up its ISRs, it relies heavily on the core
> grouping logic:
> 
> mpi3mr_setup_isr
> {
>   unsigned int irq_flags = PCI_IRQ_MSIX
> 
>   struct irq_affinity desc = { .pre_vectors =  1, .post_vectors = 1, }
> 
>   pci_alloc_irq_vectors_affinity(mrioc->pdev, min_vec,
>                                  max_vectors, irq_flags, &desc)
>   {
>     if (flags & PCI_IRQ_MSIX) {
>       // affd != NULL
>       __pci_enable_msix_range(dev, NULL, min_vecs, max_vecs, affd, flags)
>       {
> 
>         for (;;) {
> 
>           msix_capability_init(dev, entries, nvec, affd)
>           {
>             msix_setup_interrupts(dev, entries, nvec, affd)
>             {
>               // affd
>               irq_create_affinity_masks(nvec, affd)
>               {
>                 for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
>                   unsigned int nr_masks, this_vecs = affd->set_size[i]
>                   struct cpumask *result = group_cpus_evenly(this_vecs,
>                                                              &nr_masks)
>                   if (!result) {
>                     kfree(masks)
>                     return NULL
>                   }
> 
>                   for (int j = 0; j < nr_masks; j++)
>                     cpumask_copy(&masks[curvec + j].mask, &result[j])
>                   kfree(result);
> 
>                   curvec += nr_masks
>                   usedvecs += nr_masks
>                 }
>               }
>             }
>           }
>         }
>       }
>     }
>   }
> }
> 
> The critical issue lies at the invocation of group_cpus_evenly(). Without
> this patchset, the core logic lacks the necessary constraints to respect
> CPU isolation. It is entirely possible, and indeed happens in practice, for
> an isolated CPU to be assigned to a CPU mask group.

It is one bug report? No, because it doesn't show any trouble from user
viewpoint.

Sebastian explains/shows how "isolcpus=managed_irq" works perfectly in the
following link:

https://lore.kernel.org/all/20260401110232.ET5RxZfl@linutronix.de/

You have reviewed it...

What matters is that IO won't interrupt isolated CPU.

> 
> The newer implementation of irq_create_affinity_masks() introduced by this
> series resolves this. It considers the new CPU mask added to the IRQ
> affinity descriptor. When group_mask_cpus_evenly() is called, this mask is
> evaluated [1], guaranteeing that isolated CPUs are entirely excluded from
> the mask groups.
> 
> [1]: https://lore.kernel.org/lkml/20260401222312.772334-8-atomlin@atomlin.com/

Not at all.

isolated CPU is still included in each group's cpu mask, please see patch
9:

https://lore.kernel.org/linux-block/20260401222312.772334-1-atomlin@atomlin.com/T/#m59df0689ef144f5361535ce59c9ed5923d6e21d5



Thanks, 
Ming
