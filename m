Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E059C25B07
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 10:35:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60FBC408D0;
	Tue,  9 Aug 2022 10:35:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 60FBC408D0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BKBWBaVo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wvIDW63NarGR; Tue,  9 Aug 2022 10:35:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 88132408CA;
	Tue,  9 Aug 2022 10:35:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 88132408CA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56592C0032;
	Tue,  9 Aug 2022 10:35:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5DAEC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 10:35:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8CC14605D6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 10:35:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8CC14605D6
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BKBWBaVo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y3iqi78hhGbp
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 10:35:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 24AF4605AF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 24AF4605AF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 10:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660041333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YeZmWlJ57t/EqWJ2923+U6CuKUM3PGmeDKKJtSlBlkw=;
 b=BKBWBaVoWJoOyL3DvP6eh2/oGedV5xT1F6YA8nTma4uXHJiw0ZUSs2sYew4wSWeDfSVskl
 RBEzz0M7/jZWUa+MZFi4v1l6xU1ApkDPy/FVWbg4nQl3id7Mw4wz50igkdmwoHuwG8r+XA
 AsNubvoTP3gI790l1LS3skgRUbgZk/M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-P_yxas_HO5yEOyWGquzFHA-1; Tue, 09 Aug 2022 06:35:30 -0400
X-MC-Unique: P_yxas_HO5yEOyWGquzFHA-1
Received: by mail-wm1-f70.google.com with SMTP id
 i65-20020a1c3b44000000b003a537031613so1743031wma.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Aug 2022 03:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=YeZmWlJ57t/EqWJ2923+U6CuKUM3PGmeDKKJtSlBlkw=;
 b=LxUbhGjtfI3k3CJ5bTeJtuiRQQHoWoNuU9HUguG58pUo3pwChJv7RK+dO7w56I9thv
 sdDtZOSO7yF/xwmbUz4hABqWjZodniMSAepxY0GEwx0xB9Acffkj4YyRVC0/4MGVBaux
 B3b33NeAq9shffl/vTXR+IlvrE1/Fix1y92C3PXAlp/G8SgLcKPYwtpUmkj1yqk846D2
 1YdPe4Ykwh86JXXznV8lHMAGLU0q1ls8EE+kArjR7xBIppuXpqH+V1qPrEz+CQa0vKEi
 CE7/iRYAPfQdYCzbDwuIIkCqMeNjP1FkTsiiVDTbKdoORET1Q9VUlNt2q2K9BFJyDv8+
 Alfg==
X-Gm-Message-State: ACgBeo2ZBM7cX7/DnGc6OF1Olnv6b+QNebhbSO5H3czabuSFelShArIm
 mf5/Q30BN5pWDPkuM7oeJwlvMjQAqXSnjgodBbejk8w8NHJ/ubcS8Vx/GsaC7e4ns8n65S542t2
 wJ0Db27FT1vGdqZfGcixte0QOL444XJYl4rfzju3ZsA==
X-Received: by 2002:adf:f346:0:b0:21f:13ec:cacf with SMTP id
 e6-20020adff346000000b0021f13eccacfmr13580122wrp.525.1660041329264; 
 Tue, 09 Aug 2022 03:35:29 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5yD3fjmdk8FR8LY7ZeN/oQbXPL4+j7fn+/YDf5jFwCIuY7SkUglVYGH0jzof0I4LcXb2HSWQ==
X-Received: by 2002:adf:f346:0:b0:21f:13ec:cacf with SMTP id
 e6-20020adff346000000b0021f13eccacfmr13580110wrp.525.1660041329068; 
 Tue, 09 Aug 2022 03:35:29 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 az25-20020a05600c601900b003a35516ccc3sm16299278wmb.26.2022.08.09.03.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Aug 2022 03:35:28 -0700 (PDT)
Date: Tue, 9 Aug 2022 06:35:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Subject: Re: [PATCH v4 1/1] Create debugfs file with virtio balloon usage
 information
Message-ID: <20220809063414-mutt-send-email-mst@kernel.org>
References: <20220705083638.29669-1-alexander.atanasov@virtuozzo.com>
 <20220705045912-mutt-send-email-mst@kernel.org>
 <f6b46a29-0f65-9081-5228-a1028fea2bef@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <f6b46a29-0f65-9081-5228-a1028fea2bef@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, kernel@openvz.org,
 linux-kernel@vger.kernel.org
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

On Tue, Jul 05, 2022 at 12:01:58PM +0300, Alexander Atanasov wrote:
> > > diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> > > index ddaa45e723c4..f3ff7c4e5884 100644
> > > --- a/include/uapi/linux/virtio_balloon.h
> > > +++ b/include/uapi/linux/virtio_balloon.h
> > > @@ -40,6 +40,7 @@
> > >   /* Size of a PFN in the balloon interface. */
> > >   #define VIRTIO_BALLOON_PFN_SHIFT 12
> > > +#define VIRTIO_BALLOON_PAGE_SIZE (1<<VIRTIO_BALLOON_PFN_SHIFT)
> > >   #define VIRTIO_BALLOON_CMD_ID_STOP	0
> > >   #define VIRTIO_BALLOON_CMD_ID_DONE	1
> > Did you run checkpatch on this?
> 
> 
> Sure, i did:
> 
> scripts/checkpatch.pl
> ../outgoing/v4-0001-Create-debugfs-file-with-virtio-balloon-usage-inf.patch
> total: 0 errors, 0 warnings, 108 lines checked
> 
> ../outgoing/v4-0001-Create-debugfs-file-with-virtio-balloon-usage-inf.patch
> has no obvious style problems and is ready for submission.

Weird. There should be spaces around << I think.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
