Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993A6C001E0
	for <virtualization@archiver.kernel.org>; Wed, 26 Jul 2023 19:28:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 41BEC8201E;
	Wed, 26 Jul 2023 19:28:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 41BEC8201E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AcSlKRi7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UaVNRseUwzBj; Wed, 26 Jul 2023 19:28:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C3FA781774;
	Wed, 26 Jul 2023 19:28:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C3FA781774
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A053CC0072;
	Wed, 26 Jul 2023 19:28:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 956A1C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 19:28:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 707A581871
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 19:28:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 707A581871
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ScVfW8r-YVCp
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 19:28:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 80E1981774
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 19:28:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 80E1981774
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690399728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SwkepaC05QLl5gztwV48WAfFUdJ93Ti/DuPyfYVfFp8=;
 b=AcSlKRi7A14+TuWMAZn1bSi4QL5TQVBPZMXBUiSc+wnitZQVuXaIU2Yg44lNbC16Tn1CTL
 E6UmthsLbykvwbB0rnvXpbcFHZCixOFgPoPbuqiiByAxMFVjfNYsAuxMG57wozisEVcef+
 ODGGFHdN997NvwTn4h3dO3zn9FxObLo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-5P49fJpZMSq0-007-8tNnw-1; Wed, 26 Jul 2023 15:28:46 -0400
X-MC-Unique: 5P49fJpZMSq0-007-8tNnw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-99bc8f1290eso2830966b.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 12:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690399725; x=1691004525;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SwkepaC05QLl5gztwV48WAfFUdJ93Ti/DuPyfYVfFp8=;
 b=KcvjmWZz0TST24107y+Hc8A6UMfWSXFpJD9tTWYEX5bxKza+wSKm88jyTmqIyGjNTM
 8PNETaeG2XM2EVfQfgVN9NRKhzB+Hamwv77rDblW1MBtddwVIa2xlcNGvEFOJOxIC485
 QwxmMyBYAXXoroCd4Z9JKHeV2glUR4ne8QC/r2b4VTtrC6b8vtx3ZXnH/EfltZJvSht2
 yPYnGRkhkCGv4xFcwKZRZhn2ky7jkwOmV6C5ekoBt9RUaPyAO9jEknTx4JQScY2hpdeq
 /7fYWnYPEiIedYraB+4X3zk4GZP+0wOYetb7mvoYd/b9gVcp9PpSdvqFL11whA7TqMEd
 dbug==
X-Gm-Message-State: ABy/qLa+gjWGUK75BLOIvOQ0mXs0OtuMOsleGdudJ0F4bMlSRix1PTYU
 4GwmUY7LM1QiW/psjJ+9dtmM+7HWigH+RkH95vdVVRB71sNri6FmpPsbFU8MyyHTf2jbMGqnlsG
 Fpi8Mje4amzJMRMbyBzjb/DBuT7EDnTMOjVDnBqN3b5aUeDi/VA==
X-Received: by 2002:a17:906:1ba2:b0:991:e7c3:5712 with SMTP id
 r2-20020a1709061ba200b00991e7c35712mr98556ejg.30.1690399725415; 
 Wed, 26 Jul 2023 12:28:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHhQ3WDKlew1+1e3F7M/hEhcV3TrwVWza1XW/STKFBc6D4wdOZOdGNePdu6A08NQAkUqJEdpA==
X-Received: by 2002:a17:906:1ba2:b0:991:e7c3:5712 with SMTP id
 r2-20020a1709061ba200b00991e7c35712mr98541ejg.30.1690399725074; 
 Wed, 26 Jul 2023 12:28:45 -0700 (PDT)
Received: from redhat.com ([2.52.14.22]) by smtp.gmail.com with ESMTPSA id
 w8-20020a1709064a0800b0099bd4e3b4b3sm155891eju.199.2023.07.26.12.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 12:28:42 -0700 (PDT)
Date: Wed, 26 Jul 2023 15:28:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH 0/2] vdpa: Enable strict validation for netlink ops
Message-ID: <20230726152820-mutt-send-email-mst@kernel.org>
References: <20230726183054.10761-1-dtatulea@nvidia.com>
 <20230726143640-mutt-send-email-mst@kernel.org>
 <8a97e0d439d74373605b00dcaef91108ced9e5ee.camel@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <8a97e0d439d74373605b00dcaef91108ced9e5ee.camel@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linma@zju.edu.cn" <linma@zju.edu.cn>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Jul 26, 2023 at 06:56:24PM +0000, Dragos Tatulea wrote:
> On Wed, 2023-07-26 at 14:36 -0400, Michael S. Tsirkin wrote:
> > On Wed, Jul 26, 2023 at 09:30:48PM +0300, Dragos Tatulea wrote:
> > > The original patch from Lin Ma enables the vdpa driver to use validat=
ion
> > > netlink ops.
> > > =

> > > The second patch simply disables the validation skip which is no long=
er
> > > neccesary. Patchset started of from this discussion [0].
> > > =

> > > [0]
> > > https://lore.kernel.org/virtualization/20230726074710-mutt-send-email=
-mst@kernel.org/T/#t
> > =

> > Cc stable with at least 1/2 ?
> > =

> Sent a v2 with stable in cc. But looks like 1/2 breaks the "fix one thing=
 only"
> rule due to the many Fixes tags I guess...

you can split it up to 3 patches to simplify backports if you like.



> > > Dragos Tatulea (1):
> > > =A0 vdpa: Enable strict validation for netlinks ops
> > > =

> > > Lin Ma (1):
> > > =A0 vdpa: Complement vdpa_nl_policy for nlattr length check
> > > =

> > > =A0drivers/vdpa/vdpa.c | 9 +++------
> > > =A01 file changed, 3 insertions(+), 6 deletions(-)
> > > =

> > > -- =

> > > 2.41.0
> > =

> =


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
