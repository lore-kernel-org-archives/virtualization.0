Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D29C38A2D
	for <virtualization@archiver.kernel.org>; Wed, 26 Oct 2022 10:17:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 017FA40193;
	Wed, 26 Oct 2022 10:17:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 017FA40193
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QtBUWGjb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CqQHBw8ABZdr; Wed, 26 Oct 2022 10:17:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5FE9E4018A;
	Wed, 26 Oct 2022 10:17:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5FE9E4018A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C1F9C0033;
	Wed, 26 Oct 2022 10:17:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3E2FC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Oct 2022 10:17:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9933140193
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Oct 2022 10:17:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9933140193
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IJvXkj5WPk6k
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Oct 2022 10:17:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 208834018A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 208834018A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Oct 2022 10:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666779442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PfHzw1uUDDLd1Skw76XeIS+ol/3nqXCeV9p3xBHmvSE=;
 b=QtBUWGjbt9Pfw8sGVpyU6ibg4Rf/QJHTFcom6n7hiY5rGssZySFk6bIlFlU5cIM/8EQMzg
 9iv7bC855OUFwE853UarZVp9rt7eOLuJe1F8SLWAkdk/gBMXQPJ17YL61WPdigzEgAiUXi
 OmYj6Vhi7ObwzpIxAgMiUe4rFPLWk+Q=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-477-ewrI2HpwPwqXkh0LElcguQ-1; Wed, 26 Oct 2022 06:17:21 -0400
X-MC-Unique: ewrI2HpwPwqXkh0LElcguQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 qf25-20020a1709077f1900b0078c02a23da3so4292833ejc.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Oct 2022 03:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PfHzw1uUDDLd1Skw76XeIS+ol/3nqXCeV9p3xBHmvSE=;
 b=rARA5A/wu1GWD0b4RdNG62EYJP9+x6bAutqljBU1M2Wzqn2IJ1dkRrp3n11HNIQ58H
 UNcgvg4dMml8asmrRCX4Yyvvu+pCzFnnjgOGYUYLo+kwAu+//mFCLNn2cxgFUz2btbl1
 D0kMW3MpIlHgNpttH0XD08D/COYvnqTxPFS5coT3+lplGlLHtlrJw1wtKwu0LqoTtfEI
 h7UhOCLNNqj3663/eq1QoczuYL81CeZ1IoMhUqJ9Wg0P0x4zrD6CgNarA3MVFaPLdKYh
 2Dq1L/NO8eLpsivBdeqwLh9eWmerwR9sTWs+N4N3TmuDQfPOR+iT/LuC3Ng7eikj/rls
 7KoA==
X-Gm-Message-State: ACrzQf3coUoF/kqrUBTWmY8o/Hv7izjX6mSTOMbvwHrSY/9QdQVdW7UH
 XG2QcbobjWfTEKToSK3/r5w/oHWrAZA9bItRieCK6oIPnsQRq0XBAKAkmQzb0ZTdvvhkUzvti4E
 UDkKDNTMHvwa+wKGCPJSD8p0noTzczVK/usYSSLOd2A==
X-Received: by 2002:a05:6402:500d:b0:459:3e56:e6f9 with SMTP id
 p13-20020a056402500d00b004593e56e6f9mr41041560eda.367.1666779440250; 
 Wed, 26 Oct 2022 03:17:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM607CBXEUgwqhrW5hUNFPMaO0HiuTQcCanmGMIa6t/joJBY4H/rQcad/t9kyFk8+TbfkA83RA==
X-Received: by 2002:a05:6402:500d:b0:459:3e56:e6f9 with SMTP id
 p13-20020a056402500d00b004593e56e6f9mr41041533eda.367.1666779439945; 
 Wed, 26 Oct 2022 03:17:19 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-34.retail.telecomitalia.it.
 [87.11.6.34]) by smtp.gmail.com with ESMTPSA id
 sd7-20020a170906ce2700b0078d76ee7543sm2683925ejb.222.2022.10.26.03.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Oct 2022 03:17:19 -0700 (PDT)
Date: Wed, 26 Oct 2022 12:17:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: Issue with VDUSE (QSD vduse-blk export) and vhost-vdpa
Message-ID: <20221026101716.zwl5rkwb7awq4mvw@sgarzare-redhat>
References: <CAGxU2F4zRGASAv4YLoQpfRB-2cvaMij6YZo6t9E+69MZ+8Mong@mail.gmail.com>
 <CACycT3vMVbm94OYtUgB9bS6_pU6FKh1Y6kWPyAxi4rvjUfQ3qg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3vMVbm94OYtUgB9bS6_pU6FKh1Y6kWPyAxi4rvjUfQ3qg@mail.gmail.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Oct 26, 2022 at 05:39:23PM +0800, Yongji Xie wrote:
>Hi Stefano,
>
>On Wed, Oct 26, 2022 at 5:12 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> Hi Xie,
>> I was testing libblkio [1] with QSD vduse-blk export and had some
>> issues.
>>
>> In a nutshell, QSD prints me the following messages when using
>> vhost-vdpa to access the device:
>>
>>   Failed to get vq[0] iova mapping
>>   Failed to update vring for vq[0]
>>
>> This happens only with vhost-vdpa, using virtio-vdpa instead the device
>> works fine.
>> I'm using Linux v6.0 and QEMU master (commit
>> 214a8da23651f2472b296b3293e619fd58d9e212).
>>
>> I haven't had much time to investigate, I hope to do it next week, but
>> maybe it's much faster for you.
>>
>> I saw that ioctl(VDUSE_IOTLB_GET_FD) in libvduse.c returns -1 (EPERM),
>> so IIUC in the kernel vduse_dev_broken() was called, and the device is
>> in a broken state.
>>
>>
>> We will use libblkio in QEMU [2] to access vDPA devices via vhost-vdpa.
>> But I'm doing these tests without QEMU for now, using an example inside
>> the libblkio repo:
>>
>> # Build libblkio and examples
>>     # Fedora/CentOS/RHEL
>>     dnf install -y git meson rust cargo python3-docutils rustfmt
>>     # Debian/Ubuntu
>>     apt-get install -y git meson rustc cargo python3-docutils
>>
>>     git clone https://gitlab.com/libblkio/libblkio.git
>>
>>     cd libblkio
>>     git checkout v1.1.0
>>
>>     meson setup build
>>     meson compile -C build
>>
>>
>> # On terminal 1
>>     modprobe vduse
>>     modprobe vhost-vdpa
>>
>>     qemu-img create -f qcow2 -o preallocation=full /path/to/test.qcow2 1g
>>
>>     qemu-storage-daemon \
>>       --blockdev file,filename=/path/to/test.qcow2,cache.direct=on,aio=native,node-name=file \
>>       --blockdev qcow2,file=file,node-name=qcow2 \
>>       --object iothread,id=iothread0 \
>>       --export vduse-blk,id=vduse0,name=vduse0,num-queues=1,node-name=qcow2,writable=on,iothread=iothread0
>>
>>
>> # On terminal 2
>>     vdpa dev add name vduse0 mgmtdev vduse
>>
>>     cd libblkio/build
>>
>>     # blkio-bench executes
>>     ./examples/blkio-bench virtio-blk-vhost-vdpa \
>>       path=/dev/vhost-vdpa-0 --runtime=5 --readwrite=randread
>>
>>     # after this step, QSD (running on terminal 1) prints the following messages:
>>       Failed to get vq[0] iova mapping
>>       Failed to update vring for vq[0]
>>
>> I don't know if I'm doing something wrong or in libblkio we have some
>> issue, but using vdpa-sim-blk works correctly, so maybe there is
>> something in vduse that is missing.
>>
>> Any help or suggestion is welcome :-)
>>
>
>I'd like to know whether bio-bench uses the shared memory
>(tmpfs/hugetlbfs) as the vdpa memory region. This is what VDUSE needs.

Okay, so IIUC every memory regions should have an associated fd.

The buffers in libblkio are already allocated in this way, but it is not 
true for the virtqueue memory, I'll change it and test.

Thanks for the help :-)
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
