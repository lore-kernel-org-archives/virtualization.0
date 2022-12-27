Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63F3C3DA7D
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 06:04:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C83760586;
	Tue, 27 Dec 2022 06:04:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3C83760586
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DqQ5gJ6s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 22vR94Kyf10p; Tue, 27 Dec 2022 06:04:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 91CDC60591;
	Tue, 27 Dec 2022 06:04:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 91CDC60591
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 645FCC0035;
	Tue, 27 Dec 2022 06:04:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38617C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 06:04:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 059FC400D1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 06:04:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 059FC400D1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DqQ5gJ6s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lT0rFDdz2TSU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 06:04:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 02C5D40530
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 02C5D40530
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 06:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672121057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JtwK0TmUyPB3eYskZMtg0oNP152qeukFtzmu8szThS4=;
 b=DqQ5gJ6sIs5GYY/AZHOdgEBHaWkP39q7GptckzO1WSf/WxUV/D4qSaA4x0ljizwVE2xJbz
 aFR+WCXSC90XE6CSwhHG64F/1V47+51EPNtI0M0+dW0xLxVAfLdqS0gJ3UwCnY3SvIDP2K
 EULs09MemSx8UPK6diBI7YiMYpWCeY0=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-287-UodhVtjAPJ6e5-xcyOI16Q-1; Tue, 27 Dec 2022 01:04:15 -0500
X-MC-Unique: UodhVtjAPJ6e5-xcyOI16Q-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-14261bd9123so6046855fac.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 22:04:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JtwK0TmUyPB3eYskZMtg0oNP152qeukFtzmu8szThS4=;
 b=sr+QOoBr8eq5BOX2PlhrIFMPxvyR/Mlzb+Vu23pc+hilaJTfnsxxBDsXA3w1ba4lKu
 9lUFF8bMA4mANYMp9Ywzz9t2n0L5GlHSDRwePjRNQKFYkAISH4UKlCICrVAa74D6pEQD
 lbFVcqL+36k4Te4pooxocDJgUOjEwxYWI8t+3c/Xw1+PQo62HqS3ggFoC57ceG2qqxB2
 162oar4m8iBaGWP08EuqY3muFCTwki3oPmKZpTgimQqDhYBnFtxnkMrCGiv1J47ai+Ga
 2K7PXB8POpmtSuNDHe8O16M8pewHC4bzVCEYC/UaBUxiphVmcDqywtqskOnY2G/lsOwK
 YCiQ==
X-Gm-Message-State: AFqh2kqUljlA0KExTvEQ5EDSpryABFFhOzx1kl7XdnM1V8OW6KsXFS9u
 T2NG5DpEykknd7KPB0zQxb77vSJ6Al7S/aHzlDg07OxhzF57RCbruNgubNe4P5exN+1EIiV5H1z
 0dlvZ2B/u9sVbJJ8tM4ByNU4fVcZIijlZNsQW/TfIX7yiVjDGw/hb2woFyA==
X-Received: by 2002:aca:1111:0:b0:35e:7a42:7ab5 with SMTP id
 17-20020aca1111000000b0035e7a427ab5mr1074628oir.280.1672121054827; 
 Mon, 26 Dec 2022 22:04:14 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtdg06zg3ogBEVD5FhVYBrkQ3mVFEJUcvWP+Qa87KA4giCLeV4ft04uckoxPDm96o/QYr3l3GA1xlty9lfuvl8=
X-Received: by 2002:aca:1111:0:b0:35e:7a42:7ab5 with SMTP id
 17-20020aca1111000000b0035e7a427ab5mr1074622oir.280.1672121054572; Mon, 26
 Dec 2022 22:04:14 -0800 (PST)
MIME-Version: 1.0
References: <20221227022528.609839-1-mie@igel.co.jp>
 <20221227022528.609839-3-mie@igel.co.jp>
In-Reply-To: <20221227022528.609839-3-mie@igel.co.jp>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Dec 2022 14:04:03 +0800
Message-ID: <CACGkMEtAaYpuZtS0gx_m931nFzcvqSNK9BhvUZH_tZXTzjgQCg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] vringh: remove vringh_iov and unite to vringh_kiov
To: Shunsuke Mie <mie@igel.co.jp>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Tue, Dec 27, 2022 at 10:25 AM Shunsuke Mie <mie@igel.co.jp> wrote:
>
> struct vringh_iov is defined to hold userland addresses. However, to use
> common function, __vring_iov, finally the vringh_iov converts to the
> vringh_kiov with simple cast. It includes compile time check code to make
> sure it can be cast correctly.
>
> To simplify the code, this patch removes the struct vringh_iov and unifies
> APIs to struct vringh_kiov.
>
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>

While at this, I wonder if we need to go further, that is, switch to
using an iov iterator instead of a vringh customized one.

Thanks

> ---
>  drivers/vhost/vringh.c | 32 ++++++------------------------
>  include/linux/vringh.h | 45 ++++--------------------------------------
>  2 files changed, 10 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 828c29306565..aa3cd27d2384 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -691,8 +691,8 @@ EXPORT_SYMBOL(vringh_init_user);
>   * calling vringh_iov_cleanup() to release the memory, even on error!
>   */
>  int vringh_getdesc_user(struct vringh *vrh,
> -                       struct vringh_iov *riov,
> -                       struct vringh_iov *wiov,
> +                       struct vringh_kiov *riov,
> +                       struct vringh_kiov *wiov,
>                         bool (*getrange)(struct vringh *vrh,
>                                          u64 addr, struct vringh_range *r),
>                         u16 *head)
> @@ -708,26 +708,6 @@ int vringh_getdesc_user(struct vringh *vrh,
>         if (err == vrh->vring.num)
>                 return 0;
>
> -       /* We need the layouts to be the identical for this to work */
> -       BUILD_BUG_ON(sizeof(struct vringh_kiov) != sizeof(struct vringh_iov));
> -       BUILD_BUG_ON(offsetof(struct vringh_kiov, iov) !=
> -                    offsetof(struct vringh_iov, iov));
> -       BUILD_BUG_ON(offsetof(struct vringh_kiov, i) !=
> -                    offsetof(struct vringh_iov, i));
> -       BUILD_BUG_ON(offsetof(struct vringh_kiov, used) !=
> -                    offsetof(struct vringh_iov, used));
> -       BUILD_BUG_ON(offsetof(struct vringh_kiov, max_num) !=
> -                    offsetof(struct vringh_iov, max_num));
> -       BUILD_BUG_ON(sizeof(struct iovec) != sizeof(struct kvec));
> -       BUILD_BUG_ON(offsetof(struct iovec, iov_base) !=
> -                    offsetof(struct kvec, iov_base));
> -       BUILD_BUG_ON(offsetof(struct iovec, iov_len) !=
> -                    offsetof(struct kvec, iov_len));
> -       BUILD_BUG_ON(sizeof(((struct iovec *)NULL)->iov_base)
> -                    != sizeof(((struct kvec *)NULL)->iov_base));
> -       BUILD_BUG_ON(sizeof(((struct iovec *)NULL)->iov_len)
> -                    != sizeof(((struct kvec *)NULL)->iov_len));
> -
>         *head = err;
>         err = __vringh_iov(vrh, *head, (struct vringh_kiov *)riov,
>                            (struct vringh_kiov *)wiov,
> @@ -740,14 +720,14 @@ int vringh_getdesc_user(struct vringh *vrh,
>  EXPORT_SYMBOL(vringh_getdesc_user);
>
>  /**
> - * vringh_iov_pull_user - copy bytes from vring_iov.
> + * vringh_iov_pull_user - copy bytes from vring_kiov.
>   * @riov: the riov as passed to vringh_getdesc_user() (updated as we consume)
>   * @dst: the place to copy.
>   * @len: the maximum length to copy.
>   *
>   * Returns the bytes copied <= len or a negative errno.
>   */
> -ssize_t vringh_iov_pull_user(struct vringh_iov *riov, void *dst, size_t len)
> +ssize_t vringh_iov_pull_user(struct vringh_kiov *riov, void *dst, size_t len)
>  {
>         return vringh_iov_xfer(NULL, (struct vringh_kiov *)riov,
>                                dst, len, xfer_from_user);
> @@ -755,14 +735,14 @@ ssize_t vringh_iov_pull_user(struct vringh_iov *riov, void *dst, size_t len)
>  EXPORT_SYMBOL(vringh_iov_pull_user);
>
>  /**
> - * vringh_iov_push_user - copy bytes into vring_iov.
> + * vringh_iov_push_user - copy bytes into vring_kiov.
>   * @wiov: the wiov as passed to vringh_getdesc_user() (updated as we consume)
>   * @src: the place to copy from.
>   * @len: the maximum length to copy.
>   *
>   * Returns the bytes copied <= len or a negative errno.
>   */
> -ssize_t vringh_iov_push_user(struct vringh_iov *wiov,
> +ssize_t vringh_iov_push_user(struct vringh_kiov *wiov,
>                              const void *src, size_t len)
>  {
>         return vringh_iov_xfer(NULL, (struct vringh_kiov *)wiov,
> diff --git a/include/linux/vringh.h b/include/linux/vringh.h
> index 1991a02c6431..733d948e8123 100644
> --- a/include/linux/vringh.h
> +++ b/include/linux/vringh.h
> @@ -79,18 +79,6 @@ struct vringh_range {
>         u64 offset;
>  };
>
> -/**
> - * struct vringh_iov - iovec mangler.
> - *
> - * Mangles iovec in place, and restores it.
> - * Remaining data is iov + i, of used - i elements.
> - */
> -struct vringh_iov {
> -       struct iovec *iov;
> -       size_t consumed; /* Within iov[i] */
> -       unsigned i, used, max_num;
> -};
> -
>  /**
>   * struct vringh_kiov - kvec mangler.
>   *
> @@ -113,44 +101,19 @@ int vringh_init_user(struct vringh *vrh, u64 features,
>                      vring_avail_t __user *avail,
>                      vring_used_t __user *used);
>
> -static inline void vringh_iov_init(struct vringh_iov *iov,
> -                                  struct iovec *iovec, unsigned num)
> -{
> -       iov->used = iov->i = 0;
> -       iov->consumed = 0;
> -       iov->max_num = num;
> -       iov->iov = iovec;
> -}
> -
> -static inline void vringh_iov_reset(struct vringh_iov *iov)
> -{
> -       iov->iov[iov->i].iov_len += iov->consumed;
> -       iov->iov[iov->i].iov_base -= iov->consumed;
> -       iov->consumed = 0;
> -       iov->i = 0;
> -}
> -
> -static inline void vringh_iov_cleanup(struct vringh_iov *iov)
> -{
> -       if (iov->max_num & VRINGH_IOV_ALLOCATED)
> -               kfree(iov->iov);
> -       iov->max_num = iov->used = iov->i = iov->consumed = 0;
> -       iov->iov = NULL;
> -}
> -
>  /* Convert a descriptor into iovecs. */
>  int vringh_getdesc_user(struct vringh *vrh,
> -                       struct vringh_iov *riov,
> -                       struct vringh_iov *wiov,
> +                       struct vringh_kiov *riov,
> +                       struct vringh_kiov *wiov,
>                         bool (*getrange)(struct vringh *vrh,
>                                          u64 addr, struct vringh_range *r),
>                         u16 *head);
>
>  /* Copy bytes from readable vsg, consuming it (and incrementing wiov->i). */
> -ssize_t vringh_iov_pull_user(struct vringh_iov *riov, void *dst, size_t len);
> +ssize_t vringh_iov_pull_user(struct vringh_kiov *riov, void *dst, size_t len);
>
>  /* Copy bytes into writable vsg, consuming it (and incrementing wiov->i). */
> -ssize_t vringh_iov_push_user(struct vringh_iov *wiov,
> +ssize_t vringh_iov_push_user(struct vringh_kiov *wiov,
>                              const void *src, size_t len);
>
>  /* Mark a descriptor as used. */
> --
> 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
