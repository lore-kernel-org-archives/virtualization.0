Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344EE332912
	for <virtualization@lists.linux.dev>; Tue, 28 Oct 2025 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660598; cv=none; b=m+CJ7AUhd2dzOegv/mLBZMP3P67ZSPlY3KDj6XQUrziS3LsXx0qbyNXpVyQjuAcVWdsNTvDEuw0eswDv+Y1vP1Vx5XSr5iSJRmJpM2sJnhRDhkpC1Bw1hk1ySfNPibuk9ym1Q35drc5xvu7FtvcmeNi/7a4pImjzdrf94u8zsvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660598; c=relaxed/simple;
	bh=k6DUB/80tk/p9ZsPvOsXhgNv+6GExQYVkWQJfA0Xymg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bJNKngjR+Srw3fGOtzi2TaFen/3AyrbetY1ysgsE2LPKy2wJhIfh2sz0pZocWMnVjjpbgmEwlPeaooTCMqf7+kr2E+fzOwja1OkxEahpkRw/8uoMDJ/zyX4gwA2eZOq3LeJ6J4qgSo8JUFM5NvJX0ou3YENR6ieHDht9p8UbRAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R2nCrc+u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2nCrc+u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761660595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KeZZLRTGnwzYPkoev55d4qpCXJZUXZb6bdFgAsfZ6dc=;
	b=R2nCrc+uFe7OIdRWb4OUBMsSp9fVKLMdIyuottvyPylUuSC4jjqzgFcvaDNmD/zYPF8qIf
	VkD5jS9xJTaQN4lHVgOjTwMVMVmdRC5xOOiUmp5SryTCr3ZGVjs72ZFSXmSpRpYhSLphdh
	qys4fMVLcXPoaMFXd7Ccm2CaAd4E/b8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-55EgPSfDPvaNOMchiRAcyw-1; Tue, 28 Oct 2025 10:09:54 -0400
X-MC-Unique: 55EgPSfDPvaNOMchiRAcyw-1
X-Mimecast-MFC-AGG-ID: 55EgPSfDPvaNOMchiRAcyw_1761660593
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-63c1a7be4b1so8253882a12.0
        for <virtualization@lists.linux.dev>; Tue, 28 Oct 2025 07:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761660593; x=1762265393;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KeZZLRTGnwzYPkoev55d4qpCXJZUXZb6bdFgAsfZ6dc=;
        b=Rl69hyp42fGH6yJqhCPMyix2CcKlFu95MNqdCBYSe9bHxRhPN8NKxyD35ajou7E+Uf
         WICxWEV94Xuyk18rAShza81x22lIODXCi3JfMZTOI3IFkkN4DwPlb9AvM7X94Jj6lAfr
         T7jUtGPJRTSTxngAxZfSOR7YSUUiYpgdrsh5jsATASf+aoosB/tzV82DcbfyRUFNMNdt
         Cf+FmuZzlz3sk4skBMjxiWfmEF6ZsBi4iSrHm21udpQkz5R59vfdu2Mq6DO5MmhI+vZt
         ASUDDpoQgtT6euZ2tXxFWlyxBtHzH6yRyLAjZ2hq6ecI56ykFYWZZb2fsgNWkS/dAa4c
         mrQA==
X-Forwarded-Encrypted: i=1; AJvYcCUOoI3fs1cJQ8PY8Gw+nZJ1xdm7rO+djQeRzR8XnWrdE1EPMPPMW4/8XBh5iC8/ldmzAKlAOpMWRLVV5HvR4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxoD1bLsSqVAYYBL1xoOYjPsWE0IXGu6L/BFNfxRpFGZICfP+QK
	6rGCMXC5hS22zNjMd5XErPHhRHPXhY0ar2/u8nPVXR0jjQNQqygNBFbAs597eVzoLrPVNX5RNil
	1Fkygre1UUxLitolvwzU/fBKR+6Hh+K/uZ5PCWgPxuSi20H4pR73m8FbivjhSCHV+oIKY
X-Gm-Gg: ASbGncvdnWSAe0MTl5vRSmCGjkwb/ynXfQ7uDx9gno57X0+EUYxR/ZiNiGzTnoXbIXG
	eaahTkGaMafGmDG5COgyTveffdMTORl1fv4xiumc+Ybh88LfaTR45weM9mcLQh7GHFMVep2kyih
	fojNS66JJwM5+G6PuM6/jyc062U56I2eY6iDi7t9eESwnYWU79gFU7c1t9nEJL4A9qnxO7iqrVc
	RApqf4v2lKMIq6G/B+nGlis001NhOvBqVKab+BDOimwYDSobQA5tGh79ygZCkBewaHJsEgZVCba
	Am8HNf0rpPgKguhmBNw41E7PaPBw/UBcjDDJmCkVeVYWAkEYa92FQfsANJL9cVnU
X-Received: by 2002:a05:6402:1456:b0:63b:f1aa:11d1 with SMTP id 4fb4d7f45d1cf-63ed826acdcmr3237250a12.1.1761660593376;
        Tue, 28 Oct 2025 07:09:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEem+lTvepnFKdZpVOUw39YZBZhlQB90KyKypzmERmitQ6amw9M9mWfyT8audleripecx8J2Q==
X-Received: by 2002:a05:6402:1456:b0:63b:f1aa:11d1 with SMTP id 4fb4d7f45d1cf-63ed826acdcmr3237226a12.1.1761660592882;
        Tue, 28 Oct 2025 07:09:52 -0700 (PDT)
Received: from redhat.com ([31.187.78.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efd0e23sm8969833a12.35.2025.10.28.07.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 07:09:52 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:09:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251028100923-mutt-send-email-mst@kernel.org>
References: <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org>
 <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org>
 <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <20251022060748-mutt-send-email-mst@kernel.org>
 <CAJaqyWdRN3C1nOHQjWroBPWKjc5efNfVbecpruL=Cgsk6i1FXg@mail.gmail.com>
 <20251022073231-mutt-send-email-mst@kernel.org>
 <CAJaqyWeDcyKKOvVdqUkpTuH3d-Tb9rBHG3ym+LC0fcmhrN_FJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWeDcyKKOvVdqUkpTuH3d-Tb9rBHG3ym+LC0fcmhrN_FJA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EeYWdJaIII_uYt5rPNuAdoFRxiN1AtRHkI9DILLZf1o_1761660593
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Oct 22, 2025 at 02:55:18PM +0200, Eugenio Perez Martin wrote:
> On Wed, Oct 22, 2025 at 1:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Oct 22, 2025 at 12:50:53PM +0200, Eugenio Perez Martin wrote:
> > > Let me switch to MQ as I think it illustrates the point better.
> > >
> > > IIUC the workflow:
> > > a) virtio-net sends MQ_VQ_PAIRS_SET 2 to the device
> > > b) VDUSE CVQ sends ok to the virtio-net driver
> > > c) VDUSE CVQ sends the command to the VDUSE device
> > > d) Now the virtio-net driver sends virtio-net sends MQ_VQ_PAIRS_SET 1
> > > e) VDUSE CVQ sends ok to the virtio-net driver
> > >
> > > The device didn't process the MQ_VQ_PAIRS_SET 1 command at this point,
> > > so it potentially uses the second rx queue. But, by the standard:
> > >
> > > The device MUST NOT queue packets on receive queues greater than
> > > virtqueue_pairs once it has placed the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
> > > command in a used buffer.
> > >
> > > So the driver does not expect rx buffers on that queue at all. From
> > > the driver's POV, the device is invalid, and it could mark it as
> > > broken.
> >
> > ok intresting. Note that if userspace processes vqs it should process
> > cvq too. I don't know what to do in this case yet, I'm going on
> > vacation, let me ponder this a bit.
> >
> 
> Sure.

So let me ask you this, how are you going to handle device reset?
Same issue, it seems to me.

-- 
MST

