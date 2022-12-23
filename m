Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA68AC4332F
	for <virtualization@archiver.kernel.org>; Fri, 23 Dec 2022 22:36:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3397C40329;
	Fri, 23 Dec 2022 22:36:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3397C40329
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VCD5XFNN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cPyUFZG-YC80; Fri, 23 Dec 2022 22:36:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C1BD440122;
	Fri, 23 Dec 2022 22:36:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C1BD440122
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A39F6C0071;
	Fri, 23 Dec 2022 22:36:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE930C0070
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 22:36:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 810B260B0C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 22:36:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 810B260B0C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VCD5XFNN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0J3Anj4cWskj
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 22:36:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 969806079B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 969806079B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 22:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671834966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vAEhCvBqDOSeVJ5cr+C6I0wt8yyHcksJQ4MmdK2pgfQ=;
 b=VCD5XFNNFahNaBun0+u5iYfeEm9ZgbZh694LccFbz5ulG3F/Up354niYevB7PclVcaiKo/
 ms1zcJjgytvUSpwzXHSa0bQf4brfL8eRQgbOVb1sEzMWt/ejZG6htOSeCKPhAjT8MrVvIZ
 fYIWwXQzbNTW3RpQiwqoYU/vOIRHy2M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-358-J_HwaGBQPEe7mbCBby_ZWQ-1; Fri, 23 Dec 2022 17:36:05 -0500
X-MC-Unique: J_HwaGBQPEe7mbCBby_ZWQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 hs18-20020a1709073e9200b007c0f9ac75f9so4063107ejc.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 14:36:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vAEhCvBqDOSeVJ5cr+C6I0wt8yyHcksJQ4MmdK2pgfQ=;
 b=q5xxOwQN01h4QT8yQ7JGcChJAEeg3mqUUKf4SfjLwcXA8K/Xo2YS0VyVW6Du+xzwsZ
 IU2i3gXM9AhmjIPT5VjIEzKKjYNmVj9CjOIk0dgvFLWWJNNgUnNyfewMyFlo86qfpqkO
 JXL/9xJRzdCGvZUSEFoa0+8uisZPepxYeZx5VRQhzp10TbFrKRAnQESU+bwUrWqMVC2/
 BH/w2xsdBP2KNVE6z4CD6wzHs1i5LBgueWph3y1FZme/VrLfJZQbf3JFqDvAxKswxiBe
 1TGr4adz71dCJdtK7lAsPbTHsw9Ir3CwUi1jlrQjBR5UGT5w0RTBzcqin0qGHcbDLwGu
 +gHw==
X-Gm-Message-State: AFqh2kpsyGUpy0UaNkZ0TD8kwmuIq8K6NsOGV+Ze9wCcTryiEY/XiqAu
 rpLBEdV1Dgwg/oHYiknyrPZOAySFSWloRT6/GXwK6kdvIputcfMHvCLoZPLo01cEj6ZuJ1B99aT
 +yxb/eUMNju18mcvcCZBF51fGtDG9f59OGmZyZ5ORbw==
X-Received: by 2002:a17:906:7f91:b0:7c1:5a5:f6bb with SMTP id
 f17-20020a1709067f9100b007c105a5f6bbmr8730262ejr.50.1671834964185; 
 Fri, 23 Dec 2022 14:36:04 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuLH42LmprbIKVhy48/0bhL/K12YuoqsuPbuz81JiRHptRGsUb+Yjw6OoTZMpmBqEdLpDoCRQ==
X-Received: by 2002:a17:906:7f91:b0:7c1:5a5:f6bb with SMTP id
 f17-20020a1709067f9100b007c105a5f6bbmr8730220ejr.50.1671834963942; 
 Fri, 23 Dec 2022 14:36:03 -0800 (PST)
Received: from redhat.com ([2.55.175.215]) by smtp.gmail.com with ESMTPSA id
 z4-20020a1709060ac400b007c500ac66b2sm1831409ejf.64.2022.12.23.14.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Dec 2022 14:36:03 -0800 (PST)
Date: Fri, 23 Dec 2022 17:35:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] virtio,vhost,vdpa: features, fixes, cleanups
Message-ID: <20221223173127-mutt-send-email-mst@kernel.org>
References: <20221222144343-mutt-send-email-mst@kernel.org>
 <CAHk-=wi6Gkr7hJz20+xD=pBuTrseccVgNR9ajU7=Bqbrdk1t4g@mail.gmail.com>
 <20221223172549-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20221223172549-mutt-send-email-mst@kernel.org>
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

On Fri, Dec 23, 2022 at 05:27:49PM -0500, Michael S. Tsirkin wrote:
> On Fri, Dec 23, 2022 at 11:54:41AM -0800, Linus Torvalds wrote:
> > On Thu, Dec 22, 2022 at 11:43 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> > 
> > I see none of this in linux-next.
> > 
> >                Linus
> 
> They were all there, just not as these commits, as I squashed fixups to
> avoid bisect breakages with some configs. Did I do wrong?

More specifically, everything up to
458326ec10d1233399a342263d33878cb0afe710 lines up in next-20221220, and
then I decided to rebase to squash bugfixes.
Plus these are two trivial patches on top that just tweak sparse
tags so 0 chance of regressions, and an also trivial security-related bugfix.


> -- 
> MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
