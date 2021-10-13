Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E89C433EF
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 12:55:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F8A60EE9
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 12:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 92F8A60EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E206608B4;
	Wed, 13 Oct 2021 12:55:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EW_cRK2NOStK; Wed, 13 Oct 2021 12:55:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0943960073;
	Wed, 13 Oct 2021 12:55:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D64D1C000F;
	Wed, 13 Oct 2021 12:55:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60703C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:55:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4EEA540247
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:55:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X_m_b6zax1eF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:55:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 87367404E4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634129710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bua+UvhRZx/vtJpW/R79wAmjzbaBOR2FatQ2gYmLKAk=;
 b=imCDhWuWI5hr9wxKRNm+RZyDWnJUNKV39xwKQtw3TkcLGfdCvLzMrnapy3qlT/MV0lN9Yo
 GgkZNr7ehYSNFnKhhWxJ6MthVECACrBxnnuYBMn1i7mTJAuQS8x8m5ZhQYvDXohyqkh67p
 juX97odvt37mrfN0/KE6gNs1Fgz+Z8g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-XyacTCQAOc6RmbsEPAjAyg-1; Wed, 13 Oct 2021 08:55:09 -0400
X-MC-Unique: XyacTCQAOc6RmbsEPAjAyg-1
Received: by mail-wr1-f71.google.com with SMTP id
 v15-20020adfa1cf000000b00160940b17a2so1873967wrv.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 05:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bua+UvhRZx/vtJpW/R79wAmjzbaBOR2FatQ2gYmLKAk=;
 b=LyDERiCMp9+1S88cpfBL+wKOd/MABkP/3mG/e+kN7J8P2wCXnrGg65xIPLzw44bwZh
 QNnyQR0bkP2aEg/z9H+GXC2KEOEESBPZELA47cTbTHMP2dKjiOt0hCtpbooSl1S2jGUi
 z2yEiwY8+K9cc1jG1DPaVGBb9W1bosxe1+Aulh+79KurovChSAzVIDj85q0tA9MU8rv9
 oVMbS/yCpV+INbzlnJ7Z+QKqZ2Cc72P0rGohaANZ2LC7XNwHnsKmy0WfXu0DFZpPaPN3
 HKmHLngAznLUrIHn6MVNiW4HA4jruZgpLuO6HzP0ZEzaObA5+dlIvLb4dDbvFaP+2HX6
 Zs1A==
X-Gm-Message-State: AOAM532VgnPB3zXvvWaHthhVYrPYjM8aKbkey76kkHsTn5Ee8K4FrPYR
 7WKZIazg29K0zA9lzkQAdboyzGI729UmovodYZrm9aYc32IiLWgriUVoLw4meMT4jDXGdLT++3g
 jrU62bh8HR+1jC/cYxLpfLOMf6at1IzFSYaxp535XZA==
X-Received: by 2002:a1c:22d7:: with SMTP id
 i206mr13001189wmi.122.1634129708024; 
 Wed, 13 Oct 2021 05:55:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUlSBIGEPmkknnlsQTkGPbs0LAOHhsvCUmorYQR19foafC7W/ikoT3XdyrV6wuhDzoeZLiZw==
X-Received: by 2002:a1c:22d7:: with SMTP id
 i206mr13001158wmi.122.1634129707894; 
 Wed, 13 Oct 2021 05:55:07 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
 by smtp.gmail.com with ESMTPSA id g12sm5445986wme.3.2021.10.13.05.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 05:55:07 -0700 (PDT)
Date: Wed, 13 Oct 2021 08:55:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 1/1] virtio: write back F_VERSION_1 before validate
Message-ID: <20211013085423-mutt-send-email-mst@kernel.org>
References: <20211011053921.1198936-1-pasic@linux.ibm.com>
 <20211013060923-mutt-send-email-mst@kernel.org>
 <96561e29-e0d6-9a4d-3657-999bad59914e@de.ibm.com>
 <20211013081836-mutt-send-email-mst@kernel.org>
 <87zgrdulwp.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87zgrdulwp.fsf@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com,
 Xie Yongji <xieyongji@bytedance.com>, qemu-devel@nongnu.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, stefanha@redhat.com,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
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

On Wed, Oct 13, 2021 at 02:52:38PM +0200, Cornelia Huck wrote:
> On Wed, Oct 13 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Wed, Oct 13, 2021 at 01:23:50PM +0200, Christian Borntraeger wrote:
> >> Can we get this kernel patch queued for 5.15 and stable without waiting for the QEMU patch
> >> as we have a regression with 4.14?
> >
> > Probably. Still trying to decide between this and plain revert for 5.15
> > and back. Maybe both?
> 
> Probably better queue this one, in case we have some undiscovered
> problems with the config space access in virtio-net?

So both then. I think you are right. Pushed out to -next. Will do a pull
towards end of the week.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
