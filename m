Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5F8C433FE
	for <virtualization@archiver.kernel.org>; Wed, 26 Oct 2022 09:12:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28261607F4;
	Wed, 26 Oct 2022 09:12:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 28261607F4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=asgaYrAU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YhYEskEt2m7R; Wed, 26 Oct 2022 09:12:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8D76960A4F;
	Wed, 26 Oct 2022 09:12:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D76960A4F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 647D0C0032;
	Wed, 26 Oct 2022 09:12:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B446C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Oct 2022 09:12:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 366B460AFD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Oct 2022 09:12:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 366B460AFD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 95PLB4IiSdAy
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Oct 2022 09:12:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2AC3960AD8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2AC3960AD8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Oct 2022 09:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666775545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=5xNkruRiJnIiOSQrrYHGPH2e+vVoDqGR1JcaSONjqvk=;
 b=asgaYrAUy+yyKB0TBOA8Jq0Njs50rNkhWBBroaicUGvDDoHW/ips3w8lzlkhHSYSSNamBm
 HiN0oKXiYid/a/stpQ9I92qYEG37PmP2bM2IfiJklao3YIbfMfcnhWLRhQpsqiLsXq1JPU
 XkAVVPkx/QbRixFs02KlTmN5IZ2AsNo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-572-rPr_HxNkM9-O2XEiyQz-HA-1; Wed, 26 Oct 2022 05:12:19 -0400
X-MC-Unique: rPr_HxNkM9-O2XEiyQz-HA-1
Received: by mail-wr1-f71.google.com with SMTP id
 w23-20020adf8bd7000000b002358f733307so5798634wra.17
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Oct 2022 02:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5xNkruRiJnIiOSQrrYHGPH2e+vVoDqGR1JcaSONjqvk=;
 b=dU9vV/r0nEX09XFmUladX69fLQxHwXEW7+AXS0VcU25PPIKtmjpwaljUqDfUkynMnT
 md1HMijr7Quu56tsaTxn0FrxHWLX9Q3Ibucl1WXKBmjeXcBAAf2UODkqAs1AfFwnAhGe
 4eq4pi58wUC8txioxehWP9sXA+bYlLxtbvr/YSYJ1Cf/BmH6kUtwdgO9TZqaelwCZ8nH
 jKf78gPIg2FTWBawvnBxQ25JPM2edTilvZMFhs5M2RVGTD60ovEq490huBY/lvHX4byb
 pHzsD6iwLJg4kSxr2vrN+Vz50DRqv8AJxZZOAyiHb9mElfPuPya90oOrrXGmR9vH1rD0
 9cmA==
X-Gm-Message-State: ACrzQf3ezr64i/4gSKeKYCHuynRAskQuVY4KuvY8ve0Yb9LvcUYw9/O1
 0MAHaiMCDGq/S6T2nO+d/ZvQsrsXVGmNKuRb5CdfP2JidRP3R1Uh4kQvww/LvdFjRKYw7Lc//YY
 zedyNgrrNqWQ2CGCXxSHzRraLFh6P1nR4ix4t4+vcMg==
X-Received: by 2002:a05:600c:3147:b0:3c6:f871:1fec with SMTP id
 h7-20020a05600c314700b003c6f8711fecmr1709601wmo.71.1666775538552; 
 Wed, 26 Oct 2022 02:12:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7idyMh4A58fzq3JEftOywVimGTAari7nGWN9abaxQpXAUmUwLzSihveVvwWD8Ab2kRm6uTLQ==
X-Received: by 2002:a05:600c:3147:b0:3c6:f871:1fec with SMTP id
 h7-20020a05600c314700b003c6f8711fecmr1709579wmo.71.1666775538308; 
 Wed, 26 Oct 2022 02:12:18 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-34.retail.telecomitalia.it.
 [87.11.6.34]) by smtp.gmail.com with ESMTPSA id
 m17-20020a056000009100b0022eafed36ebsm4798032wrx.73.2022.10.26.02.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Oct 2022 02:12:17 -0700 (PDT)
Date: Wed, 26 Oct 2022 11:12:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Issue with VDUSE (QSD vduse-blk export) and vhost-vdpa
Message-ID: <CAGxU2F4zRGASAv4YLoQpfRB-2cvaMij6YZo6t9E+69MZ+8Mong@mail.gmail.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Michael Tsirkin <mst@redhat.com>, qemu devel list <qemu-devel@nongnu.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
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

Hi Xie,
I was testing libblkio [1] with QSD vduse-blk export and had some 
issues.

In a nutshell, QSD prints me the following messages when using 
vhost-vdpa to access the device:

  Failed to get vq[0] iova mapping
  Failed to update vring for vq[0]

This happens only with vhost-vdpa, using virtio-vdpa instead the device 
works fine.
I'm using Linux v6.0 and QEMU master (commit 
214a8da23651f2472b296b3293e619fd58d9e212).

I haven't had much time to investigate, I hope to do it next week, but 
maybe it's much faster for you.

I saw that ioctl(VDUSE_IOTLB_GET_FD) in libvduse.c returns -1 (EPERM), 
so IIUC in the kernel vduse_dev_broken() was called, and the device is 
in a broken state.


We will use libblkio in QEMU [2] to access vDPA devices via vhost-vdpa.  
But I'm doing these tests without QEMU for now, using an example inside 
the libblkio repo:

# Build libblkio and examples
    # Fedora/CentOS/RHEL
    dnf install -y git meson rust cargo python3-docutils rustfmt
    # Debian/Ubuntu
    apt-get install -y git meson rustc cargo python3-docutils

    git clone https://gitlab.com/libblkio/libblkio.git

    cd libblkio
    git checkout v1.1.0

    meson setup build
    meson compile -C build


# On terminal 1
    modprobe vduse
    modprobe vhost-vdpa

    qemu-img create -f qcow2 -o preallocation=full /path/to/test.qcow2 1g

    qemu-storage-daemon \
      --blockdev file,filename=/path/to/test.qcow2,cache.direct=on,aio=native,node-name=file \
      --blockdev qcow2,file=file,node-name=qcow2 \
      --object iothread,id=iothread0 \
      --export vduse-blk,id=vduse0,name=vduse0,num-queues=1,node-name=qcow2,writable=on,iothread=iothread0


# On terminal 2
    vdpa dev add name vduse0 mgmtdev vduse

    cd libblkio/build

    # blkio-bench executes
    ./examples/blkio-bench virtio-blk-vhost-vdpa \
      path=/dev/vhost-vdpa-0 --runtime=5 --readwrite=randread

    # after this step, QSD (running on terminal 1) prints the following messages:
      Failed to get vq[0] iova mapping
      Failed to update vring for vq[0]

I don't know if I'm doing something wrong or in libblkio we have some 
issue, but using vdpa-sim-blk works correctly, so maybe there is 
something in vduse that is missing.

Any help or suggestion is welcome :-)

Thanks,
Stefano

[1] https://libblkio.gitlab.io/libblkio/
[2] 
https://lore.kernel.org/qemu-devel/20221013185908.1297568-1-stefanha@redhat.com/

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
