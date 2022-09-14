Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34307ECAAD3
	for <virtualization@archiver.kernel.org>; Wed, 14 Sep 2022 03:47:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2238240448;
	Wed, 14 Sep 2022 03:47:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2238240448
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gDLMrkx/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0c_-6Qz2d8hq; Wed, 14 Sep 2022 03:47:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 94C5840242;
	Wed, 14 Sep 2022 03:47:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 94C5840242
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FF10C0032;
	Wed, 14 Sep 2022 03:47:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70B25C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Sep 2022 03:47:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3753B403FD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Sep 2022 03:47:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3753B403FD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a35bunrAKhoi
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Sep 2022 03:47:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A0D2D40242
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A0D2D40242
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Sep 2022 03:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663127229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fwI4pxFaOpyghP4nKqCzlpD4iYPI4aC9XKzX8S9lXFE=;
 b=gDLMrkx/TzQCa7MrdzRpGhFWeR4AyfiPNnry+RYL0L1SF/2XYr17BZ79wcJ1jKXBgQ75Nv
 oHwRq2XcBeLhGkl6PeMCfPu1JlQ/A+e+ekr2h/ZyTSJfspoFM5nFQwiEeuZBcG2LwV94MC
 IAF80loRwuYkncC58ydt9RZY3ZIpMuw=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-642-bJqFMcBlNsCuq6QhtUniRg-1; Tue, 13 Sep 2022 23:47:08 -0400
X-MC-Unique: bJqFMcBlNsCuq6QhtUniRg-1
Received: by mail-vs1-f70.google.com with SMTP id
 o5-20020a677305000000b0038c83ee2547so1370181vsc.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Sep 2022 20:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=fwI4pxFaOpyghP4nKqCzlpD4iYPI4aC9XKzX8S9lXFE=;
 b=PYnWebXy5GHWf5B8nQM35gy5SixJTFRtzZs0XB/FW/ipBts8Nx+F1GUuDJrnVjPYWp
 OMBiBczU4Pzgh6kyY0dC3C3Xz2+IuMpOIDu5sQaEjZ2lc5lpZaKiKBwn+I33lfXmFO7R
 eNy0ku6OfKwVty3HU0CtmuU5xVPLRT823+JImcPyaDEPDuDZltwy70xHUuPiLzmvYGJt
 hq9FWY2UYO5ffeUBao1ogsHulv+HItftJeTj4AxY3dIRi77VkNw2hW5cjn/Z44rAX3ee
 PP2YAFqK9Sp6xsoIa2pcYfvCG9LZS8EHTvFDYhvijROUfD0ni3Vo7SKL4gN7eN1+j97Z
 AKaQ==
X-Gm-Message-State: ACgBeo2qU55sd460jO2IVvlKqXeylaNgpogRc1ewV7VifapJt766Ryh5
 H50DaAl2UIxPO50c2Dxt7aWnHJrU+8YkURMB8u3QZw/So0zWSaM12u2oiOzkh35VScDOtvv51M5
 nkrHY+dqimr0erDgct2d5GyjZrF1iOx/VexATGZeOYzubSK1ss52zzSvBmQ==
X-Received: by 2002:a05:6102:1341:b0:398:889e:7f28 with SMTP id
 j1-20020a056102134100b00398889e7f28mr4865561vsl.21.1663127227531; 
 Tue, 13 Sep 2022 20:47:07 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5Ha3KMq4e+ZRq90AitAHpMvWzaF8YgV8fHH5lOzOSmrBmP4SuDkkqvhsU03bmmRyugK+A88DC7xMXq7SvjUso=
X-Received: by 2002:a05:6102:1341:b0:398:889e:7f28 with SMTP id
 j1-20020a056102134100b00398889e7f28mr4865558vsl.21.1663127227296; Tue, 13 Sep
 2022 20:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <CADZGycYUH=j80zmJVr7dfVtoJ+BrbAEPJE8Nvf3HR5oimJR+UQ@mail.gmail.com>
In-Reply-To: <CADZGycYUH=j80zmJVr7dfVtoJ+BrbAEPJE8Nvf3HR5oimJR+UQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 14 Sep 2022 11:46:56 +0800
Message-ID: <CACGkMEvNMDG=9tYAWDOqdYKMy-Sk3qShQX3PWGQZBcdvZ7y3Tw@mail.gmail.com>
Subject: Re: [Q] packet truncated after enabling ip_forward for virtio-net in
 guest
To: Wei Yang <richard.weiyang@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Tue, Sep 13, 2022 at 11:43 PM Wei Yang <richard.weiyang@gmail.com> wrote:
>
> Hi, I am running a guest with vhost-net as backend. After I enable
> ip_forward, the packet received is truncated.
>
> Host runs a 5.10 kernel, while guest kernel is v5.11 which doesn't
> include this commit:
>
>   virtio-net: use NETIF_F_GRO_HW instead of NETIF_F_LRO
>
> After applying this commit, the issue is gone. I guess the reason is
> this device doesn't have NETIF_F_GRO_HW set,

Note that form device POV, it should be VIRTIO_NET_F_GUEST_TSOX.

> so
> virtnet_set_guest_offloads is not called.
>
> I am wondering why packet is truncated without this fix. I follow
> virtnet_set_guest_offloads and just see virtio_net_handle_ctrl in qemu
> handles VIRTIO_NET_CTRL_GUEST_OFFLOADS. Since we use a tap dev, then I
> follow tap_fd_set_offload to ioctl(fd, TUNSETOFFLOAD, offload).
>
> But I am lost here. tap_ioctl -> set_offload(). Since we use a normal
> tap device instead of ipvtap/macvtap, update_features is empty. So I
> don't get how the device's behavior is changed after set LRO.
>
> Do I follow the wrong path? Any suggestions on investigation?

Note that if you are using tuntap, you should refert driver/net/tun.c
instead of tap.c. Where it calls netdev_update_features() that will
change the TX offloading.

Thanks

>
> I'd appreciate it if someone could give a hint :-)
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
