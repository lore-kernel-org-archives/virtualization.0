Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576A1C433EF
	for <virtualization@archiver.kernel.org>; Mon, 14 Mar 2022 12:00:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E15E040616;
	Mon, 14 Mar 2022 12:00:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 87eV--f7LYUH; Mon, 14 Mar 2022 12:00:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 564B64002B;
	Mon, 14 Mar 2022 12:00:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F237C001D;
	Mon, 14 Mar 2022 12:00:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B39FBC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 12:00:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9C840414C6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 12:00:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lxD2ixIpFnqj
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 12:00:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CE512409F9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 11:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647259198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=DTumIzkUVMCDvmMhaJUDyMiG+aNJUlziXvFqILOQYsI=;
 b=Te/XB94wzBdxgZHhteB2udunadJ24MJUt4qp/eatCDuw4e0Xl6Wb+w1HEgBSRwWLt5g+Ry
 HloGL3mFSgpRxA0ApydIwUVJLcJ/vChvSgcbY88o9ZQuhOHzuy+3MF984jCk+ytBQJCqUa
 5W2KRZBX91/U2p/FaMBB9o7SZaG/iQc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-249-bHxHegLqOvW-H7uWkhmNfg-1; Mon, 14 Mar 2022 07:59:57 -0400
X-MC-Unique: bHxHegLqOvW-H7uWkhmNfg-1
Received: by mail-wm1-f69.google.com with SMTP id
 14-20020a05600c028e00b003897a4056e8so6915256wmk.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 04:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=DTumIzkUVMCDvmMhaJUDyMiG+aNJUlziXvFqILOQYsI=;
 b=p3QTNVAHnYEhpb/YycympF3pOSpBVjxU56evG4GayYF3sgYeshzVd4ye0QLgpHuv8n
 Tt0STuAQarZXLc9AZKbPOxfy5QcHCZi/NXXqqNDviVk49VCUFhCPEL0q8TsWZQUB6Ebn
 dV+y7jWIvOkOZLJSbbiqA7LXiM1o38wJ5ossu+tJ9CJmc8w5mEllAgS5U9Pam8mwmsR7
 Fnor2XTPW4uSmziyCLelXo0xvxgcYRfilHA3HyOMcP+w5iklMeRH0l143cdGCHILqCzR
 qIrBXCraetcGZuG9l67eAg9dD7VyjwntBKeoIcgV43XP+wz/jNWCw/KkVFtPtlywLyeB
 6fwg==
X-Gm-Message-State: AOAM531yRaHxz2lcxp9V130HwwbUw82TDP1b+CeW5T3sAuJpZxnTBDbR
 su1VMkRca+9fg7cay3+BFnWNi3JLC+QhSpQBrZzE9wpTu+EtcQXbB9l+sjKYTkmgUe64SETHXQp
 kTEhDMVO2/vu/dHTiayp9CRNPDsGhJMcYFJ8jD9I7PQ==
X-Received: by 2002:a05:600c:4f09:b0:389:cf43:eaf8 with SMTP id
 l9-20020a05600c4f0900b00389cf43eaf8mr17160218wmq.201.1647259194496; 
 Mon, 14 Mar 2022 04:59:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzp7ZJAVv6i97GoEYXJTrh4j1WEgqWNchpszO38kLqkQtDsjqJCu3h0XIEDXpnWhcBdQ3hpYw==
X-Received: by 2002:a05:600c:4f09:b0:389:cf43:eaf8 with SMTP id
 l9-20020a05600c4f0900b00389cf43eaf8mr17160208wmq.201.1647259194258; 
 Mon, 14 Mar 2022 04:59:54 -0700 (PDT)
Received: from redhat.com ([2.55.183.53]) by smtp.gmail.com with ESMTPSA id
 w6-20020a5d6806000000b002036515dda7sm13416882wru.33.2022.03.14.04.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Mar 2022 04:59:53 -0700 (PDT)
Date: Mon, 14 Mar 2022 07:59:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio: a last minute regression fix
Message-ID: <20220314075951-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mail@anirudhrb.com, elic@nvidia.com
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

The following changes since commit 3dd7d135e75cb37c8501ba02977332a2a487dd39:

  tools/virtio: handle fallout from folio work (2022-03-06 06:06:50 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 95932ab2ea07b79cdb33121e2f40ccda9e6a73b5:

  vhost: allow batching hint without size (2022-03-10 08:12:04 -0500)

----------------------------------------------------------------
virtio: a last minute regression fix

I thought we did a lot of testing, but a regression still
managed to sneak in. The fix seems trivial.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Jason Wang (1):
      vhost: allow batching hint without size

 drivers/vhost/vhost.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
