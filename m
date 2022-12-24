Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864E1C4332F
	for <virtualization@archiver.kernel.org>; Sat, 24 Dec 2022 05:35:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D7720415ED;
	Sat, 24 Dec 2022 05:35:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D7720415ED
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LiJEpaF6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SUrugKe-FteR; Sat, 24 Dec 2022 05:35:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F208F415CF;
	Sat, 24 Dec 2022 05:35:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F208F415CF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90D87C0071;
	Sat, 24 Dec 2022 05:35:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03422C0070
 for <virtualization@lists.linux-foundation.org>;
 Sat, 24 Dec 2022 05:35:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C0A44400FD
 for <virtualization@lists.linux-foundation.org>;
 Sat, 24 Dec 2022 05:35:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C0A44400FD
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LiJEpaF6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3R1lJdc6yeoW
 for <virtualization@lists.linux-foundation.org>;
 Sat, 24 Dec 2022 05:35:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D765C400D8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D765C400D8
 for <virtualization@lists.linux-foundation.org>;
 Sat, 24 Dec 2022 05:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671860140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9inerhQQEwTB9gS95jFKFAYGecKLrmD2EeG2lXh213o=;
 b=LiJEpaF6lQMHy0O//IMNTPYxdBBSD2OF+ygU2VMGX6xPjetAY6elFj/CtCeem24R05yHZY
 w6UOlV54xP4YUOx1YyAC/BQ/HLcbBhDC25ZcIYGS29P9+3WmActJkTUnbfz/LyBdst7mWY
 9BM57r5d6KLh9Y+znkrWz+5iWM/hHVE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-482-HPw7VTcqMCCygTSbbDgjAg-1; Sat, 24 Dec 2022 00:35:38 -0500
X-MC-Unique: HPw7VTcqMCCygTSbbDgjAg-1
Received: by mail-ej1-f70.google.com with SMTP id
 hs18-20020a1709073e9200b007c0f9ac75f9so4432436ejc.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 21:35:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9inerhQQEwTB9gS95jFKFAYGecKLrmD2EeG2lXh213o=;
 b=LZbpY6HalxS/hJpWRsR5HZO1fX7E8cE56kRKlyLe3KlDTXh3GiFwyIhCAkleVqY0wm
 HCUCbvgaxbMwxWcOZIJFF+v/T4e8zmqox8ERQeUU3mvLxSMwYLuclHXkXT0AUspgvnbw
 Q9dDfoT24PviFYA0gc9m2/4K0ox2RVbBa9og6YBquFXm3ySyHHerN4qnDq9mXiMWrGTP
 T0VYlVnR+7+857lC9QNRaeOa0JIRDg0lccBlT7pCQTpG7pQeplhmE+nTcEEWggM3Zccq
 JAZ9p6KywZ+PTs8o6hRGr0JxHmgJSVf649XuIGOEBPtFNtRUBGMBxghxV9xCZPiQdZm8
 omBg==
X-Gm-Message-State: AFqh2ko6AshKRejSxXkYUBkPx2W2A8dLM3If2PEHAB0zk58NDuLmlRXQ
 6KUWJc2HPIRw5QMQvddq0i+iWT0CC7miiINfLKGd2bH3A0pmgCUCYTXew7aT+F/rNF0JNSt2Glv
 LUhMeJYMmWB+qEK+cl2KPccGU/FAqaBbX4rmfIuMk4g==
X-Received: by 2002:a17:906:65a:b0:7c1:7045:1a53 with SMTP id
 t26-20020a170906065a00b007c170451a53mr9229044ejb.15.1671860137872; 
 Fri, 23 Dec 2022 21:35:37 -0800 (PST)
X-Google-Smtp-Source: AMrXdXud/Fb0wtBmXHI4TVa1R5iStbJI7HVjmtxNzdJlo5vEGwnAH05ulhj4IafppoZeQFZu1DEQKg==
X-Received: by 2002:a17:906:65a:b0:7c1:7045:1a53 with SMTP id
 t26-20020a170906065a00b007c170451a53mr9229005ejb.15.1671860137631; 
 Fri, 23 Dec 2022 21:35:37 -0800 (PST)
Received: from redhat.com ([2.55.175.215]) by smtp.gmail.com with ESMTPSA id
 a1-20020a170906684100b007c0f90a9cc5sm2140091ejs.105.2022.12.23.21.35.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Dec 2022 21:35:36 -0800 (PST)
Date: Sat, 24 Dec 2022 00:35:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] virtio,vhost,vdpa: features, fixes, cleanups
Message-ID: <20221224003445-mutt-send-email-mst@kernel.org>
References: <20221222144343-mutt-send-email-mst@kernel.org>
 <CAHk-=wi6Gkr7hJz20+xD=pBuTrseccVgNR9ajU7=Bqbrdk1t4g@mail.gmail.com>
 <20221223172549-mutt-send-email-mst@kernel.org>
 <CAHk-=whpdP7X+L8RtGsonthr7Ffug=FhR+TrFe3JUyb5-zaYCA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=whpdP7X+L8RtGsonthr7Ffug=FhR+TrFe3JUyb5-zaYCA@mail.gmail.com>
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

On Fri, Dec 23, 2022 at 02:36:46PM -0800, Linus Torvalds wrote:
> On Fri, Dec 23, 2022 at 2:27 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > They were all there, just not as these commits, as I squashed fixups to
> > avoid bisect breakages with some configs. Did I do wrong?
> 
> I am literally looking at the next-20221214 state right now, doing
> 
>     git log linus/master.. -- drivers/vhost/vsock.c
>     git log linus/master.. -- drivers/vdpa/mlx5/
>     git log --grep="temporary variable type tweak"
> 
> and seeing nothing.
> 
> So none of these commits - in *any* form - were in linux-next last
> week as far as I can tell.
> 
>              Linus


They were in  next-20221220 though.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
