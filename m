Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E51C25B0C
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 18:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7679440593;
	Thu, 11 Aug 2022 18:33:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7679440593
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J68bB5KR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8diYZQJt_wgJ; Thu, 11 Aug 2022 18:33:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B737440502;
	Thu, 11 Aug 2022 18:33:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B737440502
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97608C0033;
	Thu, 11 Aug 2022 18:33:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0751FC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 18:33:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C193440060
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 18:33:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C193440060
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=J68bB5KR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2b81y1JnZdJa
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 18:33:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 454B840029
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 454B840029
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 18:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660242796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7dz5R5ZNw+F9/FGCaE9Xpa/l+1/FjVP8+1bl2Y6XNQU=;
 b=J68bB5KRh1VOKItiBTk2gHvFcL8VIdwq6dIWj4zYw8+eLNePPCDPcf3+kPCJ+V9bOyn7J8
 fiHvRxLqqwxQjh38G/4vbUHWfIf/iaua0SlAVJ864o+Bha9b/uwfWmUHe3D2qni0dADVDv
 MwZGlqjribEwp7S0F0UxdFX8ccLvt4I=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-114-dq2NRLJyNMefQA-wMCm39Q-1; Thu, 11 Aug 2022 14:33:14 -0400
X-MC-Unique: dq2NRLJyNMefQA-wMCm39Q-1
Received: by mail-ej1-f71.google.com with SMTP id
 sc31-20020a1709078a1f00b0073096c2b4e1so5868277ejc.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 11:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=7dz5R5ZNw+F9/FGCaE9Xpa/l+1/FjVP8+1bl2Y6XNQU=;
 b=Wu+8o1QE1l1KLyb9plQBPM1dkXgQqu7t1ibMGcTww9w1dAE0gFfv57ZZTsfhfxVKDu
 5NC66mp+uXaPSQZoZx8nElCGOCnCFozI/D75bQBP0JHgc3eOfIJ7orVN1SQvr2TTIujQ
 7KwuOYGXitQR5AxYGUM37382Ut/jS1+cImXbxZOU2NOMxlsJksY6HOopaOk2qTrXtZMU
 4eSrBKMRbaM+IdvSphuMsETz2ayrqXhBu40HZB4gXSjEf1Y+7y64v2cAGNfgfcTq14rO
 0wYHOF+p+EWkaiWjThpTkbCGSOhCZKfss1MYZNYmjvLAK3OXD6Na4pmm0XIgCOmGBunT
 SGRA==
X-Gm-Message-State: ACgBeo2y0q5jxJadVFdlFlwna7LrmSehDG5pcnray1mTQIMmbjaZS4hh
 4Zvmq7b869F6gKFoonG1KekPJkd6q8Xc9c88r8G2WT31tbWDCw0+Ihh8bIlQ1BE9rUtBK7tLbub
 NRPGj8VeE7wC90qxv+/QIbVjeUtiORpGNSzu4O11ZHg==
X-Received: by 2002:a17:907:8b97:b0:730:9480:972a with SMTP id
 tb23-20020a1709078b9700b007309480972amr245531ejc.648.1660242793777; 
 Thu, 11 Aug 2022 11:33:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7WllUicIl5uwdNr8dGWulKl9BvguFKH+7knv9r4HZiA3AtTg9mny3d4uq2XI+aRsoV3gOabQ==
X-Received: by 2002:a17:907:8b97:b0:730:9480:972a with SMTP id
 tb23-20020a1709078b9700b007309480972amr245507ejc.648.1660242793510; 
 Thu, 11 Aug 2022 11:33:13 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 l10-20020a1709063d2a00b0072ecef772acsm3794657ejf.2.2022.08.11.11.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Aug 2022 11:33:12 -0700 (PDT)
Date: Thu, 11 Aug 2022 20:33:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Subject: Re: build failure of next-20220811 due to d79b32c2e4a4
 ("vdpa_sim_blk: add support for discard and write-zeroes")
Message-ID: <20220811183310.ttewcrfhvs4mfohz@sgarzare-redhat>
References: <YvU67iF4z5gB4ZYk@debian>
MIME-Version: 1.0
In-Reply-To: <YvU67iF4z5gB4ZYk@debian>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 clang-built-linux <llvm@lists.linux.dev>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Nathan Chancellor <nathan@kernel.org>, linux-next@vger.kernel.org
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

Hi Sudip,

On Thu, Aug 11, 2022 at 06:22:54PM +0100, Sudip Mukherjee (Codethink) wrote:
>Hi All,
>
>Not sure if it has been reported, builds of arm64 with clang failed to
>build next-20220811 with the error:
>
>drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:201:3: error: expected expression
>                struct virtio_blk_discard_write_zeroes range;
>                ^
>drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:204:25: error: use of undeclared identifier 'range'
>                if (to_pull != sizeof(range)) {
>                                      ^
>drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:207:21: error: use of undeclared identifier 'range'
>                                to_pull, sizeof(range));
>                                                ^
>drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:212:60: error: use of undeclared identifier 'range'
>                bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->out_iov, &range,
>                                                                         ^
>drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:222:38: error: use of undeclared identifier 'range'
>                sector = vdpasim64_to_cpu(vdpasim, range.sector);
>                                                   ^
>drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:224:43: error: use of undeclared identifier 'range'
>                num_sectors = vdpasim32_to_cpu(vdpasim, range.num_sectors);
>                                                        ^
>drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:225:37: error: use of undeclared identifier 'range'
>                flags = vdpasim32_to_cpu(vdpasim, range.flags);
>                                                  ^
>drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:202:7: error: mixing declarations and code is incompatible with standards before C99 [-Werror,-Wdeclaration-after-statement]
>                u32 num_sectors, flags;
>                    ^
>8 errors generated.
>
>
>git bisect pointed to d79b32c2e4a4 ("vdpa_sim_blk: add support for discard and write-zeroes").
>And, reverting that commit has fixed the build failure.
>
>I will be happy to test any patch or provide any extra log if needed.

Thanks for the report, I already re-sent a new series with that patch 
fixed:
https://lore.kernel.org/virtualization/20220811083632.77525-1-sgarzare@redhat.com/T/#t

And it looks like it's already in Michael's tree:
https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
