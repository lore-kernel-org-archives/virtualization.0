Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6783EC4332F
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 20:03:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D788182011;
	Wed, 21 Dec 2022 20:03:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D788182011
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=ppCdHlGk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Su8BLVQqGXqA; Wed, 21 Dec 2022 20:03:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6DB9782016;
	Wed, 21 Dec 2022 20:03:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6DB9782016
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 541D9C0071;
	Wed, 21 Dec 2022 20:03:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F93FC0070
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 20:03:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0766340106
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 20:03:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0766340106
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=ppCdHlGk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r6KPejZ2bJBU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 20:03:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 56B594002B
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 56B594002B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 20:03:15 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id b2so3919369pld.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 12:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bo52z4bIyyHZqqPH6LANgXVILYMNk+fl/sMenmQKibE=;
 b=ppCdHlGkIneSJOlvqgV2cZr8pFbcpOBGGIkzAfj1VsYmDhnDAqGVaD6G7hLgjqmtWy
 A+/XR72LKV56NwLsjAbLfMs9ESoiyna+mJamltpTV2wd1yvhaizwwqT+AWtjTwcL5YvI
 lvIMcf0ll8i6HgY0APSRprRtY1OQ6tWnss7mbOuVrWnBUqjwL7ku10smlO0l7ZsxKK5y
 6xTHJiMBFxYQDMBAzI0mIcKdUDHN07e3oztKcysBZcOpzGx6MnKe9bAc1l9x/ylIxJ6p
 v0iVu/GoinWrtchnbJlEvYTxcPSat1JaifjoR4NzxQ2Z0DJ2TEl+WnD+/yQ43tnX5HQq
 rmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bo52z4bIyyHZqqPH6LANgXVILYMNk+fl/sMenmQKibE=;
 b=vnO0dDy1KgoMAUplyb9Ujh/znEVA07U2kxR1cVysQNCMsBSLRQgY14/rm+7YQ5qneu
 1Hu4tydpvf+1L3Ic94Q4F+LXFKsZCCCt6NznsY4rK7kBgTDlD6ffLmJqW9M6nbVo+2p6
 vEPQxxJiuctl8HeHVt7Xw4YA9v3MIjYZWT1ibyyv3SpGIhKAkIcbp6YO8XmVw4B0pzU8
 FsHBnZiWuxkd6N2fpWR+6RxEh7dd7ws/Bb7sPz4FVByOT5cjsNIF+R+dnjBFwc1Q61W7
 Zf4RNsaQP9KvJ6SeQZIh6bwE4LaIEb+yQcYFfrM1VsWNrtL/zKvx/eYM8KHfHo0BPAEG
 4yqQ==
X-Gm-Message-State: AFqh2kqDXBEB5tXNN+B/CtdQenuUHY0gA7h8/QQe3LwZdDZNHn1Fr9R9
 BMo8kOQqDh6CPDygkRwOSvFWGQZbiuN49DVBh3UNZQ==
X-Google-Smtp-Source: AMrXdXvNTUHijNFCO3PzK99U6zNM6gEecV4J87yBRejegveP7NKT2iq76YbaMTuqToMienh/C8d08Rc5kVmKWdMPyns=
X-Received: by 2002:a17:90a:6845:b0:221:5597:5de7 with SMTP id
 e5-20020a17090a684500b0022155975de7mr297116pjm.147.1671652994517; Wed, 21 Dec
 2022 12:03:14 -0800 (PST)
MIME-Version: 1.0
References: <20221221072003.551091-1-alvaro.karsz@solid-run.com>
In-Reply-To: <20221221072003.551091-1-alvaro.karsz@solid-run.com>
Date: Wed, 21 Dec 2022 12:03:03 -0800
Message-ID: <CAKwvOdk39E2PuKbQhhUSq46e3sHyJEVZ2fJ18ADWe4FZnCH3Ww@mail.gmail.com>
Subject: Re: [PATCH] virtio: vdpa: fix snprintf size argument in snet_vdpa
 driver
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: mst@redhat.com, Tom Rix <trix@redhat.com>,
 clang-built-linux <llvm@lists.linux.dev>,
 virtualization@lists.linux-foundation.org,
 Nathan Chancellor <nathan@kernel.org>
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
From: Nick Desaulniers via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Dec 20, 2022 at 11:20 PM Alvaro Karsz
<alvaro.karsz@solid-run.com> wrote:
>
> The buffer size and the size passed to snprintf don't match, causing
> clang warnings.
>
> This patch increases a little bit the size of the buffer, and uses
> sizeof() to get the buffer size.
>
> This patch should be applied on top of the following patch:
>
> virtio: vdpa: new SolidNET DPU driver,
> by Alvaro Karsz alvaro.karsz@solid-run.com
>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>

Thanks for the fix!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/vdpa/solidrun/snet_main.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
> index d438a89b359..9ceacf96de0 100644
> --- a/drivers/vdpa/solidrun/snet_main.c
> +++ b/drivers/vdpa/solidrun/snet_main.c
> @@ -540,7 +540,7 @@ static const struct vdpa_config_ops snet_config_ops = {
>
>  static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
>  {
> -       char name[25];
> +       char name[50];
>         int ret, i, mask = 0;
>         /* We don't know which BAR will be used to communicate..
>          * We will map every bar with len > 0.
> @@ -558,7 +558,7 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
>                 return -ENODEV;
>         }
>
> -       snprintf(name, SNET_NAME_SIZE, "psnet[%s]-bars", pci_name(pdev));
> +       snprintf(name, sizeof(name), "psnet[%s]-bars", pci_name(pdev));
>         ret = pcim_iomap_regions(pdev, mask, name);
>         if (ret) {
>                 SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
> @@ -575,10 +575,10 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
>
>  static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
>  {
> -       char name[20];
> +       char name[50];
>         int ret;
>
> -       snprintf(name, SNET_NAME_SIZE, "snet[%s]-bar", pci_name(pdev));
> +       snprintf(name, sizeof(name), "snet[%s]-bar", pci_name(pdev));
>         /* Request and map BAR */
>         ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
>         if (ret) {
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
