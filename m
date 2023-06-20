Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B30EB64D7
	for <virtualization@archiver.kernel.org>; Tue, 20 Jun 2023 15:13:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EC3C641725;
	Tue, 20 Jun 2023 15:13:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC3C641725
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=N6t88ac0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dRQdnDFKUV9T; Tue, 20 Jun 2023 15:13:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 431454170A;
	Tue, 20 Jun 2023 15:13:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 431454170A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEFDDC0037;
	Tue, 20 Jun 2023 15:13:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99930C0029
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 15:13:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7E29781324
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 15:13:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E29781324
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=N6t88ac0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YrnGX4L31UTY
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 15:13:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6DD598129F
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6DD598129F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 15:13:51 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-666683eb028so2709845b3a.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 08:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1687274031; x=1689866031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cYhpq8kII/zBY/3iWU+UakUCHm4VL9Cr+rVrcVWuTHY=;
 b=N6t88ac0/O9s1WSvaIdjbqn07sFmRw7LRT9pzUoAPItbwebr1dZnPGKuiO5ep9pKb2
 UBuw49WxISSOx7oeBfa4zbSCOE68r0PGKekjIy3XjV5KVMtuATtOpyGJafarRoNOxZpX
 JavurTTFcLQInhHa02OYpekFd7Wg/YQL4TOJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687274031; x=1689866031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cYhpq8kII/zBY/3iWU+UakUCHm4VL9Cr+rVrcVWuTHY=;
 b=FkOlKE7eGO4INufgR2pUnlBsstn8TXAnuEpLOxSw0UQWOjXeYrheLsliGR6GBt9JJP
 fgnljDhrNqQ4pvRxiQL7lHZfoWDEirxp3tO8XJN9Yh4rZCFRpYHnb6z4qpHeHST9Gs0H
 vFTv6etvS2P3mexoIB7WINu+rQoZ4Zi+y6KWtZ80XPx0YNQ7yFovz9tzyPsByH8G4gMh
 V/uVtRcRQvjcS3x0FfcAsY/Rbn1zp8cxX5MDeOM5mUwJXwjXLLfT4448paoCCHVukxGf
 0CsgpIIkKim2Au1uxw7bKYZ6lhFI6hsatd2AqD92VcycIY5lRuRgkHJ00ngHY7e+9t1W
 lyIQ==
X-Gm-Message-State: AC+VfDyxWQqwFnKt+7SVwW5sCpH6zfHraOkzQszdpauqLK9DgnHGNDnc
 otqmTs6gwLL7RodSO0hFYuG6hQ==
X-Google-Smtp-Source: ACHHUZ5FuufZTijicZcf+ErEEp0rFQuZuKEzL6yES24xb2lmYLqT0Bo9sqezWSJJNuVJRjpYIfom4g==
X-Received: by 2002:a05:6a20:8411:b0:10c:4c76:e909 with SMTP id
 c17-20020a056a20841100b0010c4c76e909mr10027154pzd.8.1687274030764; 
 Tue, 20 Jun 2023 08:13:50 -0700 (PDT)
Received: from keiichiw1.tok.corp.google.com
 ([2401:fa00:8f:203:e87e:41e3:d762:f8a8])
 by smtp.gmail.com with ESMTPSA id
 x9-20020a170902ec8900b001aaf370b1c7sm1731872plg.278.2023.06.20.08.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:13:50 -0700 (PDT)
From: Keiichi Watanabe <keiichiw@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Support negative dentry cache for FUSE and virtiofs
Date: Wed, 21 Jun 2023 00:13:13 +0900
Message-ID: <20230620151328.1637569-1-keiichiw@chromium.org>
X-Mailer: git-send-email 2.41.0.185.g7c58973941-goog
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


This patch series adds a new mount option called negative_dentry_timeout
for FUSE and virtio-fs filesystems. This option allows the kernel to cache
negative dentries, which are dentries that represent a non-existent file.
When this option is enabled, the kernel will skip FUSE_LOOKUP requests for
second and subsequent lookups to a non-existent file.

Unlike negative dentry caches on a normal filesystem such as ext4, the
kernel may need to refresh the cache for FUSE and virtio-fs filesystems.
This is because the kernel does not know when a FUSE server or a virtio-fs
device creates or deletes files. To address this, the new
negative_dentry_timeout option takes an expiration time for cache entries.
The appropriate timeout duration should be determined by considering how
often a FUSE server updates file paths and the amount of memory the kernel
can use for the cache.

As we evaluated the virtio-fs's performance on a guest Linux on crosvm
[1]'s virtiofs device[2], the `negative_dentry_timeout` option saved ~1
second per 10000 `stat` call against a non-existent path. The experiment
settings and results are as follows:

* Command to start VM with crosvm:
sudo crosvm run \
  --disable-sandbox \
  --cpus 1 \
  --mem 2048 \
  --rwroot debian.img \
  --shared-dir \
  /path/:my_virtiofs:type=fs:cache=always:timeout=3600 \
  -p "console=hvc0 init=/bin/bash" \
  vmlinux

* Mount command in the guest
Default:
$ mount -t virtiofs my_virtiofs ./workspace/
With negative dentry cache:
$ mount -t virtiofs -o negative_dentry_timeout=10 my_virtiofs ./workspace/

* Test commands
$ cd workspace
$ echo 3 > /proc/sys/vm/drop_caches
$ time for i in `seq 1 10000`; \
  do stat non-existent.txt 2> /dev/null; \
  done

* Results:
Default:
real 0m12.606s
user 0m3.624s
sys 0m7.756s

With `-o negative_dentry_timeout=10`:
real 0m11.276s
user 0m3.514s
sys 0m7.544s

[1]: https://crosvm.dev/book/
[2]: https://crosvm.dev/book/devices/fs.html


Keiichi Watanabe (3):
  docs: virtiofs: Fix descriptions about virtiofs mount option
  fuse: Add negative_dentry_timeout option
  virtiofs: Add negative_dentry_timeout option

 Documentation/filesystems/dax.rst      |  1 +
 Documentation/filesystems/fuse.rst     |  6 ++++++
 Documentation/filesystems/virtiofs.rst |  9 ++++++++-
 fs/fuse/dir.c                          |  3 ++-
 fs/fuse/fuse_i.h                       |  4 ++++
 fs/fuse/inode.c                        | 12 +++++++++++-
 fs/fuse/virtio_fs.c                    |  8 ++++++++
 7 files changed, 40 insertions(+), 3 deletions(-)

-- 
2.41.0.185.g7c58973941-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
