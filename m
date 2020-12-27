Return-Path: <SRS0=FCrO=F7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C5FC433DB
	for <virtualization@archiver.kernel.org>; Sun, 27 Dec 2020 16:15:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E79B6207CF
	for <virtualization@archiver.kernel.org>; Sun, 27 Dec 2020 16:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79B6207CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 672578700D;
	Sun, 27 Dec 2020 16:15:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 898bkVsAAVFd; Sun, 27 Dec 2020 16:15:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A391186D7A;
	Sun, 27 Dec 2020 16:15:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FC72C0893;
	Sun, 27 Dec 2020 16:15:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91706C0891
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 16:15:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 80121204A9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 16:15:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7FGdobFbIPcO
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 16:15:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com
 [209.85.222.48])
 by silver.osuosl.org (Postfix) with ESMTPS id 1BEDD2048D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 16:15:16 +0000 (UTC)
Received: by mail-ua1-f48.google.com with SMTP id y21so2657365uag.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 08:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ugCtwc9jOsjvCYwPqmUtpkMD0fT1gDohpp6pZ42Mgkc=;
 b=DxZFHYJxRaC3jfLqloT4l/55ndD2c1UNNfOoLVeex/3ztD/ITXxR1bs8Ptkqu9ulw/
 t1EZ0IbUj8yxhZEuS3VDTu5l5axtkWnTY3Dqdbhc5Wa/ufbT27oMyM1mYCTa0PIIzfkp
 v1GEo6oIO0CBhg0Mpea4A1/viMJfmhFp5n/KhLZ9P4+ZYziNiv2VKDvP2iJFeXR+BB/o
 /JdSsAXg9nO8dDTxWm+qErgEbh5QQI/tjzRdwU/YdvojO4e89iwLq+Mwcw3IIEO03z3S
 R9DdWnO65IzyXM9Lv9yn9P5nDUON4YzyXPe+JwjAgJVkxYSeDRZQCDhKdUdY3RIpzR47
 I0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ugCtwc9jOsjvCYwPqmUtpkMD0fT1gDohpp6pZ42Mgkc=;
 b=sRTIBz7zFizHuiV8tRnGfpGf0cBjBsHdralWY2Lo+LHItqR3kD5tgU0O/b6i5BVa4a
 DB0SquR+3EDol6Z/jeP43bNWdXS/Zf8ugkHt+IDfm4qtDX5zWr524rC5zYGBCIr6QW6j
 i9PbAdNhFp++sRxnbUwxikyOUsHnjTL/6Q4j/nOvajQi95w56rauXJMKTv4INeDyMj/h
 Fte7OINzOxkhADmJ6NUb6VOjejRJI7dqwvhP5NSZvJvnoEUCa9n3clpLHdsPNP5QxssW
 9zGolbO4z4F6eK1nAK8jx3z2cF8KS0B0Pr3jZZcfDQxHFNkxwHyOH+mea9GigvxcBFYG
 Vb4w==
X-Gm-Message-State: AOAM5318CYft8wVMeCh1JFngWfrp/uSe2XZyJ2h4czfMGvHxVZYkd8sF
 VwQHanM1vmqbaXcmProaw7y7aup2K1w=
X-Google-Smtp-Source: ABdhPJwav+/xeFcLVm/s3AhqZMknfviz1u+++zR7ThBKGSqzkNTr42l2H1BYlzLqLLSaMJv0YrV5eQ==
X-Received: by 2002:ab0:13eb:: with SMTP id n40mr26912437uae.43.1609085714181; 
 Sun, 27 Dec 2020 08:15:14 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com.
 [209.85.222.46])
 by smtp.gmail.com with ESMTPSA id k4sm4124254vsk.5.2020.12.27.08.15.13
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Dec 2020 08:15:13 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id w7so2639355uap.13
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 08:15:13 -0800 (PST)
X-Received: by 2002:ab0:2:: with SMTP id 2mr15371239uai.108.1609085712576;
 Sun, 27 Dec 2020 08:15:12 -0800 (PST)
MIME-Version: 1.0
References: <1608881065-7572-1-git-send-email-wangyunjian@huawei.com>
 <20201227062220-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201227062220-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sun, 27 Dec 2020 11:14:35 -0500
X-Gmail-Original-Message-ID: <CA+FuTScnt=jVt2+sagtYUXxTrc7RieKc=YyCdp+0zuS9jCiNuA@mail.gmail.com>
Message-ID: <CA+FuTScnt=jVt2+sagtYUXxTrc7RieKc=YyCdp+0zuS9jCiNuA@mail.gmail.com>
Subject: Re: [PATCH net v5 1/2] vhost_net: fix ubuf refcount incorrectly when
 sendmsg fails
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Network Development <netdev@vger.kernel.org>,
 wangyunjian <wangyunjian@huawei.com>,
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

On Sun, Dec 27, 2020 at 6:26 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Dec 25, 2020 at 03:24:25PM +0800, wangyunjian wrote:
> > From: Yunjian Wang <wangyunjian@huawei.com>
> >
> > Currently the vhost_zerocopy_callback() maybe be called to decrease
> > the refcount when sendmsg fails in tun. The error handling in vhost
> > handle_tx_zerocopy() will try to decrease the same refcount again.
> > This is wrong. To fix this issue, we only call vhost_net_ubuf_put()
> > when vq->heads[nvq->desc].len == VHOST_DMA_IN_PROGRESS.
> >
> > Fixes: 0690899b4d45 ("tun: experimental zero copy tx support")
>
> Are you sure about this tag? the patch in question only affects
> tun, while the fix only affects vhost.

That was my suggestion. But you're right. Perhaps better:

Fixes: bab632d69ee4 ("vhost: vhost TX zero-copy support")

That introduces the actual block that releases the buffer on error:

"
                err = sock->ops->sendmsg(NULL, sock, &msg, len);
                if (unlikely(err < 0)) {
+                       if (zcopy) {
+                               if (ubufs)
+                                       vhost_ubuf_put(ubufs);
+                               vq->upend_idx = ((unsigned)vq->upend_idx - 1) %
+                                       UIO_MAXIOV;
+                       }
"
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
