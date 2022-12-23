Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D9FC3DA79
	for <virtualization@archiver.kernel.org>; Fri, 23 Dec 2022 22:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E05ED41BDA;
	Fri, 23 Dec 2022 22:37:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E05ED41BDA
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=O0nO2npc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k_33qn_oLRz0; Fri, 23 Dec 2022 22:37:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2376F41BD8;
	Fri, 23 Dec 2022 22:37:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2376F41BD8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFEC7C0071;
	Fri, 23 Dec 2022 22:37:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C8B6C0070
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 22:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 764BC41BDA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 22:37:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 764BC41BDA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XgOteTltX7QF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 22:37:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 31D5041BD8
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 31D5041BD8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 22:37:06 +0000 (UTC)
Received: by mail-qt1-x82d.google.com with SMTP id x11so4699774qtv.13
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 14:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vSvLPbLq/C9FCOrpReOfkegMxmEq2CG+zmnUg15rfnE=;
 b=O0nO2npcsEuGz+0NX8LmllWKqOioCXhGuOHySQlyMTXGG2F9CCkQXekZJapL/wB5cN
 luHDk0NeFDIYSI6+va2fCWh86HzpC4ARJaWu10Enp9BH5cG/n36UP46NrRtnmKYV2mdp
 6PrsrjtqGbBhZOiPYxKOD7XSXcAkSBUcrfYFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vSvLPbLq/C9FCOrpReOfkegMxmEq2CG+zmnUg15rfnE=;
 b=rZHpGVmUV1Ew2qsK/Dki1n0hPot7T2Jr52wamBWMV8yG3AwAnWgn02cE+d9Tk6Qf6s
 AzLvvplTsq5qMGR22PCLo6Q3lqKPlx0ROTu7BD9fGwYUEgR0edwxRU6pcetXu0Ux3ZXg
 JbyjYNBglzrk5VYwRITVycbwMP524EUPyR92CRJ9lwOmbXr5AL0mOECzxa5X8BP/HWRK
 QJqgrRbgKnsg9faJKBw7tsRL3XNaemhnpUJ7gNL6VRYKrwpEdIhGjXgOcMnnGdy3D7/q
 9eLtnD6eefPkd7i3f8m2RZK93KSIzntwXHB/1ZNMkJwqR1gTZQ3vFu/SeoWpVwb1AVea
 6sfw==
X-Gm-Message-State: AFqh2krwjqLJ/+zfVyAtm4FoRfQ/WaOXjyp9sCBt+wi96CC1ZAOqpW54
 KZ4p90vhpTTy703Y1Ef0FrcK09+wYyOwT3DNVuw=
X-Google-Smtp-Source: AMrXdXt6DvBWXf/598LajPy7d/GaHXk15A7Gkmu5C+eyNesGnpppW7/ZtadMQwX8uPkmoYFGSCCyMA==
X-Received: by 2002:ac8:74cc:0:b0:3a5:306f:b124 with SMTP id
 j12-20020ac874cc000000b003a5306fb124mr14597956qtr.10.1671835024717; 
 Fri, 23 Dec 2022 14:37:04 -0800 (PST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com.
 [209.85.222.173]) by smtp.gmail.com with ESMTPSA id
 h10-20020ac8548a000000b003a8163c1c96sm2571749qtq.14.2022.12.23.14.37.03
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Dec 2022 14:37:03 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id c9so2945465qko.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 14:37:03 -0800 (PST)
X-Received: by 2002:a05:620a:1379:b0:6fc:c48b:8eab with SMTP id
 d25-20020a05620a137900b006fcc48b8eabmr367434qkl.216.1671835022820; Fri, 23
 Dec 2022 14:37:02 -0800 (PST)
MIME-Version: 1.0
References: <20221222144343-mutt-send-email-mst@kernel.org>
 <CAHk-=wi6Gkr7hJz20+xD=pBuTrseccVgNR9ajU7=Bqbrdk1t4g@mail.gmail.com>
 <20221223172549-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221223172549-mutt-send-email-mst@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Dec 2022 14:36:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=whpdP7X+L8RtGsonthr7Ffug=FhR+TrFe3JUyb5-zaYCA@mail.gmail.com>
Message-ID: <CAHk-=whpdP7X+L8RtGsonthr7Ffug=FhR+TrFe3JUyb5-zaYCA@mail.gmail.com>
Subject: Re: [GIT PULL] virtio,vhost,vdpa: features, fixes, cleanups
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: bobby.eshleman@bytedance.com, kvm@vger.kernel.org, sunnanyong@huawei.com,
 yuancan@huawei.com, virtualization@lists.linux-foundation.org,
 weiyongjun1@huawei.com, elic@nvidia.com, set_pte_at@outlook.com,
 m.szyprowski@samsung.com, almasrymina@google.com, sfr@canb.auug.org.au,
 dave@stgolabs.net, anders.roxell@linaro.org, lulu@redhat.com,
 ruanjinjie@huawei.com, rafaelmendsr@gmail.com, pizhenwei@bytedance.com,
 eperezma@redhat.com, angus.chen@jaguarmicro.com, lkft@linaro.org,
 colin.i.king@gmail.com, sammler@google.com, nathan@kernel.org,
 leiyang@redhat.com, harshit.m.mogalapalli@oracle.com, wangjianli@cdjrlc.com,
 gautam.dawar@xilinx.com, pabeni@redhat.com, dengshaomin@cdjrlc.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 dmitry.fomichev@wdc.com, wangrong68@huawei.com
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

On Fri, Dec 23, 2022 at 2:27 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> They were all there, just not as these commits, as I squashed fixups to
> avoid bisect breakages with some configs. Did I do wrong?

I am literally looking at the next-20221214 state right now, doing

    git log linus/master.. -- drivers/vhost/vsock.c
    git log linus/master.. -- drivers/vdpa/mlx5/
    git log --grep="temporary variable type tweak"

and seeing nothing.

So none of these commits - in *any* form - were in linux-next last
week as far as I can tell.

             Linus
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
