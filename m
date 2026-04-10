Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDB12D9797
	for <virtualization@lists.linux.dev>; Fri, 10 Apr 2026 02:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775789077; cv=none; b=fZBS2Xqz/v2Qtgdh8aLSJai5tdCU+kkm9vqqyk3TfJWkrjcrUj6URmfbQr9xVHyzB30qB3vWdhLB4PvG6YdpP/eD34SauQD8oyhVvaDGJbakwNGeQaFtgeKaRgs07IYkxW9galtQG1ntz593dryT5CcRLjqe4r35WiUv2plVxNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775789077; c=relaxed/simple;
	bh=TPe+unbB39v2p3g34Bl3H0+CW+J9BRBNX3aGbJ25L2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnwYeAsW+JWBz9Uf6abYPHeyIxgilQfzaGubnMbxM3F/hbcs8RqSClDNiUWvrfWgjurh/arhez6MBR0ik7SB/ep59yKF2IEItJAqSFREgtlc0uPUtzHta9XbxxW7HaOUjL1IaKK3tdcDHlC17zeKWWFHHY+uWymILWD3d3HYhLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOAbsSOE; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOAbsSOE"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35d9c7bf9a1so1584497a91.3
        for <virtualization@lists.linux.dev>; Thu, 09 Apr 2026 19:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775789076; x=1776393876; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Y42v4l6XRa4Mc3bL0tysYnB0VcDZSP2r5rXfsoOeKc=;
        b=ZOAbsSOEE4Iqvj/1ohF/mLdPyj4r1ajfiVk/+yhINngs3rTNn7HtBeR2prf3hVPkdC
         EShYia9/oOe2pwjAVpVxD7Q9Ggt8Zu7kurkXTD11EhvNwe0UtEq+SeXkVml4GcP7+PK1
         DFLKlCQRCaEdO6tVAfx4Iqn5F97MHeZol3LvELhn1q9LUe68yzbMcLKqBkjPRiUBbgfX
         JbAcx/t6cMCG/77/GdcL4mH3BezkRokOcyYSkkyk4RPScA5Hb0AwTOjZd4LnYOm6ySpn
         oAsqkBLfDIakVNrrSs8Ydnea6iaM+9Q8Cllzx+/VzwMYK84oQq/cM6lHTFoqyT8RPI0X
         Otug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775789076; x=1776393876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Y42v4l6XRa4Mc3bL0tysYnB0VcDZSP2r5rXfsoOeKc=;
        b=jIBqd1zlzsda4xuDTOu0xcz7XzgUF2xqTKyLmC32LqFc1M9nEuT+wzchSw3nV/7lu1
         FDhhFTeiwXbsa8F9CVSBwl1KEasP2DacXPrduPLqxZ8lALHb9TGpq/MgLdlnSXQ4x1jQ
         6CiS77fLtrlN59d9L8IrWL1NMNcMOUwMSEcxypNmoGS1WseNMPMP9vXSUBzDMG5tdlpU
         GPH1xgEVmw2+nrU9nSAhGDGuQr9kiC4SYMx+6cuJzrsXCrQstewMmchKoYcJiMxh6any
         nnLnwZ3wqTrSbeeMtL/71cT4qFP7SLzjWn7Dkch19xaoaaWXbj48MIpzbJuQgmZd0PQP
         kp9g==
X-Forwarded-Encrypted: i=1; AJvYcCVx6NaLjGpJlA1BISsSz75OiIFvG9l+dE4/2zpJdGVQEyHF4AOpkQ4U35TuTHaBsUcG/Y0toph4U3xesI6+zg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRFnIgmYTfzjE7pafO938ye4cOI8fcfiPf5QPxT8OwkmJrc2qV
	dlV5FObx9Sq3YIsGUuJmC22KGP+1HICwYcmDD5llFDUER25BzvfEuTto
X-Gm-Gg: AeBDiesp/jqJpOV+w4+hweN5QuyzlJIH/UKmFmUpeFEfdB/A2x52cPEXRRGO6ZJb1w8
	HdgOEsrZ7ybk9rF3BPUMY/FT1oVVG6aDlXV3+3s2rBMfaOVesBU+ls7SJ2no9u6esc6GEIB8iaQ
	sXinzfnXgsvveujVjRg3ZspWn024c8BBekJr0ITQWRXTHV+as8Q5+e8ovHmm6uUZZH7VDgA/D7E
	hKGgWA4eWF15X2FXFlATQsL8w0d75X50aE9IAXbKNIMZmDQrNRVxel8nBGLjxjORHIqOG2c37xY
	u1TaqBJWz2LSH2VRKJFIoUKQdfgZknJn3JavJf5exJ/8JmUqm6olTOm64Q97ykwRmfYt0V1nVIW
	24uyS4JCkHBSBXG8WXuytrx2Hf3el8gG6jknSvmkJwgO/J+GcTXfW3BThnexBqC+DM6B4ttYszb
	AlcFvO+7CEGUlRHL01bntmRnxVbBKbIrF0PKlg/bwSbbBLCEEQX5ma
X-Received: by 2002:a17:90a:e7ca:b0:359:974a:3d65 with SMTP id 98e67ed59e1d1-35e4285280dmr1485690a91.16.1775789075530;
        Thu, 09 Apr 2026 19:44:35 -0700 (PDT)
Received: from fedora ([2001:250:3c1e:503:ffff:ffff:74aa:4903])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e35156445sm4526177a91.14.2026.04.09.19.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 19:44:34 -0700 (PDT)
Date: Fri, 10 Apr 2026 10:44:15 +0800
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
Message-ID: <adhj_w11cpMfeEgN@fedora>
References: <20260401222312.772334-1-atomlin@atomlin.com>
 <20260401222312.772334-14-atomlin@atomlin.com>
 <ac8l-w8ERG1YN2Wm@fedora>
 <nxe24ixebb4lm2d5w4aubhtwr23df6mumqd663axj35oswdiyv@amtqhtsidyr4>
 <adMoon3Zf6gO-UbA@fedora>
 <zawhqvn53mcp4wf7axsmuq4cg73upxs5h2zgrfta5dpat3sfy4@zctfbz2ttz5m>
 <CAFj5m9JE5e4DRGbzQFxDdZWU76ZPQ3G+C9JpLu0mhTB6aesZ9g@mail.gmail.com>
 <a566smu6morqeefqal23eek4ibezfuiwhs774xtxhyyclpbtsx@uzzwgbzmwdjd>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a566smu6morqeefqal23eek4ibezfuiwhs774xtxhyyclpbtsx@uzzwgbzmwdjd>

On Thu, Apr 09, 2026 at 09:45:04PM -0400, Aaron Tomlin wrote:
> On Thu, Apr 09, 2026 at 11:00:09PM +0800, Ming Lei wrote:
> > How can the isolated core be scheduled for running polling task?
> > 
> > Who triggered it?
> > 
> > > loop waiting for the hardware completion. This would completely monopolise
> > > the core and destroy any real time isolation guarantees without the user
> > > space application ever having requested it.
> > 
> > No.
> > 
> > IOPOLL queue doesn't have interrupt, and the ->poll() is only run from
> > the submission context.  So if you don't submitted polled IO on isolated
> > CPU cores, everything is just fine.  This is simpler than irq IO actually.
> 
> Yes, you are entirely correct. The ->iopoll() is indeed executed strictly
> within the submission context. In the example below, the file operations
> iopoll callback is iocb_bio_iopoll():
> 
>       // file->f_op->iopoll(&rw->kiocb, iob, poll_flags)
>       iocb_bio_iopoll(&rw->kiocb, iob, poll_flags)
>       {
>         struct bio *bio
> 
>         bio = READ_ONCE(kiocb->private)
>         if (bio)
>           bio_poll(bio, iob, flags)
>             if (queue_is_mq(q))
>               blk_mq_poll(q, cookie, iob, flags)
>               {
>                 if (!blk_mq_can_poll(q))
>                   return 0
> 
>                 blk_hctx_poll(q, q->queue_hw_ctx[cookie], iob, flags)
>                 {
>                     int ret
> 
>                     do {
>                         ret = q->mq_ops->poll(hctx, iob)
>                         if (ret > 0)
>                             return ret
>                         if (task_sigpending(current))
>                             return 1
>                         if (ret < 0 || (flags & BLK_POLL_ONESHOT))
>                             break
>                         cpu_relax()
>                     } while (!need_resched())
> 
>                     return 0
>                 }
>               }
> 
> If an application on an isolated CPU does not explicitly submit a polled
> I/O request, it will not poll. Thank you for correcting me on this.

Great, you finally get the point.

> 
> > Can you share one example in which managed irq can't address?
> 
> Without io_queue, the block layer maps isolated CPUs to these queues, and
> the device will fire unmanaged interrupts that can freely land on isolated

For unmanaged interrupts, user can set irq affinity on housekeeping cpus
from /proc or kernel command line.

Why is unmanaged interrupts involved with this patchset?

> CPUs, thereby breaking isolation. By applying the constraint via io_queue
> at the block layer, we restrict the hardware queue count and map the
> isolated CPUs to the housekeeping queues, ensuring isolation is maintained
> regardless of whether the driver uses managed interrupts.
> 
> Does the above help?

As I mentioned, managed irq already covers it:

- typically application submits IO from housekeeping CPUs, which is mapped
  to one hardware, which effective interrupt affinity excludes isolated
  CPUs if possible.

I'd suggest to share some real problems you found instead of something
imaginary.

> 
> > > >
> > > > IMO, only two differences from this viewpoint:
> > > >
> > > > 1) `io_queue` may reduce nr_hw_queues
> > > >
> > > > 2) when application submits IO from isolated CPUs, `io_queue` can complete
> > > > IO from housekeeping CPUs.
> > >
> > > Acknowledged.
> > 
> > Are there other major differences besides the two mentioned above?
> 
> I believe the above is sufficient. Please let me know your thoughts.

Both two are small improvement, not bug fixes. However the user has to pay
the cost of potential failing of offlining CPU. Not mention the little 
complicated change: `19 files changed, 378 insertions(+), 48 deletions(-)`

But I won't object if you can update the commit log/kernel command line
doc and fix the issue found in review.

Thanks,
Ming
