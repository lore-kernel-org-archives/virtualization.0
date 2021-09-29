Return-Path: <SRS0=D/KU=OT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E64C433F5
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 14:36:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B903F61288
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 14:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B903F61288
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7950F4024B;
	Wed, 29 Sep 2021 14:36:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YoRIZDV9K6Yt; Wed, 29 Sep 2021 14:36:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 981DD4024A;
	Wed, 29 Sep 2021 14:36:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4433AC000F;
	Wed, 29 Sep 2021 14:36:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A687C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 14:36:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 47CD383131
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 14:36:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p6noV1IwuQ2F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 14:36:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4B80A83123
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 14:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632926206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=nIk9pQetoscf+b27hympjQHq3MQ54pmAnbOf3Iv9ZjU=;
 b=UYNllIXiXGSXvGQNYPKdLMrrvigJk/vMJQG7+F4p94ydBhuHhRKhqhX/SdczD4SmvAwEqL
 wBy1oxtca0xipaHWx90zXvHknbyuZ+en2pThGKQ4Nv4M+pCVTj/YTdj9tJ8zKLaorjUKM+
 JpVV1Rw6I8GzbR95GyHu01bEs+puKFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-HiDlfpr9McK8TyeFjAqzig-1; Wed, 29 Sep 2021 10:36:43 -0400
X-MC-Unique: HiDlfpr9McK8TyeFjAqzig-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 281DB1006AA4;
 Wed, 29 Sep 2021 14:36:40 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.195.135])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B51FA10016F4;
 Wed, 29 Sep 2021 14:36:01 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/6] mm/memory_hotplug: Kconfig and 32 bit cleanups
Date: Wed, 29 Sep 2021 16:35:54 +0200
Message-Id: <20210929143600.49379-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Michal Hocko <mhocko@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, linux-kselftest@vger.kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
 Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Oscar Salvador <osalvador@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Mike Rapoport <rppt@kernel.org>
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

Some cleanups around CONFIG_MEMORY_HOTPLUG, including removing 32 bit
leftovers of memory hotplug support.

Compile-tested on various architectures, quickly tested memory hotplug
on x86-64.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Alex Shi <alexs@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: x86@kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: virtualization@lists.linux-foundation.org

David Hildenbrand (6):
  mm/memory_hotplug: remove CONFIG_X86_64_ACPI_NUMA dependency from
    CONFIG_MEMORY_HOTPLUG
  mm/memory_hotplug: remove CONFIG_MEMORY_HOTPLUG_SPARSE
  mm/memory_hotplug: restrict CONFIG_MEMORY_HOTPLUG to 64 bit
  mm/memory_hotplug: remove HIGHMEM leftovers
  mm/memory_hotplug: remove stale function declarations
  x86: remove memory hotplug support on X86_32

 Documentation/core-api/memory-hotplug.rst     |  3 --
 .../zh_CN/core-api/memory-hotplug.rst         |  4 --
 arch/powerpc/include/asm/machdep.h            |  2 +-
 arch/powerpc/kernel/setup_64.c                |  2 +-
 arch/powerpc/platforms/powernv/setup.c        |  4 +-
 arch/powerpc/platforms/pseries/setup.c        |  2 +-
 arch/x86/Kconfig                              |  6 +--
 arch/x86/mm/init_32.c                         | 31 ---------------
 drivers/base/Makefile                         |  2 +-
 drivers/base/node.c                           |  9 ++---
 drivers/virtio/Kconfig                        |  2 +-
 include/linux/memory.h                        | 19 ++++------
 include/linux/memory_hotplug.h                |  3 --
 include/linux/node.h                          |  4 +-
 lib/Kconfig.debug                             |  2 +-
 mm/Kconfig                                    |  8 +---
 mm/memory_hotplug.c                           | 38 +------------------
 tools/testing/selftests/memory-hotplug/config |  1 -
 18 files changed, 28 insertions(+), 114 deletions(-)


base-commit: 5816b3e6577eaa676ceb00a848f0fd65fe2adc29
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
