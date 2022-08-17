Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D85AC2BB41
	for <virtualization@archiver.kernel.org>; Wed, 17 Aug 2022 09:39:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23A00610A9;
	Wed, 17 Aug 2022 09:39:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 23A00610A9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dDJIW+mZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eaqMH5DcWhMk; Wed, 17 Aug 2022 09:39:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B2B1A610A7;
	Wed, 17 Aug 2022 09:39:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B2B1A610A7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88E5FC0032;
	Wed, 17 Aug 2022 09:39:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2540EC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 09:39:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E77C38316F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 09:39:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E77C38316F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dDJIW+mZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l6ad6YE5qcEa
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 09:39:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 32545831E3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 32545831E3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 09:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660729147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uCWFnHQ16wzAyfLqhgH3u92LY8Ti6Pimk17aa5yv5fA=;
 b=dDJIW+mZTvGcBDYx7+Syk+zhJnWJKEcWdBULZzU3HnEhw3gqg+BSMGj6QnLlRCnXAl6As1
 VfT2/yntrhY2iZfMy2Ig0CrDVV+uny4lUFTM+fOdKIK1ox8iIEnXHEqxgeaZwKD5BtbRu9
 Lg2oJ9zwjYqH0M/x0N8gHAkOAg90PwA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-510-WQjLaDiMNtm2Yo4AApP3Ew-1; Wed, 17 Aug 2022 05:39:06 -0400
X-MC-Unique: WQjLaDiMNtm2Yo4AApP3Ew-1
Received: by mail-wr1-f72.google.com with SMTP id
 r8-20020adfbb08000000b00225239ce4deso264064wrg.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 02:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=uCWFnHQ16wzAyfLqhgH3u92LY8Ti6Pimk17aa5yv5fA=;
 b=V8lc31LYAGxH2v9TDnQUkqmRVfylAXl++JxqYfQdTq1VzwEMXY+ABrqFMPGqwRi5sE
 eXAobvNqETSNILfNFo0t7aTL7WThtdcuyL+gbb54W8AV8urakCQ0F0vQONJ0JtfRdrSm
 aLc2hQ7erz6IMmcrWw3OIRU79JYlWGAZ2NUtriprt+dApCLhv2VbduMoou05NJ66bJJ1
 lWH7JzCstUP2NMO50Rsu89ASy6SIvAAr4s898yHVzetPCO+ecPPmfZK0OVIpAlGROWtx
 Oq0ba3e5j3IQfWdkdBDEl4BoaVFOCLomzjDktVOVAlS5u80OMNq4NwFiJe8tcT9PKjke
 7EHQ==
X-Gm-Message-State: ACgBeo0DPVdCCq/hooGOpOfw3N2P3lfD7IZNcNFTddjk8n+/0v1QRST1
 mt0Iodl02prukuge6NvjJZj3ejU4pTLPjYFAWgI70hzmErHLdrPkQUAg627RoWFZDjk2PUfzIsv
 GT7xKegwVwdTYeH5aDvBlLhLVrF5LqjQRVLKP2X6Auw==
X-Received: by 2002:a05:600c:4f43:b0:3a6:16ca:8da4 with SMTP id
 m3-20020a05600c4f4300b003a616ca8da4mr1046868wmq.80.1660729145423; 
 Wed, 17 Aug 2022 02:39:05 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4cPA7l/7H4bPIK6iO/7Zz25XZgkwFi9eBr3P75wwIDPTk0z86KyHtRlguCWqedGIUY46T51Q==
X-Received: by 2002:a05:600c:4f43:b0:3a6:16ca:8da4 with SMTP id
 m3-20020a05600c4f4300b003a616ca8da4mr1046849wmq.80.1660729145162; 
 Wed, 17 Aug 2022 02:39:05 -0700 (PDT)
Received: from redhat.com ([2.55.43.215]) by smtp.gmail.com with ESMTPSA id
 h82-20020a1c2155000000b003a319bd3278sm1559876wmh.40.2022.08.17.02.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Aug 2022 02:39:04 -0700 (PDT)
Date: Wed, 17 Aug 2022 05:39:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [PATCH 2/2] vDPA: conditionally read fields in virtio-net dev
Message-ID: <20220817053821-mutt-send-email-mst@kernel.org>
References: <20220815092638.504528-1-lingshan.zhu@intel.com>
 <20220815092638.504528-3-lingshan.zhu@intel.com>
 <c5075d3d-9d2c-2716-1cbf-cede49e2d66f@oracle.com>
 <20e92551-a639-ec13-3d9c-13bb215422e1@intel.com>
 <9b6292f3-9bd5-ecd8-5e42-cd5d12f036e7@oracle.com>
 <22e0236f-b556-c6a8-0043-b39b02928fd6@intel.com>
 <892b39d6-85f8-bff5-030d-e21288975572@oracle.com>
 <52a47bc7-bf26-b8f9-257f-7dc5cea66d23@intel.com>
 <20220817045406-mutt-send-email-mst@kernel.org>
 <a91fa479-d1cc-a2d6-0821-93386069a2c1@intel.com>
MIME-Version: 1.0
In-Reply-To: <a91fa479-d1cc-a2d6-0821-93386069a2c1@intel.com>
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

On Wed, Aug 17, 2022 at 05:13:59PM +0800, Zhu, Lingshan wrote:
> 
> 
> On 8/17/2022 4:55 PM, Michael S. Tsirkin wrote:
> > On Wed, Aug 17, 2022 at 10:14:26AM +0800, Zhu, Lingshan wrote:
> > > Yes it is a little messy, and we can not check _F_VERSION_1 because of
> > > transitional devices, so maybe this is the best we can do for now
> > I think vhost generally needs an API to declare config space endian-ness
> > to kernel. vdpa can reuse that too then.
> Yes, I remember you have mentioned some IOCTL to set the endian-ness,
> for vDPA, I think only the vendor driver knows the endian,
> so we may need a new function vdpa_ops->get_endian().
> In the last thread, we say maybe it's better to add a comment for now.
> But if you think we should add a vdpa_ops->get_endian(), I can work
> on it for sure!
> 
> Thanks
> Zhu Lingshan

I think QEMU has to set endian-ness. No one else knows.

> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
