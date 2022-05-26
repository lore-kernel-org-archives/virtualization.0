Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C7CC433F5
	for <virtualization@archiver.kernel.org>; Thu, 26 May 2022 08:32:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8ABA661400;
	Thu, 26 May 2022 08:32:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6-_JwINFhoK3; Thu, 26 May 2022 08:32:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3610160E76;
	Thu, 26 May 2022 08:32:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 142FAC0039;
	Thu, 26 May 2022 08:32:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E691FC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 08:32:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C9ED8613EF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 08:32:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dGxwyBMkUrXm
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 08:32:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B1A4B60E76
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 08:32:44 +0000 (UTC)
Received: from mail-yw1-f180.google.com ([209.85.128.180]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MBDWo-1nz3GG2WmU-00Cl2K for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 10:32:42 +0200
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-2ff53d86abbso7891947b3.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 May 2022 01:32:42 -0700 (PDT)
X-Gm-Message-State: AOAM533F76hvbb+a1PvjxusO/h9Ffvjj9taZN4q1KADXYJHp0W7WOeC4
 MNuLpAbilL89ZXOPDZCu00N35441rPJ8CFG0fpM=
X-Google-Smtp-Source: ABdhPJzd1Td84PUKl1aMompoBi/CI7Ij8UKcDh3J33F17cieCWlpkBhuvBB90C07npKSjm4gZ1dqj3OUo1L9/csGNzA=
X-Received: by 2002:a81:488c:0:b0:302:549f:ffbc with SMTP id
 v134-20020a81488c000000b00302549fffbcmr1085051ywa.495.1653553961173; Thu, 26
 May 2022 01:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <628ea118.wJYf60YnZco0hs9o%lkp@intel.com>
In-Reply-To: <628ea118.wJYf60YnZco0hs9o%lkp@intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 26 May 2022 10:32:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a10aGYNr=nKZVzv+1n_DRibSCCkoCLuTDtmhZskBMWfyw@mail.gmail.com>
Message-ID: <CAK8P3a10aGYNr=nKZVzv+1n_DRibSCCkoCLuTDtmhZskBMWfyw@mail.gmail.com>
Subject: Re: [linux-next:master] BUILD REGRESSION
 8cb8311e95e3bb58bd84d6350365f14a718faa6d
To: kernel test robot <lkp@intel.com>
X-Provags-ID: V03:K1:whWImlCSxHOte50npIcDmB3JZGbQrUIkAsHSboGq5vKyu34G/NK
 vGphZojBoy64RymTU9ExvKllnTV5X12Du5UokCkRGY1Ddq6QK7lUV3rBcQrkLNV20ddnbRU
 aPYLRdIoD0DSbRTYzWmpKSA5+F9nK4CN0i4aWf/ozuDSte+Ca0QykkjOZl3ym+vKOnkrryD
 gvR5iz4CnORLSzAmNrIZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:42a3DgFifxQ=:bCjyskURT5uq703DMYlAsx
 +bPRsNpdMcbZHMbv+7OlTLEqypqkkGxvo6jNdtWcT2JmPSJzOmdvo/VqRttUf2zuU5z4UVjca
 b8Vnt7rONKsiWbYTlXXEtqEePEIZqit5gjPqQVaT2V+bYcGUP3QjkQJTtviI45aFEIuj+DnoQ
 PtXvxdtBY/SCtkGDPZGOSy8fmsnPVsr55PZmyvzS1QDvAWBQZgsmuvfeCuaX98KNJ1lRxaPoq
 YTHa9B8yUkijCfn+bTitIanROHgSZ7KtBdB/Ko9CxWAzuL08lQjgvCPwsmfTCAou6OkQbazki
 PZGNxsVl41orCAcCu/cVA8LtpdCNswxCVU429OSk2Zb2bVS/v29xZBQb4w6zFoo/61qObJSeY
 xaKEBA/lifCIlzojszGyisLOkTLa1zapFTrs69PRvG1EebmtzXZ9THrQKSZHpTBD7tYaxnkaU
 4H8buUO6La4b3jX2fYCjvRfyUCGFiZz942Oq0bl2gYmapsay9EDHnJ/vHQdHPcpswKNIWDe59
 irSOeSy5AQnBEyngusDgs9LezX2kN8umvyEbb3BM5sbKYHpdZzDXfah4vcZjdtEn3XMGX6rq8
 Iy1ojSLQD96Y+ks35h3n5fVXI8VgakiJ0iB+THKf/HgpnU5gcqXNcdi1Elc6xpJtmbvzm40Nm
 JVLiC00T5gsVf/eWVH9fx5xC2kyLqinTFjWpJ5VqeXu0QY06IkasvHRooA1EwBJVg2nS/HlD8
 o2VDadj/Ny7MjoFsUik/j0fNMLGbWhAK8VxQO0PdvTk+SrcbTcAeG6+EV71+5ic9J6pPWeYXF
 lZSjkk06w4yJhn/QxBneuZ1iR5MzNoY879EOiHr0WUVk3LW9B0esz3bWRjMxd6PvG9QncjxkT
 R6z5tbg0XIltJ/7bUkKQ==
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 linux-parport@lists.infradead.org, kvm list <kvm@vger.kernel.org>,
 linux-rdma <linux-rdma@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
 linux-staging@lists.linux.dev, bpf <bpf@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 linux-pci <linux-pci@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-omap <linux-omap@vger.kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Wed, May 25, 2022 at 11:35 PM kernel test robot <lkp@intel.com> wrote:
> .__mulsi3.o.cmd: No such file or directory
> Makefile:686: arch/h8300/Makefile: No such file or directory
> Makefile:765: arch/h8300/Makefile: No such file or directory
> arch/Kconfig:10: can't open file "arch/h8300/Kconfig"

Please stop building h8300  after the asm-generic tree is merged, the
architecture is getting removed.

        Arnd
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
