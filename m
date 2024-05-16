Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B770514293
	for <virtualization@lists.linux.dev>; Thu, 16 May 2024 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715853183; cv=none; b=OaShhKOyHkvZn0uB3JvVvIOobpGEU7x6aWVKT4eDwnBdFo1YBtbw+/jDvpVR13mWR6rCUebS5zD6NzFvN0zQjKsaI6fV4nRZ+Lg36X8pw9igSly8h+r30mCbMLz0NoOKb8RsD/z43qX2LQbq1bWUYy9sS/CyB4XcMrFv4uKO6rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715853183; c=relaxed/simple;
	bh=3WDhBUbvWVU9a+yStR60HYJlQ10TeiHR+xKgzv4TOkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JheMUyQUyK6qXZaagSgOiffrbzjg8mZKx1OirGPZNYFoW/zfWMpIG5DBvDUfNLSYR56jWoNgPPNdFb848n243tGB+kVtGswkkO4ANs9/SfydrwCPT9XuvkdUA2lamLAOhmLOgYHUVCIm6V5liw6k8Ga9HeuNdYcj2WIC7YaijRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGet9aWz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGet9aWz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715853180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/u+S5t6rTTa+aVcoDlgIUFxdt8SViMTcSlyQilqGHo=;
	b=iGet9aWziv/xmT3DTdb0IzsGUCO70++Eu+MdE1TeU2qgtBP7sGvVIsUaE6rjVjVUoG+DYC
	/U5TDAJPy8dADZuCopUVKjbP/GEamaK9sQSLAooL1j82DHbXmOvP5/EaWCPHuTQaxbfvce
	b8YHngOB+GR3uhWuWMtjmz79JePWysg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-Th15NATPPfyMTFDdnpQwag-1; Thu, 16 May 2024 05:52:59 -0400
X-MC-Unique: Th15NATPPfyMTFDdnpQwag-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2b364c4c4b0so7645441a91.1
        for <virtualization@lists.linux.dev>; Thu, 16 May 2024 02:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715853178; x=1716457978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/u+S5t6rTTa+aVcoDlgIUFxdt8SViMTcSlyQilqGHo=;
        b=BAuxEPpIdqOpnuhNWf3Is9WwIVJvBkx0kIjY+6W3Jr4QurYrK6vGmmRZI95k5osUG7
         h1oVVyT3Kpm6EA4gat7COq+iEVQbLCRczMktq62kGdsBTrV0PPbR02mjZaranAgLhVvg
         iy/2i0xAMO9DU4UDtX52H7IaUd9n8OVY/8DmidOGxSkxdNOdoEZtjmR6WQbVeXDaHezF
         c10SeoNd1cPxImWzLrr33lnwQqzvYkGM7I8KdaIsRg7rNgtAsLyFDzMXrmMPmyFYZHYp
         MgT9LmHxHJRocgwX7YH1QlqfVXJ7zy4HmV3rnTQWKOUtTy+U7IH+420oLpxGLWYkm7J0
         BPqA==
X-Forwarded-Encrypted: i=1; AJvYcCXksLlmutB/6Ne4sSeLO8QW9V6gQpDu4DIm0CR42ZFwjRNyDjrI2u8lsq8CrbSXuRV58I9BDVh+mvMeRgCn9BRCoYzVAQPcJN29/sLJzCY=
X-Gm-Message-State: AOJu0YyNSRBaRAv6yfkwa155pssGR7jzKtVQDTSmttvnP5r7UJeli5AH
	HN5Uq8GGHZxZV4WFs+3a3bQDJ1lEVfhUai8ZO2rwa8AgBBZZtBgM/s8bOEOf39k1+u8dUdQnEEs
	K7jVUXllaylkDJICdxpsJJcvsaRwYqxK7yjLL81NB3lKUXY+BKokpG19ohl+McC84+VSDz98uj+
	lDS50y7i8K9FbZjIJ4B5dkI3DD5+Iukh3MhatriE4=
X-Received: by 2002:a17:90b:1c0c:b0:2b6:22f0:3b8a with SMTP id 98e67ed59e1d1-2b6ccd94186mr19329771a91.36.1715853177761;
        Thu, 16 May 2024 02:52:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9RbZudQ162MQm+vBDY49BD9DBXtVJxkSGIwqXEXUZOY/u5NYi3XP8REvLu0c7HuYHOQUTZIZK9LAgErYCA/4=
X-Received: by 2002:a17:90b:1c0c:b0:2b6:22f0:3b8a with SMTP id
 98e67ed59e1d1-2b6ccd94186mr19329757a91.36.1715853177306; Thu, 16 May 2024
 02:52:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <13a313c7-c214-4d49-9029-c79b503c17dd@canonical.com>
 <CACGkMEtZEeObDxcVBnvczLFGm1=13=tz_4mJGeXMw+4JgGWRpA@mail.gmail.com>
 <CAFRRCvN7YYF2wT2OaXQdL8q4yvC2_kFuf3D6+jXHOZwbQ0bF9g@mail.gmail.com>
 <8f771516-86f3-6724-7b2c-22cc23933075@nvidia.com> <CAFRRCvNqAQd4Hf5v8EU7PkVu=7YmB+q340zG6ccm4O8jJHwi+g@mail.gmail.com>
In-Reply-To: <CAFRRCvNqAQd4Hf5v8EU7PkVu=7YmB+q340zG6ccm4O8jJHwi+g@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 16 May 2024 17:52:44 +0800
Message-ID: <CACGkMEuPyKwtdPO6hB+6DigOFaR2ySa99bWmmLuJgb7uLhmH7A@mail.gmail.com>
Subject: Re: [REGRESSION][v6.8-rc1] virtio-pci: Introduce admin virtqueue
To: Catherine Redfield <catherine.redfield@canonical.com>
Cc: Feng Liu <feliu@nvidia.com>, Joseph Salisbury <joseph.salisbury@canonical.com>, parav@nvidia.com, 
	jiri@nvidia.com, mst@redhat.com, yishaih@nvidia.com, 
	alex.williamson@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Francis Ginther <francis.ginther@canonical.com>, John Cabaj <john.cabaj@canonical.com>, 
	Ankush Pathak <ankush.pathak@canonical.com>, Chlo Smith <chloe.smith@canonical.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 5:46=E2=80=AFPM Catherine Redfield
<catherine.redfield@canonical.com> wrote:
>
> Feng,
>
> Thank you for providing your debugging steps; I used them on a gce image =
locally and was not able to replicate the issue.  I also attempted to repli=
cate in qemu/virsh using qemu-guest-agent to enable the S3 suspend state, a=
lso without success (that is S3 suspend state worked without any problems).=
  I have brought this back to the cloud for further debugging of their conf=
ig and guest agent to try and determine what the issue is.
>
> Thank you very much for all your help on this issue and time looking into=
 it!
> Catherine

Does this fix the issue? I guess the reason is that GCE is using legacy vir=
tio.

https://lore.kernel.org/kvm/CACGkMEth_9Baewekq862YgZwuozwG96Z3G6oYqHzyCj2JP=
UZ3g@mail.gmail.com/T/

Thanks

>
> On Thu, May 9, 2024 at 5:03=E2=80=AFAM Feng Liu <feliu@nvidia.com> wrote:
>>
>>
>> On 2024-05-08 a.m.7:18, Catherine Redfield wrote:
>> > *External email: Use caution opening links or attachments*
>> >
>> >
>> > On a VM with the GCP kernel (where we first identified the problem), I=
 see:
>> >
>> > 1. The full kernel log from `journalctl --system > kernlog` attached.
>> > The specific suspend section is here:
>> >
>> > May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal
>> > systemd[1]: Reached target sleep.target - Sleep.
>> > May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal
>> > systemd[1]: Starting systemd-suspend.service - System Suspend...
>> > May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal
>> > systemd-sleep[1413]: Performing sleep operation 'suspend'...
>> > May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal
>> > kernel: PM: suspend entry (deep)
>> > May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal
>> > kernel: Filesystems sync: 0.008 seconds
>> > May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal
>> > kernel: Freezing user space processes
>> > May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal
>> > kernel: Freezing user space processes completed (elapsed 0.001 seconds=
)
>> > May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal
>> > kernel: OOM killer disabled.
>> > May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal
>> > kernel: Freezing remaining freezable tasks
>> > May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal
>> > kernel: Freezing remaining freezable tasks completed (elapsed 0.000 se=
conds)
>> > May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal
>> > kernel: printk: Suspending console(s) (use no_console_suspend to debug=
)
>> > May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal
>> > kernel: port 00:03:0.0: PM: dpm_run_callback():
>> > pm_runtime_force_suspend+0x0/0x130 returns -16
>> > May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal
>> > kernel: port 00:03:0.0: PM: failed to suspend: error -16
>>
>> Thanks Joesph and Catherine's help.
>>
>> Hi,
>>
>> I have alreay synced up with Cananical guys offline about this issue.
>>
>> I can run "suspend/resume" sucessfully on my local server and VM.
>> And "PM: failed to suspend: error -16" looks like not cause by my
>> previous virtio patch ( fd27ef6b44be  ("virtio-pci: Introduce admin
>> virtqueue")) which only modified "virtio_device_freeze" about "suspend"
>> action.
>>
>> So I have provide the my steps and debug patch to Joesph and Catherine.
>> I will also sync up the information here, as follow:
>>
>> I have read the qemu code and find a way to trigger "suspend/resume" on
>> my setup, and add some debug message in the latest kerenel
>>
>> My setps are:
>> 1. QEMU cmdline add following
>> ....
>> -global PIIX4_PM.disable_s3=3D0 \
>> -global PIIX4_PM.disable_s4=3D1 \
>> ....
>> -netdev type=3Dtap,ifname=3Dtap0,id=3Dhostnet0,script=3Dno,downscript=3D=
no \
>> -device
>> virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D$SSH_MAC,bus=3Dpci.0,ad=
dr=3D0x3 \
>> ......
>>
>> 2. In the VM, run "systemctl suspend" to PM suspend the VM into memory
>> 3. In qemu hmp shell, run "system_wakeup" to resume the VM again
>>
>> My VM configuration:
>> NIC:     1 virtio nic emulated by QEMU
>> OS:      Ubuntu 22.04.4 LTS
>> kernel:  latest kernel, 6.9-rc7: ee5b455b0ada (kernel2/net-next-virito,
>> kernel2/master, master) Merge tag 'slab-for-6.9-rc7-fixes' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab)
>>
>>
>> I add some debug message on the latest kernel, and do above steps to
>> trigger "suspen/resume". Everything of VM is OK, VM could suspend/resume
>> successfully.
>> Follwing is the kernel log:
>> ------------------------------------------------------------------------=
----
>> ........
>> May  6 15:59:52 feliu-vm kernel: [   43.446737] PM: suspend entry (deep)
>> May  6 16:00:04 feliu-vm kernel: [   43.467640] Filesystems sync: 0.020
>> seconds
>> May  6 16:00:04 feliu-vm kernel: [   43.467923] Freezing user space
>> processes
>> May  6 16:00:04 feliu-vm kernel: [   43.470294] Freezing user space
>> processes completed (elapsed 0.002 seconds)
>> May  6 16:00:04 feliu-vm kernel: [   43.470299] OOM killer disabled.
>> May  6 16:00:04 feliu-vm kernel: [   43.470301] Freezing remaining
>> freezable tasks
>> May  6 16:00:04 feliu-vm kernel: [   43.471482] Freezing remaining
>> freezable tasks completed (elapsed 0.001 seconds)
>> May  6 16:00:04 feliu-vm kernel: [   43.471495] printk: Suspending
>> console(s) (use no_console_suspend to debug)
>> May  6 16:00:04 feliu-vm kernel: [   43.474034] virtio_net virtio0:
>> godeng virtio device freeze
>> May  6 16:00:04 feliu-vm kernel: [   43.475714] virtio_net virtio0 ens3:
>> godfeng virtnet_freeze done
>> May  6 16:00:04 feliu-vm kernel: [   43.475717] virtio_net virtio0:
>> godfeng VIRTIO_F_ADMIN_VQ not enabled
>> May  6 16:00:04 feliu-vm kernel: [   43.475719] virtio_net virtio0:
>> godeng virtio device freeze done
>> ........
>> May  6 16:00:04 feliu-vm kernel: [   43.535382] smpboot: CPU 1 is now
>> offline
>> May  6 16:00:04 feliu-vm kernel: [   43.537283] IRQ fixup: irq 1 move in
>> progress, old vector 32
>> May  6 16:00:04 feliu-vm kernel: [   43.538504] smpboot: CPU 2 is now
>> offline
>> May  6 16:00:04 feliu-vm kernel: [   43.541392] smpboot: CPU 3 is now
>> offline
>>
>> ......
>>
>> May  6 16:00:04 feliu-vm kernel: [   54.973285] smpboot: Booting Node 0
>> Processor 15 APIC 0xf
>> May  6 16:00:04 feliu-vm kernel: [   54.975190] CPU15 is up
>> May  6 16:00:04 feliu-vm kernel: [   54.976011] ACPI: PM: Waking up from
>> system sleep state S3
>> May  6 16:00:04 feliu-vm kernel: [   54.986071] virtio_net virtio0:
>> godeng virtio device restore
>> May  6 16:00:04 feliu-vm kernel: [   54.987563] virtio_net virtio0 ens3:
>> godfeng virtnet_restore done
>> May  6 16:00:04 feliu-vm kernel: [   54.987635] virtio_net virtio0:
>> godfeng: virtio device restore done
>> ......
>> May  6 16:00:04 feliu-vm kernel: [   55.307221] ata8: SATA link down
>> (SStatus 0 SControl 300)
>> May  6 16:00:04 feliu-vm kernel: [   55.442048] OOM killer enabled.
>> May  6 16:00:04 feliu-vm kernel: [   55.442051] Restarting tasks ... don=
e.
>> May  6 16:00:04 feliu-vm kernel: [   55.443576] random: crng reseeded on
>> system resumption
>> May  6 16:00:04 feliu-vm kernel: [   55.443582] PM: suspend exit
>>
>> ------------------------------------------------------------------------=
----
>>
>> Attachment is the full kernel log. I think maybe it is some configration
>> error.
>>
>>
>> Thanks
>> Feng
>>
>>
>> > May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal
>> > kernel: sd 0:0:1:0: [sda] Synchronizing SCSI cache
>> > May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal
>> > kernel: PM: Some devices failed to suspend, or early wake event detect=
ed
>> > May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal
>> > kernel: OOM killer enabled.
>> > May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal
>> > kernel: Restarting tasks ... done.
>> > May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal
>> > kernel: random: crng reseeded on system resumption
>> > May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal
>> > kernel: PM: suspend exit
>> > May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal
>> > kernel: PM: suspend entry (s2idle)
>> > -- Boot 61828bc938b44fc68a8aeedc16a23a9d --
>> > May 08 11:09:03 localhost kernel: Linux version 6.8.0-1007-gcp
>> > (buildd@lcy02-amd64-079) (x86_64-linux-gnu-gcc-13 (Ubuntu
>> > 13.2.0-23ubuntu4) 13.2.0, GNU ld (GNU Binutils for Ubuntu) 2.42)
>> > #7-Ubuntu SMP Sat Apr 20 00:58:31 UTC 2024 (Ubuntu 6.8.0-1007.7-gcp 6.=
8.1)
>> > May 08 11:09:03 localhost kernel: Command line:
>> > BOOT_IMAGE=3D/vmlinuz-6.8.0-1007-gcp
>> > root=3DPARTUUID=3D7a949935-6bf2-4cae-b404-803c95163572 ro
>> > console=3DttyS0,115200 panic=3D-1
>> >
>> > 2. The features the devices has:
>> >
>> > catred@kernel-test-202405080702:~$ cat
>> > /sys/bus/virtio/devices/virtio0/features
>> > 0110000000000000000000000000010000000000000000000000000000000000
>> > catred@kernel-test-202405080702:~$ cat
>> > /sys/bus/virtio/devices/virtio1/features
>> > 1110010110011001110000100000010000000000000000000000000000000000
>> > catred@kernel-test-202405080702:~$ cat
>> > /sys/bus/virtio/devices/virtio2/features
>> > 1110000000000000000000000000000000000000000000000000000000000000
>> > catred@kernel-test-202405080702:~$ cat
>> > /sys/bus/virtio/devices/virtio3/features
>> > 0000000000000000000000000000000000000000000000000000000000000000
>> >
>> > Catherine
>> >
>> > On Tue, May 7, 2024 at 11:34=E2=80=AFPM Jason Wang <jasowang@redhat.co=
m
>> > <mailto:jasowang@redhat.com>> wrote:
>> >
>> >     On Sat, May 4, 2024 at 2:10=E2=80=AFAM Joseph Salisbury
>> >     <joseph.salisbury@canonical.com
>> >     <mailto:joseph.salisbury@canonical.com>> wrote:
>> >      >
>> >      > Hi Feng,
>> >      >
>> >      > During testing, a kernel bug was identified with the suspend/re=
sume
>> >      > functionality on instances running in a public cloud [0].  This
>> >     bug is a
>> >      > regression introduced in v6.8-rc1.  After a kernel bisect, the
>> >     following
>> >      > commit was identified as the cause of the regression:
>> >      >
>> >      >         fd27ef6b44be  ("virtio-pci: Introduce admin virtqueue")
>> >
>> >     Have a quick glance at the patch it seems it should not damage the
>> >     freeze/restore as it should behave as in the past.
>> >
>> >     But I found something interesting:
>> >
>> >     1) assumes 1 admin vq which is not what spec said
>> >     2) special function for admin virtqueue during freeze/restore, but=
 it
>> >     doesn't do anything special than del_vq()
>> >     3) lack real users but I guess e.g the destroy_avq() needs to be
>> >     synchronized with the one that is using admin virtqueue
>> >
>> >      >
>> >      > I was hoping to get your feedback, since you are the patch auth=
or. Do
>> >      > you think gathering any additional data will help diagnose this
>> >     issue?
>> >
>> >     Yes, please show us
>> >
>> >     1) the kernel log here.
>> >     2) the features that the device has like
>> >     /sys/bus/virtio/devices/virtio0/features
>> >
>> >      > This commit is depended upon by other virtio commits, so a reve=
rt
>> >     test
>> >      > is not really straight forward without reverting all the
>> >     dependencies.
>> >      > Any ideas you have would be greatly appreciated.
>> >
>> >     Thanks
>> >
>> >      >
>> >      >
>> >      > Thanks,
>> >      >
>> >      > Joe
>> >      >
>> >      > http://pad.lv/2063315 <http://pad.lv/2063315>
>> >      >
>> >

