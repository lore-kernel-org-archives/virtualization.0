Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B03C433EF
	for <virtualization@archiver.kernel.org>; Thu, 23 Jun 2022 03:55:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56F20846C8;
	Thu, 23 Jun 2022 03:55:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 56F20846C8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZZZALthz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NR3I8CYIfPka; Thu, 23 Jun 2022 03:55:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E7E2384621;
	Thu, 23 Jun 2022 03:55:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7E2384621
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B68ADC0032;
	Thu, 23 Jun 2022 03:55:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D559FC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 03:55:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A638C84608
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 03:55:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A638C84608
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qFnngylBNkl3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 03:55:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AA07E84605
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AA07E84605
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 03:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655956504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7r6qmkZmyFSR/QZW2a5u/i7ubHA3ZPKofanFmUp6yzI=;
 b=ZZZALthzClg5hfQdPBIOWRdi8c3cCzxaoCjGU4mbumLOqUBHg2F7YiCyJ+Y6b1n8X8Nz7K
 y6BBqd/QUN9PQOw5JkYoHebD2tezIB/XQ237hlxIMZNvtoiSU3WBhU9zABppaJUVBVub1j
 SL2HSW9BmYxQN7lKrsn9BjjeBoAffh4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-Qg6JvVF1O1GLJz83BRuYCA-1; Wed, 22 Jun 2022 23:55:03 -0400
X-MC-Unique: Qg6JvVF1O1GLJz83BRuYCA-1
Received: by mail-lf1-f70.google.com with SMTP id
 bq4-20020a056512150400b0047f7f36efc6so3367762lfb.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 20:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7r6qmkZmyFSR/QZW2a5u/i7ubHA3ZPKofanFmUp6yzI=;
 b=luJ42hMI85NkaFfHYNhunDcrOCKa1alL1Rk2JSMTeIGL5t4/WHDuZbAlUcSsPtjBnc
 0tyz6HdWvbrMXuUktrPtyJ4fdzc34BphVi58SAcM/3v1Y1EGb+AgZmPWa9kz8nzj6wF0
 jrlWrafZzgVA/FTVKs+GuU7WCl1ADWznzf0zYvw86C4j5GjDCDRmqZMfRdixR0zCuKRo
 f5UMUi+URNfA3fjqzPBO7MxENZQwia7dJxqAkwcboFt2vTUjC6Gq2WYoI5jRwlUBXSpZ
 zOjAYdqSWFQXo5cVY6lW8iLHNHO54nGN2naYp1vjm9yAT9SfHjkO2tKWCveY/nSnnvm0
 27VA==
X-Gm-Message-State: AJIora/rtBAzemJuKtDO3zZSnoGNzNvrhPiq9OQYnjSUTXrgITsJM8Ty
 znliuwKyh5wHQuPwpr/T9cmACuyIM2LlLx+6FNk2AV7UbBWro8GxtWJgFb48KyGYtA6FCzqziJU
 6OkySI2EoO40JFXu92LVKDZM7K1mSvgelRXVeIQgihINkipR4WQNII4GVCg==
X-Received: by 2002:a2e:8958:0:b0:25a:852a:c302 with SMTP id
 b24-20020a2e8958000000b0025a852ac302mr3663579ljk.130.1655956501262; 
 Wed, 22 Jun 2022 20:55:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vrF3BW4ecp7uMp7ixhwZNP6zrC/7mtr9RBqWZSr7h7Xd5f5VroJYLw4ej6faDfjvvTZLb0DpnhA3R+kdmS/XI=
X-Received: by 2002:a2e:8958:0:b0:25a:852a:c302 with SMTP id
 b24-20020a2e8958000000b0025a852ac302mr3663568ljk.130.1655956501094; Wed, 22
 Jun 2022 20:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220622151407.51232-1-sgarzare@redhat.com>
In-Reply-To: <20220622151407.51232-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Jun 2022 11:54:50 +0800
Message-ID: <CACGkMEsW7OAWHZvD6rjGtCE6t3BmEvpz=PmQvbHh1hMq-6RwhA@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: call vhost_vdpa_cleanup during the release
To: Stefano Garzarella <sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Gautam Dawar <gautam.dawar@xilinx.com>
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

On Wed, Jun 22, 2022 at 11:14 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> Before commit 3d5698793897 ("vhost-vdpa: introduce asid based IOTLB")
> we call vhost_vdpa_iotlb_free() during the release to clean all regions
> mapped in the iotlb.
>
> That commit removed vhost_vdpa_iotlb_free() and added vhost_vdpa_cleanup()
> to do some cleanup, including deleting all mappings, but we forgot to call
> it in vhost_vdpa_release().
>
> This causes that if an application does not remove all mappings explicitly
> (or it crashes), the mappings remain in the iotlb and subsequent
> applications may fail if they map the same addresses.
>
> Calling vhost_vdpa_cleanup() also fixes a memory leak since we are not
> freeing `v->vdev.vqs` during the release from the same commit.
>
> Since vhost_vdpa_cleanup() calls vhost_dev_cleanup() we can remove its
> call from vhost_vdpa_release().
>
> Fixes: 3d5698793897 ("vhost-vdpa: introduce asid based IOTLB")
> Cc: gautam.dawar@xilinx.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vhost/vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 5ad2596c6e8a..23dcbfdfa13b 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1209,7 +1209,7 @@ static int vhost_vdpa_release(struct inode *inode, struct file *filep)
>         vhost_dev_stop(&v->vdev);
>         vhost_vdpa_free_domain(v);
>         vhost_vdpa_config_put(v);
> -       vhost_dev_cleanup(&v->vdev);
> +       vhost_vdpa_cleanup(v);
>         mutex_unlock(&d->mutex);
>
>         atomic_dec(&v->opened);
> --
> 2.36.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
