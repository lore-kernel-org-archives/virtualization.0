Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19831A58D
	for <virtualization@lists.linux.dev>; Sun,  9 Nov 2025 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762724828; cv=none; b=Pon8CoMEJIPo3W8uRjuvSiFnAKb+OdHnvNhnkACZDU+CaT6ka55Jai+w/8ybeQ13UHIiLqy5HNUIMUVisQj7NCNO7IFQ8sy+FafADXK/2X8LWxERgf1dfyQQ15Ig2yjki42I6JhQDieC99xY8wkkeBS6oV9v7HZ95dWAblog6L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762724828; c=relaxed/simple;
	bh=8bHPJqkcpiWZiLm7GJ4WrZrYa8pHR79dKB5UTVQ/U6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JFJgGBO0Z7xT6xAB05GaY7Yco4fp5pAJPshiSKjcWuDKf1gnFb1U+Z+QXX+YOvF4ln8ABXji9o6990rggyuXgCMFHo1TL2wHWCxEKX5DlH0lu3CLfu6XmPDvkUeJnuPdmj702kDdgqNLCjni8j1Qcc5g2BhCZU3IqUShCiLaNYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ckBQtCeM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ckBQtCeM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762724825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MpPgJNNfQcmsOxPYyH1pXdl4WpjxS9YLpOkwsCYYikE=;
	b=ckBQtCeM51vSRBgoTQSMgfSHFQfJEyJwy2IHOs3O8HDHursMhyt8C9B9GJCuSS3kGLcjJ+
	7OL5iQjTjBe4I4rzEx7xLhWHmrZUgEO333xlpeocyxeyu2bGa21hbPFsnTgREP2LkgtksL
	oTJN/S2DZJY6z67jB5xUtoKgozUzCFY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-qXX86PAqOm-BuEFfWFjtaA-1; Sun, 09 Nov 2025 16:47:02 -0500
X-MC-Unique: qXX86PAqOm-BuEFfWFjtaA-1
X-Mimecast-MFC-AGG-ID: qXX86PAqOm-BuEFfWFjtaA_1762724821
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b2f79759bso1008503f8f.2
        for <virtualization@lists.linux.dev>; Sun, 09 Nov 2025 13:47:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762724821; x=1763329621;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpPgJNNfQcmsOxPYyH1pXdl4WpjxS9YLpOkwsCYYikE=;
        b=PdBoGLTu6xhPT1hzEB8EjfiDRazKqWcVGN2ElH2rBFzY2gM7LciHWRc8QEZSA8ALs4
         EgEPLru7FkjD1rV8X2G5qnjJBH3zJMReuYu6OoiRsXoBcb50iLsHDgxEZDXu6rKrTfnY
         50xmfISBwGa5IkL32L2w/bpiaLj4KFQmXXrxoi3gkPD74tttvKNDHBdwgQPPWSnXonMg
         rWOJqywk+sG4D2LckFZyZhTacEZH5gigHGtVhFpX9duqnHJM2Z0XL42vVSFWJ8O05+ea
         cRgR7DycnxbusIlS4ZEfFQLXBYIdgRlHheH7N6N/VAL5arX6XyaJyJyFarnS3UeO609o
         JN3g==
X-Forwarded-Encrypted: i=1; AJvYcCW+OUIg4coH+P6cuu4c/nLtXt7C2I7jTCZAKDGbdCROMAj9Clk1ZXR17s1vyICYENpmtJZ9mXWraIUg0kwtUA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0B4+BNqYCEB1Dlggze2mPU2pzxqgCRUbeVFmQnYJfDyo/HBoT
	QE6ZecfawNGe67L4EvrtwvDSjcyhuq61l/Mkk9jV+Lw9fmdqvihd/YXqB1BqA7l10Rdu8wiZuhG
	Lumdnm+wAvlnTgHXHfoEah7I1QpJMZCgEMt+VLBKLv4pFVq8shEJizWn1R23j3IDncMK3
X-Gm-Gg: ASbGncvMYnp4Gk+nS4666ybVRr5gV8AYyS6tW9SwH+o+kXIRg+IQNPZduoQT9hTs8ul
	i1lqiO2YVOiDRly2/+M8RRJwV8YWa2+30K/dR+hfyVdL/FurLm4KhCj/5P7c1X4Y7b99ZBjuRLT
	j8tuW+uOAQz8cdChJLs5+Gu7bBDeY+N4fLqhCRRXewDUEOcWLeHGzUd1zK6Q+7pIL4ShbpHhMHa
	yri55T0LJMtZ/pA/UKKjnS+aVKPCmqT4jp9Krcj/DMKHwKH5IxrxPJBIv9ain2mkMujBBYlcTY+
	dgc8Kvg2N7Rer7F4ChZOK0OERfX56rxTkbOgHaybZxC6qlsm/KneEFBZV+urfBv7Yp0=
X-Received: by 2002:a5d:5d0e:0:b0:429:f051:84bf with SMTP id ffacd0b85a97d-42b2dc16b22mr4397035f8f.6.1762724820763;
        Sun, 09 Nov 2025 13:47:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGChrGnO/pUJIQy+0U7o2SKTCKjvG5QquXtb6ys9S/qAwgWsCeTMU6fAYrQrooQfJU9X4rYyw==
X-Received: by 2002:a5d:5d0e:0:b0:429:f051:84bf with SMTP id ffacd0b85a97d-42b2dc16b22mr4397025f8f.6.1762724820326;
        Sun, 09 Nov 2025 13:47:00 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bfa0sm19252079f8f.5.2025.11.09.13.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 13:46:59 -0800 (PST)
Date: Sun, 9 Nov 2025 16:46:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251109164528-mutt-send-email-mst@kernel.org>
References: <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <20251022060748-mutt-send-email-mst@kernel.org>
 <CAJaqyWdRN3C1nOHQjWroBPWKjc5efNfVbecpruL=Cgsk6i1FXg@mail.gmail.com>
 <20251022073231-mutt-send-email-mst@kernel.org>
 <CAJaqyWeDcyKKOvVdqUkpTuH3d-Tb9rBHG3ym+LC0fcmhrN_FJA@mail.gmail.com>
 <20251028100923-mutt-send-email-mst@kernel.org>
 <CAJaqyWePMtM8vtgm8UnGAv+_XNTnVNFSNuoqzt_Cn-CpZg46mA@mail.gmail.com>
 <20251028104154-mutt-send-email-mst@kernel.org>
 <CAJaqyWc=Fhp2+m8P6cctkqG+oeXUgiGhKAsR5Ns20JMun=wvbQ@mail.gmail.com>
 <CAJaqyWf1Sn7CE+VOptZprDgniRNo=8-ZzmcS5YMOeW=tP4nfBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWf1Sn7CE+VOptZprDgniRNo=8-ZzmcS5YMOeW=tP4nfBQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4VZNaUrnZAul6f7QwLm2I8ozfFbMJuwLB264emvuzfw_1762724821
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Nov 05, 2025 at 10:02:48AM +0100, Eugenio Perez Martin wrote:
> On Tue, Oct 28, 2025 at 3:57 PM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Tue, Oct 28, 2025 at 3:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Oct 28, 2025 at 03:37:09PM +0100, Eugenio Perez Martin wrote:
> > > > On Tue, Oct 28, 2025 at 3:10 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Wed, Oct 22, 2025 at 02:55:18PM +0200, Eugenio Perez Martin wrote:
> > > > > > On Wed, Oct 22, 2025 at 1:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > >
> > > > > > > On Wed, Oct 22, 2025 at 12:50:53PM +0200, Eugenio Perez Martin wrote:
> > > > > > > > Let me switch to MQ as I think it illustrates the point better.
> > > > > > > >
> > > > > > > > IIUC the workflow:
> > > > > > > > a) virtio-net sends MQ_VQ_PAIRS_SET 2 to the device
> > > > > > > > b) VDUSE CVQ sends ok to the virtio-net driver
> > > > > > > > c) VDUSE CVQ sends the command to the VDUSE device
> > > > > > > > d) Now the virtio-net driver sends virtio-net sends MQ_VQ_PAIRS_SET 1
> > > > > > > > e) VDUSE CVQ sends ok to the virtio-net driver
> > > > > > > >
> > > > > > > > The device didn't process the MQ_VQ_PAIRS_SET 1 command at this point,
> > > > > > > > so it potentially uses the second rx queue. But, by the standard:
> > > > > > > >
> > > > > > > > The device MUST NOT queue packets on receive queues greater than
> > > > > > > > virtqueue_pairs once it has placed the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
> > > > > > > > command in a used buffer.
> > > > > > > >
> > > > > > > > So the driver does not expect rx buffers on that queue at all. From
> > > > > > > > the driver's POV, the device is invalid, and it could mark it as
> > > > > > > > broken.
> > > > > > >
> > > > > > > ok intresting. Note that if userspace processes vqs it should process
> > > > > > > cvq too. I don't know what to do in this case yet, I'm going on
> > > > > > > vacation, let me ponder this a bit.
> > > > > > >
> > > > > >
> > > > > > Sure.
> > > > >
> > > > > So let me ask you this, how are you going to handle device reset?
> > > > > Same issue, it seems to me.
> > > > >
> > > >
> > > > Well my proposal is to mark it as broken so it needs to be reset
> > > > manually.
> > >
> > >
> > > Heh but guest assumes after reset device does not poke at guest
> > > memory, and will free up and reuse that memory.
> > > If userspace still pokes at it -> plus plus ungood.
> > >
> >
> > I don't get this part. Once the device is reset, the device should not
> > poke at guest memory (unless it is malicious or similar). Why would it
> > do it?
> 
> Friendly ping.



OK I thought about it a bunch. A lot of net drivers actually
just queue ethtool commands and finish them asynchronously.
Thinkably virtio could expose an API on whether it is safe to
wait for buffers to be used. virtio-net would then either
send commands directly or do the asynchronous thing.
Hmm?


-- 
MST

