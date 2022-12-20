Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1A4C4332F
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 07:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B5A0403A7;
	Tue, 20 Dec 2022 07:26:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0B5A0403A7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=V/ydCelJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JVICCn9-d3XT; Tue, 20 Dec 2022 07:26:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2EFCF4035D;
	Tue, 20 Dec 2022 07:26:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2EFCF4035D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5003C0032;
	Tue, 20 Dec 2022 07:26:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7A65C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 07:26:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BA2F1607F4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 07:26:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BA2F1607F4
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=V/ydCelJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wn1-3KriZktS
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 07:26:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D8AC16072A
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D8AC16072A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 07:26:17 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id n3so7908227pfq.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 23:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Oyr16lkkO+f52LJilby/v2FdwozTbFlzoHJ/tqUoOH0=;
 b=V/ydCelJ/1e4NaKd/oZmpUIGZ5NWJzikt1y9DeK3EnIBX7Tpsl2sBZmrsrNIoX4u0T
 WNu1OcpcjMCKuaEWsc9xlaQdAE1+8wmsGroVRqS/ZTbCzTypU9ZP3cs6KgF9QLpKqIz/
 yTRbb/yoteeZv7Bx/U4cVyZkNW9nlfUtkEQBp6ribd5iPly0/dnzdRiOtn6Eyy8ErE0O
 aWVkP73RN+hAEWlGGAteu86kxtOq4cRk5dggcFn23gtLeOjU3V0+73bBGfcUGscDRk66
 q92b4LhF0yrdQNy822RyEEXY916C9PBjAbTiDtdFhXyA1jtM1x2c7d0ULeMGiqdG+FaT
 Jjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oyr16lkkO+f52LJilby/v2FdwozTbFlzoHJ/tqUoOH0=;
 b=P2f17PEWwdUtLYmVXckhgDPkLbqHP7mVCFOY7gTN6fCLvjXqiZF83Mx768qc/rY08D
 N5Lg3Idqh8ug+/L6wdcTb5yOS3n2iZkR/xvCXYaImkhwlrrZ+aXJhJKhjbG4ODyKmQJi
 v7p24A7iaMJmqtwQwJjKV/WwREHwoIwuKLP9DaRFyWgLGjQ0xAnMhXffV+xJT+Rai3mT
 /EZQ17uLu38BLFSX2ts9xkHvSXQ55PpISsGhM/EnTlv4dvKgr3XThpegKxAgItu/2uAM
 VexQ+9r8oWs7CSNVXguwPA4bVFmed8PyqSzRAZMbyEzfUv/7QgSw6uwncrJg0wI30OuW
 yWMw==
X-Gm-Message-State: AFqh2krmtuj2KQmvnCPnc3yg1iEU1LoBG8gMGD1G7gFl9tlgZNboJ7pK
 HwH67Llp1MOK7+eo/Stt9GxklPMl2QJ7EBptVWMthQ==
X-Google-Smtp-Source: AMrXdXvgorYeaCukKa+Ic1F+7aqNFQsn9V+GDrAfXDBuRuhaW9TbfEfOw8D+OyfPUBv+NJHe/nuip5DKTGbcS11svBA=
X-Received: by 2002:a63:ee44:0:b0:489:17a2:a53d with SMTP id
 n4-20020a63ee44000000b0048917a2a53dmr499886pgk.255.1671521177155; Mon, 19 Dec
 2022 23:26:17 -0800 (PST)
MIME-Version: 1.0
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com>
 <96d85666-106b-a43e-6115-b9959b4e3e66@redhat.com>
In-Reply-To: <96d85666-106b-a43e-6115-b9959b4e3e66@redhat.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Tue, 20 Dec 2022 09:25:40 +0200
Message-ID: <CAJs=3_DkqB=6MXfUd02j6kKXahS6AWLRes5NUjj9Wp9iRecewg@mail.gmail.com>
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
To: Jason Wang <jasowang@redhat.com>
Cc: Jean Delvare <jdelvare@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-pci@vger.kernel.org, virtualization@lists.linux-foundation.org,
 bhelgaas@google.com, Guenter Roeck <linux@roeck-us.net>
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

Hi Jason,

> So I think we actually don't need to depend on HWMON here?
>
> hwmon.c is only complied when HWMON is enabled and we use IS_ENABLED to
> exclude the hwmon specific does.

We are not really depending on HWMON with "(HWMON || HWMON=n)"
If HWMON=n, the driver can be compiled either as a module or built-in.
If HWMON=y, the driver can be compiled either as a module or built-in.
If HWMON=m, the driver will be forced to be compiled as a module.

This technique allows us to use IS_ENABLED instead of IS_REACHABLE
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
