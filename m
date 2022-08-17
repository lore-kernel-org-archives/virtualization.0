Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17D6C25B08
	for <virtualization@archiver.kernel.org>; Wed, 17 Aug 2022 10:37:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 26E974013C;
	Wed, 17 Aug 2022 10:37:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 26E974013C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Dh+pCUig
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 43WPSUUrXLgb; Wed, 17 Aug 2022 10:37:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8F2FF40641;
	Wed, 17 Aug 2022 10:37:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F2FF40641
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58AF0C0033;
	Wed, 17 Aug 2022 10:37:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4FF8C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 10:37:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B13783267
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 10:37:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6B13783267
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Dh+pCUig
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oD1P9M6R5cly
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 10:37:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 35A358322E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 35A358322E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 10:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660732641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/bZCOzsQWglaIEflXVaKuMeO6kIO1iJlwntv9G+IQcI=;
 b=Dh+pCUigIb6qiHyyPaWg1MhEnNo2E9UKXecLR25/lDlDd7r+Iu7OvsjCw/7s/aPs/3xSfd
 jlfmd1QBnBWgQshwiK3b1Cl6B3XCQRvK6d5NnherRe8TtJTizNKx8BeS+cTnacyC/5CMjY
 7u9a2a5d0mQQxprpFDJEp5taO+DESjo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-455-Le29ICxtNVasjrXwBBEV3A-1; Wed, 17 Aug 2022 06:37:20 -0400
X-MC-Unique: Le29ICxtNVasjrXwBBEV3A-1
Received: by mail-wm1-f71.google.com with SMTP id
 v64-20020a1cac43000000b003a4bea31b4dso885758wme.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 03:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=/bZCOzsQWglaIEflXVaKuMeO6kIO1iJlwntv9G+IQcI=;
 b=jWVIb9aKXobzsW/JCaumWKqgMvO9UQcHO4RwTIKugIinChLOjS1GFi6Ojq3QviyLbB
 svM6thLbSG08j+aghrsvpmKNuwRe5slivbnK3aC8hZ+GfYfAd89l6Xy4KBlVEkTbrwIo
 OFuKJ7zSp7qtuZIoaum9gmEu3j6/z8P6mPyCbsJmGb93dRe2Tph/a2SN5e19/FdBIwPz
 5lbguZzLVIYl8FeuIPFQQdwWRVJF24YscFbfQ+4NlhhL2HaSEf+neo0pjQowkBAYaRfj
 8mATbLGFP/PJ0qTKXKFLXJX0xffW8Fcpv/UXdJTDc3jdt7sRag/GExy9kVcrtaMxvlLc
 hNVA==
X-Gm-Message-State: ACgBeo2KLBRjTCUt7GeB/BWp/HpklCr6VOqJVoSanpNf3oe0FZguSRE1
 Bktmkwsh48zXg+eq6eb0AS6nDjDTPJyh+dUbNWOfKOWhpZOxxM+zTH5661109osx7Vsg4135tHB
 IRHC5eHpc5PjmHf0x+s0ieDGo11WaWlz7EqydVpnpxw==
X-Received: by 2002:adf:d1e8:0:b0:223:bca:8019 with SMTP id
 g8-20020adfd1e8000000b002230bca8019mr13769498wrd.562.1660732638734; 
 Wed, 17 Aug 2022 03:37:18 -0700 (PDT)
X-Google-Smtp-Source: AA6agR78CQkZt1eehkXm5izHSD8H9NgPlq3Iq0IOh8rkYepCNOJ0f1/e81lieEPl5cN6j8AAmLR9Cw==
X-Received: by 2002:adf:d1e8:0:b0:223:bca:8019 with SMTP id
 g8-20020adfd1e8000000b002230bca8019mr13769482wrd.562.1660732638486; 
 Wed, 17 Aug 2022 03:37:18 -0700 (PDT)
Received: from redhat.com ([2.55.4.37]) by smtp.gmail.com with ESMTPSA id
 j18-20020a05600c191200b003a5f54e3bbbsm2012695wmq.38.2022.08.17.03.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Aug 2022 03:37:17 -0700 (PDT)
Date: Wed, 17 Aug 2022 06:37:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [PATCH 2/2] vDPA: conditionally read fields in virtio-net dev
Message-ID: <20220817063450-mutt-send-email-mst@kernel.org>
References: <c5075d3d-9d2c-2716-1cbf-cede49e2d66f@oracle.com>
 <20e92551-a639-ec13-3d9c-13bb215422e1@intel.com>
 <9b6292f3-9bd5-ecd8-5e42-cd5d12f036e7@oracle.com>
 <22e0236f-b556-c6a8-0043-b39b02928fd6@intel.com>
 <892b39d6-85f8-bff5-030d-e21288975572@oracle.com>
 <52a47bc7-bf26-b8f9-257f-7dc5cea66d23@intel.com>
 <20220817045406-mutt-send-email-mst@kernel.org>
 <a91fa479-d1cc-a2d6-0821-93386069a2c1@intel.com>
 <20220817053821-mutt-send-email-mst@kernel.org>
 <449c2fb2-3920-7bf9-8c5c-a68456dfea76@intel.com>
MIME-Version: 1.0
In-Reply-To: <449c2fb2-3920-7bf9-8c5c-a68456dfea76@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 gautam.dawar@amd.com
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

On Wed, Aug 17, 2022 at 05:43:22PM +0800, Zhu, Lingshan wrote:
> 
> 
> On 8/17/2022 5:39 PM, Michael S. Tsirkin wrote:
> > On Wed, Aug 17, 2022 at 05:13:59PM +0800, Zhu, Lingshan wrote:
> > > 
> > > On 8/17/2022 4:55 PM, Michael S. Tsirkin wrote:
> > > > On Wed, Aug 17, 2022 at 10:14:26AM +0800, Zhu, Lingshan wrote:
> > > > > Yes it is a little messy, and we can not check _F_VERSION_1 because of
> > > > > transitional devices, so maybe this is the best we can do for now
> > > > I think vhost generally needs an API to declare config space endian-ness
> > > > to kernel. vdpa can reuse that too then.
> > > Yes, I remember you have mentioned some IOCTL to set the endian-ness,
> > > for vDPA, I think only the vendor driver knows the endian,
> > > so we may need a new function vdpa_ops->get_endian().
> > > In the last thread, we say maybe it's better to add a comment for now.
> > > But if you think we should add a vdpa_ops->get_endian(), I can work
> > > on it for sure!
> > > 
> > > Thanks
> > > Zhu Lingshan
> > I think QEMU has to set endian-ness. No one else knows.
> Yes, for SW based vhost it is true. But for HW vDPA, only
> the device & driver knows the endian, I think we can not
> "set" a hardware's endian.

QEMU knows the guest endian-ness and it knows that
device is accessed through the legacy interface.
It can accordingly send endian-ness to the kernel and
kernel can propagate it to the driver.

> So if you think we should add a vdpa_ops->get_endian(),
> I will drop these comments in the next version of
> series, and work on a new patch for get_endian().
> 
> Thanks,
> Zhu Lingshan

Guests don't get endian-ness from devices so this seems pointless.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
