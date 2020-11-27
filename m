Return-Path: <SRS0=QmqV=FB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FBDC6379D
	for <virtualization@archiver.kernel.org>; Fri, 27 Nov 2020 15:44:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DEED20B80
	for <virtualization@archiver.kernel.org>; Fri, 27 Nov 2020 15:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ih/zFYcz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DEED20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BE18287C71;
	Fri, 27 Nov 2020 15:44:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nxZB+6VLyBMX; Fri, 27 Nov 2020 15:44:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C4E1E878E1;
	Fri, 27 Nov 2020 15:44:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AEE8DC163C;
	Fri, 27 Nov 2020 15:44:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C80E1C0052
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Nov 2020 15:44:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B536787A66
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Nov 2020 15:44:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hJ5hRwIU2Xcw
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Nov 2020 15:44:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 57A8687A65
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Nov 2020 15:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606491854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ml9rGsGgQezbwICp/zJeAIuWLYNdNW9vQx+fmZ4ZKDw=;
 b=Ih/zFYczIDxi7aAk6L6Ls8eO3DE3eY4Mbg/MDpSRSjrDIE7doYFjHnur3jXV2S9ddQlERV
 i+w6UTv1japnCqq36EhF+x5Fz7c9lcHrL8kbwvQf8kUnu38C2pgrxYUXzavbjDoC7EA6m+
 oa+siw4nkgAdWJDkDoQf3DnFKyzR2BE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-ntLXGGblOo2SkgKOup53Qw-1; Fri, 27 Nov 2020 10:44:10 -0500
X-MC-Unique: ntLXGGblOo2SkgKOup53Qw-1
Received: by mail-wm1-f69.google.com with SMTP id y187so3343751wmy.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Nov 2020 07:44:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=7ZMptySEVF+qxp46nt0WeS28nH29hpHOpjHUabFK4vI=;
 b=SvfBFWeFyXhOf224wOPggSZjDizKnhgxAZ8UB2wB/byzkzFjuUmnpJyb1k2iUSNAy7
 hsO0R3CdQRHZ4mmJWB2gcMHZ/wmgotwp42tQr/89qCkbIy3l1gTGSuOueQ7+2KYVkWmi
 k6rLwxMFhwCfn5voILEqPQAnlV1cXgCaj7wm9wBb3BNgpOWjxJRj/JFpMMT2o88Fjn77
 urmjW0PdvR3RccXHY4CxPC7jsgUmycVbpj8Csk2dQc5Qo4fYNAmZXNmQeK32BKjyuxCR
 dcegZluf2dmPjFhHXHOgnF8ZgGD1ytN+6U5vS2QtP2z/tLyq6GyXQ9SJelZV8h/K/7HP
 3+vQ==
X-Gm-Message-State: AOAM531bDfSKrd7Tx0uIVveCZ9eQnFiQ60NknPBSaoXjWBT5inlHZgIT
 /au3KL+tvqbjS/Of2SltuGK7WTmfFNZlL2iHSfAbOjeWvQjy4+JNn+vrnUNViRjn8mfhqbCC5Ju
 jnrS/ckxxtd60thh2K2rJC9AQjlryT5DnJPjunIf6CA==
X-Received: by 2002:a1c:1982:: with SMTP id 124mr9831270wmz.74.1606491849340; 
 Fri, 27 Nov 2020 07:44:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytxW8ZnvAV68ZiceF5w4J07tAVGsS+GFr6oOgADr9NuCD3xPvI6HRJ+H6eMt9FwWNO3X7TYw==
X-Received: by 2002:a1c:1982:: with SMTP id 124mr9831237wmz.74.1606491849069; 
 Fri, 27 Nov 2020 07:44:09 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it.
 [79.17.248.175])
 by smtp.gmail.com with ESMTPSA id p19sm16051757wrg.18.2020.11.27.07.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2020 07:44:08 -0800 (PST)
Date: Fri, 27 Nov 2020 16:44:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [RFC PATCH 00/27] vDPA software assisted live migration
Message-ID: <20201127154405.uobkujyhd7fuv7nx@steredhat>
References: <20201120185105.279030-1-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201120185105.279030-1-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Daniel Daly <dandaly0@gmail.com>,
 virtualization@lists.linux-foundation.org, Liran Alon <liralon@gmail.com>,
 Eli Cohen <eli@mellanox.com>, Nitin Shrivastav <nitin.shrivastav@broadcom.com>,
 Alex Barba <alex.barba@broadcom.com>,
 Christophe Fontaine <cfontain@redhat.com>, Lee Ballard <ballle98@gmail.com>,
 Lars Ganrot <lars.ganrot@gmail.com>, Rob Miller <rob.miller@broadcom.com>,
 Howard Cai <howard.cai@gmail.com>, Parav Pandit <parav@mellanox.com>,
 vm <vmireyno@marvell.com>, Salil Mehta <mehta.salil.lnk@gmail.com>,
 Stephen Finucane <stephenfin@redhat.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Sean Mooney <smooney@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jim Harford <jim.harford@broadcom.com>,
 Dmytro Kazantsev <dmytro.kazantsev@gmail.com>, Siwei Liu <loseweigh@gmail.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Michael Lilja <ml@napatech.com>,
 Max Gurtovoy <maxgu14@gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Nov 20, 2020 at 07:50:38PM +0100, Eugenio P=C3=A9rez wrote:
>This series enable vDPA software assisted live migration for vhost-net
>devices. This is a new method of vhost devices migration: Instead of
>relay on vDPA device's dirty logging capability, SW assisted LM
>intercepts dataplane, forwarding the descriptors between VM and device.
>
>In this migration mode, qemu offers a new vring to the device to
>read and write into, and disable vhost notifiers, processing guest and
>vhost notifications in qemu. On used buffer relay, qemu will mark the
>dirty memory as with plain virtio-net devices. This way, devices does
>not need to have dirty page logging capability.
>
>This series is a POC doing SW LM for vhost-net devices, which already
>have dirty page logging capabilities. None of the changes have actual
>effect with current devices until last two patches (26 and 27) are
>applied, but they can be rebased on top of any other. These checks the
>device to meet all requirements, and disable vhost-net devices logging
>so migration goes through SW LM. This last patch is not meant to be
>applied in the final revision, it is in the series just for testing
>purposes.
>
>For use SW assisted LM these vhost-net devices need to be instantiated:
>* With IOMMU (iommu_platform=3Don,ats=3Don)
>* Without event_idx (event_idx=3Doff)
>
>Just the notification forwarding (with no descriptor relay) can be
>achieved with patches 7 and 9, and starting migration. Partial applies
>between 13 and 24 will not work while migrating on source, and patch
>25 is needed for the destination to resume network activity.
>
>It is based on the ideas of DPDK SW assisted LM, in the series of
>DPDK's https://patchwork.dpdk.org/cover/48370/ .
>
>Comments are welcome.

Hi Eugenio,
I took a look and the idea of the shadow queue I think is the right way.
It's very similar to what we thought with Stefan for io_uring =

passthrough and vdpa-blk.

IIUC, when the migrations starts, the notifications from the guest to =

vhost are disabled, so QEMU starts to intercept them through the =

custom_handler installed in virtio-net (we need to understand how to =

generalize this).
At this point QEMU starts to use the shadows queues and exposes them to =

vhost.
The opposite is done for vhost to guest notifications, where =

vhost_handle_call is installed to masked_notifier to intercept the =

notification.

I hope to give better feedback when I get a complete overview ;-)

Anyway, as Jason suggested, we should split this series, so maybe we can =

merge some preparations patches (e.g. 1, 11, 21, 22) regardless the =

other patches.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
