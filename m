Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FEBE7D0A9
	for <virtualization@archiver.kernel.org>; Thu, 21 Sep 2023 20:21:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16405613D0;
	Thu, 21 Sep 2023 20:21:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 16405613D0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aWVlXVP5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M0xm_7Zw4idW; Thu, 21 Sep 2023 20:21:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BF40960E7B;
	Thu, 21 Sep 2023 20:21:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BF40960E7B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95CB3C0071;
	Thu, 21 Sep 2023 20:21:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C5D3C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 20:21:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5CE9A8235D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 20:21:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5CE9A8235D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aWVlXVP5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aZAQFgUBacwz
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 20:21:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A35EF82324
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 20:21:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A35EF82324
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695327673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1SECl7HHOuHpRqQu6Pg2t83dXUaZvAMYkmKX/gGCDg0=;
 b=aWVlXVP5QLSlyW+zmCRuweDpUPV66DtaMQT0wzJWOKUw16LkDhhQBX8v1IZZGgNUe5XBTt
 bYef9OSD78aNWA1QcK/sanB+prLUYJfDwBhoK7fK5aw5pOztV3y+GqX2tnl+79MprH+9+0
 0+X2NusoBYqMG+GS+MtdzFgjMOaZMI8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-DPaO8zJmOQ69idCfmLc60Q-1; Thu, 21 Sep 2023 16:21:09 -0400
X-MC-Unique: DPaO8zJmOQ69idCfmLc60Q-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-993d7ca4607so107900066b.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 13:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695327668; x=1695932468;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1SECl7HHOuHpRqQu6Pg2t83dXUaZvAMYkmKX/gGCDg0=;
 b=rOgyx55ZIEQ3IQkSqYOqrW7BRDO0HEmOMgHnGSnv9I+1L/TBHbnDvBmGQq+Mod4JG1
 HtQZ5UxCgdtC/Or9OMkFo6HHvjoJr3Gw08d9+HysrQ+cCR0XkCUT+afO24AjqHf05v7y
 BLw4tC6q5b4UpkyDrccOchcrywg+IJmELzd+3HnenQsmXirsOujck5+tcQ+aRmKTk3Ov
 pQvV03IQpIfZz2QZu2TR+5O9vAmm4FKoyTeFsDt7okxJ9NiBnRwXN6SrohovE28EXcAE
 RYm/aIPrTX+Z6BZp/oIXs3QN1vswMHTRigRbK0cbrgKy0YcHZK/UXXfuCydxafLa32pX
 gZsQ==
X-Gm-Message-State: AOJu0YyQ/KUZAauqKWekL/sJpw+qXKURcvqYKoI++nBJ4FM+WIArPCyK
 dNg/cjks5ld64j6Nj54jshEkfbCzF9qYTlmGjggdIwjTvozLP+IEecbuOJ/UxCNGoevKpz3HHl7
 dlbJUCXp9KtHVydMJK4GNXV10m3r091oWNpFGlsfUNg==
X-Received: by 2002:a17:907:7755:b0:9a5:d657:47ec with SMTP id
 kx21-20020a170907775500b009a5d65747ecmr5891141ejc.64.1695327668596; 
 Thu, 21 Sep 2023 13:21:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3QCdXAxYwhPYQqQbPpiWRW9ysxpmHnqzUV7PdQNvEFRE1hFOgf1uBv4E8bUxI9licalfcNg==
X-Received: by 2002:a17:907:7755:b0:9a5:d657:47ec with SMTP id
 kx21-20020a170907775500b009a5d65747ecmr5891121ejc.64.1695327668272; 
 Thu, 21 Sep 2023 13:21:08 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 t2-20020a17090616c200b0099d45ed589csm1506083ejd.125.2023.09.21.13.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 13:21:03 -0700 (PDT)
Date: Thu, 21 Sep 2023 16:20:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230921161834-mutt-send-email-mst@kernel.org>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-12-yishaih@nvidia.com>
 <20230921135832.020d102a.alex.williamson@redhat.com>
 <20230921200121.GA13733@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230921200121.GA13733@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jiri@nvidia.com, leonro@nvidia.com
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

On Thu, Sep 21, 2023 at 05:01:21PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 21, 2023 at 01:58:32PM -0600, Alex Williamson wrote:
> 
> > > +static const struct pci_device_id virtiovf_pci_table[] = {
> > > +	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_REDHAT_QUMRANET, PCI_ANY_ID) },
> > 
> > libvirt will blindly use this driver for all devices matching this as
> > we've discussed how it should make use of modules.alias.  I don't think
> > this driver should be squatting on devices where it doesn't add value
> > and it's not clear whether this is adding or subtracting value in all
> > cases for the one NIC that it modifies.  How should libvirt choose when
> > and where to use this driver?  What regressions are we going to see
> > with VMs that previously saw "modern" virtio-net devices and now see a
> > legacy compatible device?  Thanks,
> 
> Maybe this approach needs to use a subsystem ID match?
> 
> Jason

Maybe make users load it manually?

Please don't bind to virtio by default, you will break
all guests.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
