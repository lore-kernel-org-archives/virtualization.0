Return-Path: <SRS0=+b5l=LW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7970C11F65
	for <virtualization@archiver.kernel.org>; Mon, 28 Jun 2021 22:40:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FFFE61CF8
	for <virtualization@archiver.kernel.org>; Mon, 28 Jun 2021 22:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFFE61CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5F0182FEA;
	Mon, 28 Jun 2021 22:40:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8oIiBKBchxjP; Mon, 28 Jun 2021 22:40:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EDDED82FE7;
	Mon, 28 Jun 2021 22:40:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFCE5C001A;
	Mon, 28 Jun 2021 22:40:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52EEAC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 22:40:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3997040284
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 22:40:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 37W5zC3IJAcs
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 22:40:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 01D6A4014A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 22:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624920004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9rnHDaAmQWn7FzY4oV4HKI2o/HCtj8PlCKV7fSRllco=;
 b=ishYL0svXJCry2Diod7zcb8gcjhNMgTL415EcU6UHZkI8eLcrLscSH7NAFbf2k3G11Z8xA
 8qfx5cSpg+QjAV59BV3GGUvm1CvHJgF9qMjkJhr6QfSb+4fNZ+QzoV8bsFESBH0ycSYeEp
 HSFqOrcir56urNiV1fQ0+T6W+MLR8+w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-O5KiQDeDOBOheWEMqoQEMw-1; Mon, 28 Jun 2021 18:40:02 -0400
X-MC-Unique: O5KiQDeDOBOheWEMqoQEMw-1
Received: by mail-ed1-f72.google.com with SMTP id
 w1-20020a0564022681b0290394cedd8a6aso10461383edd.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 15:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9rnHDaAmQWn7FzY4oV4HKI2o/HCtj8PlCKV7fSRllco=;
 b=FkibrFiqew93Xb5/qn66P0I3cUN3/E9iOfBhVpx5z2bXACVNoTmjKpM3zvsZv+E+qx
 c3xFipP0mZLKcDMZPemVC+2zzRBrnUl6C2BGa+mF8rwu7tDSVvLO8U43Fvf7O5X81Arf
 lZmJfGkqZ2V0wtWfvQt9g3BEMY6MFpD4fhsBZpbKWEiC0GaVFZhg+I+zMuJ+u9UowzQn
 khdo/eAJaZMcogaPvFxDhjb81K5i4tXTTnFxnvHKc/QOrRbex/sXcKFCApUhy0jH9qIx
 lRoIkviiNizJMS5fY+QZ+O8CwVOjl1t5iHtptMu6lMznIRB9KIrlHSL0CTLqBUpxTf5p
 M3Rg==
X-Gm-Message-State: AOAM531oDTehrz+IW7gL42L4Lp0o4q5/fvw4Nnv6ICTN7SHTkrI4/GMr
 P0xFdZsTNTCmdRVbDpqVNure95ZfbcOUek0X/v04vxQwhjYh8galAVy3rgwT1P9AbKg6xaMjlby
 MvNrEVvNTMOmfnq7+dhT78KTTrOdQIzmzyLoxJTUGMg==
X-Received: by 2002:a05:6402:268b:: with SMTP id
 w11mr3853909edd.341.1624920001546; 
 Mon, 28 Jun 2021 15:40:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6RDk30Z7kK1RpPq6o6hnU5CVyuZVqGoI1FMaj/sIzg4gaq1ts16WUlErRUAMpT2p/BTfI4w==
X-Received: by 2002:a05:6402:268b:: with SMTP id
 w11mr3853897edd.341.1624920001444; 
 Mon, 28 Jun 2021 15:40:01 -0700 (PDT)
Received: from redhat.com ([77.126.198.14])
 by smtp.gmail.com with ESMTPSA id yh13sm7328140ejb.28.2021.06.28.15.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jun 2021 15:40:00 -0700 (PDT)
Date: Mon, 28 Jun 2021 18:39:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
Message-ID: <20210628183831-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481AE651E0E9BFA6A1839EEDC099@PH0PR12MB5481.namprd12.prod.outlook.com>
 <0434617e-f960-eb1a-a682-49b6a754413f@redhat.com>
 <PH0PR12MB548147BE1B95CB294785470CDC089@PH0PR12MB5481.namprd12.prod.outlook.com>
 <d361bd10-3967-8844-1457-48e7e9422fb2@redhat.com>
 <PH0PR12MB54812DD2DADAD0897E24CFA7DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4e0708fb-34e3-471d-ca98-44c75f693b32@redhat.com>
 <PH0PR12MB54811C39B86AC8D6BECA9E05DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
 <7a0a8bdf-4cd2-2fc2-73a5-53fb2ab432b6@redhat.com>
 <PH0PR12MB54819F782D5D7E6F9DCDF5FEDC069@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5350f5c0-c707-c3ec-8ed8-16c884467ffa@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5350f5c0-c707-c3ec-8ed8-16c884467ffa@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Mon, Jun 28, 2021 at 01:03:20PM +0800, Jason Wang wrote:
> So I think we need solve them all, but netlink is probably the wrong layer,
> we need to solve them at virtio level and let netlink a transport for them
> virtio uAPI/ABI.

I'm not sure I follow. virtio defines VF to driver communication.
This is PF to hypervisor. virtio simply does not cover it ATM.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
