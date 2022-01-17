Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA714C433EF
	for <virtualization@archiver.kernel.org>; Mon, 17 Jan 2022 08:40:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7549D40285;
	Mon, 17 Jan 2022 08:40:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yqtGOnZpy3NB; Mon, 17 Jan 2022 08:40:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0A2BB40108;
	Mon, 17 Jan 2022 08:40:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD871C0031;
	Mon, 17 Jan 2022 08:40:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E66BC002F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 08:40:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C43340273
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 08:40:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z89Y0jRlENPk
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 08:40:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 955F140108
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 08:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642408849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BLjuH51cFkRJWVNi3hBO0xfpEwddo5qConrJZzRzMjU=;
 b=YYAkVJ1EXyYfqpOiRL0Mi3bDGt/XakGREToGcVVw0Hp6vWpcNEK/pUJ4O3zPFVSPyZHi7y
 Bhi0+qLEsUMxmuop2iQoxzpY400ta/I3QIaxKENb2oZM4u7s2HqV5y1HVMznjPkt8W4CAV
 ku2Ty7npTcLxOi6J0CZ3COpzZN1iV8g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-gteNVCvZNdStuQBY4fpjZQ-1; Mon, 17 Jan 2022 03:40:47 -0500
X-MC-Unique: gteNVCvZNdStuQBY4fpjZQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 k41-20020a05600c1ca900b0034aea0b9948so8273806wms.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 00:40:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=BLjuH51cFkRJWVNi3hBO0xfpEwddo5qConrJZzRzMjU=;
 b=gXuRu/UtVoUMx9RQ0iLeN+6Uw0bnhnH4AW6R0Cs1M966JzvWzij/HlH+gIp6Wb/BKe
 fr06HZXYYk5v9YaoSRBsov6cT8KYNqi/xJnb8KYdDRR0q2DVZcQfOIVKTjYKhkslTLQ2
 ut9UScJ9T6SfQcwaAjhLNU7322Uat6Mk2zDMU/GTYiKqroYM1t/h3Nt1/49ejLLbd1Vq
 Jz4ijAIVH5l9fEwoIEBv7Ts2lzz6zla8bCh26vyVnQoLhiZs/Y7cD/8zvn2xSFi7SNzi
 4gZInDFB62iNSPzvSak4CxHBg2yJ2dlt0KcbZsf8WyeBPr4beWt3yBTPLbmRKNr7bfqG
 +ACg==
X-Gm-Message-State: AOAM533MQw6w6govESQ1kCCnqDMS0cySTutUpyO37VXhXcV40ItSfgGQ
 GCzRHPs8ULJ/Pyc74+WMd9w6/yDOGWKmvTdKJLVtbgSJO1zAOEan9OIFRI1pfJLIXbCNjQlcc+6
 8BmKRJ9HF0jY+mg7y2Z4KilizfoAxBQuZB28KVURfaQ==
X-Received: by 2002:adf:f2c5:: with SMTP id d5mr17796702wrp.90.1642408846468; 
 Mon, 17 Jan 2022 00:40:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXvnwrS6Hhqbeb42pM4DaQ5d43/2YR56/T2526aA/yVtEqYoPRUrehv7UyFOqn/AS4Ix3E9w==
X-Received: by 2002:adf:f2c5:: with SMTP id d5mr17796672wrp.90.1642408846176; 
 Mon, 17 Jan 2022 00:40:46 -0800 (PST)
Received: from redhat.com ([2.55.154.241])
 by smtp.gmail.com with ESMTPSA id y9sm5950678wrm.94.2022.01.17.00.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jan 2022 00:40:45 -0800 (PST)
Date: Mon, 17 Jan 2022 03:40:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] virtio_mem: break device on remove
Message-ID: <20220117033644-mutt-send-email-mst@kernel.org>
References: <20220114214324.239444-1-mst@redhat.com>
 <1f703ebf-0f78-e530-0fe1-163613397cad@redhat.com>
 <20220117025341-mutt-send-email-mst@kernel.org>
 <7ec8218e-9d76-a9b7-ccd0-b7c8ce257fe2@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7ec8218e-9d76-a9b7-ccd0-b7c8ce257fe2@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

T24gTW9uLCBKYW4gMTcsIDIwMjIgYXQgMDk6MzE6NTZBTSArMDEwMCwgRGF2aWQgSGlsZGVuYnJh
bmQgd3JvdGU6Cj4gT24gMTcuMDEuMjIgMDg6NTUsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToK
PiA+IE9uIE1vbiwgSmFuIDE3LCAyMDIyIGF0IDAyOjQwOjExUE0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4gPj4KPiA+PiDlnKggMjAyMi8xLzE1IOS4iuWNiDU6NDMsIE1pY2hhZWwgUy4gVHNp
cmtpbiDlhpnpgZM6Cj4gPj4+IEEgY29tbW9uIHBhdHRlcm4gZm9yIGRldmljZSByZXNldCBpcyBj
dXJyZW50bHk6Cj4gPj4+IHZkZXYtPmNvbmZpZy0+cmVzZXQodmRldik7Cj4gPj4+IC4uIGNsZWFu
dXAgLi4KPiA+Pj4KPiA+Pj4gcmVzZXQgcHJldmVudHMgbmV3IGludGVycnVwdHMgZnJvbSBhcnJp
dmluZyBhbmQgd2FpdHMgZm9yIGludGVycnVwdAo+ID4+PiBoYW5kbGVycyB0byBmaW5pc2guCj4g
Pj4+Cj4gPj4+IEhvd2V2ZXIgaWYgLSBhcyBpcyBjb21tb24gLSB0aGUgaGFuZGxlciBxdWV1ZXMg
YSB3b3JrIHJlcXVlc3Qgd2hpY2ggaXMKPiA+Pj4gZmx1c2hlZCBkdXJpbmcgdGhlIGNsZWFudXAg
c3RhZ2UsIHdlIGhhdmUgY29kZSBhZGRpbmcgYnVmZmVycyAvIHRyeWluZwo+ID4+PiB0byBnZXQg
YnVmZmVycyB3aGlsZSBkZXZpY2UgaXMgcmVzZXQuIE5vdCBnb29kLgo+ID4+Pgo+ID4+PiBUaGlz
IHdhcyByZXByb2R1Y2VkIGJ5IHJ1bm5pbmcKPiA+Pj4gCW1vZHByb2JlIHZpcnRpb19jb25zb2xl
Cj4gPj4+IAltb2Rwcm9iZSAtciB2aXJ0aW9fY29uc29sZQo+ID4+PiBpbiBhIGxvb3AsIGFuZCB0
aGlzIHJlYXNvbmluZyBzZWVtcyB0byBhcHBseSB0byB2aXJ0aW8gbWVtIHRob3VnaAo+ID4+PiBJ
IGNvdWxkIG5vdCByZXByb2R1Y2UgaXQgdGhlcmUuCj4gPj4+Cj4gPj4+IEZpeCB0aGlzIHVwIGJ5
IGNhbGxpbmcgdmlydGlvX2JyZWFrX2RldmljZSArIGZsdXNoIGJlZm9yZSByZXNldC4KPiA+Pj4K
PiA+Pj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4K
PiA+Pj4gLS0tCj4gPj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX21lbS5jIHwgMiArKwo+ID4+
PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPiA+Pj4KPiA+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19tZW0uYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19t
ZW0uYwo+ID4+PiBpbmRleCAzOGJlY2Q4ZDU3OGMuLjMzYjhhMTE4YTNhZSAxMDA2NDQKPiA+Pj4g
LS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX21lbS5jCj4gPj4+ICsrKyBiL2RyaXZlcnMvdmly
dGlvL3ZpcnRpb19tZW0uYwo+ID4+PiBAQCAtMjg4OCw2ICsyODg4LDggQEAgc3RhdGljIHZvaWQg
dmlydGlvX21lbV9yZW1vdmUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gPj4+ICAgCQl2
aXJ0aW9fbWVtX2RlaW5pdF9ob3RwbHVnKHZtKTsKPiA+Pj4gICAJLyogcmVzZXQgdGhlIGRldmlj
ZSBhbmQgY2xlYW51cCB0aGUgcXVldWVzICovCj4gPj4+ICsJdmlydGlvX2JyZWFrX2RldmljZSh2
ZGV2KTsKPiA+Pj4gKwlmbHVzaF93b3JrKCZ2bS0+d3EpOwo+ID4+Cj4gPj4KPiA+PiBXZSBzZXQg
dm0tPnJlbW92aW5nIHRvIHRydWUgYW5kIGNhbGwgY2FuY2VsX3dvcmtfc3luYygpIGluCj4gPj4g
dmlydGlvX21lbV9kZWluaXRfaG90cGx1ZygpLiBJc24ndCBpcyBzdWZmaWNpZW50Pwo+ID4+Cj4g
Pj4gVGhhbmtzCj4gPiAKPiA+IAo+ID4gSG1tIEkgdGhpbmsgeW91IGFyZSByaWdodC4gRGF2aWQs
IEkgd2lsbCBkcm9wIHRoaXMgZm9yIG5vdy4KPiA+IFVwIHRvIHlvdSB0byBjb25zaWRlciB3aGV0
aGVyIHNvbWUgY2VudHJhbCBjYXBhYmlsaXR5IHdpbGwgYmUKPiA+IGhlbHBmdWwgYXMgYSByZXBs
YWNlbWVudCBmb3IgdGhlIHZpcnRpby1tZW0gc3BlY2lmaWMgInJlbW92aW5nIiBmbGFnLgo+IAo+
IEl0J3MgYWxsIGEgYml0IHRyaWNreSBiZWNhdXNlIHdlIGFsc28gaGF2ZSB0byBoYW5kbGUgcGVu
ZGluZyB0aW1lcnMgYW5kCj4gcGVuZGluZyBtZW1vcnkgb25saW5pbmcvb2ZmbGluaW5nIG9wZXJh
dGlvbnMgaW4gYSBjb250cm9sbGVkIHdheS4gTWF5YmUKPiB3ZSBjb3VsZCBjb252ZXJ0IHRvIHZp
cnRpb19icmVha19kZXZpY2UoKSBhbmQgdXNlIHRoZQo+ICZkZXYtPnZxc19saXN0X2xvY2sgYXMg
YSByZXBsYWNlbWVudCBmb3IgdGhlIHJlbW92YWxfbG9jay4gSG93ZXZlciwgSSdtCj4gbm90IDEw
MCUgc3VyZSBpZiBpdCdzIG5pY2UgdG8gdXNlIHRoYXQgbG9jayBmcm9tCj4gZHJpdmVycy92aXJ0
aW8vdmlydGlvX21lbS5jIGRpcmVjdGx5LgoKV2UgY291bGQgYWRkIGFuIEFQSSBpZiB5b3UgbGlr
ZS4gT3IgbWF5YmUgaXQgbWFrZXMgc2Vuc2UgdG8gYWRkIGEKc2VwYXJhdGUgb25lIHRoYXQgbGV0
cyB5b3UgZmluZCBvdXQgdGhhdCByZW1vdmFsIHN0YXJ0ZWQuIE5lZWQgdG8gZmlndXJlCm91dCBo
b3cgdG8gaGFuZGxlIHN1c3BlbmQgdG9vIHRoZW4gLi4uCkdlbmVyYWxseSB3ZSBoYXZlIHRoZXNl
IGNoZWNrcyB0aGF0IGRldmljZSBpcyBub3QgZ29pbmcgYXdheQpzcHJpbmtsZWQgb3ZlciBhbGwg
ZHJpdmVycyBhbmQgSSBkb24ndCBsaWtlIGl0LCBidXQKaXQncyBub3QgZWFzeSB0byBidWlsZCBh
IHNhbmUgQVBJIHRvIGhhbmRsZSBpdCwgZXNwZWNpYWxseQpmb3IgaGlnaCBzcGVlZCB0aGluZ3Mg
d2hlbiB3ZSBjYW4ndCB0YWtlIGxvY2tzIGJlY2F1c2UgcGVyZm9ybWFuY2UuCgo+IC0tIAo+IFRo
YW5rcywKPiAKPiBEYXZpZCAvIGRoaWxkZW5iCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
