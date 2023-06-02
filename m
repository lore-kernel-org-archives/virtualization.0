Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EEDC7EE29
	for <virtualization@archiver.kernel.org>; Fri,  2 Jun 2023 11:36:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5607A42734;
	Fri,  2 Jun 2023 11:36:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5607A42734
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SoMJ3Ewr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vm6YrPyLt_-v; Fri,  2 Jun 2023 11:36:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AB1BB42715;
	Fri,  2 Jun 2023 11:36:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AB1BB42715
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8313CC0037;
	Fri,  2 Jun 2023 11:36:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BA0AC0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 11:36:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 08EDE8440B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 11:36:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 08EDE8440B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SoMJ3Ewr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SAoW5lMavCuY
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 11:36:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 63F67843FC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 63F67843FC
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 11:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685705792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LVUyDjwNsYOpveCHZodIRDVco+r4PlkF8jWKJl0C0LU=;
 b=SoMJ3Ewros1LSqX+QM5HsWR9roFT2n/gWPKUPEy47PPrXVvhpS6bRCpUHby/xYDSKGfT9S
 lxrrefQUVmKTqou1oslyMAm035rYTgXlq65UGycUdeVWzFE8XzDwsq3lX/1ernLIsm5pks
 0pw9LbSjH4Vw9QBHvPObQ99YoW2phSI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-v7qrxCTWOzeS1kWSkaPTCA-1; Fri, 02 Jun 2023 07:36:31 -0400
X-MC-Unique: v7qrxCTWOzeS1kWSkaPTCA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30ae8a5006dso2454041f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 02 Jun 2023 04:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685705790; x=1688297790;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LVUyDjwNsYOpveCHZodIRDVco+r4PlkF8jWKJl0C0LU=;
 b=i8WOanNTJBossxG90ttH1bgtYBdbU8ZYmpnvXrw2Vmta31vp2aMCan7yMsvCICP0VL
 baL4t95EBT9eX0XaIXHd2V6tscQ6MtBU7mgIRvk4ZCDVA4jzmOQ4QG5sv2mgG1S89x+I
 n3Tii8uy2tXbFEZmSwViEVOSHDIij54uP7FipSTErcgAe/cJStxbbL/xyOMR6kvDioz+
 tk1J1hTPAtYjVpqx37wrh2WA8vIbPCvM1cprTD2j4NMVDy2BiTxj75/hW7Jpj2oP5AdS
 HZK8TOWgEd0asuYz5vRBFZdfUUBKTCCqNGAqY23zElxRH7kl1gOHwNAbO240A7YcO9ra
 RULA==
X-Gm-Message-State: AC+VfDxKUodMrEpVSyMAot7V6vTfaT1dBDX/vYQcUfAtAf4FVvvKHHV6
 Y5A4qoUDjapbj0ARe1C/g3nltju0EnNTjthOTDnCGVZ3Hy6csIAvefDBbUyKU3/a4suxoAVaK0l
 IqNXTjn/NYGQafBBzOKWAcGpAcy/ixgAKghgJtcbedA==
X-Received: by 2002:adf:f8d2:0:b0:30a:f3f6:2712 with SMTP id
 f18-20020adff8d2000000b0030af3f62712mr4398549wrq.60.1685705789921; 
 Fri, 02 Jun 2023 04:36:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7NPqBJbj8hKWaRbe1r+J02QAvPyCor1V6v0wGD3J4hqwQYAbETIkEwdGMoetOm326DtLN0rQ==
X-Received: by 2002:adf:f8d2:0:b0:30a:f3f6:2712 with SMTP id
 f18-20020adff8d2000000b0030af3f62712mr4398539wrq.60.1685705789667; 
 Fri, 02 Jun 2023 04:36:29 -0700 (PDT)
Received: from redhat.com ([2.55.41.2]) by smtp.gmail.com with ESMTPSA id
 c18-20020adfe752000000b0030af20aaa3fsm1436100wrn.71.2023.06.02.04.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 04:36:29 -0700 (PDT)
Date: Fri, 2 Jun 2023 07:36:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v2 2/3] vhost: support PACKED when setting-getting
 vring_base
Message-ID: <20230602073559-mutt-send-email-mst@kernel.org>
References: <20230424225031.18947-1-shannon.nelson@amd.com>
 <20230424225031.18947-3-shannon.nelson@amd.com>
 <ogzrlfid7jwfzgk42zffegaq4xhdsrpi6vu22333ub4bkmvpc3@3pa2eyzub3jn>
 <58f93ced-2f2b-dba1-b8a3-96bdb755d54e@amd.com>
 <q6cmfha36sdkgflwwd3pr4sw7rgajag4ahgjbpfjrr76w4o2b6@3yc7zs5u65s4>
 <dcfb15e6-a4c9-cb91-becd-a1e56e14d340@amd.com>
 <CACGkMEsNo4O0uAdO5koXgYbgQLoOWp81KNjsaZYSuQ7YzjvPbA@mail.gmail.com>
 <CAGxU2F4kwnGq41q99nx879Y4Br=0aeZsf2bjx2ZqpOc93G_gDQ@mail.gmail.com>
 <CACGkMEsi0Vu21ZX2WZuEWNKQ4KTGA1iNb6+8SHeCb+Penqxr8g@mail.gmail.com>
 <CAGxU2F63yQuc-eefSkEKZKZUxpnS4myGhNP2Bkj+QQk01Pi_yg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGxU2F63yQuc-eefSkEKZKZUxpnS4myGhNP2Bkj+QQk01Pi_yg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, drivers@pensando.io
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

On Thu, May 18, 2023 at 09:34:25AM +0200, Stefano Garzarella wrote:
> I think we should do one of these things, though:
> - mask VIRTIO_F_RING_PACKED in the stable kernels when
> VHOST_GET_FEAETURES is called
> - backport this patch on all stable kernels that support vhost-vdpa
> 
> Maybe the last one makes more sense.
> 
> Thanks,
> Stefano

OK which patches do you want to go to stable exactly?


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
