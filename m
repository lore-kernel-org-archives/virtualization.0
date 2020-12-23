Return-Path: <SRS0=+X4x=F3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5468C433DB
	for <virtualization@archiver.kernel.org>; Wed, 23 Dec 2020 17:06:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 401822229C
	for <virtualization@archiver.kernel.org>; Wed, 23 Dec 2020 17:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401822229C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D49928706A;
	Wed, 23 Dec 2020 17:06:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a9AC8Kus2H5l; Wed, 23 Dec 2020 17:06:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3248687038;
	Wed, 23 Dec 2020 17:06:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14C0DC1787;
	Wed, 23 Dec 2020 17:06:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 949EBC0893
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 17:06:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7C0AA8687A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 17:06:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FfhcCGuyL3CX
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 17:06:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8B92F86846
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 17:06:18 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id j16so16881820edr.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 09:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uqtqep8MBRBnMvoqlrSmq9TH+EkPmSEzHGyxTzebhLQ=;
 b=KTqKohe/TXnxaN/Svnn4kby9voX4gttm0mqyior0aZWCPbzuM89rEjL5KRhG2mYs4p
 e6FRBOQlcdnvJG434mJ4Md8qfJcyU321XsCMv6l+0r45f0sBT1lI8gaJbX+RzodZnQ5R
 jcA03EZZxBzU/L1damoS8mZOHYzRPs1JrHKupFwv78aVD6KwVeVsvPqbwQ5LZIbESBYb
 0XD3m8ePeqIawPew2hwdpPPSv294qu+LkEJl2oeJ3QfBldHZtqOncxS0N2rpBlZd9w9U
 pJpOTKPRHMvUytd1DGLcPsA9gEfA9nSXinX29h2tFpjHud30vYpcHgudpHrSpqMqZYa/
 Y0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uqtqep8MBRBnMvoqlrSmq9TH+EkPmSEzHGyxTzebhLQ=;
 b=jK09+FnFft1yExJvwEdwmGJ18XehCzEIKsxoaZa9uKtJPGXejNq9g+M9OnV1Sfoma1
 1Zqk2lFBlEMUGH4CerW+ze9BOeVKG3xb9/WsHetnBkoTcW+lvMFt0u4a2Gg4mIGs1lzu
 2AgudyG47Ev8+Sp8YpPqqxYfM44xlzzkXRA8VMqHEzVbYTZhpLBfUbU/SiiAiiH5k+fo
 iFKKl8JD7QaER7EOZXwgEu8FjnSKAO+ZtKIgij9iAtkDf7ka/syJHYCNOAlapelpllDX
 CNlnJg6dFpa1RDD37YW7wyPAS3xOdPJ6e4R6Y4WWsikV3EZw90PyQHsOXqbUdvGW0y7+
 kR5Q==
X-Gm-Message-State: AOAM533gvB1HWbJUFs2d7B0LBMzqzbLqGSYveXY12iP9LdnLmSMFkSnT
 +HgBi5jf942bBVL3moUSZU3JL3p0XQEiYK9+XEM=
X-Google-Smtp-Source: ABdhPJwVwS1JuWFuvRUzcl9/I/UR7jRHWd5L/5jdHvD6ja745mMoTitrtSe3P9DvcViaYnz4FeCKY8jzUr0Huj6+86Y=
X-Received: by 2002:a05:6402:1386:: with SMTP id
 b6mr25566353edv.42.1608743177109; 
 Wed, 23 Dec 2020 09:06:17 -0800 (PST)
MIME-Version: 1.0
References: <1608734856-12516-1-git-send-email-wangyunjian@huawei.com>
In-Reply-To: <1608734856-12516-1-git-send-email-wangyunjian@huawei.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 23 Dec 2020 12:05:38 -0500
Message-ID: <CAF=yD-KSm4fTWUZy1F2gFOw-qLmMV76rHmzcr05Upz9WV=SXvg@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] vhost_net: fix tx queue stuck when sendmsg
 fails
To: wangyunjian <wangyunjian@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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

On Wed, Dec 23, 2020 at 9:47 AM wangyunjian <wangyunjian@huawei.com> wrote:
>
> From: Yunjian Wang <wangyunjian@huawei.com>
>
> Currently the driver don't drop a packet which can't be send by tun
>
> (e.g bad packet). In this case, the driver will always process the
> same packet lead to the tx queue stuck.
>
> To fix this issue:
> 1. in the case of persistent failure (e.g bad packet), the driver
> can skip this descriptior by ignoring the error.
> 2. in the case of transient failure (e.g -EAGAIN and -ENOMEM), the
> driver schedules the worker to try again.
>

Fixes: 3a4d5c94e959 ("vhost_net: a kernel-level virtio server")

Since I have a few other comments, a few minor typo corrections too:
don't -> doesn't, send -> sent, descriptior -> descriptor.

> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
>
>  drivers/vhost/net.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index c8784dfafdd7..e49dd64d086a 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -827,9 +827,8 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>                                 msg.msg_flags &= ~MSG_MORE;
>                 }
>
> -               /* TODO: Check specific error and bomb out unless ENOBUFS? */
>                 err = sock->ops->sendmsg(sock, &msg, len);
> -               if (unlikely(err < 0)) {
> +               if (unlikely(err == -EAGAIN || err == -ENOMEM)) {
>                         vhost_discard_vq_desc(vq, 1);
>                         vhost_net_enable_vq(net, vq);
>                         break;
> @@ -922,7 +921,6 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
>                         msg.msg_flags &= ~MSG_MORE;
>                 }
>
> -               /* TODO: Check specific error and bomb out unless ENOBUFS? */
>                 err = sock->ops->sendmsg(sock, &msg, len);
>                 if (unlikely(err < 0)) {
>                         if (zcopy_used) {
> @@ -931,9 +929,11 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
>                                 nvq->upend_idx = ((unsigned)nvq->upend_idx - 1)
>                                         % UIO_MAXIOV;
>                         }
> -                       vhost_discard_vq_desc(vq, 1);
> -                       vhost_net_enable_vq(net, vq);
> -                       break;
> +                       if (err == -EAGAIN || err == -ENOMEM) {
> +                               vhost_discard_vq_desc(vq, 1);
> +                               vhost_net_enable_vq(net, vq);
> +                               break;
> +                       }
>                 }
>                 if (err != len)
>                         pr_debug("Truncated TX packet: "

Probably my bad for feedback in patch 2/2, but now vhost will
incorrectly log bad packets as truncated packets.

This will need to be if (err >= 0 && err != len).

It would be nice if we could notify the guest in the transmit
descriptor when a packet was dropped due to failing integrity checks
(bad packet). But I don't think we easily can, so out of scope for
this fix.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
