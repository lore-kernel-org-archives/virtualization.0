Return-Path: <SRS0=Bv1r=PI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E209C433F5
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 07:37:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F4E61378
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 07:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A0F4E61378
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 601234071C;
	Wed, 20 Oct 2021 07:37:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o2W01QOsab7U; Wed, 20 Oct 2021 07:37:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E7EBA406AB;
	Wed, 20 Oct 2021 07:37:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C05CAC000F;
	Wed, 20 Oct 2021 07:37:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20443C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 07:37:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 10A38406F9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 07:37:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iRKNBgQ7JqGC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 07:37:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5ED71406AB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 07:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634715458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mQZkGZkcMT/9X7rY2JQAT2AeWtRw1pbaqZYCol/GOQU=;
 b=IzOgxOZ7bBcsSYiGWVWl+m9nwJMQ/nIi/CGhRez+KavTuJppxCeJaoSYT4L7FstwWhcSMz
 Y/hML+vfAn8GhI2Qq1R/YHlspl/3qigd6U5UFzgqweEgesB68RncG415/iR1pQERacN46u
 N/wlNdPTx60LoZE7c/A7Hp+k7e/x0VM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-598-6eSO08I3M-yeIdxE3kVYjA-1; Wed, 20 Oct 2021 03:37:37 -0400
X-MC-Unique: 6eSO08I3M-yeIdxE3kVYjA-1
Received: by mail-ed1-f72.google.com with SMTP id
 r25-20020a05640216d900b003dca3501ab4so3671725edx.15
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 00:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mQZkGZkcMT/9X7rY2JQAT2AeWtRw1pbaqZYCol/GOQU=;
 b=YG1Rq1tEw4RmM4tJcZjWw7Nz+9LWYzw22B7wKHdxgaJeP9De1KqmAMO30KGO+CANUE
 CAIrhb+D+OUUXqWDxi8Wq+ZnMvhGdD8d03MQF3W6dxNdrZq9/D7q5O7Fkw77QvDsk8EM
 cL9JZNaoPHFoCq1RuP9I1DnxzNv3PVdghWvDzQBy7ygWwq+KmsGGNRPra3ubqLjeqQor
 4HjAHufzvQ9O5bn5vybWoeHEYchXEyp3QQ/4u33EJEUXJCRQBcMQ7betNxLP9vdEK1J/
 zcMU78keCx2XEuzuUEt2xvVOG8A3Pk/78JsVtGbUkoLaN/My43y+e+iM0fXgQvV+ulMJ
 eAaw==
X-Gm-Message-State: AOAM532icwEeYqQJt9ittBFp3Xl70dE1RkRNcoEFAmvm3RjyPdwpzuW5
 M5kx4M0ofyg5bVOI7I+U12sekm52JnHuh9dFLsUNG7/NxnSez1G2dbRNPKwtBNo+3MfN84+kL1W
 ga5H8FbyFGABRjk2+rasxtkG7HtJwegLwEQihMOxxrA==
X-Received: by 2002:a17:906:1381:: with SMTP id
 f1mr43248920ejc.547.1634715455984; 
 Wed, 20 Oct 2021 00:37:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYP92GI73PEyOGZcTemC9Rxpc30vMRPxmbLU0eSsAdtYdXxiWNMDWTzMUSLLYSAn9LeHeIWA==
X-Received: by 2002:a17:906:1381:: with SMTP id
 f1mr43248904ejc.547.1634715455815; 
 Wed, 20 Oct 2021 00:37:35 -0700 (PDT)
Received: from redhat.com ([2.55.24.172])
 by smtp.gmail.com with ESMTPSA id l25sm686190edc.31.2021.10.20.00.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Oct 2021 00:37:35 -0700 (PDT)
Date: Wed, 20 Oct 2021 03:37:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH V3 01/10] virtio-blk: validate num_queues during probe
Message-ID: <20211020032849-mutt-send-email-mst@kernel.org>
References: <20211019070152.8236-1-jasowang@redhat.com>
 <20211019070152.8236-2-jasowang@redhat.com>
 <20211020071817.pzyfploxlryvdf3p@steredhat>
MIME-Version: 1.0
In-Reply-To: <20211020071817.pzyfploxlryvdf3p@steredhat>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: david.kaplan@amd.com, konrad.wilk@oracle.com, f.hetzelt@tu-berlin.de,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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

On Wed, Oct 20, 2021 at 09:18:17AM +0200, Stefano Garzarella wrote:
> On Tue, Oct 19, 2021 at 03:01:43PM +0800, Jason Wang wrote:
> > If an untrusted device neogitates BLK_F_MQ but advertises a zero
> 
> s/neogitates/negotiates
> 
> > num_queues, the driver may end up trying to allocating zero size
> > buffers where ZERO_SIZE_PTR is returned which may pass the checking
> > against the NULL. This will lead unexpected results.
> > 
> > Fixing this by failing the probe in this case.
> > 
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> > drivers/block/virtio_blk.c | 4 ++++
> > 1 file changed, 4 insertions(+)
> 
> Should we CC stable?
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

No IMO - I don't think we can reasonably expect stable to become
protected against attacks on encrypted guests. That's
a new feature, not a bugfix.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
