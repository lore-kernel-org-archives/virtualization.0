Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC916AB3
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Dec 2023 03:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTAQLKme"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36E0781E2C
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Dec 2023 03:02:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 36E0781E2C
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YTAQLKme
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kJX-qPp9TGbS
	for <virtualization@lists.linux-foundation.org>;
	Tue, 12 Dec 2023 03:02:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3F3EE813B0
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Dec 2023 03:02:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3F3EE813B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702350128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/NcUhW82kVg4Fgb3Dq1SvC66NLPOJJ84gCXl550jBOg=;
	b=YTAQLKmeRK52CKGEKwZvDgFRDUiOtUz0V6bQEdXiPYfn6dY/0pCCXCtrnhwMxVVih6uQj5
	3VQHz7sbTBhuTu2qQNfzp4GM1zMwNpMUKHOxjObviOQ/j1AHjEricSwPdILkPuoz5QZW7m
	buVzfXnfmzP4njL3LzsJ2/YtFBR8YBY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-UWOZ6AoFMEamwZIXat14nQ-1; Mon, 11 Dec 2023 22:02:06 -0500
X-MC-Unique: UWOZ6AoFMEamwZIXat14nQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2866c800dd5so6186248a91.0
        for <virtualization@lists.linux-foundation.org>; Mon, 11 Dec 2023 19:02:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702350126; x=1702954926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NcUhW82kVg4Fgb3Dq1SvC66NLPOJJ84gCXl550jBOg=;
        b=JhKc2UKRGDSuCUDGSOM0QUGcIBGdsD9uhsCgYXmib+o41BvEygnq++AD+9xGmcGB2A
         qw7kIL6MhucdRzluiYLRVYTJWhnupm5rG2PW/HdZ/QUqtAideGFznOTrCA0jsWQzIKE7
         9AwAs1m2DpoSl+EEr4Tug+OcHmAnZCCI6roK7FTv1dxWtLWXAeLNastdOqKclT75bqRY
         JDO208Pk9BSmkOCdW/a4PS2Ggf1Jj9ckAXijinJk41YCReW9rM10KGFBU3Lz9qtgfzl7
         eYVmrVmMNG4RG3uNZQBMfMa5c3R7mFJgPOYjLx9FrzERdSfmUFygNC1IEx6vXNgclJaR
         UrjA==
X-Gm-Message-State: AOJu0YzhH2+1BEHokhbYEfCxlxzCzKdvn1W4R9ns0OS4/InHk3QVfxI+
	DKGjPXRqFlUbpgBYbZ2X9HpBLEFxaQV6L+XobCxb1OPiv0HB8qW/ul1iSvuJM9KgxXI206+do6r
	M3tkx444qND2U2xByHfX4MMjW5ehRi1siI3r2ft2RZMEK6q663dCVcDdBYQ==
X-Received: by 2002:a17:90b:152:b0:286:db83:a092 with SMTP id em18-20020a17090b015200b00286db83a092mr4170423pjb.20.1702350125889;
        Mon, 11 Dec 2023 19:02:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGo0L3DeFF6N2EfhNxrYtxwbIS2B3jOa/l8pkOd4cweE+LAc92ES33i4Vds/ETJ1R24YNUMPLgjbPbXCLyTOg=
X-Received: by 2002:a17:90b:152:b0:286:db83:a092 with SMTP id
 em18-20020a17090b015200b00286db83a092mr4170415pjb.20.1702350125585; Mon, 11
 Dec 2023 19:02:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231208070754.3132339-1-stevensd@chromium.org> <20231211113710-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231211113710-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Dec 2023 11:01:53 +0800
Message-ID: <CACGkMEs_MajTFxGVcK5R8oqQzTxuL4Pm=uUnOonDczWzqaucsw@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: Add support for no-reset virtio PCI PM
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Stevens <stevensd@chromium.org>, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 12:37=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Fri, Dec 08, 2023 at 04:07:54PM +0900, David Stevens wrote:
> > If a virtio_pci_device supports native PCI power management and has the
> > No_Soft_Reset bit set, then skip resetting and reinitializing the devic=
e
> > when suspending and restoring the device. This allows system-wide low
> > power states like s2idle to be used in systems with stateful virtio
> > devices that can't simply be re-initialized (e.g. virtio-fs).
> >
> > Signed-off-by: David Stevens <stevensd@chromium.org>
>
> tagged, thanks!
> I'm still debating with myself whether we can classify this
> as a bugfix ... better not risk it I guess.

It might be suitable if there's a hypervisor that advertises
no_soft_reset (but it seems Qemu doesn't).

Thanks

>
> > ---
> > v1 -> v2:
> >  - Check the No_Soft_Reset bit
> >
> >  drivers/virtio/virtio_pci_common.c | 34 +++++++++++++++++++++++++++++-
> >  1 file changed, 33 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio=
_pci_common.c
> > index c2524a7207cf..3a95ecaf12dc 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -492,8 +492,40 @@ static int virtio_pci_restore(struct device *dev)
> >       return virtio_device_restore(&vp_dev->vdev);
> >  }
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
> >  static const struct dev_pm_ops virtio_pci_pm_ops =3D {
> > -     SET_SYSTEM_SLEEP_PM_OPS(virtio_pci_freeze, virtio_pci_restore)
> > +     .suspend =3D virtio_pci_suspend,
> > +     .resume =3D virtio_pci_resume,
> > +     .freeze =3D virtio_pci_freeze,
> > +     .thaw =3D virtio_pci_restore,
> > +     .poweroff =3D virtio_pci_freeze,
> > +     .restore =3D virtio_pci_restore,
> >  };
> >  #endif
> >
> > --
> > 2.43.0.472.g3155946c3a-goog
>

