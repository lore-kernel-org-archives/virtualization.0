Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37762C19F2A
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 17:23:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A7186831CA;
	Thu, 11 Aug 2022 17:23:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A7186831CA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=h7L4neJI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XJERKS95YTN0; Thu, 11 Aug 2022 17:23:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 214C9831B0;
	Thu, 11 Aug 2022 17:23:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 214C9831B0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2F39C0032;
	Thu, 11 Aug 2022 17:23:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4AE3C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 17:23:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C4CDF404E8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 17:23:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C4CDF404E8
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=h7L4neJI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D5ww9eg60GUj
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 17:23:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 99F3540222
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 99F3540222
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 17:23:06 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id z17so22060354wrq.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc; bh=j6b8kTrT56pwiU/IWqIOVmZdn5YfEPHXgPdh8M5ebwU=;
 b=h7L4neJIrIWcIOjwXfQEB9hwJK4xq6R+BiWBrtmxIksUhSNdQH7p/IZXM9NG/eSM0h
 hLy9cVMlPI6SVm2QoJ1zzD7Gd6wSFI6/G6O+rDkuaS9WlYydFZoX2rYKpCi+x7IPcC++
 q/TYrO9uxaqzIZzdL+odlDYDp74eWkbaepATdxwmBwCfOs2zrTyDfpkmOfUYuPxzXgbM
 g5sk4lNQFZLRaJQAoVmCUlpeACUBFmJjwo8ovs3BUn9HrcCPg7vju1kmtt4ByxF2mYln
 bnQdbwD5EfXAeXR8VozOrflRRy3ZxW2+WSdWPruAFDr5XlVVWNQ4MNBSCs8LWx2HxJ48
 CtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=j6b8kTrT56pwiU/IWqIOVmZdn5YfEPHXgPdh8M5ebwU=;
 b=gju1Sv2WJNjIbLX75/V3AKkpKEywxosf8SawNNPK7gzdJ/Wxy4vxDcbeE8mQz4N/5R
 1aje6HfY10UDdTgYhhnjWG97AEic1hSmSh9NL3nJH1SGSKEFHKJV8JMumr2o7Glh5Spi
 xKxL61e70Kf6CMTMd0SdX/7ahOd5t+NpvsAAGptNQqO6iHjsXEfLjWgkf8+4dPcJTATT
 KaKAuPSV5hPWLkeVQUdT6+H9nqDW72bKE1GWpQgDJhKGnTEGSmQBO6icuBZ7iiAXWWG6
 efCclhBxAqqeSvpgA8suiHHkv5qveB3aRjcBNdHRdVbVG2GPuEC7Kk+0+s1HLVsU8txT
 79Fg==
X-Gm-Message-State: ACgBeo1ryZhORqTAXhelJ6s8y2itpIrfx5TOkD/cWEoSX9OCbXbE/5Gt
 540BO6TEAka6hCh9HHqjB9LhJXQDcJVowQ==
X-Google-Smtp-Source: AA6agR7icK2jhFDxh4B/98tzwNsmxNFF++Z70qopjEziOWND2bqMvSdWSrJzRBBJ2glEiKAihkZd2g==
X-Received: by 2002:adf:f286:0:b0:21e:f0dc:3df0 with SMTP id
 k6-20020adff286000000b0021ef0dc3df0mr21793wro.377.1660238584739; 
 Thu, 11 Aug 2022 10:23:04 -0700 (PDT)
Received: from debian ([2405:201:8005:8149:e5c9:c0ac:4d82:e94b])
 by smtp.gmail.com with ESMTPSA id
 h4-20020a1ccc04000000b003a545ff43c5sm6362884wmb.45.2022.08.11.10.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Aug 2022 10:23:03 -0700 (PDT)
Date: Thu, 11 Aug 2022 18:22:54 +0100
From: "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: build failure of next-20220811 due to d79b32c2e4a4 ("vdpa_sim_blk:
 add support for discard and write-zeroes")
Message-ID: <YvU67iF4z5gB4ZYk@debian>
MIME-Version: 1.0
Content-Disposition: inline
Cc: Nathan Chancellor <nathan@kernel.org>, linux-next@vger.kernel.org,
 clang-built-linux <llvm@lists.linux.dev>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

Hi All,

Not sure if it has been reported, builds of arm64 with clang failed to
build next-20220811 with the error:

drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:201:3: error: expected expression
                struct virtio_blk_discard_write_zeroes range;
                ^
drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:204:25: error: use of undeclared identifier 'range'
                if (to_pull != sizeof(range)) {
                                      ^
drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:207:21: error: use of undeclared identifier 'range'
                                to_pull, sizeof(range));
                                                ^
drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:212:60: error: use of undeclared identifier 'range'
                bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->out_iov, &range,
                                                                         ^
drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:222:38: error: use of undeclared identifier 'range'
                sector = vdpasim64_to_cpu(vdpasim, range.sector);
                                                   ^
drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:224:43: error: use of undeclared identifier 'range'
                num_sectors = vdpasim32_to_cpu(vdpasim, range.num_sectors);
                                                        ^
drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:225:37: error: use of undeclared identifier 'range'
                flags = vdpasim32_to_cpu(vdpasim, range.flags);
                                                  ^
drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:202:7: error: mixing declarations and code is incompatible with standards before C99 [-Werror,-Wdeclaration-after-statement]
                u32 num_sectors, flags;
                    ^
8 errors generated.


git bisect pointed to d79b32c2e4a4 ("vdpa_sim_blk: add support for discard and write-zeroes").
And, reverting that commit has fixed the build failure.

I will be happy to test any patch or provide any extra log if needed.


--
Regards
Sudip
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
