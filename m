Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DB22EEE65
	for <virtualization@lists.linux.dev>; Thu, 25 Jun 2026 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396349; cv=none; b=p7ZcbNG6zE7kID38SbPbqDdB4UBZXn2zssC8Wlimo9nT2E8grXyILuueDQTQfMe0dw545r3klU4CroOK19a4fVrdj9x07wWOcRxKNdEDi1+g2vIIWf9ukcR4Ej2YYf0HM2tzL0dw5XQs5hbeTFretKK1EBVIV1iEX+GnPn7MXYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396349; c=relaxed/simple;
	bh=EzCJmvkF32NeoECzTzTb4mMaXcdTH7GHIf1Gnqdps30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gs/r0T0wXui9koFgsElN2JkFzbTstiJu3BsUEYg9QPwu6YfPnrPBPvXj3fqJ7oa072PFVAyUZDV+1+4Wj4A2Lko0HRx8YTCx27ya33DB81GU5BwDWUKtJE16QbVn12FY6/ofLnGdHgiTLTidXd+mJdLW+DSqTRn7ZGkMN0bCzrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NAVKF3Q3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAVKF3Q3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782396346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4kivMSTgreRdnXzlmvIzuRSVNtW0E5n9l4kLwSipR2o=;
	b=NAVKF3Q3p+ZPr1lsls0OhWODFdN1Htxb71vKIo4AGbwOKraKMvuMw9QTF/RAJ+SLv+y4RH
	RR+JMTxucz7cSrqpavLejshC6X+/WMYVIUTYjBm40A3jGKF3jDEO18thzFBzQ/pp19adQA
	3uENAdtn09Xk00rM9Te3DNGYs+rsP1Y=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-5k8IgP2hMZOyCdF-G-Mweg-1; Thu, 25 Jun 2026 10:05:45 -0400
X-MC-Unique: 5k8IgP2hMZOyCdF-G-Mweg-1
X-Mimecast-MFC-AGG-ID: 5k8IgP2hMZOyCdF-G-Mweg_1782396344
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-662ba134bf9so1796551d50.1
        for <virtualization@lists.linux.dev>; Thu, 25 Jun 2026 07:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782396344; x=1783001144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4kivMSTgreRdnXzlmvIzuRSVNtW0E5n9l4kLwSipR2o=;
        b=rZv1vKl57pVrNFpoZIWE/RkA37IikMRDhaEZSN65t/WmnA8EqQTFIj4VidQw8QsEml
         A426HB7kZmZkNtmpbSomnfi8XDMXiNyEjvoQA3Q/vopPbr8j9Og9SE7X1BecyFOc4oBM
         vF+ruHWMYr1G+OSlVB/nGZd8Ie+exrOS9GFPaDCHzi1FeS0chnP5gmU2Zf/a+KuYunnd
         6UqcP6k9nGibC2E4R76U3wrd1SUQQuuu8yBQZFGxzXmK15epPt2EAI1Cr1AqYqRV7FSH
         tmsMb9AK3ptIiiROO/zWc3awQdIFzgbkGt/Yc0yGn5CQEnQTsib7uxDIOWOMYvaZ6vrN
         g8xg==
X-Forwarded-Encrypted: i=1; AHgh+Rq5Txup0RB/0BShfENokUAy5+fvcyws3rOSJ/HYumewfZRjU0KHcIB8l9V+EQIeTJfjp/KMGoBLDnTmEFSRDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzsu7t/BqwLMxr1hpldtjmpSfB30YNE7S/r0hP01YNEIdTls/rr
	sMlwv1IkQ/lbqy8/kSEilge+tMBN9qgGzmPH/Oz6lMRiwrXBR6CStEulzaO8KUgJ655qNkEH+0+
	YLpP1WmVFvJbc/S7Ws4IdwI2TvDSkKrA3hW/YzlL7VyS6l54ZKuxTpTiAPC/w1Pzb0nJWP8a9uV
	kab/evNrBLj/YBRbQySTGFNoHIzqVIp21sIyhVuq1vSqU=
X-Gm-Gg: AfdE7clO0L1Cx1DHICk+X8KzlY7OVbMyJB7XPOJ1ZeYahqhzbinFX6WeuVYFvQmoKLc
	t0RLJlDfaksWbxTjVUuiQvcjkoUkqpv1XBd+uDWfXjkX+G1Dqy63L5KHyodwskTH6KqkMD8mUkT
	8WpX2yHhTGAyhduuTVQWIMUVDPjlJv2K00cfcB2uF47Qr0vWqIQo3wcfv4WLsDfQliRgM=
X-Received: by 2002:a05:690e:1511:b0:663:271f:6d7e with SMTP id 956f58d0204a3-66487a81a9dmr1832213d50.31.1782396344297;
        Thu, 25 Jun 2026 07:05:44 -0700 (PDT)
X-Received: by 2002:a05:690e:1511:b0:663:271f:6d7e with SMTP id
 956f58d0204a3-66487a81a9dmr1832146d50.31.1782396343623; Thu, 25 Jun 2026
 07:05:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260618095642.510565-1-chenyichong@uniontech.com> <84157955DFE4842D+20260618095642.510565-2-chenyichong@uniontech.com>
In-Reply-To: <84157955DFE4842D+20260618095642.510565-2-chenyichong@uniontech.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 25 Jun 2026 16:05:07 +0200
X-Gm-Features: AVVi8CdiMpzMl64VumRhVyiv0b0g5TPRdL0fzn6G3qqcleWIIgicOLxJ0ISOtiE
Message-ID: <CAJaqyWc3jR5vtp6vG9b5i85jgohXtcMh2KhAn2eZEzqPX5Ks=Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools/virtio: Add missing compat definitions for vhost_net_test
To: Yichong Chen <chenyichong@uniontech.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	rppt@kernel.org, ljs@kernel.org, akpm@linux-foundation.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6oG69TERA3Swp3m4OPFxzGiXCyKWmWE56WT3a-5Kf3E_1782396344
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 11:59=E2=80=AFAM Yichong Chen <chenyichong@uniontec=
h.com> wrote:
>
> vhost_net_test builds virtio_ring.c in userspace.
>
> Recent virtio headers pull in new helper headers.
>
> They also use new allocation helpers and a DMA attribute.
>
> Add the missing compat definitions.
>

I'm all in with this patch but it still misses some headers, could you
check again with latest master?

$ make vhost_net_test
cc -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I
../../usr/include/ -Wno-pointer-sign -fno-strict-overflow
-fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include
../../include/linux/kconfig.h -mfunction-return=3Dthunk
-fcf-protection=3Dnone -mindirect-branch-register -pthread   -c -o
virtio_ring.o ../../drivers/virtio/virtio_ring.c
In file included from ./linux/compiler.h:7,
                 from ./linux/kernel.h:12,
                 from ./linux/scatterlist.h:4,
                 from ./../../include/linux/virtio.h:7,
                 from ./linux/virtio.h:1,
                 from ../../drivers/virtio/virtio_ring.c:6:
./linux/../../../include/linux/compiler_types.h:638:10: fatal error:
asm/percpu_types.h: No such file or directory
  638 | #include <asm/percpu_types.h>
      |          ^~~~~~~~~~~~~~~~~~~~
compilation terminated.
make: *** [<builtin>: virtio_ring.o] Error 1

> Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
> ---
>  tools/virtio/linux/completion.h      |  9 +++++
>  tools/virtio/linux/device.h          |  1 +
>  tools/virtio/linux/dma-mapping.h     |  1 +
>  tools/virtio/linux/mod_devicetable.h | 14 +++++++
>  tools/virtio/linux/slab.h            |  4 ++
>  tools/virtio/linux/virtio_features.h | 56 ++++++++++++++++++++++++++++
>  6 files changed, 85 insertions(+)
>  create mode 100644 tools/virtio/linux/completion.h
>  create mode 100644 tools/virtio/linux/mod_devicetable.h
>  create mode 100644 tools/virtio/linux/virtio_features.h
>
> diff --git a/tools/virtio/linux/completion.h b/tools/virtio/linux/complet=
ion.h
> new file mode 100644
> index 000000000000..5e54b679721b
> --- /dev/null
> +++ b/tools/virtio/linux/completion.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_COMPLETION_H
> +#define _LINUX_COMPLETION_H
> +
> +struct completion {
> +       unsigned int done;
> +};
> +
> +#endif /* _LINUX_COMPLETION_H */
> diff --git a/tools/virtio/linux/device.h b/tools/virtio/linux/device.h
> index 075c2140d975..abf100cb0023 100644
> --- a/tools/virtio/linux/device.h
> +++ b/tools/virtio/linux/device.h
> @@ -1,4 +1,5 @@
>  #ifndef LINUX_DEVICE_H
> +#define LINUX_DEVICE_H
>
>  struct device {
>         void *parent;
> diff --git a/tools/virtio/linux/dma-mapping.h b/tools/virtio/linux/dma-ma=
pping.h
> index fddfa2fbb276..65e2974b3908 100644
> --- a/tools/virtio/linux/dma-mapping.h
> +++ b/tools/virtio/linux/dma-mapping.h
> @@ -59,5 +59,6 @@ enum dma_data_direction {
>   * instead.
>   */
>  #define DMA_MAPPING_ERROR              (~(dma_addr_t)0)
> +#define DMA_ATTR_DEBUGGING_IGNORE_CACHELINES   0
>
>  #endif
> diff --git a/tools/virtio/linux/mod_devicetable.h b/tools/virtio/linux/mo=
d_devicetable.h
> new file mode 100644
> index 000000000000..3ba594b8229d
> --- /dev/null
> +++ b/tools/virtio/linux/mod_devicetable.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_MOD_DEVICETABLE_H
> +#define _LINUX_MOD_DEVICETABLE_H
> +
> +#include <linux/types.h>
> +
> +struct virtio_device_id {
> +       __u32 device;
> +       __u32 vendor;
> +};
> +
> +#define VIRTIO_DEV_ANY_ID      0xffffffff
> +
> +#endif /* _LINUX_MOD_DEVICETABLE_H */
> diff --git a/tools/virtio/linux/slab.h b/tools/virtio/linux/slab.h
> index 319dcaa07755..13d94c6f663c 100644
> --- a/tools/virtio/linux/slab.h
> +++ b/tools/virtio/linux/slab.h
> @@ -4,4 +4,8 @@
>  #define GFP_ATOMIC 0
>  #define __GFP_NOWARN 0
>  #define __GFP_ZERO 0
> +#define kmalloc_obj(VAR_OR_TYPE, ...) \
> +       kmalloc(sizeof(VAR_OR_TYPE), GFP_KERNEL)
> +#define kmalloc_objs(VAR_OR_TYPE, COUNT, ...) \
> +       kmalloc_array((COUNT), sizeof(VAR_OR_TYPE), GFP_KERNEL)
>  #endif
> diff --git a/tools/virtio/linux/virtio_features.h b/tools/virtio/linux/vi=
rtio_features.h
> new file mode 100644
> index 000000000000..18c56610e209
> --- /dev/null
> +++ b/tools/virtio/linux/virtio_features.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_VIRTIO_FEATURES_H
> +#define _LINUX_VIRTIO_FEATURES_H
> +
> +#include <linux/bug.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +
> +#define VIRTIO_FEATURES_U64S   2
> +#define VIRTIO_FEATURES_BITS   (VIRTIO_FEATURES_U64S * 64)
> +
> +#define VIRTIO_BIT(b)          (1ULL << ((b) & 0x3f))
> +#define VIRTIO_U64(b)          ((b) >> 6)
> +
> +#define VIRTIO_DECLARE_FEATURES(name)                  \
> +       union {                                         \
> +               u64 name;                                       \
> +               u64 name##_array[VIRTIO_FEATURES_U64S]; \
> +       }
> +
> +static inline bool virtio_features_chk_bit(unsigned int bit)
> +{
> +       return bit < VIRTIO_FEATURES_BITS;
> +}
> +
> +static inline bool virtio_features_test_bit(const u64 *features,
> +                                           unsigned int bit)
> +{
> +       return virtio_features_chk_bit(bit) &&
> +              !!(features[VIRTIO_U64(bit)] & VIRTIO_BIT(bit));
> +}
> +
> +static inline void virtio_features_set_bit(u64 *features, unsigned int b=
it)
> +{
> +       if (virtio_features_chk_bit(bit))
> +               features[VIRTIO_U64(bit)] |=3D VIRTIO_BIT(bit);
> +}
> +
> +static inline void virtio_features_clear_bit(u64 *features, unsigned int=
 bit)
> +{
> +       if (virtio_features_chk_bit(bit))
> +               features[VIRTIO_U64(bit)] &=3D ~VIRTIO_BIT(bit);
> +}
> +
> +static inline void virtio_features_zero(u64 *features)
> +{
> +       memset(features, 0, sizeof(features[0]) * VIRTIO_FEATURES_U64S);
> +}
> +
> +static inline void virtio_features_from_u64(u64 *features, u64 from)
> +{
> +       virtio_features_zero(features);
> +       features[0] =3D from;
> +}
> +
> +#endif /* _LINUX_VIRTIO_FEATURES_H */
> --
> 2.51.0
>

