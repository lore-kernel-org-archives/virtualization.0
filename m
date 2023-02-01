Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0557C05027
	for <virtualization@archiver.kernel.org>; Wed,  1 Feb 2023 14:51:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4BF0340391;
	Wed,  1 Feb 2023 14:51:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4BF0340391
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YUzIrI_rg899; Wed,  1 Feb 2023 14:51:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C819F409DE;
	Wed,  1 Feb 2023 14:51:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C819F409DE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 981DCC0033;
	Wed,  1 Feb 2023 14:51:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD80DC002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 14:51:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B185E4031C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 14:51:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B185E4031C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vNmoYssXJXu9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 14:51:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 949C44031B
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 949C44031B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 14:51:48 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id
 e12-20020a0568301e4c00b0068bc93e7e34so3414474otj.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Feb 2023 06:51:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tljt9O289Ygn6RcNGURVZg0WLWtxuH5o9nRRq4d+zBg=;
 b=FLc4EljxOTAay1EkuLHhNhdUgv60MJPfRHnIABsbhUWD2vh+20i9JLfDuQtppxZEzY
 vs7qGG9xosZPEEF7JDIZKRDsIRqbT0Hjh3JUAMgyBm/dhLDG3OOglR9pzJX3mhj+seFe
 jcie3BF2Q7l4JNnNeoFYV1EZpJNeoIAlix6uA8aTib3ZISkxxf/GnBKS5GiujtdncJgn
 tlwGVcHS/yeRDAtJeHb++PtG7/i11Du7iLzpjvPMad4Bg8gspo2iC/XE/dlFZL0OL8Ij
 EEZg4bEqPqtcuPBPCr+M4joe7sI5UUcQDGHgm9e3LaEeiNkM8Ph6cawwx7dHHsCAzYo9
 EHsw==
X-Gm-Message-State: AO0yUKUWS+Qyu11ZqKfmnCUlBO4l3n0iK5DV0l5WRZ4w2jZIUD+ttVED
 dYiceloAZoBZh47+82+tCg==
X-Google-Smtp-Source: AK7set+yHHJTXSgQrEBo/14mWJ9B0EPRO/kN/uQP7vYXz6zGUE9ij0ke5wXk6VULnR0zcZ6KWd+jLA==
X-Received: by 2002:a05:6830:14cc:b0:686:5047:8478 with SMTP id
 t12-20020a05683014cc00b0068650478478mr1529863otq.16.1675263107506; 
 Wed, 01 Feb 2023 06:51:47 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 t14-20020a9d590e000000b006864816ecd9sm7825565oth.59.2023.02.01.06.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Feb 2023 06:51:47 -0800 (PST)
Received: (nullmailer pid 3364869 invoked by uid 1000);
 Wed, 01 Feb 2023 14:51:46 -0000
Date: Wed, 1 Feb 2023 08:51:46 -0600
From: Rob Herring <robh@kernel.org>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH v2 0/6] Device tree support for Hyper-V VMBus driver
Message-ID: <20230201145146.GA3352796-robh@kernel.org>
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <CAL_JsqKL3JA6nAkEHuuyxbs8-Mm=Q-nNkCmpnDApNUDVbLsvKw@mail.gmail.com>
 <20230201020449.GC20379@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230201020449.GC20379@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Cc: devicetree@vger.kernel.org, wei.liu@kernel.org, ssengar@microsoft.com,
 mikelley@microsoft.com, linux-hyperv@vger.kernel.org, haiyangz@microsoft.com,
 daniel.lezcano@linaro.org, decui@microsoft.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, krzysztof.kozlowski+dt@linaro.org,
 tglx@linutronix.de
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

On Tue, Jan 31, 2023 at 06:04:49PM -0800, Saurabh Singh Sengar wrote:
> On Tue, Jan 31, 2023 at 02:27:51PM -0600, Rob Herring wrote:
> > On Tue, Jan 31, 2023 at 12:10 PM Saurabh Sengar
> > <ssengar@linux.microsoft.com> wrote:
> > >
> > > This set of patches expands the VMBus driver to include device tree
> > > support.
> > >
> > > The first two patches enable compilation of Hyper-V APIs in a non-ACPI
> > > build.
> > >
> > > The third patch converts the VMBus driver from acpi to more generic
> > > platform driver.
> > >
> > > Further to add device tree documentation for VMBus, it needs to club with
> > > other virtualization driver's documentation. For this rename the virtio
> > > folder to more generic hypervisor, so that all the hypervisor based
> > > devices can co-exist in a single place in device tree documentation. The
> > > fourth patch does this renaming.
> > >
> > > The fifth patch introduces the device tree documentation for VMBus.
> > >
> > > The sixth patch adds device tree support to the VMBus driver. Currently
> > > this is tested only for x86 and it may not work for other archs.
> > 
> > I can read all the patches and see *what* they do. You don't really
> > need to list that here. I'm still wondering *why*. That is what the
> > cover letter and commit messages should answer. Why do you need DT
> > support? How does this even work on x86? FDT is only enabled for
> > CE4100 platform.
> 
> HI Rob,
> 
> Thanks for your comments.
> We are working on a solution where kernel is booted without ACPI tables to keep
> the overall system's memory footprints slim and possibly faster boot time.
> We have tested this by enabling CONFIG_OF for x86.

It's CONFIG_OF_EARLY_FLATTREE which you would need and that's not user 
selectable. At a minimum, you need some kconfig changes. Where are 
those?

Also see my comment on v1 about running DT validation on your dtb. I'm 
sure running it would point out other issues. Such as the root level 
comaptible string(s) need to be documented. You need cpu nodes, 
interrupt controller, timers, etc. Those all have to be documented.

Rob
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
