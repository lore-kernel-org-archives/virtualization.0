Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FC6C43334
	for <virtualization@archiver.kernel.org>; Sun, 12 Jun 2022 04:11:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B525C83F96;
	Sun, 12 Jun 2022 04:11:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GFf_l32ZWioV; Sun, 12 Jun 2022 04:11:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6CBE683E3B;
	Sun, 12 Jun 2022 04:11:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EF5AC0039;
	Sun, 12 Jun 2022 04:11:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D28D6C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Jun 2022 04:11:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A797883E76
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Jun 2022 04:11:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R0XZXPdaEsx4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Jun 2022 04:11:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9259A83E3B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Jun 2022 04:11:22 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id o7so5155373eja.1
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Jun 2022 21:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZSnySfFVFF1WlkzCsM8N2GrUnx5OLR53QsPe7K3hn/4=;
 b=fAFtXxKAtah80tBf6iqAqB5bsHRSCOqHvagsu0WUhkIfnkkLJ6E+fvFABl1dX0xmKY
 5R4R41LgzbxN32GIYKtRmquaRu9cZJYlpZ9wP16aRfYt2hHgYUkJzm6uq13FvH2Vi5Rh
 Ij8VIVS8uWX7CHjV5oQ9zqSql+oAdfKsZKlkC7ZgOu+wCph54lkwIrTdsitbrrtrhOaT
 y7hwXMaLkHT6TQ8gxK3TKnAsBmTvjfNd4DKeXSwcFV7FB7Ib+QReLTGvWWANz+bZVcL8
 FBk0bGF4f7lYEYsr8CHHLzQlfY9rdgOGxMQEHnHS2ACmAf3EiBrvJJhUzINJ6tWjdZZA
 IHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZSnySfFVFF1WlkzCsM8N2GrUnx5OLR53QsPe7K3hn/4=;
 b=BhQLNo1NfJwF/bD5QFFmJM0SWmS2F7ZTzrVZJicabvqoCya8WU6JKxh512foRpohiA
 lFwz/78GgavcPCPjL2bybP0dnYiMn1yZ5PrWTl2u3MXnOaahxYmMBV/urq0SPd5N8/yr
 AGrqHMlQybweFuNQSv/XiQTIrvK72kA+SomgmaQJkku5Cc4q58y0qkV/sgZ5RagUv2yM
 HVXDFhWoxo8jPi0Igp4GTN7UGQ+FvqDCCm6yQMAPXG7PX24ouQ0hYn+FqbuwYnYV7IVr
 sNUXtM5+oMPKowNqvGDr6/20R/v1K7g+ogpsYjYEFh8B12e9Rm7YUATqEnTtXrEe04a9
 cv/Q==
X-Gm-Message-State: AOAM532EFIK3Qscq4UWPEqWSdaiId5scrE6G7c89xa0fZtt43TuhmrmD
 f04eyw3LZat9oyw0ipvlutFrokdPazx8BoUsK7w=
X-Google-Smtp-Source: ABdhPJzC1phMjHFmG6iCLs810bJS0tkmxtQPRW62lh5ZaTSCky8H7TCW5DuzbjLEndxFENtSnFsPBR+b3jkM58QMp0g=
X-Received: by 2002:a17:906:f51:b0:6fe:cf1c:cdbf with SMTP id
 h17-20020a1709060f5100b006fecf1ccdbfmr46593552ejj.695.1655007080806; Sat, 11
 Jun 2022 21:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220602104223.54527-1-linmq006@gmail.com>
In-Reply-To: <20220602104223.54527-1-linmq006@gmail.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Sat, 11 Jun 2022 21:11:09 -0700
Message-ID: <CAPaKu7She7neKq8c7G1hH4+To=y26dvZ0kP4BfJ4FghFRf+KqA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: Fix NULL vs IS_ERR checking in
 virtio_gpu_object_shmem_init
To: Miaoqian Lin <linmq006@gmail.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>,
 ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
 NET AND BLOCK DRIVERS" <virtualization@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>
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

On Thu, Jun 2, 2022 at 3:42 AM Miaoqian Lin <linmq006@gmail.com> wrote:
>
> Since drm_prime_pages_to_sg() function return error pointers.
> The drm_gem_shmem_get_sg_table() function returns error pointers too.
> Using IS_ERR() to check the return value to fix this.
>
> Fixes: 2f2aa13724d5 ("drm/virtio: move virtio_gpu_mem_entry initialization to new function")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v2:
> - Update Fixes tag.
> - rebase the working tree.
> v1 Link: https://lore.kernel.org/all/20211222072649.18169-1-linmq006@gmail.com/
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
