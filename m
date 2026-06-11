Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF92040BCD2
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781187289; cv=none; b=eF27qjgJNqcgSO4sT5qccY/pKUe5DmJP0qe+zG9B14Ull/VR3Jye7c1YjRCr+GOXzCm6KN+pbCv85kbmKcgHbG2DCwmyOBmd6Yz3C+FHgbmW+eQQOV66Giys2ibZwwTCSen8Qcxr5Gs7DNX3YiDJ1U4Misl8Z0DWdDM0YZfc+QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781187289; c=relaxed/simple;
	bh=gfXXJLb0osriWBGidJ0dB7eIOLrIpOF6r/9loXmgON4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=clcIgTXI/CrFBnHvnQEcmmdA7lfhI3ftFfx5gFzExxE64Mpn83s7IoIgquH4POKPAior2UaehunrSe7JdYxYk2BFSD7k8nteIcl2uKUzmXmcvrHjSKclOC7+hDTauqVjE6YpKJBB2x9uxPP3ipiMLctGrfCclFmxtpxhIIAD7SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJuSAbib; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJuSAbib"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781187287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pjyIWLCuQzUyfe06LzkWeX0zKL+6OD4pYbYVEYPIpiU=;
	b=WJuSAbib9atkp/i7SE/RIOK+lYKpFiq53TfS+phXLlUlchfUUOsnCnjgUmVBFRXV/Tc2ec
	kS2eWM4bAwn767EvuMbRxeazpOH/tiGsMmQllsuhxlfa5HjK5toWfp2sip3Hz9JVRWsGd+
	kcxSm3c1e97Xd0iB4asltW9PjwIPHuI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-xvNMc6DkM3iyg7a-8Zju3w-1; Thu, 11 Jun 2026 10:14:41 -0400
X-MC-Unique: xvNMc6DkM3iyg7a-8Zju3w-1
X-Mimecast-MFC-AGG-ID: xvNMc6DkM3iyg7a-8Zju3w_1781187279
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-460153ce644so6046789f8f.0
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 07:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781187279; x=1781792079;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pjyIWLCuQzUyfe06LzkWeX0zKL+6OD4pYbYVEYPIpiU=;
        b=CyRqLvlirtfqKdDLHlUvOQnFVGDTbY0EvT/u2g4e4u4DcA/weMBIx3YfUFDY7HVs1A
         IetI3rAh9Gan/9chqnWukCDjsC4uYBHVtIr9bLbEX3Y7vOf8KcVIm0nYdmlrob1k3qyl
         eSq9MSDyWYubo2dQvXfH9xEFmcf/B6ErM+ILm884rNbxbY7XsINpbWbvlWPbTMPUhefZ
         b+RcGiI7IrtMRhSKRc/HTHbKXZHxUUSITD3OI2yKIK4X8TZck9jckMX/XMnIRMSfEfGA
         3AyEaG9ZnzB6ApgcoLeP9vQnmkZpilGS/7ix80WcQMJDcaErQyYrB0bzQ01Cp9wd2yea
         d2hQ==
X-Forwarded-Encrypted: i=1; AFNElJ+cXtoiGzwVc5gGq4C4tlGF8jiofG1HRM84lZzcbYuhyQzTidJ432i2TH8oemUXC9+Chyf0qCAnQMbE1BN7dQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzo5NRQpIi9kfhKVXjozxcdudyq5TJt+hflz1e5Bf3CHo1uo8pF
	QLn2vtGVb6DVErFoMdOGPNdPmb3QzBYApvGgfT6msQzR0eVcktIqA+u/s9O7d3ukmxOJQyvo+nM
	i5+a0ldSfLV3fyO7CBqu2beTp5uuvxUFGXkaDk748uiacV6r9L+Jg5S0pJ3AP8xHCFhSl
X-Gm-Gg: Acq92OHQYLqbX/q12WBvpzX67KbJEyUCTHVLnurMprkR+O5p0S3DkS3+K9EXYpyLzDx
	FNtSV8UF/W7YLxYHdMjkDz8OgpOR9wum6+4DfWavhyoUEMKU/UvsiIHAsROPawb13wEl638wHJS
	0qWBFtEMtnrD+52wknTNLHy9X+lzU3OpdNo43mxALBLEGSvTRoFCeZEADxkr8iw4uRtr0+nnwHO
	85BOjDb4UDQdekejdYff1w1de6PB0dG21Qdgarak3fHUQ8HFfC0knskLd1+834Ycg/mrPWrhHTb
	QtOawI4sGvMo0gz4AGftjatpbUCQjZ2++VFKT7+z/CASK5WGQqCdZverPkf6l5hL/2x2CVSWcBe
	ZFo2ioMYNE1h1GAWZ/jn6OhLuWisCB7glJteQg+gm4uAlGcwK5Aw4Kw==
X-Received: by 2002:a5d:584a:0:b0:44b:5398:4e85 with SMTP id ffacd0b85a97d-460677a62e8mr4628780f8f.22.1781187279146;
        Thu, 11 Jun 2026 07:14:39 -0700 (PDT)
X-Received: by 2002:a5d:584a:0:b0:44b:5398:4e85 with SMTP id ffacd0b85a97d-460677a62e8mr4628703f8f.22.1781187278514;
        Thu, 11 Jun 2026 07:14:38 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46028a6dce6sm73902362f8f.30.2026.06.11.07.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 07:14:38 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:14:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH 0/2] Fix lock errors in VDUSE suspend feature
Message-ID: <20260611101422-mutt-send-email-mst@kernel.org>
References: <20260611133806.198402-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260611133806.198402-1-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GQ1KwdqX6ttZKk8oZ9HroeASpyJ9-qbRjHOXg1b_a_w_1781187279
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jun 11, 2026 at 03:38:04PM +0200, Eugenio Pérez wrote:
> Fix wrong ordering at taking semaphore after spinlock and convert the spinlock
> take and release into guards, so they are not lost after a return.
> 
> This series goes on top of https://lore.kernel.org/lkml/20260610083452.477759-1-eperezma@redhat.com/
> ---
> It would be great if these can be squashed.


if you want that then just send v4.

> 
> Eugenio Pérez (2):
>   vduse: fix not releasing taken semaphore in vduse_dev_queue_irq_work
>   vduse: not take the device semaphore while holding vq spinlock
> 
>  drivers/vdpa/vdpa_user/vduse_dev.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> --
> 2.54.0

