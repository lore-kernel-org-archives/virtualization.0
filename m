Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC69C38145
	for <virtualization@archiver.kernel.org>; Tue,  6 Sep 2022 09:46:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2AC4740BB0;
	Tue,  6 Sep 2022 09:46:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2AC4740BB0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 85OznjFY3sFB; Tue,  6 Sep 2022 09:46:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8A0E2400E7;
	Tue,  6 Sep 2022 09:46:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8A0E2400E7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6CA8DC0033;
	Tue,  6 Sep 2022 09:46:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5ABC5C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 09:46:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2679B417B7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 09:46:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2679B417B7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n1cEX1jPx1mW
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 09:46:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 91B244179E
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 91B244179E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Sep 2022 09:46:32 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0VOpbTla_1662457586; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VOpbTla_1662457586) by smtp.aliyun-inc.com;
 Tue, 06 Sep 2022 17:46:27 +0800
Message-ID: <1662457569.3934484-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] Documentation: add basic information on vDPA
Date: Tue, 6 Sep 2022 17:46:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20220817221956.1149183-1-stefanha@redhat.com>
In-Reply-To: <20220817221956.1149183-1-stefanha@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, 17 Aug 2022 18:19:56 -0400, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The vDPA driver framework is largely undocumented. Add a basic page that
> describes what vDPA is, where to get more information, and how to use
> the simulator for testing.
>
> In the future it would be nice to add an overview of the driver API as
> well as comprehensive doc comments.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

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
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
