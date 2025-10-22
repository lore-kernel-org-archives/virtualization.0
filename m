Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3914FD2FB
	for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127624; cv=none; b=g1NhiOSZaVrViN6omTGczBznevvpfiCy9Qs+k6Qmvz35NFYJs0Bc1gXNMEFUNHO8h4GG87Li61sHUg37wD7HizW6UZrIjGMg6lSldw7RIs++PWbnkrKdtk9ktpIWTwed5sr8/xRXO3/tFhBVyOQwG679DGqdW9Qi5LBIh0hkhXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127624; c=relaxed/simple;
	bh=KXby+KBos3mBCHbCtKceC1SeknYNBjI8ybIfHn2TN5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fE+XEBuszR+pBnYJa/i3y6l47qcIRBT2N45yVfTxVddONis1PzK3wtCRIramgpm8M4Y2ADyxsm/C0rUyxMeCDa0GUZMr/2eh36k6xzhXMt3fzxvfchK1KloF+j0Onsax/eHvlllzEGjf5tsfc8IiBn1p1/cIP7NXyeQyBBOt5R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Op9QeDMa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Op9QeDMa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761127622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/e+F1wjH70YTwPDjaw/7Mb8vtwGL0zVerrZ8/E0h6d0=;
	b=Op9QeDMaYLRZxt+/KQIkcl5c2YM7McJKGM+Aeoz1mMU8FLnPcSfemp3gj+4CF4n3jEm/Jm
	OBFEO1lsmEtk4hXiwnFNnNswfbqSADJw300WfGHMrKbpMHva5kv8t1uZCOc6u2La2gITDx
	AE6I1pdBvJnt1Oq/K7zKHeY+ThBdix8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-KaiA8FUcOxqXHrFgc0JGJA-1; Wed, 22 Oct 2025 06:07:00 -0400
X-MC-Unique: KaiA8FUcOxqXHrFgc0JGJA-1
X-Mimecast-MFC-AGG-ID: KaiA8FUcOxqXHrFgc0JGJA_1761127619
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b48635cf06fso683059166b.1
        for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 03:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761127619; x=1761732419;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/e+F1wjH70YTwPDjaw/7Mb8vtwGL0zVerrZ8/E0h6d0=;
        b=O372lsOKmejYh0Eu+UneTYChYTWUx1oc+SHx4QqK8JUt+GAMz+ndGZJkoaYuBm04Vq
         qNIuAPr1NkJMConhMifeJtZAlH1Sp87eToxU/Q72EyGRlAt0vCVuUN/WnxRjlXv8/UXF
         VBPTZ3tIB8oEIWus1K61izVeB7iQPsfacOh8ahLvibOkk0nwXamG3tSwMjNpUGB1WtxG
         H5fzqPjCB5+Sl1M+e0YFh0HITzQVXFmyG8SHNVrfZVv1I4J04jE/Qhp99Oija3cM2zbP
         nzAzoMxnH2LpHDA1bIoDpw33/kvcgSnWDM3pKpj72eHnDWhS7moH+cwM3H5wMUBdE3b3
         3wcw==
X-Forwarded-Encrypted: i=1; AJvYcCXy6XJ1vPVJsrInRMU/IUm1vv7kY7xupB1NExEw5dBPc6vQRpipveYcBxbJ86ZS+/fFnaoDb5OxTAWZcSP/UQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyy7EB3Z6lID1AdTAW9dvBVTXzN6JUBMwGrYBVPY9kVRBBilGck
	lG9HO/seQS5dvhsvzEeDP55yRTXc8pu1xPgc8wQLpsj/sKc9DCEHDR1LFl9n+lV0rOC2cxSLJ16
	jMuTKERM2NcgaPa1aw7ofL+mSyUVvT48wCLVYCXF9+LkZVhzwoMzXBl5b4wjZe11j2PlI
X-Gm-Gg: ASbGncvBCNouuGJIrYKjGVWfv7QxrKNE7rnrrX2ZdhwblqMZWGJW2tJ0XlaQzbdVg4I
	xro2PERwKKDaLWD9JDOAi+MjTgfkVzxlUr2Eh6AUeTBkb9Qz7aWp00LolXQI8KjPGnmIOPve6Tx
	qDk6kpQHnWQL+sxmU5VIJ3AYAIiG1SmMUS1pd9uCk8jbjnR/hOsBmH6dsJJIl+JcsLZl9TAcL0L
	Pq7vLrv0Q/VoHwzDsnvuD2iuQUMNqt9tRfO5ufu83fhQc/kCxOptCh2vEj++ful+5T6QEulN/qU
	yM1YuBxtnCvKT4ku+5l9NS1HU6sP0XtSF3fqYTpoUnKuYNN84LMsQdfY+Y/zzjqW
X-Received: by 2002:a17:907:980f:b0:b3c:3c8e:189d with SMTP id a640c23a62f3a-b6474b37113mr2591860866b.32.1761127618654;
        Wed, 22 Oct 2025 03:06:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdi4vCu0HcpcB9RZjtPHlWXKhaiLhZv2KMQBy/nOXAmeOE3Rh1TYravOf+t544Sn9yyv5kZQ==
X-Received: by 2002:a17:907:980f:b0:b3c:3c8e:189d with SMTP id a640c23a62f3a-b6474b37113mr2591856866b.32.1761127618149;
        Wed, 22 Oct 2025 03:06:58 -0700 (PDT)
Received: from redhat.com ([31.187.78.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebf434f0sm1301190766b.82.2025.10.22.03.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 03:06:57 -0700 (PDT)
Date: Wed, 22 Oct 2025 06:06:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251022060506-mutt-send-email-mst@kernel.org>
References: <20251015040722-mutt-send-email-mst@kernel.org>
 <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <CACGkMEuPPFLH1YqTx03fV9N=Rx3aYXK0HMUDpZu-CvO1NYRRQA@mail.gmail.com>
 <20251016014328-mutt-send-email-mst@kernel.org>
 <CACGkMEtXWLicmszjkzOhX8Ta=LdGgsDahRUKDEVzBVG8am5vgg@mail.gmail.com>
 <20251016022131-mutt-send-email-mst@kernel.org>
 <CAJaqyWe--Hho9EdweqkC-h9=t5vhY0cbAN9uAw=hATpkSMbsEg@mail.gmail.com>
 <CAJaqyWdEY6KaVbBn5LJhkz7h6kytFg8-b8iXnc9N54L+q_Yrbw@mail.gmail.com>
 <20251017023902-mutt-send-email-mst@kernel.org>
 <CAJaqyWcyJU_ghJpQrnEyTf19o_NzE6FXkxgBRZx=1RYqQkN4gA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWcyJU_ghJpQrnEyTf19o_NzE6FXkxgBRZx=1RYqQkN4gA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mkHa48ffmw5xwits8LvGc7KUDdn9fA5RI-LZ5zGnc_Y_1761127619
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Oct 17, 2025 at 09:21:17AM +0200, Eugenio Perez Martin wrote:
> On Fri, Oct 17, 2025 at 8:39 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Oct 17, 2025 at 08:36:41AM +0200, Eugenio Perez Martin wrote:
> > > On Thu, Oct 16, 2025 at 8:25 AM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Thu, Oct 16, 2025 at 8:22 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Thu, Oct 16, 2025 at 02:03:57PM +0800, Jason Wang wrote:
> > > > > > On Thu, Oct 16, 2025 at 1:45 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > >
> > > > > > > On Thu, Oct 16, 2025 at 01:39:58PM +0800, Jason Wang wrote:
> > > > > > > > > >
> > > > > > > > > > Not exactly bufferize, record.  E.g. we do not need to send
> > > > > > > > > > 100 messages to enable/disable promisc mode - together they
> > > > > > > > > > have no effect.
> > > > > > > >
> > > > > > > > Note that there's a case that multiple commands need to be sent, e.g
> > > > > > > > set rx mode. And assuming not all the commands are the best effort,
> > > > > > > > kernel VDUSE still needs to wait for the usersapce at least for a
> > > > > > > > while.
> > > > > > >
> > > > > > > Not wait, record. Generate 1st command, after userspace consumed it -
> > > > > > > generate and send second command and so on.
> > > > > >
> > > > > > Right, that's what I asked in another thread, we still need a timeout
> > > > > > here.
> > > > >
> > > > > we do not need a timeout.
> > > > >
> > > > > > Then I think it would not be too much difference whether it is
> > > > > > VDUSE or CVQ that will fail or break the device. Conceptually, VDUSE
> > > > > > can only advertise NEEDS_RESET since it's a device implementation.
> > > > > > VDUSE can not simply break the device as it requires synchronization
> > > > > > which is not easy.
> > > > > >
> > > > > > > But for each bit of data, at most one command has to be sent,
> > > > > > > we do not care if guest tweaked rx mode 3 times, we only care about
> > > > > > > the latest state.
> > > > > >
> > > > > > Yes, but I want to know what's best when VDUSE meets userspace timeout.
> > > > > >
> > > > > > Thanks
> > > > >
> > > > >
> > > > > userspace should manage its own timeouts.
> > > > >
> > > >
> > > > Can we just apply the patch 2/2 of this RFC directly and apply the
> > > > VDUSE CVQ on top then? What are we missing to do it?
> > > >
> > >
> > > Even better, can we just revert commit 56e71885b0349 ("vduse:
> > > Temporarily fail if control queue feature requested") ?
> >
> > No because both would let userspace hang kernels merely by
> > not consuming buffers.
> >
> 
> My understanding was that you want to be able to debug qemu with gdb
> from that hang [1].
> 
> Could you put an example of the whole chain of events you expect? From
> the moment the driver sends a VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command,
> the VDUSE CVQ Forwards the command to the VDUSE device in the
> userspace, and then the vduse userland device does not reply.

this is not the idea.

the idea is that kernel handles VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET.

separately it notifies userspace that some configuration
changed and userspace gets the new value.
Or not, if it is stuck.




> How does the VDUSE CVQ detect that the VDUSE device implemented in
> userland does not reply? What are the next steps from that point of
> the kernel VDUSE module?
> 
> Thanks!
> 
> [1] https://lore.kernel.org/lkml/20251014042459-mutt-send-email-mst@kernel.org/






