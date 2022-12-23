Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F39DC4332F
	for <virtualization@archiver.kernel.org>; Fri, 23 Dec 2022 20:02:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CDBBE400D3;
	Fri, 23 Dec 2022 20:02:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CDBBE400D3
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=T/HZO1Z8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ek1jGl69qecX; Fri, 23 Dec 2022 20:02:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8644F40412;
	Fri, 23 Dec 2022 20:02:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8644F40412
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B0EBC0077;
	Fri, 23 Dec 2022 20:02:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3AC1FC0070
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 20:02:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 025CE41026
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 20:02:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 025CE41026
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mMIwai2f2akd
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 20:02:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1EAD540412
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com
 [IPv6:2607:f8b0:4864:20::a32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1EAD540412
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 20:02:09 +0000 (UTC)
Received: by mail-vk1-xa32.google.com with SMTP id v4so563881vkc.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 12:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ytlGRN+Zvf1GCedPeHeIV0/Bc2Bxmm4MYRgni7UZ0VA=;
 b=T/HZO1Z86a/yucKbo8fCYB94xGQsaTO4ihOAnJOljMUc9OICiF/xMdXrc4ryg28DpR
 eFl/E3g3ID+1rnnglCWSW0jyixUPXe1uLYogNis+p2d9rOzDyOEgoIH4uPfAhY1MCiEh
 FRVU9oEHU2CS0vZvFc4uxoQNQVaMpW4BUYnLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ytlGRN+Zvf1GCedPeHeIV0/Bc2Bxmm4MYRgni7UZ0VA=;
 b=n7jCKq+/Z6dJ/PJRVKam1Vbm2NNlQwPbHJ0nMHxtNa5bU28/l5ZhYXBJ4zcLvfaMzO
 9Hj7imCQ3YmPYtyUgFjmpjWyalpFrS4HVtaV4Qa1quVd6V/d1nvRnlQgEfW4lbdY6vnz
 rNfy0QTHuJKmJdpG4rGfWMEYjjPa2ADzB/64tz8rL0fF32/6nGTtpN0+t62m7nA8pyq3
 wbGlAjLC1LJfRyceGU3YHqu2OyuyK07oBVBN+iwvc5rg8vpNLtGvkOHmfcFdZeMUSSsv
 cyEV17j98sGMetvX89WFdoGjBiOrBR90yDk3yU+8l9h9a9b7XWCPx2dEb/f/s4ItoPiz
 y9Gw==
X-Gm-Message-State: AFqh2kpVar1jSo1n6RXlbo5IcXz3Fdi2TDb+kGsD5eccVx+jcC7ZQgRu
 LHnvVy2ANUDU2axLWo1ANxEmhBtD5Eqs+QE9Xs0=
X-Google-Smtp-Source: AMrXdXvuid7Gx4uQ5usvoYt6lf+UZmxmP1fY4LbH8vd2z8vgGHSy2pevNis0GjLozgUtz/ux4dpQJA==
X-Received: by 2002:a1f:aac8:0:b0:3d5:494d:2e6b with SMTP id
 t191-20020a1faac8000000b003d5494d2e6bmr255273vke.9.1671825727550; 
 Fri, 23 Dec 2022 12:02:07 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com.
 [209.85.221.178]) by smtp.gmail.com with ESMTPSA id
 e187-20020a1f50c4000000b003bbfc4cb34esm511035vkb.25.2022.12.23.12.02.07
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Dec 2022 12:02:07 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id t4so1398842vkt.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 12:02:07 -0800 (PST)
X-Received: by 2002:a05:6214:2b9a:b0:4c7:20e7:a580 with SMTP id
 kr26-20020a0562142b9a00b004c720e7a580mr551504qvb.43.1671825298226; Fri, 23
 Dec 2022 11:54:58 -0800 (PST)
MIME-Version: 1.0
References: <20221222144343-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221222144343-mutt-send-email-mst@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Dec 2022 11:54:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi6Gkr7hJz20+xD=pBuTrseccVgNR9ajU7=Bqbrdk1t4g@mail.gmail.com>
Message-ID: <CAHk-=wi6Gkr7hJz20+xD=pBuTrseccVgNR9ajU7=Bqbrdk1t4g@mail.gmail.com>
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

On Thu, Dec 22, 2022 at 11:43 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

I see none of this in linux-next.

               Linus
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
