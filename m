Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666E717C77
	for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 07:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710918065; cv=none; b=PkcMQg+teQhMdJ2oYwOA87e2K1JYxpqB0A/JPUMq3yETGFfEZTaBWeoCqTYPmnyugrQSW+FnLtIQs4tbmpjl2iMurWy2WNvWz7FsDGQmJrD6+RDbF7xoWWdVXg4yY5ZPiezHK+6kNIpsvCOkthLPnMqJjjrIpukJoP2Jf9Jh3TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710918065; c=relaxed/simple;
	bh=iVnWDyLoCu/Ja18Cqpr2TJjMQPI6MXMyjdDnShXMSMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rCAfTSSx7E0sD4YSVQRrU0lEaQnuImZAGLLbbLxbIlYkEIZ0ad75hA+Ptuifien8aNudBYlNNBj+Asr6ITzdgshHp1CDW/Kf7Tcn81qE2VC3IOC7/cdEcikSvc5CzTCFCMUdXA9pg/7gFOgwLxmfFjVsUpMnjrgftEXtERl5EXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R1DJ1CLH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1DJ1CLH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710918062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V257dS6Z2PYkKho2PENsqVgatRXFhhPv3P6c78DC5xE=;
	b=R1DJ1CLHrDj0XMAlU2R0HUP7mHFQXY0D9UgPEQP5fxTX2KWyXcGiBqa5O8p/xfZdiOccbS
	BsnNpEBIpG3bDLAqrPOlDmYZti3jVre/dgtlDKr59FhP/PwyG5++CK12w9VKhAFQL3EM15
	5R3FnTkRPBVxza144ZjPtMp+tO7OlPw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-EsBFaGJlOOOLxObHnNt3fw-1; Wed, 20 Mar 2024 03:01:00 -0400
X-MC-Unique: EsBFaGJlOOOLxObHnNt3fw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d496045d19so33978031fa.0
        for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 00:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710918058; x=1711522858;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V257dS6Z2PYkKho2PENsqVgatRXFhhPv3P6c78DC5xE=;
        b=AHBrNgNOx1pEKXIl+6z4kTFvZurdd6FNQI1Q8rimq3vC5xNCooDYZ0rf12HkDF8N+y
         8ljw2n31thQRYzxkLsQYZtAJPWeVry8eCmVreOmooDd+hkdsMXLb2h5tVqQLT/fy1ylj
         +pT6WwMOuycsuSjTAnzhuaclebApUwc5nzCgZn2r9sRgn1ctRDg8r3e8mKiKH0uY1nNW
         49ZCO/Q7O8S2adoIXIHw3jOxbMGGGpzs0QLRTm7bxviNP8rS1yvxzCfPcUDtBoBmVvzT
         k4qgGWcwhEoPZrfuG+U5vGveOkXnwy8ih4fHRgxoyYT24up3FlMxxPkXc82FWSi7vhUh
         kAgA==
X-Forwarded-Encrypted: i=1; AJvYcCVFz1xVTo/GJvpYCCbWEGE1yO01rjOhyBVZ1pLy4QkhxnxsYx5UP79JLFo/iBR24aX4akXdf9KCmfY/LqcmuaYXD+KsZ1lQmgF/xOS0dw8=
X-Gm-Message-State: AOJu0Ywx8xYgSQ1JcV3FvcBnNgvmWcwpJPSrKFhRwGXfbqHApGskMmCb
	GY2LgZabQ2+UUc99GayWYZJkbywMgHbhXxHIp0UUy77TIEm+UOJ1+z0f/FU9Hnm716X5glzoWrv
	VoCaOjrffvpGeXty/Oud7ow48ywDnVkvRRn7R1wlcUYMhumjo6mu6y6M5DbNvlDxp
X-Received: by 2002:a05:651c:10c9:b0:2d2:2ce1:1196 with SMTP id l9-20020a05651c10c900b002d22ce11196mr11148012ljn.53.1710918058269;
        Wed, 20 Mar 2024 00:00:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyG1sHjM8WeULtjQwKQYRWNEHzgwgIsWFQFSOvrQMAE12wThknYfdpbGCuyrdjyKAQrsu61A==
X-Received: by 2002:a05:651c:10c9:b0:2d2:2ce1:1196 with SMTP id l9-20020a05651c10c900b002d22ce11196mr11147967ljn.53.1710918057334;
        Wed, 20 Mar 2024 00:00:57 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id u8-20020a056000038800b0033ec9007bacsm9759522wrf.20.2024.03.20.00.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 00:00:56 -0700 (PDT)
Date: Wed, 20 Mar 2024 03:00:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Zhu Lingshan <lingshan.zhu@intel.com>, virtualization@lists.linux.dev
Subject: Re: [PATCH 00/10] vDPA: allow userspace query virito-block device
Message-ID: <20240320025513-mutt-send-email-mst@kernel.org>
References: <20240218185606.13509-1-lingshan.zhu@intel.com>
 <20240319023840-mutt-send-email-mst@kernel.org>
 <CACGkMEundY+cxPPvRLS06b1CK94jGL4poCd0tcj2wfSAzTVGFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEundY+cxPPvRLS06b1CK94jGL4poCd0tcj2wfSAzTVGFg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Mar 20, 2024 at 11:30:57AM +0800, Jason Wang wrote:
> On Tue, Mar 19, 2024 at 2:40 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Feb 19, 2024 at 02:55:56AM +0800, Zhu Lingshan wrote:
> > > This series allows the user space applications query vDPA virtio-block
> > > device inforamtion.
> > >
> > > testing on vdpa_sim_blk, iproute2 output:
> > > sudo ./vdpa/vdpa dev config show -jp vdpa_blk0
> > > {
> > >     "config": {
> > >         "vdpa_blk0": {
> > >             "capacity": 262144,
> > >             "segment size": 4096,
> > >             "block size": 512,
> > >             "max segments in a request": 32,
> > >             "num of queues": 1,
> > >             "logical blocks per physical block (log2)": 0,
> > >             "offset of first aligned logical block": 0,
> > >             "minimum io size": 1,
> > >             "optimal io size": 1,
> > >             "maximum discard sectors for a segment": 4294967295,
> > >             "max discard segments in a command": 1,
> > >             "discard sector alignment": 512,
> > >             "max write zeros sectors in a segment": 4294967295,
> > >             "max write zero segments": 1,
> > >             "read only": false,
> > >             "flush command support": true
> > >         }
> > >     }
> > > }
> > >
> > > Please help review
> > >
> > > Thanks
> > > Zhu Lingshan
> >
> > It's been in my tree for a while so it will be in the next pull,
> > but going forward Jason I'd like to know what kind of
> > timeline do you have in mind for reviewing vdpa patches?
> 
> I think there are some misunderstandings here.
> 
> I usually try my best to offer a review.
> 
> This series was posted during my vacation, and when I came back after
> the vacation it was merged into your tree. I'd expect you are fine
> with the patches.

Yes.

> If that doesn't work, maybe we can start to do something like:
> 
> vDPA patches needs my ack before it can be merged
> 
> Does it work?
> 
> Thanks

We have redundancy in review, it's not a problem by itself.
If you are going on an extended vacation, it's a good idea
to make this fact public so people know whether to expect your review.

> >
> > > Zhu Lingshan (10):
> > >   vDPA: report virtio-block capacity to user space
> > >   vDPA: report virtio-block max segment size to user space
> > >   vDPA: report virtio-block block-size to user space
> > >   vDPA: report virtio-block max segments in a request to user space
> > >   vDPA: report virtio-block MQ info to user space
> > >   vDPA: report virtio-block topology info to user space
> > >   vDPA: report virtio-block discarding configuration to user space
> > >   vDPA: report virtio-block write zeroes configuration to user space
> > >   vDPA: report virtio-block read-only info to user space
> > >   vDPA: report virtio-blk flush info to user space
> > >
> > >  drivers/vdpa/vdpa.c       | 212 ++++++++++++++++++++++++++++++++++++++
> > >  include/linux/vdpa.h      |   1 +
> > >  include/uapi/linux/vdpa.h |  17 +++
> > >  3 files changed, 230 insertions(+)
> > >
> > > --
> > > 2.39.3
> >

