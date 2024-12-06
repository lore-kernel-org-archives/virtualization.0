Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710752F855
	for <virtualization@lists.linux.dev>; Fri,  6 Dec 2024 01:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733448337; cv=none; b=TZvqmuG4M5AOm7JEx+uIFeP9WXvX7XEYM59mBXnVA5mph6gaiYiSUbmlUY8eYDPK1U7htYCsN39DJpSQThsNL3D5fuWwsjbr02hk3doqPFXW9QqqXK7mA/AepThtwBW3Pfe9ilMIOIbEqk7l0fd8GhP2ggS0Llci1A5bmy1zEVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733448337; c=relaxed/simple;
	bh=zLAmk+CSNIIfq3xOOA6LXUW1i0SFDfq8y16QqT7+pwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TB7s+NwIxX8i8p8Aj0a+sTXfRiS/BHKpQwrnxu/s2AkODpYzCMng3Nd1kHz9/enVYowc0HByyyW7XynnBXG7bMIcCT0+9kJghkhTZQWvjKm0gO4X8Cr+V4cCr/0pOTcUg0Ai6eKPc1WFmoot8rsE3QlJe1A45CUsJLvPA5yIM8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OC25vmus; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OC25vmus"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733448333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bMJdMfEVxUjzOv6vViRajs+c2usHfla48Mpk2GLYF8c=;
	b=OC25vmuskMLpIaKr+61oYCBTq7Rw9WfDJrqgfKOdR/+GuvjH5YI63PZgIXpWiHLotfEfd7
	2TSJuzURdgJYe6k9DpUnSlJsd5vfocZJz48l5Iqa0gSv2bHqQE7rCaHI2+0JwkgYrLYUKr
	oTkO4IsBnlYA8uQQHX8p0upstcxoYIE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-o4Q57CEMM_qCmmq5vDIKgw-1; Thu, 05 Dec 2024 20:25:32 -0500
X-MC-Unique: o4Q57CEMM_qCmmq5vDIKgw-1
X-Mimecast-MFC-AGG-ID: o4Q57CEMM_qCmmq5vDIKgw
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ee6900147cso1584778a91.1
        for <virtualization@lists.linux.dev>; Thu, 05 Dec 2024 17:25:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733448331; x=1734053131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMJdMfEVxUjzOv6vViRajs+c2usHfla48Mpk2GLYF8c=;
        b=QJDPlzFPUlDNcFYxxaKqjT2wuSZu4IZgu/eyjh7/inTl78uqQYpfjE1FP8zkfbvyjX
         Clge6eoNqoDG0JsJiBwfMF8Ue+j8AX8BJxEikr6WYEU+hmBaq9IZbj1cflFMlG7ffG9Q
         jnNV2/SqOf1DAAyZRUJvxN5J8C+e8tkciZPqbOr30LaXdB/KyFK655RVssmFhY9e1zT8
         0hQIIfLEC3khVJ1cLTUF4Xg02Yiu4DSbx+i0ldCnl0tBH7pQ3QI+g1MGyBULgjjHbN4i
         N7fA915K2Po6p8LMLwiOg02UkTtwGCCpwLeAcRTwi8J6DEGhk8XjfIQlzEUVVACF7qAR
         5lIg==
X-Gm-Message-State: AOJu0YxKIs2bwaeXkTN3qtz9tmLiwYtroD+zsJIdsVmexNWUmp6gMYAM
	jSofUtF/oJgXPQoyGKTpLNNTlQFx41OKgL4mJTaoJLsG6yL0OIMP0W01tieG5xDnXReJChnK0DK
	6yi1V9Q7uZYytPKWQZP6oPo0u+kwTK+eDXIkx7BTvAGQ+L08ks3WnZRUCj4Q4+eeOUkxXbS9vZE
	1jB4kj1ms5VhSaKS/jXY5nsytKBiElwsWuN3dFrB4=
X-Gm-Gg: ASbGncvmBCNOW0G86A+q4B5ubu2PPN/esvf24+mi29+H16VRkgyDj5ayuLBh5Q+eLg3
	cI1JqnsRHflD7TC5A5XjAYGsQKahqSRxOoQ==
X-Received: by 2002:a17:90b:37c3:b0:2ee:aa95:6de9 with SMTP id 98e67ed59e1d1-2ef6ab29c33mr1941762a91.33.1733448331214;
        Thu, 05 Dec 2024 17:25:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBZdBWi/TRlcNmYZAEPvPbMydw1ulYuSuDmflFbW1IxATFoyHqvnEz+Poaku7S/hXpVfQTK1d5HluUjYC1DRM=
X-Received: by 2002:a17:90b:37c3:b0:2ee:aa95:6de9 with SMTP id
 98e67ed59e1d1-2ef6ab29c33mr1941722a91.33.1733448330793; Thu, 05 Dec 2024
 17:25:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241121134002.990285-1-sthotton@marvell.com>
In-Reply-To: <20241121134002.990285-1-sthotton@marvell.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 6 Dec 2024 09:25:19 +0800
Message-ID: <CACGkMEueyPOfgA4W72CMCZHP06fHw07PxbpvKzxm=O2udhRLxA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] vdpa/octeon_ep: enable support for multiple
 interrupts per device
To: Shijith Thotton <sthotton@marvell.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, dan.carpenter@linaro.org, 
	schalla@marvell.com, vattunuru@marvell.com, ndabilpuram@marvell.com, 
	jerinj@marvell.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Satha Rao <skoteshwar@marvell.com>, open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WqlWEd06ab22I-XxHGMktZ5ZzVqvZ2l1w2R70CS2jp0_1733448331
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 9:45=E2=80=AFPM Shijith Thotton <sthotton@marvell.c=
om> wrote:
>
> Updated the driver to utilize all the MSI-X interrupt vectors supported
> by each OCTEON endpoint VF, instead of relying on a single vector.
> Enabling more interrupts allows packets from multiple rings to be
> distributed across multiple cores, improving parallelism and
> performance.
>
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> ---
> v1:
> - https://lore.kernel.org/virtualization/20241120070508.789508-1-sthotton=
@marvell.com
>
> Changes in v2:
> - Handle reset getting called twice.
> - Use devm_kcalloc to allocate irq array.
> - IRQ is never zero. Adjusted code accordingly.
>
>  drivers/vdpa/octeon_ep/octep_vdpa.h      | 10 +--
>  drivers/vdpa/octeon_ep/octep_vdpa_hw.c   |  2 -
>  drivers/vdpa/octeon_ep/octep_vdpa_main.c | 90 ++++++++++++++++--------
>  3 files changed, 64 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa.h b/drivers/vdpa/octeon_ep=
/octep_vdpa.h
> index 046710ec4d42..2d4bb07f91b3 100644
> --- a/drivers/vdpa/octeon_ep/octep_vdpa.h
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa.h
> @@ -29,12 +29,12 @@
>  #define OCTEP_EPF_RINFO(x) (0x000209f0 | ((x) << 25))
>  #define OCTEP_VF_MBOX_DATA(x) (0x00010210 | ((x) << 17))
>  #define OCTEP_PF_MBOX_DATA(x) (0x00022000 | ((x) << 4))
> -
> -#define OCTEP_EPF_RINFO_RPVF(val) (((val) >> 32) & 0xF)
> -#define OCTEP_EPF_RINFO_NVFS(val) (((val) >> 48) & 0x7F)
> +#define OCTEP_VF_IN_CTRL(x)        (0x00010000 | ((x) << 17))
> +#define OCTEP_VF_IN_CTRL_RPVF(val) (((val) >> 48) & 0xF)
>
>  #define OCTEP_FW_READY_SIGNATURE0  0xFEEDFEED
>  #define OCTEP_FW_READY_SIGNATURE1  0x3355ffaa
> +#define OCTEP_MAX_CB_INTR          8
>
>  enum octep_vdpa_dev_status {
>         OCTEP_VDPA_DEV_STATUS_INVALID,
> @@ -50,7 +50,6 @@ struct octep_vring_info {
>         void __iomem *notify_addr;
>         u32 __iomem *cb_notify_addr;
>         phys_addr_t notify_pa;
> -       char msix_name[256];
>  };
>
>  struct octep_hw {
> @@ -68,7 +67,8 @@ struct octep_hw {
>         u64 features;
>         u16 nr_vring;
>         u32 config_size;
> -       int irq;
> +       int nb_irqs;
> +       int *irqs;
>  };
>
>  u8 octep_hw_get_status(struct octep_hw *oct_hw);
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c b/drivers/vdpa/octeon=
_ep/octep_vdpa_hw.c
> index 1d4767b33315..d5a599f87e18 100644
> --- a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> @@ -495,8 +495,6 @@ int octep_hw_caps_read(struct octep_hw *oct_hw, struc=
t pci_dev *pdev)
>         if (!oct_hw->vqs)
>                 return -ENOMEM;
>
> -       oct_hw->irq =3D -1;
> -
>         dev_info(&pdev->dev, "Device features : %llx\n", oct_hw->features=
);
>         dev_info(&pdev->dev, "Maximum queues : %u\n", oct_hw->nr_vring);
>
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octe=
on_ep/octep_vdpa_main.c
> index cd55b1aac151..e10cb26a3206 100644
> --- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> @@ -47,13 +47,30 @@ static struct octep_hw *vdpa_to_octep_hw(struct vdpa_=
device *vdpa_dev)
>  static irqreturn_t octep_vdpa_intr_handler(int irq, void *data)
>  {
>         struct octep_hw *oct_hw =3D data;
> -       int i;
> +       int i, ring_start, ring_stride;
> +
> +       /* Each device has multiple interrupts (nb_irqs) shared among rec=
eive
> +        * rings (nr_vring). Device interrupts are mapped to specific rec=
eive
> +        * rings in a round-robin fashion. Only rings handling receive
> +        * operations require interrupts, and these are at even indices.
> +        *
> +        * For example, if nb_irqs =3D 8 and nr_vring =3D 64:
> +        * 0 -> 0, 16, 32, 48;
> +        * 1 -> 2, 18, 34, 50;
> +        * ...
> +        * 7 -> 14, 30, 46, 62;
> +        */
> +       ring_start =3D (irq - oct_hw->irqs[0]) * 2;
> +       ring_stride =3D oct_hw->nb_irqs * 2;
>
> -       for (i =3D 0; i < oct_hw->nr_vring; i++) {
> -               if (oct_hw->vqs[i].cb.callback && ioread32(oct_hw->vqs[i]=
.cb_notify_addr)) {
> -                       /* Acknowledge the per queue notification to the =
device */
> +       for (i =3D ring_start; i < oct_hw->nr_vring; i +=3D ring_stride) =
{
> +               if (ioread32(oct_hw->vqs[i].cb_notify_addr)) {

Could oct_hw->vqs[i].cb_notify_addr change? If not, maybe we can cache
it somewhere to avoid the read here.

> +                       /* Acknowledge the per ring notification to the d=
evice */
>                         iowrite32(0, oct_hw->vqs[i].cb_notify_addr);
> -                       oct_hw->vqs[i].cb.callback(oct_hw->vqs[i].cb.priv=
ate);

Thanks

