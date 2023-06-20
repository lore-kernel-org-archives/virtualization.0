Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D540FEB64D7
	for <virtualization@archiver.kernel.org>; Tue, 20 Jun 2023 15:14:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5DE58418DA;
	Tue, 20 Jun 2023 15:14:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5DE58418DA
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XKfp2wc7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JGcrTQcOAw-B; Tue, 20 Jun 2023 15:14:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 83240418B3;
	Tue, 20 Jun 2023 15:14:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 83240418B3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59958C0037;
	Tue, 20 Jun 2023 15:14:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 330CEC0029
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 15:14:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7921F4172C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 15:14:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7921F4172C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=XKfp2wc7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zNVuD3u9Evl6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 15:14:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DADC04172A
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DADC04172A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 15:14:00 +0000 (UTC)
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-54f87d5f1abso2120495a12.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 08:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1687274040; x=1689866040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lRb96LJgR72xVeW8oewPH/vIoAVz/LQLwg+4m06vZkc=;
 b=XKfp2wc7nAI8DCwXu8AhLAR5wD/2txHmlVMHGvKvNUaTw24+5WQRKQY0Xhr4S6HgiZ
 GRTW4OLWcisOfwkiy06oWmwYPHjfI2rB+H0ltRtxXHomXz841Ao/7ERSbBkQk1WNDx8L
 RqeqommVxKAl1E0YcwBImX9LSeUv3JGSoYIgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687274040; x=1689866040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lRb96LJgR72xVeW8oewPH/vIoAVz/LQLwg+4m06vZkc=;
 b=l20sT8OFs0Q4viS+IyRmZQ/tVkbpunLxEeftCLSNOD89RiwKbPRUnu+4l38T17ERmx
 NnQibPzQmUpIR2m5ZYcinDCUePd7kLLIY1cWSz3nrxy9BViUvRJTEPIzf7MRwzXIN0DF
 3XE3IPfHnHE3YNkEwJWqIRlytvEfuW3gzhgo0UGolp0rqkjliNpM3n0PJdvSbmg9CnmV
 s7ifKoZr+f/eDZZFh1lwgoAeNiAUqsbvCaK/eit2bqn9cRnjvuKs/UBsI5pik1V/Bznd
 st2yJoXW32bbPAeAWcphCKQ7lq26n2loT12XgtpRMwvzkT5w/a+3rkUgFcvQixiE5oMh
 iZaQ==
X-Gm-Message-State: AC+VfDxwaWx+agmgNroQrjDIUkcYQ9nDG4Pw/BHfaCLnUbNveQn87v1N
 9oBdfUj4cay/Wc8TD5ncMcGkxQ==
X-Google-Smtp-Source: ACHHUZ7vDNz9Cx5BItNVohrwafUr0euSnM4MHgJv4ESsQf5sFBe9OMU343gsncNkMmM7BVjOusovJA==
X-Received: by 2002:a17:902:ecc2:b0:1b5:561a:5c9a with SMTP id
 a2-20020a170902ecc200b001b5561a5c9amr4465646plh.39.1687274040118; 
 Tue, 20 Jun 2023 08:14:00 -0700 (PDT)
Received: from keiichiw1.tok.corp.google.com
 ([2401:fa00:8f:203:e87e:41e3:d762:f8a8])
 by smtp.gmail.com with ESMTPSA id
 x9-20020a170902ec8900b001aaf370b1c7sm1731872plg.278.2023.06.20.08.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:13:59 -0700 (PDT)
From: Keiichi Watanabe <keiichiw@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] docs: virtiofs: Fix descriptions about virtiofs mount
 option
Date: Wed, 21 Jun 2023 00:13:14 +0900
Message-ID: <20230620151328.1637569-2-keiichiw@chromium.org>
X-Mailer: git-send-email 2.41.0.185.g7c58973941-goog
In-Reply-To: <20230620151328.1637569-1-keiichiw@chromium.org>
References: <20230620151328.1637569-1-keiichiw@chromium.org>
MIME-Version: 1.0
Cc: uekawa@chromium.org, mhiramat@google.com, drosen@google.com,
 Jonathan Corbet <corbet@lwn.net>, sarthakkukreti@google.com,
 Miklos Szeredi <miklos@szeredi.hu>, linux-doc@vger.kernel.org,
 virtualization@lists.linux-foundation.org, takayas@chromium.org,
 Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel@vger.kernel.org,
 Vivek Goyal <vgoyal@redhat.com>
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

Since virtiofs and FUSE don't share mount options, fixes the
description. Also, explains DAX option as the only virtiofs-specific
option so far.

Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
---

 Documentation/filesystems/dax.rst      | 1 +
 Documentation/filesystems/virtiofs.rst | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/dax.rst b/Documentation/filesystems/dax.rst
index c04609d8ee24..77c5d4550ecd 100644
--- a/Documentation/filesystems/dax.rst
+++ b/Documentation/filesystems/dax.rst
@@ -167,6 +167,7 @@ Setting the `FS_XFLAG_DAX` flag (specifically or through inheritance) occurs eve
 if the underlying media does not support dax and/or the filesystem is
 overridden with a mount option.
 
+.. _virtiofs-dax:
 
 Enabling DAX on virtiofs
 ----------------------------
diff --git a/Documentation/filesystems/virtiofs.rst b/Documentation/filesystems/virtiofs.rst
index fd4d2484e949..fdec5a7840f7 100644
--- a/Documentation/filesystems/virtiofs.rst
+++ b/Documentation/filesystems/virtiofs.rst
@@ -43,7 +43,10 @@ Mount options
 -------------
 
 virtiofs supports general VFS mount options, for example, remount,
-ro, rw, context, etc. It also supports FUSE mount options.
+ro, rw, context, etc. Also, virtiofs has its own options.
+
+dax[=always,never,inode]
+  Enable direct access for files. See :ref:`virtiofs-dax`.
 
 atime behavior
 ^^^^^^^^^^^^^^
-- 
2.41.0.185.g7c58973941-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
