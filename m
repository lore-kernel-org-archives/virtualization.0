Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233761990A7
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Aug 2024 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724700183; cv=none; b=UPwtlWNIA7jX3VQvGCdLbekzeqITUC4OKPukEXqfsrQyA+VsXXz1dMlnRx+vJDlw4HS3r1mZQGb7mgi6e7iFA4O0aHTW3Grfp3q9k9As2KQwE0dj/N4zAnvGSOlEH5lWxlNSZwXdUdfdlTbyjfKOw/l2rQZNH6I9ht9TYJAuOoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724700183; c=relaxed/simple;
	bh=tDJNUr27zxTQ4SUunjdZ0ylIYlgXCyM8c00NYRgGDuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=plQpIu+1UJx0Cq1e/Zko38ALme4ohd0kd7V4D64w81XyKrbOVbg7ephIYUnZrfUB1MlWL/6+JEck7R/419Hc0zw4y0yM+k5CxksNhnNndtVo7ERo5WnxrYZXrm+CWoomC+88eAiv7OGhIRfR+dPqKRWpOPqZQQl06yY1nUd6ER0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=QDDRs32u; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="QDDRs32u"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9E586079A
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Aug 2024 19:23:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r3M6HQ3gFBmA for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Aug 2024 19:23:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b35; helo=mail-yb1-xb35.google.com; envelope-from=cbilbao@digitalocean.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CB7E86078C
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB7E86078C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=digitalocean.com header.i=@digitalocean.com header.a=rsa-sha256 header.s=google header.b=QDDRs32u
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CB7E86078C
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Aug 2024 19:23:00 +0000 (UTC)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-e116ec43a4aso5265302276.0
        for <virtualization@lists.linux-foundation.org>; Mon, 26 Aug 2024 12:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1724700179; x=1725304979; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F6LqBt/cgf5saFNqougCditEz5JCrr5uJaPi0WKZXWo=;
        b=QDDRs32utuaNhJ5GsTLy1BLCRC89PKf4BzeJSRstsFJv2xDeVOtlvNOzbPPlCenjFf
         4SpI82cCx1U7LKypug1TY25o5PwG9/7bmV5QPFCL1Sh2yIidA+wuwETheiAT9GRnLA6A
         wxLQcQRlVaby+FjtMcMVKvQw3FXeXg5LEEWQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724700179; x=1725304979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F6LqBt/cgf5saFNqougCditEz5JCrr5uJaPi0WKZXWo=;
        b=TsnVhYnyIB2wRo/Q7kWQSxH03JXNgdhYD2Czyd1b1/FagUtMicygt7nVfzZ0PTtjoJ
         p8QPGwWhPIA6vjkKUHHEYOUbPgFic8oRBB1NSC701P/UIm4+H2N5WzTOhgikhFFOi041
         n2uJ8NAJLU5r0Qd/XLU2SU3TdvMg4e1L9YSrsSkm4sBOARngT/em648pvL+0uOAjAI8e
         Nun6Ap+okfQkhZphXlUcw94JuhNbLyGfXNuzJpmBivWkO1OjYipRJ+EP4RwRVF52saqP
         uU7cxndwgaAKqgM32WgeCaL/E4xdCBlEGNZyxnfdHmSTIU+kEYn1K4PYNvtmOa/H1Zun
         o9CQ==
X-Gm-Message-State: AOJu0Yxw/pEfekXjREKNJIrmfclWIZI04Vumh5TA42dVHtuF/XGc5cf6
	mBMR9Ht06hEwYOlk7mKd3XdEoQyaQKZdepCXaUjr/zq5VL4kf09PicD/5NrDzhY=
X-Google-Smtp-Source: AGHT+IENvO39dZD8SM8XQUS6jkNMVVXZUu4Li0XJ01QpUNqrH5VA9EYbqM15qZGvjmYzMuTP3QTLBw==
X-Received: by 2002:a05:690c:1d:b0:664:5957:f7a with SMTP id 00721157ae682-6c624dca095mr146931867b3.15.1724700179081;
        Mon, 26 Aug 2024 12:22:59 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:45f:f211:3a7c:9377? ([2603:8080:7400:36da:45f:f211:3a7c:9377])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39d3a9a93sm16400567b3.89.2024.08.26.12.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 12:22:58 -0700 (PDT)
Message-ID: <1cb17652-3437-472e-b8d5-8078ba232d60@digitalocean.com>
Date: Mon, 26 Aug 2024 14:22:57 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Why is set_config not supported in mlx5_vnet?
To: Dragos Tatulea <dtatulea@nvidia.com>, eli@mellanox.com, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, eperezma@redhat.com,
 sashal@kernel.org, yuehaibing@huawei.com, steven.sistare@oracle.com
References: <33feec1a-2c5d-46eb-8d66-baa802130d7f@digitalocean.com>
 <afcbf041-7613-48e6-8088-9d52edd907ff@nvidia.com>
 <8a15a46a-2744-4474-8add-7f6fb35552b3@digitalocean.com>
 <2a1a4dfb-aef1-47c1-81ce-b29ed302c923@nvidia.com>
Content-Language: en-US
From: Carlos Bilbao <cbilbao@digitalocean.com>
In-Reply-To: <2a1a4dfb-aef1-47c1-81ce-b29ed302c923@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On 8/26/24 10:53 AM, Dragos Tatulea wrote:
>
> On 26.08.24 16:26, Carlos Bilbao wrote:
>> Hello Dragos,
>>
>> On 8/26/24 4:06 AM, Dragos Tatulea wrote:
>>> On 23.08.24 18:54, Carlos Bilbao wrote:
>>>> Hello,
>>>>
>>>> I'm debugging my vDPA setup, and when using ioctl to retrieve the
>>>> configuration, I noticed that it's running in half duplex mode:
>>>>
>>>> Configuration data (24 bytes):
>>>>   MAC address: (Mac address)
>>>>   Status: 0x0001
>>>>   Max virtqueue pairs: 8
>>>>   MTU: 1500
>>>>   Speed: 0 Mb
>>>>   Duplex: Half Duplex
>>>>   RSS max key size: 0
>>>>   RSS max indirection table length: 0
>>>>   Supported hash types: 0x00000000
>>>>
>>>> I believe this might be contributing to the underperformance of vDPA.
>>> mlx5_vdpa vDPA devicess currently do not support the VIRTIO_NET_F_SPEED_DUPLEX
>>> feature which reports speed and duplex. You can check the state on the
>>> PF.
>>
>> According to ethtool, all my devices are running at full duplex. I assume I
>> can disregard this configuration output from the module then.
>>
> Yep.
>
>>>> While looking into how to change this option for Mellanox, I read the following
>>>> kernel code in mlx5_vnet.c:
>>>>
>>>> static void mlx5_vdpa_set_config(struct vdpa_device *vdev, unsigned int offset, const void *buf,
>>>>                  unsigned int len)
>>>> {
>>>>     /* not supported */
>>>> }
>>>>
>>>> I was wondering why this is the case.
>>> TBH, I don't know why it was not added. But in general, the control VQ is the
>>> better way as it's dynamic.
>>>
>>>> Is there another way for me to change
>>>> these configuration settings?
>>>>
>>> The configuration is done using control VQ for most things (MTU, MAC, VQs,
>>> etc). Make sure that you have the CTRL_VQ feature set (should be on by
>>> default). It should appear in `vdpa mgmtdev show` and `vdpa dev config
>>> show`.
>>
>> I see that CTRL_VQ is indeed enabled. Is there any documentation on how to
>> use the control VQ to get/set vDPA configuration values?
>>
>>
> You are most likely using it already through through qemu. You can check
> if the CTR_VQ feature also shows up in the output of `vdpa dev config show`.
>
> What values are you trying to configure btw?


Yes, CTRL_VQ also shows up in vdpa dev config show. There isn't a specific
value I want to configure ATM, but my vDPA isn't performing as expected, so
I'm investigating potential issues. Below is the code I used to retrieve
the configuration from the driver; I'd be happy to send it as a patch if
you or someone else reviews it.


>
> Thanks,
> Dragos


Thanks,
Carlos

---

From ab6ea66c926eaf1e95eb5d73bc23183e0021ee27 Mon Sep 17 00:00:00 2001
From: Carlos Bilbao <bilbao@vt.edu>
Date: Sat, 24 Aug 2024 00:24:56 +0000
Subject: [PATCH] mlx5: Add support to update the vDPA configuration

This is needed for VHOST_VDPA_SET_CONFIG.

Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index b56aae3f7be3..da31c743b2b9 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2909,14 +2909,32 @@ static void mlx5_vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
     struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
     struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);

-    if (offset + len <= sizeof(struct virtio_net_config))
+    if (offset + len <= sizeof(struct virtio_net_config)) {
         memcpy(buf, (u8 *)&ndev->config + offset, len);
+        }
+        else
+        {
+            printk(KERN_ERR "%s: Offset and length out of bounds\n",
+            __func__);
+        }
+
 }

 static void mlx5_vdpa_set_config(struct vdpa_device *vdev, unsigned int offset, const void *buf,
                  unsigned int len)
 {
-    /* not supported */
+    struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
+    struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
+
+    if (offset + len <= sizeof(struct virtio_net_config))
+    {
+        memcpy((u8 *)&ndev->config + offset, buf, len);
+    }
+    else
+    {
+        printk(KERN_ERR "%s: Offset and length out of bounds\n",
+        __func__);
+    }
 }

 static u32 mlx5_vdpa_get_generation(struct vdpa_device *vdev)
--
2.34.1


