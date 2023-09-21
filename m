Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6B9E7D0A2
	for <virtualization@archiver.kernel.org>; Thu, 21 Sep 2023 21:00:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 101254207E;
	Thu, 21 Sep 2023 21:00:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 101254207E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mm3GvieG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DUNGHfMzTES1; Thu, 21 Sep 2023 21:00:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4AE4241D99;
	Thu, 21 Sep 2023 21:00:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4AE4241D99
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E439C0071;
	Thu, 21 Sep 2023 21:00:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FB93C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 21:00:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 05CD141D9A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 21:00:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 05CD141D9A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rE9EesmIgMgE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 21:00:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E2AB641D99
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 21:00:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E2AB641D99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695330004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w92TIdX77sqPjb1fzpSj+HbzxRLdHbB40Saqu1w60+Q=;
 b=Mm3GvieGt8uD+irbtVMpU1ZRedPiqqDrT3ih0I8dCsbsxyRxSVKQEwpNME0BMn8WdJscW6
 8GDKKVOLB0Kxi1f8qw9PpF3PF9gRPnofqi0LWfraY1emcUM6jTEK1N6bIaWDJoDYlku5PF
 YOqwrdi0TK+NR51/5bsMAqzFDWBGZrE=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-pMY182pdN_2mtP_OyRnOew-1; Thu, 21 Sep 2023 17:00:02 -0400
X-MC-Unique: pMY182pdN_2mtP_OyRnOew-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-1d66d948417so1971492fac.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 14:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695330002; x=1695934802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w92TIdX77sqPjb1fzpSj+HbzxRLdHbB40Saqu1w60+Q=;
 b=v4YzqJRjr1okxSpxDjiYECEiFKKRaqmSncpcAW2fX+O6p3lc0//sRciMZtKQ1mhZVn
 xDyLatTWUW8hP15sG8ijZajKLJIaFGsQRa40n/hlBEqjT9NOQNN7k8hUgqGvhQESAh82
 FfWx5Eo4ZOBxACDpLigfyfSDAma5uOYgkV6YRVR7gnIFQJgVSMRozSMCrgvkBIEAjqvS
 u0pT3vbUGJ6sFJE+soIY8DXyvHeZLyE/I4OZ9gwQQfZubCq0jPs8XtkOGmHIJe32DGw1
 dvFKji/YfF/VBmlL2vFwlUPAYm5AbfeSBx31157hQSEWWnp9yqrkiyR3LVrsldT7iYLe
 ZBog==
X-Gm-Message-State: AOJu0YzksmFBokcRlTjwBmt8PQsAGiezTRoAbm66qhcAltM5M8XqiJFx
 Ad3JLwvOF7tzmd8pmDfq0psKz6dT64EH3HUxyzS2IlpbYg+dKDIVdFdPBCt7IQv7PTrSFyeDc0A
 JNRxSusJWesGqFcRGzQHW3JrXqvLBqOBPiO55K+hSvg==
X-Received: by 2002:a05:6870:304c:b0:1d5:ef9d:5564 with SMTP id
 u12-20020a056870304c00b001d5ef9d5564mr6571674oau.11.1695330001958; 
 Thu, 21 Sep 2023 14:00:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp49HT+ZImBpexc/Hl0xUqdHosRzIOsU7V7v6//pfkOGXqA0pJhTnPQVS6l0Y658YpvuzV9Q==
X-Received: by 2002:a05:6870:304c:b0:1d5:ef9d:5564 with SMTP id
 u12-20020a056870304c00b001d5ef9d5564mr6571664oau.11.1695330001699; 
 Thu, 21 Sep 2023 14:00:01 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 n21-20020a056870a45500b001d6631fd08fsm686096oal.47.2023.09.21.14.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 14:00:01 -0700 (PDT)
Date: Thu, 21 Sep 2023 14:59:59 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230921145959.7d6b5b95.alex.williamson@redhat.com>
In-Reply-To: <20230921161834-mutt-send-email-mst@kernel.org>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-12-yishaih@nvidia.com>
 <20230921135832.020d102a.alex.williamson@redhat.com>
 <20230921200121.GA13733@nvidia.com>
 <20230921161834-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
 jiri@nvidia.com, leonro@nvidia.com
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

On Thu, 21 Sep 2023 16:20:59 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Sep 21, 2023 at 05:01:21PM -0300, Jason Gunthorpe wrote:
> > On Thu, Sep 21, 2023 at 01:58:32PM -0600, Alex Williamson wrote:
> >   
> > > > +static const struct pci_device_id virtiovf_pci_table[] = {
> > > > +	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_REDHAT_QUMRANET, PCI_ANY_ID) },  
> > > 
> > > libvirt will blindly use this driver for all devices matching this as
> > > we've discussed how it should make use of modules.alias.  I don't think
> > > this driver should be squatting on devices where it doesn't add value
> > > and it's not clear whether this is adding or subtracting value in all
> > > cases for the one NIC that it modifies.  How should libvirt choose when
> > > and where to use this driver?  What regressions are we going to see
> > > with VMs that previously saw "modern" virtio-net devices and now see a
> > > legacy compatible device?  Thanks,  
> > 
> > Maybe this approach needs to use a subsystem ID match?
> > 
> > Jason  
> 
> Maybe make users load it manually?
> 
> Please don't bind to virtio by default, you will break
> all guests.

This would never bind by default, it's only bound as a vfio override
driver, but if libvirt were trying to determine the correct driver to
use with vfio for a 0x1af4 device, it'd land on this one.  Thanks,

Alex

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
