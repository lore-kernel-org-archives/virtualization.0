Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B71C54EBD
	for <virtualization@archiver.kernel.org>; Mon,  9 Jan 2023 09:00:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 852E881764;
	Mon,  9 Jan 2023 09:00:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 852E881764
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GL5T2hJA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MV_lM6loP1i2; Mon,  9 Jan 2023 09:00:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 367068145C;
	Mon,  9 Jan 2023 09:00:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 367068145C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11AE9C0033;
	Mon,  9 Jan 2023 09:00:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBEB9C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Jan 2023 09:00:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 96BD460C16
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Jan 2023 09:00:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 96BD460C16
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GL5T2hJA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hJ38ZNniqazk
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Jan 2023 09:00:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5E82C6077D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5E82C6077D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Jan 2023 09:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673254831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ciW9YYwTiwLOjY3s3cXAhwyZejxqMBoqkbNB9AuORqI=;
 b=GL5T2hJAMT6tm6J4LtCbIY1Dt8j3X9QpqEqscvLNPpc7sMyaUpC7oYPknKpLF8NdvvO/nM
 Chjfws+BNsFqCUoHfl6vuy7W6L/ZV4c65LpYPfSKqQq+b2ExLZO25KBDwCCRjt69yC2Zs+
 9R5Svk6rT/W7od4ArDGhVxIvjosMdBc=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-593-TWtp7Di2Pw-A1tpsbZvMoQ-1; Mon, 09 Jan 2023 04:00:29 -0500
X-MC-Unique: TWtp7Di2Pw-A1tpsbZvMoQ-1
Received: by mail-ot1-f72.google.com with SMTP id
 u11-20020a9d4d8b000000b006782ebb9bf5so4162541otk.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Jan 2023 01:00:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ciW9YYwTiwLOjY3s3cXAhwyZejxqMBoqkbNB9AuORqI=;
 b=mdIy2AWZYZ/T/I+yfjBTGOABkLu4fL9Mc9j2Go8nnzc+ec4AuvwBh4IAAPX/p0eI0Z
 rST0C05z2oF/oAadt3AlFiYn9BeYREL8yr96yRQwfSA0vOo2BxDIhMdaWGqPE8OjqkDm
 Rj26qqDaRVgJr42WbinbU84pVGbXbC9VrJiBjZdSSOh4YgTgErjvCkNtbuf8rXiXbm5p
 P8PcLVX6Vbq2dGeT7Eny7fHlPQXGvBVAAPVyYWOzjOE7Uz7gniTpJC0bFM+SLEYpg9v/
 mYgw34Ewyv2TyoT2cy4AEsSbVdtImaTTz0RRhz+5WhXLk8OClZ3jxm93u+mGMb60QJQE
 0PXQ==
X-Gm-Message-State: AFqh2kqRxCxU5Da8rpD3O5bOy/aQxlGRbe2vn4c/7thRMUcqMCZlueM0
 IEUkz1kKaXH5UiE3uN7M3jcdHRvz8l4KDBNQz86p+P+UsKlMhnzOBT6tkNOfQkIBUUACbNXVkeR
 CsNSkqvjRgfF0wavRpaU8uDhkbfe0oPnAtGPwXti8PaYWe3/Zl4rydvQQhw==
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr3397922oah.35.1673254829175; 
 Mon, 09 Jan 2023 01:00:29 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs3r6xZeYmx2QyOOAm/OSF4k+rcH2P78FK/uye9bebpGs3wKFdyeXk7nf1guSipnglxm3zqQ43faxDfLHs0f1A=
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr3397915oah.35.1673254828989; Mon, 09
 Jan 2023 01:00:28 -0800 (PST)
MIME-Version: 1.0
References: <20230105070357.274-1-liming.wu@jaguarmicro.com>
In-Reply-To: <20230105070357.274-1-liming.wu@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Jan 2023 17:00:17 +0800
Message-ID: <CACGkMEtOAiV4v=-d1SA-wAVvD2WJyes3wWghpAJ9q0baG_aKGg@mail.gmail.com>
Subject: Re: [PATCH] vhost-test: remove meaningless debug info
To: liming.wu@jaguarmicro.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: 398776277@qq.com, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
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

On Thu, Jan 5, 2023 at 3:04 PM <liming.wu@jaguarmicro.com> wrote:
>
> From: Liming Wu <liming.wu@jaguarmicro.com>
>
> remove printk as it is meaningless.
>
> Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vhost/test.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> index bc8e7fb1e635..42c955a5b211 100644
> --- a/drivers/vhost/test.c
> +++ b/drivers/vhost/test.c
> @@ -333,13 +333,10 @@ static long vhost_test_ioctl(struct file *f, unsigned int ioctl,
>                         return -EFAULT;
>                 return 0;
>         case VHOST_SET_FEATURES:
> -               printk(KERN_ERR "1\n");
>                 if (copy_from_user(&features, featurep, sizeof features))
>                         return -EFAULT;
> -               printk(KERN_ERR "2\n");
>                 if (features & ~VHOST_FEATURES)
>                         return -EOPNOTSUPP;
> -               printk(KERN_ERR "3\n");
>                 return vhost_test_set_features(n, features);
>         case VHOST_RESET_OWNER:
>                 return vhost_test_reset_owner(n);
> --
> 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
