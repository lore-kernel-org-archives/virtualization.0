Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77BD361DD9
	for <virtualization@lists.linux.dev>; Mon, 25 May 2026 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779700478; cv=none; b=dyhfMQGDfGihYHyr/iJwaJciVDhN9RoPOAr2JRNs9j79+Tg/YAQnIwvjr8dWQQeW+ebARfAendSZyZsurW3FJpHoUJ91HgmME+Wpdhe0svRzJQs2m2PW9DhPtFdckNGyZ+1itnzv50URMEHfJ0VX8MURM7gwuMXNfIDv0z11ngY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779700478; c=relaxed/simple;
	bh=bz6HId41xY9V16r3H/1IHSbtq+kVTBX+AzuUuy8We88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzxL2bjbTYIQFTPPwU4Bzn4Lhc9HCpQ73EIkigINmaWOYWK16Wq+0/SaknPHaWsf/av7Wxc8MflGcSvglsOK60BISdCG+yuLhXxgh3O4AFXudMDkTP3lb5e1UBwIDgj7uNc9zAQ3lHnASX+10MbuWdvf5G+1hFB0KlIc8HNLxqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ID/rHZ4Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ID/rHZ4Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779700473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XCa6LzOtgQIffaGGFzBaXF3Q8bJnjAULK2FkHdc8+UE=;
	b=ID/rHZ4YXC9qwtn2HME1FgQSNjSjft1XaNKa8H/PJoInOonSh0KCEXujyywrs8Dc0FG6Mt
	k/tGd8vTT7R+jjFX/XED+dBtpsORQodO7IoU/cOIC140XTsa8jU0ZHHAvOeL0Y+tFDHg27
	OvkVfl5RLI8s8TO4FA7MM0kFpmlWmj0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-jKMGld5JMSy-IcjQ64BzGA-1; Mon, 25 May 2026 05:14:31 -0400
X-MC-Unique: jKMGld5JMSy-IcjQ64BzGA-1
X-Mimecast-MFC-AGG-ID: jKMGld5JMSy-IcjQ64BzGA_1779700471
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36865d109dcso8699521a91.1
        for <virtualization@lists.linux.dev>; Mon, 25 May 2026 02:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779700470; x=1780305270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCa6LzOtgQIffaGGFzBaXF3Q8bJnjAULK2FkHdc8+UE=;
        b=HV+LsN1IDyiYxgXfORyBPnTB9k93N/+ZHxjVLYOfUoe0zaZswi8BEg68UABIGlxSj6
         7y+tog31HApldqXycUw9XC35sRW1XnBNQGr8MBgX7ybgLfIdWqztGkUzy0vJv69CuRYR
         QpcPzaU6EDLPKtt321435dMSwWqhkZ863oCAEjgAlNWgxcYyUSPtZA5aDJ9NF1lg2m/y
         KD6TkOefTpizYUAUDfnxhbzuUZs0qzUbMUmdXzX/r3eNvPUnY7NKrrFSe6aaJ5gigUnn
         UAoD5mOfUnuRmRiHRxdfLRBCzwZv1xU4//QmSxxjCTkmrbFcMd+/Hy6TZUQ1kjapxknx
         lX5w==
X-Forwarded-Encrypted: i=1; AFNElJ+dIe1eZ8YYMqTbg5x3wWJSopl/oa8PGr4Ng4JW/hDwHbFUjpldLqReX8yObzIx/zN7pq1nsFyL/nxXSscSIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKT2U5a3ajGTMRSSENamM7JqapH5ZsAogMu6R5GdFlkQ1yWYZs
	YMOTu580z2C+IN1ZcvzYxgu9f2rCERCo4vGFxRaz5e6+Ih9srdphY2x8EYbF7eyP2Dft8DHYBTG
	t/rZpO8paFBXsLTnhZF033cA3g6ysqwGdaWgpOZ2hVXPHD4lYjeuyP+ksrOqYRXbZeUS0xvYAJL
	5seHXWNzuGYAssuK065qy/plp6avb/1ACCVlkNqD1N0+0=
X-Gm-Gg: Acq92OGB0f2fv8fVLjxC3UAW/bR0cPsiVqIAA7+GcApvpil7cKl0uE3UkN75OhPU+cZ
	9M27Ok2k9ObKsPq5Dwj3h1NluiqtNgwRpA+3eXvCVbsSGhREQMZ1UKsZPIk0txH1a8KhNEM47qu
	XbmHuUpIYN2B6f05vEZdATUgeOs8KwBMLaOrYZ3r2Jb490WdwNhD4v4iS2zs2x3W/PIn6+822tZ
	2RP
X-Received: by 2002:a17:90b:2585:b0:366:3ac:f730 with SMTP id 98e67ed59e1d1-36a6788e0abmr12403290a91.25.1779700470420;
        Mon, 25 May 2026 02:14:30 -0700 (PDT)
X-Received: by 2002:a17:90b:2585:b0:366:3ac:f730 with SMTP id
 98e67ed59e1d1-36a6788e0abmr12403244a91.25.1779700469810; Mon, 25 May 2026
 02:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <afn0ZdvZWswBuDMm@sgarzare-redhat> <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat> <20260506113554-mutt-send-email-mst@kernel.org>
 <afxVH2So9BbZ3Gta@sgarzare-redhat> <20260507074113-mutt-send-email-mst@kernel.org>
 <afyMCyBvZpzWrLtO@sgarzare-redhat> <20260507163710-mutt-send-email-mst@kernel.org>
 <af2sXvVCBT05XF0D@sgarzare-redhat> <20260508055343-mutt-send-email-mst@kernel.org>
 <af21ZGlANY6UUCKx@sgarzare-redhat> <baf184f6-fefd-45ca-a437-1505533e3c81@gmail.com>
 <96977898-81a0-4c79-a95f-0b288e0572a6@gmail.com>
In-Reply-To: <96977898-81a0-4c79-a95f-0b288e0572a6@gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 25 May 2026 11:14:17 +0200
X-Gm-Features: AVHnY4Lhts8wIDTXHhuzia8dvW2K6_DuNl7PB_LxKTgmjoNxj80dGuhGdtyu2k0
Message-ID: <CAGxU2F5yG1VJ6eeawAtxcgE-uEQugsG00ZrTBmqz6=AF3JyksA@mail.gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	"virtio-comment@lists.linux.dev" <virtio-comment@lists.linux.dev>, Manuel Stoeckl <code@mstoeckl.com>, 
	Alyssa Ross <hi@alyssa.is>, Spectrum Development <devel@spectrum-os.org>, 
	systemd development <systemd-devel@lists.freedesktop.org>, 
	Val Packett <val@invisiblethingslab.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1dLhitpp6UX-yKFmrZa8m7zQq2Ugb0tmWfXJTA4RkAo_1779700471
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 May 2026 at 04:37, Demi Marie Obenour <demiobenour@gmail.com> wrote:
>
> On 5/23/26 17:00, Demi Marie Obenour wrote:
> > On 5/8/26 06:11, Stefano Garzarella wrote:
> >> On Fri, May 08, 2026 at 05:58:06AM -0400, Michael S. Tsirkin wrote:
> >>> On Fri, May 08, 2026 at 11:41:21AM +0200, Stefano Garzarella wrote:
> >>>> On Thu, May 07, 2026 at 06:48:47PM -0400, Michael S. Tsirkin wrote:
> >>>>> On Thu, May 07, 2026 at 02:59:13PM +0200, Stefano Garzarella wrote:
> >>>>>> On Thu, May 07, 2026 at 07:45:10AM -0400, Michael S. Tsirkin wrote:
> >>>>>>> On Thu, May 07, 2026 at 11:09:47AM +0200, Stefano Garzarella wrote:
> >>>>
> >>>> [...]
> >>>>
> >>>>>>>> For now, we're already doing something:
> >>>>>>>> merging the skuffs if they don't have EOM set.
> >>>>>>>
> >>>>>>>
> >>>>>>> Right that's good. You could go further and merge with EOM too
> >>>>>>> if you stick the info about message boundaries somewhere else.
> >>>>>>
> >>>>>> This adds a lot of complexity IMO, but we can try.
> >>>>>>
> >>>>>> Do you have something in mind?
> >>>>>
> >>>>> BER is clearly overkill but here's a POC that claude made for me,
> >>>>> just to give u an idea. It's clearly has a ton of issues,
> >>>>> for example I dislike how GFP_ATOMIC is handled.
> >>>>
> >>>> Okay, I somewhat understand, but clearly this isn't net material
> >>>
> >>> I doubt we have many other options given reverting the regression was
> >>> ruled out.
> >>
> >> As Eric pointed out, we can't revert it.
> >
> > Could there be an option to disable the mitigation in guests, for the
> > situation where the host is trusted?  There are VMMs that implement
> > AF_VSOCK in userspace with a backing AF_UNIX socket.

Here the main problem was an attack to the host from the guest.

Can the application set the max (IIRC 4G) of SO_VM_SOCKETS_BUFFER_SIZE ?

> >
> >>>> so for now
> >>>> I think the best thing to do is to merge the fixup I sent (or something
> >>>> similar):
> >>>> https://lore.kernel.org/netdev/20260508092330.69690-1-sgarzare@redhat.com/
> >>>
> >>> I reviewed that one, problem is it's a spec violation/change that we'll
> >>> have to support forever.
> >>
> >> I have a few points to make on this, but let's discuss them there.
> >>
> >>>
> >>>> This is a major change that should be merged with more caution.
> >>>> Could this have too much of an impact on performance?
> >>>>
> >>>> Thanks,
> >>>> Stefano
> >>>
> >>> It's really a POC, real patch is left as an excersise for the reader
> >>> :).
> >>
> >> eheh, I see, but honestly, this overcomplication scares me. I'll try to
> >> think it over.
> >>
> >>> The correct approach IMHO is to only start using this
> >>> when we wasted a lot of memory on small packets.
> >>>
> >>> For example, if sum(truesize) >= buf size.
> >>>
> >>> then we'll not see a perf impact unless it's already pathological.
> >>
> >> Agree on this, which is similar to what I'm doing in that patch.
> >> Reducing the advertised buf_alloc only in pathological cases (e.g.
> >> overhead > buf_alloc).
> >
> > This isn't enough to prevent data loss due to race conditions.

Yep, we didn't go in that direction.

> >
> > I'm CCing the virtio-comment list and a few others.
> >
> > Right now, any application that needs to send massive amount of
> > data over a vsock is simply broken.  This isn't just theoretical.
> > It's causing real-world problems for users of Waypipe.
> > Waypipe forwards Wayland protocol messages over AF_VSOCK,
> > so it can send a large amount of traffic over the socket.
> > See https://gitlab.freedesktop.org/mstoceckl/waypipe/work_items/165.
> >
> > If one is willing to mutate the ring buffer in-place, or to maintain
> > an auxiliary counter, it's possible to store all messages with bounded
> > (in practice) overhead.  Specifically:
> >
> > - If the first byte of a block of data is nonzero, it's a
> >   variable-length length.  1 byte for messages less than 128 bytes.
> >
> > - If the first byte of a block of data is zero, the subsequent bytes
> >   are a variable-length counter that stores the number of consecutive
> >   zero-byte messages.
> >
> > That adds a lot of complexity, which is very unfortunate for something
> > that needs to be backported to stable kernels.  I also suspect it
> > requires all access to the ring buffer to take a lock rather than
> > being lock-free.  But it's the only approach that I can think of that
> > can work with the current spec.

Yep, we were discussing something like that in this thread, but we are
still working on that.
That said, any help on preparing patches for this would be more than welcome.

> >
> > Could there at least be a normative note stating that drivers and
> > devices should treat each message as consuming 1024 bytes + the size
> > of the message itself, and warning that anything that doesn't is
> > going to be broken in practice?

We would like to fix the issue. This is a transitive situation.

> >
> > I'm CCing Val Packet (of Invisible Things Lab) and Alyssa Ross
> > (of Spectrum) because both of them are working on systems that rely
> > critically on vsock.
>
> Update: I see that patches have been upstreamed (with CC: stable) that
> reset the connection instead of data loss.

Yep, hope that helps the situation. But again, can setting the max
SO_VM_SOCKETS_BUFFER_SIZE helps those applications?

Thanks,
Stefano

