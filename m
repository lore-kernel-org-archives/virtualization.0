Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2433CC4332F
	for <virtualization@archiver.kernel.org>; Wed, 14 Dec 2022 06:07:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D05F4175B;
	Wed, 14 Dec 2022 06:07:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9D05F4175B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ov8y7Udp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dbfiFFueT7AD; Wed, 14 Dec 2022 06:07:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D23B841734;
	Wed, 14 Dec 2022 06:07:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D23B841734
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACE0FC0033;
	Wed, 14 Dec 2022 06:07:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14245C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 06:07:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DB5BE81EE9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 06:07:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DB5BE81EE9
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ov8y7Udp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UkGYaCaU1a-I
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 06:07:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8B15181EBB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8B15181EBB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 06:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670998053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dYXLJoN5dP9NW2lg01y5/yjuzNPbyCS4n0VoKBGjJPU=;
 b=Ov8y7UdpG001APONdyViiUz+zNbuOnV1Zn3sTBnuXHrUOHY8YHWECJhWwYBJ2kYuWJ9YhD
 JKo3XSZZvm7SFaNehYS//32zEzh7W7nTqcu4QnMRJSrbr1/lsf0j7vJ/FTgyuloNdfF8Ym
 fqD4H5ezmLZwUwlI1eXRB67ZwVm/Od8=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-626-nqKMvVXhOfOjH74W9KvToA-1; Wed, 14 Dec 2022 01:07:31 -0500
X-MC-Unique: nqKMvVXhOfOjH74W9KvToA-1
Received: by mail-oo1-f70.google.com with SMTP id
 f11-20020a4a920b000000b004a09a9f7095so6047558ooh.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 22:07:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dYXLJoN5dP9NW2lg01y5/yjuzNPbyCS4n0VoKBGjJPU=;
 b=6A5tZPvNv0hYabRlelBQojOXphdhJ11YZ5lMaVdLVkX+4RSnxNz1TGFQDIees8hRvq
 lY/HDd+AyZLQPIEj2JK3mmGwcLdEQUUY32xNojwqLa/eL+/mOtBcSIErIngngh8b3edO
 2KMP7bBslYWw5PxaeyPk5TVsjlkb3ECjbFTISgaT8Rks7QjLxVyL17fwwrYzjGPC6pFD
 Nhlj/1m3TQYSHvuBQ1eUaxevz/bXRcWLwsjTaGeucNp6K4kbvB7t/sXdODMtVnaTutpR
 6UdnY+c2ctuMhJhcbaEAYMR5E4DzP7cAekLFtN9ptSAvQHMgIXQFe/eKy4d7zbPfHmQG
 Cg1w==
X-Gm-Message-State: AFqh2kqUp+FT0yaa1q3rJYlsrAUJPXt0O+w0K9tKmlNbaMl/LXGxaY5O
 0EaHLvp2VE3ZcDHtyFvXVbt3v/Ual6iG3onfb4MI4sLtwboqrOcay9RitKUT0jeCLBgbfO3Qjn5
 SHkb5Hdrod5v+RuUEz870hUF1dDUZ0CSNTpES5XEquJ4ZrxIpYL2KuPqcAw==
X-Received: by 2002:a05:6870:bb1a:b0:144:b22a:38d3 with SMTP id
 nw26-20020a056870bb1a00b00144b22a38d3mr120383oab.280.1670998051129; 
 Tue, 13 Dec 2022 22:07:31 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtd2jYdwaV4dxEOpTRHj2thmSUZZrgKIt6DRY5YGFqRfCpKAe9rId2osrQITeJMjFJGSD4lh8eHuJwUYDnMBSg=
X-Received: by 2002:a05:6870:bb1a:b0:144:b22a:38d3 with SMTP id
 nw26-20020a056870bb1a00b00144b22a38d3mr120378oab.280.1670998050902; Tue, 13
 Dec 2022 22:07:30 -0800 (PST)
MIME-Version: 1.0
References: <20221214054306.24145-1-lulu@redhat.com>
In-Reply-To: <20221214054306.24145-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 14 Dec 2022 14:07:19 +0800
Message-ID: <CACGkMEuLnCqzKF+_P1Z-iaTiQkiz5U-Ovekyw94WMPaug76Adg@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim_net: should not drop the multicast/broadcast
 packet
To: Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

On Wed, Dec 14, 2022 at 1:43 PM Cindy Lu <lulu@redhat.com> wrote:
>
> In the receive_filter(), should not drop the packet with the
> broadcast/multicast address. Add the check for this
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> index c3cb225ea469..0f4739c31eea 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -62,6 +62,9 @@ static bool receive_filter(struct vdpasim *vdpasim, size_t len)
>         if (len < ETH_ALEN + hdr_len)
>                 return false;
>
> +       if (is_broadcast_ether_addr(vdpasim->buffer + hdr_len) ||
> +           is_multicast_ether_addr(vdpasim->buffer + hdr_len))
> +               return true;
>         if (!strncmp(vdpasim->buffer + hdr_len, vio_config->mac, ETH_ALEN))
>                 return true;
>
> --
> 2.34.3
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
