Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080E0256C7D
	for <virtualization@lists.linux-foundation.org>; Wed, 23 Apr 2025 01:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745370110; cv=none; b=ZAAYxE50roGUlh+bJMEcjE3JSZBeJH948j/g8Ay4sIJOwecRp/izxlUFagcFIBg9ME8be+btYxMx2wWF24x5NMXeK/7VzTrzbSmFRurGMvwxdbiDeakiviPjv1hLurfTwW8pQSs+rhR/xg1XWUXY7bJF0k91a/5lyz6tguQHWUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745370110; c=relaxed/simple;
	bh=y4+VmnBCPOFdbmvjAoCJyBhIVZ7F2LWAXF/xQBnUmV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tyUqBZ/Uc8Xa6zuLIag2b/kNIZL4CJYpU5F2cf/OdAZ/6nA4BSPWDJd/2dro+4PpGoJahwvkFmr/VdgYnsD0zyoQ59t4csWlAX4s+TrcN7MasCBeAzLQ+EEsc0WxC68AcT15Rr/fp4T59AkTpn7VU5NtKaBy1CM3boRQn9eH/gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vwv1ODOM; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vwv1ODOM"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FC62605E7
	for <virtualization@lists.linux-foundation.org>; Wed, 23 Apr 2025 01:01:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kdV-FjKP9Tfk for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Apr 2025 01:01:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C01E4600B3
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C01E4600B3
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vwv1ODOM
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C01E4600B3
	for <virtualization@lists.linux-foundation.org>; Wed, 23 Apr 2025 01:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745370105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=suLnBGeG8Dzs3RiMxqx0Nd3yTcCcCMOBUwV5pRHCsPQ=;
	b=Vwv1ODOMPz8OT/nKtWoVvTK8ah6D3tKmp8RucZ2Sc/pzPc5McUJOhGT95bf2t8lsD91L/C
	4v5El1yR43ov52ikj04DuiOnQV3/bOBLRxfSV5T2VsxZGkUN0TFHi+VPOE4WvH8U5kvZ58
	30+HoJI4EDKaUigM+rZT+Lf8LGOAOQs=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-ylhY8eNqOJmQih4spzMjeQ-1; Tue, 22 Apr 2025 21:01:41 -0400
X-MC-Unique: ylhY8eNqOJmQih4spzMjeQ-1
X-Mimecast-MFC-AGG-ID: ylhY8eNqOJmQih4spzMjeQ_1745370100
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-523ef27785aso1317062e0c.1
        for <virtualization@lists.linux-foundation.org>; Tue, 22 Apr 2025 18:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745370100; x=1745974900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=suLnBGeG8Dzs3RiMxqx0Nd3yTcCcCMOBUwV5pRHCsPQ=;
        b=uCCxA+qUWsML5aT+Gk0sqxwMJ2r1yIW/YWMRFia5DTlYqQs6ioS2KT1l4D+gET2n5y
         lePB9p/IZ34qNYBEBmg3QqHB9fNaCuMsZnxIkHztcVRGxajxw2geWVFICYYZ4vJa/wPq
         srSoTJ0WNySB5Hmllvd+Zg09HCZ4obwV6Izlyln6pZOm7A+mJxaEUqYI6tWZ3rjcqDoK
         wJprQeDXiAOcGC2Nt6DnFCbfkQDBNXp8cfctOAjcSMy/EBpjotvzNDwGX83B0hQHSW+8
         RdIObO/ins3L+AfY5MZVu4QCM6Y30W7zu/1dqgJBWIM9wxMDCvRBnD8mXFTcfX0LPlca
         LJGA==
X-Forwarded-Encrypted: i=1; AJvYcCXeHd88cSenqKjXnUtVySoiqRswoaDZmN8ZH4q+BUcItb5qPAyUUUtMLP2Ch6+u7/m9REwbe2zARUsbPTeFhw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yzq/zTEK+NwBUQTbpBBz7kuEuVde3lg5tzqxQ10n+m8cy/5X4SR
	z9yuAQ879/blUDMK5pp2iUHYPGuqhw2XISu2lF+8JUUPHl+z+FHdUN2hH7sharSGgW8Bbx0rEuO
	/9szEIGYszmMCVewfDOyzg7ZtE2BszBxZTZWWGvL0nSR2G/TmPnrYQFYioClODH5hLF3IgrTuV+
	3xDftbGbT0Jw2nNX2JggmVDOwZIJDg7c0Zx6WJXlWo4giI2UmkFjvnaA==
X-Gm-Gg: ASbGncuQPWFxYswSfOPPYFzTSsXSs+QwacaEwc8xImoadZsLS9K2I8NpVTJlx3OBsVt
	8+4Y77aWHCKheZRGmnzMPxUEdMzafpsRnbp0ZkXujT8goDgg8lFyj6w5/hFQ4/yVp9dIkkg==
X-Received: by 2002:a05:6122:845:b0:529:2644:76bf with SMTP id 71dfb90a1353d-52926447a6emr10277478e0c.9.1745370100535;
        Tue, 22 Apr 2025 18:01:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvbJCqStjpUJNcZsRJqdDhzCFeNoakSOeF9eWWWREDdOPwaj5kbrY2hywj7CHtE2jo8yhRHUx16ZSWPen1OD8=
X-Received: by 2002:a05:6122:845:b0:529:2644:76bf with SMTP id
 71dfb90a1353d-52926447a6emr10277435e0c.9.1745370100250; Tue, 22 Apr 2025
 18:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250421024457.112163-1-lulu@redhat.com> <20250421024457.112163-5-lulu@redhat.com>
 <4xh3i7qikqiffxocxms4wfplg4tvemnszvywmtpkfyiqvq3age@jcq3aqvumig2>
In-Reply-To: <4xh3i7qikqiffxocxms4wfplg4tvemnszvywmtpkfyiqvq3age@jcq3aqvumig2>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 23 Apr 2025 09:01:03 +0800
X-Gm-Features: ATxdqUFDeBhiQEseub1vErKUpOwvixR2h27usGyemXjbTXL31lTjXbacVPQH1vs
Message-ID: <CACLfguXocCF0dUrM9k2YvZz0fuC4=3dYmbh3h7gpUZQ2ASF3zA@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VscSFGwQv5nio7rOuqAfcdvclPlYnfKvktQ9yk6lXX0_1745370100
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 9:50=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Mon, Apr 21, 2025 at 10:44:10AM +0800, Cindy Lu wrote:
> >Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> >to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> >When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> >is disabled, and any attempt to use it will result in failure.
> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/Kconfig | 15 +++++++++++++++
> > drivers/vhost/vhost.c |  3 +++
> > 2 files changed, 18 insertions(+)
> >
> >diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> >index 020d4fbb947c..bc8fadb06f98 100644
> >--- a/drivers/vhost/Kconfig
> >+++ b/drivers/vhost/Kconfig
> >@@ -96,3 +96,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
> >         If unsure, say "N".
> >
> > endif
> >+
> >+config VHOST_ENABLE_FORK_OWNER_IOCTL
> >+      bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
> >+      default n
> >+      help
> >+        This option enables the IOCTL VHOST_FORK_FROM_OWNER, which allo=
ws
> >+        userspace applications to modify the thread mode for vhost devi=
ces.
> >+
> >+          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set to =
`n`,
> >+          meaning the ioctl is disabled and any operation using this io=
ctl
> >+          will fail.
> >+          When the configuration is enabled (y), the ioctl becomes
> >+          available, allowing users to set the mode if needed.
>
> I think I already pointed out, but here there is a mix of tabs and
> spaces that IMHO we should fix.
>
Sorry, I missed this comment while preparing the patch; I=E2=80=99ll fix it=
.
> >+
> >+        If unsure, say "N".
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index fb0c7fb43f78..568e43cb54a9 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned=
 int ioctl, void __user *argp)
> >               r =3D vhost_dev_set_owner(d);
> >               goto done;
> >       }
> >+
> >+#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
>
> As I mentioned in the previous version, IMO this patch should be merged
> with the previous patch. I don't think it is good for bisection to have
> a commit with an IOCTL supported in any case and in the next commit
> instead supported only through a config.
>
> Maybe I'm missing something, but what's the point of having a separate
> patch for this?
>
> Thanks,
> Stefano
>
will fix this
thanks
cindy
> >       if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> >               u8 inherit_owner;
> >               /*inherit_owner can only be modified before owner is set*=
/
> >@@ -2313,6 +2315,7 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned=
 int ioctl, void __user *argp)
> >               r =3D 0;
> >               goto done;
> >       }
> >+#endif
> >       /* You must be the owner to do anything else */
> >       r =3D vhost_dev_check_owner(d);
> >       if (r)
> >--
> >2.45.0
> >
>

