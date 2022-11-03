Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2910BC4332F
	for <virtualization@archiver.kernel.org>; Thu,  3 Nov 2022 10:38:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8D6781ED2;
	Thu,  3 Nov 2022 10:38:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A8D6781ED2
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b9Qp4qGT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OHVVXHy-eA7j; Thu,  3 Nov 2022 10:38:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 313D681E72;
	Thu,  3 Nov 2022 10:38:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 313D681E72
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07686C0032;
	Thu,  3 Nov 2022 10:38:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EBADC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Nov 2022 10:38:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 156E060F8D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Nov 2022 10:38:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 156E060F8D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=b9Qp4qGT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Na3LtJNK-t2c
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Nov 2022 10:38:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D826760009
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D826760009
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Nov 2022 10:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667471880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SbDC2Mwl9eSSBsT2AW5/yGipvZuHluLgyKkgXCaE6v8=;
 b=b9Qp4qGTQ0E8UlyEwXsEaaX8a0IAjxqpu8gJY9rOo2WpEVIiHgdMmCeoNZCyy34Hd14BTL
 KIF/0ecC9SfhUFhWIKa0iGw8VLL1faW/9PS9XUXWuO8CloEymRPN3/NJfgOO782PvlmD1w
 vUC5SX3KytmvZfyZ8xL/nPg8gyyNjGY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-642-PTb48WFkNfeZzIqsrBUgUg-1; Thu, 03 Nov 2022 06:37:59 -0400
X-MC-Unique: PTb48WFkNfeZzIqsrBUgUg-1
Received: by mail-ed1-f70.google.com with SMTP id
 x18-20020a05640226d200b00461e027f704so1074164edd.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Nov 2022 03:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SbDC2Mwl9eSSBsT2AW5/yGipvZuHluLgyKkgXCaE6v8=;
 b=ny5ZNTL0VF4sLTAh+8JQO3ENW8tyFiEz9XEVCclsSKD0aAM3HQ47c07S5J+rBh9o5h
 n0jgs/rliPhGS3UYFytSDM28WWVZizATSOyCWVGy6KejrCR7keHI/fbsiLVpcmEWEu6W
 jEuqbXTGnkL1wnlfkCv/u5qFxuifVgMxmw28+fcy8zswi6Yszw5sP8Z4sq+VllOyzPi2
 REhKzEGBoTH/HJH/lvxKfAlfIs3n4nWhZH7kfuhW6nd8jdaKLIefZcVqzf9k5dc9ptai
 OizizhZDsMQJgz+SqXBKHfgrryTtpSZuwMSwLyta7TOLbQAaDvH9lLLQY0IGTcPTCAM7
 +c4A==
X-Gm-Message-State: ACrzQf1bL8NncPP+WvVKM3X1aY2Cq29tQLk+D76dPQUMxM3Gk2WIYQL5
 2tdeK/i5FKvqLugeA+I4Cqo2BynjLG8Hld1Otoz/lGP5IuB/el/0fSmh2UvTV3y3ppoKZtR6/5p
 LqB/44IDXGg+Ouy254Lnuu+v/q0pF/M8AHWhVhjR4BrV9vydIqJZ3XP8qoQ==
X-Received: by 2002:a05:6402:2706:b0:461:b93c:cbd8 with SMTP id
 y6-20020a056402270600b00461b93ccbd8mr29395152edd.254.1667471878504; 
 Thu, 03 Nov 2022 03:37:58 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4o9yL+UzbJkKeWvVim3Pe3D08A7aJByKoGyKI16Zs6APXYV/pgxadWJ/3vZMntPofFWH1YOsLOGCwJl6JjD/k=
X-Received: by 2002:a05:6402:2706:b0:461:b93c:cbd8 with SMTP id
 y6-20020a056402270600b00461b93ccbd8mr29395127edd.254.1667471878294; Thu, 03
 Nov 2022 03:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAGxU2F4zRGASAv4YLoQpfRB-2cvaMij6YZo6t9E+69MZ+8Mong@mail.gmail.com>
 <CACycT3vMVbm94OYtUgB9bS6_pU6FKh1Y6kWPyAxi4rvjUfQ3qg@mail.gmail.com>
 <20221026101716.zwl5rkwb7awq4mvw@sgarzare-redhat>
In-Reply-To: <20221026101716.zwl5rkwb7awq4mvw@sgarzare-redhat>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 3 Nov 2022 11:37:46 +0100
Message-ID: <CAGxU2F7Fyxw3UkZK=b2SwS5YrriThYaRGDiF9W4MCCC4MSA6xA@mail.gmail.com>
Subject: Re: Issue with VDUSE (QSD vduse-blk export) and vhost-vdpa
To: Yongji Xie <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Wed, Oct 26, 2022 at 12:17 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Wed, Oct 26, 2022 at 05:39:23PM +0800, Yongji Xie wrote:
> >Hi Stefano,
> >
> >On Wed, Oct 26, 2022 at 5:12 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >>
> >> Hi Xie,
> >> I was testing libblkio [1] with QSD vduse-blk export and had some
> >> issues.
> >>
> >> In a nutshell, QSD prints me the following messages when using
> >> vhost-vdpa to access the device:
> >>
> >>   Failed to get vq[0] iova mapping
> >>   Failed to update vring for vq[0]
> >>
> >> This happens only with vhost-vdpa, using virtio-vdpa instead the device
> >> works fine.
> >> I'm using Linux v6.0 and QEMU master (commit
> >> 214a8da23651f2472b296b3293e619fd58d9e212).
> >>
> >> I haven't had much time to investigate, I hope to do it next week, but
> >> maybe it's much faster for you.
> >>
> >> I saw that ioctl(VDUSE_IOTLB_GET_FD) in libvduse.c returns -1 (EPERM),
> >> so IIUC in the kernel vduse_dev_broken() was called, and the device is
> >> in a broken state.
> >>
> >>
> >> We will use libblkio in QEMU [2] to access vDPA devices via vhost-vdpa.
> >> But I'm doing these tests without QEMU for now, using an example inside
> >> the libblkio repo:
> >>
> >> # Build libblkio and examples
> >>     # Fedora/CentOS/RHEL
> >>     dnf install -y git meson rust cargo python3-docutils rustfmt
> >>     # Debian/Ubuntu
> >>     apt-get install -y git meson rustc cargo python3-docutils
> >>
> >>     git clone https://gitlab.com/libblkio/libblkio.git
> >>
> >>     cd libblkio
> >>     git checkout v1.1.0
> >>
> >>     meson setup build
> >>     meson compile -C build
> >>
> >>
> >> # On terminal 1
> >>     modprobe vduse
> >>     modprobe vhost-vdpa
> >>
> >>     qemu-img create -f qcow2 -o preallocation=full /path/to/test.qcow2 1g
> >>
> >>     qemu-storage-daemon \
> >>       --blockdev file,filename=/path/to/test.qcow2,cache.direct=on,aio=native,node-name=file \
> >>       --blockdev qcow2,file=file,node-name=qcow2 \
> >>       --object iothread,id=iothread0 \
> >>       --export vduse-blk,id=vduse0,name=vduse0,num-queues=1,node-name=qcow2,writable=on,iothread=iothread0
> >>
> >>
> >> # On terminal 2
> >>     vdpa dev add name vduse0 mgmtdev vduse
> >>
> >>     cd libblkio/build
> >>
> >>     # blkio-bench executes
> >>     ./examples/blkio-bench virtio-blk-vhost-vdpa \
> >>       path=/dev/vhost-vdpa-0 --runtime=5 --readwrite=randread
> >>
> >>     # after this step, QSD (running on terminal 1) prints the following messages:
> >>       Failed to get vq[0] iova mapping
> >>       Failed to update vring for vq[0]
> >>
> >> I don't know if I'm doing something wrong or in libblkio we have some
> >> issue, but using vdpa-sim-blk works correctly, so maybe there is
> >> something in vduse that is missing.
> >>
> >> Any help or suggestion is welcome :-)
> >>
> >
> >I'd like to know whether bio-bench uses the shared memory
> >(tmpfs/hugetlbfs) as the vdpa memory region. This is what VDUSE needs.
>
> Okay, so IIUC every memory regions should have an associated fd.
>
> The buffers in libblkio are already allocated in this way, but it is not
> true for the virtqueue memory, I'll change it and test.

I just changed the virtqueue memory allocation as you suggested, and it worked!

MR here: https://gitlab.com/libblkio/libblkio/-/merge_requests/141

Thanks for the help,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
