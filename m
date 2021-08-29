Return-Path: <SRS0=G2sl=NU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A633C432BE
	for <virtualization@archiver.kernel.org>; Sun, 29 Aug 2021 18:11:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13BF060F36
	for <virtualization@archiver.kernel.org>; Sun, 29 Aug 2021 18:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 13BF060F36
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C122960717;
	Sun, 29 Aug 2021 18:11:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PRDqh7NbtFfs; Sun, 29 Aug 2021 18:11:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6F66960604;
	Sun, 29 Aug 2021 18:11:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B495C0010;
	Sun, 29 Aug 2021 18:11:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C269C000E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Aug 2021 18:11:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 587A3606BE
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Aug 2021 18:11:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9sS2f7Fo2sQ5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Aug 2021 18:11:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3FEB460604
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Aug 2021 18:11:35 +0000 (UTC)
Received: by mail-lj1-x232.google.com with SMTP id c12so21794978ljr.5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Aug 2021 11:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nOEXbomGVxdTg2YIKOufPA0FWw0BA6Ntj3OHAW88ff4=;
 b=G9weGkeHN8FlJqJ0GQMGRkvYxT9+fXAmH0dB17bI65t7LV9Q70hlMMFtwZr4o4zSms
 C3ZBm+mpNRjS+UkmvFIj8dKgUWkyzIyP3SJa7hZUeOvoF9uuwyCa0eKl5/wXl5LDkYvt
 g1hC/0+a5me3A0DEW79RnUqRw17xLL0C1Ysgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nOEXbomGVxdTg2YIKOufPA0FWw0BA6Ntj3OHAW88ff4=;
 b=fMY2Z4FzeyxUuYECyOrzFmSOIC5SfXUW1JHTKcGoafsiiL7fhlRtdPrDT4zA1bcOvk
 fT+OMfqHLgGaitGBTB3ejBwprR52obQ/UG9xCUinXQR+4oImz79MmB+OwYtDwRuZqpKu
 CQ7su1oqHpf5hT7Q6UHqFXfxC32m+K112QV+B/MWL57d97uoeVYHJLogum35EtpSX/pH
 kVAFKQWl9/rVX5DLVVDEecfoQMT/ZkfVsNd9BBucflclUmEXUQOWdvAagY6vwzzwLlol
 OVsKkZfY3wR0wi6J040m2lsrVTvof9vmo87SaX1t2264MKfSIM4RDNjzCFg4R8EEtqaz
 J2Vg==
X-Gm-Message-State: AOAM530h+1nMOAeHkUXf8xC5EBCWarWRYtiXyidicABg5zlYSxsRcJaF
 mC5FYS5sOmbyhW1LCttGbVA+qpOxNNHm/Nx184A=
X-Google-Smtp-Source: ABdhPJwtuLSj5pBqfvRkbvofir5mBKQmfOQb1y9oCafmzra/QN41xYtRUJR5He5COhTOjpx8vC/Pog==
X-Received: by 2002:a05:651c:170b:: with SMTP id
 be11mr16769754ljb.219.1630260692780; 
 Sun, 29 Aug 2021 11:11:32 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com.
 [209.85.208.172])
 by smtp.gmail.com with ESMTPSA id q7sm1536594ljg.137.2021.08.29.11.11.31
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Aug 2021 11:11:31 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id c12so21794891ljr.5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Aug 2021 11:11:31 -0700 (PDT)
X-Received: by 2002:a2e:7d0e:: with SMTP id y14mr17065408ljc.251.1630260691346; 
 Sun, 29 Aug 2021 11:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210829115343-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210829115343-mutt-send-email-mst@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 29 Aug 2021 11:11:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjYkPWoQWZEHXzd3azugRO4MCCEx9dBYKkVJLrk+1gsMg@mail.gmail.com>
Message-ID: <CAHk-=wjYkPWoQWZEHXzd3azugRO4MCCEx9dBYKkVJLrk+1gsMg@mail.gmail.com>
Subject: Re: [GIT PULL] virtio: a last minute fix
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: KVM list <kvm@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Carpenter <dan.carpenter@oracle.com>
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

On Sun, Aug 29, 2021 at 8:53 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Donnu if it's too late - was on vacation and this only arrived
> Wednesday. Seems to be necessary to avoid introducing a regression
> in virtio-mem.

Heh. Not too late for 5.14, but too late in the sense that I had
picked this one up manually already as commit 425bec0032f5
("virtio-mem: fix sleeping in RCU read side section in
virtio_mem_online_page_cb()").

                Linus
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
