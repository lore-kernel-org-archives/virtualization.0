Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79971C761A6
	for <virtualization@archiver.kernel.org>; Mon, 27 Mar 2023 12:33:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0F6061022;
	Mon, 27 Mar 2023 12:33:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E0F6061022
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GvP3m+AU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zz9Qk33Dxn7e; Mon, 27 Mar 2023 12:33:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7580760A91;
	Mon, 27 Mar 2023 12:33:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7580760A91
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49B83C0035;
	Mon, 27 Mar 2023 12:33:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE801C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 12:33:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B57878142C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 12:33:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B57878142C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GvP3m+AU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iNTiqu16dbw9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 12:33:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 52290813EC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 52290813EC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 12:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679920416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mpglqp8Y7u3CQVfSJXHDjl8eXuatC2m14Xm9c2cEbLo=;
 b=GvP3m+AUY4JEv3QGY18N1I//AhkUQ4PgGC5JkVraGAqXygTViOTqSj28P9L4yiLIEnHIrI
 namjugGNzVRxySVb+9XQmNuiDEp3KuoOhZb0i2B1taTvMmpnijpkt/d9Ptrflhd0VR/tWg
 5aTgqjkP47x4PCRQnJPz6s9SbQh71hg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-4nLPjXVwPCqF48fLA6xblg-1; Mon, 27 Mar 2023 08:33:35 -0400
X-MC-Unique: 4nLPjXVwPCqF48fLA6xblg-1
Received: by mail-wm1-f69.google.com with SMTP id
 bi5-20020a05600c3d8500b003edda1368d7so4716664wmb.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 05:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679920414;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mpglqp8Y7u3CQVfSJXHDjl8eXuatC2m14Xm9c2cEbLo=;
 b=y2N0DVtaapUgjyugN+F53rga1nGgSAaUB1hiQ9J+CjL6T2vs5KVjpcYcOAKvPUD37E
 kDiBgkD1blJd5ivR6yWyEKp0UF51e1ddmtQLFzzyr1ywQ0OA5FFLyebWbs8exkyBHoMv
 LrbfGxKbwfVIxFKoipgOY5cfBMN+6aK2Jw8fGWDQPOmQC0OyX67YvVhRRTiRwJLJSERE
 Neu79LswTOUw6TIijcL/ejS8aAtsQ8WWj/Kz9TXyFJIr1xVxmSPDFPB426rj4Ut5W3Ut
 fvbISiUlMXpdcQeZF5pjy4u/T7oTnILcQxvK2KVMAxwMSvyDZcNxFKJsImWsEtug6VPK
 GpWQ==
X-Gm-Message-State: AO0yUKVmqe4W9Iplyye2nhE95bZysY4UdOnIPA7SopLCyRZhlloyeDx4
 ZrrapTdkwyadL+2N7SFFrL1WVhLA2HLaI5GKh/ZtcxaEOIQ881FXYb6W5fpXAlv+yEpF8UwdbE/
 O26j3MoTwIF3RvLzgRg2xF+2bHxDwqW9tmSCGxln6+a4D2A3ALw==
X-Received: by 2002:a05:600c:3148:b0:3ed:1f98:670f with SMTP id
 h8-20020a05600c314800b003ed1f98670fmr10506125wmo.20.1679920413785; 
 Mon, 27 Mar 2023 05:33:33 -0700 (PDT)
X-Google-Smtp-Source: AK7set/lxjcuutzR4KQhcQDX5Cq8kO+QVlRHIWfaefT5OwXpjXIvt1fetUujRaELx7OS9K3HPmMPPA==
X-Received: by 2002:a05:600c:3148:b0:3ed:1f98:670f with SMTP id
 h8-20020a05600c314800b003ed1f98670fmr10506114wmo.20.1679920413515; 
 Mon, 27 Mar 2023 05:33:33 -0700 (PDT)
Received: from redhat.com ([2.52.153.142]) by smtp.gmail.com with ESMTPSA id
 y16-20020a1c4b10000000b003e91b9a92c9sm13602105wma.24.2023.03.27.05.33.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Mar 2023 05:33:33 -0700 (PDT)
Date: Mon, 27 Mar 2023 08:33:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH 0/2] vdpa/snet: support [s/g]et_vq_state and suspend
Message-ID: <20230327083313-mutt-send-email-mst@kernel.org>
References: <20230320101817.680402-1-alvaro.karsz@solid-run.com>
 <AM0PR04MB47230415F00797EB85F0CD41D48B9@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB47230415F00797EB85F0CD41D48B9@AM0PR04MB4723.eurprd04.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Mon, Mar 27, 2023 at 06:49:32AM +0000, Alvaro Karsz wrote:
> ping

tagged. in the future pls CC everyone on the cover letter too.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
