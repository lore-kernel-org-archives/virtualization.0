Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3A6CCA479
	for <virtualization@archiver.kernel.org>; Tue, 28 Jun 2022 13:45:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ADE3740C1A;
	Tue, 28 Jun 2022 13:45:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ADE3740C1A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FqkcpVbN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JSwR56XBKPrB; Tue, 28 Jun 2022 13:45:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EEB9F40217;
	Tue, 28 Jun 2022 13:44:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EEB9F40217
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE71FC0032;
	Tue, 28 Jun 2022 13:44:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 013DCC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 13:44:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C1BB382BF5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 13:44:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C1BB382BF5
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FqkcpVbN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c_Fe5aFQakBA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 13:44:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED5F682BC4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED5F682BC4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 13:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656423895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hTKU2Np09ZtKabep+TfxXVYS1Y9DSz+czzdyoC+zeWM=;
 b=FqkcpVbNyE3PykaWV5LpDkeT30c5CsOqBHsIgd326vIS2+yxpJ67uQpVKWqP9K0MKFlZDn
 HWcW0jIGlUaZHWPGBTdixLUmvCvAQKKF5fIZ3lgztuTwaNhbNQ5qEsrmqULEU3LNKpUSW1
 evKVCcfKze2C5c2vo9LDn/R8g9bgrck=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-XVI1g1P7MYG5JTto5XF7Jg-1; Tue, 28 Jun 2022 09:44:51 -0400
X-MC-Unique: XVI1g1P7MYG5JTto5XF7Jg-1
Received: by mail-wr1-f71.google.com with SMTP id
 w12-20020adf8bcc000000b0021d20a5b24fso405104wra.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=hTKU2Np09ZtKabep+TfxXVYS1Y9DSz+czzdyoC+zeWM=;
 b=G0/ivuLNnJQY68rpqOmDOLOMhg4riGfspm/Wjau/taX3mpvzKAWawr2UNv7ur7Ch9S
 7KXr8cfie4lwzG8C2b7A3GywdmaaThI5Fny6xU0LNWUdJD3CgK9Koh/khkfs9KmKcMm3
 4KXmhiWWc7VXeO79oyVgshN353wmDwl2tKF19aro+nwDKC7ABkfhSWzCyNu6H6ZSdMUN
 n/NgQZj+baePLs67QPipOY9iR8aLeeZiD2h8tlwrNKCRvYbwZBWFn40FsBfAO8l4ZxGz
 IwiV5Ac7anYBQBb88Aem+U3voXC4XcGljfoHXFYSusOOaIlGLSxXMcIACj1v5/2EN0N+
 LTsA==
X-Gm-Message-State: AJIora+UcVl/h8L16LzRBwMFwmqgN/U8nalIMaao3SBsyNY27VPuDcEX
 u5Xcy9jiaI7tb1VSLTU1j2J7KqSGEyQ1vJXugm5iadwZeN6jBUZ/05G7es9qqeEuK+ZjSQFhJ79
 wyRdduxR0IRToOgHSq01rtIiY+VXBEP7nQIPsTGNiNg==
X-Received: by 2002:a05:6000:79e:b0:21b:bc0a:99d4 with SMTP id
 bu30-20020a056000079e00b0021bbc0a99d4mr17240193wrb.565.1656423890337; 
 Tue, 28 Jun 2022 06:44:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sPWXFvUvtzyxCMk9Gd6kxz02V2LWzAokqDn4AqQ5aZX6+OSB5A0LtPAjU3qDMm4YViNyvqeQ==
X-Received: by 2002:a05:6000:79e:b0:21b:bc0a:99d4 with SMTP id
 bu30-20020a056000079e00b0021bbc0a99d4mr17240143wrb.565.1656423890092; 
 Tue, 28 Jun 2022 06:44:50 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-149.retail.telecomitalia.it.
 [87.11.6.149]) by smtp.gmail.com with ESMTPSA id
 g13-20020adffc8d000000b0021b99efceb6sm13809079wrr.22.2022.06.28.06.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jun 2022 06:44:49 -0700 (PDT)
Date: Tue, 28 Jun 2022 15:44:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH v6 3/4] vhost-vdpa: uAPI to suspend the device
Message-ID: <CAGxU2F43+5zsQOR4ReTtQtEF47s6y-XKcevosMOzUdEqpLhAsg@mail.gmail.com>
References: <20220623160738.632852-1-eperezma@redhat.com>
 <20220623160738.632852-4-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220623160738.632852-4-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Kamde, Tanuj" <tanuj.kamde@amd.com>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>,
 Pablo Cascon Katchadourian <pabloc@xilinx.com>, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>, Cindy Lu <lulu@redhat.com>,
 Piotr.Uminski@intel.com, Martin Petrus Hubertus Habets <martinh@xilinx.com>,
 Xie Yongji <xieyongji@bytedance.com>, Dinan Gunawardena <dinang@xilinx.com>,
 habetsm.xilinx@gmail.com, Longpeng <longpeng2@huawei.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, Laurent Vivier <lvivier@redhat.com>,
 netdev <netdev@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>,
 ecree.xilinx@gmail.com, Harpreet Singh Anand <hanand@xilinx.com>,
 Martin Porter <martinpo@xilinx.com>, "Dawar, Gautam" <gautam.dawar@amd.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Zhu Lingshan <lingshan.zhu@intel.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Jun 23, 2022 at 06:07:37PM +0200, Eugenio P=E9rez wrote:
>The ioctl adds support for suspending the device from userspace.
>
>This is a must before getting virtqueue indexes (base) for live migration,
>since the device could modify them after userland gets them. There are
>individual ways to perform that action for some devices
>(VHOST_NET_SET_BACKEND, VHOST_VSOCK_SET_RUNNING, ...) but there was no
>way to perform it for any vhost device (and, in particular, vhost-vdpa).
>
>After a successful return of the ioctl call the device must not process
>more virtqueue descriptors. The device can answer to read or writes of
>config fields as if it were not suspended. In particular, writing to
>"queue_enable" with a value of 1 will not make the device start
>processing buffers of the virtqueue.
>
>Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
>---
> drivers/vhost/vdpa.c       | 19 +++++++++++++++++++
> include/uapi/linux/vhost.h | 14 ++++++++++++++
> 2 files changed, 33 insertions(+)
>
>diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>index 3d636e192061..7fa671ac4bdf 100644
>--- a/drivers/vhost/vdpa.c
>+++ b/drivers/vhost/vdpa.c
>@@ -478,6 +478,22 @@ static long vhost_vdpa_get_vqs_count(struct vhost_vdp=
a *v, u32 __user *argp)
>       return 0;
> }
>
>+/* After a successful return of ioctl the device must not process more
>+ * virtqueue descriptors. The device can answer to read or writes of conf=
ig
>+ * fields as if it were not suspended. In particular, writing to "queue_e=
nable"
>+ * with a value of 1 will not make the device start processing buffers.
>+ */
>+static long vhost_vdpa_suspend(struct vhost_vdpa *v)
>+{
>+      struct vdpa_device *vdpa =3D v->vdpa;
>+      const struct vdpa_config_ops *ops =3D vdpa->config;
>+
>+      if (!ops->suspend)
>+              return -EOPNOTSUPP;
>+
>+      return ops->suspend(vdpa);
>+}
>+
> static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>                                  void __user *argp)
> {
>@@ -654,6 +670,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *fil=
ep,
>       case VHOST_VDPA_GET_VQS_COUNT:
>               r =3D vhost_vdpa_get_vqs_count(v, argp);
>               break;
>+      case VHOST_VDPA_SUSPEND:
>+              r =3D vhost_vdpa_suspend(v);
>+              break;
>       default:
>               r =3D vhost_dev_ioctl(&v->vdev, cmd, argp);
>               if (r =3D=3D -ENOIOCTLCMD)
>diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
>index cab645d4a645..6d9f45163155 100644
>--- a/include/uapi/linux/vhost.h
>+++ b/include/uapi/linux/vhost.h
>@@ -171,4 +171,18 @@
> #define VHOST_VDPA_SET_GROUP_ASID     _IOW(VHOST_VIRTIO, 0x7C, \
>                                            struct vhost_vring_state)
>
>+/* Suspend or resume a device so it does not process virtqueue requests a=
nymore
>+ *
>+ * After the return of ioctl with suspend !=3D 0, the device must finish =
any
>+ * pending operations like in flight requests. It must also preserve all =
the
>+ * necessary state (the virtqueue vring base plus the possible device spe=
cific
>+ * states) that is required for restoring in the future. The device must =
not
>+ * change its configuration after that point.
>+ *
>+ * After the return of ioctl with suspend =3D=3D 0, the device can contin=
ue
>+ * processing buffers as long as typical conditions are met (vq is enable=
d,
>+ * DRIVER_OK status bit is enabled, etc).
>+ */
>+#define VHOST_VDPA_SUSPEND            _IOW(VHOST_VIRTIO, 0x7D, int)
                                         ^
IIUC we are not using the argument anymore, so this should be changed in
_IO(VHOST_VIRTIO, 0x7D).

And we should update a bit the documentation.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
