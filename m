Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E12322E3E1
	for <virtualization@lists.linux-foundation.org>; Fri, 21 Mar 2025 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742585982; cv=none; b=lECsPVVfJx/Q2qcmzxScf8jiQ2EulVsVx5pc857IsoCrNdthq5VD6nOu3q/7xCs3fCSNO2VwuAVPuPz9lfI0nmbBf9U3UUXl1tx33tYuZo0MzSp2wHqClpuPFYZ45jmIvzrHILO1nZC3oa4XoU5v+ma7zzcCvsEHviHr/HWjbEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742585982; c=relaxed/simple;
	bh=8Yf2e58bOdkWki6r3N9zOG96lZWqklx3PpwjJDAqkTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=P3Ni/IpPPDIijcGs0BimLZYjnFADYCQISdfnVZcpAH33MCaF3d/DXO4UhY1s2i0GuP81D+f0Ah+L867ygYFEFl7m0v1BYy44NCNHKcDXg1zAjW2cog73G1b2KSHGpIWrb4i8PYniAf2sV6wPiPq1B3LbZy7/jXy0Vd8sZX0o9Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I7k8wTz6; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7k8wTz6"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6E95840F5
	for <virtualization@lists.linux-foundation.org>; Fri, 21 Mar 2025 19:39:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qAK1nCbcPTqZ for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Mar 2025 19:39:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2480484105
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2480484105
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I7k8wTz6
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2480484105
	for <virtualization@lists.linux-foundation.org>; Fri, 21 Mar 2025 19:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742585978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uaOk1vPVeha7q1Or366XeLotZcOIEZyeZ7CHH+BWos8=;
	b=I7k8wTz6DGIoikL1ryfCskvC4maiyjO9lDzgiSdrgROqwe/KlM1l0KIxxN5byGEzyxFVoA
	TkgEOCYkxLBSqNyNZJej/bc6qvePi1PZgOom8dEWZrsQri98S1oI8Qyox9Y4+wRqK01G0s
	Lno6CAK6yGrdoHh2klfgAyLQlhBz254=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-uWKzux-vOCGyDnZ7wRGMmg-1; Fri, 21 Mar 2025 15:39:37 -0400
X-MC-Unique: uWKzux-vOCGyDnZ7wRGMmg-1
X-Mimecast-MFC-AGG-ID: uWKzux-vOCGyDnZ7wRGMmg_1742585976
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3011cfa31f6so3835336a91.3
        for <virtualization@lists.linux-foundation.org>; Fri, 21 Mar 2025 12:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742585976; x=1743190776;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uaOk1vPVeha7q1Or366XeLotZcOIEZyeZ7CHH+BWos8=;
        b=p7Wg1r8GxiPss+P30B5dkElNI7d5bSBLVcyH1nmCxa4NFaBJhcO1A+G9yB34KlNzNy
         SQaH054EnegjuLeX2iNHBZTmjLmtVN8VGU0Q8xXwHPTaJFesF8pywPbcEi0hFsd3vkdk
         hF58acEauOsbT23xqTvdjKFk9byVGQa9Y2RlZsovsqznU9mOSAUABBsJCu38W1yugnVB
         8fZe1l7eLWYt+Dm3RnDT2pQsMjWKrxGWiLjLDvuWC8135D9ppWSAptWfK1gQy/a89kp0
         7v72+vk66OPpe9Yyg/K2eI1lwyuxyVJA5WMumXsYU2dWjLlAci2ZI62OrEtdisrkzGLX
         bFkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKpitfXkYb/5MhC+Fk3XHkO/raVbJx2OysRNIGD7EHwrwjjl2j6z2APbHJ/35g2Nn7NGHIf2vSISTWOCwsKw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzeIbx61PCJ2s26NC/tK+T+CH3+/+Op71ibL0wBOLnma3N39m6V
	ljySYb1RX72gYZrRKuK0RinOMYa7gWXEUpfj2NOzJJUX0yFvyaIzgJM9yfcasOYZM/xEgS1bcP/
	vgsyl8k6d9c1K0PCZcnyGQClstUJ8ZV7GiGw7lD4Yob7x9fVz3i8eZZV9ZVgpuV7frArjFUHHnd
	d2c3I=
X-Gm-Gg: ASbGncvXvY6rIKaws6G/Obr3caKly6MRq6rgpx+56ybZHYpr571/zGmbIom4XP2XHmJ
	RaYLWqEP2YCWFi7pvtdlHkyucmYnfvg+O2srRobDZ+Co5YOYFROBJ+qmmsMKi8/ErhyjD0dWgCX
	5KDncWnEtJpNEYKTkiPPFo08fmNdWKnzC07KDbPhBdRwOe5qBCrlmW/SjbeH6+tOHoGCFSPR0d+
	/MipRYpsIoHTXpQ8eJx95FGBevaxRLm0jkhkLoQl5KSfcJ1QOjYz9FUFzQuaYP1NlyoMKIamaed
	yc0Crgar
X-Received: by 2002:a05:6a20:3d84:b0:1f3:1d13:96b3 with SMTP id adf61e73a8af0-1fe42f08eacmr7029292637.5.1742585976114;
        Fri, 21 Mar 2025 12:39:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ9PwVrNT0IX4mEc55T4ElrcZWZgBTxmg9r86dv6Ws9U7gh7qZgMQ627xJ7/9/+AXMPCDGyg==
X-Received: by 2002:a05:6a20:3d84:b0:1f3:1d13:96b3 with SMTP id adf61e73a8af0-1fe42f08eacmr7029263637.5.1742585975610;
        Fri, 21 Mar 2025 12:39:35 -0700 (PDT)
Received: from redhat.com ([195.133.138.172])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a2a4792fsm2197397a12.71.2025.03.21.12.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 12:39:35 -0700 (PDT)
Date: Fri, 21 Mar 2025 15:39:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v7 8/8] vhost: Add a KConfig knob to enable IOCTL
 VHOST_FORK_FROM_OWNER
Message-ID: <20250321153829-mutt-send-email-mst@kernel.org>
References: <20250302143259.1221569-1-lulu@redhat.com>
 <20250302143259.1221569-9-lulu@redhat.com>
 <CACGkMEv7WdOds0D+QtfMSW86TNMAbjcdKvO1x623sLANkE5jig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEv7WdOds0D+QtfMSW86TNMAbjcdKvO1x623sLANkE5jig@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EjJmAZdcgt4brJnNqmKf-Gr-QUh8vFoMMFERXHE5cpI_1742585976
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Mar 03, 2025 at 01:52:06PM +0800, Jason Wang wrote:
> On Sun, Mar 2, 2025 at 10:34 PM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> > to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> > is disabled, and any attempt to use it will result in failure.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/Kconfig | 15 +++++++++++++++
> >  drivers/vhost/vhost.c | 11 +++++++++++
> >  2 files changed, 26 insertions(+)
> >
> > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > index b455d9ab6f3d..e5b9dcbf31b6 100644
> > --- a/drivers/vhost/Kconfig
> > +++ b/drivers/vhost/Kconfig
> > @@ -95,3 +95,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
> >           If unsure, say "N".
> >
> >  endif
> > +
> > +config VHOST_ENABLE_FORK_OWNER_IOCTL
> > +       bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
> > +       default n
> > +       help
> > +         This option enables the IOCTL VHOST_FORK_FROM_OWNER, which allows
> > +         userspace applications to modify the thread mode for vhost devices.
> > +
> > +          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set to `n`,
> > +          meaning the ioctl is disabled and any operation using this ioctl
> > +          will fail.
> > +          When the configuration is enabled (y), the ioctl becomes
> > +          available, allowing users to set the mode if needed.
> > +
> > +         If unsure, say "N".
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index fb0c7fb43f78..09e5e44dc516 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> >                 r = vhost_dev_set_owner(d);
> >                 goto done;
> >         }
> > +
> > +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> >         if (ioctl == VHOST_FORK_FROM_OWNER) {
> >                 u8 inherit_owner;
> >                 /*inherit_owner can only be modified before owner is set*/
> > @@ -2313,6 +2315,15 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> >                 r = 0;
> >                 goto done;
> >         }
> > +
> > +#else
> > +       if (ioctl == VHOST_FORK_FROM_OWNER) {
> > +               /* When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is 'n', return error */
> > +               r = -ENOTTY;
> > +               goto done;
> > +       }
> > +#endif
> > +
> >         /* You must be the owner to do anything else */
> >         r = vhost_dev_check_owner(d);
> >         if (r)
> > --
> > 2.45.0
> 
> Do we need to change the default value of the inhert_owner? For example:
> 
> #ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> inherit_owner = false;
> #else
> inherit_onwer = true;
> #endif
> 
> ?
> 
> Other patches look good to me.
> 
> Thanks


I think I agree with Cindy. kconfig just tells us whether the
ioctl is allowed. should not affect the default, if we want
a kconfig for default, it should be separate, but I doubt it.

> >

