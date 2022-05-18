Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F8CC433F5
	for <virtualization@archiver.kernel.org>; Wed, 18 May 2022 16:33:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 22CB640AE5;
	Wed, 18 May 2022 16:33:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HAjMI-nfRgcE; Wed, 18 May 2022 16:33:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CCDEC403F8;
	Wed, 18 May 2022 16:33:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FE91C0032;
	Wed, 18 May 2022 16:33:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D73DAC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 16:33:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C4BF66122C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 16:33:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tx1RZHAFtHzn
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 16:33:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D22E36122A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 16:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652891589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=6BW+tomAtB+5qk/t/SKeP6VB//NGldp/mpIoLmV3bKM=;
 b=WOepCd9pQK4U8McLcvFf/IQUeh4XaFVGD3w0LnLxjtChigIWuVYDhsCJ752XQn3aI+amEt
 pnIJ+QbAZsH/DE3405c274Xsl7Wz0Bgu7U/+Ck40jJGpaaSsDmBfIq1EJ16OnnGZMawM20
 FShGTCDisWHhuiYOMEBkflU/DRjUp+c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-v5Y3N4rVMm-2l2gkm6tiKQ-1; Wed, 18 May 2022 12:33:08 -0400
X-MC-Unique: v5Y3N4rVMm-2l2gkm6tiKQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 i131-20020a1c3b89000000b00393fbb0718bso3151995wma.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 09:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=6BW+tomAtB+5qk/t/SKeP6VB//NGldp/mpIoLmV3bKM=;
 b=KSjNU/l3HJ2nviy+zON69dOnsWj4WCEdseOQJSeWDH+5Ts+HcAB9Nr2b5HyxCZQQp2
 nMEIo+OlfllOlrfvCqRlQ/fNOhiwBS2/CHVp3E3oU3GWqHuW/EA1Gbouo34P0yQsPS31
 tW39vsINPWv9qBYCx8nc2hug+EWyVVjbVC/8AGD+2CUmCjBp7N1JthIeAdH2XjNxyIPU
 +JYcIYWVCfj+RtoYG1ouv6gk/0erUDw5lJcTkxc82gp0sZVQriEHiBDhY/o4pVeY4wlR
 ruIYAOwGjBOLvkkkb4gc6fjspOodyok6spKynwgtOafu+6CEkCamrxuDfo6dF2CZ0DmR
 eblA==
X-Gm-Message-State: AOAM530hhClHcOgG7DTjHEZ3NO4vVY1N85/CClwUqRSgTmda7E4Ziepy
 7TzH/6RhjcKrLVRKGUXgPkcy/iMXKub/jOzQ7hyVCpSpcPOHBraMCYk0PwzBHyWp3EmXZC9D+H4
 j9D+6DeY67q8dIeSqoUMNG5wXF+AUONgGV4IyroR3Tw==
X-Received: by 2002:a05:6000:1688:b0:20d:a533:fc5 with SMTP id
 y8-20020a056000168800b0020da5330fc5mr459074wrd.338.1652891586809; 
 Wed, 18 May 2022 09:33:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfNEmIPPO7ty/Qr0Slw7Q7GYnij8heyI7qsewEV2V5kqhFnMGnfmQUh+NwrkEXhVzH3oNxug==
X-Received: by 2002:a05:6000:1688:b0:20d:a533:fc5 with SMTP id
 y8-20020a056000168800b0020da5330fc5mr459036wrd.338.1652891586395; 
 Wed, 18 May 2022 09:33:06 -0700 (PDT)
Received: from redhat.com ([151.81.230.224]) by smtp.gmail.com with ESMTPSA id
 x10-20020a7bc20a000000b003942a244ebesm2121054wmi.3.2022.05.18.09.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 May 2022 09:33:06 -0700 (PDT)
Date: Wed, 18 May 2022 12:33:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] mlx5: last minute fixup
Message-ID: <20220518123304-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 elic@nvidia.com
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

The following changes since commit 42226c989789d8da4af1de0c31070c96726d990c:

  Linux 5.18-rc7 (2022-05-15 18:08:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to acde3929492bcb9ceb0df1270230c422b1013798:

  vdpa/mlx5: Use consistent RQT size (2022-05-18 12:31:31 -0400)

----------------------------------------------------------------
mlx5: last minute fixup

The patch has been on list for a while but as it was posted as part of a
thread it was missed.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Eli Cohen (1):
      vdpa/mlx5: Use consistent RQT size

 drivers/vdpa/mlx5/net/mlx5_vnet.c | 61 ++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 40 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
