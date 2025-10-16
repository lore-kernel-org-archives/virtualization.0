Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43029238150
	for <virtualization@lists.linux.dev>; Thu, 16 Oct 2025 05:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760593220; cv=none; b=dm6NzUrIysXLUSgWFpCgJMVlURsoYFDOQiNNVstrZAkMua3/u43KqXkq4BaFnnnCgt/xaW4m0xur2xLTURSKwjSTPy8mUq3zjwK4o61ZVbvX77YzgcCXhTeWgNQ2K4MGPYmGNVrt9vrQGazhBUuS+EkQcF7qISPlLx92OFrNiik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760593220; c=relaxed/simple;
	bh=VJ18jYE5xew5E/InDn9pRFTleRlYAEGcA/L27q4XDwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=htFj84xg1UyhUZaxSEzECoPm9ULESKvlnWcXJc/L/LiYfV5n0dpYrBiHK59sftHrEyf+vPC8R0jlVOuTGEfpsu9JOLctFrDZ2PFFBY5RtUo+4ZlWPrSAyB7KtgBbscaF5mlwdNhPPp4PUg/DagBMUhMfF/xXOJWRSxk/tN0AgfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kfg1cVEf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kfg1cVEf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760593217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2xXUa4RGBuxd3fWczbR2kcbubK6oCnYESbCnCoYcuJ0=;
	b=Kfg1cVEf9+L4sixXoCMjA022eKd8Yenezsjwyn/ZKmxvSzJAMC4yvEC98bn7xNG3j8zz8H
	aMuRAYrMVXrDmli/wdrAFHk9c81PP8Hh4KnoWsaofT4uwjoL4IwIF1vQxLiXxSpfKFlIQT
	DLzw5gkVf/KHqfDQowbOoCMwWo4wBt0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-fOVjnoZ6MpSO1mpEXvQsnw-1; Thu, 16 Oct 2025 01:40:12 -0400
X-MC-Unique: fOVjnoZ6MpSO1mpEXvQsnw-1
X-Mimecast-MFC-AGG-ID: fOVjnoZ6MpSO1mpEXvQsnw_1760593211
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32eb864fe90so709870a91.3
        for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 22:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760593211; x=1761198011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xXUa4RGBuxd3fWczbR2kcbubK6oCnYESbCnCoYcuJ0=;
        b=PCJmKWnAAbURNw/AUqvRwefHhSpaFcojnQKDZB++bmrvss5uBmwz6hcny5nVHwdo5g
         P0dqf8XTXNLDaVzwW4p2tC7X8SG2Iv6LteKNri6r0H5mq2OoMPevWL6sjKHYdsid1Wlx
         /W1yvRBPp7KslQ7cB95NARQATgyYNGGY4PgWn6fqybulOUW/6HjOo0B8yDmpKWcuGa2b
         FD0I6Uvx7WLzq1u6Oa3/0NC0BfiyggcyZdeV2eoygtHpPX8JwzySj9A+1f/bSLYkUKwp
         1+OT3RPPpR8isPoSIHte9+QCZA55Wut746dnIh3OSGmgkY93nREceuqBs7cJXxr7jTQx
         XTHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjka7MbiVBO/WN1k81B58/FlIFcuQz8fTk4/iIjwsNCq/P+BBpON5ut7dEiW9uBANNAjcZrLC34lWZu5ZHzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVkDA95oGmMBKih5tYmppD69yUcXN/vf+iSiWsFKc2cnrzYcVk
	BINOwBGGQTmQNGQsI/5/pqoupFBJem0sALL50uSc9zvFMmwkRWVNGeaZxZ7iatI+S8aGCz6AZ71
	x4M6JOV7FWiYSRBI05oaHMCdVxn6tixEpi25xyunHJAeE3olvneeqqIi7oQOE++TVttFfzVQSv8
	llsrq3raHt00KwQxFqEMHXaxIrf2qkrvN6k0BHUH5hhGs=
X-Gm-Gg: ASbGncuBAuiWYTjSvqA76RYtN4ROr7F5DXcnODxulcRXvKFV+t7d6ywnktteC2nicBw
	fOFo9n0CG3oqD4yvJ2pk6ABvaBjlxIN+9iB1AXhwK5SSSVa8lm6Pkr5U488wfQD5iRD8F8DDiKI
	LPyIpYJ3BU8QBDSw+jxff8VGnHtSglmCkSjRH3y7d7bUONsy4WeDbd
X-Received: by 2002:a17:90a:c888:b0:33b:8ac4:1ac4 with SMTP id 98e67ed59e1d1-33b8ac44075mr12915383a91.35.1760593211329;
        Wed, 15 Oct 2025 22:40:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRYzegVqy0jyI6NeS7hc9ixsnNrrMqwU4r45wmEfDwuD1xAFZjQulb0t4fxG2gZ2tlvuAAKbh02fzbnhD60UU=
X-Received: by 2002:a17:90a:c888:b0:33b:8ac4:1ac4 with SMTP id
 98e67ed59e1d1-33b8ac44075mr12915355a91.35.1760593210867; Wed, 15 Oct 2025
 22:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251007130622.144762-2-eperezma@redhat.com> <20251014042459-mutt-send-email-mst@kernel.org>
 <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>
 <20251014051537-mutt-send-email-mst@kernel.org> <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>
 <20251015023020-mutt-send-email-mst@kernel.org> <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org> <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org> <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
In-Reply-To: <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 16 Oct 2025 13:39:58 +0800
X-Gm-Features: AS18NWBDR9JTU4s-rwneNQV4mlVYwhLu3NYx2QjzFIN7LRuTsRKCocHVC5Xab6c
Message-ID: <CACGkMEuPPFLH1YqTx03fV9N=Rx3aYXK0HMUDpZu-CvO1NYRRQA@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea DE <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: togU8OOttzkS8MssPtRnY5Gp4dGpz2yFBnvyNo2B6d4_1760593211
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 6:37=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Oct 15, 2025 at 10:09=E2=80=AFAM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> >
> > On Wed, Oct 15, 2025 at 10:03:49AM +0200, Maxime Coquelin wrote:
> > > On Wed, Oct 15, 2025 at 9:45=E2=80=AFAM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Wed, Oct 15, 2025 at 9:05=E2=80=AFAM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Wed, Oct 15, 2025 at 08:52:50AM +0200, Eugenio Perez Martin wr=
ote:
> > > > > > On Wed, Oct 15, 2025 at 8:33=E2=80=AFAM Michael S. Tsirkin <mst=
@redhat.com> wrote:
> > > > > > >
> > > > > > > On Wed, Oct 15, 2025 at 08:08:31AM +0200, Eugenio Perez Marti=
n wrote:
> > > > > > > > On Tue, Oct 14, 2025 at 11:25=E2=80=AFAM Michael S. Tsirkin=
 <mst@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Oct 14, 2025 at 11:14:40AM +0200, Maxime Coquelin=
 wrote:
> > > > > > > > > > On Tue, Oct 14, 2025 at 10:29=E2=80=AFAM Michael S. Tsi=
rkin <mst@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio P=
=C3=A9rez wrote:
> > > > > > > > > > > > An userland device implemented through VDUSE could =
take rtnl forever if
> > > > > > > > > > > > the virtio-net driver is running on top of virtio_v=
dpa.  Let's break the
> > > > > > > > > > > > device if it does not return the buffer in a longer=
-than-assumible
> > > > > > > > > > > > timeout.
> > > > > > > > > > >
> > > > > > > > > > > So now I can't debug qemu with gdb because guest dies=
 :(
> > > > > > > > > > > Let's not break valid use-cases please.
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Instead, solve it in vduse, probably by handling cvq =
within
> > > > > > > > > > > kernel.
> > > > > > > > > >
> > > > > > > > > > Would a shadow control virtqueue implementation in the =
VDUSE driver work?
> > > > > > > > > > It would ack systematically messages sent by the Virtio=
-net driver,
> > > > > > > > > > and so assume the userspace application will Ack them.
> > > > > > > > > >
> > > > > > > > > > When the userspace application handles the message, if =
the handling fails,
> > > > > > > > > > it somehow marks the device as broken?
> > > > > > > > > >
> > > > > > > > > > Thanks,
> > > > > > > > > > Maxime
> > > > > > > > >
> > > > > > > > > Yes but it's a bit more convoluted  than just acking them=
.
> > > > > > > > > Once you use the buffer you can get another one and so on
> > > > > > > > > with no limit.
> > > > > > > > > One fix is to actually maintain device state in the
> > > > > > > > > kernel, update it, and then notify userspace.
> > > > > > > > >
> > > > > > > >
> > > > > > > > I thought of implementing this approach at first, but it ha=
s two drawbacks.
> > > > > > > >
> > > > > > > > The first one: it's racy. Let's say the driver updates the =
MAC filter,
> > > > > > > > VDUSE timeout occurs, the guest receives the fail, and then=
 the device
> > > > > > > > replies with an OK. There is no way for the device or VDUSE=
 to update
> > > > > > > > the driver.
> > > > > > >
> > > > > > > There's no timeout. Kernel can guarantee executing all reques=
ts.
> > > > > > >
> > > > > >
> > > > > > I don't follow this. How should the VDUSE kernel module act if =
the
> > > > > > VDUSE userland device does not use the CVQ buffer then?
> > > > >
> > > > > First I am not sure a VQ is the best interface for talking to use=
rspace.
> > > > > But assuming yes - just avoid sending more data, send it later af=
ter
> > > > > userspace used the buffer.
> > > > >
> > > >
> > > > Let me take a step back, I think I didn't describe the scenario wel=
l enough.
> > > >
> > > > We have a VDUSE device, and then the same host is interacting with =
the
> > > > device through the virtio_net driver over virtio_vdpa.
> > > >
> > > > Then, the virtio_net driver sends a control command though its CVQ,=
 so
> > > > it *takes the RTNL*. That command reaches the VDUSE CVQ.
> > > >
> > > > It does not matter if the VDUSE device in the userland processes th=
e
> > > > commands through a CVQ, reading the vduse character device, or anot=
her
> > > > system. The question is: what to do if the VDUSE device does not
> > > > process that command in a timely manner? Should we just let the RTN=
L
> > > > be taken forever?
> > > >
> > >
> > > My understanding is that:
> > > 1. Virtio-net sends a control messages, waits for reply
> > > 2. VDUSE driver dequeues it, adds it to the SCVQ, replies OK to the C=
VQ
> > > 3. Userspace application dequeues the message from the SCVQ
> > >  a. If handling is successful it replies OK
> > >  b. If handling fails, replies ERROR
>
> If that's the case, everything would be ok now. In both cases, the
> RTNL is held only by that time. The problem is when the VDUSE device
> userland does not reply.
>
> > > 4. VDUSE driver reads the reply
> > >  a. if OK, do nothing
> > >  b. if ERROR, mark the device as broken?
> > >
> > > This is simplified as it does not take into account SCVQ overflow if
> > > the application is stuck.
> > > If IIUC, Michael suggests to only enqueue a single message at the tim=
e
> > > in the SVQ,
> > > and bufferize the pending messages in the VDUSE driver.
>
> But the RTNL keeps being held in all that process, isn't it?
>
> >
> > Not exactly bufferize, record.  E.g. we do not need to send
> > 100 messages to enable/disable promisc mode - together they
> > have no effect.

Note that there's a case that multiple commands need to be sent, e.g
set rx mode. And assuming not all the commands are the best effort,
kernel VDUSE still needs to wait for the usersapce at least for a
while.

> >
>
> I still don't follow how that unlocks the RTNL. Let me put some workflows=
:
>
> 1) MAC_TABLE_SET, what can we do if:
> The driver sets a set of MAC addresses, (A, B, C). VDUSE device does
> send this set to the VDUSE userland device, as we don't have more
> information. Now, the driver sends a new table with addresses (A, B,
> D), but the device still didn't reply to the VDUSE driver.
>
> VDUSE should track that the new state is (A, B, D), and then wait for
> the previous request to be replied by the device? What should we
> report to the driver? If we wait for the device to reply, we're in the
> same situation regarding the RTNL.
>
> Now we receive a new state (A, B, E). We haven't sent the (A, B, D),
> so it is good to just replace the (A, B, D) with that. and send it
> when (A, B, C) is completed with either success or failure.
>
> 2) VQ_PAIRS_SET
>
> The driver starts with 1 vq pair. Now the driver sets 3 vq pairs, and
> the VDUSE CVQ forwards the command. The driver still thinks that it is
> using 1 vq pair. I can store that the driver request was 3, and it is
> still in-flight. Now the timeout occurs, so the VDUSE device returns
> fail to the driver, and the driver frees the vq regions etc. After
> that, the device now replies OK. The memory that was sent as the new
> vqs avail ring and descriptor ring now contains garbage, and it could
> happen that the device start overriding unrelated memory.
>
> Not even VQ_RESET protects against it as there is still a window
> between the CMD set and the VQ reset.

Yes, I think it would be fine if the command is the best effort that
means the state in kernel VDUSE could be out of sync with userspace.
But it would be problematic if the command is not the best effort. And
implementing cvq means a device model is implemented in the kernel
VDUSE which might be a burden. Hardening the cvq might still be a good
idea to go e.g

1) the device might be backed by software that is running in DPU
2) in kernel emulation of cvq might be buggy (e.g mlx5_vdpa and simulator)

Thanks

>

