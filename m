Return-Path: <SRS0=8N1b=MT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694A7C4320A
	for <virtualization@archiver.kernel.org>; Tue, 27 Jul 2021 13:19:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E349E61A8F
	for <virtualization@archiver.kernel.org>; Tue, 27 Jul 2021 13:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E349E61A8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A4BDE83134;
	Tue, 27 Jul 2021 13:19:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hN0rsDZds0uc; Tue, 27 Jul 2021 13:19:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6142A82CF1;
	Tue, 27 Jul 2021 13:19:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26C05C0010;
	Tue, 27 Jul 2021 13:19:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6618CC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 13:19:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 54E824045F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 13:19:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zcSqalmxHFIB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 13:19:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E73DF40449
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 13:19:17 +0000 (UTC)
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MwQCb-1n0k1m06NR-00sJwL for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 15:19:15 +0200
Received: by mail-wr1-f42.google.com with SMTP id p5so10082340wro.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 06:19:14 -0700 (PDT)
X-Gm-Message-State: AOAM532w/Q9BKtDl2uDSlhTrGrPYrXOvowfAtgvXbDM5UW2lO36KTX2n
 R1N2mhnzw+TS5GmEni/T8aW8XFm+RErPUEH8yA0=
X-Google-Smtp-Source: ABdhPJxSjFEFKBXvzBbAwzE3BP7gX5Ofvzrlecx6hytkypeX0c/MmtPXgXi1JiY9YwFd9jpsqplnmEB57dA6G5o6dNA=
X-Received: by 2002:adf:fd90:: with SMTP id d16mr1019269wrr.105.1627391954517; 
 Tue, 27 Jul 2021 06:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210727131217.15092-1-xianting.tian@linux.alibaba.com>
In-Reply-To: <20210727131217.15092-1-xianting.tian@linux.alibaba.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 27 Jul 2021 15:18:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a15ykABd61Rad5iaZtGN=-+Guk0CNyCMK3XD7TgubG7hg@mail.gmail.com>
Message-ID: <CAK8P3a15ykABd61Rad5iaZtGN=-+Guk0CNyCMK3XD7TgubG7hg@mail.gmail.com>
Subject: Re: [PATCH] virtio-console: avoid DMA from vmalloc area
To: Xianting Tian <xianting.tian@linux.alibaba.com>
X-Provags-ID: V03:K1:D9brX5iX8iCJw09L5/EfPk1ypRwuzf7OIMsWFRvoAvFPVbt9kNJ
 ZZBvRFBrdLzTtygz3l+E1uPv5fVD6IHNnnq1CpZtnHmlwPLnvRskMqac+RA77EeIiwAFEfo
 pIIlzqiGm8FOdhApg7HE0xatQsIugP89NaFKR48SCUCuKkuFjf4EyZRoQsFLuq+ojF0CdZL
 M4+hIoPV/8SJdn/k3Jasw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7vvQHKga4so=:oYOY0eZA6ddkqkAp7LSXBc
 JIf/aDoTGKmDx5arLkvdrAhVztsSW45sULiJNEyiMCmxM55e4PS+zRBirbXKmob307OJxLIN8
 FFWoSvghcOKInHwpDUvL3jF4CCgYZYwUh+kot9bWtBDmTJQLqwtxx7OQUb2U5zKxqE7CPQwOY
 YyE+K45AfRV6Zhm+OyzcELiLLApWwAQ4ToOyrDx/QjY43fkYyn8sAwrJmibhC56jTgFJKUowE
 5UQCtCGUGKbnZqFy+zWnYpPYfzL2j8SPdFsc6s8hO13ZMHfm+fM7OcFB+fMtdxslQjmoKhseQ
 bxtrJr+1Pd+o5htqqjfFr2WKhjcMHhb0KcaHGdmXe0uFx4Xv96xAPWAlW8+ZuMYbt2zmBbDsK
 h+QEAApv/qZedG6YEFDN6dJ+6egY7gLen223BIzA7OAB9G4OzPr1mvqWMvuBwL+BcW/47akyB
 g9AbYrsdCQSY4KPxFAdHPzrhX7HyrdnLYt6kFYKz6i1QkO3ueAycNkri/ZEXz+vP32zVOivBo
 33HSjYCqMH6yuImRRyTE6WPBt2JSJvy90BPEOj2MlCcXmMSgfmNLVneh9GXFl6Kf/7bYhsfBm
 E/1YgMQkq9WqmslOatsqOPIsuSMFhl88dcyzjCcLthvzBgm9OMM8zPbIt4/b1l3vRi/093Pxr
 hw4MiayWA0DHYSTO/2kWy8bjXjdIDZakgPLqUan/osXL9P726gDFk2anmrD/Nyi9D2zVt4hPG
 m/dnyDOZMfgJrJi1HFAdDrxwZILseB3hkwlxWib0OwSNhCE4Jj1QTYZuJObHTtQtNq7d3uQGs
 NWPobf3Miv7eQLjRLsLhkYXZaiAbkLkCKGApATGLUkVenHFtlLRi4rVdom3Rdg0DtyWqBRtu2
 a/ftigxc+YPfknWqnAtSHGSdZ1ylj0YcQhyus2J7X2pthaoxqHHwn0Od8rzZanu27ZmMxMhGY
 TgWndxF9lr1pBWiIIoXj+/nmVaw1amN1fIyZXV7rWwrugXnZ0Q8ld
Cc: Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>,
 gregkh <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>, Omar Sandoval <osandov@fb.com>
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

On Tue, Jul 27, 2021 at 3:13 PM Xianting Tian
<xianting.tian@linux.alibaba.com> wrote:
> @@ -1127,13 +1128,18 @@ static int put_chars(u32 vtermno, const char *buf, int count)
>         if (!port)
>                 return -EPIPE;
>
> -       data = kmemdup(buf, count, GFP_ATOMIC);
> -       if (!data)
> -               return -ENOMEM;
> +       if (is_vmalloc_addr(buf)) {
> +               data = kmemdup(buf, count, GFP_ATOMIC);

What about buffers in .data? If those are in a loadable module, I guess you have
the same problem as with vmalloc() and vmap().

is_vmalloc_or_module_addr() would take care of both, not sure if there are
other examples that don't work. In theory it could be ioremap(), kmap_atomic()
or fixmap as well, but those seem less likely to matter here.

        Arnd
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
