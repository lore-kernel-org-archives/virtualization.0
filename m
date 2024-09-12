Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B411B9840
	for <virtualization@lists.linux.dev>; Thu, 12 Sep 2024 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152394; cv=none; b=GkGpSBnFVtDzE65O/03j6+ANzmYHAnZ/UXdwtUl4c22a4f3OmFVjio1XpuQGlmltXddZinSNWSPBg3sYGPu6ySwypb/Hkb6PJhW5k2IiPf2/p/2cIEwZkml2XI67xdwGupliMcldatwPa+GVe0Xx5zdSCI1DzP05MCdcI+HZXvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152394; c=relaxed/simple;
	bh=5gT9BRmXCO0TLfrvU31q0lPa6C7WuN7JAaAkfFi/zgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tMzDZpIimAiubHXMauuj8On7ern0XoX3xW6RZDVDmL3OhKkxZ/OTYpkf6OZ1wKH90GeNJa6T6CS2RFhWpI4TAQvfAQUFhlneTvajv7ViqchvJHp3cK5BuhQGLeddJTPX6n5bveZ0GQ7erffS03Bn6ao7tU6WQeKSfdAKCaSFLPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+p7eC/G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+p7eC/G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726152390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RkOgBhHe6/k/nE3HpsJCkCjdlY43j+z3h97RvGxFGJU=;
	b=Z+p7eC/GLuWOMOPszVCA3Q9xEmJqJkeBghSgJg2HQhLrvosHoTK3DGQAlbUbxpgo95EfN9
	4+iCMBHqracoOAeza/fWXnR3EJmkYy+2bFcPUSROgHOnV3luJbK/noLqD19Puc5HJKocGB
	Qf998fPj8BPpY4TitdibGtI2KvijOgE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-vkyzM0VqMb64-C-Y-5NoYg-1; Thu, 12 Sep 2024 10:46:29 -0400
X-MC-Unique: vkyzM0VqMb64-C-Y-5NoYg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb050acc3so5651775e9.1
        for <virtualization@lists.linux.dev>; Thu, 12 Sep 2024 07:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726152388; x=1726757188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkOgBhHe6/k/nE3HpsJCkCjdlY43j+z3h97RvGxFGJU=;
        b=PZRB9ifqjpXBe2TzW0hdNOkbtnT8jNTqdASQaCT7WDpdb0c7NbjYAUK1lGRGfjplSp
         B3K/4UIi0cHPsotUWk9zJKh4vF9zRCo4pqafYHk0QLL4d8ROae1CrfiTE8pxKxmCkvVG
         hz5y2edZThJ7tsI2QW2XTNOOSCMtBrC/l2re0209J8SlKiiStk6pxjVNnkchfjjxfI3A
         saMXv4P0yZbLRpYg4msUgAOBEyxfTFLUIpuCMLPFUuAnMt/tPMxQ/51/hGnSNNWBF4lR
         SBSjwLIOLP8EeS9Vg5hT0sh2Rn2O/NB530dAJ4iR8VUzVAXdeePccMK6v+wgxIOe/JD0
         BAjA==
X-Forwarded-Encrypted: i=1; AJvYcCVtMycVaoLHIURo2xV98TCE60jq3FnbXsP42yNAYhiS6KlO6MPgxRSVkpPt8MKPWcVoVcY86vg45Sa35CUXwg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyOKoiFXKi+9Bg1s5Kg8GkIBN3WrhpFxuNEBGzqddXe7Wp5bxei
	yQsFijHlwVbDKGN3zQmH03slquPmF5LpvVxPqW+4xs9JucmcMEGHdxfMEHqOKLly37CiyBLVo0D
	vi6yeZ40uQNdbG9WLuZD15kRq0UXh80AxB7aKLk6pO00eTkQfQTBo5T6iAhp7pGqlRzN8vgVp
X-Received: by 2002:a05:600c:1c25:b0:42c:ae1d:ea4b with SMTP id 5b1f17b1804b1-42cbde1a51emr63152145e9.13.1726152388046;
        Thu, 12 Sep 2024 07:46:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEakTyhyWFWtQns98wQW2B5kqVZSDJcqennuilUm4CeDOT3jYZwL5+Fyv99b/FC+BW6JyB7/g==
X-Received: by 2002:a05:600c:1c25:b0:42c:ae1d:ea4b with SMTP id 5b1f17b1804b1-42cbde1a51emr63151815e9.13.1726152387097;
        Thu, 12 Sep 2024 07:46:27 -0700 (PDT)
Received: from redhat.com ([2a02:14f:177:45a6:a4e6:75a4:a286:2745])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb21b1bsm176676075e9.2.2024.09.12.07.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 07:46:26 -0700 (PDT)
Date: Thu, 12 Sep 2024 10:46:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marco Elver <elver@google.com>
Cc: syzbot <syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com>,
	eperezma@redhat.com, jasowang@redhat.com,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Subject: Re: [syzbot] [virt?] KCSAN: data-race in virtqueue_disable_cb /
 vring_interrupt (4)
Message-ID: <20240912104553-mutt-send-email-mst@kernel.org>
References: <000000000000e2058e0621e7a637@google.com>
 <20240912070121-mutt-send-email-mst@kernel.org>
 <CANpmjNN+3TwdxkvnFzzeQNOVXq-smqpi+xtkw0j+Pd-BGkrgFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CANpmjNN+3TwdxkvnFzzeQNOVXq-smqpi+xtkw0j+Pd-BGkrgFw@mail.gmail.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 12, 2024 at 03:48:32PM +0200, Marco Elver wrote:
> On Thu, 12 Sept 2024 at 13:03, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Sep 12, 2024 at 01:11:21AM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    7c6a3a65ace7 minmax: reduce min/max macro expansion in ato..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1608e49f980000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=1e7d02549be622b2
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=8a02104389c2e0ef5049
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/a1f7496fa21f/disk-7c6a3a65.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/f423739e51a9/vmlinux-7c6a3a65.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/b65a0f38cbd7/bzImage-7c6a3a65.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com
> > >
> > > ==================================================================
> > > BUG: KCSAN: data-race in virtqueue_disable_cb / vring_interrupt
> > >
> > > write to 0xffff88810285ef52 of 1 bytes by interrupt on cpu 0:
> > >  vring_interrupt+0x12b/0x180 drivers/virtio/virtio_ring.c:2591
> >
> >
> > Yes, it's racy!
> >
> > 2589:        /* Just a hint for performance: so it's ok that this can be racy! */
> > 2590:        if (vq->event)
> > 2591:            vq->event_triggered = true;
> >
> >
> > Question: is there a way to annotate code to tell syzbot it's ok?
> 
> In this case, "if (data_race(vq->event))" might be the right choice.
> 
> This is a quick guide on which access primitive to use in concurrent
> code: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt
> 
> Thanks,
> -- Marco

I sent a patch tagging this whole field as racy. Pls take a look.

-- 
MST

