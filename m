Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95505C433FE
	for <virtualization@archiver.kernel.org>; Wed, 16 Mar 2022 08:59:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 428744028B;
	Wed, 16 Mar 2022 08:59:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9oU3CSi9r1vj; Wed, 16 Mar 2022 08:59:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BE0B440245;
	Wed, 16 Mar 2022 08:59:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D87FC0012;
	Wed, 16 Mar 2022 08:59:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E934C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 08:59:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 27C0484174
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 08:59:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x_-6aIlTv1Qk
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 08:59:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 70FDC84145
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 08:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647421145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2IQfYLfuAocMPTVuNwxwAuSPOEHSe4nK/cDVLhWner4=;
 b=JRIG7onM41ycHFYOSnZtS92L0psyThIqzv9b5CWsWKpBaJaUsg1x2Ak0KkSB1USnPtE3vj
 UNKuUBdBghlS2wd9sAfRn/MLjU1MbwYEXn+Vqe+BMfV6DSyzA+hGc03QT2DByuFQa8yGBd
 C530ua39NBlnlY+tCU4wgYhI+Ud1PHQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-nCu_68qnM8ikbp2m8lKIJw-1; Wed, 16 Mar 2022 04:59:04 -0400
X-MC-Unique: nCu_68qnM8ikbp2m8lKIJw-1
Received: by mail-qv1-f70.google.com with SMTP id
 h18-20020a05621402f200b00440cedaa9a2so1229464qvu.17
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 01:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2IQfYLfuAocMPTVuNwxwAuSPOEHSe4nK/cDVLhWner4=;
 b=LAgMsUpJRCVGvi3FMtN8hfF11iUXAPpuo3oOpaacUvp0udsT3cvF5b+XBCL9hQRTMj
 BEx9eWTRxw9/HeCiNOq01uD/X5Ylr+oNDFM0CXPHhbc4245vFeKcrtrOp5BTHvXScdXS
 plljTrsE7NO1joFI8LLKfipm/fosfQF+wso4Ca4AabLN0wzgz/DeVJzmehjmXuWZhPP+
 CkcSUduo4TjPvlq18Yj5nO67+4GBSWYYxTS2WF+Qk0u8/KwVQQAWNYm00AmEME091hfR
 CBAkBCa6dP/sYog2fpQM8s96Ilwf5hu6hFiDEPYVaRAVwxumLV3zqKTQ4yJ3999mAolZ
 AAIQ==
X-Gm-Message-State: AOAM531Cx6k8z+DD+m0rA2o0tHV9yd6fMyV02Gb5MMFlUF79RVX73QnD
 8URDKr0yIZoxMNX8CxHIUfZU/0a0Vw2oZIMydZNtqOmklI0rVNgNb+/Y5B/dJ+VuaLvr9CA+uGz
 B8wdgsC4BRaWxPj+2jBBZLxec32Rm8QjS54QgrC65gA==
X-Received: by 2002:a37:946:0:b0:67d:9d27:3c1 with SMTP id
 67-20020a370946000000b0067d9d2703c1mr11964251qkj.476.1647421143373; 
 Wed, 16 Mar 2022 01:59:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxE0vzbmy81u38sAbV94J0w29xluplMn3uFAqGcnwP0RR4dmNglMBlgx+GJvoCwd8mKJnazsA==
X-Received: by 2002:a37:946:0:b0:67d:9d27:3c1 with SMTP id
 67-20020a370946000000b0067d9d2703c1mr11964239qkj.476.1647421143091; 
 Wed, 16 Mar 2022 01:59:03 -0700 (PDT)
Received: from sgarzare-redhat (host-212-171-187-184.retail.telecomitalia.it.
 [212.171.187.184]) by smtp.gmail.com with ESMTPSA id
 v3-20020a05622a188300b002e1cbca8ea4sm1066677qtc.59.2022.03.16.01.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Mar 2022 01:59:02 -0700 (PDT)
Date: Wed, 16 Mar 2022 09:58:54 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Krasnov Arseniy Vladimirovich <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 0/2] af_vsock: add two new tests for SOCK_SEQPACKET
Message-ID: <20220316085854.estmt5xafafsmp73@sgarzare-redhat>
References: <1474b149-7d4c-27b2-7e5c-ef00a718db76@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <1474b149-7d4c-27b2-7e5c-ef00a718db76@sberdevices.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Krasnov Arseniy <oxffffaa@gmail.com>,
 Rokosov Dmitry Dmitrievich <DDRokosov@sberdevices.ru>
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

On Wed, Mar 16, 2022 at 07:25:07AM +0000, Krasnov Arseniy Vladimirovich wrote:
>This adds two tests: for receive timeout and reading to invalid
>buffer provided by user. I forgot to put both patches to main
>patchset.
>
>Arseniy Krasnov(2):
>
>af_vsock: SOCK_SEQPACKET receive timeout test
>af_vsock: SOCK_SEQPACKET broken buffer test
>
>tools/testing/vsock/vsock_test.c | 211 +++++++++++++++++++++++++++++++++++++++
>1 file changed, 211 insertions(+)

I think there are only small things to fix, so next series you can 
remove RFC (remember to use net-next).

I added the tests to my suite and everything is running correctly.

I also suggest you to solve these little issues that checkpatch has 
highlighted to have patches ready for submission :-)

Thanks,
Stefano

$ ./scripts/checkpatch.pl --strict -g  master..HEAD
---------------------------------------------------------------------
Commit 2a1bfb93b51d ("af_vsock: SOCK_SEQPACKET receive timeout test")
---------------------------------------------------------------------
CHECK: Unnecessary parentheses around 'errno != EAGAIN'
#70: FILE: tools/testing/vsock/vsock_test.c:434:
+	if ((read(fd, &dummy, sizeof(dummy)) != -1) ||
+	   (errno != EAGAIN)) {

WARNING: From:/Signed-off-by: email name mismatch: 'From: Krasnov Arseniy Vladimirovich <AVKrasnov@sberdevices.ru>' != 'Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>'

total: 0 errors, 1 warnings, 1 checks, 97 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or --fix-inplace.

Commit 2a1bfb93b51d ("af_vsock: SOCK_SEQPACKET receive timeout test") has style problems, please review.
-------------------------------------------------------------------
Commit 9176bcabcdd7 ("af_vsock: SOCK_SEQPACKET broken buffer test")
-------------------------------------------------------------------
CHECK: Comparison to NULL could be written "!buf1"
#51: FILE: tools/testing/vsock/vsock_test.c:486:
+	if (buf1 == NULL) {

CHECK: Comparison to NULL could be written "!buf2"
#57: FILE: tools/testing/vsock/vsock_test.c:492:
+	if (buf2 == NULL) {

CHECK: Please don't use multiple blank lines
#152: FILE: tools/testing/vsock/vsock_test.c:587:
+
+

WARNING: From:/Signed-off-by: email name mismatch: 'From: Krasnov Arseniy Vladimirovich <AVKrasnov@sberdevices.ru>' != 'Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>'

total: 0 errors, 1 warnings, 3 checks, 150 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or --fix-inplace.

Commit 9176bcabcdd7 ("af_vsock: SOCK_SEQPACKET broken buffer test") has style problems, please review.

NOTE: If any of the errors are false positives, please report
       them to the maintainer, see CHECKPATCH in MAINTAINERS.




_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
