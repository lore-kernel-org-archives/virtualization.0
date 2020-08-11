Return-Path: <SRS0=ofWe=BV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29150C433DF
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 09:52:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E148B207DA
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 09:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpEqBXKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E148B207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A2BFC85D9B;
	Tue, 11 Aug 2020 09:52:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wFPyMNcLa3Mu; Tue, 11 Aug 2020 09:52:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 31AA3854C4;
	Tue, 11 Aug 2020 09:52:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10CE0C013C;
	Tue, 11 Aug 2020 09:52:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11966C004D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 09:52:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0E30D87618
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 09:52:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 19yEzLwUooUo
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 09:52:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5CFCE8761F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 09:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597139563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=gGMnZPmT7ixMhwbu4yokwhtq3er1WJDeFsWp1eDU4pk=;
 b=YpEqBXKBESrNTJgMXZqQ/lxBx3bjpxJtmCHRJvEZQ6MlEOcCsdKRO+k1TN5bEH5UdIf5s6
 QRQzWUMQahhfYVyjfza8n95i0dmSwaNmVgBwm4GgV69LNtUdvgfeuxple8iHu3LGyy6uyz
 cH8W6Dd3pnvNPunvrxHkVsf2bdGfuAo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-TYTmt2WvNVi37cRfeqvB3A-1; Tue, 11 Aug 2020 05:52:41 -0400
X-MC-Unique: TYTmt2WvNVi37cRfeqvB3A-1
Received: by mail-wr1-f71.google.com with SMTP id s23so5386483wrb.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 02:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition;
 bh=gGMnZPmT7ixMhwbu4yokwhtq3er1WJDeFsWp1eDU4pk=;
 b=IzquG7pUO88BXTi2k9gZDCYu8fnuedbR6SlkVC4lkZm9XCl/QwYxBV5x7VacVN7dAH
 zw9hJ8f9bBDp3IovZtPljb6iAcQ5rls+7isTei0ZqV352rmcojGhvY0uCuhki+vGRvNO
 bGtSkeoMMHSQiXHuFLSVqd/9s+Zb2qUWReNZJIbC1wxxRwX2QkbgYCSOqiEoMN+pD6c7
 dFdjuUAMyWjYsJ7TZmTin+ACwdP4CE9EyRJZx4JOCErz+6CNX25ykgM5NiR2VM/ZfgSd
 FO4VyacnmO3HiJ+bdbZDgQN0W5Odoq5gmREpuLAoVK+oG+KDj6xTJ1bPlb+P5QJQ9Vb+
 xA1A==
X-Gm-Message-State: AOAM531FHbHMyzjYWhTyrgyzyDkNoIPM9vXC/Q5de92GhdJJXZuf8Ur5
 KIVAWZcDo8t4a6rQOA4v8f7P/40IxcLqjVuAYqKkJX8k0vFWpPF/hJFUuJ8A1DIU+gF+9guRlwH
 HOKKb2yqkB8r0QWDaXqbsfEJ3D1ymaXuvDE4UBekt9g==
X-Received: by 2002:a1c:5413:: with SMTP id i19mr3273265wmb.139.1597139560577; 
 Tue, 11 Aug 2020 02:52:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxf+f9BOAuNyV0fV51wxKj3vsz/ndrBpN0y84aVcs80B2Xl9d6mUZySMXQojfhQxR+zmZC+6w==
X-Received: by 2002:a1c:5413:: with SMTP id i19mr3273255wmb.139.1597139560405; 
 Tue, 11 Aug 2020 02:52:40 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id o3sm25950915wru.64.2020.08.11.02.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 02:52:39 -0700 (PDT)
Date: Tue, 11 Aug 2020 05:52:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org
Subject: vdpa: handling of VIRTIO_F_ACCESS_PLATFORM/VIRTIO_F_ORDER_PLATFORM
Message-ID: <20200811054754-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

Hi!
I'd like to raise the question of whether we can drop the requirement
of VIRTIO_F_ACCESS_PLATFORM from vdpa?
As far as I can see, it is merely required for virtio vdpa -
so should we not enforce it there?

The point is support for legacy guests - which mostly just works
on x86.

Also, what is the plan for VIRTIO_F_ORDER_PLATFORM?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
