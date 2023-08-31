Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07B6C83F29
	for <virtualization@archiver.kernel.org>; Thu, 31 Aug 2023 08:39:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51A7641962;
	Thu, 31 Aug 2023 08:39:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 51A7641962
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MDk2ByIy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bsgr9sQTmO_Y; Thu, 31 Aug 2023 08:39:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6D9364193B;
	Thu, 31 Aug 2023 08:39:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6D9364193B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22089C0039;
	Thu, 31 Aug 2023 08:39:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14A9CC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 08:39:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC18260B69
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 08:39:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC18260B69
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MDk2ByIy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R9lEFpeWQZA9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 08:39:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DE76160B3A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 08:39:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DE76160B3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693471157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4U5OavrGGzIX2SQggveJnFodx3l4/uKCAkVfx0r7+WA=;
 b=MDk2ByIyxx6TI4v1TYSN5lmLpUaoMaxFF7PwPU2ffD9BYZx1GX443luZeomdidZCBMW3O4
 luDqBAFgS4W2nv/gDVaEAmcoCNsbpzQYToCLn1z1RA8h44klDERzXZp+zOK800NVB7QveG
 PkyEOYp7TztNRHGNJLXNijRHTaWNj+I=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-ETkX6fdrOxeB08P6kGCiEA-1; Thu, 31 Aug 2023 04:39:14 -0400
X-MC-Unique: ETkX6fdrOxeB08P6kGCiEA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5219df4e8c4so137554a12.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 01:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693471153; x=1694075953;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4U5OavrGGzIX2SQggveJnFodx3l4/uKCAkVfx0r7+WA=;
 b=OxOoOSTQfRD6lRhg0XLH9OOc9kDbA1aNFbdVTgbfPsZN0nM3WPQKBKdR4KnFSVDBOR
 LAPPNfyXKZ/U5d2RypGHIkSSKn7wTanvqTVzCcrER+z5E8R63rqgJq/9dL4KzeQTCa7V
 /M3tb3Oqw1LZBV4GrQDhDSOTteuhjm75z05GdTjpHzmdA7qGj8fKImmEeu2zSWULLE+V
 nb86q/Nocm281JzfldnUpimk/c4IRBK1HtEdFFlEgP2XjuFCIzCK+pFzMKw9Ew42oqAV
 gkOEiX+MzRjdnp8H4ftcwng8DKGzes+n2fdTUdbBv/Y1attLgc27cfOvRF7Z1BCQPlxW
 umzA==
X-Gm-Message-State: AOJu0YzDWy7OxAK+/W+zHP5WbSKklQF7gKNTRO7xXWdQu98CD9KPWU7o
 M0b2NLOf7QNFEXuvj4P6+cbeOKidd+BpqnqX/DmYiOIumFv03JjmuvwtTB64CBsk6zix7wc9u8J
 pacxSKsuERJKx/jSgMm+0tKljpX1NHZKQ75uHk4qWeg==
X-Received: by 2002:a17:906:1011:b0:9a1:aea8:cb5a with SMTP id
 17-20020a170906101100b009a1aea8cb5amr3100540ejm.1.1693471153153; 
 Thu, 31 Aug 2023 01:39:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQznoCZsudp4h/5hjJwGDh0u7T82ZLRGV1HdyxcWpDsY7QFEeILa81CM1hRRlYaWdPtDLTJA==
X-Received: by 2002:a17:906:1011:b0:9a1:aea8:cb5a with SMTP id
 17-20020a170906101100b009a1aea8cb5amr3100525ejm.1.1693471152865; 
 Thu, 31 Aug 2023 01:39:12 -0700 (PDT)
Received: from gerbillo.redhat.com
 (host-87-20-178-126.retail.telecomitalia.it. [87.20.178.126])
 by smtp.gmail.com with ESMTPSA id
 s19-20020a170906455300b0098e0a937a6asm502302ejq.69.2023.08.31.01.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 01:39:12 -0700 (PDT)
Message-ID: <d672e49458e257516d66213b83aeaa686fe66ea1.camel@redhat.com>
Subject: Re: [PATCH net] virtio: kdoc for struct virtio_pci_modern_device
From: Paolo Abeni <pabeni@redhat.com>
To: Shannon Nelson <shannon.nelson@amd.com>, jasowang@redhat.com, 
 mst@redhat.com, virtualization@lists.linux-foundation.org,
 brett.creeley@amd.com,  netdev@vger.kernel.org
Date: Thu, 31 Aug 2023 10:39:11 +0200
In-Reply-To: <20230828213403.45490-1-shannon.nelson@amd.com>
References: <20230828213403.45490-1-shannon.nelson@amd.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: simon.horman@corigine.com, drivers@pensando.io
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

Hi,

On Mon, 2023-08-28 at 14:34 -0700, Shannon Nelson wrote:
> Finally following up to Simon's suggestion for some kdoc attention
> on struct virtio_pci_modern_device.
> 
> Link: https://lore.kernel.org/netdev/ZE%2FQS0lnUvxFacjf@corigine.com/
> Cc: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

IMHO this is net-next material and net-next is closed, so please repost
this with a proper tag when net-next reopens in ~2w.

Thanks,

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
