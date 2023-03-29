Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1876EC74A5B
	for <virtualization@archiver.kernel.org>; Wed, 29 Mar 2023 11:03:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F9EB8194C;
	Wed, 29 Mar 2023 11:03:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F9EB8194C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=vIEbQUp1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id akFcVY1YPaOk; Wed, 29 Mar 2023 11:03:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 190C58176A;
	Wed, 29 Mar 2023 11:03:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 190C58176A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D26B5C0037;
	Wed, 29 Mar 2023 11:03:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4428FC002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 11:03:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2E0CB61464
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 11:03:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2E0CB61464
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
 header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=vIEbQUp1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QUOfvdZqBWTG
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 11:03:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 19BBB61460
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 19BBB61460
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 11:03:40 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id y4so61599456edo.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 04:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112; t=1680087819;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WhbbiJ4e+b5CD8Cc7IUFUuG1LQyA1ZawH0b3mjKbWjA=;
 b=vIEbQUp1Ae1jSXkVEksl8NuRvjoOt/9zkLTtgCkEpxxDzQegdJ6sRYmpyDQsyOQpk/
 SxZ/6NzDfeTsITBSra50Q1GEllSE/70WyOok7lctCG4OWasrSdqPjCxR2R4IJZ/EKUV8
 HH4vUqBrzllszumb8VEzoIoz6+1HugUuXidHjUGK5oCDd3SCHT26rw7PHUmE/EiAgjqt
 kHzBdQYkxQZZu/lgXTtaY15NCMUNeq3RTf52lxMJsMNNP0X1+gg3te9bdAD4aZ9IPVuU
 5hk55w+RGDCUgzWPejeCLvldTSeb2VZFqME0DTh8AK2FDmutq8rNoL8qXoCTBvPFOFMV
 FDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680087819;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WhbbiJ4e+b5CD8Cc7IUFUuG1LQyA1ZawH0b3mjKbWjA=;
 b=H7UBsMT8EOL5frlc4a89CoP6I4bflJ/P6vHJFS6aYgkBw6SU4NAfS64AmrplZ7gxvW
 +wLcKNdGzTmDjG2J9dIjuG4OAec32c76Y1RRdqtWDHezb9loIwY3xkFTqMEFUnXwz6HD
 Plg8u85kQc2WZ8cHfVnVW5PWIbGo+gY3+qVtBc11xVfysQvxbWpQHsv1qCEOAFaQkPs7
 Hjh8RB8mUweLiXT8UeJGhmbu5S8ofgTRIqIEjXvtvwETqP0bc6tucEpmn+/a05zQ8vwx
 WX5aHxtqRe1orsVBNMJKl/vCiM0CwIBeBst9pzjyOo6wnTZxTMET/jGUV9ZJqRxIQYM7
 mkuQ==
X-Gm-Message-State: AAQBX9cIWxbtrnxYk8m30qCW2qJNtms19Ot2J+Fn4kVNB7rGv69kqj7w
 4HbaoSJwaVg/umSlSZK5/rGslw==
X-Google-Smtp-Source: AKy350ak9VgusBtqHfKGCN3XpdT6OBjA2Hz6hJLq7hk/S/hf34pTotdEBWM714i92+XHxNyq6WYrPw==
X-Received: by 2002:a17:906:9485:b0:933:c052:a277 with SMTP id
 t5-20020a170906948500b00933c052a277mr19912705ejx.12.1680087819244; 
 Wed, 29 Mar 2023 04:03:39 -0700 (PDT)
Received: from localhost.localdomain (178-133-100-41.mobile.vf-ua.net.
 [178.133.100.41]) by smtp.gmail.com with ESMTPSA id
 md12-20020a170906ae8c00b008e68d2c11d8sm16406975ejb.218.2023.03.29.04.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Mar 2023 04:03:38 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yoshfuji@linux-ipv6.org, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 0/4] eBPF RSS through QMP support.
Date: Wed, 29 Mar 2023 13:45:41 +0300
Message-Id: <20230329104546.108016-1-andrew@daynix.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Cc: yan@daynix.com, yuri.benditovich@daynix.com
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

This series of patches provides the ability to retrieve eBPF program
through qmp, so management application may load bpf blob with proper capabilities.
Now, virtio-net devices can accept eBPF programs and maps through properties
as external file descriptors. Access to the eBPF map is direct through mmap()
call, so it should not require additional capabilities to bpf* calls.
eBPF file descriptors can be passed to QEMU from parent process or by unix
socket with sendfd() qmp command.

Overall, the basic scenario of using the helper looks like this:
 * Libvirt checks for ebpf_fds property.
 * Libvirt requests eBPF blob through QMP.
 * Libvirt loads blob for virtio-net.
 * Libvirt launches the QEMU with eBPF fds passed.
 
Andrew Melnychenko (4):
  ebpf: Added eBPF initialization by fds and map update.
  virtio-net: Added property to load eBPF RSS with fds.
  ebpf: Added declaration/initialization routines.
  qmp: Added new command to retrieve eBPF blob.

 ebpf/ebpf.c                    |  48 +++++++++++++
 ebpf/ebpf.h                    |  25 +++++++
 ebpf/ebpf_rss-stub.c           |   6 ++
 ebpf/ebpf_rss.c                | 124 +++++++++++++++++++++++++++------
 ebpf/ebpf_rss.h                |  10 +++
 ebpf/meson.build               |   1 +
 hw/net/virtio-net.c            |  77 ++++++++++++++++++--
 include/hw/virtio/virtio-net.h |   1 +
 monitor/qmp-cmds.c             |  17 +++++
 qapi/misc.json                 |  25 +++++++
 10 files changed, 307 insertions(+), 27 deletions(-)
 create mode 100644 ebpf/ebpf.c
 create mode 100644 ebpf/ebpf.h

-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
