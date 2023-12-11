Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B402030A
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Dec 2023 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBj9SJ1Z"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9162D81E7A
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Dec 2023 07:27:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9162D81E7A
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JBj9SJ1Z
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jkDKJspuiToK
	for <virtualization@lists.linux-foundation.org>;
	Mon, 11 Dec 2023 07:27:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A66F381D5F
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Dec 2023 07:27:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A66F381D5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702279633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=heMUTgb5GaeOiDdKYyFVi6QpbUm0pw75w+l+VAumXBk=;
	b=JBj9SJ1ZpEkCZP0SSa8a+fORXVXo9kYm5haK66cc9BGR1WqE5Ncz/UvbCneWV+Z+84Dmc5
	BF3e4f4YsVysSa+SNV9Mu+VBsVmDEuc94ider2Skb+TPXN3UEnO+2sjq1X8mBSLBEu+iFH
	gFy0mdUCM+X500DsQYhMuDCPN9Bv5Zg=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-wqKCDCI_MT2hNEqrYdeuLg-1; Mon, 11 Dec 2023 02:27:11 -0500
X-MC-Unique: wqKCDCI_MT2hNEqrYdeuLg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6ce337ff87fso2526357b3a.0
        for <virtualization@lists.linux-foundation.org>; Sun, 10 Dec 2023 23:27:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702279631; x=1702884431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heMUTgb5GaeOiDdKYyFVi6QpbUm0pw75w+l+VAumXBk=;
        b=BO3ywmM1wGIyWPasAnqaX/3DRDdtgyinSTjy6eTW/fbEzN+7wREKH+W1OJ9xpL/9Zz
         wXkBGT6zBmVrX59J3rw+TMCHJ25/K5PssUa+3S/lMInalSqKEAUtnTtYHRLgywLXQaDA
         ngnEH9sc+2hOGV7CWzkfEPAGWklukpMR3wnZqRu5r5W0o759G4enhSyVPRM3gYz5cKUH
         uxdJWwM0K8aR3MaYviEN+8tahcJZ6uupJG35xy400G47Uxz36QDBV5iAI0MKvFMjSeWj
         Bt7lQtbipCyKFPmBTsnWmS907ffcdJe9AX15eVGTuKEc67gvbIGpI3KKM8jLNQbo2P8O
         udMQ==
X-Gm-Message-State: AOJu0YwoDwxrjK7/rBfBK4WIJIifsatjioKmOKaxF3PUQkVxqbEqVktZ
	npUVWhXhjOhlwePYmwJi3f4elM9x0E7M4Bv3+F0Qx0GgHfn1O+0GFqghBh1q+5EAGQH47dQuP38
	Mj097+lKdmRYtqMctOXv0qF3qaB22uPhsoBP/PHGYxLQUBNnnT+/WpF1j8A==
X-Received: by 2002:a05:6a21:1a3:b0:18f:e956:8332 with SMTP id le35-20020a056a2101a300b0018fe9568332mr5440551pzb.8.1702279630807;
        Sun, 10 Dec 2023 23:27:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwze31CQ0YmqHJ9TW/fpON2L8+D6Rtz1KtVRwdsq+25spKb3eYq8RHvwkd1mgitO/HmDDEBCjbgt5GrAs/TFQ=
X-Received: by 2002:a05:6a21:1a3:b0:18f:e956:8332 with SMTP id
 le35-20020a056a2101a300b0018fe9568332mr5440548pzb.8.1702279630504; Sun, 10
 Dec 2023 23:27:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231208070754.3132339-1-stevensd@chromium.org>
In-Reply-To: <20231208070754.3132339-1-stevensd@chromium.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Dec 2023 15:26:59 +0800
Message-ID: <CACGkMEsGK9oQrrYAe4Dp7q2R=dqz+hJdWDsamKywA87S3565Cw@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: Add support for no-reset virtio PCI PM
To: David Stevens <stevensd@chromium.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 3:09=E2=80=AFPM David Stevens <stevensd@chromium.org=
> wrote:
>
> If a virtio_pci_device supports native PCI power management and has the
> No_Soft_Reset bit set, then skip resetting and reinitializing the device
> when suspending and restoring the device. This allows system-wide low
> power states like s2idle to be used in systems with stateful virtio
> devices that can't simply be re-initialized (e.g. virtio-fs).
>
> Signed-off-by: David Stevens <stevensd@chromium.org>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
> v1 -> v2:
>  - Check the No_Soft_Reset bit
>
>  drivers/virtio/virtio_pci_common.c | 34 +++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_p=
ci_common.c
> index c2524a7207cf..3a95ecaf12dc 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -492,8 +492,40 @@ static int virtio_pci_restore(struct device *dev)
>         return virtio_device_restore(&vp_dev->vdev);
>  }
>
> +static bool vp_supports_pm_no_reset(struct device *dev)
> +{
> +       struct pci_dev *pci_dev =3D to_pci_dev(dev);
> +       u16 pmcsr;
> +
> +       if (!pci_dev->pm_cap)
> +               return false;
> +
> +       pci_read_config_word(pci_dev, pci_dev->pm_cap + PCI_PM_CTRL, &pmc=
sr);
> +       if (PCI_POSSIBLE_ERROR(pmcsr)) {
> +               dev_err(dev, "Unable to query pmcsr");
> +               return false;
> +       }
> +
> +       return pmcsr & PCI_PM_CTRL_NO_SOFT_RESET;
> +}
> +
> +static int virtio_pci_suspend(struct device *dev)
> +{
> +       return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_freeze(dev);
> +}
> +
> +static int virtio_pci_resume(struct device *dev)
> +{
> +       return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_restore(dev)=
;
> +}
> +
>  static const struct dev_pm_ops virtio_pci_pm_ops =3D {
> -       SET_SYSTEM_SLEEP_PM_OPS(virtio_pci_freeze, virtio_pci_restore)
> +       .suspend =3D virtio_pci_suspend,
> +       .resume =3D virtio_pci_resume,
> +       .freeze =3D virtio_pci_freeze,
> +       .thaw =3D virtio_pci_restore,
> +       .poweroff =3D virtio_pci_freeze,
> +       .restore =3D virtio_pci_restore,
>  };
>  #endif
>
> --
> 2.43.0.472.g3155946c3a-goog
>

