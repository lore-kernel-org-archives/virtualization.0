Return-Path: <SRS0=XE2Y=MP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_RED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318FCC4338F
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 09:04:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD99F60EC0
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 09:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DD99F60EC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A6740401C4;
	Fri, 23 Jul 2021 09:04:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8TmxGcXYvIOp; Fri, 23 Jul 2021 09:04:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 49350401BF;
	Fri, 23 Jul 2021 09:04:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29722C001A;
	Fri, 23 Jul 2021 09:04:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BFF1C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 09:03:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 772086064D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 09:03:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y6yqnfL53z_m
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 09:03:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5DA2D6063A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 09:03:57 +0000 (UTC)
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MaHOX-1ldXxf1wyD-00WCEN for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 11:03:54 +0200
Received: by mail-wr1-f48.google.com with SMTP id r2so1586540wrl.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 02:03:53 -0700 (PDT)
X-Gm-Message-State: AOAM530zTkDUISDdjVa2IKbj9wjpcD1OOGwmUmss38HRi47qe01peOs4
 TcKWz+PZDLeN2mGMtvtvGGIBeL+hE3pG/uRqa6I=
X-Google-Smtp-Source: ABdhPJy3ItUq0sRuqlziECSTpnqgqAEwiUMYe9CtHrcLjroCnJUUgu4nyS6Li21tNISMIRuRGBH3im1Ow2SeuHqPtvs=
X-Received: by 2002:adf:e107:: with SMTP id t7mr4168842wrz.165.1627031033699; 
 Fri, 23 Jul 2021 02:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <bcf2fb9bbe965862213f27e05f87ffc91283c0c5.1627018061.git.jie.deng@intel.com>
In-Reply-To: <bcf2fb9bbe965862213f27e05f87ffc91283c0c5.1627018061.git.jie.deng@intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 23 Jul 2021 11:03:37 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1=TpKLGMzvoLafjxtmoBbDL+sBMb8ZiEmTjW91Yr-cYw@mail.gmail.com>
Message-ID: <CAK8P3a1=TpKLGMzvoLafjxtmoBbDL+sBMb8ZiEmTjW91Yr-cYw@mail.gmail.com>
Subject: Re: [PATCH v15] i2c: virtio: add a virtio i2c frontend driver
To: Jie Deng <jie.deng@intel.com>
X-Provags-ID: V03:K1:GO9/RWNtOF1Jp7aWFWRWEe9aXF1YxYl+wB6JhMw95mTeHfB+ACr
 HiAZkVSRJoCBU6MCX7rwBvhFaJ5eKwWdIqmjMB+NSxFJqw2GEedjSkeh+7irYu1TRxzjssX
 fPh2HZWRv9XLZigntGMm52iixbkPgP7U3BU3vxowsAgxK5CQhsUIsFFAknl6rlhbFb4Am1n
 BnJ0l/Un8KZEZTaAfS1hQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PjkuYOwM9D4=:DB+HUAZP9x6o0zVArvr5ze
 fq9RNiT/p8XK6bqurpAahmCQOI83wvJhn8jfL4cgjBYrVHVJWK1lnmjiQCc7VKTOqiW05Iiu2
 BXVDQoByIiaLkItTLdLVKlVpn04TIx4CPB/0BO/9ov/5x7oxM9mokQJGpRW0saMBXxZl63wlS
 Y3eq8XBBxPihJ/pRKV2QpoCPIvyPw+st8x3yl2XPQttxjnbDBaGfPjcopbyqNFIKCXSXIlrk+
 jYEtN8aLVdthe20E/Jzgn9iSvP0rzZiZxqz8r6Da23MrnkbRPQRe+ZsEoJcaG7cAY9TNZ+GBP
 XlVOPCPPd6WgeeiPEATpezEuZmsKYfG6R/OH40pL4H/AYO+E99d8e16RrE+goXem5UqFQ0ANb
 re8k0iI9HA28SvzOMt8s6jEMWBq+WTqxXt5TTKHiUqO0XT73qFqqdfQIeV6F7miqLzMeM+M7g
 6+lDRpxJbHDJSsZnNtvWlJsLLePZMu/QxQ8ywRq0S9HK5J31SR0hKu33TQCbcIbHvEHKiUHoM
 ukifnjlz3W60F47a0XSvPOr689jjU7z/d7JotoeFvETs9tP8NdxG3KH7ixGBE/QSSdijz0j9O
 4wHisaKGl7tBQ+vc1ecbqKFFcVGNpJ36h9ATKmAEFvN6I6KpHoLpJ/c+E2rocIbFPbY0uEWgr
 y/dY9YwQRPhO4bknD9dPFi6F+AdWfzLKS/+JScMMTWfNVwoVZ88gLTWjGhnJrSUIUQz104oKP
 YwJhIxKc9+HTUEbdqmzajLIAcTvIV4e7k1wbZ0g6AbGwNIDD11ecEMreoI9zJxCnI6XYGG6Wl
 k0meYGUYCzR1WG7vEG172O+Qz/vhYb+/as30L+T0c0wrS4x9lnk5ljc4AmqVJakN16kKizpLW
 MWANwnv0D5ITewJh26Mia+w8wXmLY11RJ1Kw4lGO2487UvH3MI9JI1QU0gPPxv+e3NYHuF5LK
 2KVFaoWVmFp6IfSmLa4dHVit1TPkLLU7W9ImiPDS83YdoXTtu9SjG
Cc: Vincent Guittot <vincent.guittot@linaro.org>, yu1.wang@intel.com,
 Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, jiedeng@alumni.sjtu.edu.cn,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>, Wolfram Sang <wsa@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Linux I2C <linux-i2c@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 gregkh <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, conghui.chen@intel.com
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

On Fri, Jul 23, 2021 at 7:44 AM Jie Deng <jie.deng@intel.com> wrote:

> +
> +       ret = virtio_i2c_setup_vqs(vi);
> +       if (ret)
> +               return ret;
> +
> +       vi->adap.owner = THIS_MODULE;
> +       snprintf(vi->adap.name, sizeof(vi->adap.name),
> +                "i2c_virtio at virtio bus %d", vdev->index);
> +       vi->adap.algo = &virtio_algorithm;
> +       vi->adap.quirks = &virtio_i2c_quirks;
> +       vi->adap.dev.parent = &vdev->dev;
> +       i2c_set_adapdata(&vi->adap, vi);
> +
> +       /*
> +        * Setup ACPI node for controlled devices which will be probed through
> +        * ACPI.
> +        */
> +       ACPI_COMPANION_SET(&vi->adap.dev, ACPI_COMPANION(pdev));

Since there is now a generic way for virtio drivers to link up with OF
device nodes, maybe this should be handled the same way in the
virtio core rather than the driver?

> index 70a8057a..99aa27b 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -55,6 +55,7 @@
>  #define VIRTIO_ID_FS                   26 /* virtio filesystem */
>  #define VIRTIO_ID_PMEM                 27 /* virtio pmem */
>  #define VIRTIO_ID_MAC80211_HWSIM       29 /* virtio mac80211-hwsim */
> +#define VIRTIO_ID_I2C_ADAPTER          34 /* virtio i2c adapter */
>  #define VIRTIO_ID_BT                   40 /* virtio bluetooth */

This will now conflict with Viresh's patch that adds all the other IDs.
Not sure if there is anything to be done about that.

       Arnd
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
