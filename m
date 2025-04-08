Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AED6267712
	for <virtualization@lists.linux.dev>; Tue,  8 Apr 2025 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108126; cv=none; b=bxUT4Gr0JwDa9+FHr2LQjm+xVDyD0MmDZoDAlJ98BO9Iv9WVoeeQv1dW8y2fuUhojoqMoBDtyyn/jfnheq4dOCi10lq6VrwrGxQSvhwquiNiyn0rb+QjwBD5ZDTfyb7L4vEVxNSJ9HZO9z/YfuUgubKWFtbUUTOCwFh4q/ShE8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108126; c=relaxed/simple;
	bh=/m6+Ua66NFMhg2vNP8D7cOPQD3B82lw7pQYHz/7iMJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaCKCGKDa0eu042U9655RMzcrWiweOh/3Ja62dPiKiTphGSBqSOKCwz3052LoyVCxkH9pEnfHN/MqRd+UxvjgoxUZPMELv4A2LqiduTqlaVycMtkDv4R2uJ+fQijzumww+fgu+qEAVAKzu/6h0Uy/YlbQyfvJUdqRJ7S81bpieU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47698757053so61620171cf.0
        for <virtualization@lists.linux.dev>; Tue, 08 Apr 2025 03:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744108124; x=1744712924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SsrLZDcWMMgz5qw73ZarBN4RUT9hrtTKFIK6rblk8+Q=;
        b=qdn9CHT7nddxVVEisp9fv1VCiQIG5IjrgrfdGJoyzbFJq9JQCf/kZFQdsvs4q3+n94
         wYpktynuzk5TCXZPuBCxsFFajAamq/cYJg3Y6DeyMN5FqruZzfe3bfPaYlCILjuwpJ+M
         BwajkRv1lvQzeb3lRfOLXzCt/CBXpouFNntIK7ccqAfn2xaKaTrnZAPYM/FC5SkMQF7R
         yBKr5yLmveRXMLPgK+i0zapM3lGXWx+2SLibHNi//l8cHLqYLuwfPCRJyltsrOVziMgu
         S6h9vFzbRoJTaKgqxSccOFISt4r+mVPxWeQ/MTXrqKqh5bEpk7wI566xViskgjgoAkid
         zoxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBr8Ic/BEDF78MaFgTmyXJJLhigPJ5qULjbWyF07UONOKHJmJ9yseSvsiNV7TNV59B5aFQqIyUoGHHpp6Ckw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEkSlamEJjphShNemyXD8nQmGCO5gst9K4pmUi+Zmf6ijEXyxr
	vFbd3nuuff8UEK/3EM8ANbpeGTFgib0Fm+St9kM+2uOmP40hTTVU1+r2LHLg
X-Gm-Gg: ASbGncvh5eQU/WSo4T+wDMGc9VfjC5m+ejUxsUSqW7IPASrRDNSXTmeJYPgPAbV2+st
	iH+LFhVaEzD2wdzNZ9WxCH8DZAsRNgkPKLBbVK4bVXiZh94rE/n575WeP7ltjUVYi7f0nP1rhd4
	IN0gwSRqb1K+a2gkGj1WZcQARn3zULd4+aqrzdRz2ZkNioXAHNdPMW/CNfMNDHisEYL8m242u6h
	G44uMtTmmZE4/uCdz8KSApmrRZv4lDw0bf+zRNGnfBzR8XQCqxCzFuNFjk4RuxMdqs1RkSORuiy
	f3H4vVQ0/mJXE2Ai+J3Y4QhuFP45hqaYf7mKeKgv9yv59D/GR6QHKSKMdDy/zpXF0vgf36OyFnr
	eDsSN4FWttr4=
X-Google-Smtp-Source: AGHT+IGwjH7YzROSjSG8cpTPBAo+Njk1brB2BvrH83LstRVPZbo6tg57elnkTkR4t/E5WjGrjmtzKg==
X-Received: by 2002:a05:622a:11d1:b0:476:67d8:930e with SMTP id d75a77b69052e-47925a433c0mr237405961cf.34.1744108124009;
        Tue, 08 Apr 2025 03:28:44 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4791b058546sm74273401cf.10.2025.04.08.03.28.43
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 03:28:43 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-476805acddaso63274121cf.1
        for <virtualization@lists.linux.dev>; Tue, 08 Apr 2025 03:28:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0+SefrA2X0VC/DJkkscXjZTZL1YN4O9rH4V9kjK9fOqTh24Eahgob6BMxGrRno+3/UlV+q2aO1gEQ3wfcTQ==@lists.linux.dev
X-Received: by 2002:a05:6102:2b91:b0:4c4:e415:6737 with SMTP id
 ada2fe7eead31-4c856a8cf46mr12241766137.23.1744107755579; Tue, 08 Apr 2025
 03:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250407104025.3421624-1-arnd@kernel.org>
In-Reply-To: <20250407104025.3421624-1-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Apr 2025 12:22:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWN=wurw7qz0t2ovMkUNu0BJRAMv_0U63Lqs2MGxkVnHw@mail.gmail.com>
X-Gm-Features: ATxdqUE9l7FjkqlZMDiGBpUM7CUSkyfcARh2bgkw-zOenNlQ3qLl0OOY1x_PRRI
Message-ID: <CAMuHMdWN=wurw7qz0t2ovMkUNu0BJRAMv_0U63Lqs2MGxkVnHw@mail.gmail.com>
Subject: Re: [RFC] PCI: add CONFIG_MMU dependency
To: Arnd Bergmann <arnd@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Carl Vanderlip <quic_carlv@quicinc.com>, 
	Oded Gabbay <ogabbay@kernel.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Dave Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>, 
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Xinliang Liu <xinliang.liu@linaro.org>, 
	Tian Tao <tiantao6@hisilicon.com>, Xinwei Kong <kong.kongxinwei@hisilicon.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Yongqin Liu <yongqin.liu@linaro.org>, 
	John Stultz <jstultz@google.com>, Sui Jingfeng <suijingfeng@loongson.cn>, 
	Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, 
	Zack Rusin <zack.rusin@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Saurav Kashyap <skashyap@marvell.com>, Javed Hasan <jhasan@marvell.com>, 
	GR-QLogic-Storage-Upstream@marvell.com, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Nilesh Javali <njavali@marvell.com>, 
	Manish Rangankar <mrangankar@marvell.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Javier Martinez Canillas <javierm@redhat.com>, 
	Jani Nikula <jani.nikula@intel.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Lijo Lazar <lijo.lazar@amd.com>, Niklas Schnelle <schnelle@linux.ibm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux1394-devel@lists.sourceforge.net, amd-gfx@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org, virtualization@lists.linux.dev, 
	spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org, 
	kvm@vger.kernel.org, Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

CC Gerg

On Mon, 7 Apr 2025 at 12:40, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> It turns out that there are no platforms that have PCI but don't have an MMU,
> so adding a Kconfig dependency on CONFIG_PCI simplifies build testing kernels
> for those platforms a lot, and avoids a lot of inadvertent build regressions.
>
> Add a dependency for CONFIG_PCI and remove all the ones for PCI specific
> device drivers that are currently marked not having it.
>
> Link: https://lore.kernel.org/lkml/a41f1b20-a76c-43d8-8c36-f12744327a54@app.fastmail.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -21,6 +21,7 @@ config GENERIC_PCI_IOMAP
>  menuconfig PCI
>         bool "PCI support"
>         depends on HAVE_PCI
> +       depends on MMU
>         help
>           This option enables support for the PCI local bus, including
>           support for PCI-X and the foundations for PCI Express support.

While having an MMU is a hardware feature, I consider disabling MMU
support software configuration.  So this change prevents people from
disabling MMU support on a system that has both a PCI bus and an MMU.
But other people may not agree, or care?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
