Return-Path: <SRS0=J2aX=NH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D39C4338F
	for <virtualization@archiver.kernel.org>; Mon, 16 Aug 2021 05:58:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C4AF61A02
	for <virtualization@archiver.kernel.org>; Mon, 16 Aug 2021 05:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C4AF61A02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C23D040206;
	Mon, 16 Aug 2021 05:58:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g1ipTuJNykpJ; Mon, 16 Aug 2021 05:58:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1E20B400CD;
	Mon, 16 Aug 2021 05:58:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1C2FC0010;
	Mon, 16 Aug 2021 05:58:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6307C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 05:58:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A2171606DB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 05:58:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 81cXjqERyee1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 05:58:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B1815606C0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 05:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629093493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zzBGJJqBFSBoFMd/7VL7kFohdNwb5iPjMELIiRJfV74=;
 b=guYea8cZUETwykvZyUW6KzIpcgqQYe6KPWRbUVT4/pRbM/lVDmkZNFpf342Nchj15e9Usm
 h3V0Qo9uySENZoffmoQvBH9X5amwDHxPmW6pSU9SV2iMPCFYqqL3zr07QPdibwfV8FjAnt
 ci9fjz/SSsuhMeIfpX65ckFpDdSxJn0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-ZK8WIgImNfeoNapQvOUKxw-1; Mon, 16 Aug 2021 01:58:11 -0400
X-MC-Unique: ZK8WIgImNfeoNapQvOUKxw-1
Received: by mail-pj1-f70.google.com with SMTP id
 k17-20020a17090aaa11b02901788cbc8832so11917776pjq.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 Aug 2021 22:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=zzBGJJqBFSBoFMd/7VL7kFohdNwb5iPjMELIiRJfV74=;
 b=T1OPZmcwaBz/wRHHZF6S55v/TiShsv7B6IMnrVA48zRoB7KKFwHavrtO4/URqzhGzF
 cktlCO+I76WwHbtHNJHHVkEie5EhcWLVR4wGNsp+Z3ZfVPo/eka0/ZaDug1GQonPTs7k
 KIOMdPYlOyubvLaze/LIEYVJJB9saiBjlZzoFG2ZrJRGX5Y+VBua9HatykaAM1XfxfLs
 QWR9Ztt0ml+w46ZFRDf8U/9QL+1QJ+P5ybA1Cu38HMatZkvaBu769CHQPOQ5dYAxg4Vj
 Z2PfmeWt+bTm8yXsD6D6Yws9W6mMXZg1yxwgjMq21UcCzXLnAP9SINT/LOnk9+4LE9Jg
 UMOg==
X-Gm-Message-State: AOAM5327YQtJWK80hKzRZalCJRjNtZeahsYcveC7Tx2UpR+oJbMrfZDO
 zAm9/J3H7XGsHWDrnVPItFi2h0kdo9Swbo0EC8xqlKoY6hETtxlYN5JjVrUmTk/tw1G12gE41cA
 ecRYakiwYA2Sv4bDUYVkIcwimbA7dvR7hlmGkE3zoBA==
X-Received: by 2002:a63:3501:: with SMTP id c1mr14274039pga.280.1629093490700; 
 Sun, 15 Aug 2021 22:58:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkiGCnDPpCh/MwpUjd33MQ340tsoqbZeAEA8xBjekeNfawVjNBW6sRCOlogMIbXpzdOE8T/g==
X-Received: by 2002:a63:3501:: with SMTP id c1mr14274020pga.280.1629093490496; 
 Sun, 15 Aug 2021 22:58:10 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 22sm11739146pgn.88.2021.08.15.22.58.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Aug 2021 22:58:10 -0700 (PDT)
Subject: Re: [Patch v1 3/3] vdpa/mlx5: Add multiqueue support
To: Eli Cohen <elic@nvidia.com>
References: <20210811075347.GC56418@mtl-vdi-166.wap.labs.mlnx>
 <fccc39c8-f9af-e489-8804-511cb07f1ed2@redhat.com>
 <20210811110401.GB64192@mtl-vdi-166.wap.labs.mlnx>
 <c318303b-3774-909a-a532-2189e9e5a3b9@redhat.com>
 <20210812045535.GA99755@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEsyHiia5DrRU0nLy_OkUZLcQ1==y4Gxy1sETWpVQpVXvg@mail.gmail.com>
 <20210812070151.GA103566@mtl-vdi-166.wap.labs.mlnx>
 <2cc15e3e-bd5c-8e43-1d2f-b0e03b8690d5@redhat.com>
 <20210812095035.GA105096@mtl-vdi-166.wap.labs.mlnx>
 <61b913bb-3f6b-49d4-f5f1-32dce3bd7fae@redhat.com>
 <20210816054746.GA30532@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3f26a849-d1a8-49e2-cb60-d58d7c4cbcd9@redhat.com>
Date: Mon, 16 Aug 2021 13:58:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210816054746.GA30532@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: eperezma <eperezma@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 mst <mst@redhat.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIxLzgvMTYg5LiL5Y2IMTo0NywgRWxpIENvaGVuIOWGmemBkzoKPiBPbiBNb24sIEF1
ZyAxNiwgMjAyMSBhdCAxMjoxNjoxNFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiDlnKgg
MjAyMS84LzEyIOS4i+WNiDU6NTAsIEVsaSBDb2hlbiDlhpnpgZM6Cj4+PiBPbiBUaHUsIEF1ZyAx
MiwgMjAyMSBhdCAwMzowNDozNVBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+IOWcqCAy
MDIxLzgvMTIg5LiL5Y2IMzowMSwgRWxpIENvaGVuIOWGmemBkzoKPj4+Pj4gT24gVGh1LCBBdWcg
MTIsIDIwMjEgYXQgMDI6NDc6MDZQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+IE9u
IFRodSwgQXVnIDEyLCAyMDIxIGF0IDEyOjU1IFBNIEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29t
PiB3cm90ZToKPj4+Pj4+PiBPbiBUaHUsIEF1ZyAxMiwgMjAyMSBhdCAxMToxOToxOUFNICswODAw
LCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+Pj4+PiDlnKggMjAyMS84LzExIOS4i+WNiDc6MDQsIEVs
aSBDb2hlbiDlhpnpgZM6Cj4+Pj4+Pj4+PiBPbiBXZWQsIEF1ZyAxMSwgMjAyMSBhdCAwNDozNzo0
NFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+Pj4+Pj4+IOWcqCAyMDIxLzgvMTEg5LiL
5Y2IMzo1MywgRWxpIENvaGVuIOWGmemBkzoKPj4+Pj4+Pj4+Pj4+IE9uZSB0aGluZyBuZWVkIHRv
IHNvbHZlIGZvciBtcSBpcyB0aGF0IHRoZToKPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pgo+Pj4+
Pj4+Pj4+Pj4+ICtzdGF0aWMgdTE2IGN0cmxfdnFfaWR4KHN0cnVjdCAgbWx4NV92ZHBhX2RldiAq
bXZkZXYpCj4+Pj4+Pj4+Pj4+Pj4gK3sKPj4+Pj4+Pj4+Pj4+PiArICAgICByZXR1cm4gMiAqICBt
bHg1X3ZkcGFfbWF4X3FwcyhtdmRldi0+bWF4X3Zxcyk7Cj4+Pj4+Pj4+Pj4+Pj4gK30KPj4+Pj4+
Pj4+Pj4+IFdlIHNob3VsZCBoYW5kbGUgdGhlIGNhc2Ugd2hlbiBNUSBpcyBzdXBwb3J0ZWQgYnkg
dGhlIGRldmljZSBidXQgbm90IHRoZQo+Pj4+Pj4+Pj4+Pj4gZHJpdmVyLgo+Pj4+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+Pj4+IEUuZyBpbiB0aGUgY2FzZSB3aGVuIHdlIGhhdmUgMiBxdWV1ZSBwYWlyczoK
Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+PiBXaGVuIE1RIGlzIGVuYWJsZWQsIGN2cSBpcyBxdWV1
ZSA0Cj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4gV2hlbiBNUSBpcyBub3QgZW5hYmxlZCwgY3Zx
IGlzIHF1ZXVlIDIKPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+IFRoZXJlJ3Mgc29tZSBpc3N1ZSB3
aXRoIHRoaXMuIEkgZ2V0IGNhbGxiYWNrcyB0YXJnZXRpbmcgc3BlY2lmaWMKPj4+Pj4+Pj4+Pj4g
dmlydHF1ZXVlcyBiZWZvcmUgZmVhdHVyZXMgbmVnb3RpYXRpb24gaGFzIGJlZW4gY29tcGxldGVk
Lgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+PiBTcGVjaWZpY2FsbHksIEkgZ2V0IHNldF92cV9jYigp
IGNhbGxzLiBBdCB0aGlzIHBvaW50IEkgbXVzdCBrbm93IHRoZQo+Pj4+Pj4+Pj4+PiBjb250cm9s
IHZxIGluZGV4Lgo+Pj4+Pj4+Pj4+IFNvIEkgdGhpbmsgd2UgbmVlZCBkbyBib3RoOgo+Pj4+Pj4+
Pj4+Cj4+Pj4+Pj4+Pj4gMSkgQXQgb25lIGhhbmQsIGl0J3MgYSBidWcgZm9yIHRoZSB1c2Vyc3Bh
Y2UgdG8gdXNlIHZxX2luZGV4IGJlZm9yZSBmZWF0dXJlCj4+Pj4+Pj4+Pj4gaXMgbmVnb3RpYXRl
ZAo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gKGxvb2tzIGxpa2UgYSBidWcgaW4gbXkgY3ZxIHNlcmll
cyB0aGF0IHdpbGwgY2FsbCBTRVRfVlJJTkdfQ0FMTCBiZWZvcmUKPj4+Pj4+Pj4+PiBmZWF0dXJl
IGlzIG5lZ290aWF0ZSwgd2hpY2ggSSB3aWxsIGxvb2spLgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4g
MikgQXQgdGhlIG90aGVyIGhhbmQsIHRoZSBkcml2ZXIgc2hvdWxkIGJlIGFibGUgdG8gZGVhbCB3
aXRoIHRoYXQKPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gQWxsIEkgY2FuIGRvIGlzIGRyb3AgY2FsbGJh
Y2tzIGZvciBWUXMgYmVmb3JlIGZlYXR1cmVzIG5lZ290YXRpb24gaGFzCj4+Pj4+Pj4+PiBiZWVu
IGNvbXBsZXRlZC4KPj4+Pj4+Pj4gT3IganVzdCBsZWF2ZSBxdWV1ZSBpbmRleCAwLCAxIHdvcmsu
Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+IFNpbmNlIGl0IGlzIG5vdCBleHBlY3RlZCB0byBiZSBjaGFuZ2Vk
Lgo+Pj4+Pj4+Pgo+Pj4+Pj4+IFJpZ2h0LCB3aWxsIGRvLgo+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+IEkg
dGhpbmsgdGhlIENWUSBpbmRleCBtdXN0IG5vdCBkZXBlbmQgb24gdGhlIG5lZ290aWF0ZWQgZmVh
dHVyZXMgYnV0Cj4+Pj4+Pj4+Pj4+IHJhdGhlciBkZXBlbmQgb2YgdGhlIHZhbHVlIHRoZSBkZXZp
Y2UgZHJpdmVyIHByb3ZpZGVzIGluIHRoZSBjYWxsIHRvCj4+Pj4+Pj4+Pj4+IF92ZHBhX3JlZ2lz
dGVyX2RldmljZSgpLgo+Pj4+Pj4+Pj4+IEF0IHRoZSB2aXJ0aW8gbGV2ZWwsIGl0J3MgdG9vIGxh
dGUgdG8gY2hhbmdlIHRoYXQgYW5kIGl0IGJyZWFrcyB0aGUgYmFja3dhcmQKPj4+Pj4+Pj4+PiBj
b21wYXRpYmlsaXR5Lgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gQnV0IGF0IHRoZSB2RFBBIGxldmVs
LCB0aGUgdW5kZXIgbGF5ZXIgZGV2aWNlIGNhbiBtYXAgdmlydGlvIGN2cSB0byBhbnkgb2YKPj4+
Pj4+Pj4+PiBpdCdzIHZpcnRxdWV1ZS4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IEUuZyBtYXAgY3Zx
IChpbmRleCAyKSB0byBtbHg1IGN2cSAodGhlIGxhc3QpLgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBJ
IGFtIG5vdCBmb2xsb3dpbmcgeW91IGhlcmUuIEkgc3RpbGwgZG9uJ3Qga25vdyB3aGF0IGluZGV4
IGlzIGN2cS4KPj4+Pj4+Pj4gUmlnaHQsIHdlIHN0aWxsIG5lZWQgdG8gd2FpdCBmb3IgdGhlIGZl
YXR1cmUgYmVpbmcgbmVnb3RpYXRlZCBpbiBvcmRlciB0bwo+Pj4+Pj4+PiBwcm9jZWVkLgo+Pj4+
Pj4+Pgo+Pj4+Pj4+IFNvIHRvIHN1bW1hcmlzZSwgYmVmb3JlIGZlYXR1cmUgbmVnb3RpYXRpb24g
Y29tcGxldGUsIEkgYWNjZXB0IGNhbGxzCj4+Pj4+Pj4gcmVmZXJyaW5nIHRvIFZRcyBvbmx5IGZv
ciBpbmRpY2VzIDAgYW5kIDEuCj4+Pj4+Pj4gQWZ0ZXIgZmVhdHVyZSBuZWdvdGlhdGlvbiBjb21w
bGV0ZSBJIGtub3cgQ1ZRIGluZGV4IGFuZCB3aWxsIGFjY2VwdAo+Pj4+Pj4+IGluZGljZXMgMCB0
byBjdnEgaW5kZXguCj4+Pj4+PiBJIGRvbid0IGdldCB0aGlzICJhY2NlcHQgaW5kaWNlcyAwIHRv
IGN2cSBpbmRleCIuCj4+Pj4+IFdoYXQgSSBtZWFudCB0byBzYXkgaXMgdGhhdCB0aGVyZSBhcmUg
c2V2ZXJhbCBjYWxsYmFja3MgdGhhdCByZWZlciB0bwo+Pj4+PiBzcGVjaWZpYyB2aXJ0cXVldWVz
LCBlLmcuIHNldF92cV9hZGRyZXNzKCksIHNldF92cV9udW0oKSBldGMuIFRoZXkgYWxsCj4+Pj4+
IGFjY2VwdCB2aXJ0cXVldWUgaW5kZXggYXMgYW4gYXJndW1lbnQuCj4+Pj4+Cj4+Pj4+IFdoYXQg
d2Ugd2FudCB0byBkbyBpcyB2ZXJpZnkgd2hlYXRoZXIgdGhlIGluZGV4IHByb3ZpZGVkIGlzIHZh
bGlkIG9yCj4+Pj4+IG5vdC4gSWYgaXQgaXMgbm90IHZhbGlkLCBlaXRoZXIgcmV0dXJuIGVycm9y
IChpZiB0aGUgY2FsbGJhY2sgY2FuIHJldHVybgo+Pj4+PiBhIHZhbHVlKSBvciBqdXN0IGF2b2lk
IHByb2Nlc3NpbmcgaXQuIElmIHRoZSBpbmRleCBpcyB2YWxpZCB0aGVuIHdlCj4+Pj4+IHByb2Nl
c3MgaXQgbm9ybWFsbHkuCj4+Pj4+Cj4+Pj4+IE5vdyB3ZSBuZWVkIHRvIGRlY2lkZSB3aGljaCBp
bmRleCBpcyB2YWxpZCBvciBub3QuIFdlIG5lZWQgc29tZXRoaW5nCj4+Pj4+IGxpa2UgdGhpcyB0
byBpZGVudGlmaXkgdmFsaWQgaW5kZXhlcyByYW5nZToKPj4+Pj4KPj4+Pj4gQ1ZRIGNsZWFyOiAw
IGFuZCAxCj4+Pj4+IENWUSBzZXQsIE1RIGNsZWFyOiAwLCAxIGFuZCAyIChmb3IgQ1ZRKS4KPj4+
Pj4gQ1ZRIHNldCwgTVEgc2V0OiAwLi5udnEgd2hlcmUgbnZxIGlzIHdoYXRldmVyIHByb3ZpZGVk
IHRvCj4+Pj4+IF92ZHBhX3JlZ2lzdGVyX2RldmljZSgpCj4+Pj4gWWVzLgo+Pj4+Cj4+PiBVbmZv
cnR1bmF0ZWx5IGl0IGRvZXMgbm90IHdvcmsuCj4+PiBzZXRfdnFfY2IoKSBmb3IgYWxsIHRoZSBt
dWx0aXF1ZXVlcyBpcyBjYWxsZWQgYmVvZnJlIGZlYXR1cmUKPj4+IG5lZ290aWF0aW9uLiBJZiBJ
IGFwcGx5IHRoZSBhYm92ZSBsb2dpYywgSSB3aWxsIGxvc2UgdGhlc2Ugc2V0dGluZ3MuCj4+Pgo+
Pj4gSSBjYW4gbWFrZSBhbiBleGNlcHRpb24gZm9yIHNldF92cV9jYigpLCBzYXZlIGNhbGxiYWNr
cyBhbmQgcmVzdG9yZQo+Pj4gdGhlbSBhZnRlcndhcmRzLiBUaGlzIGxvb2tzIHRvbyBjb252b2x1
dGVkIGFuZCBtYXliZSB3ZSBzaG91bGQgc2Vlawo+Pj4gYW5vdGhlciBzb2x1dGlvbi4KPj4KPj4g
SSBhZ3JlZS4KPj4KPj4KPj4+IExldCBtZSBrbm93IHdoYXQgeW91IHRoaW5rLgo+Pgo+PiBSZXRo
aW5rIGFib3V0IHRoaXMgaXNzdWUuIEl0IGxvb2tzIHRvIHRoZSBvbmx5IGlzc3VlIHdlIGZhY2Ug
aXMgdGhlCj4+IHNldF92cV9jYigpLgo+Pgo+PiBXaXRoIHRoZSBhc3N1bXB0aW9uIHRoYXQgdGhl
IHVzZXJzcGFjZSBjYW4gdXNlIHRoZSBpbmRleCBjb3JyZWN0bHkgKGV2ZW4KPj4gYmVmb3JlIHNl
dF9mZWF0dXJlcykuIEkgd29uZGVyIHRoZSBmb2xsb3dpbmcgd29ya3MuCj4+Cj4+IEluc3RlYWQg
b2YgY2hlY2tpbmcgd2hldGhlciB0aGUgaW5kZXggaXMgY3ZxIGluIHNldF92cV9jYigpIGhvdyBh
Ym91dDoKPj4KPj4gMSkgZGVjb3VwbGUgZXZlbnRfY2Igb3V0IG9mIG1seDVfdmRwYV92aXJ0cXVl
dWUgYW5kIG1seDVfY29uZ3JvX3ZxCj4+IDIpIGhhdmUgYSBkZWRpY2F0ZWQgZXZlbnRfY2IgYXJy
YXkgaW4gbWx4NV92ZHBhX25ldAo+PiAzKSB0aGVuIHdlIGNhbiBkbwo+Pgo+PiBuZGV2LT5ldmVu
dF9jYnNbaW5kZXhdID0gKmNiOwo+Pgo+IFNvIGFjdHVhbGx5IHlvdSdyZSBzdWdnZXN0aW5nIHRv
IHNhdmUgYWxsIHRoZSBjYWxsYWJjayBjb25maWd1cmF0aW9ucyBpbgo+IGFuIGFycmF5IGFuZCBl
dmFsdWF0ZSBjdnEgaW5kZXggYWZ0ZXIgZmVhdHVyZSBuZWdvdGlhdGlvbiBoYXMgYmVlbgo+IGNv
bXBsZXRlZC4KCgpZZXMuCgoKPgo+IEkgdGhpbmsgdGhhdCBjb3VsZCB3b3JrLiBJIHdpbGwgY29k
ZSB0aGlzIGFuZCB1cGRhdGUuCgoKVGhhbmtzLgoKCj4KPj4gaW4gbWx4NV92ZHBhX3NldF92cV9j
YigpCj4+Cj4+IDQpIGluIHRoZSBtbHg1X2N2cV9raWNrX2hhbmRsZXIoKSwgd2Uga25vdyB0aGUg
ZmVhdHVyZSBpcyBuZWdvdGlhdGVkIGFuZCB3ZQo+PiBjYW4gdXNlIHRoZSBjb3JyZWN0IGluZGV4
IHRoZXJlLgo+Pgo+PiBJbiB0aGUgbWVhbiB0aW1lLCBJIHdpbGwgbG9vayBhdCBRZW11IGNvZGUg
dG8gc2VlIGlmIHdlIGNhbiBndWFyYW50ZWUgdGhhdAo+PiBzZXRfZmVhdHVyZXMgaXMgY2FsbGVk
IGJlZm9yZSBzZXRfdnFfY2FsbGJhY2suIChBdCBmaXJzdCBnbGFuY2UsIGl0J3Mgbm90Cj4+IHRy
aXZpYWwgYnV0IGxldCdzIHNlZSkuCj4+Cj4+IFRoYW5rcwo+Pgo+Pgo+Pj4+PiBBbmQgd2hpbGUg
d3JpdGluZyB0aGlzLCBJIHRoaW5rIHRoaXMgbG9naWMgZG9lcyBub3QgYmVsb2cgaW4gbWx4NV92
ZHBhCj4+Pj4+IGJ1dCBwcm9iYWJseSBpbiB2ZHBhLmMKPj4+PiBUaGUgcHJvYmxlbSBpcyB0aGF0
IHZkcGEgc2hvdWxkIGJlIHVuYXdhcmUgb2YgYSBzcGVjaWZpYyBkZXZpY2UgdHlwZS4gRS5nCj4+
Pj4gdGhlIGFib3ZlIGluZGljZXMgbWF5IHdvcmsgb25seSBmb3IgdmlydGlvLW5ldCBidXQgbm90
IG90aGVyLgo+Pj4+Cj4+Pj4gVGhhbmtzCj4+Pj4KPj4+Pgo+Pj4+PiAJCj4+Pj4+PiBUaGFua3MK
Pj4+Pj4+Cj4+Pj4+Pj4+IFRoYW5rcwo+Pj4+Pj4+Pgo+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IFRoYW5r
cwo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
