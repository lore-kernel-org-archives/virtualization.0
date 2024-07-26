Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596A21CAB1
	for <virtualization@lists.linux.dev>; Fri, 26 Jul 2024 02:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721961474; cv=none; b=skfUpIX3urJJFTVZUU/kYTfNwQATAZ4vs7Ca6OXjDjc2Q6mpXxL3p3McUtRyih1XFX8oWDXdd/Kc+EOPbDpOio5+KQfth0GmtSXI35DyrFxPZuVVOmncbcpM3g2gsgU+7sbm8kXqXgZRYDPZNLFfaqqaIVmThn56gMl924vRqjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721961474; c=relaxed/simple;
	bh=GhKBsF/SvlEAcs33XHCOiJKx/NxpU6atfNNwN1ekgw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gn0p0L5euh8kYIOpNKQlD84a1PB4q2utWqjaJqfPageqUx3m29oHEC6KtW8HltDAEDycRmhjdDw/1RSVlHKfH2Sm1cZ7uSLgV7nuvocW8IluIEhOEPEEXoAlXaiJBRiuqKiM+fEslqPTdAfJoIqQYYdZt9uSO/dH4/B1/t7h+lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EROBhUf7; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EROBhUf7"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cb81c0ecb4so333582a91.0
        for <virtualization@lists.linux.dev>; Thu, 25 Jul 2024 19:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721961472; x=1722566272; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhKBsF/SvlEAcs33XHCOiJKx/NxpU6atfNNwN1ekgw0=;
        b=EROBhUf7nTpZiwgqkz2nOKQBYg05i8A2NJtt36Duu1fyr/S7sq4itBSMrz9M7Jy4Fk
         301IJPqesXB2//TFBVuDwT1RuK5OXVT9TA1WeUK9FD3m8wsOVBjf2pwjQ4FaT4+VzBk6
         yVmzpR9oHksZrnDR2VnDJeE9junkxzpcpnVD2fYdQhXsZOJM4PTar/IKSwba9NgG4Ru7
         j+VurmwZUeaXK1Q2IzYr+Yp66E+SOeCc7OxysKR+Gk14QqebiVb8ay152nh5U749tNO/
         ZEsuC7SzsxEIafSUWl+JD8p4xeVAEJlvz3DICV2CZ2+u43bGnXoA4HGlAvof6AshCsHt
         gVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721961472; x=1722566272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhKBsF/SvlEAcs33XHCOiJKx/NxpU6atfNNwN1ekgw0=;
        b=baYy6e/nwvHWVLNriSnKQBXTr4f/FyFN1ZrEtGDmfwjY+625dj1z05U987T4ab2gax
         0w22Y62PJHkW7EysfjIFEyCxiC32qfYV6CVnYftvpBAUKaIrefpMWzI99Nu4NrHXNY6+
         btX+iY2bjqYd15/lCmA2pco3t3xDDoTdjU2ApERktiRnxsfCuiZH9N5UMPnTdT+rCn7k
         ozsdpPVzL4ieNVBU+Oc3udMVOxkqy2m/pzvehPQ9VgMbMC4YqaZeZWu20FjES+X8FY9P
         dYQ504vAZzwtwXG36a326VWT1QSsbLt9VCBxKPoucR8uw2AZVX8DXXNXUW7rf4t9yIOJ
         U1lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWr+JPO6seROmpV8BVR1WUpE0ybEkU+jsmzaj640U52M7AP+2t1f8DKDo+cDH3GIIojLb3lVY6uDKANmGsMUUXNLrmQnX169USmiRslJfo=
X-Gm-Message-State: AOJu0Yxx8n0eOE/ZMHAPDlsif5i2juoB49Pl2INg5ksljpsZytKKqCyb
	d00hcqCh7D42FgVjow0F6fNPz53zbiwAAr8CVcme+vZOijRobzyZFFd9fziWAPyk40PiKy9CmDb
	ZbR3YHBInnNzrE8t9P7knz/yqAFNL2lnBM5po
X-Google-Smtp-Source: AGHT+IFkbOn1XHzUw/cOU4XhDRjKP/0fMxqFwleFgQz3swVjmW0A9rcMKes9FlpwhVD0tMLzQ/Y3rclyhA0kdf+YqZc=
X-Received: by 2002:a17:90b:4b52:b0:2cb:5829:a491 with SMTP id
 98e67ed59e1d1-2cf2207e990mr7588684a91.20.1721961471649; Thu, 25 Jul 2024
 19:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240724033816.GD492231@quicinc.com>
In-Reply-To: <20240724033816.GD492231@quicinc.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Fri, 26 Jul 2024 10:37:40 +0800
Message-ID: <CACycT3sGqd7jT2--Srt2de0gDPs6+AE9vMgX-ObBgKoZoqoBJw@mail.gmail.com>
Subject: Re: [RFC] vduse config write support
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Cc: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.linux.dev, 
	virtualization@lists.linux.dev, quic_mnalajal@quicinc.com, 
	quic_eberman@quicinc.com, quic_pheragu@quicinc.com, quic_pderrin@quicinc.com, 
	quic_cvanscha@quicinc.com, quic_pkondeti@quicinc.com, quic_tsoni@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 11:38=E2=80=AFAM Srivatsa Vaddagiri
<quic_svaddagi@quicinc.com> wrote:
>
> Currently vduse does not seem to support configuration space writes
> (vduse_vdpa_set_config does nothing). Is there any plan to lift that
> limitation? I am aware of the discussions that took place here:
>

The problem is that current virtio code can't allow the failure of config w=
rite.

> https://patchwork.kernel.org/project/netdevbpf/patch/20210615141331.407-1=
1-xieyongji@bytedance.com/
>
> Perhaps writes can be supported *selectively* without violating safety co=
ncerns
> expressed in the above email discussion?
>
> We are thinking of using vduse for hypervisor assisted virtio devices, wh=
ich
> may need config write support and hence this question.
>
> To provide more details, we have a untrusted host that spins off a protec=
ted
> (confidential) guest VM on a Type-1 hypervisor (Gunyah). VMM in untrusted=
 host
> leads to couple of issues:
>
> 1) Latency of (virtio) register access. VMM can take too long to respond =
with
> VCPU stalled all that while. I think vduse shares a similar concern, due =
to
> which it maintains a cache of configuratin registers inside kernel.
>
> 2) For PCI pass-through devices, we are concerned of letting VMM be in ch=
arge of
> emulating the complete configuration space (how can VM defend against inv=
alid
> attributes presented for passthr devices)? I am aware of TDISP, but I thi=
nk it
> may not be available for some of the devices on our platform.
>
> One option we are considering is for hypervisor to be in charge of virtio=
-PCI
> bus emulation, allowing only select devices (with recognized features) to=
 be
> registered on the bus. VMM would need to register devices/features with
> hypervisor, which would verify it (as per some policy) and present them t=
o VM on
> the virtio-PCI bus it would emulate. Protected VM should be shielded from
> invalid device configuration information that it may otherwise read from =
a
> compromised VMM.
>
> For virtio devices, the hypervisor would also service most register read/=
writes
> (to address concern #1), which implies it would need to cache a copy of t=
he
> device configuration information (similar to vduse).
>
> We think vduse can be leveraged here to initialize the hypervisor cache o=
f
> virtio registers. Basically have a vdpa-gunyah driver registered on the v=
dpa
> bus to which vduse devices are bound (rather than virtio-vdpa or vhost-vd=
pa).
> vdpa-gunyah driver can pull configuration information from vduse and pass=
 that
> on to hypervisor. It will also help inject IRQ and pass on queue notifica=
tions
> (using hypervisor specific APIs).
>
> We will however likely need vduse to support configuration writes (guest =
VM
> updating configuration space, for ex: writing to 'events_clear' field in =
case of
> virtio-gpu). Would vduse maintainers be willing to accept config_write su=
pport
> for select devices/features (as long as the writes don't violate any safe=
ty
> concerns we may have)?
>

It would be easier to support it if the config write just triggers an
async operation on the device side, e.g. a doorbell. That means we
can't ensure that any required internal actions on the device side
triggered by the config write have been completed after the driver
gets a successful return. But I'm not sure if this is your case.

Thanks,
Yongji
