Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47044C433EF
	for <virtualization@archiver.kernel.org>; Fri, 18 Mar 2022 13:40:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E371361358;
	Fri, 18 Mar 2022 13:40:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rG76nTLg4XeS; Fri, 18 Mar 2022 13:40:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 93A50607BC;
	Fri, 18 Mar 2022 13:40:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67233C0033;
	Fri, 18 Mar 2022 13:40:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56256C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 13:40:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4530840330
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 13:40:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fUqd6dGK7URT
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 13:40:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 976B7402A8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 13:40:33 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id s29so14100120lfb.13
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 06:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=iuWM94KXc3sHuEczLPPtyGXuhzAg1rDstlM1ADE7s3M=;
 b=XrVnOOWANhLsZoKC7tAVwelULRuxcVtl8ok/B50Ci+Icmp+Xm78Hs7u1hmCqy4Y9o5
 2wQrwtdFlk/UIFqJQadRtS0Sp0F/pLURRTuTtJP7dz9i1kpiKvHLA8GVecaFHHtp8j1E
 7F+jwE8+TZ6+X/np5nIlpcam2tZn9pZd7MHOG0dlE+RrNOXg+nvEORA8OwnJ8OSdgUaR
 ghWGedl3Mxw04GCMk6LBPsF3z7CntEN99/POd2HNPhFRXs6+uhH4jNOo4g2PRc479yre
 i6gsfByRRy+qx/ULHMBd1czjbi8C1XcWZbod0behsp4N+JD2Gy0CVH5UDMahoC7BIctp
 Ht3Q==
X-Gm-Message-State: AOAM531xqh/eJDrNHFipTZRjp0AFhaITEAbvf5CtsAS5I20tHrLGPmcS
 jDw578EaGSsTyQORF00x9mI=
X-Google-Smtp-Source: ABdhPJzRWA/Ob0RieST3cFH09R5YU4a/GPnX/2Z2nYswG93mdyAF6PWgwC9uMegY4oc7gHWoPDs9oQ==
X-Received: by 2002:ac2:5389:0:b0:448:90e8:b166 with SMTP id
 g9-20020ac25389000000b0044890e8b166mr6031739lfh.121.1647610831557; 
 Fri, 18 Mar 2022 06:40:31 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl.
 [78.11.189.27]) by smtp.googlemail.com with ESMTPSA id
 q26-20020ac24a7a000000b004437f641a32sm854157lfp.15.2022.03.18.06.40.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Mar 2022 06:40:31 -0700 (PDT)
Message-ID: <d4d69acd-72d3-dfe1-9a11-d6590d2d90d8@kernel.org>
Date: Fri, 18 Mar 2022 14:40:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: virtio: mmio: add optional virtio,wakeup
 property
Content-Language: en-US
To: Minghao Xue <quic_mingxue@quicinc.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <1646733156-19333-1-git-send-email-quic_mingxue@quicinc.com>
 <20220317063515.GA30789@mingxue-gv.qualcomm.com> <YjMJ32SFXTLCuaRY@myrica>
 <20220318021052.GA16300@mingxue-gv.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220318021052.GA16300@mingxue-gv.qualcomm.com>
Cc: devicetree@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, robh+dt@kernel.org,
 quic_ztu@quicinc.com
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

On 18/03/2022 03:10, Minghao Xue wrote:
> Hi Jean and folks,
> This is just an optional flag which could be used on an embedded system.
> For example, if we want to use an virtio-input device as a virtual power
> key to wake up the virtual machine, we can set this flag in the device
> tree.
> Currently, virio-mmio driver does not implement suspend/resume
> callback(maybe no need). So we want to check this flag and call
> enable_irq_wake()  accordingly in vm_find_vqs().

There is a generic wakeup-source property. How is this one different
that you need a separate one?


Best regards,
Krzysztof
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
