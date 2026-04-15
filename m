Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB97E3D6474
	for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776243508; cv=pass; b=bV9NRgWqaeu/3VDTase3TPqtwNn/BlkArZUlqZIqxRIP4YLt68J/M+MDiveCLpYjcn7zMwoy92ZXto1jlEP3+wqkuOMBUPuTgbCVfkNkjQP2kcFlEmafSXsOa4rxdKtukjaSuoomgI3yV1Mm6BAUFkCJ6u8nQunQG3FrcQi1nA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776243508; c=relaxed/simple;
	bh=NmZn8YaVwP7ozh9+ymcLzBd4heHiFWdC0pHFeYEhGzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGhuvD1tiFsW1q+mxPJCUnWRfSXFMYYMQNZVtKa7sss3RBkUuVh1nYWsZTMgoS4uMQoxeuZ8JDW8eYFOtkqrTlPiUZkYeVwsURg3X+pH1DQJdrZNUbhBX5VKfA0tazHowvyRLQHWTlSOPUvETaiijyZjO3MyvUchWNhRBbLCFZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxQCqrca; arc=pass smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxQCqrca"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4670464029eso3684068b6e.2
        for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 01:58:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776243506; cv=none;
        d=google.com; s=arc-20240605;
        b=lNrewrorvultd18ViUp5MbDlyyONg2OR44s6YRDTsAwUJ5/IT4ZKemIQCQziBajxXb
         fKyeWAC2B+mm+Cb3PNis/IWf4VEcopg/F8yir26+wzV+qlPwcKnrleomSKyF2XGrdHJs
         8rVUa8HBoqDLGYU1NvyjI2z92DONfZYpwrV/I1BDMKqxCk25SSB7ast1N822xc0smHrg
         wh4UdQkcnCoYMlU/ZPKLn9RA9EC402bAflRANbmmwy2Vx3LbsAJ25AVXLsymh6IUFohA
         ZZsrk/1dQia1Zhip3puLPsDLvNl0SaNJVuxOvo43HgSiY78D2AthvHmt6i5llHraEZD6
         vycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NmZn8YaVwP7ozh9+ymcLzBd4heHiFWdC0pHFeYEhGzA=;
        fh=PHtPnKk6Tg/i9augYq4eAjhl//57zyM08v7dpc10Ba4=;
        b=bcwUrxmrBjNtzvGuc2ht7MTPRXmDHGaSdWGw7FEBZyAEz3O3hbVqmOkkWc2FhQhmrg
         CZeFyQxXoe9rGKtigBshQe3mzqFU3xC60nJxlgJ9yynUASNcw2SHMtLKbzHX8q3krxIf
         aeoizoCdP+IxewE82va8lWor/7kl4ZyoG5bCUXM9td/kUSFHfRApZe8njghWquQfpo4m
         pWCw6WM/iIlIG75ESazvmiRSKXjfOR+t9o6ijzjY0JXz/aKwG+C/g1F2cqdfEDvallCS
         fqkWFh6tSfgmzknJKqEtgXsauh65lXbXAaaTG+sIvAz+P3wGBWZS29hQSdQK6S9BoDXj
         fRJQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776243506; x=1776848306; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmZn8YaVwP7ozh9+ymcLzBd4heHiFWdC0pHFeYEhGzA=;
        b=JxQCqrcapfXC+aICLrVFxxYMHsP3FSku+//ZbrdVMQE/ZCwTwlyIpp5wgzh3bqvpsC
         pwl5T8DjFdqfEkxuNVw94K7nUic7HUpttVvv2YuqdQ4UsEmAVmPXZj9nZh/78S1Slj8g
         4mo8G+pqsUz4AEccDxso0zSGVuQ3j4qYGoXDLFL++7P0y0DAZv+GVpXoocunVzOwBahN
         MlpJmJOKV/CascIdniTvl+OznnT4Kzb22T0dZRaqH77f2bYhrZkd8YoDZnIA3848dsf+
         IANLcEmeiB9d7ji1Rk5+Rb/9Ugki6JB8kCthX7hzF641GRpmmw+5A6JecZ6F4wd3kyY+
         snRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776243506; x=1776848306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NmZn8YaVwP7ozh9+ymcLzBd4heHiFWdC0pHFeYEhGzA=;
        b=LVBRhWeWHKOQ2dAQdXZi0ijJ3ZsKhaLJEA2/9i0wtx6gJqfcXAdcLb8dBaJEjAlW3S
         C/9kEw7AiTR2vKOXtp9gQP3sR/VFFY9nHeuWIeRV5N4IDjT+WdyWwXTzqvXiJsRdlTkD
         L0wqudSQ9Z+H98V//zjvf9LbT2FFbjuMb7XXwvgrmVeJhyeMiCrjyzV2wgNAPyEQc4jo
         6qrohiJrp3sa31EjcBiyduOcXmGNtTmtnVePgYGjS48cXx+7kasAW0mV/k5/zfYDjNCu
         HotlrpSQ1T53KA0vwnN55DRXYhk15KIdYdPSZ1RmV4swdbUvjUGE0+iqYbZj09xvYRvU
         lHLw==
X-Forwarded-Encrypted: i=1; AFNElJ+qj8e+vzE4d+KlCrQnMveDGih5HLZtQA58rCm7N0ueJhTdbHpefU/LoNqhnoxb+zybZKFCI/w8+4VTq9n41A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLBcmcAGx2d4ZZWhv4/MqJ4F8+xX44n5Kz+fc8xa4BWSeMQ2GR
	wnJmvBa7F2bh3wtMT9Lc7m1ZjwF1l133KcAAE7jwWbcqT8ZlPpk3eA0Ov62x/ypS7vRSVsDBTAw
	L5fcHlcFmBEVFdAD7hGVZ2N/7f/9jWnE=
X-Gm-Gg: AeBDietzV8GkGoMxN9yk6A+CdnI8GUSMIHbv0i29SSKmcGmXvb0C3yJPTCkG0KTO90l
	7mNX6QcYwfolA/cJxxfwukOEDk2SUZxPnT5OAfj6wn1zuFy2E/exR4DvXew9FKvjd5BpJUA2ULj
	gtmafXcvfXg8MhkG85V+OSc39A6zRSsLSfAc+3/vX6k8XJZpgvMI0w3ZLGRS/GnVBayIXHCrpVI
	OFVr3C3bhrAT3zbmwMPacX696yprsg8SRg2V7aGTghBP1LRzcrgo8krPOZm31yYZNVH3YxXnxzA
	/Tgn/sLE1zw2p9klFqt4Q073OaCYzeswFKaaxH/mUQ==
X-Received: by 2002:a05:6808:c162:b0:467:91:fb26 with SMTP id
 5614622812f47-4789f111a6dmr9948231b6e.37.1776243505664; Wed, 15 Apr 2026
 01:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <nxe24ixebb4lm2d5w4aubhtwr23df6mumqd663axj35oswdiyv@amtqhtsidyr4>
 <adMoon3Zf6gO-UbA@fedora> <zawhqvn53mcp4wf7axsmuq4cg73upxs5h2zgrfta5dpat3sfy4@zctfbz2ttz5m>
 <CAFj5m9JE5e4DRGbzQFxDdZWU76ZPQ3G+C9JpLu0mhTB6aesZ9g@mail.gmail.com>
 <a566smu6morqeefqal23eek4ibezfuiwhs774xtxhyyclpbtsx@uzzwgbzmwdjd>
 <adhj_w11cpMfeEgN@fedora> <dzpxscrhibmi5okkozf5jfull4dcajgpctldvdyfcjgmpeetk5@tkeyqouyabzy>
 <adpD8M8cNu3IZzEL@fedora> <6glgsbk2djsz4cqtbp2ht4274dw4rveq6fojlnpnuvx6zmpjxw@i43jo2l4qlz4>
 <ad0Hk48y5JEeMlFk@fedora> <20260415083458.UD3cF5IQ@linutronix.de>
In-Reply-To: <20260415083458.UD3cF5IQ@linutronix.de>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 15 Apr 2026 16:58:14 +0800
X-Gm-Features: AQROBzBesZ1I4COKhVLm4yVWD97BVXXbWvhA1t-bSTLWqOPST2qVCo792OkUIh8
Message-ID: <CACVXFVMPO_JZMSbELnsKzUpXZ7M1sF7cHETUtdqEFT73gn9shA@mail.gmail.com>
Subject: Re: [PATCH v10 13/13] docs: add io_queue flag to isolcpus
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Aaron Tomlin <atomlin@atomlin.com>, Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk, 
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, mst@redhat.com, 
	aacraid@microsemi.com, James.Bottomley@hansenpartnership.com, 
	martin.petersen@oracle.com, liyihang9@h-partners.com, 
	kashyap.desai@broadcom.com, sumit.saxena@broadcom.com, 
	shivasharan.srikanteshwara@broadcom.com, chandrakanth.patil@broadcom.com, 
	sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com, 
	suganath-prabu.subramani@broadcom.com, ranjan.kumar@broadcom.com, 
	jinpu.wang@cloud.ionos.com, tglx@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com, 
	yphbchou0911@gmail.com, wagi@kernel.org, frederic@kernel.org, 
	longman@redhat.com, chenridong@huawei.com, hare@suse.de, kch@nvidia.com, 
	steve@abita.co, sean@ashe.io, chjohnst@gmail.com, neelx@suse.com, 
	mproche@gmail.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 4:35=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-04-13 23:11:15 [+0800], Ming Lei wrote:
> > > > What matters is that IO won't interrupt isolated CPU.
> > >
> > > The isolcpus=3Dmanaged_irq acts as a "best effort" avoidance algorith=
m rather
> > > than a strict, unbreakable constraint. This is indicated in the propo=
sed
> > > changes to Documentation/core-api/irq/managed_irq.rst [1].
> >
> > Yes, it is "best effort", but isolated cpu is only take as effective CP=
U
> > for the hw queue's irq iff all others are offline. Which is just fine f=
or typical
> > use cases, in which IO isn't submitted from isolated CPU.
>
> Couldn't we tackle this by limiting the number of managed interrupts the
> device asks for and then limiting the CPUs it could be bound to?
>
> So if have house keeping CPUs 0/1 and isolated 2-63 then managed_irq=3D i=
s
> futile since it use 64 interrupts and map each to one CPU. Even if the
> device supports less it would map them evenly across available CPUs.
>
> If the user wishes to initiate I/O from all CPUs but not be bother by
> interrupts we could limit the device to ask for 2 interrupts instead of
> 64 (with the consequence of more queue sharing) and then limit those two
> interrupts to CPU 0 and 1 instead to CPU 0-31 and 32-63 like it would be
> now the case.
>
> Wouldn't that be what the io_queue flag tries to do?

Yes, that is why I call it one optimization, however it does introduce
cost of CPU offline failure, please see patch 11.

Thanks,
Ming Lei
