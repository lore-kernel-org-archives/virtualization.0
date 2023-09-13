Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE49EDEC73
	for <virtualization@archiver.kernel.org>; Wed, 13 Sep 2023 15:04:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EB7060A79;
	Wed, 13 Sep 2023 15:04:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8EB7060A79
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UOG/uU7b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AIz1wEgz84rJ; Wed, 13 Sep 2023 15:04:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B1A0660B57;
	Wed, 13 Sep 2023 15:04:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B1A0660B57
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E436C0071;
	Wed, 13 Sep 2023 15:04:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E77B9C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 15:04:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B934F4138D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 15:04:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B934F4138D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UOG/uU7b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KECDjNhnc9FA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 15:04:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B751E40871
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 15:04:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B751E40871
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694617470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=rwIQDXNs82qD7q4ewNp//4ii4InYSIsRfhTkCMfwRtA=;
 b=UOG/uU7bz+mEpW+dGlqoxRia2U4yo/qpHSLmOFiaD302mGSFW+DDHd4gt1z71JGSd/FAVY
 LV5Df3Wk1536XLec6jCk1w2sT0o37RV88HM+uqwRgHFV6H2Q7EZsarnMti8zcvNci9/C0k
 DSykBysaVLxaRsMg0kRN1qdf4XMePDY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-EscOx4fyNiGAUJFNy1n__w-1; Wed, 13 Sep 2023 11:04:28 -0400
X-MC-Unique: EscOx4fyNiGAUJFNy1n__w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-401e521122fso54571795e9.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 08:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694617467; x=1695222267;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rwIQDXNs82qD7q4ewNp//4ii4InYSIsRfhTkCMfwRtA=;
 b=VfsDiLVY/bD+3b5FV9/I3TK5kwUtX2yFbMu6/ChnxSPKd1OVnthRH3HGV7rNFeXPhl
 s7I/iZmkVtoj0yTZFpOgT4jiaAvqgG6lFwTtm8EgBkd/LJC1LdsUL2OnLETiqQyyVKOy
 mHkrQixwcejcjRYppkBwoayVGM39RsWW0WS4z3jv6IGoJf00nMaYAh4sA2qH66JmOfcJ
 bNYBHsDgaLNWKGhDymTH5ghEqIr+y6u9pJTagyQF8DCCOFQLHoO2TYRoNu24ZQI4tRLv
 LxHsh2MNs/H2KKNGoV4oqqC3KzC1cJNnLAvCJvwZz7KSSLrLqZS9qbe1EWM9N6tWR/EO
 SQIg==
X-Gm-Message-State: AOJu0YwnkYp5r3lid4CbxOzHHQSNU5oFatjifW3ku/t8r45wOkMZrpAp
 ApmE3oHJBo/u2Cx3/Mm8jx9yrLn5vDbzhBg00hDmcLhs+f1pdwglskt8vTzz6yTG85R9YcOirnn
 MLCNr8HrFK5bGIjHiiHgA4kBo7/Wy+oltdJ/+RQJBnnTHE1fzEtVA5XMecmgxGyXl9HbWFhoZdc
 BX36P520P0uE8QgIBt04hZTVKmjptV
X-Received: by 2002:a05:600c:219a:b0:3fe:1f93:8cf4 with SMTP id
 e26-20020a05600c219a00b003fe1f938cf4mr2261412wme.8.1694617467401; 
 Wed, 13 Sep 2023 08:04:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFN+UQjHyCh0ekVnuJZMdgO2BSQZ+Kan1s0gLV7d+40D696dEdZr2S/+2XZZU4ZvTo8eys71w==
X-Received: by 2002:a05:600c:219a:b0:3fe:1f93:8cf4 with SMTP id
 e26-20020a05600c219a00b003fe1f938cf4mr2261383wme.8.1694617466913; 
 Wed, 13 Sep 2023 08:04:26 -0700 (PDT)
Received: from pc-79.home ([2a01:cb15:805d:bf00:8136:3827:5b1a:46d])
 by smtp.gmail.com with ESMTPSA id
 8-20020a05600c028800b00402c0a8a084sm2244564wmk.17.2023.09.13.08.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 08:04:26 -0700 (PDT)
Date: Wed, 13 Sep 2023 17:04:24 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: virtio-sound linux driver conformance to spec
Message-ID: <ZQHPeD0fds9sYzHO@pc-79.home>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: mst@redhat.com, stefanha@redhat.com, virtio-comment@lists.oasis-open.org
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

Hello,

This email is to report a behavior of the Linux virtio-sound driver that
looks like it is not conforming to the VirtIO specification. The kernel
driver is moving buffers from the used ring to the available ring
without knowing if the content has been updated from the user. If the
device picks up buffers from the available ring just after it is
notified, it happens that the content is old. This problem can be fixed
by waiting a period of time after the device dequeues a buffer from the
available ring. The driver should not be allowed to change the content
of a buffer in the available ring. When buffers are enqueued in the
available ring, the device can consume them immediately.

1. Is the actual driver implementation following the spec?  
2. Shall the spec be extended to support such a use-case?

Thanks, Matias

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
