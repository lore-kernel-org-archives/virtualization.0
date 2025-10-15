Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89197313523
	for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 09:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760519830; cv=none; b=GkUhiGKvIAUDecCxUr4Kzyj7eQ9i8zgiD5nWXIwXLmxZBPNPi9eq0/lIur+2ZuwQTtmOf+StwtqFhhlD7z0lXpBhTHCLboxMRVS6nEwzAkTIXFukQgVwnEcxhabqHJoaSs9RFR3rjBcRFfEJ3P36hJgGqLpE35WNvU/p9M4FbI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760519830; c=relaxed/simple;
	bh=m5kgFTlaBuRjrc0k/OrFvieVbiXcubGTXkHad9E9goA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LevXSUkxBagHH0ql9otzJnqSI4lj+Bny+HdeU+8tiPOlYjUI2pdWNr7pJMkoqsL5NQzS24kQTszIbmlRQcoNrxhtfUsPHIIIoXhpAVdxOfYA3pTcDW7+YZq+tUvkGhrauZxA/kkKj6KxWyj0QAp0Q1clIe2DcPbDyfIrXIFHdwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZLDSH9f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZLDSH9f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760519826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T+W/Ps6mfSHXXLVeKLlZT9gRXrcUqusYciN8Ccn5eqA=;
	b=eZLDSH9fYP3EPNC3T78uW+PXvNYhOfQy57inETbUh9WwzJo2luoXOHCu2ggSEYv+E6NfX1
	/oAE0c/Q96AJnfsClYhwLG3FWtRfokBThJLoStYXzLen6tc/0v7Fhc/+wbnpdFr8MUcLCL
	ZzN6AjYDh4BtUU5mhGXZVtFl8MhIyQE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-W08fd8UEPUOauCwoyDDC9A-1; Wed, 15 Oct 2025 05:17:05 -0400
X-MC-Unique: W08fd8UEPUOauCwoyDDC9A-1
X-Mimecast-MFC-AGG-ID: W08fd8UEPUOauCwoyDDC9A_1760519824
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-57cd230ea26so5072455e87.3
        for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 02:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760519824; x=1761124624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+W/Ps6mfSHXXLVeKLlZT9gRXrcUqusYciN8Ccn5eqA=;
        b=BOSP0vtPVvFV9sGB1HwiDW+9jtkfAPo2zB73oKO+DqI8Fxjg4T0jWKp/5kb3/pGFCw
         NtjCqQ8qXeaQchBIAeOTAYhSiNY/V2gEgU3LD3ZvLAnulPmjMSXy4GltIa25Npt40Tn3
         WQ6ME+vABqH1/T87kvPk/XYv1dNk8knI+WjWskgQd1c8/t99epOMOvrJ5ciPpajHFw01
         dCqoIAL+gdA1MVf2NCKjwcCRRtqLzHTvhohUK1uKYv6qf7REA2bmdZVBdbFl4PSPskDj
         z8rhtOZE7/WeFDsHD3za3cl1Q2SJLFsI6ZBZBTRA7PWQV9RwzvNYK8ALRYbuXnhflRrr
         BdVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU//j78BHpYzmkZ/mjF4BNdOnE1/AT30W30NVxpKfjx2lmG50/cHBNFaBV/eZa/v8NQV3tbP72msRUX1JsgPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyOYP35x798lK/A2cAbUeBOYE6UN5y+85KQgKAc5HqQd4ky+eTc
	8aTHgLt1cJvHThWrG8myK/S8BV7eEfc0bhLbMOQ4oQAhcZzDP3KEWnRKY3raow5p4CisK+AX1cC
	VgKojRpW6nQvQKW2EFUggJMxxSI949yS4iIPhsSUliyTE6dNW6ECBBFpxzoAlrp27pUj2L+M34h
	MMKW+uBhLQ4sZp/ClUc1LxJy+0qMOveLpCxZzEtmarrU8=
X-Gm-Gg: ASbGncttLo7cqyjttQEoC8KAbF2Geb1xI+puHHONapN5PO1i5b+4PO7eubOO/4WeqQl
	LEz+AMGJL0sJQvd21pdfA04fPmrh4r/ulYY904I6HumweBGVYPwrfntgUe2+Swg39p41fGXlSOD
	IDscwFHeia/a3r+BqjPjs=
X-Received: by 2002:a05:6512:1055:b0:590:5995:6dda with SMTP id 2adb3069b0e04-5906d896c12mr8384008e87.7.1760519823886;
        Wed, 15 Oct 2025 02:17:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbS8vCAPQOfj1bJplfzozEkDoKaXrEkumuXh42o7c1yuWxbblUnl807XsvcuyitjDL9J6CWpXvJSUIyQf4oFs=
X-Received: by 2002:a05:6512:1055:b0:590:5995:6dda with SMTP id
 2adb3069b0e04-5906d896c12mr8383998e87.7.1760519823389; Wed, 15 Oct 2025
 02:17:03 -0700 (PDT)
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
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com> <20251015040722-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251015040722-mutt-send-email-mst@kernel.org>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Wed, 15 Oct 2025 11:16:52 +0200
X-Gm-Features: AS18NWB5QyrCzhPwBCIKSs_RFHzvQqPOsnDCLt9kZ_MpPs_Goa5lAAx2J2tvWTc
Message-ID: <CAO55csx=QqqZFB8jEKerVRjwSTKRoLZuGhuCOL3yR6+q0vriDg@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Uu7gq9fsFn2Jv63Hu0VPToN8tLFiYuOS6RP7tYgEGpA_1760519824
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 10:09=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Wed, Oct 15, 2025 at 10:03:49AM +0200, Maxime Coquelin wrote:
> > On Wed, Oct 15, 2025 at 9:45=E2=80=AFAM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Wed, Oct 15, 2025 at 9:05=E2=80=AFAM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Wed, Oct 15, 2025 at 08:52:50AM +0200, Eugenio Perez Martin wrot=
e:
> > > > > On Wed, Oct 15, 2025 at 8:33=E2=80=AFAM Michael S. Tsirkin <mst@r=
edhat.com> wrote:
> > > > > >
> > > > > > On Wed, Oct 15, 2025 at 08:08:31AM +0200, Eugenio Perez Martin =
wrote:
> > > > > > > On Tue, Oct 14, 2025 at 11:25=E2=80=AFAM Michael S. Tsirkin <=
mst@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Oct 14, 2025 at 11:14:40AM +0200, Maxime Coquelin w=
rote:
> > > > > > > > > On Tue, Oct 14, 2025 at 10:29=E2=80=AFAM Michael S. Tsirk=
in <mst@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio P=C3=
=A9rez wrote:
> > > > > > > > > > > An userland device implemented through VDUSE could ta=
ke rtnl forever if
> > > > > > > > > > > the virtio-net driver is running on top of virtio_vdp=
a.  Let's break the
> > > > > > > > > > > device if it does not return the buffer in a longer-t=
han-assumible
> > > > > > > > > > > timeout.
> > > > > > > > > >
> > > > > > > > > > So now I can't debug qemu with gdb because guest dies :=
(
> > > > > > > > > > Let's not break valid use-cases please.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Instead, solve it in vduse, probably by handling cvq wi=
thin
> > > > > > > > > > kernel.
> > > > > > > > >
> > > > > > > > > Would a shadow control virtqueue implementation in the VD=
USE driver work?
> > > > > > > > > It would ack systematically messages sent by the Virtio-n=
et driver,
> > > > > > > > > and so assume the userspace application will Ack them.
> > > > > > > > >
> > > > > > > > > When the userspace application handles the message, if th=
e handling fails,
> > > > > > > > > it somehow marks the device as broken?
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > > Maxime
> > > > > > > >
> > > > > > > > Yes but it's a bit more convoluted  than just acking them.
> > > > > > > > Once you use the buffer you can get another one and so on
> > > > > > > > with no limit.
> > > > > > > > One fix is to actually maintain device state in the
> > > > > > > > kernel, update it, and then notify userspace.
> > > > > > > >
> > > > > > >
> > > > > > > I thought of implementing this approach at first, but it has =
two drawbacks.
> > > > > > >
> > > > > > > The first one: it's racy. Let's say the driver updates the MA=
C filter,
> > > > > > > VDUSE timeout occurs, the guest receives the fail, and then t=
he device
> > > > > > > replies with an OK. There is no way for the device or VDUSE t=
o update
> > > > > > > the driver.
> > > > > >
> > > > > > There's no timeout. Kernel can guarantee executing all requests=
.
> > > > > >
> > > > >
> > > > > I don't follow this. How should the VDUSE kernel module act if th=
e
> > > > > VDUSE userland device does not use the CVQ buffer then?
> > > >
> > > > First I am not sure a VQ is the best interface for talking to users=
pace.
> > > > But assuming yes - just avoid sending more data, send it later afte=
r
> > > > userspace used the buffer.
> > > >
> > >
> > > Let me take a step back, I think I didn't describe the scenario well =
enough.
> > >
> > > We have a VDUSE device, and then the same host is interacting with th=
e
> > > device through the virtio_net driver over virtio_vdpa.
> > >
> > > Then, the virtio_net driver sends a control command though its CVQ, s=
o
> > > it *takes the RTNL*. That command reaches the VDUSE CVQ.
> > >
> > > It does not matter if the VDUSE device in the userland processes the
> > > commands through a CVQ, reading the vduse character device, or anothe=
r
> > > system. The question is: what to do if the VDUSE device does not
> > > process that command in a timely manner? Should we just let the RTNL
> > > be taken forever?
> > >
> >
> > My understanding is that:
> > 1. Virtio-net sends a control messages, waits for reply
> > 2. VDUSE driver dequeues it, adds it to the SCVQ, replies OK to the CVQ
> > 3. Userspace application dequeues the message from the SCVQ
> >  a. If handling is successful it replies OK
> >  b. If handling fails, replies ERROR
> > 4. VDUSE driver reads the reply
> >  a. if OK, do nothing
> >  b. if ERROR, mark the device as broken?
> >
> > This is simplified as it does not take into account SCVQ overflow if
> > the application is stuck.
> > If IIUC, Michael suggests to only enqueue a single message at the time
> > in the SVQ,
> > and bufferize the pending messages in the VDUSE driver.
>
> Not exactly bufferize, record.  E.g. we do not need to send
> 100 messages to enable/disable promisc mode - together they
> have no effect.

The downside of such optimization is that it requires the VDUSE Kernel driv=
er
to be able to handle all the message types.

So every time we add support for a new control message type, we'll also hav=
e
to patch VDUSE Kernel driver.

I am not sure the gain is worth the effort as the traffic on the
control queue is
usually rather low?

Maxime

>
> --
> MST
>

