Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B99C433F5
	for <virtualization@archiver.kernel.org>; Mon, 21 Feb 2022 07:56:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5776960B99;
	Mon, 21 Feb 2022 07:56:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OlVjfj3JEads; Mon, 21 Feb 2022 07:56:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F2AE160B44;
	Mon, 21 Feb 2022 07:56:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9D27C0033;
	Mon, 21 Feb 2022 07:56:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D1EDC001A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 07:56:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2D44181443
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 07:56:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h0xhT2OPfDEq
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 07:56:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1527F81442
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 07:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645430204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iBw4eca/2ri514KH6J7gRLjfIuFxkyB+uZbTAnGGOyY=;
 b=TkYnFPO4IkSEcrI69mwUK7HsGjVLHdFoJzzzHS3eIrkcdNilb+AiAmtTJk2a0GR6S4JY6M
 olb0XwVo4pBGTfFxF+hMOZbMunq2GOyU5mHI7fYmp/w684U7J3wImm1HuMv3FtXEL+Gqxv
 bvkD9czQLdK9gxHBFP9upFARhJx0MZU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-Tto5fJNsPcyw8BtEqCwXwQ-1; Mon, 21 Feb 2022 02:56:43 -0500
X-MC-Unique: Tto5fJNsPcyw8BtEqCwXwQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 w42-20020a0565120b2a00b00432f6a227e0so2338714lfu.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Feb 2022 23:56:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iBw4eca/2ri514KH6J7gRLjfIuFxkyB+uZbTAnGGOyY=;
 b=oEqLnn+ZkOGWArpDZB1J0MVPwLyIQ2PtvMIvxUxqAwbZO4fMsplOfjovXTyP5QuP3Z
 Bz6pYOb8pSQIQUhjRfKYAqW9vqtpx3gJKi8aZeLtpouUYyT7oZI02HJ9w+kNsnPs8WiY
 P9C9HsG9KyaIw+Kj+FXZh9tP7pM74TQmL+trRgWugzK+N8FsXPihhCW6tyII20NpB3qg
 NKTQYkps4PZbSuiTF3EvnL79RV2jUsUV3G23lOgj4GvOjMXDa287PvN1AoUGrGzY0jeE
 z/IU5BvgGLe+duPWe7zwBqFnpZHtUFhr4J8H8r07lXwZ9yilAedkxVL4YWF6fAVLQ8vy
 m6XA==
X-Gm-Message-State: AOAM530iG4cn6HeB5Ko0o9p0tOq6tZQDyBaQ0vpZR3XJmEW0dbVv6o39
 ty9Ldw1g5IVhjaraCsjgvYdXe5QpkFZsv8p75CEIHkeJGWie7shjWSb8s48zW/hFiQ09l3J4ELC
 RTlPyKxEoR+je6qPm7vbZwv12sqZQs6HbSuccKyU+rhg6hZSCmgRL0nzs3w==
X-Received: by 2002:a2e:bd03:0:b0:244:d446:27dc with SMTP id
 n3-20020a2ebd03000000b00244d44627dcmr13556128ljq.307.1645430201630; 
 Sun, 20 Feb 2022 23:56:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfI65mgIz4pkVVi5lbHZtWOT6Zpk1e/JWrK+zV9T5uVl8cjvGGwGWi+coH2R6hx6x7Zhb4LSm68t8Y7Edr3rE=
X-Received: by 2002:a2e:bd03:0:b0:244:d446:27dc with SMTP id
 n3-20020a2ebd03000000b00244d44627dcmr13556119ljq.307.1645430201411; Sun, 20
 Feb 2022 23:56:41 -0800 (PST)
MIME-Version: 1.0
References: <20220221072852.31820-1-mail@anirudhrb.com>
In-Reply-To: <20220221072852.31820-1-mail@anirudhrb.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Feb 2022 15:56:29 +0800
Message-ID: <CACGkMEs6HLM3ok29rm4u=Tq2preno_60Z6cvKw2T7=nak2yzkQ@mail.gmail.com>
Subject: Re: [PATCH] vhost: handle zero regions in vhost_set_memory
To: Anirudh Rayabharam <mail@anirudhrb.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com
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

On Mon, Feb 21, 2022 at 3:45 PM Anirudh Rayabharam <mail@anirudhrb.com> wrote:
>
> Return early when userspace sends zero regions in the VHOST_SET_MEM_TABLE
> ioctl.
>
> Otherwise, this causes an erroneous entry to be added to the iotlb. This
> entry has a range size of 0 (due to u64 overflow). This then causes
> iotlb_access_ok() to loop indefinitely resulting in a hung thread.
> Syzbot has reported this here:

Interesting, I think iotlb_access_ok() won't be called for memory
table entries, or anything I missed?

(If this is not true, we need a kernel patch as well).

Thanks

>
> https://syzkaller.appspot.com/bug?extid=0abd373e2e50d704db87
>
> Reported-and-tested-by: syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com
> Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> ---
>  drivers/vhost/vhost.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 59edb5a1ffe2..821aba60eac2 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1428,6 +1428,8 @@ static long vhost_set_memory(struct vhost_dev *d, struct vhost_memory __user *m)
>                 return -EFAULT;
>         if (mem.padding)
>                 return -EOPNOTSUPP;
> +       if (mem.nregions == 0)
> +               return 0;
>         if (mem.nregions > max_mem_regions)
>                 return -E2BIG;
>         newmem = kvzalloc(struct_size(newmem, regions, mem.nregions),
> --
> 2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
