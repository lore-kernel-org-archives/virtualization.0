Return-Path: <SRS0=U4FE=NK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D19CC4338F
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 07:15:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5DBA6112D
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 07:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C5DBA6112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96BD860BC4;
	Thu, 19 Aug 2021 07:15:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yUZ_VyPC_Fqo; Thu, 19 Aug 2021 07:15:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 38E6760BB9;
	Thu, 19 Aug 2021 07:15:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13CD4C0010;
	Thu, 19 Aug 2021 07:15:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4814FC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 07:15:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3613C80DBD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 07:15:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PhV-mVd3gunu
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 07:15:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 49DA680DB9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 07:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629357321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JtvN6iNMdGmkea7B6V9eMJCEPu4udf3FXvOO7uWUum4=;
 b=bLm8/BPfmHyP3E1N+PqIRFHMEzwLTuJF7meH2hcZ3nbsL6Ec66GOXNlQgFEG1k6ET+fJyA
 1TQ1iA8mUHAyXYJSKnPavPYaYOVfOmSpkeUMYE4NW/OzYLUAxb/+nboF2z0IEhOIsBuizM
 WPQkxxKlpiMlo9kJKG4u7yqz0T1S470=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-Xnlzr900NSKAxmeqx5mVFg-1; Thu, 19 Aug 2021 03:15:20 -0400
X-MC-Unique: Xnlzr900NSKAxmeqx5mVFg-1
Received: by mail-lf1-f69.google.com with SMTP id
 k11-20020ac257cb000000b003ce6a4383f3so1628028lfo.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 00:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JtvN6iNMdGmkea7B6V9eMJCEPu4udf3FXvOO7uWUum4=;
 b=LhEqwzvvJ+fKSYECPJh9ncyvqpuiTbA+EH3aOnS+z/VwWlg0gBg3aM3BgmenGNeHvo
 dlv2l5eHa9DEiiO2aQBPSGzQdfjLoEJ4u8+aJ5cOeGPgQKMWXrKAe2Epktbsgg42O2mW
 KgggROi9amTwnkX42BKCUF9z/jjIx6QC0lTz2Vmaj0wKQT410vNFvLPgrNchTGt3/qnq
 +Qw5byhJedTVeb5TYMvwNoqCwODsG9ZxcUFGdUffDM00shSZ2L8kJucqbQuUxBKCYIpc
 QBoZxeG2Oo3mF3ChQ/BRrvWnUcBxxHBTFXNWnmasf2ybmrzmDD9wvt5bwKltE3PFHChK
 WkAA==
X-Gm-Message-State: AOAM531jX/qThHcU9pYewc2IjmkzW8SYvJLRaQaaR/gBauyKOTGIzIQn
 a5DfdKP8C8GvTrupdxbDGeAeMUrRBnp8F0ENI+IKv0x5p72r5kOvEJzWFr6DVGIqhdIYaNuSo8l
 764x79eOD1Vkhzsa2XqqCklApop8p6Lj8EvhhCbRETzYMqYdF5wOVAgIwHw==
X-Received: by 2002:a05:6512:4011:: with SMTP id
 br17mr9537705lfb.463.1629357318366; 
 Thu, 19 Aug 2021 00:15:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDA3yWRtHmt7+p9RDc2xD+8Qkk8UiFLDM/TOekxD9F1zwUbmVJhKNyUVwiHsXgcG+3dlBmW7TLAjHuRfYslT0=
X-Received: by 2002:a05:6512:4011:: with SMTP id
 br17mr9537689lfb.463.1629357318164; 
 Thu, 19 Aug 2021 00:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210805055623-mutt-send-email-mst@kernel.org>
 <e3b31032-222a-e1bc-f452-a965b456f48b@redhat.com>
 <20210806034817-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812C49AAA468E1E6A871A9DCF39@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210809053624-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CF2E07B38C45A2829B7BDCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210816165217-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819F68856798FBA8528BBADCFF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEs4fnV2RT8DSW3i0TtHL6t1rwuNyC-uLi3tRopb7mOhvA@mail.gmail.com>
 <20210818133309-mutt-send-email-mst@kernel.org>
 <4ee539aa-a7c6-d9b9-790c-b8fedc69e5c7@redhat.com>
 <PH0PR12MB54810DBD4DCB352FFEAB0550DCC09@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54810DBD4DCB352FFEAB0550DCC09@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 19 Aug 2021 15:15:07 +0800
Message-ID: <CACGkMEvc2OneOrLBbs_Dg1hcit6it=jLex5Ja7rQ-yaVucQCWA@mail.gmail.com>
Subject: Re: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
To: Parav Pandit <parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gVGh1LCBBdWcgMTksIDIwMjEgYXQgMToyMyBQTSBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRp
YS5jb20+IHdyb3RlOgo+Cj4KPgo+ID4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4KPiA+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMTksIDIwMjEgOTo1MiBBTQo+Cj4gPgo+
ID4g5ZyoIDIwMjEvOC8xOSDkuIrljYgxOjMzLCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+
ID4gPiBPbiBXZWQsIEF1ZyAxOCwgMjAyMSBhdCAxMjozMTozOVBNICswODAwLCBKYXNvbiBXYW5n
IHdyb3RlOgo+ID4gPj4gT24gV2VkLCBBdWcgMTgsIDIwMjEgYXQgMTE6MTUgQU0gUGFyYXYgUGFu
ZGl0IDxwYXJhdkBudmlkaWEuY29tPgo+ID4gd3JvdGU6Cj4gPiA+Pj4KPiA+ID4+Pgo+ID4gPj4+
PiBGcm9tOiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+ID4gPj4+PiBTZW50
OiBUdWVzZGF5LCBBdWd1c3QgMTcsIDIwMjEgMjoyNCBBTQo+ID4gPj4+Pgo+ID4gPj4+PiBPbiBN
b24sIEF1ZyAwOSwgMjAyMSBhdCAwOTo1MTo0OUFNICswMDAwLCBQYXJhdiBQYW5kaXQgd3JvdGU6
Cj4gPiA+Pj4+Pj4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4KPiA+
ID4+Pj4+PiBTZW50OiBNb25kYXksIEF1Z3VzdCA5LCAyMDIxIDM6MTAgUE0KPiA+ID4+Pj4+Pgo+
ID4gPj4+Pj4+IE9uIEZyaSwgQXVnIDA2LCAyMDIxIGF0IDA4OjU1OjU2QU0gKzAwMDAsIFBhcmF2
IFBhbmRpdCB3cm90ZToKPiA+ID4+Pj4+Pj4KPiA+ID4+Pj4+Pj4+IFRoZSBwb2ludCBpcyB0byB0
cnkgYW5kIG5vdCByZWludmVudCBhIGRlZGljYXRlZCB2cGRhIGludGVyZmFjZQo+ID4gPj4+Pj4+
Pj4gd2hlcmUgYSBnZW5lcmljIG9uZSBleGl0cy4KPiA+ID4+Pj4+Pj4+IEUuZy4gZm9yIHBoeSB0
aGluZ3Mgc3VjaCBhcyBtYWMgc3BlZWQgZXRjLCBJIHRoaW5rIG1vc3QgcGVvcGxlCj4gPiA+Pj4+
Pj4+PiBhcmUgdXNpbmcgZXRodG9vbCB0aGluZ3MgcmlnaHQ/Cj4gPiA+Pj4+Pj4+IEFzIHlvdSBr
bm93IHZkcGEgaXMgdGhlIGJhY2tlbmQgZGV2aWNlIGZvciB0aGUgZnJvbnQtZW5kCj4gPiA+Pj4+
Pj4+IG5ldGRldmljZQo+ID4gPj4+Pj4+IGFjY2Vzc2VkIGJ5IHRoZSBldGh0b29sLgo+ID4gPj4+
Pj4+PiB2ZHBhIG1hbmFnZW1lbnQgdG9vbCBoZXJlIGlzIGNvbXBvc2luZyB0aGUgdmRwYSBkZXZp
Y2UuCj4gPiA+Pj4+Pj4+Cj4gPiA+Pj4+Pj4+IEZvciBleGFtcGxlIGNyZWF0b3IgKGh5cGVydmlz
b3IpIG9mIHRoZSB2ZHBhIGRldmljZXMga25vd3MgdGhhdAo+ID4gPj4+Pj4+PiBhIGd1ZXN0IFZN
IGlzIGdpdmVuIDQgdmNwdXMsIFNvIGh5cGVydmlzb3IgY3JlYXRlcyBhIHZkcGEKPiA+ID4+Pj4+
Pj4gZGV2aWNlcyB3aXRoIGNvbmZpZyBzcGFjZSBsYXlvdXQgYXMsIG1heF92aXJ0cXVldWVfcGFp
cnMgPSA0Lgo+ID4gPj4+Pj4+PiBBbmQgdGhlIE1BQyBhZGRyZXNzIGNob3NlbiBieSBoeXBlcnZp
c29yIGluIG1hY1s2XS4KPiA+ID4+Pj4+Pj4KPiA+ID4+Pj4+Pj4gR3Vlc3QgVk0gZXRodG9vbCBj
YW4gc3RpbGwgY2hvc2UgdG8gdXNlIGxlc3MgbnVtYmVyIG9mIGNoYW5uZWxzLgo+ID4gPj4+Pj4+
Pgo+ID4gPj4+Pj4+PiBUeXBpY2FsbHksCj4gPiA+Pj4+Pj4+IGV0aHRvb2wgaXMgZm9yIGd1ZXN0
IFZNLgo+ID4gPj4+Pj4+PiB2ZHBhIGRldmljZSBpcyBpbiBoeXBldmlzb3IuCj4gPiA+Pj4+Pj4+
Cj4gPiA+Pj4+Pj4+IEhvdyBjYW4gaHlwZXJ2aXNvciBjb21wb3NlIGEgdmRwYSBkZXZpY2Ugd2l0
aG91dCBhbnkgdG9vbD8KPiA+ID4+Pj4+Pj4gSG93IGNhbiBpdCB0ZWxsIGV0aHRvb2wsIHdoYXQg
aXMgc3VwcG9ydGVkIGFuZCB3aGF0IGFyZSB0aGUKPiA+IGRlZmF1bHRzPwo+ID4gPj4+Pj4+Pgo+
ID4gPj4+Pj4+PiBJIG11c3QgYmUgbWlzdW5kZXJzdGFuZGluZyB5b3VyIGNvbW1lbnQgYWJvdXQg
ZXRodG9vbC4KPiA+ID4+Pj4+Pj4gQ2FuIHlvdSBwbGVhc2UgZXhwbGFpbj8KPiA+ID4+Pj4+Pgo+
ID4gPj4+Pj4+IEkgYW0gYmFzaWNhbGx5IHNheWluZyB0aGF0IHdlIHByb2JhYmx5IHdhbnQgdG8g
YmUgYWJsZSB0byBjaGFuZ2UKPiA+ID4+Pj4+PiBNQUMgb2YgYSBWRFBBIGRldmljZSBvbiB0aGUg
aG9zdCB3aXRob3V0IGRlc3JveWluZyBhbmQgcmVjcmVhdGluZwo+ID4gPj4+Pj4+IHRoZSBkZXZp
Y2UgYXMgbG9uZyBhcyBpdCdzIG5vdCBpbiB1c2UuCj4gPiA+Pj4+PiBPay4gSSB1bmRlcnN0b29k
IHlvdXIgY29tbWVudCBub3cuCj4gPiA+Pj4+PiBZZXMsIHRoaXMgd2FzIHRoZSBvYmplY3RpdmUg
d2hpY2ggaXMgd2h5IHRoZXkgYXJlIHByZXNlbnQgYXMKPiA+ID4+Pj4+IGluZGVwZW5kZW50Cj4g
PiA+Pj4+IGNvbmZpZyBrbm9iLgo+ID4gPj4+Pj4gSmFzb24gd2FzIHN1Z2dlc3RpbmcgdG8gaGF2
ZSB0aGVtIGFzIGNyZWF0aW9uIG9ubHkga25vYnMsIHdoaWNoCj4gPiA+Pj4+PiByZXF1aXJlcwo+
ID4gPj4+PiByZWNyZWF0ZS4KPiA+ID4+Pj4+IEkgZG9uJ3QgaGF2ZSBzdHJvbmcgb3BpbmlvbiBm
b3IgZWl0aGVyIG1ldGhvZC4KPiA+ID4+Pj4+Cj4gPiA+Pj4+PiBQYXNzaW5nIHRoZW0gYXQgY3Jl
YXRpb24gdGltZSBpcyBzaW1wbGVyIGZvciB1c2VyLgo+ID4gPj4+Pj4gSWYgdXNlciBuZWVkcyB0
aGUgYWJpbGl0eSB0byBtb2RpZnkgYW5kIHJldXNlIHNhbWUgZGV2aWNlIHdpdGgKPiA+ID4+Pj4+
IGRpZmZlcmVudAo+ID4gPj4+PiBjb25maWcsIGV4dGVuZGluZyBzdWNoIHN1cHBvcnQgaW4gZnV0
dXJlIGxpa2UgdGhpcyBwYXRjaCBzaG91bGQgcG9zc2libGUuCj4gPiA+Pj4+PiBTbyB0aGVyZSBh
cmUgdHdvIHF1ZXN0aW9ucyB0byBjbG9zZS4KPiA+ID4+Pj4+IDEuIENhbiB3ZSBzdGFydCB3aXRo
IGNvbmZpZyBwYXJhbXMgYXQgdmRwYSBkZXZpY2UgY3JlYXRpb24gdGltZT8KPiA+ID4+Pj4gSSdt
IG5vdCBzdXJlIHdoZXRoZXIgd2UgbmVlZCBib3RoIGJ1dCBJJ2QgbGlrZSB0byBzZWUgYSBmdWxs
IEFQSQo+ID4gPj4+PiBhbmQgSSB0aGluayB3ZSBhbGwgYWdyZWUgaG9zdCB3YW50cyBhYmlsaXR5
IHRvIHR3ZWFrIG1hYyBhZnRlcgo+ID4gPj4+PiBkZXZpY2UgY3JlYXRpb24gZXZlbiBpZiBndWVz
dCBpcyBub3QgYWxsb3dlZCB0byBjaGFuZ2UgbWFjLCByaWdodD8KPiA+ID4+Pj4KPiA+ID4+PiBZ
ZXMuCj4gPiA+Pj4gJCB2ZHBhIGRldiBhZGQgbmFtZSBmb28gbWdtdGRldiBwY2kvMDAwMDowMzow
MC4wIG1hYwo+ID4gPj4+IDAwOjExOjIyOjMzOjQ0OjU1IG1heHZxcyA4IG10dSA5MDAwCj4gPiA+
Pj4KPiA+ID4+PiBBYm92ZSBBUEkgaWYgd2UgZG8gYXQgY3JlYXRpb24gdGltZS4gSXQgaXMgbGlr
ZWx5IHNpbXBsZXIgZm9yIHVzZXIgdG8gcGFzcwo+ID4gbmVjZXNzYXJ5IHBhcmFtcyBkdXJpbmcg
Y3JlYXRpb24gdGltZS4KPiA+ID4+Pgo+ID4gPj4+Pj4gMi4gSXMgaXQgb2sgdG8gaGF2ZSB0aGVz
ZSBjb25maWcgcGFyYW1zIGFzIGluZGl2aWR1YWwgZmllbGRzIGF0Cj4gPiA+Pj4+PiBuZXRsaW5r
IFUtPksKPiA+ID4+Pj4gVUFQSSBsZXZlbD8KPiA+ID4+Pj4+IFRoaXMgaXMgdGhlIG1ldGhvZCBw
cm9wb3NlZCBpbiB0aGlzIHBhdGNoIHNlcmllcy4KPiA+ID4+Pj4+IChTaW1pbGFyIHRvIGluY3Jl
bWVudGFsbHkgZ3Jvd2luZyB2eGxhbiBpcCBsaW5rIGNvbW1hbmQpLgo+ID4gPj4+Pj4KPiA+ID4+
Pj4+IE9yCj4gPiA+Pj4+PiBUaGV5IHNob3VsZCBiZSBwYWNrZWQgaW4gYSBzdHJ1Y3R1cmUgYmV0
d2VlbiBVLT4gSyBhbmQgZGVhbCB3aXRoCj4gPiA+Pj4+IHR5cGVjYXN0aW5nIGJhc2VkIG9uIHNp
emUgYW5kIG1vcmU/Cj4gPiA+Pj4+PiAoSmFzb24ncyBpbnB1dCkuCj4gPiA+Pj4+IEknbSBpbmNs
aW5lZCB0byBzYXkgdnhsYW4gaXMgY2xvc2VyIHRvIGEgbW9kZWwgdG8gZm9sbG93Lgo+ID4gPj4+
IE9rLiB0aGFua3MgZm9yIHRoZSBmZWVkYmFjay4gV2UgYXJlIHVzaW5nIHRoZSBtb2RlbCBjbG9z
ZSB0byB2eGxhbi4KPiA+ID4+PiBMZXRzIHJlc29sdmUgc2hvdWxkIHdlIGhhdmUgaXQgYXQgY3Jl
YXRpb24gdGltZSwgcG9zdCBjcmVhdGlvbiBvciBib3RoPwo+ID4gPj4+IChhKSBDcmVhdGlvbiB0
aW1lCj4gPiA+Pj4gUHJvczoKPiA+ID4+PiAtIHNpbXBsZXIgc2luZ2xlIGFwaSBmb3IgdXNlcgo+
ID4gPj4+IC0gZWxpbWluYXRlcyBuZWVkcyBvZiBpbnZlbnRpbmcgc3RhdHMgcmVzZXQgaW4gZnV0
dXJlIHNlcmllcwo+ID4gPj4+IENvbnM6Cj4gPiA+Pj4gLSBpbmFiaWxpdHkgdG8gcmV1c2UgdGhl
IGRldmljZSB3aXRoIGRpZmZlcmVudCBjb25maWcKPiA+ID4+IFRoaXMgY2FuIGJlIHNvbHZlZCBi
eSBkZXN0cm95aW5nIHRoZSBpbnN0YW5jZSBhbmQgcmUtY3JlYXRpbmcgaXQgd2l0aAo+ID4gPj4g
YSBkaWZmZXJlbnQgcGFyYW1zPwo+ID4gPj4KPiA+ID4+PiAtIFRoaXMgbWF5IG5vdCBiZSBvZiBn
cmVhdCBhZHZhbnRhZ2UsIGFuZCBpdCBpcyBwcm9iYWJseSBmaW5lIHRvCj4gPiA+Pj4gaGF2ZSBj
cmVhdGlvbiB0aW1lIHBhcmFtcwo+ID4gPj4+Cj4gPiA+Pj4gKGIpIHBvc3QgY3JlYXRpb24gdGlt
ZToKPiA+ID4+PiBQcm9zOgo+ID4gPj4+IC0gYWJsZSB0byByZXVzZSB0aGUgZGV2aWNlIHdpdGgg
ZGlmZmVyZW50IGNvbmZpZyBmb3Igc2F5IGRpZmZlcmVudCBWTS4KPiA+ID4+PiAtIHdpbGwgcmVx
dWlyZSBzdGF0cyByZXNldCBpbiBmdXR1cmUgb25jZSBzdGF0cyBhcmUgaW1wbGVtZW50ZWQKPiA+
ID4+IEFueSByZWFzb24gZm9yIGRvaW5nIHRoaXMgb3RoZXIgdGhhbiByZS1jcmVhdGluZyB0aGUg
ZGV2aWNlPwo+ID4gPiBQZXJtaXNzaW9ucy4KPiA+Cj4gPgo+ID4gSSB3b3VsZCBleHBlY3QgdGhh
dCBDQVBfTkVUX0FETUlOIGlzIHJlcXVpcmVkIGZvciBib3RoIGNhc2VzLgo+Cj4gQ29ycmVjdC4g
UGF0Y2gtMyBpbiB0aGlzIHNlcmllcyBoYXMgdGhlIGNvZGUgZm9yIENBUF9ORVRfQURNSU4gZm9y
IHNldHRpbmcgdGhlIG1hYywgc25pcHBldCBiZWxvdy4KPiBGb3IgdmRwYSBuZXQgZGV2aWNlIGFk
ZGl0aW9uIHdlIGRvIG5vdCBoYXZlIHRoZSBjaGVjayB5ZXQuCj4KPiBZb3UvTWljaGFlbCBtZW50
aW9uZWQgdGhhdCBRRU1VIHJ1bnMgd2l0aG91dCBhbnkgcGVybWlzc2lvbnMgaW4gc29tZSBvdGhl
ciB0aHJlYWQuCj4gRG8geW91IG1lYW4gUUVNVSBjYW4gcnVuIHdpdGhvdXQgdGhlc2UgY2FwYWJp
bGl0aWVzPwoKWWVzLgoKPiBJZiB5ZXMsIGlzIGl0IGZhaXIgYXNrIGZvciBub24gUUVNVSBzdyB0
byBzZXR1cCB0aGUgdmRwYSBkZXZpY2Ugd2hpY2ggaGFzIHRoZSBoaWdoZXIgY2FwYWJpbGl0aWVz
IHRoYW4gUUVNVSBhbmQgYWZ0ZXIgdGhhdCBRRU1VIHJ1bnMgd2l0aCBsb3dlciBjYXBhYmlsaXRp
ZXM/CgpSaWdodCwgZS5nIGl0J3MgdGhlIGNoYXJnZSBvZiBsaWJ2aXJ0IG9yIG90aGVyIHByaXZp
bGVnZWQgcHJvY2VzcyB0bwp0aG9zZSBraW5kIG9mIGNvbmZpZ3VyYXRpb24uCgpTbyBJIGRvbid0
IHNlZSBob3cgaXQgZGlmZmVycyBmcm9tIGRldmljZSBjcmVhdGlvbiBmcm9tIHRoZSB2aWV3IG9m
IHBlcm1pc3Npb24uCgpUaGFua3MKCj4KPiArc3RhdGljIGludCB2ZHBhX2Rldl9uZXRfY29uZmln
X3NldChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgZ2VubF9pbmZvICppbmZvKSB7
Cj4gKyAgICAgICBzdHJ1Y3QgbmxhdHRyICoqbmxfYXR0cnMgPSBpbmZvLT5hdHRyczsKPiArICAg
ICAgIHN0cnVjdCB2ZHBhX2Rldl9zZXRfY29uZmlnIGNvbmZpZyA9IHt9Owo+ICsgICAgICAgY29u
c3QgdTggKm1hY2FkZHI7Cj4gKyAgICAgICBpbnQgZXJyOwo+ICsKPiArICAgICAgIGlmICghbmV0
bGlua19jYXBhYmxlKHNrYiwgQ0FQX05FVF9BRE1JTikpCj4gKyAgICAgICAgICAgICAgIHJldHVy
biAtRVBFUk07Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
