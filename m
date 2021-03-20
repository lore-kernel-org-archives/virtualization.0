Return-Path: <SRS0=6Ykv=IS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8160C433DB
	for <virtualization@archiver.kernel.org>; Sat, 20 Mar 2021 20:04:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CDA161490
	for <virtualization@archiver.kernel.org>; Sat, 20 Mar 2021 20:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDA161490
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F3DE56078C;
	Sat, 20 Mar 2021 20:04:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e6JacabWjWhK; Sat, 20 Mar 2021 20:04:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA4406078D;
	Sat, 20 Mar 2021 20:04:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7192EC000B;
	Sat, 20 Mar 2021 20:04:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEB24C0001
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Mar 2021 20:04:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B6EFE401FE
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Mar 2021 20:04:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PzOX3yVOA9nS
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Mar 2021 20:04:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 50AD6401F9
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Mar 2021 20:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616270691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pnGnuCZZHz4XpqGqAahLmMqXi+ESBvx9VOBJS6yQPvo=;
 b=EZOzHxGH8HZVAlFBR1R8RwegZXIlxrcBfFMIHGYvS9lNmwkMXc1D1jBrRR4kRTis6jk+Zg
 /ugwsnV/M29hRh2ia99BFvGFK0vrNEcDer0gCQWcxPHXu0V5yFnhFolEZJtzJa/SA0zKfX
 wPEOIj0bnySVGydiwyQmWvu3KhXBwH4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-w8LsL9iyM2eQICnONU3okw-1; Sat, 20 Mar 2021 16:04:49 -0400
X-MC-Unique: w8LsL9iyM2eQICnONU3okw-1
Received: by mail-wr1-f70.google.com with SMTP id s10so23703002wre.0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Mar 2021 13:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pnGnuCZZHz4XpqGqAahLmMqXi+ESBvx9VOBJS6yQPvo=;
 b=nyQO1ENgcZIMPSS6tM8p5SeVEaa4NNv+C17yU1iIH8npZ8n30Hk6p4mV1VeWWo66p1
 PGkO7j7rUYRNTHb0GItNcl7zgnhcM0QUue+92MluTjQT+jLP8B309s39vlV+APRl7czW
 yZn3L9JtHmWV8xs9Y2SQh2yJmBGb88PzkNzrdjK1yUVZcYvNfmLSFqdU9dtlsX67lhMQ
 INankseoG8AKzzw65R2iatFvxyxtc53dSqAudM9wXXWd6jYdE1EsLl5LPsK/ssDh3HFi
 IicT9ikIC8cBWnuytT26LAdb7M81FJbF9WipYMkaVy/VBch0lFoAOjwlbMSCa0OEZs4B
 nTtQ==
X-Gm-Message-State: AOAM531T9914OgJD4qX92qKCVVaEverl3aBrBYhsVCNTSWsIzbd4vZFE
 R8dQWTyozIrAjr9SPAvf2qHoDrG6dRBf+vBrXxalrxLEgvIyfPp3Az3mh2wXnejfylon4PLrTOV
 pAPKLrXR61rq6OVwghQPB9ZRYv+obuj46OdPjEfxw3w==
X-Received: by 2002:a05:6000:1363:: with SMTP id
 q3mr10599184wrz.74.1616270688139; 
 Sat, 20 Mar 2021 13:04:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7L9ySoCVBIPu7d6xQw3Xs2Tj/PnDDoZVrDpnDuMVdcWWj5/Ke+oKKH8pTiLrVtFu6ZdfbPg==
X-Received: by 2002:a05:6000:1363:: with SMTP id
 q3mr10599168wrz.74.1616270687954; 
 Sat, 20 Mar 2021 13:04:47 -0700 (PDT)
Received: from redhat.com ([2a10:800e:f0d3:0:b69b:9fb8:3947:5636])
 by smtp.gmail.com with ESMTPSA id l15sm12002303wme.43.2021.03.20.13.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Mar 2021 13:04:47 -0700 (PDT)
Date: Sat, 20 Mar 2021 16:04:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Connor Kuehl <ckuehl@redhat.com>
Subject: Re: [PATCH 2/3] virtiofs: split requests that exceed virtqueue size
Message-ID: <20210320160430-mutt-send-email-mst@kernel.org>
References: <20210318135223.1342795-1-ckuehl@redhat.com>
 <20210318135223.1342795-3-ckuehl@redhat.com>
 <YFNvH8w4l7WyEMyr@miu.piliscsaba.redhat.com>
 <00c5dce8-fc2d-6e68-e3bc-a958ca5d2342@redhat.com>
MIME-Version: 1.0
In-Reply-To: <00c5dce8-fc2d-6e68-e3bc-a958ca5d2342@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
 stefanha@redhat.com, linux-fsdevel@vger.kernel.org, vgoyal@redhat.com
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

On Thu, Mar 18, 2021 at 10:52:14AM -0500, Connor Kuehl wrote:
> On 3/18/21 10:17 AM, Miklos Szeredi wrote:
> > I removed the conditional compilation and renamed the limit.  Also made
> > virtio_fs_get_tree() bail out if it hit the WARN_ON().  Updated patch below.
> 
> Thanks, Miklos. I think it looks better with those changes.
> 
> > The virtio_ring patch in this series should probably go through the respective
> > subsystem tree.
> 
> Makes sense. I've CC'd everyone that ./scripts/get_maintainers.pl suggested
> for that patch on this entire series as well. Should I resend patch #1
> through just that subsystem to avoid confusion or wait to see if it gets
> picked out of this series?

Yes pls post separately. Thanks!

> Thanks again,
> 
> Connor

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
