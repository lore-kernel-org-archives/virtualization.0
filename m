Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4610C4167B
	for <virtualization@archiver.kernel.org>; Mon, 12 Dec 2022 16:30:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2D4E34074E;
	Mon, 12 Dec 2022 16:30:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2D4E34074E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=OaaojC/s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g3ECvQyPHkkO; Mon, 12 Dec 2022 16:30:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A483B40101;
	Mon, 12 Dec 2022 16:30:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A483B40101
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B87CC0032;
	Mon, 12 Dec 2022 16:30:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3FE9C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 16:30:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BFE4040256
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 16:30:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BFE4040256
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5Qbo0ZJe5VCS
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 16:30:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EDBD240101
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EDBD240101
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 16:30:18 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id c7so214632pfc.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 08:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OUILWEspXMe7ooUig3KmknX9KoRcehzQ+nw7PUyJ1kU=;
 b=OaaojC/sMyai941Icb8QrOqMENAWi28ghc9hDsed00zjgjisK6qVEZu2vOMG8n6FBF
 mRTAFH6tUYD1vvdF+OQzbqW4ejDlJmdO83c0sjR8B6XLmzvRlBgKt6VPAt6yOfgNXXyS
 N5hpWodqaEejfLPFa5uI/+RgmUe+2L5KuDbTZUzGpS0Yy71Zsw9asM92nPSSAqgzID8V
 TZbBBSJDtvX+M6y77IBx8HxMvYUg0YvxvqtzfiXR379RHxM6LHGWjUpvhiicE9ZSZ9m8
 NJUY3oS5uH+mKQyJu3VMfKT0w/YVtgxjW31JMhCJYUkUnNwWQRbj6amimPqgaYKW5WtQ
 qWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OUILWEspXMe7ooUig3KmknX9KoRcehzQ+nw7PUyJ1kU=;
 b=SCqa2D9Wtt9N+v1/E09CprEhfq6R5L64LjkLJl9wPFbu5BRQ7mT0EdtQ0yeNE0jccC
 6GSpS0XHm2cME0s3M+6xlOMMOe60X9ubF0zyhHHfQQxnHlS0kWs+uVc9RwGoKhcck30L
 Sz10dJQ4tC6yIAVLmFp7gzxjYnE0N4Dgs3zE3cAbFCvMaFCScicekkShn5HUknifG4Xq
 ySjOPOb73VZsJlx/ewBDfmzN0tkpTdo37j3k0HuZyL4a6lTJoYNEehx7gYp/lkZam/FT
 lt0tD9bdyD46xEelKWv/InK6B2phFb4hnSYfjJzWocsYcIXqT2++6O9Dgyftx8qYkNOC
 O4Iw==
X-Gm-Message-State: ANoB5pnG4jcnb1hKclQYhGtUi+26S/48bZo/Pox0izl/IBT463ri8OfD
 vQJjbtaCn6K2tT0V0AVP7VQmok0JBH8PCqnyj8vprA==
X-Google-Smtp-Source: AA0mqf7JA3HhSeTurk8iZookol7LHDnbT/F4m7xHYAYV/UuB9gMGq1bbOo6jpRGSGdf/yNJmDF2yJW3rA7g/Yj6tJB4=
X-Received: by 2002:a05:6a00:10cd:b0:572:5c03:f7ad with SMTP id
 d13-20020a056a0010cd00b005725c03f7admr98862692pfu.17.1670862618084; Mon, 12
 Dec 2022 08:30:18 -0800 (PST)
MIME-Version: 1.0
References: <20221212142454.3225177-1-alvaro.karsz@solid-run.com>
 <20221212142454.3225177-4-alvaro.karsz@solid-run.com>
 <848cc714-b152-8cec-ce03-9b606f268aef@roeck-us.net>
In-Reply-To: <848cc714-b152-8cec-ce03-9b606f268aef@roeck-us.net>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Mon, 12 Dec 2022 18:29:41 +0200
Message-ID: <CAJs=3_AdgWS23-t6dELgSfz7DS4U0eXuXP_UZ3Fn21VCEwA-4w@mail.gmail.com>
Subject: Re: [PATCH 3/3 v4] virtio: vdpa: new SolidNET DPU driver.
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-pci@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

Hi Guenter,
Thanks for your comments.

> This is wrong. It should be possible to build the driver without it, and
> without forcing everyone to enable hwmon just to get support for this device -
> even more so since hwmon support is explicitly marked as optional below.
> Why force people to compile it if it is not mandatory ?
>
>
> Yes, I know, "select HWMON" is done elsewhere as well, but it is just as wrong
> there. No one should be forced to enable HWMON support just to get, say, support
> for the IDT PCIe-switch Non-Transparent Bridge.


You have a good point.
I will remove it from the Kconfig file, and I will add:
#if IS_REACHABLE(CONFIG_HWMON)
in relevant places

Something like:

solidrun/Makefile:
obj-$(CONFIG_SNET_VDPA) += snet_vdpa.o
snet_vdpa-$(CONFIG_SNET_VDPA) += snet_main.o
#if IS_REACHABLE(CONFIG_HWMON)
snet_vdpa-$(CONFIG_SNET_VDPA) += snet_hwmon.o
#endif

solidrun/snet_main.c, snet_vdpa_probe_pf function:

if (PSNET_FLAG_ON(psnet, SNET_CFG_FLAG_HWMON)) {
#if IS_REACHABLE(CONFIG_HWMON)
        psnet_create_hwmon(pdev);
#else
        SNET_ERR(pdev, "Can't start HWMON, CONFIG_HWMON is not reachable\n");
#endif
}

solidrun/snet_vdpa.h, snet_vdpa_probe_pf function:
#if IS_REACHABLE(CONFIG_HWMON)
void psnet_create_hwmon(struct pci_dev *pdev);
#endif

What do you think?

> I do not see why the second include would be needed.

You're right, I'll remove it.

>
> Tpecast seems unnecessary.

I'll remove it.

> Kind of obvious.

Ok, I'll remove the comment.

> Badly misleading indent. No idea why checkpatch doesn't report it.
>
>
> That makes me wonder: Did you not run checkpatch --strict, or did you choose
> to ignore what it reports ?

I did run checkpatch (without --strict).
I tried now with --strict. and I'm not getting any indent
errors/warnings, this is strange..
I will fix it.

> FWIW, a _hwmon ending in a hwmon driver device name is redundant.
> What else would it be ? Why not just use pci_name() ?

I'll change it to "snet_%s", pci_name(pdev)

> devm_hwmon_device_register_with_info() returns an ERR_PTR on error,
> not NULL.

Ok, I'll fix it.

> I hope you know what you are doing here. This may result in people wondering
> why hwmon support doesn't work if they expect it to work. No one looks
> into the kernel log. Besides, ignoring the error doesn't really help
> much because that error return means that something serious is wrong.

You have a point, but the hwmon is not the "main" functionality of
this device, so I don't want to fail the entire device because of a
"side" functionality.
Now that the SNET vdpa driver doesn't select CONFIG_HWMON, we may have
a situation when the SNET_CFG_FLAG_HWMON flag is set, but the kernel
is compiled without CONFIG_HWMON.
I don't think that I should fail probe in this case.

> Wow, a 5-second hot loop. Not my responsibility to accept or reject this
> part of the code, but personally I think this is completely unaccceptable.

The SNET DPU may require some time to become ready.
If the driver is compiled as a module, this is not a problem, but if
the driver is builtin in the kernel, we may need to wait a little for
the DPU.
But you're right, 5 secs is indeed a big number, I'll change it to 2 secs.

> Memory allocation failures are not commonly logged since the low level code
> already does that.

Right, I'll remove the error log.

Alvaro
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
