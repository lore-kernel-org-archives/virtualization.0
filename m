Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A49C4332F
	for <virtualization@archiver.kernel.org>; Thu, 13 Oct 2022 13:40:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 747644040D;
	Thu, 13 Oct 2022 13:40:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 747644040D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yrq1roku
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xMvypic3mwac; Thu, 13 Oct 2022 13:40:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0AC834010E;
	Thu, 13 Oct 2022 13:40:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0AC834010E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D671BC0032;
	Thu, 13 Oct 2022 13:40:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 200E7C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 13:40:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E91E1402DC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 13:40:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E91E1402DC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yk16YnjJDJnh
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 13:40:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E6C2B4010E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E6C2B4010E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 13:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665668427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=DcJvD5vzFcxsS07jGH2XZzGBqICBqV6Tq7siAWkTRL0=;
 b=Yrq1roku9v79loMhfPvHHbjZ9B13SU8LaMh5/bg7ozYlhM8VXjWqiL1OOaYr4yKvfntF3Q
 NgOyQpp7ow8iEjViFbPfAiuzziynCeltJezgyWl6jKH93FfKfsjPpt4JV57KnWi6Fy/7+g
 4KV0oW4OvB5N2N0+MQ8e73z84lQEpLk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-609-hDGEp68GN6ylICkUlw2SiA-1; Thu, 13 Oct 2022 09:40:26 -0400
X-MC-Unique: hDGEp68GN6ylICkUlw2SiA-1
Received: by mail-wm1-f70.google.com with SMTP id
 c3-20020a7bc843000000b003b486fc6a40so844721wml.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Oct 2022 06:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DcJvD5vzFcxsS07jGH2XZzGBqICBqV6Tq7siAWkTRL0=;
 b=XBs8pVJFPUUPG+HUZTdiV4Cmlc3wy+K4MLW7D3sr63oIsbS9btHiuVJqX1QKTAsiEd
 SSQmRFf0XmMf81Cahh6RraVR8Y5Wgmcgwf1ATpkh0tfKDyxEpC3qNtI701YOScI5Qykk
 DV/SL6lJvRqNAnktfVQeUOGS4p2UQzl/3BkK8GZ69J++6knKIHheMmUeKGCGV0PZ0gcc
 fV1eD55cyeXw9Jf5+sGgiabdBzXfaoNvVUPq8xZznKmAHxoN92PNqGCJ/mn8Q8cmgSV9
 L2WIToSnx+a+dEj8Kv7CBkPkaYckgW6d4K5yXIl097GZNiRB/h/K+WhnpDY8VyYJD4S5
 4qEg==
X-Gm-Message-State: ACrzQf2NAwrd8/0xhpJRu86yZNTBywpEl9bfiZv42FHzeCxEcJoUz2uI
 70pduUzNFWJ9XwAiJU0E7IVFWXBymbzO6JVLXOsW3FQ1JjLHNqfQlFx97elEUx0kIirroEzsvli
 CwOLtF7xHopxGkH85E9pDKtII9TsIj0vrlwSkuavt/g==
X-Received: by 2002:a05:600c:88a:b0:3c5:c9e3:15cc with SMTP id
 l10-20020a05600c088a00b003c5c9e315ccmr6622899wmp.67.1665668425603; 
 Thu, 13 Oct 2022 06:40:25 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6TnPZr5gSOifctojxkDFUAx5X0RgYRQuKniGc+MNA0UHK/ABnoPNo2kwVXsSINExlzellCjg==
X-Received: by 2002:a05:600c:88a:b0:3c5:c9e3:15cc with SMTP id
 l10-20020a05600c088a00b003c5c9e315ccmr6622877wmp.67.1665668425410; 
 Thu, 13 Oct 2022 06:40:25 -0700 (PDT)
Received: from redhat.com ([2.54.162.123]) by smtp.gmail.com with ESMTPSA id
 bl13-20020adfe24d000000b00230b3a0f461sm2065542wrb.33.2022.10.13.06.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Oct 2022 06:40:24 -0700 (PDT)
Date: Thu, 13 Oct 2022 09:40:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio: bugfix, reviewer
Message-ID: <20221013094021-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mpe@ellerman.id.au, angus.chen@jaguarmicro.com, lingshan.zhu@intel.com
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

The following changes since commit 041bc24d867a2a577a06534d6d25e500b24a01ef:

  Merge tag 'pci-v6.1-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci (2022-10-11 11:08:18 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to be8ddea9e75e65b05837f6d51dc5774b866d0bcf:

  vdpa/ifcvf: add reviewer (2022-10-13 09:37:30 -0400)

----------------------------------------------------------------
virtio: bugfix, reviewer

Fix a regression in virtio pci on power.
Add a reviewer for ifcvf.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Michael S. Tsirkin (2):
      virtio_pci: use irq to detect interrupt support
      vdpa/ifcvf: add reviewer

 MAINTAINERS                        | 4 ++++
 drivers/virtio/virtio_pci_common.c | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
