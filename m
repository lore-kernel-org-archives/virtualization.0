Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD719C4332F
	for <virtualization@archiver.kernel.org>; Tue,  7 Nov 2023 13:23:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 039B96133C;
	Tue,  7 Nov 2023 13:23:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 039B96133C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PvTOtuNA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6B-dW4PvuNux; Tue,  7 Nov 2023 13:23:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 85F4D60B69;
	Tue,  7 Nov 2023 13:23:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 85F4D60B69
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 693D3C0039;
	Tue,  7 Nov 2023 13:23:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3384CC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 13:23:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 015CE82AC3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 13:23:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 015CE82AC3
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PvTOtuNA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nTTmuLxHPJCk
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 13:23:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AEC09822FA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 13:23:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AEC09822FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699363420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6FU32l39lKCSdZhSytwDwo2S8vBHIikXujdpUSbPKo8=;
 b=PvTOtuNAgO5a4t4fAwNwn7zoMgnxsUmUSgmCiWJ7nonTxC9OWiBBpjI1S/xoB+ihLJTFz9
 DdOBtc8uVmgG9Y3pY2FFaQSFQElzz+u6ZF1mLOYvLXwPodaydTkEueoisZRthjPaUKIdeZ
 4/VGbIALM2xCwOZzsK9s9IM6mDSaa4k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-kbxhXzVBM42YnIrCNu9gCA-1; Tue, 07 Nov 2023 08:23:39 -0500
X-MC-Unique: kbxhXzVBM42YnIrCNu9gCA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32da8de4833so2936739f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Nov 2023 05:23:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699363418; x=1699968218;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6FU32l39lKCSdZhSytwDwo2S8vBHIikXujdpUSbPKo8=;
 b=TjXP7TONJXEVZ8QNrsYrSr761ahz4QZ0jlPLtLdeOt7nkq/ZGArGWHcP0RlPsskhuc
 rRUF4M0CZoYRc30IHV7oyYqM0pUc4CS0kXYoPpAOQ464nSFhDgIWunYSCYFs61q3oJ9U
 xVtdEg45tVeJFTXswoMVXc5uKrjfh+GjxGh5jLHx99cGV8x+ZA5Ra9+tDTOpPWH9+0wa
 BHodmCNvcurqz9cF8WrFPylXk7qe95y/jr9tdBh1nx1CKuHAhJM/7eIqwRFm4Y+RSiF3
 Mnr8E4UGcb+b8GvR68A+AckMN99k3AhX87UzNk83LSn4AcB73jnJZiHP+wn0NDz5rF6y
 r7MQ==
X-Gm-Message-State: AOJu0Yz8hWA6j4DxzheWVSWmSHSPdPwRJgWLVIzwn36+/1L9np1GY+7w
 gaLjJ5b6RckQwhkoSn/a0lN8ZScj8cIu8DI4KXF/aTleWOSeJuoNet/ji4LaH50VAZvKrDTf7+Y
 xI2GAw4KMCgSxj6ZCnPl1i2bvTldLv5oWUZbmWs3PLA==
X-Received: by 2002:a5d:64af:0:b0:32f:aaff:96dd with SMTP id
 m15-20020a5d64af000000b0032faaff96ddmr11425181wrp.4.1699363417941; 
 Tue, 07 Nov 2023 05:23:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkb/2QIpst9kXo1JNieCe98S9IH2A6ymDLslfoNXCzUG50rRwswfRq4amhWEX0BKprIvqrcA==
X-Received: by 2002:a5d:64af:0:b0:32f:aaff:96dd with SMTP id
 m15-20020a5d64af000000b0032faaff96ddmr11425155wrp.4.1699363417297; 
 Tue, 07 Nov 2023 05:23:37 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f1:373a:140:63a8:a31c:ab2a])
 by smtp.gmail.com with ESMTPSA id
 o3-20020a056000010300b0032da4f70756sm2391885wrx.5.2023.11.07.05.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 05:23:36 -0800 (PST)
Date: Tue, 7 Nov 2023 08:23:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231107082214-mutt-send-email-mst@kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20231103171641.1703146-1-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: yi.l.liu@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, jgg@nvidia.com
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

On Sat, Nov 04, 2023 at 01:16:33AM +0800, Cindy Lu wrote:
> Test passed in the physical device (vp_vdpa), but  there are still some problems in the emulated device (vdpa_sim_net), 

I'm not sure there's even value in bothering with iommufd for the
simulator. Just find a way to disable it and fail gracefully.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
