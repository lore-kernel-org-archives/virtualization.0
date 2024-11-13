Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FCC2594
	for <virtualization@lists.linux.dev>; Wed, 13 Nov 2024 06:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731479579; cv=none; b=np5jSt/acsS/HYNS5UZHsRMr1ZpCq2MRKHWJrs+btW6OyE1p4IJwbyU3BHkLswaDruT4a4+RPS3guas19vtJ+nyAZKxjT/jAGK0Z0tngATytmFrDvl7lcUVbyqEAmXKVbTtT2ueIwEFF7SRvqOmGPkJ9jsXWBGTs6gG+gokKSvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731479579; c=relaxed/simple;
	bh=Lw3nK/L1jm7SkFLesz8RoI/vr7mkD5mxfPU6EoBK83s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FnpfJBtMsqbz/jYxxXdlmKjl+sYVQjrKVSZQEV+sxGq1tpyhtq6Smrx/ob9ZjCb1KF7H0BvBTgrUcCeesmZpNS9lojr3be6g1SFR09kziZHqLeP7uPzdEaXsGpJbuzl3nC4d2kj67MV5NtGPNRpiyJa8lB0WpjfOwCu05rO1RrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bJvX/sq9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJvX/sq9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731479576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rufpVhFdmb4VBRTafDBR2fxnE3o2Ggdk6Fw5zg77oVc=;
	b=bJvX/sq9xPX0I76untdvn83vcG+f2Fjq2GS18mfz40Nz0NFfQwRMysVABxQplGFEW6hASp
	odLgxWdUFRMJTYN50bH4sFLwLAPb2txv0Frb7t9VnGhj2ion+pHr2ZXv+kZ1DXvmn6LBW7
	njZgqaEyrNlKXriMvN4fA6EJFtLHIrk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-c_h7-9-vMFCc0WF4QjuYKQ-1; Wed, 13 Nov 2024 01:32:53 -0500
X-MC-Unique: c_h7-9-vMFCc0WF4QjuYKQ-1
X-Mimecast-MFC-AGG-ID: c_h7-9-vMFCc0WF4QjuYKQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4316ac69e6dso50943785e9.0
        for <virtualization@lists.linux.dev>; Tue, 12 Nov 2024 22:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731479572; x=1732084372;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rufpVhFdmb4VBRTafDBR2fxnE3o2Ggdk6Fw5zg77oVc=;
        b=Uvf8LJ5IVEpTUJZrAgznhaj9ZNVhbpWO5Z5pZVhCfZLgEgX9wbPTJ7JTLGygIvZtCl
         TZXhDsyAFd8M7baGiEjj24nzjEpgiAB2oNFNdRNlM1TH2J4kR5vanFAYE8ZPj9ABgMfi
         wAN/+sqrn46QGWtZkEc1NoyqGNw9B2pcyvYbCl6qdDiQ1Nmg0GrHb4/j5BEY938Vey92
         T/1kcLHADGqbwZtOyyIGISZs+x3nIFDAnP34ZSP4v4Oo+vqTUlEE7ZYz2bnCirpA20fW
         uHX/A/fGcOnGQSuy+1SiDAvrpNTSnMkk0H9FZfDjg0dKq0QhZnlJF7IZ+ftw8QU34qqX
         vqww==
X-Forwarded-Encrypted: i=1; AJvYcCXwoXQkdI5JB/BBSoPAmTac1Y4h1PeU2oe1ZBCaXdUACk2UzGp2lSeD0GlqpcRv0jgR++6YJM+Z94oEcR7meg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzkcoa86a0VH52stn7fr0puw4Nb7a2bvTcwC484XXCJ+2uMS+JE
	Xh8UmIP7ZJsdmFkW1bcT0azvzrhLAYBjjsjUfSvT8cOz5bxzvggmjaDw/IRuAdnGKoOgW1TOYzE
	S1+Cn4BNwwOH8b6xJKnMStAbMGbDa2Dz2On6SfVZzwH1dx5/+k6R7Q8tcxUxNfzQH
X-Received: by 2002:a05:600c:5124:b0:42c:b995:2100 with SMTP id 5b1f17b1804b1-432b74faa3bmr153588355e9.6.1731479572327;
        Tue, 12 Nov 2024 22:32:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvSivPbOF1a3z2KjRJHfbTayaTS2MPjyFeMmHN0IJchZdRUqbmt8NJD00TQs1TXCkMviDiyA==
X-Received: by 2002:a05:600c:5124:b0:42c:b995:2100 with SMTP id 5b1f17b1804b1-432b74faa3bmr153588185e9.6.1731479571999;
        Tue, 12 Nov 2024 22:32:51 -0800 (PST)
Received: from redhat.com ([2a02:14f:17b:c70e:bfc8:d369:451b:c405])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d5541832sm12580005e9.30.2024.11.12.22.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 22:32:51 -0800 (PST)
Date: Wed, 13 Nov 2024 01:32:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, virtualization@lists.linux.dev,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Eugenio Perez Martin <eperezma@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 0/2] vdpa/mlx5: Iova mapping related fixes
Message-ID: <20241113013105-mutt-send-email-mst@kernel.org>
References: <20241021134040.975221-1-dtatulea@nvidia.com>
 <8e93cd9e-7237-4863-a5a7-a6561d5ca015@nvidia.com>
 <CACGkMEtALWqmoyOBu8vywnk=SuU=N1zKt7sxwueKkYQi3LB0MQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtALWqmoyOBu8vywnk=SuU=N1zKt7sxwueKkYQi3LB0MQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yssxPTRSELI82ZkJB5UHvmAt3q2AiUiFD3IeypEpEiA_1731479572
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Nov 13, 2024 at 09:45:22AM +0800, Jason Wang wrote:
> On Mon, Nov 11, 2024 at 4:58 PM Dragos Tatulea <dtatulea@nvidia.com> wrote:
> >
> >
> >
> > On 21.10.24 15:40, Dragos Tatulea wrote:
> > > Here are 2 fixes from Si-Wei:
> > > - The first one is an important fix that has to be applied as far
> > >   back as possible (hence CC'ing linux-stable).
> > > - The second is more of an improvement. That's why it doesn't have the
> > >   Fixes tag.
> > >
> > > I'd like to thank Si-Wei for the effort of finding and fixing these
> > > issues. Especially the first issue which was very well hidden and
> > > was there since day 1.
> > >
> > > Si-Wei Liu (2):
> > >   vdpa/mlx5: Fix PA offset with unaligned starting iotlb map
> > >   vdpa/mlx5: Fix suboptimal range on iotlb iteration
> > >
> > >  drivers/vdpa/mlx5/core/mr.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > Gentle nudge for a review. The bug fixed by the first patch is a very
> > serious and insidious one.
> 
> I think I've acked to those patches, have you received that?
> 
> Thanks

I saw your acks Jason, thanks!
Patch 1 is now upstream. Patch 2 is queued but I asked a question about
it.


> >
> > Thanks,
> > Dragos
> >
> >

