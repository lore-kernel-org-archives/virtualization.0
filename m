Return-Path: <SRS0=jANb=LB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A43FC4743E
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 02:47:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC750611C2
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 02:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC750611C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 72B464016A;
	Mon,  7 Jun 2021 02:47:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f1RHeCTbYxR5; Mon,  7 Jun 2021 02:47:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id DBB9840015;
	Mon,  7 Jun 2021 02:47:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0E83C000E;
	Mon,  7 Jun 2021 02:47:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3B7FC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:47:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9BA114033E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:47:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AYNUK9K7NgOD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:47:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 66CDA40337
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 02:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623034032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mr3tocRxWL7KHdg8awV/zpzMwDBrih+hXjg05z6CBzk=;
 b=haMo9aeds9u8nULlZC6Q3drF2plPXEY5xSLIsUX0RSurG2BGVhZDKtt6UvGXDaBloHnJbZ
 cs5a6HR3qjbcu0BN2Qck6ERVa+ZphW6IoTt/w8FeJYdhgnZ5v2thhyRocrFSAiZVjJo7fW
 5MHNRNmWOPOf6uUhQ5VWKi/l55pPDCs=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-PYVz6Kl6Pk2TmLjbNNbEWA-1; Sun, 06 Jun 2021 22:47:09 -0400
X-MC-Unique: PYVz6Kl6Pk2TmLjbNNbEWA-1
Received: by mail-pf1-f199.google.com with SMTP id
 l3-20020a056a001403b02902ea25d3c7d4so6339680pfu.15
 for <virtualization@lists.linux-foundation.org>;
 Sun, 06 Jun 2021 19:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Mr3tocRxWL7KHdg8awV/zpzMwDBrih+hXjg05z6CBzk=;
 b=anOKOUWk8MJtUWlJKIPni2zETgxmpH/CbpBJL4rGSZdMFjZrdF6K5mY8F0aZyGzz7i
 05w7s00hsrdJBpiK63ZK03uZUSfdIBEUewAenDxqiMrzrFlBPXQZDrD0RVGIi8MsyVhW
 bpTEeBwQ2CyDY/qTcFNrP+mb+SBGrCpbUNxoEIFYsPkrDdAzVzR9IbnZRuCbUN8ec6Ek
 hNUM6phdwl8E25+vsHADLgGXL4rMZefsicJhl5HJ5sLbABFd3lRyz9M0NYS9lIb6OLF/
 Ol6PxvmNufua1I1iwvx1qkjNTGVbPvuCdIW7luabrD+DuU/vdPrk77rtO/Cd4GFN4huQ
 /0gg==
X-Gm-Message-State: AOAM531wwd4KNriiNTOF3Lp30I0A0KvbPqheSNR2baXEtg25gSlo4VFB
 jm5nIdbkBJl7dC3un8p8Dnohd/04IygoGh+r/4lLzBAD7zbbM9PvZw+nojspxOQwRytw2eVsOqk
 WfpZJdX119pVv4aJDO00EnYmFXWDwuAAsAlrxNAzuCA==
X-Received: by 2002:a17:90a:a512:: with SMTP id
 a18mr10789097pjq.215.1623034028454; 
 Sun, 06 Jun 2021 19:47:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxp6+IFTDaA+xiekaXr4IMEzKNt6UmxaapTPVHbpvF501mj9bOPvGKBHxi8b6knZswIY52v0A==
X-Received: by 2002:a17:90a:a512:: with SMTP id
 a18mr10789078pjq.215.1623034028146; 
 Sun, 06 Jun 2021 19:47:08 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id z134sm6704296pfc.209.2021.06.06.19.47.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Jun 2021 19:47:07 -0700 (PDT)
Subject: Re: [RFC PATCH 0/7] Untrusted device support for virtio
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20210421032117.5177-1-jasowang@redhat.com>
 <YInOQt1l/59zzPJK@Konrads-MacBook-Pro.local>
 <9b089e3b-7d7a-b9d6-a4a1-81a6eff2e425@redhat.com>
 <e8a35789-5001-3e17-1546-80fa9daa5ab1@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b4f25e0e-5115-2d58-e433-1839651d747f@redhat.com>
Date: Mon, 7 Jun 2021 10:46:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e8a35789-5001-3e17-1546-80fa9daa5ab1@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: ashish.kalra@amd.com, file@sect.tu-berlin.de,
 martin.radev@aisec.fraunhofer.de, kvm@vger.kernel.org, mst@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, stefanha@redhat.com
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

CuWcqCAyMDIxLzYvNCDkuIvljYgxMToxNywgS29ucmFkIFJ6ZXN6dXRlayBXaWxrIOWGmemBkzoK
PiBPbiA0LzI5LzIxIDEyOjE2IEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pgo+PiDlnKggMjAyMS80
LzI5IOS4iuWNiDU6MDYsIEtvbnJhZCBSemVzenV0ZWsgV2lsayDlhpnpgZM6Cj4+PiBPbiBXZWQs
IEFwciAyMSwgMjAyMSBhdCAxMToyMToxMEFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+
IEhpIEFsbDoKPj4+Pgo+Pj4+IFNvbWV0aW1lcywgdGhlIGRyaXZlciBkb2Vzbid0IHRydXN0IHRo
ZSBkZXZpY2UuIFRoaXMgaXMgdXN1YWxseQo+Pj4+IGhhcHBlbnMgZm9yIHRoZSBlbmNydHB5ZWQg
Vk0gb3IgVkRVU0VbMV0uIEluIGJvdGggY2FzZXMsIHRlY2hub2xvZ3kKPj4+PiBsaWtlIHN3aW90
bGIgaXMgdXNlZCB0byBwcmV2ZW50IHRoZSBwb2tpbmcvbWFuZ2xpbmcgb2YgbWVtb3J5IGZyb20g
dGhlCj4+Pj4gZGV2aWNlLiBCdXQgdGhpcyBpcyBub3Qgc3VmZmljaWVudCBzaW5jZSBjdXJyZW50
IHZpcnRpbyBkcml2ZXIgbWF5Cj4+Pj4gdHJ1c3Qgd2hhdCBpcyBzdG9yZWQgaW4gdGhlIGRlc2Ny
aXB0b3IgdGFibGUgKGNvaGVyZW50IG1hcHBpbmcpIGZvcgo+Pj4+IHBlcmZvcm1pbmcgdGhlIERN
QSBvcGVyYXRpb25zIGxpa2UgdW5tYXAgYW5kIGJvdW5jZSBzbyB0aGUgZGV2aWNlIG1heQo+Pj4+
IGNob29zZSB0byB1dGlsaXplIHRoZSBiZWhhdmlvdXIgb2Ygc3dpb3RsYiB0byBwZXJmb3JtIGF0
dGFja3NbMl0uCj4+PiBXZSBmaXhlZCBpdCBpbiB0aGUgU1dJT1RMQi4gVGhhdCBpcyBpdCBzYXZl
cyB0aGUgZXhwZWN0ZWQgbGVuZ3RoCj4+PiBvZiB0aGUgRE1BIG9wZXJhdGlvbi4gU2VlCj4+Pgo+
Pj4gY29tbWl0IGRhZjk1MTRmZDVlYjA5OGQ3ZDZmM2ExMjQ3Y2I4Y2M0OGZjOTQxNTUKPj4+IEF1
dGhvcjogTWFydGluIFJhZGV2IDxtYXJ0aW4uYi5yYWRldkBnbWFpbC5jb20+Cj4+PiBEYXRlOsKg
wqAgVHVlIEphbiAxMiAxNjowNzoyOSAyMDIxICswMTAwCj4+Pgo+Pj4gwqDCoMKgwqAgc3dpb3Rs
YjogVmFsaWRhdGUgYm91bmNlIHNpemUgaW4gdGhlIHN5bmMvdW5tYXAgcGF0aAo+Pj4gwqDCoMKg
wqAgVGhlIHNpemUgb2YgdGhlIGJ1ZmZlciBiZWluZyBib3VuY2VkIGlzIG5vdCBjaGVja2VkIGlm
IGl0IGhhcHBlbnMKPj4+IMKgwqDCoMKgIHRvIGJlIGxhcmdlciB0aGFuIHRoZSBzaXplIG9mIHRo
ZSBtYXBwZWQgYnVmZmVyLiBCZWNhdXNlIHRoZSBzaXplCj4+PiDCoMKgwqDCoCBjYW4gYmUgY29u
dHJvbGxlZCBieSBhIGRldmljZSwgYXMgaXQncyB0aGUgY2FzZSB3aXRoIHZpcnRpbyAKPj4+IGRl
dmljZXMsCj4+PiDCoMKgwqDCoCB0aGlzIGNhbiBsZWFkIHRvIG1lbW9yeSBjb3JydXB0aW9uLgo+
Pgo+Pgo+PiBHb29kIHRvIGtub3cgdGhpcywgYnV0IHRoaXMgc2VyaWVzIHRyaWVzIHRvIHByb3Rl
Y3QgYXQgZGlmZmVyZW50IAo+PiBsZXZlbC4gQW5kIEkgYmVsaWV2ZSBzdWNoIHByb3RlY3Rpb24g
bmVlZHMgdG8gYmUgZG9uZSBhdCBib3RoIGxldmVscy4KPj4KPgo+IE15IGFwb2xvZ2llcyBmb3Ig
dGFraW5nIHNvIGxvbmcgdG8gcmVzcG9uZCwgc29tZWhvdyB0aGlzIGRpc2FwcGVhcmVkIAo+IGlu
IG9uZSBvZiB0aGUgZm9sZGVycy4KCgpObyBwcm9ibGVtLgoKCj4+Cj4+Pj4gRm9yIGRvdWJsZSBp
bnN1cmFuY2UsIHRvIHByb3RlY3QgZnJvbSBhIG1hbGljb3VzIGRldmljZSwgd2hlbiBETUEgQVBJ
Cj4+Pj4gaXMgdXNlZCBmb3IgdGhlIGRldmljZSwgdGhpcyBzZXJpZXMgc3RvcmUgYW5kIHVzZSB0
aGUgZGVzY3JpcHRvcgo+Pj4+IG1ldGFkYXRhIGluIGFuIGF1eGlsaWF5IHN0cnVjdHVyZSB3aGlj
aCBjYW4gbm90IGJlIGFjY2Vzc2VkIHZpYQo+Pj4+IHN3aW90bGIgaW5zdGVhZCBvZiB0aGUgb25l
cyBpbiB0aGUgZGVzY3JpcHRvciB0YWJsZS4gQWN0dWFsbHksIHdlJ3ZlCj4+PiBTb3JyeSBmb3Ig
YmVpbmcgZGVuc2UgaGVyZSwgYnV0IGhvdyB3b2xkIFNXSU9UTEIgYmUgdXRpbGl6ZWQgZm9yCj4+
PiB0aGlzIGF0dGFjaz8KPj4KPj4KPj4gU28gd2Ugc3RpbGwgYmVoYXZpb3JzIHRoYXQgaXMgdHJp
Z2dlcmVkIGJ5IGRldmljZSB0aGF0IGlzIG5vdCAKPj4gdHJ1c3RlZC4gU3VjaCBiZWhhdmlvciBp
cyB3aGF0IHRoZSBzZXJpZXMgdHJpZXMgdG8gYXZvaWQuIFdlJ3ZlIAo+PiBsZWFybnQgYSBsb3Qg
b2YgbGVzc29ucyB0byBlbGltaW5hdGUgdGhlIHBvdGVudGlhbCBhdHRhY2tzIHZpYSB0aGlzLiAK
Pj4gQW5kIGl0IHdvdWxkIGJlIHRvbyBsYXRlIHRvIGZpeCBpZiB3ZSBmb3VuZCBhbm90aGVyIGlz
c3VlIG9mIFNXSU9UTEIuCj4+Cj4+IFByb3ZpbmcgInRoZSB1bmV4cGVjdGVkIGRldmljZSB0cmln
Z2VyZWQgYmVoYXZpb3IgaXMgc2FmZSIgaXMgdmVyeSAKPj4gaGFyZCAob3IgZXZlbiBpbXBvc3Np
YmxlKSB0aGFuICJlbGltaW5hdGluZyB0aGUgdW5leHBlY3RlZCBkZXZpY2UgCj4+IHRyaWdnZXJl
ZCBiZWhhdmlvciB0b3RhbGx5Ii4KPj4KPj4gRS5nIEkgd29uZGVyIHdoZXRoZXIgc29tZXRoaW5n
IGxpa2UgdGhpcyBjYW4gaGFwcGVuOiBDb25zaWRlciB0aGUgRE1BIAo+PiBkaXJlY3Rpb24gb2Yg
dW5tYXAgaXMgdW5kZXIgdGhlIGNvbnRyb2wgb2YgZGV2aWNlLiBUaGUgZGV2aWNlIGNhbiAKPj4g
Y2hlYXQgdGhlIFNXSU9UTEIgYnkgY2hhbmdpbmcgdGhlIGZsYWcgdG8gbW9kaWZ5IHRoZSBkZXZp
Y2UgcmVhZCBvbmx5IAo+PiBidWZmZXIuIAo+Cj4gPGJsaW5rcz4gV2h5IHdvdWxkIHlvdSB3YW50
IHRvIGV4cG9zZSB0aGF0IHRvIHRoZSBkZXZpY2U/IEFuZCB3b3VsZG4ndCAKPiB0aGF0IGJlIHNw
ZWNpZmljIHRvIExpbnV4IGRldmljZXMgLSBiZWNhdXNlIHN1cmVseSBXaW5kb3dzIERNQSBBUElz
IAo+IGFyZSBkaWZmZXJlbnQgYW5kIHRoaXMgJ2ZsYWcnIHNlZW1zIHZlcnkgTGludXgta2VybmVs
IHNwZWNpZmljPwoKCkp1c3QgdG8gbWFrZSBzdXJlIHdlIGFyZSBpbiB0aGUgc2FtZSBwYWdlLiBU
aGUgImZsYWciIEkgYWN0dWFsbHkgbWVhbiAKdGhlIHZpcnRpbyBkZXNjcmlwdG9yIGZsYWcgd2hp
Y2ggY291bGQgYmUgbW9kaWZpZWQgYnkgdGhlIGRldmljZS4gQW5kIApkcml2ZXIgZGVkdWNlIHRo
ZSBETUEgQVBJIGZsYWcgZnJvbSB0aGUgZGVzY3JpcHRvciBmbGFnLgoKCj4KPj4gSWYgeWVzLCBp
dCBpcyByZWFsbHkgc2FmZT8KPgo+IFdlbGwgbm8/IEJ1dCBuZWl0aGVyIGlzIHJtIC1SZiAvIGJ1
dCB3ZSBzdGlsbCBhbGxvdyBmb2xrcyB0byBkbyB0aGF0Lgo+Pgo+PiBUaGUgYWJvdmUgcGF0Y2gg
b25seSBsb2cgdGhlIGJvdW5jZSBzaXplIGJ1dCBpdCBkb2Vzbid0IGxvZyB0aGUgZmxhZy4gCj4K
PiBJdCBsb2dzIGFuZCBwYW5pY3MgdGhlIHN5c3RlbS4KCgpHb29kIHRvIGtub3cgdGhhdC4KCgo+
Cj4+IEV2ZW4gaWYgaXQgbG9ncyB0aGUgZmxhZywgU1dJT1RMQiBzdGlsbCBkb2Vzbid0IGtub3cg
aG93IGVhY2ggYnVmZmVyIAo+PiBpcyB1c2VkIGFuZCB3aGVuIGl0J3MgdGhlIGFwcHJvcHJpYXRl
KHNhZmUpIHRpbWUgdG8gdW5tYXAgdGhlIGJ1ZmZlciwgCj4+IG9ubHkgdGhlIGRyaXZlciB0aGF0
IGlzIHVzaW5nIHRoZSBTV0lPVExCIGtub3cgdGhlbS4KPgo+IEZhaXIgZW5vdWdoLiBJcyB0aGUg
aW50ZW50IHRvIGRvIHRoZSBzYW1lIHRoaW5nIGZvciBhbGwgdGhlIG90aGVyIAo+IGRyaXZlcnMg
dGhhdCBjb3VsZCBiZSBydW5uaW5nIGluIGFuIGVuY3J5cHRlZCBndWVzdCBhbmQgd291bGQgcmVx
dWlyZSAKPiBTV0lPVExCLgo+Cj4gTGlrZSBsZWdhY3kgZGV2aWNlcyB0aGF0IEtWTSBjYW4gZXhw
b3NlIChmbG9wcHkgZHJpdmVyPywgU1ZHQSBkcml2ZXIpPwoKCk15IHVuZGVyc3RhbmRpbmcgaXMg
dGhhdCB3ZSBzaG91bGRuJ3QgZW5hYmxlIHRoZSBsZWdhY3kgZGV2aWNlcyBhdCBhbGwgCmluIHRo
aXMgY2FzZS4KCk5vdGUgdGhhdCB2aXJ0aW8gaGFzIGJlZW4gZXh0ZW5kZWQgdG8gdmFyaW91cyB0
eXBlcyBvZiBkZXZpY2VzICh3ZSBjYW4gCmJvb3QgcWVtdSB3aXRob3V0IFBDSSBhbmQgbGVnYWN5
IGRldmljZXMgKGUuZyB0aGUgbWljcm8gVk0pKQoKLSB2aXJ0aW8gaW5wdXQKLSB2aXJ0aW8gZ3B1
Ci0gdmlydGlvIHNvdW5kCi4uLgoKSSdtIG5vdCBzdXJlIHdoZXRoZXIgd2UgbmVlZCBmbG9wcHks
IGJ1dCBpdCdzIG5vdCBoYXJkIHRvIGhhdmUgYSAKdmlydGlvLWZsb3BweSBpZiBuZWNlc3NhcnkK
ClNvIGl0IHdvdWxkIGJlIHN1ZmZpY2llbnQgZm9yIHVzIHRvIGF1ZGl0L2hhcmRlbiB0aGUgdmly
dGlvIGRyaXZlcnMuCgoKPgo+Pgo+PiBTbyBJIHRoaW5rIHdlIG5lZWQgdG8gY29uc29saWRhdGUg
b24gYm90aCBsYXllcnMgaW5zdGVhZCBvZiBzb2xlbHkgCj4+IGRlcGVuZGluZyBvbiB0aGUgU1dJ
T1RMQi4KPgo+IFBsZWFzZSBtYWtlIHN1cmUgdGhhdCB0aGlzIGV4cGxhbmF0aW9uIGlzIGluIHBh
cnQgb2YgdGhlIGNvdmVyIGxldHRlcgo+IG9yIGluIHRoZSBjb21taXQvS2NvbmZpZy4KCgpJIHdp
bGwgZG8gdGhhdCBpZiB0aGUgc2VyaWVzIG5lZWRzIGEgcmVzcGluLgoKCj4KPiBBbHNvLCBhcmUg
eW91IGF3YXJlIG9mIHRoZSBwYXRjaHNldCB0aGFuIEFuZGkgYmVlbiB3b3JraW5nIG9uIHRoYXQg
Cj4gdHJpZXMgdG8gbWFrZSB0aGUgRE1BIGNvZGUgdG8gaGF2ZSBleHRyYSBiZWxscyBhbmQgd2hp
c3RsZXMgZm9yIHRoaXMgCj4gcHVycG9zZT8KCgpZZXMsIGJ1dCBhcyBkZXNjcmliZWQgYWJvdmUg
dGhleSBhcmUgbm90IGR1cGxpY2F0ZWQuIFByb3RlY3Rpb24gYXQgYm90aCAKbGV2ZWxzIHdvdWxk
IGJlIG9wdGltYWwuCgpBbm90aGVyIG5vdGUgaXMgdGhhdCB0aGlzIHNlcmllcyBpcyBub3Qgb25s
eSBmb3IgRE1BL3N3aW90bGIgc3R1ZmZzLCBpdCAKZWxpbWluYXRlIGFsbCB0aGUgcG9zc2libGUg
YXR0YWNrcyB2aWEgdGhlIGRlc2NyaXB0b3IgcmluZy4KCihPbmUgZXhhbXBsZSBpcyB0aGUgYXR0
YWNrIHZpYSBkZXNjcmlwdG9yLm5leHQpCgpUaGFua3MKCgo+Cj4gVGhhbmsgeW91Lgo+PiBUaGFu
a3MKPj4KPj4KPj4+Cj4+Pj4gYWxtb3N0IGFjaGlldmVkIHRoYXQgdGhyb3VnaCBwYWNrZWQgdmly
dHF1ZXVlIGFuZCB3ZSBqdXN0IG5lZWQgdG8gZml4Cj4+Pj4gYSBjb3JuZXIgY2FzZSBvZiBoYW5k
bGluZyBtYXBwaW5nIGVycm9ycy4gRm9yIHNwbGl0IHZpcnRxdWV1ZSB3ZSBqdXN0Cj4+Pj4gZm9s
bG93IHdoYXQncyBkb25lIGluIHRoZSBwYWNrZWQuCj4+Pj4KPj4+PiBOb3RlIHRoYXQgd2UgZG9u
J3QgZHVwbGljYXRlIGRlc2NyaXB0b3IgbWVkYXRhIGZvciBpbmRpcmVjdAo+Pj4+IGRlc2NyaXB0
b3JzIHNpbmNlIGl0IHVzZXMgc3RyZWFtIG1hcHBpbmcgd2hpY2ggaXMgcmVhZCBvbmx5IHNvIGl0
J3MKPj4+PiBzYWZlIGlmIHRoZSBtZXRhZGF0YSBvZiBub24taW5kaXJlY3QgZGVzY3JpcHRvcnMg
YXJlIGNvcnJlY3QuCj4+Pj4KPj4+PiBUaGUgYmVoYWl2b3IgZm9yIG5vbiBETUEgQVBJIGlzIGtl
cHQgZm9yIG1pbmltaXppbmcgdGhlIHBlcmZvcm1hbmNlCj4+Pj4gaW1wYWN0Lgo+Pj4+Cj4+Pj4g
U2xpZ2h0bHkgdGVzdGVkIHdpdGggcGFja2VkIG9uL29mZiwgaW9tbXUgb24vb2YsIHN3aW90bGIg
Zm9yY2Uvb2ZmIGluCj4+Pj4gdGhlIGd1ZXN0Lgo+Pj4+Cj4+Pj4gUGxlYXNlIHJldmlldy4KPj4+
Pgo+Pj4+IFsxXSAKPj4+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvZmFiNjE1Y2Ut
NWUxMy1hM2IzLTM3MTUtYTQyMDNiNGFiMDEwQHJlZGhhdC5jb20vVC8gCj4+Pj4KPj4+PiBbMl0g
Cj4+Pj4gaHR0cHM6Ly95aGJ0Lm5ldC9sb3JlL2FsbC9jMzYyOWEyNy0zNTkwLTFkOWYtMjExYi1j
MGI3YmUxNTJiMzJAcmVkaGF0LmNvbS9ULyNtYzZiNmUyMzQzY2JlZmZjYTY4Y2E3YTk3ZTBmNDcz
YWFhODcxYzk1YiAKPj4+Pgo+Pj4+Cj4+Pj4gSmFzb24gV2FuZyAoNyk6Cj4+Pj4gwqDCoCB2aXJ0
aW8tcmluZzogbWFpbnRhaW4gbmV4dCBpbiBleHRyYSBzdGF0ZSBmb3IgcGFja2VkIHZpcnRxdWV1
ZQo+Pj4+IMKgwqAgdmlydGlvX3Jpbmc6IHJlbmFtZSB2cmluZ19kZXNjX2V4dHJhX3BhY2tlZAo+
Pj4+IMKgwqAgdmlydGlvLXJpbmc6IGZhY3RvciBvdXQgZGVzY19leHRyYSBhbGxvY2F0aW9uCj4+
Pj4gwqDCoCB2aXJ0aW9fcmluZzogc2VjdXJlIGhhbmRsaW5nIG9mIG1hcHBpbmcgZXJyb3JzCj4+
Pj4gwqDCoCB2aXJ0aW9fcmluZzogaW50cm9kdWNlIHZpcnRxdWV1ZV9kZXNjX2FkZF9zcGxpdCgp
Cj4+Pj4gwqDCoCB2aXJ0aW86IHVzZSBlcnIgbGFiZWwgaW4gX192cmluZ19uZXdfdmlydHF1ZXVl
KCkKPj4+PiDCoMKgIHZpcnRpby1yaW5nOiBzdG9yZSBETUEgbWV0YWRhdGEgaW4gZGVzY19leHRy
YSBmb3Igc3BsaXQgdmlydHF1ZXVlCj4+Pj4KPj4+PiDCoCBkcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cmluZy5jIHwgMTg5IAo+Pj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tCj4+
Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDE0MSBpbnNlcnRpb25zKCspLCA0OCBkZWxldGlvbnMoLSkK
Pj4+Pgo+Pj4+IC0tIAo+Pj4+IDIuMjUuMQo+Pj4+Cj4+Cj4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
