Return-Path: <SRS0=YcCX=LS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0EDC48BDF
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 07:05:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62845613E0
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 07:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62845613E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F9516079D;
	Thu, 24 Jun 2021 07:05:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EjBqSG6WQ0rW; Thu, 24 Jun 2021 07:05:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A195A60603;
	Thu, 24 Jun 2021 07:05:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64232C001A;
	Thu, 24 Jun 2021 07:05:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E022C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 07:05:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0D92B606F2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 07:05:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WbOvHUqBhRkV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 07:05:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AFE8560603
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 07:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624518315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2HZwgsLltFSgG3Uq6T0Om6QOmFBOR2qHu7CzIA5ulBo=;
 b=CnBS0DBQoTJpUnRLKjylvuMJ0TWwINakAav2aPuRsoyg+10bKtGYNon4XSSjFagmDU0Zg5
 Dx/6vXSGbAL4wafOFle6fxZtoRiL9/d/L49UDUcqKEbAjR6P++lFOPwlGfpPr8pq43Tbfs
 2UtMlu13OXaEuPbxX0gwoRyn0SAJkP8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565--ZyJ9v9FOtSH98cBUTOl5g-1; Thu, 24 Jun 2021 03:05:13 -0400
X-MC-Unique: -ZyJ9v9FOtSH98cBUTOl5g-1
Received: by mail-pg1-f197.google.com with SMTP id
 z71-20020a63334a0000b029022250d765d3so3257550pgz.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 00:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=2HZwgsLltFSgG3Uq6T0Om6QOmFBOR2qHu7CzIA5ulBo=;
 b=MCgRvFQ9skTEjVOdRoIwTsj6ZmcbMvqiOwIy2c/z5m5eOaOfc608BizHtUbPlMtajn
 F4HK369L+Kn+AD2vBw0dfg4PZIQ/2X5kUcD6WorU7t7QEfD0IW+0b+4HKNlDvNQN0lZ2
 oJIDc2doRdEilmcZ+UM0Fy3mKzqbh3XnBRTwBf/pYGvgLfhUalLA4FqFGL24gP6xYWE+
 zZi1hHrNUSF+VB+5ClQvruifmJud77QKKHbr/n0ZzTIgUIRuaDqj2pus5bzbI9lqQWCh
 Nnm/TimEZyr9aOCQuV+ChHohCnzYUa/kTnkLA8REBfbPwX79eAH8sJ2ELe1OBz/zhN7z
 TRag==
X-Gm-Message-State: AOAM530L7HHdB9eBcdSo77NyeV3KxzIK31y1TX3R+k3s3cMTjB8fHC9E
 jp5x00h+QLBEKYIbZvFzhL6wWfTFZoKeoJ8VuVZ5mu/5McoPO9xk5qdKv4W+wTdbzn8Bd4UovMP
 1bC3cyjTinGQyoSnDtYPmBNeh04KXpW1qozuW13P80g==
X-Received: by 2002:a63:457:: with SMTP id 84mr3570202pge.78.1624518312630;
 Thu, 24 Jun 2021 00:05:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJpw0DdLkFaQMh7aY7ONV0gl6gGc8EdSi3fmiRbEpZSvGp+WzBwEcMj6WioH0Y/GIWVTj+Rw==
X-Received: by 2002:a63:457:: with SMTP id 84mr3570188pge.78.1624518312408;
 Thu, 24 Jun 2021 00:05:12 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id v8sm1693534pff.34.2021.06.24.00.05.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jun 2021 00:05:12 -0700 (PDT)
Subject: Re: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
To: Parav Pandit <parav@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210616191155.102303-3-parav@nvidia.com>
 <aa7899c0-4b6b-dee3-a175-91e0394bc999@redhat.com>
 <PH0PR12MB5481AE651E0E9BFA6A1839EEDC099@PH0PR12MB5481.namprd12.prod.outlook.com>
 <0434617e-f960-eb1a-a682-49b6a754413f@redhat.com>
 <PH0PR12MB548147BE1B95CB294785470CDC089@PH0PR12MB5481.namprd12.prod.outlook.com>
 <d361bd10-3967-8844-1457-48e7e9422fb2@redhat.com>
 <PH0PR12MB54812DD2DADAD0897E24CFA7DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4e0708fb-34e3-471d-ca98-44c75f693b32@redhat.com>
Date: Thu, 24 Jun 2021 15:05:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54812DD2DADAD0897E24CFA7DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>
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

CuWcqCAyMDIxLzYvMjQg5LiL5Y2IMjoyOSwgUGFyYXYgUGFuZGl0IOWGmemBkzoKPgo+PiBGcm9t
OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+PiBTZW50OiBUaHVyc2RheSwgSnVu
ZSAyNCwgMjAyMSAxMToxMyBBTQo+Pgo+PiDlnKggMjAyMS82LzIzIOS4i+WNiDEyOjIyLCBQYXJh
diBQYW5kaXQg5YaZ6YGTOgo+Pj4+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+Cj4+Pj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDIzLCAyMDIxIDk6MzkgQU0KPj4+Pgo+Pj4+
IOWcqCAyMDIxLzYvMjIg5LiL5Y2IMTA6MDMsIFBhcmF2IFBhbmRpdCDlhpnpgZM6Cj4+Pj4+PiBJ
cyBpdCBiZXR0ZXIgdG8gdXNlIGEgc2VwYXJhdGUgZW51bSBmb3IgbmV0IHNwZWNpZmljIGF0dHJp
YnV0ZXM/Cj4+Pj4+Pgo+Pj4+PiBZZXMsIGJlY2F1c2UgdGhleSBhcmUgb25seSBuZXQgc3BlY2lm
aWMuCj4+Pj4+IEkgZ3Vlc3MgaXQgaXMgcmVsYXRlZCB0byB5b3VyIGJlbG93IHF1ZXN0aW9uLgo+
Pj4+Pgo+Pj4+Pj4gQW5vdGhlciBxdWVzdGlvbiAoc29ycnkgaWYgaXQgaGFzIGJlZW4gYXNrZWQg
YmVmb3JlKS4gQ2FuIHdlIHNpbXBseQo+Pj4+Pj4gcmV0dXJuIHRoZSBjb25maWcgKGJpbmFyeSkg
dG8gdGhlIHVzZXJzcGFjZSwgdGhlbiB1c2VzcGFjZSBjYW4gdXNlCj4+Pj4+PiB0aGUgZXhpc3Rp
bmcgdUFQSSBsaWtlIHZpcnRpb19uZXRfY29uZmlnIHBsdXMgdGhlIGZlYXR1cmUgdG8KPj4+Pj4+
IGV4cGxhaW4gdGhlCj4+Pj4gY29uZmlnPwo+Pj4+PiBXZSBkaWQgZGlzY3VzcyBpbiB2Mi4KPj4+
Pj4gVXN1YWxseSByZXR1cm5pbmcgdGhlIHdob2xlIGJsb2IgYW5kIHBhcnNpbmcgaXMgbm90IGRl
c2lyZWQgdmlhIG5ldGxpbmsuCj4+Pj4+IFJldHVybmluZyBpbmRpdmlkdWFsIGZpZWxkcyBnaXZl
IHRoZSBmdWxsIGZsZXhpYmlsaXR5IHRvIHJldHVybiBvbmx5Cj4+Pj4+IHRoZSB2YWxpZAo+Pj4+
IGZpZWxkcy4KPj4+Pj4gT3RoZXJ3aXNlIHdlIG5lZWQgdG8gaW1wbGVtZW50IGFub3RoZXIgYml0
bWFzayB0b28gdG8gdGVsbCB3aGljaAo+Pj4+PiBmaWVsZHMKPj4+PiBmcm9tIHRoZSBzdHJ1Y3Qg
YXJlIHZhbGlkIGFuZCBzaGFyZSB3aXRoIHVzZXIgc3BhY2UuCj4+Pj4+IFJldHVybmluZyBpbmRp
dmlkdWFsIGZpZWxkcyBpcyB0aGUgd2lkZWx5IHVzZWQgYXBwcm9hY2guCj4+Pj4gVGhlIG1haW4g
Y29uY2VybnMgYXJlOgo+Pj4+Cj4+Pj4gMSkgVGhlIGJsb2Igd2lsbCBiZSBzZWxmIGNvbnRhaW5l
ZCBpZiBpdCB3YXMgcGFzc2VkIHdpdGggdGhlCj4+Pj4gbmVnb3RpYXRlZCBmZWF0dXJlcywgc28g
d2UgZG9uJ3QgbmVlZCBiaXRtYXNrLgo+Pj4gV2hpY2ggZmllbGRzIG9mIHRoZSBzdHJ1Y3QgYXJl
IHZhbGlkIGlzIHRvbGQgYnkgYWRkaXRpb25hbCBmaWVsZHMuCj4+Pj4gMikgVXNpbmcgaW5kaXZp
ZHVhbCBmaWVsZHMgbWVhbnMgaXQgbXVzdCBkdXBsaWNhdGUgdGhlIGNvbmZpZyBmaWVsZHMKPj4+
PiBvZiBldmVyeSB2aXJ0aW8gZGV2aWNlcwo+Pj4+Cj4+PiBNb3N0bHkgbm8uIGlmIHRoZXJlIGFy
ZSBjb21tb24gY29uZmlnIGZpZWxkcyBhY3Jvc3MgdHdvIGRldmljZSB0eXBlcywKPj4+IHRoZXkg
d291bGQgYmUgbmFtZWQgYXMKPj4+IFZEUEFfQVRUUl9ERVZfQ0ZHXyoKPj4+IE5ldCBzcGVjaWZp
YyB3aWxsIGJlLAo+Pj4gVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHXyoKPj4+IEJsb2NrIHNwZWNpZmlj
LCB3aWxsIGJlLAo+Pj4gVkRQQV9BVFRSX0RFVl9CTEtfQ0ZHXyoKPj4KPj4gSSBtZWFudCBpdCBs
b29rcyBsaWtlIFZEUEFfQVRUUl9ERVZfTkVUIHdpbGwgZHVwbGljYXRlIGFsbCB0aGUgZmllbGRz
IG9mOgo+Pgo+PiBzdHJ1Y3QgdmlydGlvX25ldF9jb25maWc7Cj4+Cj4+IEFuZCBWRFBBX0FUVFJf
REVWX0JMT0NLIHdpbGwgZHVwbGljYXRlIGFsbCB0aGUgZmllbGRzIG9mCj4+Cj4+IHN0cnVjdCB2
aXJ0aW9fYmxrX2NvbmZpZzsgd2hpY2ggaGFzIH4yMSBmaWVsZHMuCj4+Cj4+IEFuZCB3ZSBoYWQg
YSBwbGVudHkgb2Ygb3RoZXIgdHlwZXMgb2YgdmlydGlvIGRldmljZXMuCj4+Cj4+IENvbnNpZGVy
IHdlIGhhZCBhIG1hdHVyZSBzZXQgb2YgdmlydGlvIHNwZWNpZmljIHVBUEkgZm9yIGNvbmZpZyBz
cGFjZS4KPj4gSXQgd291bGQgYmUgYSBidXJkZW4gaWYgd2UgbmVlZCBhbiB1bm5lY2Vzc2FyeSB0
cmFuc2xhdGlvbiBsYXllciBvZiBuZXRsaW5rIGluCj4+IHRoZSBtaWRkbGU6Cj4+Cj4+IFt2RFBB
IHBhcmVudCAodmlydGlvX25ldF9jb25maWcpXSA8LT4gW25ldGxpbmsgKFZEUEFfQVRUUl9ERVZf
TkVUX1hYKV0KPj4gPC0+IFt1c2Vyc3BhY2UgKFZEUEFfQVRUUl9ERVZfTkVUX1hYKV0KPj4+IDwt
PiBbIHVzZXIgKHZpcnRpb19uZXRfY29uZmlnKV0KPiBUaGlzIHRyYW5zbGF0aW9uIGlzIG5vdCB0
aGVyZS4gV2Ugc2hvdyByZWxldmFudCBuZXQgY29uZmlnIGZpZWxkcyBhcyBWRFBBX0FUVFJfREVW
X05FVCBpbmRpdmlkdWFsbHkuCj4gSXQgaXMgbm90IGEgYmluYXJ5IGR1bXAgd2hpY2ggaXMgaGFy
ZGVyIGZvciB1c2VycyB0byBwYXJzZSBhbmQgbWFrZSBhbnkgdXNlIG9mIGl0LgoKClRoZSBpcyBk
b25lIGltcGxpY2l0bHksIHVzZXIgbmVlZHMgdG8gdW5kZXJzdGFuZCB0aGUgc2VtYW50aWMgb2Yg
CnZpcnRpb19uZXRfY29uZmlnIGFuZCBtYXAgdGhlIGluZGl2aWR1YWwgZmllbGRzIHRvIHRoZSB2
ZHBhIHRvb2wgCnN1Yi1jb21tYW5kLgoKCj4KPiBJdCBpcyBvbmx5IG9uZSBsZXZlbCBvZiB0cmFu
c2xhdGlvbiBmcm9tIHZpcnRpb19uZXRfY29uZmlnIChrZXJuZWwpIC0+IG5ldGxpbmsgdmRwYSBm
aWVsZHMuCj4gSXQgaXMgc2ltaWxhciB0byAnc3RydWN0IG5ldGRldmljZScgLT4gcnRubCBpbmZv
IGZpZWxkcy4KCgpJIHRoaW5rIG5vdCwgdGhlIHByb2JsZW0gaXMgdGhhdCB0aGUgbmV0ZGV2aWNl
IGlzIG5vdCBhIHBhcnQgb2YgdUFQSSBidXQgCnZpcnRpb19uZXRfY29uZmlnIGlzLgoKCj4KPj4g
SWYgd2UgbWFrZSBuZXRsaW5rIHNpbXBseSBhIHRyYW5zcG9ydCwgaXQgd291bGQgYmUgbXVjaCBl
YXNpZXIuIEFuZCB3ZSBoYWQKPj4gdGhlIGNoYW5jZSB0byB1bmlmeSB0aGUgbG9naWMgb2YgYnVp
bGRfY29uZmlnKCkgYW5kIHNldF9jb25maWcoKSBpbiB0aGUgZHJpdmVyLgo+IEhvdz8gV2UgbmVl
ZCBiaXQgbWFzayB0byB0ZWxsIHRoYXQgb3V0IG9mIDIxIGZpZWxkcyB3aGljaCBmaWVsZHMgdG8g
dXBkYXRlIGFuZCB3aGljaCBub3QuCj4gQW5kIHRoYXQgaXMgZnVydGhlciBtaXhlZCB3aXRoIG9m
ZnNldCBhbmQgbGVuZ3RoLgoKClNvIHNldF9jb25maWcoKSBjb3VsZCBiZSBjYWxsZWQgZnJvbSB1
c2Vyc3BhY2UsIHNvIGRpZCBidWlsZF9jb25maWcoKS4gClRoZSBvbmx5IGRpZmZlcmVuY2UgaXM6
CgoxKSB0aGV5J3JlIHVzaW5nIGRpZmZlcmVudCB0cmFuc3BvcnQsIGlvY3RsIHZzIG5ldGxpbmsK
MikgYnVpbGRfY29uZmlnKCkgaXMgb25seSBleHBlY3RlZCB0byBiZSBjYWxsZWQgYnkgdGhlIG1h
bmFnZW1lbnQgdG9vbAoKSWYgcWVtdSB3b3JrcyB3ZWxsIHZpYSBzZXRfY29uZmlnIGlvY3RsLCBu
ZXRsaW5rIHNob3VsZCB3b3JrIGFzIHdlbGwuCgpCdHcsIHdoYXQgaGFwcGVucyBpZiBtYW5hZ2Vt
ZW50IHRvb2wgdHJpZXMgdG8gbW9kaWZ5IHRoZSBtYWMgb2YgdkRQQSAKd2hlbiB0aGUgZGV2aWNl
IGlzIGFscmVhZHkgdXNlZCBieSB0aGUgZHJpdmVyPwoKCj4KPj4KPj4+PiBBbmQgYWN0dWFsbHks
IGl0J3Mgbm90IHRoZSBiaW5hcnkgYmxvYiBzaW5jZSB1YXBpIGNsZWFybHkgZGVmaW5lIHRoZQo+
Pj4+IGZvcm1hdCAoZS5nIHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyksIGNhbiB3ZSBmaW5kIGEg
d2F5IHRvIHVzZSB0aGF0Pwo+Pj4+IEUuZyBpbnRyb2R1Y2UgZGV2aWNlL25ldCBzcGVjaWZpYyBj
b21tYW5kIGFuZCBwYXNzaW5nIHRoZSBibG9iIHdpdGgKPj4+PiBsZW5ndGggYW5kIG5lZ290aWF0
ZWQgZmVhdHVyZXMuCj4+PiBMZW5ndGggbWF5IGNoYW5nZSBpbiBmdXR1cmUsIG1vc3RseSBleHBh
bmQuIEFuZCBwYXJzaW5nIGJhc2VkIG9uIGxlbmd0aAo+PiBpcyBub3Qgc3VjaCBhIGNsZWFuIHdh
eS4KPj4KPj4KPj4gTGVuZ3RoIGlzIG9ubHkgZm9yIGxlZ2FsIGNoZWNraW5nLiBUaGUgY29uZmln
IGlzIHNlbGYgY29udGFpbmVkIHdpdGg6Cj4+Cj4gVW5saWtlbHkuIFdoZW4gc3RydWN0dXJlIHNp
emUgaW5jcmVhc2VzIGxhdGVyLCB0aGUgcGFyc2luZyB3aWxsIGNoYW5nZSBiYXNlZCBvbiB0aGUg
bGVuZ3RoLgo+IEJlY2F1c2Ugb2xkZXIga2VybmVsIHdvdWxkIHJldHVybiBzaG9ydGVyIGxlbmd0
aCB3aXRoIG9sZGVyIGlwcm91dGUyIHRvb2wuCgoKVGhpcyBpcyBmaW5lIHNpbmNlIHRoZSBvbGRl
ciBrZXJuZWwgb25seSBzdXBwb3J0IGxlc3MgZmVhdHVyZXMuIFRoZSBvbmx5IApwb3NzaWJsZSBp
c3N1ZSBpZiB0aGUgb2xkIGlwcm91dGUgMiBydW5zIG9uIG5ldyBrZXJuZWwuIFdpdGggdGhlIGN1
cnJlbnQgCnByb3Bvc2FsLCBpdCBtYXkgY2F1c2Ugc29tZSBjb25maWcgZmllbGRzIGNhbid0IG5v
dCBiZSBzaG93ZWQuCgpJIHRoaW5rIGl0IG1pZ2h0IGJlIHVzZWZ1bCB0byBpbnRyb2R1Y2UgYSBj
b21tYW5kIHRvIHNpbXBseSBkdW1wIHRoZSAKY29uZmlnIHNwYWNlLgoKCj4gU28gdXNlciBzcGFj
ZSBhbHdheXMgaGF2ZSB0byBkZWFsIGFuZCBoYXZlIG5hc3R5IHBhcnNpbmcvdHlwZWNhc3Rpbmcg
YmFzZWQgb24gdGhlIGxlbmd0aC4KCgpUaGF0J3MgaG93IHVzZXJzcGFjZSAoUWVtdSkgaXMgZXhw
ZWN0ZWQgdG8gd29yayBub3cuIFRoZSB1c2Vyc3BhY2UgCnNob3VsZCBkZXRlcm1pbmUgdGhlIHNl
bWFudGljIG9mIHRoZSBmaWVsZHMgYmFzZWQgb24gdGhlIGZlYXR1cmVzLgoKRGlmZmVyZW50aWF0
ZSBjb25maWcgZmllbGRzIGRvZXNuJ3QgaGVscCBtdWNoLCBlLmcgdXNlcnNwYWNlIHN0aWxsIG5l
ZWQgCnRvIGRpZmZlciBMSU5LX1VQIGFuZCBBTk5PVU5DRSBmb3IgdGhlIHN0YXR1cyBmaWVsZC4K
Cgo+Cj4+IDEpIGRldmljZSBpZAo+PiAyKSBmZWF0dXJlcwo+Pgo+Pgo+Pj4gUGFyc2luZyBmaWVs
ZHMgcmVxdWlyZSBrbm93bGVkZ2Ugb2YgZmVhdHVyZXMgYXMgd2VsbCBhbmQgYXBwbGljYXRpb24g
bmVlZHMKPj4gdG8gbWFrZSBtdWx0aXBsZSBuZXRsaW5rIGNhbGxzIHRvIHBhcnNlIHRoZSBjb25m
aWcgc3BhY2UuCj4+Cj4+Cj4+IEkgdGhpbmsgd2UgZG9uJ3QgY2FyZSBhYm91dCB0aGUgcGVyZm9y
bWFuY2UgaW4gdGhpcyBjYXNlLiBJdCdzIGFib3V0IHRocmVlCj4+IG5ldGxpbmsgY2FsbHM6Cj4+
Cj4gSXRzIG5vdCBhYm91dCBwZXJmb3JtYW5jZS4gQnkgdGhlIHRpbWUgMXN0IGNhbGwgaXMgbWFk
ZSwgZmVhdHVyZXMgZ290IHVwZGF0ZWQgYW5kIGl0IGlzIG91dCBvZiBzeW5jIHdpdGggY29uZmln
Lgo+Cj4+IDEpIGdldCBjb25maWcKPj4gMikgZ2V0IGRldmljZSBpZAo+PiAzKSBnZXQgZmVhdHVy
ZXMKPj4KPiBUaGlzIHJlcXVpcmVzIHVzaW5nIGZlYXR1cmVzIGZyb20gM3JkIG5ldGxpbmsgb3V0
cHV0IHRvIGRlY29kZSBvdXRwdXQgb2YgMXN0IG5ldGxpbmsgb3V0cHV0Lgo+IFdoaWNoIGlzIGEg
Yml0IG9kZCBvZiBuZXRsaW5rLgo+IE90aGVyIG5ldGxpbmsgbmxhX3B1dCgpIHByb2JhYmx5IHNl
bmRpbmcgd2hvbGUgc3RydWN0dXJlIGRvZXNu4oCZdCBuZWVkIHRvIGRvIGl0LgoKCldlbGwsIHdl
IGNhbiBwYWNrIHRoZW0gYWxsIGludG8gYSBzaW5nbGUgc2tiIGlzbid0IGl0PyAocHJvYmFibHkg
d2l0aCBhIApjb25maWcgbGVuKS4KCgo+Cj4+IEZvciBidWlsZCBjb25maWcsIGl0J3Mgb25seSBv
bmUKPj4KPj4gMSkgYnVpbGQgY29uZmlnCj4+Cj4+Cj4+PiBJIHByZWZlciB0byBmb2xsb3cgcmVz
dCBvZiB0aGUga2VybmVsIHN0eWxlIHRvIHJldHVybiBzZWxmIGNvbnRhaW5lZAo+PiBpbnZpZGl2
aWR1YWwgZmllbGRzLgo+Pgo+Pgo+PiBCdXQgSSBzYXcgYSBsb3Qgb2Yga2VybmVsIGNvZGVzIGNo
b29zZSB0byB1c2UgZS5nIG5sYV9wdXQoKSBkaXJlY3RseSB3aXRoCj4+IG1vZHVsZSBzcGVjaWZp
YyBzdHJ1Y3R1cmUuCj4+Cj4gSXQgbWlnaHQgYmUgc2VsZi1jb250YWluZWQgc3RydWN0dXJlIHRo
YXQgcHJvYmFibHkgaGFzIG5vdCBmb3VuZCB0aGUgbmVlZCB0byBleHBhbmQuCgoKSSB0aGluayBp
dCdzIGp1c3QgYSBtYXR0ZXIgb2YgcHV0dGluZyB0aGUgY29uZmlnIGxlbmd0aCB3aXRoIHRoZSBj
b25maWcgCmRhdGEuIE5vdGUgdGhhdCB3ZSd2ZSBhbHJlYWR5IGhhZCAuZ2V0X2NvbmZpZ19zaXpl
KCkgb3BzIGZvciB2YWxpZGF0aW5nIAppbnB1dHMgdGhyb3VnaCBWSE9TVF9TRVRfQ09ORklHL1ZI
T1NUX0dFVF9DT05GSUcuCgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
