Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED89C6FA8B
	for <virtualization@archiver.kernel.org>; Fri, 23 Sep 2022 03:34:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83F2D825B9;
	Fri, 23 Sep 2022 03:34:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 83F2D825B9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fn3ea4SR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NC7DgDOD_cXK; Fri, 23 Sep 2022 03:34:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B6361818C4;
	Fri, 23 Sep 2022 03:34:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B6361818C4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B6AFC0033;
	Fri, 23 Sep 2022 03:34:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82CDCC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 03:34:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 68F0341726
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 03:34:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 68F0341726
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fn3ea4SR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FBFgUjVeFUNG
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 03:34:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0653341724
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0653341724
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 03:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663904038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jfwRdGDNcq40RH+ojb8JkEtDCmxqgfcCO3MCP5Icg8s=;
 b=Fn3ea4SRYFEFO1v0iuUgkiSJZxPCzOowFi3Z74XuFpOTCpABJoHEYHJF3vRoyPX88uTNUE
 ChDgyW0xcyVVVhC109/KUR0vHlAD4h9WZjYYrWOBda5tWWoCGB8QQyPKcZa+repqAQZAA0
 Gzw/2nUtKZjFhEZi2KEiD6ZenHUdsPU=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-344-uXjFvHi6NuutirsHzhSlsQ-1; Thu, 22 Sep 2022 23:33:55 -0400
X-MC-Unique: uXjFvHi6NuutirsHzhSlsQ-1
Received: by mail-oo1-f72.google.com with SMTP id
 y10-20020a4a9c0a000000b0047330d6f1c0so4750109ooj.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 20:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=jfwRdGDNcq40RH+ojb8JkEtDCmxqgfcCO3MCP5Icg8s=;
 b=JWLWUpnTGp+KQYTzSqTmdlsjYGImin05iYUEYanNGgDmIqcLtRhJWe+KjDWND96o/B
 TXBS1deXX/eZrbvTlB6ob2crYqyXal1NwwLaSZVo/OsxQqnASMi0QNiLC3T64KZ/lpDd
 jCG98CHgtx57fnbi0oeMGEuL6rvR1alOF4mJU7VbtsTLZziHKhqghJl5lnalZa0QSGSJ
 nJcbk2LYNlDjT6j7FUck8HafxLAfJ6cojCdacsU3JY5LEHgk/bYKsmcpyGHL0lGWuTNp
 syj4VMinwxe4f2wtDeXml6jJpuN4ixMSW9RLhGXH6B4OLBf9gHRP3VazHTqh+S5qV4tb
 m+Sw==
X-Gm-Message-State: ACrzQf31J/hrSs3p83i0r+BWwx8m5JVjjuZOZakiVrvL/Rl9UkqbCZXO
 OwEODDLZrno6m+dKmchVGggfvhqS1uc4GWk2PyMAo+YZmGTctZSRv/nLTqZ3OrMIl9eZBBwkVG9
 0a97Ppdo2VUHYjl8YT5A8PhTKIi9jqCWJ28oIi19YsVLkcnDiyJ0BzSSSQw==
X-Received: by 2002:a4a:d351:0:b0:476:46fd:c2f1 with SMTP id
 d17-20020a4ad351000000b0047646fdc2f1mr2002949oos.93.1663904034619; 
 Thu, 22 Sep 2022 20:33:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5eqtkRyiERFEunZk642z2/M048SWtLReDOqGxDyluNWX4hDNUDToBGyDd/A5vZWaP/MZjmW7s5p1mxQp+9v60=
X-Received: by 2002:a4a:d351:0:b0:476:46fd:c2f1 with SMTP id
 d17-20020a4ad351000000b0047646fdc2f1mr2002935oos.93.1663904034409; Thu, 22
 Sep 2022 20:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220922024305.1718-1-jasowang@redhat.com>
 <20220922024305.1718-3-jasowang@redhat.com>
 <20220922092250.pj26iutmywlemvbm@sgarzare-redhat>
In-Reply-To: <20220922092250.pj26iutmywlemvbm@sgarzare-redhat>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 23 Sep 2022 11:33:43 +0800
Message-ID: <CACGkMEvcZdPE7-jhhcYn=ZAf0BgEE=CEurqe68dOtWGcZzRM8Q@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Cindy Lu <lulu@redhat.com>, mst <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Gautam Dawar <gdawar@xilinx.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yongji Xie <xieyongji@bytedance.com>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, Eli Cohen <elic@nvidia.com>,
 eperezma <eperezma@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>
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

On Thu, Sep 22, 2022 at 5:23 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Thu, Sep 22, 2022 at 10:43:04AM +0800, Jason Wang wrote:
> >This patch implements features provisioning for vdpa_sim_net.
> >
> >1) validating the provisioned features to be a subset of the parent
> >   features.
> >2) clearing the features that is not wanted by the userspace
> >
> >For example:
> >
> ># vdpa mgmtdev show
> >vdpasim_net:
> >  supported_classes net
> >  max_supported_vqs 3
> >  dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
> >
> >1) provision vDPA device with all features that are supported by the
> >   net simulator
> >
> ># vdpa dev add name dev1 mgmtdev vdpasim_net
> ># vdpa dev config show
> >dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> >  negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
> >
> >2) provision vDPA device with a subset of the features
> >
> ># vdpa dev add name dev1 mgmtdev vdpasim_net device_features 0x300020000
> ># vdpa dev config show
> >dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> >  negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
> >
> >Reviewed-by: Eli Cohen <elic@nvidia.com>
> >Signed-off-by: Jason Wang <jasowang@redhat.com>
> >---
> > drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
> > 1 file changed, 10 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> >index 886449e88502..a9ba02be378b 100644
> >--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> >+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> >@@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> >       dev_attr.work_fn = vdpasim_net_work;
> >       dev_attr.buffer_size = PAGE_SIZE;
> >
> >+      if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> >+              if (config->device_features &
> >+                  ~dev_attr.supported_features)
> >+                      return -EINVAL;
> >+              dev_attr.supported_features &=
> >+                       config->device_features;
> >+      }
> >+
>
> How about doing this inside vdpasim_create()?
>
> That way we support this feature in all simulators.

Yes, let me do that in the next version.

Thanks

>
> Thanks,
> Stefano
>
> >       simdev = vdpasim_create(&dev_attr);
> >       if (IS_ERR(simdev))
> >               return PTR_ERR(simdev);
> >@@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
> >       .id_table = id_table,
> >       .ops = &vdpasim_net_mgmtdev_ops,
> >       .config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
> >-                           1 << VDPA_ATTR_DEV_NET_CFG_MTU),
> >+                           1 << VDPA_ATTR_DEV_NET_CFG_MTU |
> >+                           1 << VDPA_ATTR_DEV_FEATURES),
> >       .max_supported_vqs = VDPASIM_NET_VQ_NUM,
> >       .supported_features = VDPASIM_NET_FEATURES,
> > };
> >--
> >2.25.1
> >
> >_______________________________________________
> >Virtualization mailing list
> >Virtualization@lists.linux-foundation.org
> >https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
