Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6931AC430
	for <virtualization@lists.linux.dev>; Thu, 12 Sep 2024 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726148952; cv=none; b=l9NZJ3NssquP/KobLoa2ZS9i3EfBUDgE0yESL2V9vEaM24YTJbs7aKowdfN555MPINJuDid1TNdbWTJtUHmDd2c2m4HsgVCZQhh5/dnHUYFxKWe419WfTnVF9CMzkj+OR77qGkxmz1AZWyoIxkrjAXyaJRy4khumPGfQHKWN454=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726148952; c=relaxed/simple;
	bh=BeCToDaYapaX3Saa/es3zn7QE7cn2Hm7x6pEwmgVvYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mc9UJ+jS2ODcMzBWwpd4EA5TkR5Wlc0aAPDIxNJ4ZtapC6u3cBtIGJ+vefhJIN3ZFAXUFkbKbVdVzWV7ARO/ef8F4q3JCUyrplN1knkp9+d8/aAM4vGG+WLq8SiNRy/LipADqjIVHItHQIvFQYjjDE3PFDk9UMpuTVKs4ykGMr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MKAmuCof; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MKAmuCof"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71781f42f75so752006b3a.1
        for <virtualization@lists.linux.dev>; Thu, 12 Sep 2024 06:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726148950; x=1726753750; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fUQa4s1nfS6Ak/vMXpFFTKhTCLVYkjsgEZVj84spgpI=;
        b=MKAmuCofJT2hvEFwdwTDsYyTycn074vWnw0rzxed9i+vINlsMMN4rB1XYcwdMyr0HS
         OAypec62CIzoXBssJve2Niz2GHdWigG9ueDZ4Mh9vfx0Qh8kvy9jTesJsA/pjKvCWZus
         kbd2KuWUVmW2aJaqLQOyH5hE/SmGeGK249uy7h76fULNBvOvAz6ZbDtUtYHYT+dUkIFe
         Mh/IWeX7AzRnVdHEi/+HilTYClcL9YiRCnisUVrsWz3W85ArH6uHPpdN7IWF0AMTUP6K
         99cwcJWVfAABvBHNNOBHhxgVJb4Pz6nvgKLSyzUoM/NPSrcfRkWikJLYFKP6v11oZ+KL
         E0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726148950; x=1726753750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUQa4s1nfS6Ak/vMXpFFTKhTCLVYkjsgEZVj84spgpI=;
        b=g1dT22J49u0nWpG+wHa/Ybd5sxJXfTcJzXr17oMZt1noJi9FLSYO31F4ru7lh2F6b5
         s/JfyrTKeCv4L453arKbH90M7D5vssF/D6NSBjiSm1zpb760eMLKixcUtoKXR3G6d7QX
         874IWHFdP2wDCJBo2+TsTj6r8IRwv2GxjqJsXOpENDbCh2EhX6yKjKl17HxGg8YH8n6D
         8DY7PA1UOTNPphQdFxcvWsdZu+t77nYVKbNJ8hiauGUtZTJg7VzpCpNOEoO0Io6Ck8PR
         WTt8e3av7tL28S7zpVSdLTM2aJNiXz89yvVTkAlPkreVg/1a3XGfsaGhBiRGtwa1/O17
         odxw==
X-Forwarded-Encrypted: i=1; AJvYcCU9xTcnPnFha9nS9uEjnL2m+MGi6URec9aIfYxR3NzTECxIAEBf0mNM7TW1iiYVxnnQ9s/V71+1XaZwGY6q9g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrnIJjSgaffSYAB4MPkNFs96+QDd7LNZzIhzaNgpywmTubKYH0
	eszwe7r90fbT82of2e6cCQrjbE7OI/3Vj1s2FwjsY9Dfdm+M2mEJs78GX3u4E25CVup1m4O+4iv
	SpP+sqZfnqmWTEqxTZz7xYbNOrvaxoAX5vHSM
X-Google-Smtp-Source: AGHT+IEPr3PK6becA5u/81rvfWVTB62iUowBdbi297hZYuVMK8UYMPCjcecQcbIV27iiqIRftGBxFzb0qMGGSrE5SgY=
X-Received: by 2002:a05:6a21:b8a:b0:1cf:5c1d:83e2 with SMTP id
 adf61e73a8af0-1cf7624b290mr4425750637.39.1726148949520; Thu, 12 Sep 2024
 06:49:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <000000000000e2058e0621e7a637@google.com> <20240912070121-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240912070121-mutt-send-email-mst@kernel.org>
From: Marco Elver <elver@google.com>
Date: Thu, 12 Sep 2024 15:48:32 +0200
Message-ID: <CANpmjNN+3TwdxkvnFzzeQNOVXq-smqpi+xtkw0j+Pd-BGkrgFw@mail.gmail.com>
Subject: Re: [syzbot] [virt?] KCSAN: data-race in virtqueue_disable_cb /
 vring_interrupt (4)
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: syzbot <syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com>, 
	eperezma@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Sept 2024 at 13:03, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Sep 12, 2024 at 01:11:21AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    7c6a3a65ace7 minmax: reduce min/max macro expansion in ato..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1608e49f980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=1e7d02549be622b2
> > dashboard link: https://syzkaller.appspot.com/bug?extid=8a02104389c2e0ef5049
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/a1f7496fa21f/disk-7c6a3a65.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/f423739e51a9/vmlinux-7c6a3a65.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/b65a0f38cbd7/bzImage-7c6a3a65.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KCSAN: data-race in virtqueue_disable_cb / vring_interrupt
> >
> > write to 0xffff88810285ef52 of 1 bytes by interrupt on cpu 0:
> >  vring_interrupt+0x12b/0x180 drivers/virtio/virtio_ring.c:2591
>
>
> Yes, it's racy!
>
> 2589:        /* Just a hint for performance: so it's ok that this can be racy! */
> 2590:        if (vq->event)
> 2591:            vq->event_triggered = true;
>
>
> Question: is there a way to annotate code to tell syzbot it's ok?

In this case, "if (data_race(vq->event))" might be the right choice.

This is a quick guide on which access primitive to use in concurrent
code: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt

Thanks,
-- Marco
