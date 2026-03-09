Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD28734F479
	for <virtualization@lists.linux.dev>; Mon,  9 Mar 2026 23:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773097689; cv=pass; b=UH5GUvp20IS/3sDk7h0raIII4gQIVhcryU5+BAVfSBEU8+15E3jV4G30MIL94WUbSTyZbSqxysHSP7EWaDNCMSYZt8dR1dY7rSgSc4QL0rDjMTQ4U9KYTIZek5smp0rXXDFXzy5Gv267o6fI4mCzSwGM6Aw1Gd4pFlV41RLQkcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773097689; c=relaxed/simple;
	bh=M4cduyEH0nzIyeAa2DWzTvD5pL+wmdKzftbWE4kTeiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxmahlUmrjNr7Hh97cJ8Fd3krV/dFGu7K+NilfYtLzmuTDA3XUfZKwOE/iyoi47Knzy4oPm9mqJLn0Pts90dpyedF0IoiV5OMX+/fJYg/m/NY3wEIe6hMfnyTXLCwP+BBEymA2Er+Xoa7KQmuJIQI7KU/xBfQDgW+wOemmw4mBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g083bVe1; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g083bVe1"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-660ea6ceb5aso8464854a12.0
        for <virtualization@lists.linux.dev>; Mon, 09 Mar 2026 16:08:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773097686; cv=none;
        d=google.com; s=arc-20240605;
        b=fGUoIvoT4CJp1AHVGOFTRguX5xBIYZeNtfGr1eqt8xmt7rNhX6jjVrgPQP8Eaa2UtJ
         WPM5I9FrT8zjlu00is3etsnC+VzYEklVATLOzSShWQRIphChXchKC+R+8BcmR5uLdv9d
         NSMbUC0m6Kg0WUrPhIb/nnxTc43bc5r4irtUXXjmho/Vg0xVvwfHABtQXy4FPBfHaFZ/
         wQSgThyyWYadqq6boneLzAz6/zoizwRgUZoR89wBrZaA4Umxx8BbXhaslOG7+Crl6rz3
         db42u+rN8DahxwKnti/s4oIXqaTww6h3w9xm7mTRsO4e6i6rhxzeB5OGrN56hIPib6cz
         EheA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RBshlfHpx3Ec+CKDHPfm6S/XgqSY4C1OlvaszE0SqYs=;
        fh=g1gAJpsKegNkN3kI42xin4aKlUXXAEEEbrEuBE885zI=;
        b=a4mufO9agn/GxRrVJExXunSrjFSTnlb0RnVo3NHwyR9Whz2Y3CPQfYM6xLOtw1zzfM
         5rFIN3/bao4qCzp+iXZpUFix+2/BZQxBKb30A/bLYaaoU2x/jXswwZCjO/7PuNIl9sQw
         UqglNVWGFTCLf0e+VBfwMqxidG/9ED3p7Qeur0P4xx4x81GpNrCb0PzZNwCzMs2WOi1n
         LNEKLBSe7yGN38xjvoPz3Qf6DVJKZ92uZscK4ymIapWwpuC080XPXoX9ZNCzipWpSdXi
         nlywcxc4LHY8q3Tc9XJo/4iznQgA8zUCz9xU7oF6F3EVJOCiqvh36NqBcg+dbE3qRunY
         /SJQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773097686; x=1773702486; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBshlfHpx3Ec+CKDHPfm6S/XgqSY4C1OlvaszE0SqYs=;
        b=g083bVe17l6mxq/Vu+PlCXEVx0haskABC6KnJD/RKYxv/Op6BOmBDRvZ3kOaXLEbbQ
         zsDuTeDNnCi//GGKQE9hC61v1bYmIgjGItvBz58Hi0sPF7PhgfZey3ih9xpzs2Og0LpA
         5f7Y5XahDU7BsEcBkzHyI02Rn4tysxuGPBwXlYaSbUcowr1TDdMp6jHh06R1F0YWDN8T
         nY1snadv8kEABbvG/aL+Py/JRzkii3m9gOQ2N4LxkNhtMsPT8rD0taRY5YoFFcGqTIcE
         +GCVt3KjyW2nQi99+eTYbGXWhuHS5a4uyN6eLHH436bVeVgTzOZAmNquN1ngu7d03BGe
         /2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773097686; x=1773702486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RBshlfHpx3Ec+CKDHPfm6S/XgqSY4C1OlvaszE0SqYs=;
        b=R+tp64Y7P5z4AYNGoIAzUnssuh2RR/3wsERXvk0o/na05C2cjO3ya8Zj46jDtp2hBc
         tmTj1b8rCVOB3XbH82Pd2xFv4J1P70iRfkPNpK8ko0TWIOxpsGPpR2npm4xE0chN4k4a
         Ucg0jQr90gulQSzXn+pI5aq1ue5upG0gDr6q+HfUQEIqT/zUgGFbmIU80y3toIm1OmG1
         3vmWcJbN9HD1wJFkC38OoQfYg2isaLCXjCdkrsujVxGOMLS8fnZM+wQD8mEK6oGX4YUe
         JawMnL39OXyhBKaZB/4DLW7469PEKG/tYHtjUaEky3JQT+ugbB50INQyKQ4ep6lPqGgo
         RBAw==
X-Forwarded-Encrypted: i=1; AJvYcCX9JKJuBzdPboZfrhXwDJlL1ArgsW5xIy0JGgrcxo/hCDqy+2+DD6b5FRoA+UuE1iT5FRkWhZtEFfIowe54Tg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvzPwfU6YVgspv+vOJMXhX33vpnAzpBQcH1KVmHkZNC0OFGOCR
	qWDTL2DyIo/DiN6cz73d1ADV2mdnLqMzwEf7VU3SmfoFwLLlVPxR9JW+rTKazRISaEvuNQwkQMy
	RRYr2ghqfjJxPju92LkCF3MhE03liU8U=
X-Gm-Gg: ATEYQzzYOpISheGNE9BPeou5RNpSYgTDIuNzk+y9UUSa77OydejK4xKuM4GxKuj9sVV
	5KsklwTwI5PzrutJzIoMRVotTK4Onnb0T5Go8a/3KxuNVitP5QUY6yXDvAAWr1ZJQ+P+M+WrQYO
	P1MN5OpIQmZIdmE6U+gPY78brmRiN6g9CWM5rkywj+XEY3yw1/tatxN39/WJH/boquQ6z5r/6e2
	czEu07hmddPT3Jg8BEdbCAkcL6RSKt/zo/xUsFSZiKYEG2+zVj/ouzT51MnvlJn3FPvBix8Ur64
	nH8mMrlCwdS0zY1cq/X7dXHbXecgmkWch3go6zlTIA==
X-Received: by 2002:a17:907:3e10:b0:b96:e1de:db04 with SMTP id
 a640c23a62f3a-b9711a1fe33mr88963666b.18.1773097685832; Mon, 09 Mar 2026
 16:08:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260226204345.1904786-1-jdaley@linux.ibm.com>
 <20260226204345.1904786-2-jdaley@linux.ibm.com> <20260309030617.GB8611@fedora>
 <55a1fe3d-617f-4ddc-8d71-a8b498eb186f@linux.ibm.com>
In-Reply-To: <55a1fe3d-617f-4ddc-8d71-a8b498eb186f@linux.ibm.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 10 Mar 2026 07:07:53 +0800
X-Gm-Features: AaiRm52a24UUlcx8zgmavlWcAXJUewlR7p2esuE-N9GRDWx7T5YMpj0PqhmkvEw
Message-ID: <CAJSP0QUmtShZ4ObnVM79h31Qi0VJ42+81wtEJZwYm6K1DG+NWw@mail.gmail.com>
Subject: Re: [PATCH 1/1] scsi: virtio_scsi: move INIT_WORK calls to virtscsi_init
To: Joshua Daley <jdaley@linux.ibm.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, mst@redhat.com, 
	jasowang@redhat.com, pbonzini@redhat.com, eperezma@redhat.com, 
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com, 
	mjrosato@linux.ibm.com, farman@linux.ibm.com, frankja@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 5:07=E2=80=AFAM Joshua Daley <jdaley@linux.ibm.com>=
 wrote:
>
> On 3/8/2026 11:06 PM, Stefan Hajnoczi wrote:
> > On Thu, Feb 26, 2026 at 09:43:45PM +0100, Joshua Daley wrote:
> >> The last step of virtscsi_handle_event is to call virtscsi_kick_event,
> >> which calls INIT_WORK on it's own work item. INIT_WORK resets the
> >> work item's data bits to 0.
> >>
> >> If this occurs while the work item is being flushed by
> >> cancel_work_sync, then kernel/workqueue.c/work_offqd_enable triggers a
> >> kernel warning, as it expects the "disable" bit to be 1:
> >>
> >> [   21.450115] workqueue: work disable count underflowed
> >> [   21.450117] WARNING: CPU: 1 PID: 56 at kernel/workqueue.c:4328 enab=
le_work+0x10a/0x120
> >> ...
> >> [   21.450171] Call Trace:
> >> [   21.450173]  [<000003db2e5bdc3e>] enable_work+0x10e/0x120
> >> [   21.450176] ([<000003db2e5bdc3a>] enable_work+0x10a/0x120)
> >> [   21.450178]  [<000003db2e5bdd86>] cancel_work_sync+0x86/0xa0
> >> [   21.450181]  [<000003daae97d9e4>] virtscsi_remove+0xb4/0xd0 [virtio=
_scsi]
> >> [   21.450184]  [<000003db2ef3b5ca>] virtio_dev_remove+0x6a/0xd0
> >> [   21.450186]  [<000003db2ef9106c>] device_release_driver_internal+0x=
1ac/0x260
> >> [   21.450190]  [<000003db2ef8edc8>] bus_remove_device+0xf8/0x190
> >> [   21.450192]  [<000003db2ef88d72>] device_del+0x142/0x340
> >> [   21.450194]  [<000003db2ef88fa0>] device_unregister+0x30/0xa0
> >> [   21.450196]  [<000003db2ef3b2fa>] unregister_virtio_device+0x2a/0x4=
0
> >>
> >> This warning may occur if a controller is detached immediately
> >> following a disk detach.
> >>
> >> Move the INIT_WORK call to prevent this. Don't re-init event list
> >> work items in virtscsi_kick_event, init them only once in
> >> virtscsi_init instead.
> >>
> >> Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
> >> ---
> >>   drivers/scsi/virtio_scsi.c | 6 +++++-
> >>   1 file changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> >> index 0ed8558dad72..173092931df6 100644
> >> --- a/drivers/scsi/virtio_scsi.c
> >> +++ b/drivers/scsi/virtio_scsi.c
> >> @@ -242,7 +242,6 @@ static int virtscsi_kick_event(struct virtio_scsi =
*vscsi,
> >>      struct scatterlist sg;
> >>      unsigned long flags;
> >>
> >> -    INIT_WORK(&event_node->work, virtscsi_handle_event);
> >>      sg_init_one(&sg, event_node->event, sizeof(struct virtio_scsi_eve=
nt));
> >>
> >>      spin_lock_irqsave(&vscsi->event_vq.vq_lock, flags);
> >> @@ -898,6 +897,11 @@ static int virtscsi_init(struct virtio_device *vd=
ev,
> >>      virtscsi_config_set(vdev, cdb_size, VIRTIO_SCSI_CDB_SIZE);
> >>      virtscsi_config_set(vdev, sense_size, VIRTIO_SCSI_SENSE_SIZE);
> >>
> >> +    if (virtio_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
> >> +            for (i =3D 0; i < VIRTIO_SCSI_EVENT_LEN; i++)
> >> +                    INIT_WORK(&vscsi->event_list[i].work, virtscsi_ha=
ndle_event);
> >> +    }
> >
> > The eventq should be populated unconditionally so that non-hotplug
> > events are processed even when F_HOTPLUG is not negotiated. For example=
,
> > LUN capacity changes are reported via the VIRTIO_SCSI_T_PARAM_CHANGE
> > event. LUN capacity changes depend on F_CHANGE, not F_HOTPLUG.
> >
> > There is a related bug here: the other if (virtio_has_feature(vdev,
> > VIRTIO_SCSI_F_HOTPLUG)) conditionals in this file need to be revisited
> > so that LUN capacity changes are reported even when F_HOTPLUG is not
> > negotiated. You can test this bug with QEMU's -device
> > virtio-scsi-pci,hotplug=3Doff parameter and the 'block_resize' QEMU
> > monitor command.
> >
> > Do you want to write a patch or do you want me to send a follow-up?
> >
> > Thanks,
> > Stefan
>
> I can write a patch. Thanks for your review.
>
> There are 3 other if (virtio_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) co=
nditionals in this file, for:
>
> 1. virtscsi_kick_event_all() called in virtscsi_probe()
> 2. virtscsi_cancel_event_work() called in virtscsi_remove()
> 3. virtscsi_kick_event_all() called in virtscsi_restore()
>
> Should the eventq be populated truly unconditionally? Then I would just r=
emove the conditions from
> these calls. Or would it be better to just change the conditions to also =
check the other feature:
> if (... || virtio_has_feature(vdev, VIRTIO_SCSI_F_CHANGE))

Yes. The eventq is always present and the memory backing it is already
allocated. I think dropping the conditionals simplifies the driver and
avoids bugs like the F_CHANGE one without introducing downsides.

Stefan
