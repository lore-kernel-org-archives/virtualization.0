Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0FCC4332F
	for <virtualization@archiver.kernel.org>; Mon, 19 Dec 2022 10:44:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D52CD40874;
	Mon, 19 Dec 2022 10:44:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D52CD40874
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z66t4GiS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jhJQxo_q5jDt; Mon, 19 Dec 2022 10:44:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 49C3140873;
	Mon, 19 Dec 2022 10:44:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 49C3140873
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCC0DC0032;
	Mon, 19 Dec 2022 10:44:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0C19C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 10:43:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B3D33813A9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 10:43:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B3D33813A9
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z66t4GiS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z1TEy9z4_A1F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 10:43:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 13995813A3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 13995813A3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 10:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671446636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hP40XExtVlEk3Tvp3942GEdX1ZWThCpbszcDu6IxWMs=;
 b=Z66t4GiSZqNrzVc+b8/p63F8Rl7cGNTFlXsQIOWdqsFJwUSTKh4KMPZ/wMn0JpRcjroJ9f
 bvH6P+mPpffkyTUWKP/WxfNh7Tbb+jvIVB2i+9neaT7J+B0l6isR0GKZrnV9F21MKW7aaD
 8KHYMJDqaKd034gFdJyoRO5Al1VupDQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-14-7ayDyo7ZPZayxBHfpq3QXg-1; Mon, 19 Dec 2022 05:43:55 -0500
X-MC-Unique: 7ayDyo7ZPZayxBHfpq3QXg-1
Received: by mail-qk1-f200.google.com with SMTP id
 h8-20020a05620a284800b006b5c98f09fbso7065778qkp.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 02:43:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hP40XExtVlEk3Tvp3942GEdX1ZWThCpbszcDu6IxWMs=;
 b=hr/cYQMulOHI4gcBp9+gO5ZfWUPZdFl1TmEXZMKr8SU3FtYWDDbPzHY4N5Zzqlfzt1
 qL6jYTdh8/JzojVHpZ5r1eef1oSOvyAEMVZjnEsGVk1fxCF13jqq/lB060Bdx/GKRVNY
 jIrau4DwODdj/018cCkTaLLIrG5eBPM1Q4H60Iqe2FbEdGk7flLSJyrLsvodhPW/sASm
 sKCU14d7H1eePh+fhZD42dney6SRQPMXIlU4MzY3685Byg5iinvIYzBaG2zrytJ8VR+7
 teKg3LHI6vFR7NJzBSmVkGKEwxZFZSPHAk0BU7PxP6Zdb4/p9wpMxHjX88SDL2AUTbVc
 GEkQ==
X-Gm-Message-State: ANoB5plNL/kfPYZMt1XrnfkeZaUuzhTVmf6xWHZVHdtifEzYMQpO+fWE
 OpXDiQRRvJ9jw1Eej2xztaErkeebke4kxBUlEU3U1RVpMqjRmwCx2tjbfnvhVstRp8SsgjGV2Z9
 GyuLOM6uB5/9n0haTpiM3IHlRSKm4CLUVxlGTvzkqWQ==
X-Received: by 2002:a05:622a:5c06:b0:3a7:e783:7b6 with SMTP id
 gd6-20020a05622a5c0600b003a7e78307b6mr57457663qtb.5.1671446635234; 
 Mon, 19 Dec 2022 02:43:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7E2KKhqSNRjJp5xUmcTvGusdp4XOxc8QsAeRjzIluNS2TOIJTGAX7KTyqc8UBeLHh3avNODw==
X-Received: by 2002:a05:622a:5c06:b0:3a7:e783:7b6 with SMTP id
 gd6-20020a05622a5c0600b003a7e78307b6mr57457655qtb.5.1671446634962; 
 Mon, 19 Dec 2022 02:43:54 -0800 (PST)
Received: from redhat.com ([45.144.113.29]) by smtp.gmail.com with ESMTPSA id
 p16-20020a05620a057000b006fee9a70343sm6618272qkp.14.2022.12.19.02.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Dec 2022 02:43:54 -0800 (PST)
Date: Mon, 19 Dec 2022 05:43:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
Message-ID: <20221219054321-mutt-send-email-mst@kernel.org>
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
In-Reply-To: <20221219083511.73205-4-alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 virtualization@lists.linux-foundation.org
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

On Mon, Dec 19, 2022 at 10:35:11AM +0200, Alvaro Karsz wrote:
> This commit includes:
>  1) The driver to manage the controlplane over vDPA bus.
>  2) A HW monitor device to read health values from the DPU.
> 
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>

As far as I can tell patches 1,2 are upstream right?
So you can just post patch 3.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
