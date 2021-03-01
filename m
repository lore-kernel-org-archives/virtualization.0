Return-Path: <SRS0=COaL=H7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064F5C433E6
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 10:28:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7927464DBD
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 10:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7927464DBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1E64842FFA;
	Mon,  1 Mar 2021 10:28:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 59EAscooXRXG; Mon,  1 Mar 2021 10:28:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id B993E42FFD;
	Mon,  1 Mar 2021 10:28:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93194C000A;
	Mon,  1 Mar 2021 10:28:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96EA0C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 10:28:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 883C14F22E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 10:28:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9r2CAVROfX3L
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 10:28:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2871D4F22D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 10:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614594524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k7ADf3niU9T72jCtQO4N18C/t86nRCIwYwr2OxAlDkQ=;
 b=Dc/TRkep4GKlcwOwqqO8EKIGwBRyrA6WlNdZd2BtSSmhmSzL8lg1U60aH4xQ3ajGMU4S3P
 CPixJaYyv5q0nQ1S0jsioBU9DiHzPX2nsDy6HijspM/SMaYp1ct4QKWevX+bEsoCjpJedB
 Ce3gpfkVE7xFlHhVcnCeFZNIei9jSoE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-bvYaWBdJPue8LPzZRIqckQ-1; Mon, 01 Mar 2021 05:28:43 -0500
X-MC-Unique: bvYaWBdJPue8LPzZRIqckQ-1
Received: by mail-wm1-f70.google.com with SMTP id h16so5433585wmq.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Mar 2021 02:28:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=k7ADf3niU9T72jCtQO4N18C/t86nRCIwYwr2OxAlDkQ=;
 b=f76bTj5Puapa4SlFfnO5GGaiCogiRogFnFHz8GNR0ayL63rimeNYA5Sz3HhCc56+wH
 qj8iJK/tYNIeTIas5G2vHymfSRGQsVvOffEG3/t5BZDxGUY/WizWbBtjnHV0V5uKwgA9
 qh40ISlnr/RRmePHNCr48HgIVmYy+aMvHxF8TFVBMQD7Fw7oSqROZEd5D3/HdcPN6yBB
 l7cOW+73bwACa8UoquMA1SfcWmZBo9FzRjlhYYyT9nk5GhsO4EbbolOcQP9/Bwf8GSA2
 eiEkE3BZVSkwj7cJb2Kk5wyNhnCmz7+Bk237qV3zeyL44RZKlRwlk8ax0E45X+JZzs/B
 UG/w==
X-Gm-Message-State: AOAM530T4zVppHq5rCZTB1Ltd2DR0avfDXE/kBQ7AiuYxV3i93BO2poe
 6G1lBOiWJz1yL7CDkEqX1qYSDMEnWtfvv0PBhDAa211mrD8PYHgpJd59PVVnH7yc+IS5KLyuP5s
 GQzIIMltuJ2N519LMzzCLeMnnzKuAYHEpKzDV0w5y3Q==
X-Received: by 2002:a1c:dd44:: with SMTP id u65mr6958977wmg.87.1614594522189; 
 Mon, 01 Mar 2021 02:28:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx4DTC3GXHOh8PxYEusARRD5Ow9/4t4TDJw+4F6Q7OqrOgjy9B9s4ooThPnjiXgYgek5eTQ1w==
X-Received: by 2002:a1c:dd44:: with SMTP id u65mr6958965wmg.87.1614594522024; 
 Mon, 01 Mar 2021 02:28:42 -0800 (PST)
Received: from amorenoz.users.ipa.redhat.com ([94.73.62.62])
 by smtp.gmail.com with ESMTPSA id v5sm21770615wmh.2.2021.03.01.02.28.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Mar 2021 02:28:41 -0800 (PST)
Subject: Re: [PATCH linux-next 2/9] vdpa: Introduce query of device config
 layout
To: Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <20210224061844.137776-1-parav@nvidia.com>
 <20210224061844.137776-3-parav@nvidia.com>
 <1a9f4f3c-4581-35cc-5d3a-1495bb00257a@redhat.com>
 <BY5PR12MB4322AF919B1BF71DA31C53FFDC9D9@BY5PR12MB4322.namprd12.prod.outlook.com>
 <bfb3a5d2-d335-c4f2-20cb-65d53fc4b216@redhat.com>
 <BY5PR12MB4322010113CCDCA1BB81F766DC9D9@BY5PR12MB4322.namprd12.prod.outlook.com>
 <a1836031-9240-b835-13c3-42dab92d06fa@redhat.com>
 <BY5PR12MB4322917EA142EA37DFAA53EADC9A9@BY5PR12MB4322.namprd12.prod.outlook.com>
 <bbed2011-b0f7-82ba-0e85-0ee455595e5e@redhat.com>
From: Adrian Moreno <amorenoz@redhat.com>
Message-ID: <afe9f219-1247-173f-e93a-cfe083e5cfbd@redhat.com>
Date: Mon, 1 Mar 2021 11:28:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <bbed2011-b0f7-82ba-0e85-0ee455595e5e@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=amorenoz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Eli Cohen <elic@nvidia.com>, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Sean Mooney <smooney@redhat.com>, "mst@redhat.com" <mst@redhat.com>
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

CgpPbiAzLzEvMjEgODo1MCBBTSwgSmFzb24gV2FuZyB3cm90ZToKPiAKPiBPbiAyMDIxLzMvMSAz
OjI5IOS4i+WNiCwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+Pgo+Pj4gRnJvbTogSmFzb24gV2FuZyA8
amFzb3dhbmdAcmVkaGF0LmNvbT4KPj4+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMSwgMjAyMSA5OjI5
IEFNCj4+Pgo+Pj4gT24gMjAyMS8yLzI2IDQ6NTAg5LiL5Y2ILCBQYXJhdiBQYW5kaXQgd3JvdGU6
Cj4+Pj4+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4+Pj4+IFNlbnQ6
IEZyaWRheSwgRmVicnVhcnkgMjYsIDIwMjEgMTo1NiBQTQo+Pj4+Pgo+Pj4+Pgo+Pj4+PiBPbiAy
MDIxLzIvMjYgMTozMiDkuIvljYgsIFBhcmF2IFBhbmRpdCB3cm90ZToKPj4+Pj4+PiBGcm9tOiBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+Pj4+Pj4+IFNlbnQ6IFdlZG5lc2RheSwg
RmVicnVhcnkgMjQsIDIwMjEgMjoxOCBQTQo+Pj4+Pj4+Cj4+Pj4+Pj4gT24gMjAyMS8yLzI0IDI6
MTgg5LiL5Y2ILCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4gK8KgwqDC
oCBpZiAobmxhX3B1dF91MTYobXNnLAo+Pj4gVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BWF9WUVAs
Cj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbmZpZy0+bWF4X3ZpcnRxdWV1ZV9w
YWlycykpCj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVNU0dTSVpFOwo+Pj4+Pj4+
IFdlIHByb2JhYmx5IG5lZWQgdG8gY2hlY2sgVklSVElPX05FVF9GX1JTUyBoZXJlLgo+Pj4+Pj4g
WWVzLiBXaWxsIHVzZSBpdCBpbiB2Mi4KPj4+Pj4+Cj4+Pj4+Pj4+ICvCoMKgwqAgaWYgKG5sYV9w
dXRfdTgobXNnLAo+Pj4gVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX1JTU19NQVhfS0VZX0xFTiwKPj4+
Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uZmlnLT5yc3NfbWF4X2tleV9z
aXplKSkKPj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAtRU1TR1NJWkU7Cj4+Pj4+Pj4+
ICsKPj4+Pj4+Pj4gK8KgwqDCoCByc3NfZmllbGQgPSBsZTE2X3RvX2NwdShjb25maWctPnJzc19t
YXhfa2V5X3NpemUpOwo+Pj4+Pj4+PiArwqDCoMKgIGlmIChubGFfcHV0X3UxNihtc2csCj4+PiBW
RFBBX0FUVFJfREVWX05FVF9DRkdfUlNTX01BWF9JVF9MRU4sCj4+Pj4+Pj4gcnNzX2ZpZWxkKSkK
Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAtRU1TR1NJWkU7Cj4+Pj4+Pj4+ICsKPj4+
Pj4+Pj4gK8KgwqDCoCBoYXNoX3R5cGVzID0gbGUzMl90b19jcHUoY29uZmlnLT5zdXBwb3J0ZWRf
aGFzaF90eXBlcyk7Cj4+Pj4+Pj4+ICvCoMKgwqAgaWYgKG5sYV9wdXRfdTMyKG1zZywKPj4+IFZE
UEFfQVRUUl9ERVZfTkVUX0NGR19SU1NfSEFTSF9UWVBFUywKPj4+Pj4+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgY29uZmlnLT5zdXBwb3J0ZWRfaGFzaF90eXBlcykpCj4+Pj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoCByZXR1cm4gLUVNU0dTSVpFOwo+Pj4+Pj4+PiArwqDCoMKgIHJldHVybiAwOwo+
Pj4+Pj4+PiArfQo+Pj4+Pj4+PiArCj4+Pj4+Pj4+ICtzdGF0aWMgaW50IHZkcGFfZGV2X25ldF9j
b25maWdfZmlsbChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsCj4+Pj4+Pj4+ICtzdHJ1Y3Qgc2tf
YnVmZiAqbXNnKSB7Cj4+Pj4+Pj4+ICvCoMKgwqAgc3RydWN0IHZpcnRpb19uZXRfY29uZmlnIGNv
bmZpZyA9IHt9Owo+Pj4+Pj4+PiArCj4+Pj4+Pj4+ICvCoMKgwqAgdmRldi0+Y29uZmlnLT5nZXRf
Y29uZmlnKHZkZXYsIDAsICZjb25maWcsIHNpemVvZihjb25maWcpKTsKPj4+Pj4+PiBEbyB3ZSBu
ZWVkIHRvIHN5bmMgd2l0aCBvdGhlciBwb3NzaWJsZSBnZXRfY29uZmlnIGNhbGxzIGhlcmU/Cj4+
Pj4+PiBUbyByZWFkZXJzIG9mIGdldF9jb25maWcoKSBpcyBvay4gTm8gbmVlZCB0byBzeW5jLgo+
Pj4+Pj4gSG93ZXZlciwgSSB0aGluayBzZXRfY29uZmlnKCkgYW5kIGdldF9jb25maWcoKSBzaG91
bGQgc3luYyBvdGhlcndpc2UKPj4+Pj4gZ2V0X2NvbmZpZyBjYW4gZ2V0IHBhcnRpYWwgdmFsdWUu
Cj4+Pj4+PiBXaWxsIHByb2JhYmx5IGhhdmUgdG8gYWRkIHZkcGFfZGV2aWNlLT5jb25maWdfYWNj
ZXNzX2xvY2soKS4KPj4+Pj4gUHJvYmFibHkuIEFuZCB0aGUgc2V0X2NvbmZpZygpIHNob3VsZCBi
ZSBzeW5jaHJvbml6ZWQgd2l0aCB0aGUKPj4+Pj4gcmVxdXJlc3QgdGhhdCBjb21lcyBmcm9tIHZE
UEEgYnVzLgo+Pj4+IFllcywgYSBydyBzZW1hcGhvcmUgaXMgZ29vZCBlbm91Z2guCj4+Pj4gRGV2
aWNlIGNvbmZpZyBmaWVsZHMgY2FuIGJlIGNoYW5nZSBmcm9tIHRoZSBkZXZpY2Ugc2lkZSBhbnl3
YXksIHN1Y2ggYXMKPj4+IGxpbmsgc3RhdHVzIGFueXdheS4KPj4+PiBTeW5jIHVzaW5nIGxvY2sg
c2hvdWxkbuKAmXQgYmUgcHJvYmxlbS4KPj4+Pgo+Pj4+PiBUaGlzIG1ha2VzIG1lIHRoaW5rIHdo
ZXRoZXIgd2Ugc2hvdWxkIGdvIGJhY2sgdG8gdHdvIHBoYXNlcyBtZXRob2QsCj4+Pj4+IGNyZWF0
ZSBhbmQgZW5hYmxlLgo+Pj4+Pgo+Pj4+PiBUaGUgdkRQQSBkZXZpY2UgaXMgb25seSByZWdpc3Ry
ZWQgYWZ0ZXIgZW5hYmxpbmcsIHRoZW4gdGhlcmUncyBubwo+Pj4+PiBuZWVkIHRvIHN5bmMgd2l0
aCB2RFBBIGJ1cywgYW5kIG1nbXQgaXMgbm90IGFsbG93ZWQgdG8gY2hhbmdlIGNvbmZpZwo+Pj4g
YWZ0ZXIgZW5hbGJpbmc/Cj4+Pj4gSW4gdGhhdCBjYXNlIHdlIHNob3VsZCBiZSBhYmxlIHRvIGRp
c2FibGUgaXQgYXMgd2VsbC4gRGlzYWJsZSBzaG91bGQgdGFrZSB0aGUKPj4+IGRldmljZSBvZiB0
aGUgYnVzLgo+Pj4+IEkgZmluZCBpdCB3ZWlyZCB0byBoYXZlIHRoaXMgbW9kZWwgdG8gbGluZ2Vy
IGFyb3VuZCB0aGUgZGV2aWNlIHdpdGhvdXQKPj4+IGFuY2hvcmluZyBvbiB0aGUgYnVzLgo+Pj4+
IEZvciBleGFtcGxlIGRldmljZSBpcyBub3QgeWV0IGVuYWJsZWQsIHNvIGl0IGlzIG5vdCBhbmNo
b3JlZCBvbiB0aGUgYnVzLCBidXQKPj4+IGl0cyBuYW1lIGlzIHN0aWxsIGhhdmUgdG8gcmVtYWlu
IHVuaXF1ZS4KPj4+Cj4+Pgo+Pj4gQ2FuIHdlIGRvIHNvbWUgc3luY2hvcm5pemF0aW9uIGJldHdl
ZW4gdmRwYSBkZXZpY2UgYWxsb2NhdGlvbiBhbmQgdmRwYQo+Pj4gZGV2aWNlIHJlZ2lzdGllciB0
byBzb2x2ZSB0aGUgbmFtaW5nIGlzc3VlPwo+PiBtZ210IHRvb2wgcXVlcnlpbmcgdGhlIGRldmlj
ZSBjb25maWcgc3BhY2UgYWZ0ZXIgdmRwYSBkZXZpY2UgaXMgaW4gdXNlIGlzIHJlYWwuCj4+IFNv
IEkgZG9uJ3Qgc2VlIHNvbHZpbmcgaXQgYW55IGRpZmZlcmVudGx5Lgo+Pgo+PiBOb3cgdXBwZXIg
bGF5ZXJzIG9mIHZkcGEgdG8gbm90IGFjY2VzcyB0aGUgZGV2aWNlIG9uIHRoZSBwbGFjZWQgb24g
dGhlIHZkcGEKPj4gYnVzLCBjYW4gYmUgdGFrZW4gY2FyZSBieSBleGlzdGluZyBkcml2ZXIgY29k
ZSB1c2luZwo+PiBlY2hvIDAgPiAvc3lzL2J1cy92ZHBhL2RyaXZlcnNfYXV0b3Byb2JlCj4+Cj4+
IEJ5IGRlZmF1bHQgdmRwYSBkZXZpY2UgcGxhY2VkIG9uIHRoZSBidXMgd29udCBiaW5kIHRvIGFu
eSBkcml2ZXIgKG5ldC92aG9zdCBldGMpLgo+PiAxLiBEZWNpc2lvbiB0byBiaW5kIHRvIHdoaWNo
IGRyaXZlciBpcyBkb25lIGFmdGVyIGNvbmZpZyBvZiB0aGUgdmRwYSBkZXZpY2UgaXMKPj4gZG9u
ZS4KPj4gMi4gb3JjaGVzdHJhdGlvbiBzdyBkb2VzIGNyZWF0ZSBhbmQgY29uZmlnIGJlZm9yZSBp
dCBiaW5kcyB0byB0aGUgcmlnaHQgZHJpdmVyCj4+IDMuIHdoaWNoIGRyaXZlciB0byBiaW5kIHRv
IGRlY2lkZWQgYmFzZWQgb24gdGhlIHVzZSBjYXNlIG9mIHRoYXQgaW5kaXZpZHVhbAo+PiB2ZHBh
IGRldmljZQo+PiBGb3IgZXhhbXBsZSwKPj4gKGEpIHZkcGEwIGJpbmRzIHRvIG5ldCBkcml2ZXIg
dG8gaGF2ZSBOZXRkZXYgZm9yIGNvbnRhaW5lcgo+PiAoYikgdmRwYTEgYmluZHMgdG8gdmhvc3Qg
ZHJpdmVyIHRvIG1hcCB2ZHBhIGRldmljZSB0byBWTQo+IAo+IAo+IEkgdGhpbmsgaXQgc2hvdWxk
IHdvcmsuCj4gPiBBZGRpbmcgQWRyaWFuLCBNYXhpbWUgYW5kIFNlYW4gZm9yIG1vcmUgY29tbWVu
dHMuCgpJcyB0aGlzIGEgc3Ryb25nIHJlcXVpcmVtZW50IG9yIGp1c3QgYSBvcHRpb25hbCBvcGVy
YXRpb24/ClRoaXMgbWlnaHQgYnJlYWsgc29tZSBleGlzdGluZyBsb2dpYyB0aGF0IGV4cGVjdHMg
bmV0ZGV2IG9yIHZob3N0LXZkcGEgZGV2aWNlIHRvCmV4aXN0IGJlZm9yZSB0aGUgc29tZSBjb25m
aWcgKGUuZzptYWMgYWRkcmVzcykgaXMgc2V0LgoKClRoYW5rcwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
