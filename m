Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7109C433F5
	for <virtualization@archiver.kernel.org>; Sun, 12 Dec 2021 23:01:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63D5B4299A;
	Sun, 12 Dec 2021 23:01:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g1HN6dVA-aDc; Sun, 12 Dec 2021 23:01:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0C4DD42971;
	Sun, 12 Dec 2021 23:01:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC1BBC002F;
	Sun, 12 Dec 2021 23:01:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70042C0012
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 23:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 42F1E60B78
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 23:01:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WgBedg6w1d6c
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 23:01:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 669C660B61
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 23:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639350080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nWAAVnbV6MqAjMvta69bjbT9xwzoQtd+RCXC/QhLjKY=;
 b=C44aFaxmLXk2ClxfwtTQpwloudxdgB7ICI21mq+h3EQFau9SjcGI4w6Gts0pQ2K1HHXsMp
 aQMZs0SELS0SpZ7Mb8vjPcjMonqlEYnfkSNRlIzf0GSF5bkG0dqONey867FdAMLfG+K1Jg
 L0xbWqD0P1cC6AmR5n8Oym0wGEKlAO8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-ecILu7TGNpCzaSuwDuT-EA-1; Sun, 12 Dec 2021 18:01:19 -0500
X-MC-Unique: ecILu7TGNpCzaSuwDuT-EA-1
Received: by mail-wm1-f69.google.com with SMTP id
 69-20020a1c0148000000b0033214e5b021so8773137wmb.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 15:01:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nWAAVnbV6MqAjMvta69bjbT9xwzoQtd+RCXC/QhLjKY=;
 b=l1E0pGZa0znvCbtlT/tKFpqz/HqKFiPssZO6Ekad3Y3OZypjowTB68etd1cZBimlB+
 +RAzex+Dm8GwbRTavJ7FTlz/U39E6LzDRqnyD5SV7Bt6faKD2cFR31BtXSphHFyJ4O5x
 cHencFCiGI3DBtD4AYxr7el8aUhWbqLG0VlM6cvSedGGeDoRZtU33c12uPoPCRaflKqA
 p1Bkcy23aU4VZN1lL/G7jio8U/d8cxU2Ab3x+pSwYRbuYptVuVyGQLirc6KGvjanA/TK
 R3E3/65VZ7pnMNrfEPBIbg8Cue6Pn0ohK2HkVVkgFamkvWLXx4gH5BoRfpj20Tz2WcBB
 sy7g==
X-Gm-Message-State: AOAM5310EYd8Tm6BxIGXiVClTw3Rw/C7pBDVmhpF9y0FzcRWlGuPczQV
 P3N5aSa+kd9OGkwnZRE5GTKp+S04G8/fjTR5iFZqF0VLmGJ5ChCS7FRgC/xjD9Ed3grWsVg6N6e
 Gwgl7drl5M2HuAriuhkltfbNu6AVj9JMJeMaaDaQcWg==
X-Received: by 2002:adf:f98c:: with SMTP id f12mr28846585wrr.184.1639350077949; 
 Sun, 12 Dec 2021 15:01:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQCdHRAXnhC2AijT3mDyv6Ek9NRjuf014yNW66vb72IH9ZLQVQ9UW9yFVsxil1X5rmlgEpzQ==
X-Received: by 2002:adf:f98c:: with SMTP id f12mr28846567wrr.184.1639350077791; 
 Sun, 12 Dec 2021 15:01:17 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:107e:eefb:294:6ac8:eff6:22df])
 by smtp.gmail.com with ESMTPSA id o4sm10813418wry.80.2021.12.12.15.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Dec 2021 15:01:17 -0800 (PST)
Date: Sun, 12 Dec 2021 18:01:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] vhost: cleanups and fixes
Message-ID: <20211212180010-mutt-send-email-mst@kernel.org>
References: <20211212175951-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211212175951-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: jroedel@suse.de, kvm@vger.kernel.org, arnd@arndb.de, konrad.wilk@oracle.com,
 netdev@vger.kernel.org, qperret@google.com, will@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 suzuki.poulose@arm.com, maz@kernel.org, steven.price@arm.com,
 robin.murphy@arm.com, hch@lst.de, dan.carpenter@oracle.com, lkp@intel.com
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

The email subject is wrong. it's just bugfixes.
But the tag is ok, and that's what matters, right?

On Sun, Dec 12, 2021 at 05:59:58PM -0500, Michael S. Tsirkin wrote:
> The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1:
> 
>   Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> 
> for you to fetch changes up to bb47620be322c5e9e372536cb6b54e17b3a00258:
> 
>   vdpa: Consider device id larger than 31 (2021-12-08 15:41:50 -0500)
> 
> ----------------------------------------------------------------
> virtio,vdpa: bugfixes
> 
> Misc bugfixes.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> Arnd Bergmann (1):
>       virtio: always enter drivers/virtio/
> 
> Dan Carpenter (3):
>       vduse: fix memory corruption in vduse_dev_ioctl()
>       vdpa: check that offsets are within bounds
>       vduse: check that offset is within bounds in get_config()
> 
> Parav Pandit (1):
>       vdpa: Consider device id larger than 31
> 
> Wei Wang (1):
>       virtio/vsock: fix the transport to work with VMADDR_CID_ANY
> 
> Will Deacon (1):
>       virtio_ring: Fix querying of maximum DMA mapping size for virtio device
> 
>  drivers/Makefile                        | 3 +--
>  drivers/vdpa/vdpa.c                     | 3 ++-
>  drivers/vdpa/vdpa_user/vduse_dev.c      | 6 ++++--
>  drivers/vhost/vdpa.c                    | 2 +-
>  drivers/virtio/virtio_ring.c            | 2 +-
>  net/vmw_vsock/virtio_transport_common.c | 3 ++-
>  6 files changed, 11 insertions(+), 8 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
