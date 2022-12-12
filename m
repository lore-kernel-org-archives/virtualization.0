Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C18C4332F
	for <virtualization@archiver.kernel.org>; Mon, 12 Dec 2022 17:01:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A75340942;
	Mon, 12 Dec 2022 17:01:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0A75340942
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=apShNOqu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4ULmQccV22qH; Mon, 12 Dec 2022 17:01:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 09B5040874;
	Mon, 12 Dec 2022 17:01:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 09B5040874
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0711C0032;
	Mon, 12 Dec 2022 17:01:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34D18C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 17:01:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 158D960B20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 17:01:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 158D960B20
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=apShNOqu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JK-h4qzk1mpJ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 17:01:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A473A607F4
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A473A607F4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 17:01:07 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1445ca00781so9139962fac.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 09:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6OFNwOVEvjonocdKLd3uOtuOYuKpHMlsyaaoacS/Uy4=;
 b=apShNOquL44hqhSrtfmjvxs/zc/3PtIpb0UBcsyiwgDuLze7oIdZfJS0S5BjnkT+k/
 Q8AWG4z8sNQ4GVoHLe8RQgvOTN3Xp1REy7C1+WcRVAF2gg3ofJamKBAMx+lZvsMEUSKi
 XGLnlU9Hx9PuZV3U73HTMjxlou2GYDcIyLect2NXIsIA4m1GFHZ44ON25vGCdPd0PxYy
 tvN4a472lIBxXOmyXH9LrVoENRp1P/4C250zHggEbWwLS5bNdCwMGrRWXh3Fehj9Iokg
 z+Hw4hQ6DTaR1N2O9HnSlGjUvK+tUK0KxivY5bId+OJsfrnDDR5eg5WI5voYUH0bLxxT
 VXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6OFNwOVEvjonocdKLd3uOtuOYuKpHMlsyaaoacS/Uy4=;
 b=7IVvFDBq/0AiJDKBeV2muxTGlf/CRy2pjOboCW70gQvoApSSXv4VchyqD1Kots1iMK
 x55/nIqnQ+DGylSnDVe4l7L3q3DJq+UOQRsEP2R0PJdi709clSYU+X+TLlPYJSKdg4U8
 846I12ZkB8gMrs4wecpa56qvP4+0i2bmQwq5H+abNufBQoE6YxBLzdrWxw0tAXfvQCi4
 2lQXZmgrbyZjtEbSBCnKA1u4JWsmNYWthrxOKQOBhHGlxCF+FRVpHXiSaVLYp3cGoRbQ
 o4O3W+rCh6+jwjXU7tkQsZ/Zh/JRKoPGxupzrjhHv3CzPszYt7RUrH6CzVF9KWb3Q8id
 tNWQ==
X-Gm-Message-State: ANoB5pkGj5KlaqJKYQLlVMfd/MOS7ueS7GVw0uV09PJOVJVpFqRsNAlR
 4hbZENdZH39wD0kbVHah/+U=
X-Google-Smtp-Source: AA0mqf5wgeRby5TRoMTROPnVRYMnMGQTVB0jbLCSJLjmWKTmZs4usj1YMJbnQB8jwCpIc3XikW+YDg==
X-Received: by 2002:a05:6870:3118:b0:13c:2b53:a0e8 with SMTP id
 v24-20020a056870311800b0013c2b53a0e8mr8543160oaa.54.1670864465841; 
 Mon, 12 Dec 2022 09:01:05 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 f43-20020a056871072b00b00144bb1013e6sm165969oap.4.2022.12.12.09.01.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Dec 2022 09:01:05 -0800 (PST)
Message-ID: <3f83e874-3d7c-cc97-2207-a47dbcfe960f@roeck-us.net>
Date: Mon, 12 Dec 2022 09:01:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
References: <20221212142454.3225177-1-alvaro.karsz@solid-run.com>
 <20221212142454.3225177-4-alvaro.karsz@solid-run.com>
 <848cc714-b152-8cec-ce03-9b606f268aef@roeck-us.net>
 <CAJs=3_AdgWS23-t6dELgSfz7DS4U0eXuXP_UZ3Fn21VCEwA-4w@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 3/3 v4] virtio: vdpa: new SolidNET DPU driver.
In-Reply-To: <CAJs=3_AdgWS23-t6dELgSfz7DS4U0eXuXP_UZ3Fn21VCEwA-4w@mail.gmail.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 12/12/22 08:29, Alvaro Karsz wrote:
> Hi Guenter,
> Thanks for your comments.
> 
>> This is wrong. It should be possible to build the driver without it, and
>> without forcing everyone to enable hwmon just to get support for this device -
>> even more so since hwmon support is explicitly marked as optional below.
>> Why force people to compile it if it is not mandatory ?
>>
>>
>> Yes, I know, "select HWMON" is done elsewhere as well, but it is just as wrong
>> there. No one should be forced to enable HWMON support just to get, say, support
>> for the IDT PCIe-switch Non-Transparent Bridge.
> 
> 
> You have a good point.
> I will remove it from the Kconfig file, and I will add:
> #if IS_REACHABLE(CONFIG_HWMON)
> in relevant places
> 
> Something like:
> 
> solidrun/Makefile:
> obj-$(CONFIG_SNET_VDPA) += snet_vdpa.o
> snet_vdpa-$(CONFIG_SNET_VDPA) += snet_main.o
> #if IS_REACHABLE(CONFIG_HWMON)

I don't think that works in Makefiles. It would have to be ifdef.

> snet_vdpa-$(CONFIG_SNET_VDPA) += snet_hwmon.o
> #endif
> 

Even better would be a separate CONFIG_SNET_VDPA_HWMON Kconfig option.

> solidrun/snet_main.c, snet_vdpa_probe_pf function:
> 
> if (PSNET_FLAG_ON(psnet, SNET_CFG_FLAG_HWMON)) {
> #if IS_REACHABLE(CONFIG_HWMON)
>          psnet_create_hwmon(pdev);
> #else
>          SNET_ERR(pdev, "Can't start HWMON, CONFIG_HWMON is not reachable\n");
> #endif

Per your own statement, that is not an error, and thus should not be logged
as one.

> }
> 
> solidrun/snet_vdpa.h, snet_vdpa_probe_pf function:
> #if IS_REACHABLE(CONFIG_HWMON)
> void psnet_create_hwmon(struct pci_dev *pdev);
> #endif
> 
> What do you think?
> 

It would be much better to add a shim function in the include file.

There should be a dependency

	depends on HWMON || HWMON=n

in Kconfig, and the shim function would then be

#if IS_REACHABLE(CONFIG_HWMON)
void psnet_create_hwmon(struct pci_dev *pdev);
#else
void psnet_create_hwmon(struct pci_dev *pdev) {}
#endif

>> I do not see why the second include would be needed.
> 
> You're right, I'll remove it.
> 
>>
>> Tpecast seems unnecessary.
> 
> I'll remove it.
> 
>> Kind of obvious.
> 
> Ok, I'll remove the comment.
> 
>> Badly misleading indent. No idea why checkpatch doesn't report it.
>>
>>
>> That makes me wonder: Did you not run checkpatch --strict, or did you choose
>> to ignore what it reports ?
> 
> I did run checkpatch (without --strict).
> I tried now with --strict. and I'm not getting any indent
> errors/warnings, this is strange..
> I will fix it.
> 

I referred to the other problems it reports, such as using macro arguments
without ().

>> FWIW, a _hwmon ending in a hwmon driver device name is redundant.
>> What else would it be ? Why not just use pci_name() ?
> 
> I'll change it to "snet_%s", pci_name(pdev)
> 
>> devm_hwmon_device_register_with_info() returns an ERR_PTR on error,
>> not NULL.
> 
> Ok, I'll fix it.
> 
>> I hope you know what you are doing here. This may result in people wondering
>> why hwmon support doesn't work if they expect it to work. No one looks
>> into the kernel log. Besides, ignoring the error doesn't really help
>> much because that error return means that something serious is wrong.
> 
> You have a point, but the hwmon is not the "main" functionality of
> this device, so I don't want to fail the entire device because of a
> "side" functionality.
> Now that the SNET vdpa driver doesn't select CONFIG_HWMON, we may have
> a situation when the SNET_CFG_FLAG_HWMON flag is set, but the kernel
> is compiled without CONFIG_HWMON.
> I don't think that I should fail probe in this case.
> 
>> Wow, a 5-second hot loop. Not my responsibility to accept or reject this
>> part of the code, but personally I think this is completely unaccceptable.
> 
> The SNET DPU may require some time to become ready.
> If the driver is compiled as a module, this is not a problem, but if
> the driver is builtin in the kernel, we may need to wait a little for
> the DPU.
> But you're right, 5 secs is indeed a big number, I'll change it to 2 secs.
> 

That isn't the point. A 2-second hot loop is just as bad.
There should be a usleep_range() or similar between loop iterations.

Guenter

>> Memory allocation failures are not commonly logged since the low level code
>> already does that.
> 
> Right, I'll remove the error log.
> 
> Alvaro

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
