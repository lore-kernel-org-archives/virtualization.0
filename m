Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4752C08BD
	for <virtualization@lists.linux.dev>; Mon,  2 Feb 2026 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770050722; cv=none; b=i8gfyOTeJzgxNm7UVCjrugFoyTK5+8K6EOwcTs+OfXi2MhONQuAqARBszo+7QVrXQAnKvJig0+6VvZo0TejGDz2IyLmUeWejYXxo3dI7QySe8/1GnfwvClNixxkIBBkFfG75Iiaw2UWVfoScL7w0BBEEwQuvrR7t0+N0WR44pys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770050722; c=relaxed/simple;
	bh=lkML6C8/WI/y0YcNHGPg1vTCJcq1BxkxXOZpicvA2+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=T7RQJsJ1ewi+XOZRynpywkIxVfVvOMVvXtPxKDxVIuhjsH/YbGGOK/rFN09TL3MjvwknP1Q3lxGTXjw2NMKem4pO2QgET/5Npl+az2RgkessSvnV2CsyHQ7oIh+gFzuBGI+nOacrL/BVuwnMz9PSc+rc1Rkl6lAIzLOen05RB9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QrpEmD6x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QrpEmD6x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770050720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1MaLyDAEXIM+1K7joqwk/7F2Jjy8XHWKQlNGyxT7zGc=;
	b=QrpEmD6xnBiViuo+mPtx3ktk9RyUVxWZE2721efjU0AyuPbZpF/izPj1MZC+dM3XyADzb2
	WbF9yTMYOyfGGx20QmdNtdUZt25nGHeUqK4iozKUqMGAqOvPGuZ0yJ4kl5NZpqaVFNCD0K
	w4FrBdh7zwmKIs8QIwpP/yxQ7+ltsAo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-mT7G8JHdMw-F86hPhAqbYQ-1; Mon, 02 Feb 2026 11:45:19 -0500
X-MC-Unique: mT7G8JHdMw-F86hPhAqbYQ-1
X-Mimecast-MFC-AGG-ID: mT7G8JHdMw-F86hPhAqbYQ_1770050718
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47ee1fe7b24so46309175e9.1
        for <virtualization@lists.linux.dev>; Mon, 02 Feb 2026 08:45:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770050718; x=1770655518;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1MaLyDAEXIM+1K7joqwk/7F2Jjy8XHWKQlNGyxT7zGc=;
        b=KHbrguwz3hYG+l0kDd28PBk0WxcsuD7fP/ZnCNpYkRAHXtcf6Md1Y6l8J4QkyHHMFM
         7rHpY9Jk0S+PIyHIT28zYwIfYcizybIuX5cVcRPWi6H1aA1hyyfovItU2rt2nAcVmEXi
         ej2htcarlqEHca5vP8yfEeHmiZtWjMtjG/O9Ieohg0h0LU1OayA0oVxZv0eQSFPkmPLk
         NuA9GLv1HzMr0sbR3e5epXsoGOTFK6iiVlch0ptc7tZ+nHtKFqLJgorSk/UvDPInrAwx
         SXvMcXjJwvdUkazdEYErcBCb6sqLNW+ufTVaC9J9070AIos8lDKwV7by0fuIGPvyYuER
         EnwA==
X-Forwarded-Encrypted: i=1; AJvYcCWU/Gl/+oV8VIABH/3tMiXnNjNmm+EgR5ufaroktI4oZ/z6xRKx4Mpjg7QJMoNBlOXs/W0f29w7cyN/DkhCrA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHzWfsjVACfnP7W+G8UpOquG15929RpXgm912E4aqMW96iDrLQ
	HEsNtkePtPRypCke3VGGqfeJP7G/MW33H9vJfEyDVCr6sp752m5+4/5WRx/pzkApp49kp2C4mTn
	uH8MEhxY+OE9WJO/S5VKefkTkYmj7zz18+tp2b+f3Z6LIjjr679lKskz91bxdIqgupVJt
X-Gm-Gg: AZuq6aJHJr9BMMZIiAGtP+bBlvU+nBr87A81606pUI0C2CzFo01NxV3eivWXFr+ty4k
	z4v1H6B2KR5oL3pGEWsGY6t5wU+eSwBoJWQO3CgUoSRzW5OHtXQU/8U8kPjcwK2+iUWiu9Z08Ne
	l3L5A4tnFoo5kMtH5QTyD8Sd/5Va06eg75d8SaJEC4kkLzl02HMbaNu29cM40feS/BC88R/44gc
	DajYUVcpKnB7zDyRzswEZKzN2C3YyqX0/e53CJ3xWHHhUqrwvG5mugjSS6CgLVE5ls/cit1O7WI
	qqf8fXp6PTr/OeeEfjAiik1BP3SoaNTulHRGZdE2i6nBmORVmftLBB6aMNxZN+GSMDd7TCyFNao
	usNR1/g==
X-Received: by 2002:a05:600d:8449:b0:482:ef72:5778 with SMTP id 5b1f17b1804b1-482ef7258admr74875155e9.8.1770050717803;
        Mon, 02 Feb 2026 08:45:17 -0800 (PST)
X-Received: by 2002:a05:600d:8449:b0:482:ef72:5778 with SMTP id 5b1f17b1804b1-482ef7258admr74874785e9.8.1770050717367;
        Mon, 02 Feb 2026 08:45:17 -0800 (PST)
Received: from redhat.com ([2a06:c701:73e3:8f00:866c:5eeb:fc46:7674])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483051247ebsm1055045e9.4.2026.02.02.08.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 08:45:16 -0800 (PST)
Date: Mon, 2 Feb 2026 11:45:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Arnd Bergmann <arnd@kernel.org>, Jason Wang <jasowang@redhat.com>,
	Xie Yongji <xieyongji@bytedance.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Anders Roxell <anders.roxell@linaro.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] vduse: fix compat handling for
 VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO
Message-ID: <20260202114412-mutt-send-email-mst@kernel.org>
References: <20260202095940.1358613-1-arnd@kernel.org>
 <20260202095940.1358613-2-arnd@kernel.org>
 <CAJaqyWeJs4u6G46gEg=-G6o3u6LsgzVC03fTGR=O_qd_HujLuw@mail.gmail.com>
 <30db98bd-8361-46f5-aec1-ffbc4e8574dd@app.fastmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <30db98bd-8361-46f5-aec1-ffbc4e8574dd@app.fastmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TnnK6QKGhWV4OQAtLOReNM4pMlAFlOSY4GVKhjIzI28_1770050718
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Feb 02, 2026 at 12:59:03PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 2, 2026, at 12:34, Eugenio Perez Martin wrote:
> > On Mon, Feb 2, 2026 at 11:07 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >>
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> These two ioctls are incompatible on 32-bit x86 userspace, because
> >> the data structures are shorter than they are on 64-bit.
> >>
> >> Add compad handling to the regular ioctl handler to just handle
> >> them the same way and ignore the extra padding. This could be
> >> done in a separate .compat_ioctl handler, but the main one already
> >> handles two versions of VDUSE_IOTLB_GET_FD, so adding a third one
> >> fits in rather well.
> >>
> >
> > I'm just learning about the COMPAT_ stuff but does this mean the
> > userland app need to call a different ioctl depending if it is
> > compiled for 32 bits or 64 bits? I guess it is not the case, but how
> > is that handled?
> 
> In a definition like
> 
> #define VDUSE_IOTLB_GET_FD      _IOWR(VDUSE_BASE, 0x10, struct vduse_iotlb_entry)
> 
> The resulting integer value encodes sizeof(struct vduse_iotlb_entry)
> in some of the bits. Since x86-32 and x86-64 have different
> sizes for this particular structure, the command codes are
> different for the same macro. The recommendation from 
> Documentation/driver-api/ioctl.rst is to use structures with
> a consistent layout across all architectures to avoid that.
> 
> The normal way to handle this once it has gone wrong is to split
> out the actual handler into a function that takes the kernel
> structure, and a .compat_ioctl() handler that copies the
> 32-bit structure to the stack in the correct format.
> 
> Since the v1 structures here are /almost/ compatible aside from
> the padding at the end, my patch here takes a shortcut and does
> not add a custom .compat_ioctl handler but instead changes
> the native version on x86-64 to deal with both layouts.
> This does mean that the kernel driver now also accepts the
> 64-bit layout coming from compat tasks, and the compat layout
> coming from 64-bit tasks.
> 
> Nothing in userspace changes, as it still just uses the existing
> VDUSE_IOTLB_GET_FD macro, and the kernel continues to handle
> the native layout as before.
> 
>     Arnd

I think .compat_ioctl would be cleaner frankly. Just look at
all the ifdefery. And who knows what broken-ness userspace
comes up with with this approach. Better use the standard approach.

