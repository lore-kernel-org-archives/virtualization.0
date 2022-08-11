Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEB1C19F2A
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 13:58:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC68741844;
	Thu, 11 Aug 2022 13:58:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CC68741844
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SSirumC/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E3JryV5rw_x9; Thu, 11 Aug 2022 13:58:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E377441837;
	Thu, 11 Aug 2022 13:58:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E377441837
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1E9AC0032;
	Thu, 11 Aug 2022 13:58:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37347C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:58:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 020F04185A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:58:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 020F04185A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TnBt9mjHB5xh
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:58:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6FB5C41837
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6FB5C41837
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660226316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SueXoUwoFpOiUowzXaYPSnSZQFBzpony+oQ+FoIu3TE=;
 b=SSirumC/XBugGh7xRvgOpkf1SHTxr95hAFrsl+Ix5kHwopOGzN3AGEtIkL1tiymIptZ8va
 syGIqDYroyG+eNXf1Yiw6wjox3qqxMVFlREOb/E1FsIezIl4/SZaoOUyXRLKJmG6g1GiAx
 CNcDFsR735ewrY9VvRnEfhH+PQznnpk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-80-fLEyL-8OMZeUkyDn_29MHA-1; Thu, 11 Aug 2022 09:58:34 -0400
X-MC-Unique: fLEyL-8OMZeUkyDn_29MHA-1
Received: by mail-ed1-f69.google.com with SMTP id
 t13-20020a056402524d00b0043db1fbefdeso10901373edd.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 06:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=SueXoUwoFpOiUowzXaYPSnSZQFBzpony+oQ+FoIu3TE=;
 b=ifuuMcQc5NFBxEpDNC5Ac3pFnhNrr8tkWdHUXe5Vaudx5ALzmHDSxgJlFFiev8gMac
 OQQb6yuS5MovjFQPTOGVy0WRzKuHWGHWBZmmoJzWsmdTyg32kqv2ldlWqaXPky4+Rf0b
 YoplxNQ8CtemlU8xIYnJ0JEKkppCTNekD0VyzlunEZTDAUO8kNLpiHvDpLYQ/UD/jCg/
 l58GUlwBqdGwY+xnvVTr4LQhPzJJigkvPc7AFojdW54P7yb/d7RiKsaXGdZmfcLxOLqa
 Xn/5c/lbW4Ikvq2vxr37C+eJ49am4WRhoc0i9kFKCy725VpIgbLmucRBlKB6/1+SvEaQ
 3MUw==
X-Gm-Message-State: ACgBeo2zuu02/uk220ZTB8yVNcuiuhpj5R7TdYXtb7qSGL7LepRHzpQf
 esmN7AFn54MLFdWt/35SmzPPvNhBo9rKANg0Dj9JhSGY2RyWE1oS0bq+xE7zIMHGNFSt83GRQbX
 mHXg7s8ViKbRAKLFGbGeRyp6fL2tL+X7GYH9TuaYmHg==
X-Received: by 2002:a17:907:a0c6:b0:730:f081:6e8e with SMTP id
 hw6-20020a170907a0c600b00730f0816e8emr21391786ejc.479.1660226313546; 
 Thu, 11 Aug 2022 06:58:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5b46QDyRM9vbzNuiXMABuDw2O5Su7R7FeFDkEfFhsasyXKwagvg8ClVE2e++6Vq45R4NWZ9Q==
X-Received: by 2002:a17:907:a0c6:b0:730:f081:6e8e with SMTP id
 hw6-20020a170907a0c600b00730f0816e8emr21391746ejc.479.1660226313014; 
 Thu, 11 Aug 2022 06:58:33 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 a1-20020a50ff01000000b0043a5bcf80a2sm9166980edu.60.2022.08.11.06.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Aug 2022 06:58:32 -0700 (PDT)
Date: Thu, 11 Aug 2022 09:58:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH v8 0/3] Implement vdpasim suspend operation
Message-ID: <20220811095743-mutt-send-email-mst@kernel.org>
References: <20220811135353.2549658-1-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220811135353.2549658-1-eperezma@redhat.com>
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

On Thu, Aug 11, 2022 at 03:53:50PM +0200, Eugenio P=E9rez wrote:
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

> Applied on top of vhost branch.
> =

> Comments are welcome.
> =

> v8:
> * v7 but incremental from vhost instead of isolated.

Now I'm lost. incremental to what? Does the vhost branch now
have the correct bits?

> v7:
> * Remove ioctl leftover argument and update doc accordingly.
> =

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

> Eugenio P=E9rez (3):
>   vdpa: delete unreachable branch on vdpasim_suspend
>   vdpa: Remove wrong doc of VHOST_VDPA_SUSPEND ioctl
>   vhost: Remove invalid parameter of VHOST_VDPA_SUSPEND ioctl
> =

>  drivers/vdpa/vdpa_sim/vdpa_sim.c |  7 -------
>  include/linux/vdpa.h             |  2 +-
>  include/uapi/linux/vhost.h       | 17 ++++++-----------
>  3 files changed, 7 insertions(+), 19 deletions(-)
> =

> -- =

> 2.31.1
> =


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
