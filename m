Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3448BC43217
	for <virtualization@archiver.kernel.org>; Thu, 24 Nov 2022 22:03:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A82B1404EB;
	Thu, 24 Nov 2022 22:03:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A82B1404EB
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=NKmZCbcF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JsVhwIp1dfY6; Thu, 24 Nov 2022 22:03:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D46C1403EC;
	Thu, 24 Nov 2022 22:03:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D46C1403EC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98864C0033;
	Thu, 24 Nov 2022 22:03:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60FEDC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 22:03:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2164482259
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 22:03:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2164482259
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=NKmZCbcF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IUbdm-NDtPyj
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 22:03:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 73D1882257
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 73D1882257
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 22:03:23 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 a7-20020a056830008700b0066c82848060so1629107oto.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 14:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r7fmJxVpycgNcUBud6bDQI9KWqc9ZhDcYIayEMy39qA=;
 b=NKmZCbcFgxsgCNwCQGq0TB2oHsJBs4ViH/Kjbya2ZPVgN7A57KzUJOUnvF/XRbV5cI
 K2YLOBP7LLttW1dgKlltolEkMuWsgBsB3TCqV3H/0I6S4J8R1Q7D6H8idIgcaSakmfNz
 7j0nSjdGcbXG+Ljk1kOGLs24UChHW9AWBRBtL8jPEX2URF6ckA5La2oD9He2diUX9Ggu
 LPjMrXEXiwpZt6aY5OGH7yZ7LkywNw8N18GeHRNg/TF+xX/3C7eAf2BrMzDdPNgqC6cH
 9D+WEY6u2VBOHWnaVQXxrjHRvw0SHk651Vkm159sN6CIlCeSSQOj5dJYRrk85+mUjmSg
 mvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r7fmJxVpycgNcUBud6bDQI9KWqc9ZhDcYIayEMy39qA=;
 b=1Q5UJcaPHWwd0DqsTUUapTDwDBaaOAzJI8aaJOFfTvm5WN7RfZrT00YECPpWBgZTxk
 gHPh9VizTrJoZliZEKFrp8IwMvWfeTGBcX7XfISTQ4D1l4OQRNY/sMqBKITICLEGJfdu
 7PBGP9XEGGGSxebyr1kcM68tQivQje0gKsFdO6yXi1mntddvQmtGUm479478UMf1Y1Kn
 aRt2ecvMnWB8rMBjm2euh/o5096+MI5tA+YlUcGyRknFpYFZxn4IHYgtytUVfcK4SoUb
 mRB1saFUSJpOn19opG73rWymVUwN+NWzQCXbiktMmfg7j+cLRzqMZJ0ynrP+1PMWh3+d
 tKYg==
X-Gm-Message-State: ANoB5pmQQwrmfYt5Ol1IUDEy6Glz7fWtkeRWpEFpKGak/9JflUSuiJ3n
 Y1oquahbe+A+J2yO633DKYzwd1usxFpMoyj1JF2JUw==
X-Google-Smtp-Source: AA0mqf7DbHHtXgRyz5e1cF0kF6QsUxlGigejUaYOCpvGTmT+e8HrUiFeK4L3Rz/WFMSpSYtAx34w8I/z1Lx3/Gn/IQo=
X-Received: by 2002:a9d:5d04:0:b0:66b:85b7:ac37 with SMTP id
 b4-20020a9d5d04000000b0066b85b7ac37mr10378413oti.363.1669327402427; Thu, 24
 Nov 2022 14:03:22 -0800 (PST)
MIME-Version: 1.0
References: <20221121085923.2717501-1-alvaro.karsz@solid-run.com>
 <1bd1c77e-d8c3-b04a-4fbc-bbc85391e630@nvidia.com>
 <20221124013830-mutt-send-email-mst@kernel.org>
 <Y3/WXWoV1jcJnohR@fedora>
In-Reply-To: <Y3/WXWoV1jcJnohR@fedora>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Fri, 25 Nov 2022 00:02:45 +0200
Message-ID: <CAJs=3_An8uCfAAek4ga-NkQ4dAgsFN1TSL5goi5Y59m_Goojww@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

Thanks Stefan

> How about naming it VBLK_GET_LIFETIME? It's clearer what the ioctl does
> and it follows the name of virtio-blk request type.

You're right, I'll rename it.

> ENOTTY already has meaning for ioctl(2):
>
>
>   ENOTTY fd is not associated with a character special device.
>
>
>   ENOTTY The specified request does not apply to the kind of object that the file descriptor fd references.
>
>
> Use ENOTSUP instead?

 ENOTSUP seems like a better fit, I'll change the error code.

> In terms of security, any process with access to the block device node
> is allowed to get the lifetime?
>
>
> Usually only privileged processes have access to block device nodes, but
> I wanted to check whether anyone can think of a scenario where this is
> not okay.
>
>
> For example, a virtio-blk device may have a partition that an untrusted
> process like a database or key-value store accesses. Can the untrusted
> process read the lifetime information of the entire device?


I agree that only a privileged process should be able to read the lifetime.
I could add something like:
if (!capable(CAP_SYS_ADMIN))
        return -EPERM;

> It's unusual for an ioctl to produce a struct that's not in CPU
> endianness. I think the kernel should deal with endianness here.

The endianness was discussed in the first version:

> > After more thought, I think that the driver should handle the
> > virtio_blk_lifetime struct endianness.
> > Something like:
> > ...
> > lifetime.pre_eol_info = __le16_to_cpu(lifetime.pre_eol_info);
> > lifetime. device_lifetime_est_typ_a  = __le16_to_cpu(lifetime.
> > device_lifetime_est_typ_a);
> > lifetime. device_lifetime_est_typ_b  = __le16_to_cpu(lifetime.
> > device_lifetime_est_typ_b);
> >
> > if (copy_to_user((void __user *)arg, (void *)&lifetime,
> > ...
> >
> > What do you think?
>
>
> I think if you are going to pass struct virtio_blk_lifetime to
> userspace, better pass it as defined in the spec, in LE format.


I tend to agree that endianness should be taken care of in the kernel.

> We need to check that vblk->vdev is non-NULL before accessing it in
> virtblk_ioctl_lifetime():
>
>
>   if (!vblk->vdev) {
>       mutex_unlock(&vblk->dev_mutex);
>       return -ENXIO;
>   }
>
>
> Without the check I expect virtblk_ioctl_lifetime() to dereference a
> NULL pointer.

Right

Alvaro
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
