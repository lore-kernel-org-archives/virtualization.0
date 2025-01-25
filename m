Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60EB28E37
	for <virtualization@lists.linux.dev>; Sat, 25 Jan 2025 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737820653; cv=none; b=ESONox4/7KYOqCSKy5tWdlmmwHH6+LugDNLkQ2Kq10UnUICicF3EN9SCl3DpkSROHwIS0HLwafYCT7SAON/7xbTTQCwqEqhHvsn15hq8tNwk8VOnt8ABFzcpmLjmLB36QoMQlQpgw+ohGJ3HpGsoTWVZkkk5ucPCEJhjljqp/AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737820653; c=relaxed/simple;
	bh=/Zpjy5u9s282dqlcyNcBjv3a2sOTSP38Gg7wKXyAaLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0EiZfKl9fFP9iES3zFFErKHmqcdLyjxhhDB+4NpC9AY+irz/OTmEdfOATzUoZ+3/BPcA9nAPAIS4X2+vZSxJnoNlAuPgPZSnOTHhcoouGdkXv8kpE9eTAqvtomts3RtW5LOv1oZOsWpDKwTE2qo4fPAXiDMB5bQohu83t2YfZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=virtualopensystems.com; spf=none smtp.mailfrom=virtualopensystems.com; dkim=pass (2048-bit key) header.d=virtualopensystems-com.20230601.gappssmtp.com header.i=@virtualopensystems-com.20230601.gappssmtp.com header.b=dEuBouae; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=virtualopensystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=virtualopensystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtualopensystems-com.20230601.gappssmtp.com header.i=@virtualopensystems-com.20230601.gappssmtp.com header.b="dEuBouae"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso493271866b.3
        for <virtualization@lists.linux.dev>; Sat, 25 Jan 2025 07:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=virtualopensystems-com.20230601.gappssmtp.com; s=20230601; t=1737820649; x=1738425449; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PLMLtZK87EZSnbC21LohK4S0aY7cewELelChDtt+Bk=;
        b=dEuBouaevFypp9b0nXSQIu/11lY+m9iXrGaQkvzbG2y0H4qwqzEI9sZdNlc6p9DtIz
         mrGfH1IYXcffqKFH8qvxN0CCo/tOFaM+UwdO8nkObUfT0cGtSE+W176Mgrh2jIfbjCRx
         2OMXb0ZMs0jkoeDlDvsm0Uzc4ZtJUKK3DrveKpIu92XnOGWsmnKLOFy0I6eUpsqN/AF5
         lKEd28iI0Fe1YkzaR+1Gd/dH5BqGAFyPtoHhb0Y96XD3GUmYtlsbOaVk5ftHTjLJY1VC
         i/iv/gX3DNfeQJBLTsc3D3oyXYAIbrpfe+d6R+5GkjNZCLFIBmslgh8EriIYGdNAekog
         zPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737820649; x=1738425449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PLMLtZK87EZSnbC21LohK4S0aY7cewELelChDtt+Bk=;
        b=TXuTD+/h2EG7BYhRJMykW4zkF88XiJwp21w06t0f4eyiW6WmB5Ne3WKQf8YHpJ5yGu
         nDsMVDl916V6SZyJxC87uAx/Phc93+XCWvodpdF/YntMYQTpYGEl2hfXiRLHEs570vyX
         AjfaS5Qd/cutXz07jsD6AX98rTkQhMnjIWisAgIIHpuRJggnMJaWaNqaWtkT/SfqRQnt
         2z+EbW4WvegN9q4HL3ulpz5618jWEdmJ1MKPRzN69ZLIGNlR4LLRJ54f0c1/I9yNe7Cd
         wblbCRSYit6xggaNpqCyj2x5X0gVo1zCLVmG0C1RxX5k6mLYrtvMFIKvcYbZeWEoHA+l
         hGjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD6HhEWJLgkT2kymmTZ3YbJoqyDo5pGJ7DOUOfW6JUQ0t/JQAxpMJcdAUA7mOvBSdf1ynAeeoekI7XFYlFEw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/+l//IMJDLSRQEPbS1Gyc60uPlIJagCNUnpL1C8WAgX992HA2
	vI5AIsCqyxuG76QFi3cr2cobfkHnuRYSKT3Og39KVLyxHFIrYgPqJAP49+SNXuE=
X-Gm-Gg: ASbGncse/FjkmdtvYvDxlww3s8JFHNLQAylCa9H03mFB2pJnrY1QBnPYL1PM+j2d3L+
	78PASOd69wHCcDIypSAt6BVOCXf/iyyRPPmGb9LBbEHzFCIP4jJj7D64el4sJOieG6aYcJ11g8m
	vKZoKhd76nYPzwZhKMvxaG+MKUS1hZkQJe9RIC6YAlQ+y+tu0lzxYsHy7Og2O+2+eub9bgQxgHk
	0l6G9Fvu83lxzDexli98JE+liT/a65uUxyzgzoy0vfr2eWkdCvn66JJ/OaT7JwcebodpH3yYkXz
	K4Jn1YmDPNH058SDAFl9CO51PPy5QC4=
X-Google-Smtp-Source: AGHT+IGak5gjPzMDUE+SC4/1d72QwMPUb/q5oPBi0ZeKGYu8Gitp+AGY2N/LlSjM4v2J36yZkiAwig==
X-Received: by 2002:a17:906:d54f:b0:aa6:1e9a:e45a with SMTP id a640c23a62f3a-ab38b3893c1mr2885637966b.46.1737820649032;
        Sat, 25 Jan 2025 07:57:29 -0800 (PST)
Received: from ritos-ThinkPad.. ([45.66.41.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab693c63541sm54481066b.67.2025.01.25.07.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 07:57:28 -0800 (PST)
From: t.ampelikiotis@virtualopensystems.com
To: jasowang@redhat.com
Cc: virtio-dev@lists.oasis-open.org,
	anna@virtualopensystems.com,
	a.rigo@virtualopensystems.com,
	m.paolino@virtualopensystems.com,
	s.raho@virtualopensystems.com,
	chou.kensou@jp.panasonic.com,
	wminer@linuxfoundation.org,
	jsmoeller@linuxfoundation.org,
	virtualization@lists.linux.dev,
	stefanha@redhat.com,
	xuanzhuo@linux.alibaba.com,
	sgarzare@redhat.com
Subject: Re: [virtio-dev] [RFC PATCH 0/1] Virtio-loopback: a virtio based HAL for non-virtualized environments
Date: Sat, 25 Jan 2025 17:57:25 +0200
Message-Id: <20250125155725.120284-1-t.ampelikiotis@virtualopensystems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CACGkMEug=QgyAEwKZfzn76O0A+_cQTt_JBpLhTfryNYzR-gc3g@mail.gmail.com>
References: <CACGkMEug=QgyAEwKZfzn76O0A+_cQTt_JBpLhTfryNYzR-gc3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Dec 23, 2024 at 5:59 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Fri, Dec 20, 2024 at 11:49 PM Timos Ampelikiotis
> <t.ampelikiotis@virtualopensystems.com> wrote:
> >
> >
> >
> > On Thu, Dec 5, 2024 at 10:17 AM Jason Wang <jasowang@redhat.com> wrote:
> >>
> >> Adding Eugenio and YongJi.
> >>
> >> On Wed, Dec 4, 2024 at 11:38 PM <t.ampelikiotis@virtualopensystems.com> wrote:
> >> >
> >> > From: Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
> >> >
> >> > We would like to share with you an RFC for the Virtio-loopback
> >> > technology which we have been working on at Virtual Open Systems in
> >> > the context of the Automotive Grade Linux community (Software defined
> >> > Vehicles expert group)
> >> >
> >> > We previously presented this activity (see [1]) and now we come back
> >> > to you with latest development and updates.
> >> >
> >> > We believe that the technology is more mature today and we would like
> >> > to assess the community interest in the technology itself and in
> >> > merging the code.
> >> >
> >> > Below we provide a brief description of the technology, recent
> >> > updates and a short comparison with vDUSE that might be seen as a
> >> > similar technology.
> >> >
> >> > 1. Overview:
> >> > -------
> >> >
> >> > Virtio-loopback is a hardware abstraction layer (HAL) designed for
> >> > non-virtualized environments based on virtio. The main objective is
> >> > to enable applications communication with vhost-user devices in a
> >> > non-virtualized environment.
> >> >
> >> > More in details, Virtio-loopback architecture consists of a new
> >> > transport (Virtio-loopback), a user-space application (Adapter) and
> >> > the vhost-user devices.
> >> >
> >> > The data path has been implemented using the "zero-copy" principle,
> >>
> >> This need more clarification, for example, how could we prevent
> >> malicious usersapce device from modifying kernel pages etc. Especially
> >> consider not all buffer occupy full pages.
> >>
> >> Actually, after chatting with Yong Ji, I've played with a zerocopy POC
> >> for VDUSE, but it tries to do zerocopy only for page aligned buffer:
> >>
> >> https://github.com/jasowang/net/tree/vduse-zerocopy
> >>
> >> The idea is to map the page directly to the userspace if the buffer
> >> occupies a full page and usersapce is expected to recycle the page via
> >> MADV_DONTNEED. It's far from mature but it can demonstrate the idea
> >> somehow.
> >
> >
> > I had a quick look into the POC and it seems like it improves
> > performance (by reducing the copies) without compromising the security.
>
> Note that it has something left: e.g what if userspace doesn't
> "recycle" pages via MADV_DONTNEED etc.
>
> >
> > In general, it is similar to what we propose (though we focused on
> > performance mainly). A brief introduction of how data are shared with
> > the vhost-user devices without copies follows:
> >
> > In virtio-loopback, a page handler is assigned to the kernel memory
> > when a vhost-user device tries to mmap a new memory region. Any time
> > then the vhost-user device tries to actually access a page inside
> > that memory region, a page-fault is generated and the driver decides
> > which is the corresponding page to be inserted to the vhost-user
> > process.
>
> Note that the page fault is really expensive, that's in my POC I
> hacked the VDUSE to map the pages to avoid #PF. But it needs a concept
> like "owner" so VDUSE can grab the mm_struct of the owner process to
> do that.
>
> > Before sharing the page, we have intentionally left some
> > space for security checks to be implemented in the future.
> > At that point we can check if the page requested is related to the
> > corresponding device and if not then do not share it with the user-space.
> >
> > As correctly said, that solution does not address the case of buffers
> > being smaller than a page, and indeed, there is the chance for malicious
> > applications to take advantage of the data padding the page after the buffer.
> >
> > Solving that issue would lead us to the solution you shared above. More
> > specifically creating a bouncing buffer approach for those cases. I didn't
> > have the chance to benchmark the above POC yet, but I believe that it should
> > introduce a performance advantage over the upstream vDUSE solution.
>
> I had some tests through qsd. I can get at most 40% improvement when
> I'm using 128K write etc.
>
> But when I was doing POC with OVS-DPDK, I didn't get good performance
> as it involved too much madvise() per packet. I'm trying to seek a
> good way to reduce the call to madvise.
>
> >
> > I understand that security is a very important point here.
> > So my first objectives for the virtio-loopback future development
> > would be first to address all the security concerns about the
> > technology.
> >
> > Before that, I would like to assess your interest in the technology
> > and understand:
> > a) if the community would be interested to merge a new virtio-transport
> >   which does something similar with vDUSE but does not depend on vDPA?
>
> If there's an advantage of bypassing vDPA, I would like to know. Since
> I'm seeking a way to accelerate VDUSE with zerocopy and the work was
> kind of duplicated.

Performance wise, it might not introduce any additional benefit but since
it is a simpler, more lightweight architecture with less components and
dependencies might be also interesting to co-exist with vduse for serving
as virtio HAL for non-virtualization environments.

>
> > b) if it would be interesting to make the adapter compatible with vDUSE
> >   in order to add support for more devices in the current vDUSE
> >   implementation?
>
> That would be welcomed.

Nice! I look forward to see the vduse-agent when it is available.
In the meantime feel free to have a look into the virtio-loopback
adapter (user-space counterpart) available here:

https://gerrit.automotivelinux.org/gerrit/gitweb?p=src/virtio/virtio-loopback-adapter.git;a=commit;h=269f019fde391bffdfbd42dee45c0cc8721e8f4f

Thanks,
Timos
