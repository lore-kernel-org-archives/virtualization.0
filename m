Return-Path: <SRS0=dYih=NI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDAFC432BE
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 04:20:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6AC360F22
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 04:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B6AC360F22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7AE7B60811;
	Tue, 17 Aug 2021 04:20:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wivBqKVQIFkx; Tue, 17 Aug 2021 04:20:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 098F1607A7;
	Tue, 17 Aug 2021 04:20:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC58FC0010;
	Tue, 17 Aug 2021 04:20:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18B3BC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 04:20:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E86E240156
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 04:20:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pxTkg04ZN7lR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 04:20:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 829A440012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 04:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629174006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gdLH7bL/U35lM9ae39O0VZTDZcYHJmPhMPnB8xScIc4=;
 b=HYgvXSmgxiiMTowC5b585XgFGNCbC4YEeYNcrgQJHlhaBhEEb4oqCyhvWgLKTn0OK/d+Re
 UGGPs1z2+dsTkKkRUwfG01mDbvWvzm5M8021CSlAbtPXzXd+ioQ3tQ5kPR5AfTJq6x7/Al
 faR2DTsTn7q+ijKlLeqhGcJZoUJJs6U=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-sIUpyM_fNQCEVUPPvRa8kw-1; Tue, 17 Aug 2021 00:20:04 -0400
X-MC-Unique: sIUpyM_fNQCEVUPPvRa8kw-1
Received: by mail-pj1-f71.google.com with SMTP id
 m9-20020a17090ade09b029017903cc8d6cso1348129pjv.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 21:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=gdLH7bL/U35lM9ae39O0VZTDZcYHJmPhMPnB8xScIc4=;
 b=pIe87oxWjqQJOBS+ETIx8P42Rj+gJzkLddcwHFEh4IVygtP6kk5boEO07Es5t4/3MK
 V2SeorjmwA2OrrISiDOFiASToBt2tr+y0QXeQKlpXkMwklZSU4+pTFFGxHvyWSZl4wfN
 JUaw7rARyeYtrbrtNOLpnQXI8VibEGSyt+I7KQ5g6+emGKLDRw/UvVJz3XK2fWJdL2VN
 G+45NMidoL7gyBo8K9Ijdq60ZfPmrulDsFx57pFppRceEVLyvoxDjt2gmPSSaonSCMmg
 eVoIsBty2HaWRXpCKrL6EE7rTEaeYC0fF92ystVibW+OHtZCnckCvS7ZWE3PpFPspIMW
 72xA==
X-Gm-Message-State: AOAM532rC7o05l2yjo18u2phC/5jBb2WRGs/mwunxoreTxCjvNVY++SQ
 Vxb0EaaBVZmVN9bIZ7V/yjIobMfyT7TnBoPKAO7DsNh5+3AHJkrDvhA2azQKySbhN9swCOVvRse
 Nu7S6yG8pZdHl0lbtTk7oQSRVV3rrmxHV9ur4/Nth7A==
X-Received: by 2002:a17:90a:b002:: with SMTP id
 x2mr1555970pjq.100.1629174003854; 
 Mon, 16 Aug 2021 21:20:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/7uBhagYE60lCZKoorPsib/yMwHb8I2fYQpb7K3H+8A10VomV8YaVIHpypsFmxzdQq3gxxA==
X-Received: by 2002:a17:90a:b002:: with SMTP id
 x2mr1555953pjq.100.1629174003637; 
 Mon, 16 Aug 2021 21:20:03 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id t5sm730655pfd.133.2021.08.16.21.20.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Aug 2021 21:20:03 -0700 (PDT)
Subject: Re: [Patch v1 3/3] vdpa/mlx5: Add multiqueue support
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <c318303b-3774-909a-a532-2189e9e5a3b9@redhat.com>
 <20210812045535.GA99755@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEsyHiia5DrRU0nLy_OkUZLcQ1==y4Gxy1sETWpVQpVXvg@mail.gmail.com>
 <20210812070151.GA103566@mtl-vdi-166.wap.labs.mlnx>
 <2cc15e3e-bd5c-8e43-1d2f-b0e03b8690d5@redhat.com>
 <20210812095035.GA105096@mtl-vdi-166.wap.labs.mlnx>
 <61b913bb-3f6b-49d4-f5f1-32dce3bd7fae@redhat.com>
 <20210816054746.GA30532@mtl-vdi-166.wap.labs.mlnx>
 <3f26a849-d1a8-49e2-cb60-d58d7c4cbcd9@redhat.com>
 <20210816165659.GA51703@mtl-vdi-166.wap.labs.mlnx>
 <20210816153630-mutt-send-email-mst@kernel.org>
 <CACGkMEvu9tUWPkYqLoDzJ0gR=5RMstMhcU+OkhFtHn7TB5Ki6Q@mail.gmail.com>
 <PH0PR12MB5481B0AC416186D7B20FCB26DCFE9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d54f2e9b-1a04-7118-5c39-c93997eb2afd@redhat.com>
Date: Tue, 17 Aug 2021 12:19:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481B0AC416186D7B20FCB26DCFE9@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: eperezma <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

CuWcqCAyMDIxLzgvMTcg5LiL5Y2IMTI6MDMsIFBhcmF2IFBhbmRpdCDlhpnpgZM6Cj4+IEZyb206
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4+IFNlbnQ6IFR1ZXNkYXksIEF1Z3Vz
dCAxNywgMjAyMSA5OjI2IEFNCj4+Cj4+IE9uIFR1ZSwgQXVnIDE3LCAyMDIxIGF0IDM6MzcgQU0g
TWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4KPj4gd3JvdGU6Cj4+PiBPbiBNb24s
IEF1ZyAxNiwgMjAyMSBhdCAwNzo1Njo1OVBNICswMzAwLCBFbGkgQ29oZW4gd3JvdGU6Cj4+Pj4g
T24gTW9uLCBBdWcgMTYsIDIwMjEgYXQgMDE6NTg6MDZQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPj4+Pj4g5ZyoIDIwMjEvOC8xNiDkuIvljYgxOjQ3LCBFbGkgQ29oZW4g5YaZ6YGTOgo+Pj4+
Pj4gT24gTW9uLCBBdWcgMTYsIDIwMjEgYXQgMTI6MTY6MTRQTSArMDgwMCwgSmFzb24gV2FuZyB3
cm90ZToKPj4+Pj4+PiDlnKggMjAyMS84LzEyIOS4i+WNiDU6NTAsIEVsaSBDb2hlbiDlhpnpgZM6
Cj4+Pj4+Pj4+IE9uIFRodSwgQXVnIDEyLCAyMDIxIGF0IDAzOjA0OjM1UE0gKzA4MDAsIEphc29u
IFdhbmcgd3JvdGU6Cj4+Pj4+Pj4+PiDlnKggMjAyMS84LzEyIOS4i+WNiDM6MDEsIEVsaSBDb2hl
biDlhpnpgZM6Cj4+Pj4+Pj4+Pj4gT24gVGh1LCBBdWcgMTIsIDIwMjEgYXQgMDI6NDc6MDZQTSAr
MDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+Pj4+Pj4gT24gVGh1LCBBdWcgMTIsIDIwMjEg
YXQgMTI6NTUgUE0gRWxpIENvaGVuCj4+IDxlbGljQG52aWRpYS5jb20+IHdyb3RlOgo+Pj4+Pj4+
Pj4+Pj4gT24gVGh1LCBBdWcgMTIsIDIwMjEgYXQgMTE6MTk6MTlBTSArMDgwMCwgSmFzb24gV2Fu
Zwo+PiB3cm90ZToKPj4+Pj4+Pj4+Pj4+PiDlnKggMjAyMS84LzExIOS4i+WNiDc6MDQsIEVsaSBD
b2hlbiDlhpnpgZM6Cj4+Pj4+Pj4+Pj4+Pj4+IE9uIFdlZCwgQXVnIDExLCAyMDIxIGF0IDA0OjM3
OjQ0UE0gKzA4MDAsIEphc29uCj4+IFdhbmcgd3JvdGU6Cj4+Pj4+Pj4+Pj4+Pj4+PiDlnKggMjAy
MS84LzExIOS4i+WNiDM6NTMsIEVsaSBDb2hlbiDlhpnpgZM6Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+IE9u
ZSB0aGluZyBuZWVkIHRvIHNvbHZlIGZvciBtcSBpcyB0aGF0IHRoZToKPj4+Pj4+Pj4+Pj4+Pj4+
Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+ICtzdGF0aWMgdTE2IGN0cmxf
dnFfaWR4KHN0cnVjdAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gK21seDVfdmRwYV9kZXYgKm12ZGV2KSB7
Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiArICAgICByZXR1cm4gMiAqCj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiAr
bWx4NV92ZHBhX21heF9xcHMobXZkZXYtPm1heF92cXMpOwo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gK30K
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gV2Ugc2hvdWxkIGhhbmRsZSB0aGUgY2FzZSB3aGVuIE1RIGlzCj4+
Pj4+Pj4+Pj4+Pj4+Pj4+IHN1cHBvcnRlZCBieSB0aGUgZGV2aWNlIGJ1dCBub3QgdGhlIGRyaXZl
ci4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4gRS5nIGluIHRoZSBjYXNlIHdo
ZW4gd2UgaGF2ZSAyIHF1ZXVlIHBhaXJzOgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+
Pj4+PiBXaGVuIE1RIGlzIGVuYWJsZWQsIGN2cSBpcyBxdWV1ZSA0Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+IFdoZW4gTVEgaXMgbm90IGVuYWJsZWQsIGN2cSBpcyBxdWV1ZSAy
Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4gVGhlcmUncyBzb21lIGlzc3VlIHdp
dGggdGhpcy4gSSBnZXQKPj4+Pj4+Pj4+Pj4+Pj4+PiBjYWxsYmFja3MgdGFyZ2V0aW5nIHNwZWNp
ZmljIHZpcnRxdWV1ZXMgYmVmb3JlCj4+IGZlYXR1cmVzIG5lZ290aWF0aW9uIGhhcyBiZWVuIGNv
bXBsZXRlZC4KPj4+Pj4+Pj4+Pj4+Pj4+PiBTcGVjaWZpY2FsbHksIEkgZ2V0IHNldF92cV9jYigp
IGNhbGxzLiBBdAo+Pj4+Pj4+Pj4+Pj4+Pj4+IHRoaXMgcG9pbnQgSSBtdXN0IGtub3cgdGhlIGNv
bnRyb2wgdnEgaW5kZXguCj4+Pj4+Pj4+Pj4+Pj4+PiBTbyBJIHRoaW5rIHdlIG5lZWQgZG8gYm90
aDoKPj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+PiAxKSBBdCBvbmUgaGFuZCwgaXQncyBh
IGJ1ZyBmb3IgdGhlIHVzZXJzcGFjZQo+Pj4+Pj4+Pj4+Pj4+Pj4gdG8gdXNlIHZxX2luZGV4IGJl
Zm9yZSBmZWF0dXJlIGlzIG5lZ290aWF0ZWQKPj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+
PiAobG9va3MgbGlrZSBhIGJ1ZyBpbiBteSBjdnEgc2VyaWVzIHRoYXQgd2lsbAo+Pj4+Pj4+Pj4+
Pj4+Pj4gY2FsbCBTRVRfVlJJTkdfQ0FMTCBiZWZvcmUgZmVhdHVyZSBpcyBuZWdvdGlhdGUsCj4+
IHdoaWNoIEkgd2lsbCBsb29rKS4KPj4+Pj4+Pj4+Pj4+Pj4+IDIpIEF0IHRoZSBvdGhlciBoYW5k
LCB0aGUgZHJpdmVyIHNob3VsZCBiZQo+Pj4+Pj4+Pj4+Pj4+Pj4gYWJsZSB0byBkZWFsIHdpdGgg
dGhhdAo+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4gQWxsIEkgY2FuIGRvIGlzIGRyb3Ag
Y2FsbGJhY2tzIGZvciBWUXMgYmVmb3JlCj4+Pj4+Pj4+Pj4+Pj4+IGZlYXR1cmVzIG5lZ290YXRp
b24gaGFzIGJlZW4gY29tcGxldGVkLgo+Pj4+Pj4+Pj4+Pj4+IE9yIGp1c3QgbGVhdmUgcXVldWUg
aW5kZXggMCwgMSB3b3JrLgo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4gU2luY2UgaXQgaXMg
bm90IGV4cGVjdGVkIHRvIGJlIGNoYW5nZWQuCj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+IFJp
Z2h0LCB3aWxsIGRvLgo+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+PiBJIHRoaW5rIHRoZSBD
VlEgaW5kZXggbXVzdCBub3QgZGVwZW5kIG9uIHRoZQo+Pj4+Pj4+Pj4+Pj4+Pj4+IG5lZ290aWF0
ZWQgZmVhdHVyZXMgYnV0IHJhdGhlciBkZXBlbmQgb2YgdGhlCj4+Pj4+Pj4+Pj4+Pj4+Pj4gdmFs
dWUgdGhlIGRldmljZSBkcml2ZXIgcHJvdmlkZXMgaW4gdGhlIGNhbGwgdG8KPj4gX3ZkcGFfcmVn
aXN0ZXJfZGV2aWNlKCkuCj4+Pj4+Pj4+Pj4+Pj4+PiBBdCB0aGUgdmlydGlvIGxldmVsLCBpdCdz
IHRvbyBsYXRlIHRvIGNoYW5nZQo+Pj4+Pj4+Pj4+Pj4+Pj4gdGhhdCBhbmQgaXQgYnJlYWtzIHRo
ZSBiYWNrd2FyZCBjb21wYXRpYmlsaXR5Lgo+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+
IEJ1dCBhdCB0aGUgdkRQQSBsZXZlbCwgdGhlIHVuZGVyIGxheWVyIGRldmljZQo+Pj4+Pj4+Pj4+
Pj4+Pj4gY2FuIG1hcCB2aXJ0aW8gY3ZxIHRvIGFueSBvZiBpdCdzIHZpcnRxdWV1ZS4KPj4+Pj4+
Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+PiBFLmcgbWFwIGN2cSAoaW5kZXggMikgdG8gbWx4NSBj
dnEgKHRoZSBsYXN0KS4KPj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+IEkgYW0gbm90IGZv
bGxvd2luZyB5b3UgaGVyZS4gSSBzdGlsbCBkb24ndCBrbm93IHdoYXQKPj4gaW5kZXggaXMgY3Zx
Lgo+Pj4+Pj4+Pj4+Pj4+IFJpZ2h0LCB3ZSBzdGlsbCBuZWVkIHRvIHdhaXQgZm9yIHRoZSBmZWF0
dXJlIGJlaW5nCj4+Pj4+Pj4+Pj4+Pj4gbmVnb3RpYXRlZCBpbiBvcmRlciB0byBwcm9jZWVkLgo+
Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+PiBTbyB0byBzdW1tYXJpc2UsIGJlZm9yZSBmZWF0dXJl
IG5lZ290aWF0aW9uCj4+Pj4+Pj4+Pj4+PiBjb21wbGV0ZSwgSSBhY2NlcHQgY2FsbHMgcmVmZXJy
aW5nIHRvIFZRcyBvbmx5IGZvciBpbmRpY2VzIDAKPj4gYW5kIDEuCj4+Pj4+Pj4+Pj4+PiBBZnRl
ciBmZWF0dXJlIG5lZ290aWF0aW9uIGNvbXBsZXRlIEkga25vdyBDVlEgaW5kZXgKPj4+Pj4+Pj4+
Pj4+IGFuZCB3aWxsIGFjY2VwdCBpbmRpY2VzIDAgdG8gY3ZxIGluZGV4Lgo+Pj4+Pj4+Pj4+PiBJ
IGRvbid0IGdldCB0aGlzICJhY2NlcHQgaW5kaWNlcyAwIHRvIGN2cSBpbmRleCIuCj4+Pj4+Pj4+
Pj4gV2hhdCBJIG1lYW50IHRvIHNheSBpcyB0aGF0IHRoZXJlIGFyZSBzZXZlcmFsIGNhbGxiYWNr
cwo+Pj4+Pj4+Pj4+IHRoYXQgcmVmZXIgdG8gc3BlY2lmaWMgdmlydHF1ZXVlcywgZS5nLgo+Pj4+
Pj4+Pj4+IHNldF92cV9hZGRyZXNzKCksIHNldF92cV9udW0oKSBldGMuIFRoZXkgYWxsIGFjY2Vw
dCB2aXJ0cXVldWUKPj4gaW5kZXggYXMgYW4gYXJndW1lbnQuCj4+Pj4+Pj4+Pj4gV2hhdCB3ZSB3
YW50IHRvIGRvIGlzIHZlcmlmeSB3aGVhdGhlciB0aGUgaW5kZXggcHJvdmlkZWQKPj4+Pj4+Pj4+
PiBpcyB2YWxpZCBvciBub3QuIElmIGl0IGlzIG5vdCB2YWxpZCwgZWl0aGVyIHJldHVybiBlcnJv
cgo+Pj4+Pj4+Pj4+IChpZiB0aGUgY2FsbGJhY2sgY2FuIHJldHVybiBhIHZhbHVlKSBvciBqdXN0
IGF2b2lkCj4+Pj4+Pj4+Pj4gcHJvY2Vzc2luZyBpdC4gSWYgdGhlIGluZGV4IGlzIHZhbGlkIHRo
ZW4gd2UgcHJvY2VzcyBpdCBub3JtYWxseS4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IE5vdyB3ZSBu
ZWVkIHRvIGRlY2lkZSB3aGljaCBpbmRleCBpcyB2YWxpZCBvciBub3QuIFdlCj4+Pj4+Pj4+Pj4g
bmVlZCBzb21ldGhpbmcgbGlrZSB0aGlzIHRvIGlkZW50aWZpeSB2YWxpZCBpbmRleGVzIHJhbmdl
Ogo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gQ1ZRIGNsZWFyOiAwIGFuZCAxCj4+Pj4+Pj4+Pj4gQ1ZR
IHNldCwgTVEgY2xlYXI6IDAsIDEgYW5kIDIgKGZvciBDVlEpLgo+Pj4+Pj4+Pj4+IENWUSBzZXQs
IE1RIHNldDogMC4ubnZxIHdoZXJlIG52cSBpcyB3aGF0ZXZlciBwcm92aWRlZAo+Pj4+Pj4+Pj4+
IHRvCj4+Pj4+Pj4+Pj4gX3ZkcGFfcmVnaXN0ZXJfZGV2aWNlKCkKPj4+Pj4+Pj4+IFllcy4KPj4+
Pj4+Pj4+Cj4+Pj4+Pj4+IFVuZm9ydHVuYXRlbHkgaXQgZG9lcyBub3Qgd29yay4KPj4+Pj4+Pj4g
c2V0X3ZxX2NiKCkgZm9yIGFsbCB0aGUgbXVsdGlxdWV1ZXMgaXMgY2FsbGVkIGJlb2ZyZSBmZWF0
dXJlCj4+Pj4+Pj4+IG5lZ290aWF0aW9uLiBJZiBJIGFwcGx5IHRoZSBhYm92ZSBsb2dpYywgSSB3
aWxsIGxvc2UgdGhlc2Ugc2V0dGluZ3MuCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IEkgY2FuIG1ha2UgYW4g
ZXhjZXB0aW9uIGZvciBzZXRfdnFfY2IoKSwgc2F2ZSBjYWxsYmFja3MgYW5kCj4+Pj4+Pj4+IHJl
c3RvcmUgdGhlbSBhZnRlcndhcmRzLiBUaGlzIGxvb2tzIHRvbyBjb252b2x1dGVkIGFuZCBtYXli
ZQo+Pj4+Pj4+PiB3ZSBzaG91bGQgc2VlayBhbm90aGVyIHNvbHV0aW9uLgo+Pj4+Pj4+IEkgYWdy
ZWUuCj4+Pj4+Pj4KPj4+Pj4+Pgo+Pj4+Pj4+PiBMZXQgbWUga25vdyB3aGF0IHlvdSB0aGluay4K
Pj4+Pj4+PiBSZXRoaW5rIGFib3V0IHRoaXMgaXNzdWUuIEl0IGxvb2tzIHRvIHRoZSBvbmx5IGlz
c3VlIHdlIGZhY2UKPj4+Pj4+PiBpcyB0aGUgc2V0X3ZxX2NiKCkuCj4+Pj4+Pj4KPj4+Pj4+PiBX
aXRoIHRoZSBhc3N1bXB0aW9uIHRoYXQgdGhlIHVzZXJzcGFjZSBjYW4gdXNlIHRoZSBpbmRleAo+
Pj4+Pj4+IGNvcnJlY3RseSAoZXZlbiBiZWZvcmUgc2V0X2ZlYXR1cmVzKS4gSSB3b25kZXIgdGhl
IGZvbGxvd2luZyB3b3Jrcy4KPj4+Pj4+Pgo+Pj4+Pj4+IEluc3RlYWQgb2YgY2hlY2tpbmcgd2hl
dGhlciB0aGUgaW5kZXggaXMgY3ZxIGluIHNldF92cV9jYigpIGhvdwo+PiBhYm91dDoKPj4+Pj4+
PiAxKSBkZWNvdXBsZSBldmVudF9jYiBvdXQgb2YgbWx4NV92ZHBhX3ZpcnRxdWV1ZSBhbmQKPj4+
Pj4+PiBtbHg1X2Nvbmdyb192cQo+Pj4+Pj4+IDIpIGhhdmUgYSBkZWRpY2F0ZWQgZXZlbnRfY2Ig
YXJyYXkgaW4gbWx4NV92ZHBhX25ldAo+Pj4+Pj4+IDMpIHRoZW4gd2UgY2FuIGRvCj4+Pj4+Pj4K
Pj4+Pj4+PiBuZGV2LT5ldmVudF9jYnNbaW5kZXhdID0gKmNiOwo+Pj4+Pj4+Cj4+Pj4+PiBTbyBh
Y3R1YWxseSB5b3UncmUgc3VnZ2VzdGluZyB0byBzYXZlIGFsbCB0aGUgY2FsbGFiY2sKPj4+Pj4+
IGNvbmZpZ3VyYXRpb25zIGluIGFuIGFycmF5IGFuZCBldmFsdWF0ZSBjdnEgaW5kZXggYWZ0ZXIg
ZmVhdHVyZQo+Pj4+Pj4gbmVnb3RpYXRpb24gaGFzIGJlZW4gY29tcGxldGVkLgo+Pj4+Pgo+Pj4+
PiBZZXMuCj4+Pj4+Cj4+Pj4+Cj4+Pj4+PiBJIHRoaW5rIHRoYXQgY291bGQgd29yay4gSSB3aWxs
IGNvZGUgdGhpcyBhbmQgdXBkYXRlLgo+Pj4+IEl0IHdvcmtzIGZpbmUgd2hlbiBJIGFtIHdvcmtp
bmcgd2l0aCB5b3VyIHZlcnNpb24gb2YgcWVtdSB3aXRoCj4+Pj4gc3VwcG9ydCBmb3IgbXVsdGkg
cXVldWUuCj4+Pj4KPj4+PiBUaGUgcHJvYmxlbSBpcyB0aGF0IGl0IGlzIGJyb2tlbiBvbiBxZW11
IHY2LjAuMC4gSWYgSSByZWdpc3RlciBteQo+Pj4+IHZkcGEgZGV2aWNlIHdpdGggbW9yZSB0aGFu
IDIgZGF0YSB2aXJ0cXVldWVzLCBxZW11IHdvbid0IGV2ZW4gY3JlYXRlCj4+Pj4gYSBuZXRkZXZp
Y2UgaW4gdGhlIFZNLgo+PiBRZW11IHNob3VsZCBoaWRlIE1RIGZlYXR1cmUgaW4gdGhpcyBjYXNl
IGJ1dCBsb29rcyBsaWtlIGl0IGRvZXNuJ3QuCj4+Cj4+IFdpbGwgaGF2ZSBhIGxvb2suCj4+Cj4+
Pj4gSSBhbSBub3Qgc3VyZSBob3cgdG8gaGFuZGxlIHRoaXMuIElzIHRoZXJlIHNvbWUga2luZCBv
ZiBpbmRpY2F0aW9uIEkKPj4+PiBjYW4gZ2V0IGFzIHRvIHRoZSB2ZXJzaW9uIG9mIHFlbXUgc28g
SSBjYW4gYXZvaWQgdXNpbmcgbXVsdGlxdWV1ZQo+Pj4+IGZvciB2ZXJzaW9ucyBJIGtub3cgYXJl
IHByb2JsZW1hdGljPwo+Pj4gTm8gdmVyc2lvbnMgOykgVGhpcyBpcyB3aGF0IGZlYXR1cmUgYml0
cyBhcmUgZm9yIC4uLgo+PiBZZXMuCj4+Cj4+IFNvIGRvZXMgaXQgd29yayBpZiAibXE9b2ZmIiBp
cyBzcGVjaWZpZWQgaW4gdGhlIGNvbW1hbmQgbGluZT8KPj4KPiBXZSBzaG91bGQgbm90IGFkZCBk
cml2ZXIgbW9kdWxlIHBhcmFtZXRlci4KCgpOb3RlIHRoYXQsIGl0J3Mgbm90IGEgbW9kdWxlIHBh
cmFtZXRlciBidXQgYSBxZW11IGNvbW1hbmQgbGluZSB0byAKZGlzYWJsZSBtcSBmZWF0dXJlLgoK
Cj4gV2UgYW55d2F5IG5lZWQgbnVtYmVyIG9mIFZRcyB0byBiZSBkcml2ZW4gYnkgdGhlIG51bWJl
ciBvZiB2Y3B1cyB1c2VkIGJ5IHRoZSBWTS4KPiBTbyB3aHkgbm90IHNwZWNpZnkgdGhpcyB3aGVu
IGNyZWF0aW5nIGEgdmRwYSBkZXZpY2U/CgoKWWVzLCBJIHRoaW5rIGl0IHNob3VsZCB3b3JrIGFz
IHdlbGwuCgpTbyBtYW5hZ2VtZW50IG5lZWQgZWl0aGVyOgoKMSkgZGlzYWJsZSBtdWx0aXF1ZXVl
IHZpYSAibXE9b2ZmIgoKb3IKCjIpIHVzaW5nIG5ldGxpbmsgQVBJIHRvIGNyZWF0ZSBhIHNpbmds
ZSBxdWV1ZSBwYWlyIGRldmljZQoKZm9yIHRoZSBxZW11IDw9Ni4xLgoKVGhhbmtzCgoKPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
