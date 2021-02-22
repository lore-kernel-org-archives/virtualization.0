Return-Path: <SRS0=djY9=HY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0496AC433DB
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 07:34:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 769F964E4B
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 07:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769F964E4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 049DB83841;
	Mon, 22 Feb 2021 07:34:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZUDnH_-0gTi6; Mon, 22 Feb 2021 07:34:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 286328380E;
	Mon, 22 Feb 2021 07:34:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DAE04C000A;
	Mon, 22 Feb 2021 07:34:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB25CC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 07:34:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B803A6F53B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 07:34:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zorUByNO0hxW
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 07:34:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 662F66F53A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 07:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613979283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6FVHK+rXFWPhvTdgY3ca3NMaeJHpQu46VbcX/NLNp1o=;
 b=YOJc6VhrxPq6zMYAvv7o9fZW68kSUf9wwDwuFwqF9ID8/oscYz0fD/iCxw9X2o4lKzhsyw
 InM3CLsZd+1tdgns/8r6VHpFohtb8LuUxzvLUxI80OhNg5p6aBzLJZPVglgAqBTBYSzKob
 1pgiyuidy2zrLH6yTSAj5mt5N5XoNk4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-C_xhpjRZONiFQuJ6qOyLhQ-1; Mon, 22 Feb 2021 02:34:42 -0500
X-MC-Unique: C_xhpjRZONiFQuJ6qOyLhQ-1
Received: by mail-ed1-f72.google.com with SMTP id q2so6490904edt.16
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Feb 2021 23:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=6FVHK+rXFWPhvTdgY3ca3NMaeJHpQu46VbcX/NLNp1o=;
 b=tXekizHEKttvLjFHT+S1gfBuLagwdWp5nA4nsHbjaaqgKsmOInKqaFUB65SWml44za
 qanvFRvGSn2FRGEe7046JcJc6X3g8DQPPisGGZn8ZCoAeHJG3PoJ8DP/9amwdRV0RiAf
 dnDf6s/M4lJhC1YC1gInlYx6xZ7bO61zoOcv3lloZiCAJWr9Oe766NyuFONvUJ+q2Q2W
 +OqTScWITqHpaYUOWnZxhyoCkWrKDldyzSavCUBJ/YzMCLm+6zJOyRS6VzYdVAuDKnq7
 S4YK8MjFMtqSnvBzW0Nhmm5nGJ5NcFhN+OCk0/rLa16wCW5Y9Im0fPgy+3rPnVyW7lE9
 adCA==
X-Gm-Message-State: AOAM530IpM9y1/1xXZmzzR6U+NqsIY9GilurQgVPB2eSOfwK4OWvjOs1
 Jxm6Z8lb9I3/2pt1wizLrwEElYhtbshBbw2enMA92UreGiM0zN3fNtVGmxHjEmUu6HZw2nGNhJp
 w6snFb4L93yEqLNu9hmJEhVF6SA/oenqdc/1juf0jhg==
X-Received: by 2002:a05:6402:3d8:: with SMTP id
 t24mr21009493edw.298.1613979280812; 
 Sun, 21 Feb 2021 23:34:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxEzpKE3VGwXPIdtln/AiroN8FBRqHsg0v8D6hpM8GMEsbhJmhd1UQeVTsGMSLWYiL91843Cw==
X-Received: by 2002:a05:6402:3d8:: with SMTP id
 t24mr21009478edw.298.1613979280624; 
 Sun, 21 Feb 2021 23:34:40 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id m26sm4603396eja.6.2021.02.21.23.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Feb 2021 23:34:40 -0800 (PST)
Date: Mon, 22 Feb 2021 02:34:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Message-ID: <20210222023040-mutt-send-email-mst@kernel.org>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
MIME-Version: 1.0
In-Reply-To: <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, netdev@vger.kernel.org, elic@nvidia.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gTW9uLCBGZWIgMjIsIDIwMjEgYXQgMTI6MTQ6MTdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIxLzIvMTkgNzo1NCDkuIvljYgsIFNpLVdlaSBMaXUgd3JvdGU6Cj4gPiBD
b21taXQgNDUyNjM5YTY0YWQ4ICgidmRwYTogbWFrZSBzdXJlIHNldF9mZWF0dXJlcyBpcyBpbnZv
a2VkCj4gPiBmb3IgbGVnYWN5IikgbWFkZSBhbiBleGNlcHRpb24gZm9yIGxlZ2FjeSBndWVzdHMg
dG8gcmVzZXQKPiA+IGZlYXR1cmVzIHRvIDAsIHdoZW4gY29uZmlnIHNwYWNlIGlzIGFjY2Vzc2Vk
IGJlZm9yZSBmZWF0dXJlcwo+ID4gYXJlIHNldC4gV2Ugc2hvdWxkIHJlbGlldmUgdGhlIHZlcmlm
eV9taW5fZmVhdHVyZXMoKSBjaGVjawo+ID4gYW5kIGFsbG93IGZlYXR1cmVzIHJlc2V0IHRvIDAg
Zm9yIHRoaXMgY2FzZS4KPiA+IAo+ID4gSXQncyB3b3J0aCBub3RpbmcgdGhhdCBub3QganVzdCBs
ZWdhY3kgZ3Vlc3RzIGNvdWxkIGFjY2Vzcwo+ID4gY29uZmlnIHNwYWNlIGJlZm9yZSBmZWF0dXJl
cyBhcmUgc2V0LiBGb3IgaW5zdGFuY2UsIHdoZW4KPiA+IGZlYXR1cmUgVklSVElPX05FVF9GX01U
VSBpcyBhZHZlcnRpc2VkIHNvbWUgbW9kZXJuIGRyaXZlcgo+ID4gd2lsbCB0cnkgdG8gYWNjZXNz
IGFuZCB2YWxpZGF0ZSB0aGUgTVRVIHByZXNlbnQgaW4gdGhlIGNvbmZpZwo+ID4gc3BhY2UgYmVm
b3JlIHZpcnRpbyBmZWF0dXJlcyBhcmUgc2V0Lgo+IAo+IAo+IFRoaXMgbG9va3MgbGlrZSBhIHNw
ZWMgdmlvbGF0aW9uOgo+IAo+ICIKPiAKPiBUaGUgZm9sbG93aW5nIGRyaXZlci1yZWFkLW9ubHkg
ZmllbGQsIG10dSBvbmx5IGV4aXN0cyBpZiBWSVJUSU9fTkVUX0ZfTVRVIGlzCj4gc2V0Lgo+IFRo
aXMgZmllbGQgc3BlY2lmaWVzIHRoZSBtYXhpbXVtIE1UVSBmb3IgdGhlIGRyaXZlciB0byB1c2Uu
Cj4gIgo+IAo+IERvIHdlIHJlYWxseSB3YW50IHRvIHdvcmthcm91bmQgdGhpcz8KPiAKPiBUaGFu
a3MKCkFuZCBhbHNvOgoKVGhlIGRyaXZlciBNVVNUIGZvbGxvdyB0aGlzIHNlcXVlbmNlIHRvIGlu
aXRpYWxpemUgYSBkZXZpY2U6CjEuIFJlc2V0IHRoZSBkZXZpY2UuCjIuIFNldCB0aGUgQUNLTk9X
TEVER0Ugc3RhdHVzIGJpdDogdGhlIGd1ZXN0IE9TIGhhcyBub3RpY2VkIHRoZSBkZXZpY2UuCjMu
IFNldCB0aGUgRFJJVkVSIHN0YXR1cyBiaXQ6IHRoZSBndWVzdCBPUyBrbm93cyBob3cgdG8gZHJp
dmUgdGhlIGRldmljZS4KNC4gUmVhZCBkZXZpY2UgZmVhdHVyZSBiaXRzLCBhbmQgd3JpdGUgdGhl
IHN1YnNldCBvZiBmZWF0dXJlIGJpdHMgdW5kZXJzdG9vZCBieSB0aGUgT1MgYW5kIGRyaXZlciB0
byB0aGUKZGV2aWNlLiBEdXJpbmcgdGhpcyBzdGVwIHRoZSBkcml2ZXIgTUFZIHJlYWQgKGJ1dCBN
VVNUIE5PVCB3cml0ZSkgdGhlIGRldmljZS1zcGVjaWZpYyBjb25maWd1cmF0aW9uCmZpZWxkcyB0
byBjaGVjayB0aGF0IGl0IGNhbiBzdXBwb3J0IHRoZSBkZXZpY2UgYmVmb3JlIGFjY2VwdGluZyBp
dC4KNS4gU2V0IHRoZSBGRUFUVVJFU19PSyBzdGF0dXMgYml0LiBUaGUgZHJpdmVyIE1VU1QgTk9U
IGFjY2VwdCBuZXcgZmVhdHVyZSBiaXRzIGFmdGVyIHRoaXMgc3RlcC4KNi4gUmUtcmVhZCBkZXZp
Y2Ugc3RhdHVzIHRvIGVuc3VyZSB0aGUgRkVBVFVSRVNfT0sgYml0IGlzIHN0aWxsIHNldDogb3Ro
ZXJ3aXNlLCB0aGUgZGV2aWNlIGRvZXMgbm90CnN1cHBvcnQgb3VyIHN1YnNldCBvZiBmZWF0dXJl
cyBhbmQgdGhlIGRldmljZSBpcyB1bnVzYWJsZS4KNy4gUGVyZm9ybSBkZXZpY2Utc3BlY2lmaWMg
c2V0dXAsIGluY2x1ZGluZyBkaXNjb3Zlcnkgb2YgdmlydHF1ZXVlcyBmb3IgdGhlIGRldmljZSwg
b3B0aW9uYWwgcGVyLWJ1cyBzZXR1cCwKcmVhZGluZyBhbmQgcG9zc2libHkgd3JpdGluZyB0aGUg
ZGV2aWNl4oCZcyB2aXJ0aW8gY29uZmlndXJhdGlvbiBzcGFjZSwgYW5kIHBvcHVsYXRpb24gb2Yg
dmlydHF1ZXVlcy4KOC4gU2V0IHRoZSBEUklWRVJfT0sgc3RhdHVzIGJpdC4gQXQgdGhpcyBwb2lu
dCB0aGUgZGV2aWNlIGlzIOKAnGxpdmXigJ0uCgoKc28gYWNjZXNzaW5nIGNvbmZpZyBzcGFjZSBi
ZWZvcmUgRkVBVFVSRVNfT0sgaXMgYSBzcGVjIHZpb2xhdGlvbiwgcmlnaHQ/CgoKPiAKPiA+IFJl
amVjdGluZyByZXNldCB0byAwCj4gPiBwcmVtYXR1cmVseSBjYXVzZXMgY29ycmVjdCBNVFUgYW5k
IGxpbmsgc3RhdHVzIHVuYWJsZSB0byBsb2FkCj4gPiBmb3IgdGhlIHZlcnkgZmlyc3QgY29uZmln
IHNwYWNlIGFjY2VzcywgcmVuZGVyaW5nIGlzc3VlcyBsaWtlCj4gPiBndWVzdCBzaG93aW5nIGlu
YWNjdXJhdGUgTVRVIHZhbHVlLCBvciBmYWlsdXJlIHRvIHJlamVjdAo+ID4gb3V0LW9mLXJhbmdl
IE1UVS4KPiA+IAo+ID4gRml4ZXM6IDFhODZiMzc3YWEyMSAoInZkcGEvbWx4NTogQWRkIFZEUEEg
ZHJpdmVyIGZvciBzdXBwb3J0ZWQgbWx4NSBkZXZpY2VzIikKPiA+IFNpZ25lZC1vZmYtYnk6IFNp
LVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4KPiA+IC0tLQo+ID4gICBkcml2ZXJzL3Zk
cGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAxNSArLS0tLS0tLS0tLS0tLS0KPiA+ICAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxNCBkZWxldGlvbnMoLSkKPiA+IAo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9t
bHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gaW5kZXggN2MxZjc4OS4uNTQwZGQ2NyAxMDA2NDQKPiA+
IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gKysrIGIvZHJpdmVy
cy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiBAQCAtMTQ5MCwxNCArMTQ5MCw2IEBAIHN0
YXRpYyB1NjQgbWx4NV92ZHBhX2dldF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYp
Cj4gPiAgIAlyZXR1cm4gbXZkZXYtPm1seF9mZWF0dXJlczsKPiA+ICAgfQo+ID4gLXN0YXRpYyBp
bnQgdmVyaWZ5X21pbl9mZWF0dXJlcyhzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHU2NCBm
ZWF0dXJlcykKPiA+IC17Cj4gPiAtCWlmICghKGZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9fRl9B
Q0NFU1NfUExBVEZPUk0pKSkKPiA+IC0JCXJldHVybiAtRU9QTk9UU1VQUDsKPiA+IC0KPiA+IC0J
cmV0dXJuIDA7Cj4gPiAtfQo+ID4gLQo+ID4gICBzdGF0aWMgaW50IHNldHVwX3ZpcnRxdWV1ZXMo
c3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYpCj4gPiAgIHsKPiA+ICAgCWludCBlcnI7Cj4gPiBA
QCAtMTU1OCwxOCArMTU1MCwxMyBAQCBzdGF0aWMgaW50IG1seDVfdmRwYV9zZXRfZmVhdHVyZXMo
c3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1NjQgZmVhdHVyZXMpCj4gPiAgIHsKPiA+ICAgCXN0
cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiA9IHRvX212ZGV2KHZkZXYpOwo+ID4gICAJc3RydWN0
IG1seDVfdmRwYV9uZXQgKm5kZXYgPSB0b19tbHg1X3ZkcGFfbmRldihtdmRldik7Cj4gPiAtCWlu
dCBlcnI7Cj4gPiAgIAlwcmludF9mZWF0dXJlcyhtdmRldiwgZmVhdHVyZXMsIHRydWUpOwo+ID4g
LQllcnIgPSB2ZXJpZnlfbWluX2ZlYXR1cmVzKG12ZGV2LCBmZWF0dXJlcyk7Cj4gPiAtCWlmIChl
cnIpCj4gPiAtCQlyZXR1cm4gZXJyOwo+ID4gLQo+ID4gICAJbmRldi0+bXZkZXYuYWN0dWFsX2Zl
YXR1cmVzID0gZmVhdHVyZXMgJiBuZGV2LT5tdmRldi5tbHhfZmVhdHVyZXM7Cj4gPiAgIAluZGV2
LT5jb25maWcubXR1ID0gY3B1X3RvX21seDV2ZHBhMTYobXZkZXYsIG5kZXYtPm10dSk7Cj4gPiAg
IAluZGV2LT5jb25maWcuc3RhdHVzIHw9IGNwdV90b19tbHg1dmRwYTE2KG12ZGV2LCBWSVJUSU9f
TkVUX1NfTElOS19VUCk7Cj4gPiAtCXJldHVybiBlcnI7Cj4gPiArCXJldHVybiAwOwo+ID4gICB9
Cj4gPiAgIHN0YXRpYyB2b2lkIG1seDVfdmRwYV9zZXRfY29uZmlnX2NiKHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRldiwgc3RydWN0IHZkcGFfY2FsbGJhY2sgKmNiKQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
