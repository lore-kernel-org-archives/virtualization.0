Return-Path: <SRS0=CgtS=KM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC72C433ED
	for <virtualization@archiver.kernel.org>; Mon, 17 May 2021 23:40:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28D8C611BE
	for <virtualization@archiver.kernel.org>; Mon, 17 May 2021 23:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D8C611BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E40C283C5C;
	Mon, 17 May 2021 23:40:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T0s0-216DVgl; Mon, 17 May 2021 23:40:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94F8C83C59;
	Mon, 17 May 2021 23:40:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64AA1C000E;
	Mon, 17 May 2021 23:40:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84C26C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 23:40:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 64D08606BE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 23:40:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3zLEvRSd51YN
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 23:40:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 670DE60682
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 23:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621294813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PI2cBh7ZV039zjsym5pdKGbiVVxTK1V76FCuyS+vLt0=;
 b=K36FVKMJDLCMrFbKdhzUV2OUDasyb/OMx3nOjKjXdPJNVe7Vz/F1JOqfvgO7uC+kN29wIT
 aU6CWyA9y3oKSzgqL+ZuKm/hFSgLnq3jLEH8dsQnV5wfKnsZxELiq20kQ1MUVwNG1Zx+k3
 MuG3EzxDSmmGWn1NQ7jsgBaTNLfGNXk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-NMAwhK3NN5ONXetnJ_R-1A-1; Mon, 17 May 2021 19:40:11 -0400
X-MC-Unique: NMAwhK3NN5ONXetnJ_R-1A-1
Received: by mail-wr1-f70.google.com with SMTP id
 j33-20020adf91240000b029010e4009d2ffso4621411wrj.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 16:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PI2cBh7ZV039zjsym5pdKGbiVVxTK1V76FCuyS+vLt0=;
 b=LbB3qBruUHvtqRjC40qLHH69ULA2h0jzl8GkuSX3CaSwugpfsToMgTTOno5WlWtFhx
 1d4yTQ2ckl8/4JmCm3N1L/YFMgnIf8ejHUW5IaJ1J0oTGuWwoV3AOGps0zXlZbWw4gcC
 aA3BWYAv0S9dhNv9WdljVDh8T78UgEpwveOaCb3HVDaQFXDHnSV9BpzyDKw2gnAwiRcc
 St0TMmnPX+lAmt5fQ4nw4vKA8rdPfKkIIIgY+fsbW94qnNtF0vo3K4vj2ozlbN3fssFF
 6ZRffWMUlR9uaHgKcpuSO2xmD7rpa2he6rI7HuSnDPwBpx1etB1dMttTOsT8EZQqdHVE
 XZxg==
X-Gm-Message-State: AOAM532ej+rcpnIVIRIx/DD5K1I1cGgybemF3P8CwBzHA3w3MkrLH2Lg
 Fyj+gkHCixAafumlcFiAxTMLVPro//9PWewlRT8XKBdVG0A4M+X7zDM+3FL0QAqFZd5vme4hbjn
 75Or6L5Lrc66bzyXvmIWiMLMrhXCkMS6MXXnye4jnFA==
X-Received: by 2002:a5d:658f:: with SMTP id q15mr2669001wru.399.1621294810260; 
 Mon, 17 May 2021 16:40:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGYIBf4ArHDftxVkjGzAaaVs/pIWHbhDQW+SvL8o7m6uB3LYwoFWQtqlYVbDJZbDEp64mBfQ==
X-Received: by 2002:a5d:658f:: with SMTP id q15mr2668983wru.399.1621294810122; 
 Mon, 17 May 2021 16:40:10 -0700 (PDT)
Received: from redhat.com ([2a10:800c:1fa6:0:3809:fe0c:bb87:250e])
 by smtp.gmail.com with ESMTPSA id h17sm3549731wre.38.2021.05.17.16.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 May 2021 16:40:09 -0700 (PDT)
Date: Mon, 17 May 2021 19:40:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [RFC PATCH 00/17] Add validation for used length
Message-ID: <20210517193912-mutt-send-email-mst@kernel.org>
References: <20210517090836.533-1-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210517090836.533-1-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: ohad@wizery.com, amit@kernel.org, airlied@linux.ie,
 linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org, miklos@szeredi.hu,
 stefanha@redhat.com, dan.j.williams@intel.com,
 virtualization@lists.linux-foundation.org, johannes@sipsolutions.net,
 vgoyal@redhat.com
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

On Mon, May 17, 2021 at 05:08:19PM +0800, Xie Yongji wrote:
> Current virtio device drivers may trust the used length returned
> in virtqueue_get_buf()/virtqueue_get_buf_ctx(). But the used length
> might come from an untrusted device when VDUSE[1] is enabled. To
> protect this case, this series tries to add validation for the
> used length.
> 
> Since many legacy devices will also set the used length incorrectly,
> we did not add the validation unconditionally. Instead, we will do
> the validation only when the device driver needs the used length.
> A NULL len passed to virtqueue_get_buf()/virtqueue_get_buf_ctx()
> will mean the used length is not needed by the device driver.

Can we be more specific? Which drivers have problems when used len
is incorrect? Maybe there's an easier way like validating the length
in the driver ...

> [1] https://lore.kernel.org/kvm/20210331080519.172-1-xieyongji@bytedance.com/
> 
> Xie Yongji (17):
>   virtio_ring: Avoid reading unneeded used length
>   virtio-blk: Remove unused used length
>   virtio_console: Remove unused used length
>   crypto: virtio - Remove unused used length
>   drm/virtio: Remove unused used length
>   caif_virtio: Remove unused used length
>   virtio_net: Remove unused used length
>   mac80211_hwsim: Remove unused used length
>   virtio_pmem: Remove unused used length
>   rpmsg: virtio: Remove unused used length
>   virtio_scsi: Remove unused used length
>   virtio_balloon: Remove unused used length
>   virtio_input: Remove unused used length
>   virtio_mem: Remove unused used length
>   virtiofs: Remove unused used length
>   vsock: Remove unused used length
>   virtio_ring: Add validation for used length
> 
>  drivers/block/virtio_blk.c                 |  3 +--
>  drivers/char/virtio_console.c              | 12 ++++--------
>  drivers/crypto/virtio/virtio_crypto_algs.c |  6 ++----
>  drivers/gpu/drm/virtio/virtgpu_vq.c        |  3 +--
>  drivers/net/caif/caif_virtio.c             |  3 +--
>  drivers/net/virtio_net.c                   | 10 ++++------
>  drivers/net/wireless/mac80211_hwsim.c      |  3 +--
>  drivers/nvdimm/nd_virtio.c                 |  3 +--
>  drivers/rpmsg/virtio_rpmsg_bus.c           |  3 +--
>  drivers/scsi/virtio_scsi.c                 |  3 +--
>  drivers/virtio/virtio_balloon.c            | 21 ++++++++++-----------
>  drivers/virtio/virtio_input.c              |  6 ++----
>  drivers/virtio/virtio_mem.c                |  3 +--
>  drivers/virtio/virtio_ring.c               | 28 +++++++++++++++++++++++-----
>  fs/fuse/virtio_fs.c                        |  6 ++----
>  net/vmw_vsock/virtio_transport.c           |  3 +--
>  16 files changed, 56 insertions(+), 60 deletions(-)
> 
> -- 
> 2.11.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
