Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57F4C433FE
	for <virtualization@archiver.kernel.org>; Mon, 17 Jan 2022 08:32:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 341B380B5D;
	Mon, 17 Jan 2022 08:32:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fSKHL2XuD69H; Mon, 17 Jan 2022 08:32:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BBC2181376;
	Mon, 17 Jan 2022 08:32:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96EAFC0031;
	Mon, 17 Jan 2022 08:32:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6373FC002F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 08:32:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4A4B760615
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 08:32:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7nIpbUY8Yag8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 08:32:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 972B4605E8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 08:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642408321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vaBNs95WDlXx8iGl0AyfpROH/j47Hay2zVSLmFsrGtg=;
 b=Mq8yNpeEq2DZTB2XDE10++mLPAMFwqc9tz8XhoL9Xse00bZfhLMxOCIeGKniUI8XyLMEvJ
 zTpr0HNxa0bOL8C5ATCwzUuUn0b4MroZnc4RaAG+jxRBjnwVjepScfVuTfGij2ZhTzHZjM
 NQ89IhJtqnDW05DdGGg5OirnwssqP60=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-qtRrliWAOny3Jv_gSTINdw-1; Mon, 17 Jan 2022 03:31:59 -0500
X-MC-Unique: qtRrliWAOny3Jv_gSTINdw-1
Received: by mail-ed1-f70.google.com with SMTP id
 j10-20020a05640211ca00b003ff0e234fdfso13597107edw.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 00:31:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:organization:subject
 :in-reply-to:content-transfer-encoding;
 bh=vaBNs95WDlXx8iGl0AyfpROH/j47Hay2zVSLmFsrGtg=;
 b=pfZ1kZteDcvtgKbAbMOLt9RK3ycgcdP033Kng6rUauWaUVlnUuWy14v1l1dne/lvVT
 Kwdiu14VziJ6CAFZjpJtmDXTnD52VDkc5VoUxXE6szTuywVa6Km16nvRodV/i+VIBsyn
 hoaJbJYxygoUjSA7CuirvIhMk9rSqGHuYHwls/CYR/LBYsQmz6vNTSP7D0/EOR5fqFBO
 m3MhDwAs3OYhxXTPGpVd4p1dFhGYsZDhdg62N5zeBbjga/pQSAQdNNjZ/BQg2/n+T2IU
 2eOa5D69ZCa/pCuWML81vXTHOMgdVbzzqNldIBlsd0dySprLi5K5lOenGYRKV2rYh3Yl
 w5dg==
X-Gm-Message-State: AOAM531NogBc17spDYCZ76t6xiKxBDEKxcgWE0dObW5H1fkZgVQR/9Ez
 XRod1JRjF+RQyDFTPYKyB2w2ZjthT19vW+OwOmrrIShZ42u/MXUa+HFv70XUdtf+hj1rvARzIWn
 paAD7q8paP7ifcVXhxqYElM3JF0/ROp21+hwMfJ/ZPQ==
X-Received: by 2002:aa7:c609:: with SMTP id h9mr20143854edq.248.1642408318293; 
 Mon, 17 Jan 2022 00:31:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgZa/KW4xGU199wi9i9/KP8wY0G54upJDfddwLxn3V0PbEj2XKQGZhKuv6oRoWoO1Yxc7NKg==
X-Received: by 2002:aa7:c609:: with SMTP id h9mr20143839edq.248.1642408318111; 
 Mon, 17 Jan 2022 00:31:58 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:dd00:68a1:1bd:6733:bde9?
 (p200300cbc705dd0068a101bd6733bde9.dip0.t-ipconnect.de.
 [2003:cb:c705:dd00:68a1:1bd:6733:bde9])
 by smtp.gmail.com with ESMTPSA id b19sm2463073edr.40.2022.01.17.00.31.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jan 2022 00:31:57 -0800 (PST)
Message-ID: <7ec8218e-9d76-a9b7-ccd0-b7c8ce257fe2@redhat.com>
Date: Mon, 17 Jan 2022 09:31:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20220114214324.239444-1-mst@redhat.com>
 <1f703ebf-0f78-e530-0fe1-163613397cad@redhat.com>
 <20220117025341-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] virtio_mem: break device on remove
In-Reply-To: <20220117025341-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gMTcuMDEuMjIgMDg6NTUsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBPbiBNb24sIEph
biAxNywgMjAyMiBhdCAwMjo0MDoxMVBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pgo+PiDl
nKggMjAyMi8xLzE1IOS4iuWNiDU6NDMsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4+PiBB
IGNvbW1vbiBwYXR0ZXJuIGZvciBkZXZpY2UgcmVzZXQgaXMgY3VycmVudGx5Ogo+Pj4gdmRldi0+
Y29uZmlnLT5yZXNldCh2ZGV2KTsKPj4+IC4uIGNsZWFudXAgLi4KPj4+Cj4+PiByZXNldCBwcmV2
ZW50cyBuZXcgaW50ZXJydXB0cyBmcm9tIGFycml2aW5nIGFuZCB3YWl0cyBmb3IgaW50ZXJydXB0
Cj4+PiBoYW5kbGVycyB0byBmaW5pc2guCj4+Pgo+Pj4gSG93ZXZlciBpZiAtIGFzIGlzIGNvbW1v
biAtIHRoZSBoYW5kbGVyIHF1ZXVlcyBhIHdvcmsgcmVxdWVzdCB3aGljaCBpcwo+Pj4gZmx1c2hl
ZCBkdXJpbmcgdGhlIGNsZWFudXAgc3RhZ2UsIHdlIGhhdmUgY29kZSBhZGRpbmcgYnVmZmVycyAv
IHRyeWluZwo+Pj4gdG8gZ2V0IGJ1ZmZlcnMgd2hpbGUgZGV2aWNlIGlzIHJlc2V0LiBOb3QgZ29v
ZC4KPj4+Cj4+PiBUaGlzIHdhcyByZXByb2R1Y2VkIGJ5IHJ1bm5pbmcKPj4+IAltb2Rwcm9iZSB2
aXJ0aW9fY29uc29sZQo+Pj4gCW1vZHByb2JlIC1yIHZpcnRpb19jb25zb2xlCj4+PiBpbiBhIGxv
b3AsIGFuZCB0aGlzIHJlYXNvbmluZyBzZWVtcyB0byBhcHBseSB0byB2aXJ0aW8gbWVtIHRob3Vn
aAo+Pj4gSSBjb3VsZCBub3QgcmVwcm9kdWNlIGl0IHRoZXJlLgo+Pj4KPj4+IEZpeCB0aGlzIHVw
IGJ5IGNhbGxpbmcgdmlydGlvX2JyZWFrX2RldmljZSArIGZsdXNoIGJlZm9yZSByZXNldC4KPj4+
Cj4+PiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+
Pj4gLS0tCj4+PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19tZW0uYyB8IDIgKysKPj4+ICAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fbWVtLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fbWVtLmMKPj4+IGlu
ZGV4IDM4YmVjZDhkNTc4Yy4uMzNiOGExMThhM2FlIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92
aXJ0aW8vdmlydGlvX21lbS5jCj4+PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fbWVtLmMK
Pj4+IEBAIC0yODg4LDYgKzI4ODgsOCBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9fbWVtX3JlbW92ZShz
dHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPj4+ICAgCQl2aXJ0aW9fbWVtX2RlaW5pdF9ob3Rw
bHVnKHZtKTsKPj4+ICAgCS8qIHJlc2V0IHRoZSBkZXZpY2UgYW5kIGNsZWFudXAgdGhlIHF1ZXVl
cyAqLwo+Pj4gKwl2aXJ0aW9fYnJlYWtfZGV2aWNlKHZkZXYpOwo+Pj4gKwlmbHVzaF93b3JrKCZ2
bS0+d3EpOwo+Pgo+Pgo+PiBXZSBzZXQgdm0tPnJlbW92aW5nIHRvIHRydWUgYW5kIGNhbGwgY2Fu
Y2VsX3dvcmtfc3luYygpIGluCj4+IHZpcnRpb19tZW1fZGVpbml0X2hvdHBsdWcoKS4gSXNuJ3Qg
aXMgc3VmZmljaWVudD8KPj4KPj4gVGhhbmtzCj4gCj4gCj4gSG1tIEkgdGhpbmsgeW91IGFyZSBy
aWdodC4gRGF2aWQsIEkgd2lsbCBkcm9wIHRoaXMgZm9yIG5vdy4KPiBVcCB0byB5b3UgdG8gY29u
c2lkZXIgd2hldGhlciBzb21lIGNlbnRyYWwgY2FwYWJpbGl0eSB3aWxsIGJlCj4gaGVscGZ1bCBh
cyBhIHJlcGxhY2VtZW50IGZvciB0aGUgdmlydGlvLW1lbSBzcGVjaWZpYyAicmVtb3ZpbmciIGZs
YWcuCgpJdCdzIGFsbCBhIGJpdCB0cmlja3kgYmVjYXVzZSB3ZSBhbHNvIGhhdmUgdG8gaGFuZGxl
IHBlbmRpbmcgdGltZXJzIGFuZApwZW5kaW5nIG1lbW9yeSBvbmxpbmluZy9vZmZsaW5pbmcgb3Bl
cmF0aW9ucyBpbiBhIGNvbnRyb2xsZWQgd2F5LiBNYXliZQp3ZSBjb3VsZCBjb252ZXJ0IHRvIHZp
cnRpb19icmVha19kZXZpY2UoKSBhbmQgdXNlIHRoZQomZGV2LT52cXNfbGlzdF9sb2NrIGFzIGEg
cmVwbGFjZW1lbnQgZm9yIHRoZSByZW1vdmFsX2xvY2suIEhvd2V2ZXIsIEknbQpub3QgMTAwJSBz
dXJlIGlmIGl0J3MgbmljZSB0byB1c2UgdGhhdCBsb2NrIGZyb20KZHJpdmVycy92aXJ0aW8vdmly
dGlvX21lbS5jIGRpcmVjdGx5LgotLSAKVGhhbmtzLAoKRGF2aWQgLyBkaGlsZGVuYgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
