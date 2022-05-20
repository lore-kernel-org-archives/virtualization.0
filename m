Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA7EC433EF
	for <virtualization@archiver.kernel.org>; Fri, 20 May 2022 07:11:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A42B84672;
	Fri, 20 May 2022 07:11:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GzqQqHyg8eh0; Fri, 20 May 2022 07:11:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C801F8431B;
	Fri, 20 May 2022 07:11:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93DE9C0032;
	Fri, 20 May 2022 07:11:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0825EC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 07:11:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E5011409E1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 07:11:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j1miej2k-2u7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 07:11:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 30D8940158
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 07:11:01 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 fw21-20020a17090b129500b001df9f62edd6so5901211pjb.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 00:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=97zq3Qo0/Ny+Q7r8sMLtMXEzhnPp1W1hgAntg+pA9PY=;
 b=uGNZuK2pXyA3XYjj10+l0gMcXEl0/o0lX5su3Epqzrx9iTt/ijBcfFP49nW1hs3dSk
 Gx988oH+cPRR+q+JDUd1PlRAW5NmgcldcCCo4uCD3nDeWeOxCDTgz6MBqIK3WBf39Vbz
 0Iw3WKKCDWtX1ka3hrFGkmzf/P+uR+LRsWZCIPpK5z18FRXbGFG+4dd/Lclj1IdBgivl
 OKTsBtc5iAzKtMfOs3J0pNWTJCKWsUtSthRJUxCZWeU3VR6oJWpED+4A9SVQNsbDSzFT
 3E3cU4UjI9DWk12TMkoHEY5l8ELvcnrLZaugXjs0jpQts5hL0xEtkj/xCx2RUfozj/LA
 UJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=97zq3Qo0/Ny+Q7r8sMLtMXEzhnPp1W1hgAntg+pA9PY=;
 b=iOycxp3mQMnvlTRFLYK0TNNLtHQvYzthgLdFq8y9kt/Vm5QE0snkCljC4zBkd4BRqq
 k4WfKqbLrH+CXp4aXwiwPPYUa2h8et3W3c/+WCXbUS9uHOUsa5WzDxJ7PmVEiqJISYbu
 WTL0rBoMW9MIfe9R4+5jYvcomq2qAobdt0KBRBempmY0u85GSEFnT6ExnaSFyxkfk/H9
 fFudPzN7mQFePtADZIlBj0dy8ccRpvLNnxQiQrkYf1hvF7Y+1n5Rs3NXscO1uHJ2biVC
 0JDd+/lwkw8ajdcUfZwcgeDQRnZX44zQinQmBRuV7XjunesjZlysIL7CZy7qvUzimUO+
 op+w==
X-Gm-Message-State: AOAM532cDt2Xo4G/YXk2al/LAu6StmCJ0TSxNOEGhTvap2Bg9BaZQqdO
 WIS/1HLg9s8MOFM17uH+0IIFOg==
X-Google-Smtp-Source: ABdhPJy+dBTvNY4bONBwGn0CvJdBUJt+Emcg5t0eGDRQEsSgzVaznzXkndYO31HfhwH8jj8MFZY8vg==
X-Received: by 2002:a17:90b:3948:b0:1df:b2c1:dc07 with SMTP id
 oe8-20020a17090b394800b001dfb2c1dc07mr6435774pjb.0.1653030661138; 
 Fri, 20 May 2022 00:11:01 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.255])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a170902d21200b00161b3d5e3e4sm4965168ply.304.2022.05.20.00.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 May 2022 00:11:00 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: akpm@linux-foundation.org, naoya.horiguchi@nec.com, mst@redhat.com,
 david@redhat.com
Subject: [PATCH 0/3] recover hardware corrupted page by virtio balloon
Date: Fri, 20 May 2022 15:06:45 +0800
Message-Id: <20220520070648.1794132-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 zhenwei pi <pizhenwei@bytedance.com>, pbonzini@redhat.com
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

Hi,

I'm trying to recover hardware corrupted page by virtio balloon, the
workflow of this feature like this:

Guest              5.MF -> 6.RVQ FE    10.Unpoison page
                    /           \            /
-------------------+-------------+----------+-----------
                   |             |          |
                4.MCE        7.RVQ BE   9.RVQ Event
 QEMU             /               \       /
             3.SIGBUS              8.Remap
                /
----------------+------------------------------------
                |
            +--2.MF
 Host       /
       1.HW error

1, HardWare page error occurs randomly.
2, host side handles corrupted page by Memory Failure mechanism, sends
   SIGBUS to the user process if early-kill is enabled.
3, QEMU handles SIGBUS, if the address belongs to guest RAM, then:
4, QEMU tries to inject MCE into guest.
5, guest handles memory failure again.

1-5 is already supported for a long time, the next steps are supported
in this patch(also related driver patch):

6, guest balloon driver gets noticed of the corrupted PFN, and sends
   request to host side by Recover VQ FrontEnd.
7, QEMU handles request from Recover VQ BackEnd, then:
8, QEMU remaps the corrupted HVA fo fix the memory failure, then:
9, QEMU acks the guest side the result by Recover VQ.
10, guest unpoisons the page if the corrupted page gets recoverd
    successfully.

Test:
This patch set can be tested with QEMU(also in developing):
https://github.com/pizhenwei/qemu/tree/balloon-recover

Emulate MCE by QEMU(guest RAM normal page only, hugepage is not supported):
virsh qemu-monitor-command vm --hmp mce 0 9 0xbd000000000000c0 0xd 0x61646678 0x8c

The guest works fine(on Intel Platinum 8260):
 mce: [Hardware Error]: Machine check events logged
 Memory failure: 0x61646: recovery action for dirty LRU page: Recovered
 virtio_balloon virtio5: recovered pfn 0x61646
 Unpoison: Unpoisoned page 0x61646 by virtio-balloon
 MCE: Killing stress:24502 due to hardware memory corruption fault at 7f5be2e5a010

And the 'HardwareCorrupted' in /proc/meminfo also shows 0 kB.

About the protocol of virtio balloon recover VQ, it's undefined and in
developing currently:
- 'struct virtio_balloon_recover' defines the structure which is used to
  exchange message between guest and host.
- '__le32 corrupted_pages' in struct virtio_balloon_config is used in the next
  step:
  1, a VM uses RAM of 2M huge page, once a MCE occurs, the 2M becomes
     unaccessible. Reporting 512 * 4K 'corrupted_pages' to the guest, the guest
     has a chance to isolate the 512 pages ahead of time.

  2, after migrating to another host, the corrupted pages are actually recovered,
     once the guest gets the 'corrupted_pages' with 0, then the guest could
     unpoison all the poisoned pages which are recorded in the balloon driver.

zhenwei pi (3):
  memory-failure: Introduce memory failure notifier
  mm/memory-failure.c: support reset PTE during unpoison
  virtio_balloon: Introduce memory recover

 drivers/virtio/virtio_balloon.c     | 243 ++++++++++++++++++++++++++++
 include/linux/mm.h                  |   4 +-
 include/uapi/linux/virtio_balloon.h |  16 ++
 mm/hwpoison-inject.c                |   2 +-
 mm/memory-failure.c                 |  59 ++++++-
 5 files changed, 315 insertions(+), 9 deletions(-)

-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
