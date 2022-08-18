Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7689CC00140
	for <virtualization@archiver.kernel.org>; Thu, 18 Aug 2022 08:05:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0223340168;
	Thu, 18 Aug 2022 08:05:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0223340168
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M33dqN/t
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PDdKpN68koC4; Thu, 18 Aug 2022 08:05:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8830040395;
	Thu, 18 Aug 2022 08:05:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8830040395
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 531C2C0032;
	Thu, 18 Aug 2022 08:05:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73BFEC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 08:05:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2FA6284001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 08:05:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2FA6284001
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=M33dqN/t
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z4Y2I-O0YHdI
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 08:05:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B1B2E83E43
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B1B2E83E43
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 08:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660809921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EEvqUcQmIj9/YAiae1HApl/DsVDoyFZBZ0Um99hdIHI=;
 b=M33dqN/tsMysZkoDwfOfxLUQ04x5H2i4anhx5uyC+fNl+bebJD930xnriDKhN0zVpG5iHm
 5YqRH6hFtVBabAIOQwoo0TIr/xNq5sQ88i5gkxj1T+wHZJYTk54DJUhdjtQsIRAzZTn5XE
 d8ZYsDA129HGv+WkfjVBvkNzk0pgH7Q=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-349-mj_IYKsqPM6yNJgt0qL1NA-1; Thu, 18 Aug 2022 04:05:20 -0400
X-MC-Unique: mj_IYKsqPM6yNJgt0qL1NA-1
Received: by mail-lj1-f197.google.com with SMTP id
 y11-20020a05651c220b00b0025e4bd7731fso271006ljq.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 01:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=EEvqUcQmIj9/YAiae1HApl/DsVDoyFZBZ0Um99hdIHI=;
 b=hQ2Lq+IQv3K8pOPN/fGAg3qZMVD10w5CZJwtl47McJKLSowBfTwoLO62UoCT+ojGil
 ae3j9eSpWDJow0ksWjlZuI23mZ64H22dKsbsU8YMwfgvE8o2gShNzybLTN2olE+0R6Nk
 SdNRscm6yR6ZzrBImuk8VlPdC4CmfOxpzgG9BsKyzqLjWQ7jW/mzaEPgPLqZZ9UBtQs3
 iVCGjHjck2vjknKyr+pCKIN+9ItU91w8UPCoMO3kUd8fKpidLhVnha14nvZPTZ/Ub5n/
 InaNtXqdk/Gq5wzUhqUo4DF0d0H00o2MUZL47S3dF56Xboidm3n4BFRTjSN3/Z/hiDfN
 pMYA==
X-Gm-Message-State: ACgBeo3g0/4mI4IHVzBTpfqN/PhsQE3opmFAf/PiGTVca1carJCWwCYo
 dkgLvBn/nkWOm5W+pORq7L6iccbH9dm8wU6Ty5A6l/W8Zx6L7ohXBZccX3Y9tXA28MsC85zYb6m
 YM80zZapkoxF/OduXBtropw6T6qREpwznGrfmVPDpTrnpEeUELHGglrByeg==
X-Received: by 2002:a2e:a983:0:b0:25f:f273:548e with SMTP id
 x3-20020a2ea983000000b0025ff273548emr501673ljq.141.1660809919399; 
 Thu, 18 Aug 2022 01:05:19 -0700 (PDT)
X-Google-Smtp-Source: AA6agR46k09nEp5PaxhgcHPz5gwgI+Ykd3f40dyd6/GHGaPhn/5mLrbuDJ2nPozxQfzCNGN6SkupyPLl1nyRciLhMUE=
X-Received: by 2002:a2e:a983:0:b0:25f:f273:548e with SMTP id
 x3-20020a2ea983000000b0025ff273548emr501666ljq.141.1660809919211; Thu, 18 Aug
 2022 01:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220817221956.1149183-1-stefanha@redhat.com>
In-Reply-To: <20220817221956.1149183-1-stefanha@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Aug 2022 16:05:08 +0800
Message-ID: <CACGkMEuVama8zsPmf48t0LwEor1-+ihzajeU3=PdYjKGafdg3g@mail.gmail.com>
Subject: Re: [PATCH] Documentation: add basic information on vDPA
To: Stefan Hajnoczi <stefanha@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Aug 18, 2022 at 6:20 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The vDPA driver framework is largely undocumented. Add a basic page that
> describes what vDPA is, where to get more information, and how to use
> the simulator for testing.
>
> In the future it would be nice to add an overview of the driver API as
> well as comprehensive doc comments.

+1

>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  Documentation/driver-api/index.rst |  1 +
>  Documentation/driver-api/vdpa.rst  | 40 ++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
>  create mode 100644 Documentation/driver-api/vdpa.rst
>
> diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
> index d3a58f77328e..e307779568d4 100644
> --- a/Documentation/driver-api/index.rst
> +++ b/Documentation/driver-api/index.rst
> @@ -103,6 +103,7 @@ available subsections can be seen below.
>     switchtec
>     sync_file
>     tty/index
> +   vdpa
>     vfio-mediated-device
>     vfio
>     vfio-pci-device-specific-driver-acceptance
> diff --git a/Documentation/driver-api/vdpa.rst b/Documentation/driver-api/vdpa.rst
> new file mode 100644
> index 000000000000..75c666548e1d
> --- /dev/null
> +++ b/Documentation/driver-api/vdpa.rst
> @@ -0,0 +1,40 @@
> +====================================
> +vDPA - VIRTIO Data Path Acceleration
> +====================================
> +
> +The vDPA driver framework can be used to implement VIRTIO devices that are
> +backed by physical hardware or by software. While the device's data path
> +complies with the VIRTIO specification, the control path is driver-specific and
> +a netlink interface exists for instantiating devices.
> +
> +vDPA devices can be attached to the kernel's VIRTIO device drivers or exposed
> +to userspace emulators/virtualizers such as QEMU through vhost.
> +
> +The driver API is not documented beyond the doc comments in <linux/vdpa.h>. The
> +netlink API is not documented beyond the doc comments in <linux/uapi/vdpa.h>.
> +The existing vDPA drivers serve as reference code for those wishing to develop
> +their own drivers.
> +
> +See https://vdpa-dev.gitlab.io/ for more information about vDPA.
> +
> +Questions can be sent to the virtualization@lists.linux-foundation.org mailing
> +list.
> +
> +Device simulators
> +-----------------
> +
> +There are software vDPA device simulators for testing, prototyping, and
> +development purposes. The simulators do not require physical hardware.
> +
> +Available simulators include:
> +
> +- `vdpa_sim_net` implements a virtio-net loopback device.
> +- `vdpa_sim_blk` implements a memory-backed virtio-blk device.
> +
> +To use `vdpa_sim_blk` through vhost::
> +
> +  # modprobe vhost_vdpa
> +  # modprobe vdpa_sim_blk
> +  # vdpa dev add name vdpa-blk1 mgmtdev vdpasim_blk
> +  ...use /dev/vhost-dev-0...
> +  # vdpa dev del vdpa-blk1
> --
> 2.37.2
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
