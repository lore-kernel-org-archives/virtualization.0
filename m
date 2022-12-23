Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD63BC4332F
	for <virtualization@archiver.kernel.org>; Fri, 23 Dec 2022 22:27:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33A1861166;
	Fri, 23 Dec 2022 22:27:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 33A1861166
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E7DqpYKT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tAMl6qc35aAt; Fri, 23 Dec 2022 22:27:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D7E1B60AF6;
	Fri, 23 Dec 2022 22:27:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D7E1B60AF6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CA7DC0071;
	Fri, 23 Dec 2022 22:27:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B13DC0070
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 22:27:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3170F40162
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 22:27:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3170F40162
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=E7DqpYKT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BQXKO4Pb3tGJ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 22:27:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1224E40122
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1224E40122
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 22:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671834471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NtRKjrrbYIdgIGkqJ3VqinENOoahNs+OyBFqva7XmGo=;
 b=E7DqpYKTGehP8+1P8QLubJAG/tC6tW28WOqY7A4C3iTrBE6Idrn7T1MbbG24kcb+mw1YLv
 cEvC4nL7bTMwzmwk5GUvjNvhL3z+S7fFhe7Kmyp2Ol9yyg2GmFz3KfEasFGM5i9MGbv5O6
 NqLv3aOTUsMbB+8dggqma1kBb0xZVt0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-280-CV4DVEBdOUCNQuXjgt5uIA-1; Fri, 23 Dec 2022 17:27:50 -0500
X-MC-Unique: CV4DVEBdOUCNQuXjgt5uIA-1
Received: by mail-wm1-f70.google.com with SMTP id
 fl12-20020a05600c0b8c00b003d96f0a7f36so1385727wmb.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 14:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NtRKjrrbYIdgIGkqJ3VqinENOoahNs+OyBFqva7XmGo=;
 b=fOa4oAbxWyRm7MjBfIHK6CVcfiSwR51+9MIofcwcYLR90hTYrwk2ynB8Ba00FY1VB8
 PXpwmO4XsciVUNJg6SjES8M5uVX4sHr5rnSTFAaa8gokHrzY7mPTbEA/Y72H6NRz+9TU
 xVRSSz/UoBHYnVP9NfdtYF/hGeEiZi/Dk5aqsELaaSjtQSZpW85lcWdjtGK+38zOOVQN
 XU3/+A2LR+DKGE2vvl5KmeBkySxc77BuUTm8YToqHY8oynASiyNSUTBAua+dfr9LKSL+
 ksyGaKOIp/ZJWeyRknaQsD5xIkvKBGxurncR5NUWjVHpBbKOJp2xOp0vI+r8CeTHddCn
 RkVA==
X-Gm-Message-State: AFqh2kqORmB1f16p1NC4woYzXED6eIESIOi+Pu1u7kNjWnKx3IW9rzQ4
 4Z3dM7Onuli1ehdbkev08NyQ0nCX+7jk1sqEIMZBulRkJQcgvCdOy6VtjV8c6yDAlnXlBia12Oi
 ZRMvAeZF/SKEc+Ab5TjfcGYTyMA42yJu/5QhvPfWY6g==
X-Received: by 2002:a1c:770b:0:b0:3cf:a18d:399c with SMTP id
 t11-20020a1c770b000000b003cfa18d399cmr8706198wmi.1.1671834468902; 
 Fri, 23 Dec 2022 14:27:48 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtypUNzb7VgDxwSmNV5kkZqdNzHIvqFLFIqRXIsvO8K841mwmSg7ycczPWKeRCh2AE62HTTFw==
X-Received: by 2002:a1c:770b:0:b0:3cf:a18d:399c with SMTP id
 t11-20020a1c770b000000b003cfa18d399cmr8706186wmi.1.1671834468656; 
 Fri, 23 Dec 2022 14:27:48 -0800 (PST)
Received: from redhat.com ([2.55.175.215]) by smtp.gmail.com with ESMTPSA id
 h12-20020a05600c350c00b003d355ad9bb7sm11729817wmq.20.2022.12.23.14.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Dec 2022 14:27:47 -0800 (PST)
Date: Fri, 23 Dec 2022 17:27:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] virtio,vhost,vdpa: features, fixes, cleanups
Message-ID: <20221223172549-mutt-send-email-mst@kernel.org>
References: <20221222144343-mutt-send-email-mst@kernel.org>
 <CAHk-=wi6Gkr7hJz20+xD=pBuTrseccVgNR9ajU7=Bqbrdk1t4g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wi6Gkr7hJz20+xD=pBuTrseccVgNR9ajU7=Bqbrdk1t4g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Fri, Dec 23, 2022 at 11:54:41AM -0800, Linus Torvalds wrote:
> On Thu, Dec 22, 2022 at 11:43 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> 
> I see none of this in linux-next.
> 
>                Linus

They were all there, just not as these commits, as I squashed fixups to
avoid bisect breakages with some configs. Did I do wrong?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
