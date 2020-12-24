Return-Path: <SRS0=rM6z=F4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E350C433E0
	for <virtualization@archiver.kernel.org>; Thu, 24 Dec 2020 15:57:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 066FF223DB
	for <virtualization@archiver.kernel.org>; Thu, 24 Dec 2020 15:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066FF223DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 279EA867F4;
	Thu, 24 Dec 2020 15:57:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id psuJM0xB5xlu; Thu, 24 Dec 2020 15:57:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7A34F85FC4;
	Thu, 24 Dec 2020 15:57:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59FC9C1825;
	Thu, 24 Dec 2020 15:57:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8685CC0893
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 15:57:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7A08886243
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 15:57:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a56PQAFrrQnU
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 15:56:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com
 [209.85.217.52])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 493B385B3B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 15:56:57 +0000 (UTC)
Received: by mail-vs1-f52.google.com with SMTP id s2so1514096vsk.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 07:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XRYO0lFUVOrah75uQXi2tgidobUUXCXbkVzNcCSUK7Y=;
 b=vD+85mxRjBfgH/Sr9fNWdZGEZkGCHFeLsjU3Ur+c3zJ5wpb8lGtmkFUlNYttDgBl3q
 pA+Xr1MSgCOJD31ItdxXMEyce5g0ByZJ9cV5+yoh1TlZ15r9KptXP5AmQAA5IDLtQhSo
 ufPxBCA+vBcRbjE/l97R4uobG1CxRofdyDygsn0r4YzTJg8fHwRFCRGXpRcV5HWb4UPy
 822ceXGoh7xsp9/ALp7vqguO5tHDyI9vzdm+X9EY4dOxT5LvNdfSw1BnYqGU9VZB5pot
 qJt/EEOUvT0cHl2EwwDJ6Hu7uMhSyi+zlsutqz9l1oa6vxvhfH+qb8i8zb7TkPf/dwEh
 7QGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XRYO0lFUVOrah75uQXi2tgidobUUXCXbkVzNcCSUK7Y=;
 b=tlp+bRVkOmOkGxEEORqnPRtxpShoUiyGxzIYC/q4j5SUKVRr9hMGGPHUZYsrlU1byZ
 8ANo5HyeDlSMND2JV/m/zi2hT8chy+mVKmJFEjij7mAVeRcb8Au86vtG1ub472EpYoGc
 VcVRPB4kcFMO/3zvritGzPrWtivCRjKrNkPVVO1+HgJe7WW9KZZ8IyNdicrB90OMPWfZ
 4EnWzS5b28wiMZ51B3IFglNo8pAYNf3LHti77h9BfiGl9I5GGLPX/qc3yONbGSfCaHQq
 wK/NYo8JrVybHs7mUz29iSNo/szxB1PRTNdZlmE18cPUWscHHpLaabcIsZ9QUuFEEeOV
 RyMw==
X-Gm-Message-State: AOAM531Hnl3yMkQ4insu09bbcQGBqGjnx9JxlwDMYsFkxvRs9WOksCKa
 FUhG60G7fDmRbdrEx+wWoa9GhvN1178=
X-Google-Smtp-Source: ABdhPJxHW/Ak1ZOeDy4PeYdzn2C8bMNiYc+/jZrFmfiNYJCpVikrQJdwkegsRdiDy73tYAReAmDfGg==
X-Received: by 2002:a67:80d3:: with SMTP id b202mr22634599vsd.2.1608825415448; 
 Thu, 24 Dec 2020 07:56:55 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com.
 [209.85.217.52])
 by smtp.gmail.com with ESMTPSA id e3sm3805641vkh.11.2020.12.24.07.56.54
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Dec 2020 07:56:54 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id q10so1474360vsr.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 07:56:54 -0800 (PST)
X-Received: by 2002:a67:3201:: with SMTP id y1mr21661285vsy.22.1608825414045; 
 Thu, 24 Dec 2020 07:56:54 -0800 (PST)
MIME-Version: 1.0
References: <1608810533-8308-1-git-send-email-wangyunjian@huawei.com>
In-Reply-To: <1608810533-8308-1-git-send-email-wangyunjian@huawei.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 24 Dec 2020 10:56:16 -0500
X-Gmail-Original-Message-ID: <CA+FuTSfmKFVZ7_q6nU92YYk-MLKWTa_bkE+L4C8vi5+UQ1_a8A@mail.gmail.com>
Message-ID: <CA+FuTSfmKFVZ7_q6nU92YYk-MLKWTa_bkE+L4C8vi5+UQ1_a8A@mail.gmail.com>
Subject: Re: [PATCH net] tun: fix return value when the number of iovs exceeds
 MAX_SKB_FRAGS
To: wangyunjian <wangyunjian@huawei.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 "Lilijun \(Jerry\)" <jerry.lilijun@huawei.com>,
 virtualization@lists.linux-foundation.org, xudingke <xudingke@huawei.com>,
 "huangbin \(J\)" <brian.huangbin@huawei.com>,
 chenchanghu <chenchanghu@huawei.com>
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

On Thu, Dec 24, 2020 at 6:51 AM wangyunjian <wangyunjian@huawei.com> wrote:
>
> From: Yunjian Wang <wangyunjian@huawei.com>
>
> Currently the tun_napi_alloc_frags() function returns -ENOMEM when the
> number of iovs exceeds MAX_SKB_FRAGS + 1. However this is inappropriate,
> we should use -EMSGSIZE instead of -ENOMEM.
>
> Fixes: 90e33d459407 ("tun: enable napi_gro_frags() for TUN/TAP driver")
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>

Acked-by: Willem de Bruijn <willemb@google.com>

It might be good to explain why the distinction matters: one denotes a
transient failure that the caller (specifically vhost_net) can retry,
the other a persistent failure due to bad packet geometry that should
be dropped.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
