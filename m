Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB954C4332F
	for <virtualization@archiver.kernel.org>; Thu, 10 Nov 2022 06:29:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 563CE8175F;
	Thu, 10 Nov 2022 06:29:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 563CE8175F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IY4t65zX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MzOJT4RX3E6p; Thu, 10 Nov 2022 06:29:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D340C812C3;
	Thu, 10 Nov 2022 06:29:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D340C812C3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B739CC0033;
	Thu, 10 Nov 2022 06:29:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AB4BC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 06:29:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EB7C0812C3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 06:29:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EB7C0812C3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qmS4XKB6e7Pg
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 06:29:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2894181747
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2894181747
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 06:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668061755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TXL488ZlRihLJDGsyo7LynfcXA9LIsju9BjG5bCePW0=;
 b=IY4t65zX9hVbBq3svRSeRkT8QF9FwXbIE7zUPveLcoCeExUXypolU7PTctB4KMVBZBVJCP
 DcZTxJSArGRyfJy8L+7V0xjv47w4qYK4hpyQNxSGXeCPAxwZDsQdFFj8vixOsSVBDbCDGb
 RrYZVdkmI7qanCeV7yp6DTAMVYShkgs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-43-hBXaYe4mMbug8VNoIhCOqg-1; Thu, 10 Nov 2022 01:29:11 -0500
X-MC-Unique: hBXaYe4mMbug8VNoIhCOqg-1
Received: by mail-pl1-f198.google.com with SMTP id
 b18-20020a170903229200b00186e357f3b9so761213plh.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Nov 2022 22:29:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TXL488ZlRihLJDGsyo7LynfcXA9LIsju9BjG5bCePW0=;
 b=hzqZHxfPtNOnNUWXOKqWVVgAM8k658TVFuVo5zM+tD077skHy/xOz1fnCS8y0pG/NF
 pe5+NBZd1ulwii9CPeWJaqHeeunDAZa6ica4ZojjbKZ879cWV5gvdwNNitYREVjBRuMU
 oQQ9w5h07wGUG083wRQSrcEHROUC+A6aY49TJLycm6cw/AOZRfIZNxtJOFVBoMm1PPsx
 C5hY8jZdQsPLO3Afkpl+xDQaBVp6kLJSD/ABitGoXpTUTiyVdJDxjSZouIoo89E+i6/M
 3+2BoDH5vm1LW4IxkdaAJEr4cUPi1DnihuOagFE8d4TzXiW7URzG88teslvZZ+UrxPjN
 VRMA==
X-Gm-Message-State: ACrzQf1QmYhLoYZLNGBS+hjIjEiVbN4cDZJJ8NmDx+FhdL/gHy2eMfsh
 m18Go7xnGoImaA+tVbxwX9Z0pkF6epq9YsnNwqG7pSd7614DYFJtXsgSTB3KxNr+6zGHRHbxi1g
 U/OKfCcIKU1GIg1aWbYCKkXAC39WXzc1qfFhuezv6VA==
X-Received: by 2002:a17:903:1112:b0:179:ce23:dd57 with SMTP id
 n18-20020a170903111200b00179ce23dd57mr65794251plh.114.1668061750388; 
 Wed, 09 Nov 2022 22:29:10 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4mf9RY6PyttgDBnKdDNRbK5f5baxgGmhqkMWLWgVsRnQr/d90cG17GYrXFcDpLBVwNcGLcfg==
X-Received: by 2002:a17:903:1112:b0:179:ce23:dd57 with SMTP id
 n18-20020a170903111200b00179ce23dd57mr65794233plh.114.1668061750057; 
 Wed, 09 Nov 2022 22:29:10 -0800 (PST)
Received: from [10.72.13.112] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 b14-20020a170903228e00b00176acd80f69sm10312943plh.102.2022.11.09.22.29.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Nov 2022 22:29:07 -0800 (PST)
Message-ID: <d59c311f-ba9f-4c00-28f8-c50e099adb9f@redhat.com>
Date: Thu, 10 Nov 2022 14:29:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 0/4] ifcvf/vDPA implement features provisioning
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
References: <20221107093345.121648-1-lingshan.zhu@intel.com>
 <CACGkMEs9af1E1pLd2t8E71YBPF=rHkhfN8qO9_3=x6HVaCMAxg@mail.gmail.com>
 <0b15591f-9e49-6383-65eb-6673423f81ec@intel.com>
 <CACGkMEujqOFHv7QATWgYo=SdAKef5jQXi2-YksjgT-hxEgKNDQ@mail.gmail.com>
 <80cdd80a-16fa-ac75-0a89-5729b846efed@intel.com>
 <CACGkMEu-5TbA3Ky2qgn-ivfhgfJ2b12mDJgq8iNgHce8qu3ApA@mail.gmail.com>
 <03657084-98ab-93bc-614a-e6cc7297d93e@intel.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <03657084-98ab-93bc-614a-e6cc7297d93e@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: piotr.uminski@intel.com, hang.yuan@intel.com,
 virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com
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

CuWcqCAyMDIyLzExLzEwIDE0OjIwLCBaaHUsIExpbmdzaGFuIOWGmemBkzoKPgo+Cj4gT24gMTEv
MTAvMjAyMiAxMTo0OSBBTSwgSmFzb24gV2FuZyB3cm90ZToKPj4gT24gV2VkLCBOb3YgOSwgMjAy
MiBhdCA1OjA2IFBNIFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+IAo+PiB3
cm90ZToKPj4+Cj4+Pgo+Pj4gT24gMTEvOS8yMDIyIDQ6NTkgUE0sIEphc29uIFdhbmcgd3JvdGU6
Cj4+Pj4gT24gV2VkLCBOb3YgOSwgMjAyMiBhdCA0OjE0IFBNIFpodSwgTGluZ3NoYW4gCj4+Pj4g
PGxpbmdzaGFuLnpodUBpbnRlbC5jb20+IHdyb3RlOgo+Pj4+Pgo+Pj4+PiBPbiAxMS85LzIwMjIg
Mjo1MSBQTSwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+IE9uIE1vbiwgTm92IDcsIDIwMjIgYXQg
NTo0MiBQTSBaaHUgTGluZ3NoYW4gCj4+Pj4+PiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4gd3Jv
dGU6Cj4+Pj4+Pj4gVGhpcyBzZXJpZXMgaW1wbGVtZW50cyBmZWF0dXJlcyBwcm92aXNpb25pbmcg
Zm9yIGlmY3ZmLgo+Pj4+Pj4+IEJ5IGFwcGx5aW5nIHRoaXMgc2VyaWVzLCB3ZSBhbGxvdyB1c2Vy
c3BhY2UgdG8gY3JlYXRlCj4+Pj4+Pj4gYSB2RFBBIGRldmljZSB3aXRoIHNlbGVjdGVkIChtYW5h
Z2VtZW50IGRldmljZSBzdXBwb3J0ZWQpCj4+Pj4+Pj4gZmVhdHVyZSBiaXRzIGFuZCBtYXNrIG91
dCBvdGhlcnMuCj4+Pj4+PiBJIGRvbid0IHNlZSBhIGRpcmVjdCByZWxhdGlvbnNoaXAgYmV0d2Vl
biB0aGUgZmlyc3QgMyBhbmQgdGhlIGxhc3QuCj4+Pj4+PiBNYXliZSB5b3UgY2FuIHN0YXRlIHRo
ZSByZWFzb24gd2h5IHRoZSByZXN0cnVjdHVyZSBpcyBhIG11c3QgZm9yIHRoZQo+Pj4+Pj4gZmVh
dHVyZSBwcm92aXNpb25pbmcuIE90aGVyd2lzZSwgd2UnZCBiZXR0ZXIgc3BsaXQgdGhlIHNlcmll
cy4KPj4+Pj4gV2hlbiBpbnRyb2R1Y2luZyBmZWF0dXJlcyBwcm92aXNpb25pbmcgYWJpbGl0eSB0
byBpZmN2ZiwgdGhlcmUgaXMgCj4+Pj4+IGEgbmVlZAo+Pj4+PiB0byByZS1jcmVhdGUgdkRQQSBk
ZXZpY2VzCj4+Pj4+IG9uIGEgVkYgd2l0aCBkaWZmZXJlbnQgZmVhdHVyZSBiaXRzLgo+Pj4+IFRo
aXMgc2VlbXMgYSByZXF1aXJlbWVudCBldmVuIHdpdGhvdXQgZmVhdHVyZSBwcm92aXNpb25pbmc/
IERldmljZQo+Pj4+IGNvdWxkIGJlIGRlbGV0ZWQgZnJvbSB0aGUgbWFuYWdlbWVudCBkZXZpY2Ug
YW55aG93Lgo+Pj4gWWVzLCB3ZSBuZWVkIHRoaXMgdG8gZGVsZXRlIGFuZCByZS1jcmVhdGUgYSB2
RFBBIGRldmljZS4KPj4gSSB3b25kZXIgaWYgd2UgbmVlZCBzb21ldGhpbmcgdGhhdCB3b3JrcyBm
b3IgLXN0YWJsZS4KPiBJIGNhbiBhZGQgYSBmaXggdGFnLCBzbyB0aGVzZSB0aHJlZSBwYXRjaGVz
IGNvdWxkIGFwcGx5IHRvIHN0YWJsZQoKCkl0J3MgdG9vIGh1Z2UgZm9yIC1zdGFibGUuCgoKPj4K
Pj4gQUZBSUssIHdlIGNhbiBtb3ZlIHRoZSB2ZHBhX2FsbG9jX2RldmljZSgpIGZyb20gcHJvYmUo
KSB0byBkZXZfYWRkKCkKPj4gYW5kIGl0IHNlZW1zIHRvIHdvcms/Cj4gWWVzIGFuZCB0aGlzIGlz
IGRvbmUgaW4gdGhpcyBzZXJpZXMgYW5kIHRoYXQncyB3aHkgd2UgbmVlZCB0aGVzZQo+IHJlZmFj
dG9yaW5nIGNvZGUuCgoKSSBtZWFudCB0aGVyZSdzIHByb2JhYmx5IG5vIG5lZWQgdG8gY2hhbmdl
IHRoZSBhc3NvY2lhdGlvbiBvZiBleGlzdGluZyAKc3RydWN0dXJlIGJ1dCBqdXN0IGRvIHRoZSBh
bGxvY2F0aW9uIGluIGRldl9hZGQoKSwgdGhlbiB3ZSB3aWxsIGhhdmUgYSAKcGF0Y2ggd2l0aCBt
dWNoIG1vcmUgc21hbGwgY2hhbmdlc2V0IHRoYXQgZml0IGZvciAtc3RhYmxlLgoKVGhhbmtzCgoK
Pgo+IEJ5IHRoZSB3YXksIGRvIHlvdSBoYXZlIGFueSBjb21tZW50cyB0byB0aGUgcGF0Y2hlcz8K
Pgo+IFRoYW5rcywKPiBaaHUgTGluZ3NoYW4KPj4KPj4gVGhhbmtzCj4+Cj4+PiBXZSBjcmVhdGUg
dkRQQSBkZXZpY2UgZnJvbSBhIFZGLCBzbyB3aXRob3V0IGZlYXR1cmVzIHByb3Zpc2lvbmluZwo+
Pj4gcmVxdWlyZW1lbnRzLAo+Pj4gd2UgZG9uJ3QgbmVlZCB0byByZS1jcmVhdGUgdGhlIHZEUEEg
ZGV2aWNlLiBCdXQgd2l0aCBmZWF0dXJlcyAKPj4+IHByb3Zpc2lvbmluZywKPj4+IGl0IGlzIGEg
bXVzdCBub3cuCj4+Pgo+Pj4gVGhhbmtzCj4+Pgo+Pj4KPj4+PiBUaGFrbnMKPj4+Pgo+Pj4+PiBX
aGVuIHJlbW92ZSBhIHZEUEEgZGV2aWNlLCB0aGUgY29udGFpbmVyIG9mIHN0cnVjdCB2ZHBhX2Rl
dmljZSAKPj4+Pj4gKGhlcmUgaXMKPj4+Pj4gaWZjdmZfYWRhcHRlcikgaXMgZnJlZS1lZCBpbgo+
Pj4+PiBkZXZfZGVsKCkgaW50ZXJmYWNlLCBzbyB3ZSBuZWVkIHRvIGFsbG9jYXRlIGlmY3ZmX2Fk
YXB0ZXIgaW4gCj4+Pj4+IGRldl9hZGQoKQo+Pj4+PiB0aGFuIGluIHByb2JlKCkuIFRoYXQncwo+
Pj4+PiB3aHkgSSBoYXZlIHJlLWZhY3RvcmVkIHRoZSBhZGFwdGVyL21nbXRfZGV2IGNvZGUuCj4+
Pj4+Cj4+Pj4+IEZvciByZS1mYWN0b3JpbmcgdGhlIGlycSByZWxhdGVkIGNvZGUgYW5kIGlmY3Zm
X2Jhc2UsIGxldCB0aGVtIAo+Pj4+PiB3b3JrIG9uCj4+Pj4+IHN0cnVjdCBpZmN2Zl9odywgdGhl
Cj4+Pj4+IHJlYXNvbiBpcyB0aGF0IHRoZSBhZGFwdGVyIGlzIGFsbG9jYXRlZCBpbiBkZXZfYWRk
KCksIGlmIHdlIHdhbnQgCj4+Pj4+IHRoZXNlcwo+Pj4+PiBmdW5jdGlvbnMgdG8gd29yawo+Pj4+
PiBiZWZvcmUgZGV2X2FkZCgpLCBsaWtlIGluIHByb2JlLCB3ZSBuZWVkIHRoZW0gd29yayBvbiBp
ZmN2Zl9odyAKPj4+Pj4gdGhhbiB0aGUKPj4+Pj4gYWRhcHRlci4KPj4+Pj4KPj4+Pj4gVGhhbmtz
Cj4+Pj4+IFpodSBMaW5nc2hhbgo+Pj4+Pj4gVGhhbmtzCj4+Pj4+Pgo+Pj4+Pj4+IFBsZWFzZSBo
ZWxwIHJldmlldwo+Pj4+Pj4+Cj4+Pj4+Pj4gVGhhbmtzCj4+Pj4+Pj4KPj4+Pj4+PiBaaHUgTGlu
Z3NoYW4gKDQpOgo+Pj4+Pj4+IMKgwqDCoMKgIHZEUEEvaWZjdmY6IGlmY3ZmIGJhc2UgbGF5ZXIg
aW50ZXJmYWNlcyB3b3JrIG9uIHN0cnVjdCAKPj4+Pj4+PiBpZmN2Zl9odwo+Pj4+Pj4+IMKgwqDC
oMKgIHZEUEEvaWZjdmY6IElSUSBpbnRlcmZhY2VzIHdvcmsgb24gaWZjdmZfaHcKPj4+Pj4+PiDC
oMKgwqDCoCB2RFBBL2lmY3ZmOiBhbGxvY2F0ZSBpZmN2Zl9hZGFwdGVyIGluIGRldl9hZGQoKQo+
Pj4+Pj4+IMKgwqDCoMKgIHZEUEEvaWZjdmY6IGltcGxlbWVudCBmZWF0dXJlcyBwcm92aXNpb25p
bmcKPj4+Pj4+Pgo+Pj4+Pj4+IMKgwqDCoCBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5j
IHzCoCAzMiArKy0tLS0tCj4+Pj4+Pj4gwqDCoMKgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9i
YXNlLmggfMKgIDEwICstCj4+Pj4+Pj4gwqDCoMKgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9t
YWluLmMgfCAxNTYgCj4+Pj4+Pj4gKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0KPj4+
Pj4+PiDCoMKgwqAgMyBmaWxlcyBjaGFuZ2VkLCA4OSBpbnNlcnRpb25zKCspLCAxMDkgZGVsZXRp
b25zKC0pCj4+Pj4+Pj4KPj4+Pj4+PiAtLSAKPj4+Pj4+PiAyLjMxLjEKPj4+Pj4+Pgo+CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
