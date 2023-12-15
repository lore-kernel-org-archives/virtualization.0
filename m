Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8E9381
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 01:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YYGTLlRJ"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D398E60FFD
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 01:00:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D398E60FFD
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=YYGTLlRJ
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l582F5VI9m_3
	for <virtualization@lists.linux-foundation.org>;
	Fri, 15 Dec 2023 01:00:54 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 72F1260FE6
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Dec 2023 01:00:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 72F1260FE6
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bf3efe2cbso91850e87.2
        for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 17:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702602052; x=1703206852; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeaw3ji0pg6zC2peZEVGQL9hjW+bOoI/oOULSseP2eQ=;
        b=YYGTLlRJuui9pJ1GzTywJYab6ds8e+BTw4a1cLzvteDhC4F9oLebqHxEYdi86fjBLy
         A6Xg+mjun9/bCsSdBQWHcbU+4dy5JebDoHwMJSv6qAF7FwXp6kguz8d7KntJI5sKBuOG
         QdvKMibZeqXktwFZclvH2FR//SOWIqC8PztkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702602052; x=1703206852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeaw3ji0pg6zC2peZEVGQL9hjW+bOoI/oOULSseP2eQ=;
        b=H3FaDq7WhLoVLUBY/nMp71l0oqXCAZtdZQvLmKa5QZc5yhrg3Z+wTUfB36ZYPFm+RS
         CpPzuzVH09RjXz+LesIufrsoyRZw0rWGVwqCPQNKrCRpLxJwdyuCK2Wu5DcwmDkK/JcX
         KBrbwUI7/NEcIxOC/WWU/Pq8EIncvEY2WzTMy2GXTU/c929TYeM47E2eJfbR0QZW+igy
         CeQkgM4RKWiOwKkl40GVLV5Z/+5e+nEAwB0dkXmnxxPX/YWsslE7cUBR49N808W2ovxF
         5XtV6ie5yexHdMAlkCCtWxL9Y3O+MxGRjHrmrMQ1ZeAWLlwNd4LsIHYEB1nK3bDvhIrB
         tHtA==
X-Gm-Message-State: AOJu0YwLrLR7TZIT+FZCUvnVPB2aykUHPAEhWke2O6FpWNg7UH/Guufd
	IzzNoD7zNUa1isb1hMb/0iyAi3SRvPELs4s6Df02pw==
X-Google-Smtp-Source: AGHT+IE04S5Qh7uJe6rBqhFgzTVg8/E62kzoLJ68Pm4mv9JVFbY+sJs88Raftysa85n96dacTNvUxuni1E51J6YM/Kc=
X-Received: by 2002:a05:6512:3b8d:b0:50d:1487:8d11 with SMTP id
 g13-20020a0565123b8d00b0050d14878d11mr3154911lfv.144.1702602052113; Thu, 14
 Dec 2023 17:00:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231208070754.3132339-1-stevensd@chromium.org> <9fb51bfc-576a-4c7b-92c2-c161e7f08ae7@redhat.com>
In-Reply-To: <9fb51bfc-576a-4c7b-92c2-c161e7f08ae7@redhat.com>
From: David Stevens <stevensd@chromium.org>
Date: Fri, 15 Dec 2023 10:00:41 +0900
Message-ID: <CAD=HUj6ZsZo_kxZazDDDUp61pEHupuf0Lf7WqkKBsMOA1CYcNQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: Add support for no-reset virtio PCI PM
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 6:47=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 08.12.23 08:07, David Stevens wrote:
> > If a virtio_pci_device supports native PCI power management and has the
> > No_Soft_Reset bit set, then skip resetting and reinitializing the devic=
e
> > when suspending and restoring the device. This allows system-wide low
> > power states like s2idle to be used in systems with stateful virtio
> > devices that can't simply be re-initialized (e.g. virtio-fs).
> >
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> > ---
> > v1 -> v2:
> >   - Check the No_Soft_Reset bit
> >
> >   drivers/virtio/virtio_pci_common.c | 34 +++++++++++++++++++++++++++++=
-
> >   1 file changed, 33 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio=
_pci_common.c
> > index c2524a7207cf..3a95ecaf12dc 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -492,8 +492,40 @@ static int virtio_pci_restore(struct device *dev)
> >       return virtio_device_restore(&vp_dev->vdev);
> >   }
> >
> > +static bool vp_supports_pm_no_reset(struct device *dev)
> > +{
> > +     struct pci_dev *pci_dev =3D to_pci_dev(dev);
> > +     u16 pmcsr;
> > +
> > +     if (!pci_dev->pm_cap)
> > +             return false;
> > +
> > +     pci_read_config_word(pci_dev, pci_dev->pm_cap + PCI_PM_CTRL, &pmc=
sr);
> > +     if (PCI_POSSIBLE_ERROR(pmcsr)) {
> > +             dev_err(dev, "Unable to query pmcsr");
> > +             return false;
> > +     }
> > +
> > +     return pmcsr & PCI_PM_CTRL_NO_SOFT_RESET;
> > +}
> > +
> > +static int virtio_pci_suspend(struct device *dev)
> > +{
> > +     return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_freeze(dev);
> > +}
> > +
> > +static int virtio_pci_resume(struct device *dev)
> > +{
> > +     return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_restore(dev)=
;
> > +}
> > +
> >   static const struct dev_pm_ops virtio_pci_pm_ops =3D {
> > -     SET_SYSTEM_SLEEP_PM_OPS(virtio_pci_freeze, virtio_pci_restore)
> > +     .suspend =3D virtio_pci_suspend,
> > +     .resume =3D virtio_pci_resume,
> > +     .freeze =3D virtio_pci_freeze,
> > +     .thaw =3D virtio_pci_restore,
> > +     .poweroff =3D virtio_pci_freeze,
> > +     .restore =3D virtio_pci_restore,
> >   };
> >   #endif
> >
>
> Am I correct with my assumption that this will make s2idle work with virt=
io-mem-pci as well?
>
> Right now, all suspending is disabled, but really only s4/hibernate is pr=
oblematic.
>
> [root@vm-0 ~]# echo "s2idle" > /sys/power/mem_sleep
> [root@vm-0 ~]# echo "mem" > /sys/power/state
> [  101.822991] PM: suspend entry (s2idle)
> [  101.828978] Filesystems sync: 0.004 seconds
> [  101.831618] Freezing user space processes
> [  101.834569] Freezing user space processes completed (elapsed 0.001 sec=
onds)
> [  101.836915] OOM killer disabled.
> [  101.838072] Freezing remaining freezable tasks
> [  101.841054] Freezing remaining freezable tasks completed (elapsed 0.00=
1 seconds)
> [  101.843538] printk: Suspending console(s) (use no_console_suspend to d=
ebug)
> [  101.957676] virtio_mem virtio0: save/restore not supported.
> [  101.957683] virtio-pci 0000:00:02.0: PM: pci_pm_suspend(): virtio_pci_=
freeze+0x0/0x50 returns -1
> [  101.957702] virtio-pci 0000:00:02.0: PM: dpm_run_callback(): pci_pm_su=
spend+0x0/0x170 returns -1
> [  101.957718] virtio-pci 0000:00:02.0: PM: failed to suspend async: erro=
r -1

QEMU's virtio-pci devices don't advertise no_soft_reset, so this patch
won't affect vanilla QEMU. But if you add PCI_PM_CTRL_NO_SOFT_RESET to
the capability, then it should work. I'm working with crosvm, which
doesn't have virtio-mem implemented, but this patch makes virtio-fs
work with no extra kernel changes.

-David
