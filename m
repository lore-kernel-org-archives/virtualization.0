Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C37F6FC3
	for <virtualization@lists.linux.dev>; Tue,  6 Aug 2024 03:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722913846; cv=none; b=SfDcymZ5CZzxQH8O2ofK2d1W5IwrX4bgsWU8cV3ZlFzIk0VFii5gOcKv+KU61l8UcSHq47uF5wahkvu0Dve9IDDG+Y+/lF6k4xUMYukhjJmFeV2BzZZiDDVSRv7A3+b9OO18j825i8oUBiHzWH5/wx84VgBXuK+Q2Smk33Cz9/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722913846; c=relaxed/simple;
	bh=U4HEFD8CUVMLfWTgw9z7V6Ux1UCzXOA+F012FnD1b5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2nyCcUFTfnNAybWPmM9VdZaC/K2DqD/iD0E6qcWno8Qk4oQjnTgmQR5ZzThF1CEfoGIWeI7x1WahOIpH7QVgQEOWTCU5xxKfCXkDgX8rnDZtMIjO8530/lq3jt1T9XD4Y987yuhVzzzsSBbvKBhNOevsHuCKnNzMztB/dGsRNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=L2UMFyco; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="L2UMFyco"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cb64529a36so222301a91.0
        for <virtualization@lists.linux.dev>; Mon, 05 Aug 2024 20:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722913844; x=1723518644; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4HEFD8CUVMLfWTgw9z7V6Ux1UCzXOA+F012FnD1b5w=;
        b=L2UMFycooAyVFWAp0O6rq2RgC0iv/Q6qm4O3a1ZJn9FnltAH/mgoPaDVAn8detvE0n
         Dn2/walBuHVMNnnyECv8nJs7toW3hPa/Cauc4CpjgaZrk9BxbtYo+MV+tpDCvytsoqQr
         o9R9RV2afbGj4D4ORaexCWxYF/C1GMW3j3TSuX+hUQLHFjVtagzRhmVDVwQoxxzPfy9k
         g/IaANwhKwCgqe8W6WOEpR7dCj05yM+CSrbhVnS1foYOElehsrWkrmZVh22u8nfJP93E
         caP9SxO6OqKMkTz9ri+ZkYuClQu38DgyeaOZ8aKTh0Quh8wVRPKI8ld80IHub5v0TwBV
         /ytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722913844; x=1723518644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4HEFD8CUVMLfWTgw9z7V6Ux1UCzXOA+F012FnD1b5w=;
        b=KcaiE1MjK5PtLQcZi0sjhE8wsPUg0tZ8Lr7FMS6XpR1rOFPwCEt6MrO51CZNqiOEAL
         IBO5DWAl5etGMaNr/yy56D3Z7tHgfdfQbzfwHLn54I//fLAwHylixH5uRuKbigbWJbWh
         TKi94ygMiUX+aMRVcpiIigdFKsM5SwnHBo6Xk++G1LplEMDLca8kNgQnHOFWo8a/ppo/
         3YxCmZwmGPqHb5R4bFXcHPy2brUWLmo9ybLxl1tq7cR5jm+i4I/mRTfKzDZszfpm0BUq
         r7g6Yk+0YbQEc33UuYk6h5PDIgNMHmBr4iUvemwXwYdizkPE+3zM41Oci5DkMHFYb6PT
         o/Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUngl6wrEf1nM0VMFuEQfsjsYULvbnkhKaUCwVC7P8fHqo9SZor+FjlHvuDF20GRAEJTYRw2sbMoUTInfV3n0P23vEWNigvu8hJaryn7kY=
X-Gm-Message-State: AOJu0YzyP7P2/DVX0NRdTTwd2u0LCC5EjkQuoie14/RgJZqir3CLYwSO
	FJ5HNs6+wVnJDm1qJBaeaU6KbAnVLQ8UkTUQU5iAGFeTaynFf9RyyZs98zqK6+QNkSrRv5/PCHu
	SMXyuLea9P/3iqTKBoYqxXEBkr4WFlLa1iORF
X-Google-Smtp-Source: AGHT+IHTYparmt/OTUThIPTlzIvOrqD9cz4WdKpTshz9lzOsNEUt309813jePKD3C5KsZ33asBZLz3EEOnXCpOLA/34=
X-Received: by 2002:a17:90a:680d:b0:2c9:a56b:8db6 with SMTP id
 98e67ed59e1d1-2cff9559125mr12349178a91.37.1722913843669; Mon, 05 Aug 2024
 20:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240805082106.65847-1-jasowang@redhat.com> <CACGkMEvNyB_+fHV5aAeCQhebA8aF8+9hnjkjeEzt5bgrVgqw5Q@mail.gmail.com>
 <CACycT3sz-OOKKcmH=FgD7gp_Bhi9=nwnkTn0VgRhQBxS2Dp4qw@mail.gmail.com> <CACGkMEs4YWr5zu0_nVCvqLSFBG9U_A_mw+7AdkMwrPo_6X-gOA@mail.gmail.com>
In-Reply-To: <CACGkMEs4YWr5zu0_nVCvqLSFBG9U_A_mw+7AdkMwrPo_6X-gOA@mail.gmail.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Tue, 6 Aug 2024 11:10:32 +0800
Message-ID: <CACycT3vYF3nwZ3k5_8G=Zok9c4qRjCcGLVQ7+RfSpK=5PToMuA@mail.gmail.com>
Subject: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: Jason Wang <jasowang@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel <linux-kernel@vger.kernel.org>, 21cnbao@gmail.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 10:28=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Aug 5, 2024 at 6:42=E2=80=AFPM Yongji Xie <xieyongji@bytedance.co=
m> wrote:
> >
> > On Mon, Aug 5, 2024 at 4:24=E2=80=AFPM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Mon, Aug 5, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > Barry said [1]:
> > > >
> > > > """
> > > > mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> > > > __GFP_NOFAIL without direct reclamation may just result in a busy
> > > > loop within non-sleepable contexts.
> > > > ""=E2=80=9C
> > > >
> > > > Unfortuantely, we do that under read lock. A possible way to fix th=
at
> > > > is to move the pages allocation out of the lock into the caller, bu=
t
> > > > having to allocate a huge number of pages and auxiliary page array
> > > > seems to be problematic as well per Tetsuon [2]:
> > > >
> > > > """
> > > > You should implement proper error handling instead of using
> > > > __GFP_NOFAIL if count can become large.
> > > > """
> > > >
> >
> > I think the problem is it's hard to do the error handling in
> > fops->release() currently.
>
> vduse_dev_dereg_umem() should be the same, it's very hard to allow it to =
fail.
>
> >
> > So can we temporarily hold the user page refcount, and release it when
> > vduse_dev_open()/vduse_domain_release() is executed. The kernel page
> > allocation and memcpy can be done in vduse_dev_open() which allows
> > some error handling.
>
> Just to make sure I understand this, the free is probably not the big
> issue but the allocation itself.
>

Yes, so defer the allocation might be a solution.

> And if we do the memcpy() in open(), it seems to be a subtle userspace
> noticeable change? (Or I don't get how copying in vduse_dev_open() can
> help here).
>

Maybe we don't need to do the copy in open(). We can hold the user
page refcount until the inflight I/O is completed. That means the
allocation of new kernel pages can be done in
vduse_domain_map_bounce_page() and the release of old user pages can
be done in vduse_domain_unmap_bounce_page(). Of course, we still have
a copy (old user page -> new user spage) if the daemon calls
vduse_dev_reg_umem() again.

Thanks,
Yongji
