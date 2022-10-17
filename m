Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98492C4332F
	for <virtualization@archiver.kernel.org>; Mon, 17 Oct 2022 07:08:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F397240918;
	Mon, 17 Oct 2022 07:08:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F397240918
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Go1D+lqZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nnvjuD40ow3Q; Mon, 17 Oct 2022 07:08:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E53A0408A4;
	Mon, 17 Oct 2022 07:08:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E53A0408A4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDF1DC0033;
	Mon, 17 Oct 2022 07:08:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5545CC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:08:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3030660655
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:08:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3030660655
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Go1D+lqZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HaoOj2uhl7qt
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:08:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E053B605E0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E053B605E0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 07:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665990513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9usayBzkIcBIJW6WysoHYem7xlHhVzBoZ4SlpZHoo4A=;
 b=Go1D+lqZVbAgDdgIUZlzl225sPs/fBAG69n02p+TwVS5+2213FabiQSumffic8NsfuYmBu
 Vg6582j9a2CyS+anto2AORnpY9sclW6I0ANY8bziHiCA5kFeckQfl0iYV8ZTeHPv/ZmCFC
 NYp6at1/GmVVte8VX9DKSnZHBhd2QpY=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-346-Y6AK9-lNMimAMj8GmGscCw-1; Mon, 17 Oct 2022 03:08:32 -0400
X-MC-Unique: Y6AK9-lNMimAMj8GmGscCw-1
Received: by mail-ot1-f71.google.com with SMTP id
 36-20020a9d0627000000b0063927bfccb5so4647915otn.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Oct 2022 00:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9usayBzkIcBIJW6WysoHYem7xlHhVzBoZ4SlpZHoo4A=;
 b=MmVBATQe521zxKHFIucgk9SoWKIsXX3tJpJKd3jesVuOA6EoBME/NJyajs6D5TFGtg
 kRMAFr780u96pKekXPzxBZbi2BCN7DGTuJpLXJ1gVm1D4Q5qt0RJtRM7GjoNlMAahlzL
 w1+UC84sAH9Z84kb60kkOXNX6BFrdHXJaWTw7Zz9xChEs71q8qrvq0KC30TA2cg2cR7i
 DUL5dJTc6Y6Oq0wkipBqEOOcF73vkSE8y/XHt2tiZEoXoLKAylMPPqsl4rYlEd8DDMCU
 37istxFo6OnDSuYXXV7XWhVJiOUlA18doVDMepKEFyaCk/nzafzR6F6sBdBnjUHxRt72
 vljw==
X-Gm-Message-State: ACrzQf3O4CUxs0yfeIX14jSuU9HyM+DwzMb3EJUPdBVi4YDFVV0MD4ax
 FA5OYLiPRNSF3USOZglNybBhqBb9L1Cy4jsrIyteMs1GluHGJ7W4r9F9O2/5S9vIuAVz6xXuKQG
 xQSikGlDY2RRfbsHhX/2PIZy7jevoNa3D0JAW9ljwLH5KgsSSGrKrHufwPQ==
X-Received: by 2002:a9d:7dcf:0:b0:661:dc25:ba0 with SMTP id
 k15-20020a9d7dcf000000b00661dc250ba0mr4354067otn.201.1665990511559; 
 Mon, 17 Oct 2022 00:08:31 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7waEHbw1nll8KdB1C4R8PTMAQG1p6WJ5GlAY6zu0wGd9AgaUqPoF5K8EbsNvAlZhX7DHOjTO4jupaDYWXW7W4=
X-Received: by 2002:a9d:7dcf:0:b0:661:dc25:ba0 with SMTP id
 k15-20020a9d7dcf000000b00661dc250ba0mr4354061otn.201.1665990511336; Mon, 17
 Oct 2022 00:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <1665793690-28120-1-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1665793690-28120-1-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Oct 2022 15:08:19 +0800
Message-ID: <CACGkMEvaKnqS-0p7iqyHP_Wbbj1YdmPFA7ABfKK_8FbXMsZEkg@mail.gmail.com>
Subject: Re: [PATCH 0/4] vDPA: dev config export via "vdpa dev show" command
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Sean Mooney <smooney@redhat.com>, virtualization@lists.linux-foundation.org,
 Daniel Berrange <berrange@redhat.com>, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

Adding Sean and Daniel for more thoughts.

On Sat, Oct 15, 2022 at 9:33 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
> Live migration of vdpa would typically require re-instate vdpa
> device with an idential set of configs on the destination node,
> same way as how source node created the device in the first place.
>
> In order to allow live migration orchestration software to export the
> initial set of vdpa attributes with which the device was created, it
> will be useful if the vdpa tool can report the config on demand with
> simple query.

For live migration, I think the management layer should have this
knowledge and they can communicate directly without bothering the vdpa
tool on the source. If I was not wrong this is the way libvirt is
doing now.

> This will ease the orchestration software implementation
> so that it doesn't have to keep track of vdpa config change, or have
> to persist vdpa attributes across failure and recovery, in fear of
> being killed due to accidental software error.
>
> In this series, the initial device config for vdpa creation will be
> exported via the "vdpa dev show" command.
> This is unlike the "vdpa
> dev config show" command that usually goes with the live value in
> the device config space, which is not reliable subject to the dynamics
> of feature negotiation and possible change in device config space.
>
> Examples:
>
> 1) Create vDPA by default without any config attribute
>
> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0
> $ vdpa dev show vdpa0
> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
> $ vdpa dev -jp show vdpa0
> {
>     "dev": {
>         "vdpa0": {
>             "type": "network",
>             "mgmtdev": "pci/0000:41:04.2",
>             "vendor_id": 5555,
>             "max_vqs": 9,
>             "max_vq_size": 256,
>         }
>     }
> }
>
> 2) Create vDPA with config attribute(s) specified
>
> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 \
>     mac e4:11:c6:d3:45:f0 max_vq_pairs 4
> $ vdpa dev show
> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
>   mac e4:11:c6:d3:45:f0 max_vq_pairs 4
> $ vdpa dev -jp show
> {
>     "dev": {
>         "vdpa0": {
>             "type": "network",
>             "mgmtdev": "pci/0000:41:04.2",

So "mgmtdev" looks not necessary for live migration.

Thanks

>             "vendor_id": 5555,
>             "max_vqs": 9,
>             "max_vq_size": 256,
>             "mac": "e4:11:c6:d3:45:f0",
>             "max_vq_pairs": 4
>         }
>     }
> }
>
> ---
>
> Si-Wei Liu (4):
>   vdpa: save vdpa_dev_set_config in struct vdpa_device
>   vdpa: pass initial config to _vdpa_register_device()
>   vdpa: show dev config as-is in "vdpa dev show" output
>   vdpa: fix improper error message when adding vdpa dev
>
>  drivers/vdpa/ifcvf/ifcvf_main.c      |  2 +-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c    |  2 +-
>  drivers/vdpa/vdpa.c                  | 63 +++++++++++++++++++++++++++++++++---
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  2 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  2 +-
>  drivers/vdpa/vdpa_user/vduse_dev.c   |  2 +-
>  drivers/vdpa/virtio_pci/vp_vdpa.c    |  3 +-
>  include/linux/vdpa.h                 | 26 ++++++++-------
>  8 files changed, 80 insertions(+), 22 deletions(-)
>
> --
> 1.8.3.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
