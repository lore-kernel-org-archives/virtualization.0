Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B597C30C37D
	for <virtualization@lists.linux.dev>; Fri, 17 Oct 2025 06:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760683195; cv=none; b=Jnt+dl/sfPRwvIgM5YqK43D8iao85vOllZI4tl60RXYOwg9+bJMRMgA/7qoJIn3b3mP+OjRVJC6x1dDBVSJMfADAxZjj471TelIteHadTcA5rx/T4oUdbiohps6rdZ3WMke4avxJHL9yC7tY97QWIW/juYJiDZ8o+HfXpUnEbLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760683195; c=relaxed/simple;
	bh=Pn3WT3/4aiAA30c4v5Ydi8TjC3mE2LrU/lEAxBvDbV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ax+XUsVfERuL9cptOHcnMELeKXJCwUoV44JpJXJMxGx+tZ61TujacX5SYd1HF6lqHRvl+RiPVhlGXLVK6FqvZUdTr213cvCWg0TpBioHB/WJolXEoS9WEJM+xuZ9WX25BXQ9ANVc+ZRBKh+zJ+KmOiLVn3Ntb1/E2rhm8o+AfgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VDGJxOeH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDGJxOeH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760683192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OP6nyCW4vbGz2cR/HFIO6nyw2IF1OiFQ2HFBH7E+uck=;
	b=VDGJxOeHCf8HuqlV2JwRRxGqmfdwpMA6YJWq+mOhTs8/EruEc7gLJjHPb1DqLMlU4kzk9O
	Jlxaat/S74yJbtFZA3o5NRAZXWESJEObtGPUQ0AIgV1ZLAMEJSJ3vRe5A6dXx8kdSzaJRw
	mFv1jq7KIgbAKTRr/IU0X0N3qn0lApw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-1qKrSm6bPReCrAzYukI7BQ-1; Fri, 17 Oct 2025 02:39:51 -0400
X-MC-Unique: 1qKrSm6bPReCrAzYukI7BQ-1
X-Mimecast-MFC-AGG-ID: 1qKrSm6bPReCrAzYukI7BQ_1760683190
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-427015f63faso870773f8f.0
        for <virtualization@lists.linux.dev>; Thu, 16 Oct 2025 23:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760683190; x=1761287990;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OP6nyCW4vbGz2cR/HFIO6nyw2IF1OiFQ2HFBH7E+uck=;
        b=f7GWQ/xez3CQyGEMARqxoVQWeRq/qWoUftwoE95sY4Mk612IT6sPdTj+eyJ1hkHdfZ
         +YXKKRuSr00z0u5xSIgCDCurSHhe6HpKY4U2D3WiVAzPz7jx8xKY6rG5sN+JxWKjMm12
         4diWsHatheEja6x64tipLizZDrIKyYEA5Kcmt0IMxE6vClHiCc0o0rCtC2vuGDPTufit
         R/IM1/45ETWi7PyuZLCqUxDvBAhZOTESjDnnF1G5M5lELjB7veC+kKHC/ET40Yd4lHM2
         /7eGxPDk7sDB+AZ10XJ5dPqE4VOZl6aqVaiVyIvkBrQEF5mekx+e131fxJUOZA7cY+le
         1nFA==
X-Forwarded-Encrypted: i=1; AJvYcCW9nxnir718N+2oIYXssmuaBxBHdCmqLw6ok95Z1oe3tGJJ2NMeBoDVGWn+OPdiLwsWKubOcjiQOhYq0iJvtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxcBzlivHcfaiBS3oLO5W4KOdytERReSh5hkh3pLi2rkIIjgfpg
	UMe16o6Z1A1iNKy+HlghZelmVoZ0E8dhiFN+cbnP+4ioHLVLVcnMYEQRlmaHf2pv7Ft+9IQ49Iq
	NEvTHauWAlEr1CsUdrvp6iGkhJiIM4oGXYGFkGqXvGsWOZyszwQbsROITwqKJUuBX2MR8
X-Gm-Gg: ASbGncu05f9R5ikZUXobithH0guNpicNfHuVLHXa9uGgseI6CvqQbNsqCo1ZtvcwKKO
	UqG3t7OWys/JMmCEM7y9gS57ei9onbyBig334Dup2RBMx13yLrKTDB+sUrtaMwoivH9uiFmTHTR
	75XnEnJrc5sURdRRyLsyM/Rxkt7qkPuJXGnUXJU7MIOxYFRsnCzEJHGsvvWqOK4hbAc8T+5LVuh
	BaYfL4ohtfWT01XG/TggCNFFI+k69xyN0nF02C6VsrlPnahm+r74FsdghIIfeQRVbmZg+NSnIws
	v9SkXZWIKgBU3hGjkdy8B6UahHOJ1idGww0XNwuGTN5mmtnwi39K/7/WRtjo3OVhq1Pv
X-Received: by 2002:a05:6000:2307:b0:425:8125:b108 with SMTP id ffacd0b85a97d-42704dab10dmr1532915f8f.54.1760683189896;
        Thu, 16 Oct 2025 23:39:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5cW70B3eIdfICP2gCPXaPXJ1502nVp3SeROnq1YEmxbNhFAFUlFjWKhikGvYfYspBeGPjFw==
X-Received: by 2002:a05:6000:2307:b0:425:8125:b108 with SMTP id ffacd0b85a97d-42704dab10dmr1532899f8f.54.1760683189324;
        Thu, 16 Oct 2025 23:39:49 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426f2f72e18sm17687729f8f.0.2025.10.16.23.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 23:39:48 -0700 (PDT)
Date: Fri, 17 Oct 2025 02:39:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251017023902-mutt-send-email-mst@kernel.org>
References: <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org>
 <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <CACGkMEuPPFLH1YqTx03fV9N=Rx3aYXK0HMUDpZu-CvO1NYRRQA@mail.gmail.com>
 <20251016014328-mutt-send-email-mst@kernel.org>
 <CACGkMEtXWLicmszjkzOhX8Ta=LdGgsDahRUKDEVzBVG8am5vgg@mail.gmail.com>
 <20251016022131-mutt-send-email-mst@kernel.org>
 <CAJaqyWe--Hho9EdweqkC-h9=t5vhY0cbAN9uAw=hATpkSMbsEg@mail.gmail.com>
 <CAJaqyWdEY6KaVbBn5LJhkz7h6kytFg8-b8iXnc9N54L+q_Yrbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWdEY6KaVbBn5LJhkz7h6kytFg8-b8iXnc9N54L+q_Yrbw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u7JXoLGg99YhDpHeQZbldjCG_BfddzC-ne_IUWnjpu0_1760683190
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Oct 17, 2025 at 08:36:41AM +0200, Eugenio Perez Martin wrote:
> On Thu, Oct 16, 2025 at 8:25 AM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Thu, Oct 16, 2025 at 8:22 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, Oct 16, 2025 at 02:03:57PM +0800, Jason Wang wrote:
> > > > On Thu, Oct 16, 2025 at 1:45 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Thu, Oct 16, 2025 at 01:39:58PM +0800, Jason Wang wrote:
> > > > > > > >
> > > > > > > > Not exactly bufferize, record.  E.g. we do not need to send
> > > > > > > > 100 messages to enable/disable promisc mode - together they
> > > > > > > > have no effect.
> > > > > >
> > > > > > Note that there's a case that multiple commands need to be sent, e.g
> > > > > > set rx mode. And assuming not all the commands are the best effort,
> > > > > > kernel VDUSE still needs to wait for the usersapce at least for a
> > > > > > while.
> > > > >
> > > > > Not wait, record. Generate 1st command, after userspace consumed it -
> > > > > generate and send second command and so on.
> > > >
> > > > Right, that's what I asked in another thread, we still need a timeout
> > > > here.
> > >
> > > we do not need a timeout.
> > >
> > > > Then I think it would not be too much difference whether it is
> > > > VDUSE or CVQ that will fail or break the device. Conceptually, VDUSE
> > > > can only advertise NEEDS_RESET since it's a device implementation.
> > > > VDUSE can not simply break the device as it requires synchronization
> > > > which is not easy.
> > > >
> > > > > But for each bit of data, at most one command has to be sent,
> > > > > we do not care if guest tweaked rx mode 3 times, we only care about
> > > > > the latest state.
> > > >
> > > > Yes, but I want to know what's best when VDUSE meets userspace timeout.
> > > >
> > > > Thanks
> > >
> > >
> > > userspace should manage its own timeouts.
> > >
> >
> > Can we just apply the patch 2/2 of this RFC directly and apply the
> > VDUSE CVQ on top then? What are we missing to do it?
> >
> 
> Even better, can we just revert commit 56e71885b0349 ("vduse:
> Temporarily fail if control queue feature requested") ?

No because both would let userspace hang kernels merely by
not consuming buffers.

-- 
MST

