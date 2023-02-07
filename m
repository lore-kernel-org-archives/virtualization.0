Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633FFC636D3
	for <virtualization@archiver.kernel.org>; Tue,  7 Feb 2023 17:54:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E37204064C;
	Tue,  7 Feb 2023 17:54:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E37204064C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lgi/S5+a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MMJ7mzaYRiyV; Tue,  7 Feb 2023 17:54:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B2D5440A68;
	Tue,  7 Feb 2023 17:54:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B2D5440A68
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BADAC0033;
	Tue,  7 Feb 2023 17:54:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F9D8C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 17:54:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 69C0F81E0E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 17:54:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 69C0F81E0E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=lgi/S5+a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eZSVU2Lxm4zX
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 17:54:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 53E0B8176D
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 53E0B8176D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 17:54:10 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id CA068B81A1F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 17:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D943C433EF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 17:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675792446;
 bh=QRBQnyyHAR4nNDWnh2/Xyc0CKoOqb7mHoQfl7kZ5vpk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=lgi/S5+a1/ZukFGv53T3arvczqE+I9asjszo6+cA1299DkGCPnySgcfj9zTFFlUTf
 T2Jt7Zd9IWFxaYQvUptoNjBfr4XCGQrn1RjxaQ0HKubVTj66/up/qYDwgsBsw4sXE3
 aj4ZIUDZTZedaeuvuXTfAsVQiZmc9izSzFq3LPMI5P8GAVV9VDncsDBRw407iXjcdE
 axwkA0AEIbSF33cuR2fSOVRf4019mEArjfaK4wQmOCxOzEhL61zRU6SZCwDZvGgs73
 S1GdrGJEjnD6VMs35rufyWWVn5CsQoYvYZLfQpjq6TUwFqzC8rhjk05pUupGHLwy6k
 oTyFWfNDu0Pkw==
Received: by mail-vs1-f43.google.com with SMTP id a24so17148910vsl.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Feb 2023 09:54:06 -0800 (PST)
X-Gm-Message-State: AO0yUKW0/CIfRR1Nj5bJD2YvowA5w+HJvtRoQkS8p5XN+OZvkCT78EAR
 guPsRNP7XtlCrNBQ62qJoi+ObZEJO9Wx1J0nCw==
X-Google-Smtp-Source: AK7set+aGI6c3afb0NAGVijCIp/ouYbW3+D03JuQO2RqNg4GVnToaFDDhXrPsBKRZa22R6HxxHE3Q1Ywvlh75hzvsMs=
X-Received: by 2002:a67:7206:0:b0:3ea:c8c:48a5 with SMTP id
 n6-20020a677206000000b003ea0c8c48a5mr825382vsc.53.1675792445449; Tue, 07 Feb
 2023 09:54:05 -0800 (PST)
MIME-Version: 1.0
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <CAL_JsqKL3JA6nAkEHuuyxbs8-Mm=Q-nNkCmpnDApNUDVbLsvKw@mail.gmail.com>
 <20230201020449.GC20379@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20230201145146.GA3352796-robh@kernel.org>
 <20230201163455.GA21409@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20230201163455.GA21409@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: Rob Herring <robh@kernel.org>
Date: Tue, 7 Feb 2023 11:53:54 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKHPg4ybcmMV2fmqG_Xo+9nR917TD8KmubfhyEwA2cwPA@mail.gmail.com>
Message-ID: <CAL_JsqKHPg4ybcmMV2fmqG_Xo+9nR917TD8KmubfhyEwA2cwPA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Device tree support for Hyper-V VMBus driver
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
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

On Wed, Feb 1, 2023 at 10:34 AM Saurabh Singh Sengar
<ssengar@linux.microsoft.com> wrote:
>
> On Wed, Feb 01, 2023 at 08:51:46AM -0600, Rob Herring wrote:
> > On Tue, Jan 31, 2023 at 06:04:49PM -0800, Saurabh Singh Sengar wrote:
> > > On Tue, Jan 31, 2023 at 02:27:51PM -0600, Rob Herring wrote:
> > > > On Tue, Jan 31, 2023 at 12:10 PM Saurabh Sengar
> > > > <ssengar@linux.microsoft.com> wrote:
> > > > >
> > > > > This set of patches expands the VMBus driver to include device tree
> > > > > support.
> > > > >
> > > > > The first two patches enable compilation of Hyper-V APIs in a non-ACPI
> > > > > build.
> > > > >
> > > > > The third patch converts the VMBus driver from acpi to more generic
> > > > > platform driver.
> > > > >
> > > > > Further to add device tree documentation for VMBus, it needs to club with
> > > > > other virtualization driver's documentation. For this rename the virtio
> > > > > folder to more generic hypervisor, so that all the hypervisor based
> > > > > devices can co-exist in a single place in device tree documentation. The
> > > > > fourth patch does this renaming.
> > > > >
> > > > > The fifth patch introduces the device tree documentation for VMBus.
> > > > >
> > > > > The sixth patch adds device tree support to the VMBus driver. Currently
> > > > > this is tested only for x86 and it may not work for other archs.
> > > >
> > > > I can read all the patches and see *what* they do. You don't really
> > > > need to list that here. I'm still wondering *why*. That is what the
> > > > cover letter and commit messages should answer. Why do you need DT
> > > > support? How does this even work on x86? FDT is only enabled for
> > > > CE4100 platform.
> > >
> > > HI Rob,
> > >
> > > Thanks for your comments.
> > > We are working on a solution where kernel is booted without ACPI tables to keep
> > > the overall system's memory footprints slim and possibly faster boot time.
> > > We have tested this by enabling CONFIG_OF for x86.
> >
> > It's CONFIG_OF_EARLY_FLATTREE which you would need and that's not user
> > selectable. At a minimum, you need some kconfig changes. Where are
> > those?
>
> You are right we have define a new config flag in Kconfig, and selected CONFIG_OF
> and CONFIG_OF_EARLY_FLATTREE. We are working on upstreaming that patch as well
> however that will be a separate patch series.

Fair enough, but that should come first IMO. Really I just want to see
a complete picture. That can be a reference to a git branch(es) or
other patch series. But again, what I want to see in particular is the
actual DT and validation run on it.

> > Also see my comment on v1 about running DT validation on your dtb. I'm
> > sure running it would point out other issues. Such as the root level
> > comaptible string(s) need to be documented. You need cpu nodes,
> > interrupt controller, timers, etc. Those all have to be documented.
>
> I will be changing the parent node to soc node as suggested by Krzysztof
> in other thread.

Another issue yes, but orthogonal to my comments.

>
> soc {
>         #address-cells = <2>;
>         #size-cells = <2>;

You are missing 'ranges' here. Without it, addresses aren't translatable.

You are also missing 'compatible = "simple-bus";'. This happens to
work on x86 because of legacy reasons, but we don't want new cases
added.

>
>         vmbus@ff0000000 {
>             #address-cells = <2>;
>             #size-cells = <1>;
>             compatible = "Microsoft,vmbus";

'Microsoft' is not a vendor prefix.

>             ranges = <0x00 0x00 0x0f 0xf0000000 0x10000000>;
>         };
> };
>
> This will be sufficient.

All these comments are unnecessary because the tools will now check
these things and we shouldn't have to.

Rob
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
