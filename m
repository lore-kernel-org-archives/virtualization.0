Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8A3C433FE
	for <virtualization@archiver.kernel.org>; Mon, 22 Nov 2021 16:36:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1424F40241;
	Mon, 22 Nov 2021 16:36:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DldaNWW4rHo9; Mon, 22 Nov 2021 16:36:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5085A40223;
	Mon, 22 Nov 2021 16:36:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25E80C002E;
	Mon, 22 Nov 2021 16:36:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79A87C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 16:36:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5AACC40575
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 16:36:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qCpwkZ913qdS
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 16:36:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 98FE340544
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 16:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637598970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xOj6PkANhb6frdrg6dV7v39rxknergSrEgBUTsnCA3U=;
 b=NMJsZBSh0lzuwABofp9sIUSrev6SrDDk+UXWwQBO4uhKZ2afBNMb9JUbkIxIdI2SvtKbnD
 kb0NYO/f3yXNMKKH72gT4a2zUrTh8Axx/koJH1ZKLXLbZCnB1eIMksFwvoyf9u7eWlAdjQ
 YTk4HBkWoJ9aYTPwAFS4zoLCD2tR3us=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-s8WjydtlOVmkHHoVEWKNiA-1; Mon, 22 Nov 2021 11:36:09 -0500
X-MC-Unique: s8WjydtlOVmkHHoVEWKNiA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5A771023F4F;
 Mon, 22 Nov 2021 16:36:07 +0000 (UTC)
Received: from steredhat.redhat.com (unknown [10.39.192.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6D1D60C7F;
 Mon, 22 Nov 2021 16:35:26 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 0/2] vhost/vsock: fix used length and cleanup in
 vhost_vsock_handle_tx_kick()
Date: Mon, 22 Nov 2021 17:35:23 +0100
Message-Id: <20211122163525.294024-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Halil Pasic <pasic@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Asias He <asias@redhat.com>
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

This is a follow-up to Micheal's patch [1] and the discussion with Halil and
Jason [2].

I made two patches, one to fix the problem and one for cleanup. This should
simplify the backport of the fix because we've had the problem since
vhost-vsock was introduced (v4.8) and that part has been touched a bit
recently.

Thanks,
Stefano

[1] https://lore.kernel.org/virtualization/20211122105822.onarsa4sydzxqynu@steredhat/T/#t
[2] https://lore.kernel.org/virtualization/20211027022107.14357-1-jasowang@redhat.com/T/#t

Stefano Garzarella (2):
  vhost/vsock: fix incorrect used length reported to the guest
  vhost/vsock: cleanup removing `len` variable

 drivers/vhost/vsock.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
