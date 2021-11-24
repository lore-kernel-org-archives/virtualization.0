Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37DFC4332F
	for <virtualization@archiver.kernel.org>; Wed, 24 Nov 2021 15:39:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2CCDE402FC;
	Wed, 24 Nov 2021 15:39:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m0b5JE8rHxYu; Wed, 24 Nov 2021 15:39:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EB63C402F8;
	Wed, 24 Nov 2021 15:39:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF9E0C001E;
	Wed, 24 Nov 2021 15:39:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB3D5C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 15:39:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B915761BA5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 15:39:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QcYiXioRiLwC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 15:39:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 16A7960687
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 15:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637768363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2ZAQ9bYIpFW8w5nnJ2NX1dTFB2zcv9+w2ukWOWPCF5I=;
 b=VAlpX7IqzWtTm059kr65xTpzweeSwR5fXX1VFPaNKcDRLd38z2MkFrOzLEu7GVP1Y3YHnv
 PFTiDgUEpytoQRWWRA8gvhjcxbU1vnokkMB++Ng+NQHCFUgdvhqH8j3jESYfa0UFOjBAaM
 Ma1WRzojfx9ZHuXfQh3Rj0jTwqUbMyM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-442-6xNoMkPrMEabs-g8_4clfQ-1; Wed, 24 Nov 2021 10:39:21 -0500
X-MC-Unique: 6xNoMkPrMEabs-g8_4clfQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 eg20-20020a056402289400b003eb56fcf6easo2674396edb.20
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 07:39:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2ZAQ9bYIpFW8w5nnJ2NX1dTFB2zcv9+w2ukWOWPCF5I=;
 b=nWPohHLMZYYunMDJQZye2rqedwVK8u1Mjw7rdLRR96PPufW1jp+5k/jtmNuaN/XTaj
 hsz+O4lW8HMpplfBJit+ay+WAuvHklI4Gswou6m4vHfGaFrWRMid1zV5f7ja+TpdmHas
 Ggnh00i1julICfAaHGAr79Q++xXYAEvNQGd8ceHcPQ7xblSRBIC4tgyHCgrXTWul180Z
 DdiuF4zR2Ofw6AK4ZBxJk1GLKJYZ0C1qR6fDDrvAJfdWlZF8+kYv/D+fO49Vhp2tLKrX
 maFeGFu+Ig9X41JNnAG2uDuRqB/jRpDB1v0twSwdRu6xv5ZeReHibfUST8BpetLFrzhH
 jgJA==
X-Gm-Message-State: AOAM530QUxTP8Sl0HbIHXgNSNA6R4uAcx10y7qODKI98ljukwkX/VqtA
 WMROyIulAUZceqFRdrYuvlHO+kDrs69Ur8842ws3FyzSgLaBKs/FIoSYwbBvTQcXixIVBRm0AxW
 8cesiQd6BpDpnABhM7Ij1GWi2hBYr+VTj2iYa1wd5Wg==
X-Received: by 2002:a17:906:4bcf:: with SMTP id
 x15mr21211719ejv.273.1637768360444; 
 Wed, 24 Nov 2021 07:39:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIoRH2WtnFT3cwBPr87hT88WyQOrA/0ZJYyfvukNGh+Cf3LGP/KgoKVcbcNm0UQ/svUQrL/A==
X-Received: by 2002:a17:906:4bcf:: with SMTP id
 x15mr21211655ejv.273.1637768360136; 
 Wed, 24 Nov 2021 07:39:20 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it.
 [87.10.72.39])
 by smtp.gmail.com with ESMTPSA id u16sm103149ejy.16.2021.11.24.07.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Nov 2021 07:39:19 -0800 (PST)
Date: Wed, 24 Nov 2021 16:39:16 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH V4 0/3] vDPA/ifcvf: enables Intel C5000X-PL virtio-blk
Message-ID: <CAGxU2F622pzZkh8WC7J+jGYu-_ozSDx1Tvvvtw-z52xwC3S38A@mail.gmail.com>
References: <20210419063326.3748-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20210419063326.3748-1-lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Cindy Lu <lulu@redhat.com>, kvm <kvm@vger.kernel.org>,
 Michael Tsirkin <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Zhu Lingshan <lingshan.zhu@intel.com>
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

Hi Zhu,

On Mon, Apr 19, 2021 at 8:39 AM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>
> This series enabled Intel FGPA SmartNIC C5000X-PL virtio-blk for vDPA.

Looking at the IFCVF upstream vDPA driver (with this series applied), it 
seems that there is still some cleaning to be done to support virtio-blk 
devices:

- ifcvf_vdpa_get_config() and ifcvf_vdpa_set_config() use
  `sizeof(struct virtio_net_config)` to check the inputs.
  This seems wrong for a virtio-blk device. Maybe we can set the config
  size for each device in ifcvf_vdpa_dev_add() and use that field to
  check the inputs. We can reuse the same field also in
  ifcvf_vdpa_get_config_size().

- Just for make the code more readable we should rename `net_cfg` field
  to `device_cfg`in `struct ifcvf_hw`.

What do you think?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
