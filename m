Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB04C19F2A
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 19:20:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DAB184044D;
	Wed, 10 Aug 2022 19:20:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DAB184044D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZQCqVgZQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bTsrWWWFJ-HZ; Wed, 10 Aug 2022 19:20:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4028840012;
	Wed, 10 Aug 2022 19:20:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4028840012
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E06D3C0033;
	Wed, 10 Aug 2022 19:20:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1895C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 19:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 74D6281BC6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 19:20:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 74D6281BC6
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZQCqVgZQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jr7oa4pPpSQF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 19:20:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E151481B6D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E151481B6D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 19:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660159205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mg9jfkgOJMJfQD+UBNUpUZRupW9q/o+qow5RgcfsokI=;
 b=ZQCqVgZQkEmfbxVz9TpIN4CR3dlDGcD0Zoq0zup7osSqffbJMDtbUMoUkPDjhwHDdpbu8f
 p9fdvSxyk9+6pgxCyCUbYQlFxIcxUri5pUi+lDsKq6L1HaOwbF2zkCEFmmqsDeUWwUob23
 ySsO+Vca2xp5d0Brv1FLojQ8s4UEAAc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-149-PxKvpn3tPlOI4SPkJ7fhow-1; Wed, 10 Aug 2022 15:20:04 -0400
X-MC-Unique: PxKvpn3tPlOI4SPkJ7fhow-1
Received: by mail-ed1-f69.google.com with SMTP id
 o2-20020a056402438200b0043d552deb2aso9749570edc.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 12:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=mg9jfkgOJMJfQD+UBNUpUZRupW9q/o+qow5RgcfsokI=;
 b=ebxuO3nmZuBZdE9YJQU0E2Ehs33gAwwky4SQs8GU+gB4FBZjJvli+crJzq8YgIAapz
 UNG0qw4NliiMj2bV3O338xuqhowxTNAY3mdWyR40g4EIJVo7ESHmSi7mUsZirqUxshAD
 IWBtp+0Kx/cCTN3wXMFO7SM9YG8pZNVW6E5jZwt9ePZUVlkKOUnyewDeMS78R77kWJlF
 DliyZ0ATF0WJEfZJmiEpR5nTBs+Bu6qUIS3LFcDvvNJ4Awrf3PFeadoc5f/l7m1pQUSx
 yv/kCQM5zzWFL1CbzZGe6VJP5ZDDbJbvRlSvVN15xiiXyGE/aL4uT+I2QIIewq+dvwks
 uYxQ==
X-Gm-Message-State: ACgBeo2ewadLRmgNum8lK+pcGiCdRO6u/IZQqqSI1XZtIze7NFg13e13
 Or5zwcN+p2RBpTp97rz5K9qypIqBiAR410z4I54TjfzOOKOT/vs3OWPjE8ImLZGsm2fdRVcRWAq
 025LhmYQQVoiT8ImeBIegc00ActFyB2gMKeD1h2Bvnw==
X-Received: by 2002:a05:6402:11cb:b0:43c:c7a3:ff86 with SMTP id
 j11-20020a05640211cb00b0043cc7a3ff86mr28501452edw.383.1660159203356; 
 Wed, 10 Aug 2022 12:20:03 -0700 (PDT)
X-Google-Smtp-Source: AA6agR513nGcOyEx/cZZy+oLMyNgfYHlcNGvOvBbmD5iBHW2tkSoDlCb8kDWjvUl/mnZVx0X2sxUhw==
X-Received: by 2002:a05:6402:11cb:b0:43c:c7a3:ff86 with SMTP id
 j11-20020a05640211cb00b0043cc7a3ff86mr28501439edw.383.1660159203147; 
 Wed, 10 Aug 2022 12:20:03 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 d15-20020aa7d5cf000000b0043d6ece495asm8111225eds.55.2022.08.10.12.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Aug 2022 12:20:02 -0700 (PDT)
Date: Wed, 10 Aug 2022 15:19:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH v7 0/4] Implement vdpasim suspend operation
Message-ID: <20220810151907-mutt-send-email-mst@kernel.org>
References: <20220810171512.2343333-1-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220810171512.2343333-1-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: tanuj.kamde@amd.com, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, pabloc@xilinx.com,
 Eli Cohen <elic@nvidia.com>, Zhang Min <zhang.min9@zte.com.cn>,
 lulu@redhat.com, Piotr.Uminski@intel.com, martinh@xilinx.com,
 Xie Yongji <xieyongji@bytedance.com>, dinang@xilinx.com,
 habetsm.xilinx@gmail.com, Longpeng <longpeng2@huawei.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, lvivier@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ecree.xilinx@gmail.com,
 hanand@xilinx.com, martinpo@xilinx.com, gautam.dawar@amd.com,
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Aug 10, 2022 at 07:15:08PM +0200, Eugenio P=E9rez wrote:
> Implement suspend operation for vdpa_sim devices, so vhost-vdpa will offer
> that backend feature and userspace can effectively suspend the device.
> =

> This is a must before getting virtqueue indexes (base) for live migration,
> since the device could modify them after userland gets them. There are
> individual ways to perform that action for some devices
> (VHOST_NET_SET_BACKEND, VHOST_VSOCK_SET_RUNNING, ...) but there was no
> way to perform it for any vhost device (and, in particular, vhost-vdpa).
> =

> After a successful return of ioctl the device must not process more virtq=
ueue
> descriptors. The device can answer to read or writes of config fields as =
if it
> were not suspended. In particular, writing to "queue_enable" with a value=
 of 1
> will not make the device start processing virtqueue buffers.
> =

> In the future, we will provide features similar to
> VHOST_USER_GET_INFLIGHT_FD so the device can save pending operations.
> =

> Applied on top of [1] branch after removing the old commits.

Except, I can't really do this without invaliding all testing.
Can't you post an incremental patch?

> Comments are welcome.
> =

> v7:
> * Remove ioctl leftover argument and update doc accordingly.

> v6:
> * Remove the resume operation, making the ioctl simpler. We can always add
>   another ioctl for VM_STOP/VM_RESUME operation later.
> * s/stop/suspend/ to differentiate more from reset.
> * Clarify scope of the suspend operation.
> =

> v5:
> * s/not stop/resume/ in doc.
> =

> v4:
> * Replace VHOST_STOP to VHOST_VDPA_STOP in vhost ioctl switch case too.
> =

> v3:
> * s/VHOST_STOP/VHOST_VDPA_STOP/
> * Add documentation and requirements of the ioctl above its definition.
> =

> v2:
> * Replace raw _F_STOP with BIT_ULL(_F_STOP).
> * Fix obtaining of stop ioctl arg (it was not obtained but written).
> * Add stop to vdpa_sim_blk.
> =

> [1] git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
> =

> Eugenio P=E9rez (4):
>   vdpa: Add suspend operation
>   vhost-vdpa: introduce SUSPEND backend feature bit
>   vhost-vdpa: uAPI to suspend the device
>   vdpa_sim: Implement suspend vdpa op
> =

>  drivers/vdpa/vdpa_sim/vdpa_sim.c     | 14 +++++++++++
>  drivers/vdpa/vdpa_sim/vdpa_sim.h     |  1 +
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  3 +++
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  3 +++
>  drivers/vhost/vdpa.c                 | 35 +++++++++++++++++++++++++++-
>  include/linux/vdpa.h                 |  4 ++++
>  include/uapi/linux/vhost.h           |  9 +++++++
>  include/uapi/linux/vhost_types.h     |  2 ++
>  8 files changed, 70 insertions(+), 1 deletion(-)
> =

> -- =

> 2.31.1
> =


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
