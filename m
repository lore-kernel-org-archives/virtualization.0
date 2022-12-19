Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16501C4332F
	for <virtualization@archiver.kernel.org>; Mon, 19 Dec 2022 10:44:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A85666058C;
	Mon, 19 Dec 2022 10:44:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A85666058C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iO4jTAy4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pWex1ymOHrOz; Mon, 19 Dec 2022 10:44:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4DD2E60592;
	Mon, 19 Dec 2022 10:44:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4DD2E60592
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 159EDC0032;
	Mon, 19 Dec 2022 10:44:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22CDAC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 10:44:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EB2D3408EF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 10:44:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB2D3408EF
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iO4jTAy4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iHcIW1psAXMV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 10:44:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2CB6640877
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2CB6640877
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 10:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671446675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Reu6NRJwdKAI/LUu39/+1k6l1aGIPSvkajefprb2Rq4=;
 b=iO4jTAy4P6L8gP2p7c5BZzq035jBXER8qTK89PsrtI1OF5gL7xaPRh5ppyLKK8M/3A44kq
 xEor1upb/ZFo5VAsO0j7Sm2Dl9m1oVIls0Aa2c8xPtrGOFulAsIp6Zj2kt1o/L+Oz00MV2
 8BNCFX6nftC3il9vjT5e6oO+JWeNXzQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-255-giAzD09yOP-Y4LDr0hL7zg-1; Mon, 19 Dec 2022 05:44:33 -0500
X-MC-Unique: giAzD09yOP-Y4LDr0hL7zg-1
Received: by mail-qk1-f197.google.com with SMTP id
 de38-20020a05620a372600b0070224de1c6eso6204783qkb.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 02:44:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Reu6NRJwdKAI/LUu39/+1k6l1aGIPSvkajefprb2Rq4=;
 b=JrQTYXccDkBQx41mLNWlw4gfsZTWEKsAF9Gvhl3c0PRmVKFyLMTUpMTaCGfNAo9EJ7
 vxEbVw6NHwMvroT74DGNCnz/ys/a7RVgOE5Ez2Yg4BrGw98ClRG5FL6ZcSz1eke77sVA
 tzuczgu+dWvuwFVNq0PvaKS1cVU8uc1MbPdqm9EVCBP08Y6iLb9re7oWPHfWHYWk3Vbk
 uv2qI67gGAM4xnkq5ijmdTthPCjgXw2OJ0O65WH0cc0kEHxTbt1yQBAHYEFww7RdnnG0
 E0mBvw0mTKjF/f0t3OtIfsCd3HF4ei/ovXhcRdwxK9Tkz73NPbOHw7LT+2GHsgqLwKGH
 labQ==
X-Gm-Message-State: ANoB5pn9nrRnrJE6VzY8cNWLhr5pxFVzr6as+uGP2UsC7imP78tEvyIQ
 JbcKbKkji6BPvmT5HjNvMaH/Eexnafu/8Fci9A9Y3WSshbz9p+bOzd+JXo471nCsMan/r5yF3BZ
 Z3pXC8y1NAzwcxCIv3Ys6ZOrrCViZ5vcwgoyWl/63Jg==
X-Received: by 2002:a05:622a:248b:b0:3a6:454f:4e3f with SMTP id
 cn11-20020a05622a248b00b003a6454f4e3fmr59822163qtb.7.1671446673027; 
 Mon, 19 Dec 2022 02:44:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4MdILKCwus5PCnhvoaUL4i2rjze68GkRcU9GQwLpc+ka1EwGERY0zv8jKnKomaEy6NC6C7YA==
X-Received: by 2002:a05:622a:248b:b0:3a6:454f:4e3f with SMTP id
 cn11-20020a05622a248b00b003a6454f4e3fmr59822150qtb.7.1671446672763; 
 Mon, 19 Dec 2022 02:44:32 -0800 (PST)
Received: from redhat.com ([45.144.113.29]) by smtp.gmail.com with ESMTPSA id
 p24-20020a05620a133800b006faa2c0100bsm6655000qkj.110.2022.12.19.02.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Dec 2022 02:44:32 -0800 (PST)
Date: Mon, 19 Dec 2022 05:44:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
Message-ID: <20221219054419-mutt-send-email-mst@kernel.org>
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com>
 <20221219054321-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20221219054321-mutt-send-email-mst@kernel.org>
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

On Mon, Dec 19, 2022 at 05:43:55AM -0500, Michael S. Tsirkin wrote:
> On Mon, Dec 19, 2022 at 10:35:11AM +0200, Alvaro Karsz wrote:
> > This commit includes:
> >  1) The driver to manage the controlplane over vDPA bus.
> >  2) A HW monitor device to read health values from the DPU.
> > 
> > Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> 
> As far as I can tell patches 1,2 are upstream right?
> So you can just post patch 3.

Oh my bad pls ignore.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
