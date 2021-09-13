Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70989C433EF
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 16:19:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2291F60FA0
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 16:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2291F60FA0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E627B80C55;
	Mon, 13 Sep 2021 16:19:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kUZnoFuuUbj6; Mon, 13 Sep 2021 16:19:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8ACAE80C0B;
	Mon, 13 Sep 2021 16:19:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C92BC0011;
	Mon, 13 Sep 2021 16:19:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8565C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 16:19:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A59F040131
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 16:19:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XYcNLldBTGPx
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 16:19:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C002B40004
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 16:19:09 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id h133so14764734oib.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 09:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=N/xWzsBvqbn7jaeScL3f3s2ZA+9ZXt9gbvH0hh2wYqs=;
 b=RQ7hh2BPtVQZCJRpUOs9J8RxaFes0UR5KxWnf1sYxhufmrjNmW2didexyDITFZdsxC
 Kvghcihb327Yic4NNqHkQyNXtCmj8oSYQhjONbUbocrdgBxlGaKHrDE5SWd4I9YquUc0
 WenkrxhySOFXNmrd8Vj7BM+jehzX+H40j5ioqeaw34F5FPyARB7L7HgurPoa2CG7WlsO
 qWkbVVfRUgGmnC1CnbVCLRTFiXOdiEjVccsieju0hDofc4gktQJjl2/U6F6d67tMQIFb
 VmOZiXxeB7i1a7f4y02oiA0OLralUSa22zrW8QKQwjJqzvioMuAh1Q3NIeq6ChX1Nsvz
 +reg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=N/xWzsBvqbn7jaeScL3f3s2ZA+9ZXt9gbvH0hh2wYqs=;
 b=fJv9juEVh83Dry9KhVgpFGsWORuz6iW9VvW0Pmog6jlk1Nfh9f48au5oLqrGrk6mgL
 zpMtMjNKv8R36vRVo5nJiNnyWdmE8E/NKHwEHAJtvtNCQs8l34bZU6zC9J+V7o+7VIkU
 PMHRnAPUdMTV/VPHez0P1nDxHAha01k7G7ywGO+F/Q7LDbUjUrkabaZ/nIE1+9Gy/GFg
 zaDZEtL2z1jz09hwciOXq92eUGdp96+xK2g3Fkzt72VQ/o6sYscckE3Z1kEOvLHCFjvp
 4kx0LZ6vp0wbxoANiDrIm1MUQDavbS3bT7Gqhg47FiPNZhiNlSQp5/AzEOz5rO1OVzgg
 DIRA==
X-Gm-Message-State: AOAM532djyGZ99EydiCn1ND9oEMDwfUNfpFT6MBmkZVgTGSZct9LRdEh
 e3OWIvVEEyDFF087R8BZNIo=
X-Google-Smtp-Source: ABdhPJy8IIqfMvGEvR4RTQ17OcjoZehc+ZdejnMHeNu4ua85Usp8hsBvX6aPh4XYk6wkuD65e3OEKA==
X-Received: by 2002:a05:6808:3a3:: with SMTP id
 n3mr8437749oie.41.1631549948824; 
 Mon, 13 Sep 2021 09:19:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 w12sm1789648oie.41.2021.09.13.09.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 09:19:08 -0700 (PDT)
Date: Mon, 13 Sep 2021 09:19:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 5/5] virtio: Bind virtio device to device-tree node
Message-ID: <20210913161907.GA176753@roeck-us.net>
References: <cover.1627273794.git.viresh.kumar@linaro.org>
 <454a58f998b0d16847d72a97b32192829fab2c8c.1627273794.git.viresh.kumar@linaro.org>
 <20210913144905.GA1267554@roeck-us.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210913144905.GA1267554@roeck-us.net>
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Bill Mills <bill.mills@linaro.org>
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

On Mon, Sep 13, 2021 at 07:49:07AM -0700, Guenter Roeck wrote:
> On Mon, Jul 26, 2021 at 10:21:45AM +0530, Viresh Kumar wrote:
> > Bind the virtio devices with their of_node. This will help users of the
> > virtio devices to mention their dependencies on the device in the DT
> > itself. Like GPIO pin users can use the phandle of the device node, or
> > the node may contain more subnodes to add i2c or spi eeproms and other
> > users.
> > 
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> This patch causes a boot failure on sparc64: The virtio device no longer
> instantiates. Reverting this patch fixes the problem. Bisect log attached.
> 

In case it matters: The problem is here:

+       if (!of_device_is_compatible(np, compat)) {
+               ret = -EINVAL;
+               goto out;
+       }

Guenter

> Guenter
> 
> ---
> # bad: [6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f] Linux 5.15-rc1
> # good: [926de8c4326c14fcf35f1de142019043597a4fac] Merge tag 'acpi-5.15-rc1-3' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> git bisect start 'HEAD' '926de8c4326c'
> # good: [8177a5c96229ff24da1e362789e359b68b4f34f5] Merge tag 'libata-5.15-2021-09-11' of git://git.kernel.dk/linux-block
> git bisect good 8177a5c96229ff24da1e362789e359b68b4f34f5
> # bad: [78e709522d2c012cb0daad2e668506637bffb7c2] Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost
> git bisect bad 78e709522d2c012cb0daad2e668506637bffb7c2
> # bad: [7bc7f61897b66bef78bb5952e3d1e9f3aaf9ccca] Documentation: Add documentation for VDUSE
> git bisect bad 7bc7f61897b66bef78bb5952e3d1e9f3aaf9ccca
> # bad: [41116599a0731f4cd451e9d191d879ab45e31945] virtio/vsock: add 'VIRTIO_VSOCK_SEQ_EOR' bit.
> git bisect bad 41116599a0731f4cd451e9d191d879ab45e31945
> # good: [5262912ef3cfc5e518892c3d67fb36412cb813e2] vdpa/mlx5: Add support for control VQ and MAC setting
> git bisect good 5262912ef3cfc5e518892c3d67fb36412cb813e2
> # good: [7f815fce08d563006e43d1b7d2f9a0a4f3b832f3] dt-bindings: i2c: Add bindings for i2c-virtio
> git bisect good 7f815fce08d563006e43d1b7d2f9a0a4f3b832f3
> # good: [d5a8680dfab0547a4ecd708b1fe9de48598a6757] uapi: virtio_ids: Sync ids with specification
> git bisect good d5a8680dfab0547a4ecd708b1fe9de48598a6757
> # bad: [9af8f1061646e8e22b66413bedf7b3e2ab3d69e5] virtio/vsock: rename 'EOR' to 'EOM' bit.
> git bisect bad 9af8f1061646e8e22b66413bedf7b3e2ab3d69e5
> # bad: [694a1116b405d887c893525a6766b390989c8606] virtio: Bind virtio device to device-tree node
> git bisect bad 694a1116b405d887c893525a6766b390989c8606
> # first bad commit: [694a1116b405d887c893525a6766b390989c8606] virtio: Bind virtio device to device-tree node
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
