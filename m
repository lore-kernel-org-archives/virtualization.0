Return-Path: <SRS0=J2aX=NH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2BEC4320A
	for <virtualization@archiver.kernel.org>; Mon, 16 Aug 2021 20:51:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908FC60FDA
	for <virtualization@archiver.kernel.org>; Mon, 16 Aug 2021 20:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 908FC60FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4B447400F4;
	Mon, 16 Aug 2021 20:51:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W-QE0ZJkSKsR; Mon, 16 Aug 2021 20:51:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D384D402F2;
	Mon, 16 Aug 2021 20:51:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2755C0010;
	Mon, 16 Aug 2021 20:51:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E91A4C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 20:51:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D8DC180E91
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 20:51:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tRA_UQ5ouu05
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 20:51:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1755680E81
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 20:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629147070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nezBhRzGRO8/tDJu4lidssTTxDaXeeuciraua8okEFM=;
 b=DYkTGPeQc4NMA4Z1izBhLzA8VmhLYmv4lAWvYUvS/u3Yx+UM6veiGUH0uwcER5tF/OGZwo
 cy5awMC3pyXTgSr+mOLSsSAAjBA1syFwLAqAt7C3shNYlidHq0fA1Sm1ZksPNeGnJSYoA0
 tH0yPO/UAokxYtrurFv/sySTMjk1KJk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-1lna09dnNA2r0ADiPBrOKQ-1; Mon, 16 Aug 2021 16:51:09 -0400
X-MC-Unique: 1lna09dnNA2r0ADiPBrOKQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 y22-20020a0564023596b02903bd9452ad5cso9428351edc.20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 13:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=nezBhRzGRO8/tDJu4lidssTTxDaXeeuciraua8okEFM=;
 b=cD8Ywv2qhpISDYIJZ2IdbodBBcgrCqurq6Tiak/rOvTNTqZ/IPPBr6Nr8kHN8tIPkb
 i5/Yus3oRCFP1MMK7s7zIYE0d7BITxPsS83FlbjNYq1kmcRURmHTwE+9v3QrSyVG5wnz
 wx13bLZwmv1OuIpNzjLNG/0FS/cNKHIHmubFIicM9RshiiKFk+oVOCj3bH9mDHGXeVro
 kvvxgP2HBNe97SLK1DlYErE+ih1h0U+dVo8WM29tcQGq2r99781aPF7iwiJZx6R0DjzX
 Rc408GqN7jkDLTF5qOnv0OATy/G3e35QG9sUXHh0dOItxuo9MFn5o7ZxcWDkcONSZcEM
 wYnQ==
X-Gm-Message-State: AOAM533gBUtHK2shoUzWBGi5AmM7kCvHFQX85rmWw8ZcMu9UYE5tk/Db
 fYba+3kXHP0ICCjaSq87B3KTKHIeazskC9l9gl9evCD9T7/KeFNZtvP2GPq7sGcYnTVrRaAvUD7
 Vh1F1N2rRV8Pxm0eeZVD6fiju4H1mtPtXbDWtwEuJDw==
X-Received: by 2002:a17:906:f298:: with SMTP id
 gu24mr22673ejb.334.1629147067939; 
 Mon, 16 Aug 2021 13:51:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYYvhwWoxKiBf+lL9yG+hy1LuaH/1Y8s+RUPkUxqZI/Iirj8SHyMDinH+7LYeyTyPlVxshzw==
X-Received: by 2002:a17:906:f298:: with SMTP id
 gu24mr22662ejb.334.1629147067781; 
 Mon, 16 Aug 2021 13:51:07 -0700 (PDT)
Received: from redhat.com ([2.55.150.133])
 by smtp.gmail.com with ESMTPSA id f12sm121943ejz.99.2021.08.16.13.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Aug 2021 13:51:06 -0700 (PDT)
Date: Mon, 16 Aug 2021 16:51:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Message-ID: <20210816165029-mutt-send-email-mst@kernel.org>
References: <20210806034817-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812C49AAA468E1E6A871A9DCF39@PH0PR12MB5481.namprd12.prod.outlook.com>
 <be8a0173-b7fb-eabf-bc4a-9492133674ef@redhat.com>
 <20210809052121.GA209158@mtl-vdi-166.wap.labs.mlnx>
 <PH0PR12MB5481F74DCC09018C476D7262DCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210809055748.GA210406@mtl-vdi-166.wap.labs.mlnx>
 <PH0PR12MB5481E4454B3785A40AB8A181DCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210809060746.GA210718@mtl-vdi-166.wap.labs.mlnx>
 <PH0PR12MB54813DD5B2E36DEF5364C1A5DCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvqOBL40h7wRq9atZ=L6DwR_CuSE_ZTZ4aMHnuSxNbKSw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvqOBL40h7wRq9atZ=L6DwR_CuSE_ZTZ4aMHnuSxNbKSw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gTW9uLCBBdWcgMDksIDIwMjEgYXQgMDM6MDU6MzFQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiA+IFNvIEkgZG9u4oCZdCBzZWUgdGhlbSBhcyBtdXR1YWxseSBleGNsdXNpdmUgY2FwYWJp
bGl0eS4KPiAKPiBZZXMsIHdlIHByb2JhYmx5IG5lZWQgYm90aC4KPiAKPiBDVlEgZm9yIHBvc3Qg
Y3JlYXRpb24gY29uZmlndXJhdGlvbiBhbmQgbmV0bGluayBBUEkgZm9yIHByb3Zpc2lvbmluZy4K
ClRvIG5vdGUgd2hlbiBob3N0IHdhbnRzIHRvIGNoYW5nZSBwb3N0IHByb3Zpc2lvbmluZyBpdCB3
aWxsIGFsc28gdXNlCm5ldGxpbmsgSSBndWVzcy4KCj4gPgo+ID4gPiBidXQgaXQncyBiZWluZyB1
c2VkIGFsbCBvdmVyIGFuZCBMaW51eCBoYXMgYSBzcGVjaWZpYyBBUEkgdG8KPiA+ID4gZ2VuZXJh
dGUgcmFuZG9tIE1BQyBhZGRyZXNzZXM6IGV0aF9od19hZGRyX3JhbmRvbSgpLgo+IAo+IFllcywg
YnV0IGl0IHVzZXMgbG9jYWwgYXNzaWdubWVudCBiaXQsIG1hbmFnZW1lbnQgbWF5IHdhbnQgdXNl
IG90aGVycy4KPiAKPiBUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
