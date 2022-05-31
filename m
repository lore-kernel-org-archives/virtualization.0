Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D183C433F5
	for <virtualization@archiver.kernel.org>; Tue, 31 May 2022 05:42:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 498F682BA7;
	Tue, 31 May 2022 05:42:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ua1yl5boULMp; Tue, 31 May 2022 05:42:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AD1F782B9F;
	Tue, 31 May 2022 05:42:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D818C0039;
	Tue, 31 May 2022 05:42:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46E62C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 05:42:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 41D68400A4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 05:42:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qBt31uJ61Z8t
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 05:42:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EC2054023F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 05:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653975737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lXZqQ2bmpu17MD3xsKbd7SyCjtmA473Yqjdy/U/0t2k=;
 b=RPv3FBqJ8mx1MhR/jpdsTnVTLCSxMEAggTo8TeID/KfNL7xHY2M7Q4P+WIBAS1/t2SZK8H
 xSEzC+v1LterpBYO9aU1LSsueW+67I+Lc/7z3h1tsw+KDr5oxaBwSQAVKzO7DCx+S/V6pL
 hIjQ6hFN1fiAJrxd3QB9kv21R+MxDUk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-CsbX13NRPu6WXoV6a8fcKQ-1; Tue, 31 May 2022 01:42:16 -0400
X-MC-Unique: CsbX13NRPu6WXoV6a8fcKQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 c11-20020adffb4b000000b0020ff998391dso1773057wrs.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 22:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=lXZqQ2bmpu17MD3xsKbd7SyCjtmA473Yqjdy/U/0t2k=;
 b=MLosT0YXWD5gWs0IpDlBw7lekdhFSs4pDi91osEsiVGMAOy4PYxGVZCNqVk8Hhzrgz
 aN634Oy1c+5xfuEYw5rMxCN8e0wsmBrcOpL2YyhLrkk2CoDmVReo6W8yzCDGX5Fd+Prt
 CyqGH33rn+QHiuK4pXwl3lINYpV+QpG5hoVWzlftlTZe//hGhOB80muy0pd83tsujlSw
 8sX//AvZ7hQ1DwBd54sQGArJuru7MvPrEuJxA2ZYBcAs7uAPOoDwpDfVQmPXXvIh2Zey
 l9BPOEBuhHpmu4l+E8GhvdlhHRfkElaRDlHRKGCcFrcurlV1udMw/yTMY43lNQIcviVJ
 x86A==
X-Gm-Message-State: AOAM530hnB8X/xKSRy9ZSKswFjZLilFwV4gVOmCd4rJUWpmp6gVGD88o
 bkPtCGcGxnZVBnJbjmdrqqsLlS1YwQilAim8VA9y2kjTt9xMdwwqb2YlHfMFR5r05p3Q3h2FtTh
 iBW6v0eW3sZy6s8eIutlSOexz72jBGq+XWIGTWcg4Hg==
X-Received: by 2002:a5d:5984:0:b0:20f:f3a1:fc56 with SMTP id
 n4-20020a5d5984000000b0020ff3a1fc56mr26938597wri.718.1653975734744; 
 Mon, 30 May 2022 22:42:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdE+qW9FBh7CyCXbLKMzMHLR0yj20nkiIZGrztEDmjYsCEbIiQpOmR1K3n4oHtOPy/6V+v4A==
X-Received: by 2002:a5d:5984:0:b0:20f:f3a1:fc56 with SMTP id
 n4-20020a5d5984000000b0020ff3a1fc56mr26938567wri.718.1653975734469; 
 Mon, 30 May 2022 22:42:14 -0700 (PDT)
Received: from redhat.com ([2.52.157.68]) by smtp.gmail.com with ESMTPSA id
 e9-20020a5d5949000000b002103136623esm5160877wri.85.2022.05.30.22.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 May 2022 22:42:13 -0700 (PDT)
Date: Tue, 31 May 2022 01:42:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH v4 0/4] Implement vdpasim stop operation
Message-ID: <20220531014108-mutt-send-email-mst@kernel.org>
References: <20220526124338.36247-1-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220526124338.36247-1-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: tanuj.kamde@amd.com, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 pabloc@xilinx.com, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>, lulu@redhat.com, Piotr.Uminski@intel.com,
 martinh@xilinx.com, Xie Yongji <xieyongji@bytedance.com>, dinang@xilinx.com,
 habetsm.xilinx@gmail.com, Longpeng <longpeng2@huawei.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, lvivier@redhat.com,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ecree.xilinx@gmail.com, hanand@xilinx.com,
 martinpo@xilinx.com, gautam.dawar@amd.com,
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

On Thu, May 26, 2022 at 02:43:34PM +0200, Eugenio P=E9rez wrote:
> Implement stop operation for vdpa_sim devices, so vhost-vdpa will offer
> that backend feature and userspace can effectively stop the device.
> =

> This is a must before get virtqueue indexes (base) for live migration,
> since the device could modify them after userland gets them. There are
> individual ways to perform that action for some devices
> (VHOST_NET_SET_BACKEND, VHOST_VSOCK_SET_RUNNING, ...) but there was no
> way to perform it for any vhost device (and, in particular, vhost-vdpa).
> =

> After the return of ioctl with stop !=3D 0, the device MUST finish any
> pending operations like in flight requests. It must also preserve all
> the necessary state (the virtqueue vring base plus the possible device
> specific states) that is required for restoring in the future. The
> device must not change its configuration after that point.
> =

> After the return of ioctl with stop =3D=3D 0, the device can continue
> processing buffers as long as typical conditions are met (vq is enabled,
> DRIVER_OK status bit is enabled, etc).
> =

> In the future, we will provide features similar to VHOST_USER_GET_INFLIGH=
T_FD
> so the device can save pending operations.
> =

> Comments are welcome.


So given this is just for simulator and affects UAPI I think it's fine
to make it wait for the next merge window, until there's a consensus.
Right?

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

> Eugenio P=E9rez (4):
>   vdpa: Add stop operation
>   vhost-vdpa: introduce STOP backend feature bit
>   vhost-vdpa: uAPI to stop the device
>   vdpa_sim: Implement stop vdpa op
> =

>  drivers/vdpa/vdpa_sim/vdpa_sim.c     | 21 +++++++++++++++++
>  drivers/vdpa/vdpa_sim/vdpa_sim.h     |  1 +
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  3 +++
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  3 +++
>  drivers/vhost/vdpa.c                 | 34 +++++++++++++++++++++++++++-
>  include/linux/vdpa.h                 |  6 +++++
>  include/uapi/linux/vhost.h           | 14 ++++++++++++
>  include/uapi/linux/vhost_types.h     |  2 ++
>  8 files changed, 83 insertions(+), 1 deletion(-)
> =

> -- =

> 2.31.1
> =


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
