Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A8EC433EF
	for <virtualization@archiver.kernel.org>; Tue, 29 Mar 2022 04:18:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A97B083332;
	Tue, 29 Mar 2022 04:18:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Of9PylNkiuUK; Tue, 29 Mar 2022 04:18:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 604FD82A4E;
	Tue, 29 Mar 2022 04:18:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30C7AC002C;
	Tue, 29 Mar 2022 04:18:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5609CC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 04:18:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3568160899
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 04:18:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pb_DaAAk4MoT
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 04:18:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 98A7E60A92
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 04:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648527492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dVJL4ozOwWA5aukUzGIkvdEWbtM61TZAzLEivcvQQUE=;
 b=ef3uEWosZSUHQfO6Bl5ERZMp2ASrChpIIB3PhlnJho/c7LygsUHIa7OH0oeLqbdWu3t8MT
 6gtbOD9mUqemiGZvtgFWrrCWN/w8QscILgn7GBHudcyBVqjCPpApCfqhpc4fAf9INzRHz3
 QSJncrnY7XXLDV/+54rbaVtoj85DuJg=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-vhsSPz3nOPesjSA8jAIecg-1; Tue, 29 Mar 2022 00:18:07 -0400
X-MC-Unique: vhsSPz3nOPesjSA8jAIecg-1
Received: by mail-lj1-f198.google.com with SMTP id
 20-20020a05651c009400b002462f08f8d2so6952410ljq.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 21:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dVJL4ozOwWA5aukUzGIkvdEWbtM61TZAzLEivcvQQUE=;
 b=flrVJSHedQSrY54EUrVT+98moWOaP8NQWG5EU2xE4jEES00vLYIRtNYsuExA0b6NYh
 G54pJa7e8HXIbE5MNiqaRLvDMEtt1rOvNVOKf26o8glzqr52ru/X89+O1TpinH6oVJ22
 yHcQ16TKH7ehj7H286Cr25+HaS+KIM0JzOpDIwoTRHRarY7y0lQniKneqArKUw96HqLf
 zjKUZh3IIohYixqkPhWZQQH+xT5FIQIvW7v0nwt+TpwGCQqx7N1ZFTEY3mrzfCBNk5nn
 9PUfXoOAELEdDCLxg/RewR/BjU873RNjtzeUyI1kKWj1vN4ZT+ZEG6U5uXlxUEtyF/bc
 1t4g==
X-Gm-Message-State: AOAM530+PdqwfcB06vXqHv0Jmrfx6L1nlTJhkAVwEy5H6udqCTe3WFkU
 XtyX7QuTLbz4xHRLalM30YT1+733mNdQom7sryjRAlzPHegdfMECLI3zwdN7VouXnyb+4SHrnt7
 sl+ngfClXrjga0NV8Apa0sZe5wzuuBwTYiojugAPwFGMxD5VcPMW7Q+XSHg==
X-Received: by 2002:ac2:4189:0:b0:448:bc2b:e762 with SMTP id
 z9-20020ac24189000000b00448bc2be762mr819657lfh.471.1648527485844; 
 Mon, 28 Mar 2022 21:18:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaY1KO8qVJ4cK/ULy7QRzOia521HxyOEE6HiQaQmTLIpFRQOw8Oc0IsataNVwt/lE/FGXuDmllt+ByEA3I5Kc=
X-Received: by 2002:ac2:4189:0:b0:448:bc2b:e762 with SMTP id
 z9-20020ac24189000000b00448bc2be762mr819648lfh.471.1648527485674; Mon, 28 Mar
 2022 21:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220329040840.3419-1-jasowang@redhat.com>
 <20220329040840.3419-3-jasowang@redhat.com>
In-Reply-To: <20220329040840.3419-3-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 29 Mar 2022 12:17:54 +0800
Message-ID: <CACGkMEuRUh1qUBxKTcvuMXRkenGY53VBOf8dwabEsytnc6gFOQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] vdpa/mlx5: Use consistent RQT size
To: mst <mst@redhat.com>, jasowang <jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Eli Cohen <elic@nvidia.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

My bad, dunno what happened.

Please ignore this series, I will repost.

Thanks

On Tue, Mar 29, 2022 at 12:08 PM Jason Wang <jasowang@redhat.com> wrote:

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
