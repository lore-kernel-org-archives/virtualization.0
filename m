Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A086C433EF
	for <virtualization@archiver.kernel.org>; Tue, 14 Dec 2021 05:08:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C423F8137C;
	Tue, 14 Dec 2021 05:08:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TGB2utxX7BYV; Tue, 14 Dec 2021 05:08:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2EE9781378;
	Tue, 14 Dec 2021 05:08:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05E5FC002F;
	Tue, 14 Dec 2021 05:08:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 134ACC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 05:08:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E0ACD40137
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 05:08:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xw1lxheBq8M4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 05:08:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 674BC400F5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 05:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639458492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OBHzgpNG5qwGxFpFqo+UbXajiFs/3vLUugDY970MpYI=;
 b=e34mw9EcEwx797rkqHgIAcsTnBWo/oFoGwDZAiEIqy9HFJZrnEnDz1XV5yNx0KdjD1FAVL
 swcvcv/6Mu9ScllbtGBBBJDU2TyHsuX5+djVFT8EV91qugN/dEGRsmRsq2VfavFuo1dQw9
 Odj0naCR6OZF+PfCtSxoJpHprdiXasQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-Ho5Lh951OJya0WPxhtKjLQ-1; Tue, 14 Dec 2021 00:06:13 -0500
X-MC-Unique: Ho5Lh951OJya0WPxhtKjLQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 o18-20020a05600c511200b00332fa17a02eso7417543wms.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 21:06:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=OBHzgpNG5qwGxFpFqo+UbXajiFs/3vLUugDY970MpYI=;
 b=eJJZB282tcG2ofXuRcrzVqxB3cUEwCeFNvgB5H865EAoDeE3SKnIuy6EqGrCOjJ7eg
 vnpGQwF/dd7zP8ZMrQJ0VRbXzOyzeyA5QPc5lvA55FQk3HMU1l4w6EVt6waKgmm95p0L
 PMauba+k0dPvg+34Uqbi3h6cZ5nClImNVSDxwM4GnnhzgC6iOWBzd1C+iKesLURJO0NG
 3OXPblIHfZ//CfReSY/GOVmyfrwuDrtv1RuvsbrdcDL1upJmtl5dRUtc5Ln20iFtn9Af
 0noylP9it29fKEeVUUtLXgg/LGsrTC6GYZnjk/BLlzT4VbXjoOBV3p4RwILyeeMRdLlG
 ddkQ==
X-Gm-Message-State: AOAM532s+I1IubYefocXPxFGzw8HM+VZ1/5BEQhg1hnP878qbGWWh9sz
 yz2A4Psd3rORozOAtpWIMPQpMRi1DW9LMLMoxOrolzRzNRKFxu/H3J3vY55W9DGi1JbcJU7yNG8
 YC6QXSMjUi/oK2NuxKscUMsVAvpW+0maCnsfr5BCwuw==
X-Received: by 2002:a5d:5144:: with SMTP id u4mr3227105wrt.91.1639458371962;
 Mon, 13 Dec 2021 21:06:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwk+n+lFy9zCHYPdTwwmcgN7nodpnWuaVSWcgWLaxCR9R8nw1xYnLu3T2KMPKGtr/XXwrwMVw==
X-Received: by 2002:a5d:5144:: with SMTP id u4mr3227076wrt.91.1639458371678;
 Mon, 13 Dec 2021 21:06:11 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:207d:b931:2ce5:ef76:2d17:5466])
 by smtp.gmail.com with ESMTPSA id s18sm948675wrb.91.2021.12.13.21.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Dec 2021 21:06:10 -0800 (PST)
Date: Tue, 14 Dec 2021 00:06:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: vdpa legacy guest support (was Re: [PATCH] vdpa/mlx5:
 set_features should allow reset to zero)
Message-ID: <20211214000245-mutt-send-email-mst@kernel.org>
References: <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
 <52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com>
 <20210228163031-mutt-send-email-mst@kernel.org>
 <2cb51a6d-afa0-7cd1-d6f2-6b153186eaca@redhat.com>
 <20210302043419-mutt-send-email-mst@kernel.org>
 <178f8ea7-cebd-0e81-3dc7-10a058d22c07@redhat.com>
 <c9a0932f-a6d7-a9df-38ba-97e50f70c2b2@oracle.com>
 <20211212042311-mutt-send-email-mst@kernel.org>
 <ba9df703-29af-98a9-c554-f303ff045398@oracle.com>
MIME-Version: 1.0
In-Reply-To: <ba9df703-29af-98a9-c554-f303ff045398@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 elic@nvidia.com, linux-kernel@vger.kernel.org
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

T24gTW9uLCBEZWMgMTMsIDIwMjEgYXQgMDU6NTk6NDVQTSAtMDgwMCwgU2ktV2VpIExpdSB3cm90
ZToKPiAKPiAKPiBPbiAxMi8xMi8yMDIxIDE6MjYgQU0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90
ZToKPiA+IE9uIEZyaSwgRGVjIDEwLCAyMDIxIGF0IDA1OjQ0OjE1UE0gLTA4MDAsIFNpLVdlaSBM
aXUgd3JvdGU6Cj4gPiA+IFNvcnJ5IGZvciByZXZpdmluZyB0aGlzIGFuY2llbnQgdGhyZWFkLiBJ
IHdhcyBraW5kYSBsb3N0IGZvciB0aGUgY29uY2x1c2lvbgo+ID4gPiBpdCBlbmRlZCB1cCB3aXRo
LiBJIGhhdmUgdGhlIGZvbGxvd2luZyBxdWVzdGlvbnMsCj4gPiA+IAo+ID4gPiAxLiBsZWdhY3kg
Z3Vlc3Qgc3VwcG9ydDogZnJvbSB0aGUgcGFzdCBjb252ZXJzYXRpb25zIGl0IGRvZXNuJ3Qgc2Vl
bSB0aGUKPiA+ID4gc3VwcG9ydCB3aWxsIGJlIGNvbXBsZXRlbHkgZHJvcHBlZCBmcm9tIHRoZSB0
YWJsZSwgaXMgbXkgdW5kZXJzdGFuZGluZwo+ID4gPiBjb3JyZWN0PyBBY3R1YWxseSB3ZSdyZSBp
bnRlcmVzdGVkIGluIHN1cHBvcnRpbmcgdmlydGlvIHYwLjk1IGd1ZXN0IGZvciB4ODYsCj4gPiA+
IHdoaWNoIGlzIGJhY2tlZCBieSB0aGUgc3BlYyBhdAo+ID4gPiBodHRwczovL3VybGRlZmVuc2Uu
Y29tL3YzL19faHR0cHM6Ly9vemxhYnMub3JnLypydXN0eS92aXJ0aW8tc3BlYy92aXJ0aW8tMC45
LjUucGRmX187ZmchIUFDV1Y1TjlNMlJWOTloUSFkVEttekp3d1JzRk03QnRTdVREdTFjTmx5NW40
WENvdEgwV1ltaWR6R3FIU1h0NDBpN1pVNDNVY05nN0dZeFpnJCAuIFRob3VnaCBJJ20gbm90IHN1
cmUKPiA+ID4gaWYgdGhlcmUncyByZXF1ZXN0L25lZWQgdG8gc3VwcG9ydCB3aWxkZXIgbGVnYWN5
IHZpcnRpbyB2ZXJzaW9ucyBlYXJsaWVyCj4gPiA+IGJleW9uZC4KPiA+IEkgcGVyc29uYWxseSBm
ZWVsIGl0J3MgbGVzcyB3b3JrIHRvIGFkZCBpbiBrZXJuZWwgdGhhbiB0cnkgdG8KPiA+IHdvcmsg
YXJvdW5kIGl0IGluIHVzZXJzcGFjZS4gSmFzb24gZmVlbHMgZGlmZmVyZW50bHkuCj4gPiBNYXli
ZSBwb3N0IHRoZSBwYXRjaGVzIGFuZCB0aGlzIHdpbGwgcHJvdmUgdG8gSmFzb24gaXQncyBub3QK
PiA+IHRvbyB0ZXJyaWJsZT8KPiBJIHN1cHBvc2UgaWYgdGhlIHZkcGEgdmVuZG9yIGRvZXMgc3Vw
cG9ydCAwLjk1IGluIHRoZSBkYXRhcGF0aCBhbmQgcmluZwo+IGxheW91dCBsZXZlbCBhbmQgaXMg
bGltaXRlZCB0byB4ODYgb25seSwgdGhlcmUgc2hvdWxkIGJlIGVhc3kgd2F5IG91dC4KCk5vdGUg
YSBzdWJ0bGUgZGlmZmVyZW5jZTogd2hhdCBtYXR0ZXJzIGlzIHRoYXQgZ3Vlc3QsIG5vdCBob3N0
IGlzIHg4Ni4KTWF0dGVycyBmb3IgZW11bGF0b3JzIHdoaWNoIG1pZ2h0IHJlb3JkZXIgbWVtb3J5
IGFjY2Vzc2VzLgpJIGd1ZXNzIHRoaXMgZW5mb3JjZW1lbnQgYmVsb25ncyBpbiBRRU1VIHRoZW4/
Cgo+IEkKPiBjaGVja2VkIHdpdGggRWxpIGFuZCBvdGhlciBNZWxsYW5veC9OVkRJQSBmb2xrcyBm
b3IgaGFyZHdhcmUvZmlybXdhcmUgbGV2ZWwKPiAwLjk1IHN1cHBvcnQsIGl0IHNlZW1zIGFsbCB0
aGUgaW5ncmVkaWVudCBoYWQgYmVlbiB0aGVyZSBhbHJlYWR5IGRhdGVkIGJhY2sKPiB0byB0aGUg
RFBESyBkYXlzLiBUaGUgb25seSBtYWpvciB0aGluZyBsaW1pdGluZyBpcyBpbiB0aGUgdkRQQSBz
b2Z0d2FyZSB0aGF0Cj4gdGhlIGN1cnJlbnQgdmRwYSBjb3JlIGhhcyB0aGUgYXNzdW1wdGlvbiBh
cm91bmQgVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNIGZvcgo+IGEgZmV3IERNQSBzZXR1cCBvcHMs
IHdoaWNoIGlzIHZpcnRpbyAxLjAgb25seS4KPiAKPiA+IAo+ID4gPiAyLiBzdXBwb3NlIHNvbWUg
Zm9ybSBvZiBsZWdhY3kgZ3Vlc3Qgc3VwcG9ydCBuZWVkcyB0byBiZSB0aGVyZSwgaG93IGRvIHdl
Cj4gPiA+IGRlYWwgd2l0aCB0aGUgYm9ndXMgYXNzdW1wdGlvbiBiZWxvdyBpbiB2ZHBhX2dldF9j
b25maWcoKSBpbiB0aGUgc2hvcnQgdGVybT8KPiA+ID4gSXQgbG9va3Mgb25lIG9mIHRoZSBpbnR1
aXRpdmUgZml4IGlzIHRvIG1vdmUgdGhlIHZkcGFfc2V0X2ZlYXR1cmVzIGNhbGwgb3V0Cj4gPiA+
IG9mIHZkcGFfZ2V0X2NvbmZpZygpIHRvIHZkcGFfc2V0X2NvbmZpZygpLgo+ID4gPiAKPiA+ID4g
IMKgwqDCoMKgwqDCoMKgIC8qCj4gPiA+ICDCoMKgwqDCoMKgwqDCoMKgICogQ29uZmlnIGFjY2Vz
c2VzIGFyZW4ndCBzdXBwb3NlZCB0byB0cmlnZ2VyIGJlZm9yZSBmZWF0dXJlcyBhcmUKPiA+ID4g
c2V0Lgo+ID4gPiAgwqDCoMKgwqDCoMKgwqDCoCAqIElmIGl0IGRvZXMgaGFwcGVuIHdlIGFzc3Vt
ZSBhIGxlZ2FjeSBndWVzdC4KPiA+ID4gIMKgwqDCoMKgwqDCoMKgwqAgKi8KPiA+ID4gIMKgwqDC
oMKgwqDCoMKgIGlmICghdmRldi0+ZmVhdHVyZXNfdmFsaWQpCj4gPiA+ICDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgdmRwYV9zZXRfZmVhdHVyZXModmRldiwgMCk7Cj4gPiA+ICDCoMKg
wqDCoMKgwqDCoCBvcHMtPmdldF9jb25maWcodmRldiwgb2Zmc2V0LCBidWYsIGxlbik7Cj4gPiA+
IAo+ID4gPiBJIGNhbiBwb3N0IGEgcGF0Y2ggdG8gZml4IDIpIGlmIHRoZXJlJ3MgY29uc2Vuc3Vz
IGFscmVhZHkgcmVhY2hlZC4KPiA+ID4gCj4gPiA+IFRoYW5rcywKPiA+ID4gLVNpd2VpCj4gPiBJ
J20gbm90IHN1cmUgaG93IGltcG9ydGFudCBpdCBpcyB0byBjaGFuZ2UgdGhhdC4KPiA+IEluIGFu
eSBjYXNlIGl0IG9ubHkgYWZmZWN0cyB0cmFuc2l0aW9uYWwgZGV2aWNlcywgcmlnaHQ/Cj4gPiBM
ZWdhY3kgb25seSBzaG91bGQgbm90IGNhcmUgLi4uCj4gWWVzIEknZCBsaWtlIHRvIGRpc3Rpbmd1
aXNoIGxlZ2FjeSBkcml2ZXIgKHN1cHBvc2UgaXQgaXMgMC45NSkgYWdhaW5zdCB0aGUKPiBtb2Rl
cm4gb25lIGluIGEgdHJhbnNpdGlvbmFsIGRldmljZSBtb2RlbCByYXRoZXIgdGhhbiBiZWluZyBs
ZWdhY3kgb25seS4KPiBUaGF0IHdheSBhIHYwLjk1IGFuZCB2MS4wIHN1cHBvcnRpbmcgdmRwYSBw
YXJlbnQgY2FuIHN1cHBvcnQgYm90aCB0eXBlcyBvZgo+IGd1ZXN0cyB3aXRob3V0IGhhdmluZyB0
byByZWNvbmZpZ3VyZS4gT3IgYXJlIHlvdSBzdWdnZXN0aW5nIGxpbWl0IHRvIGxlZ2FjeQo+IG9u
bHkgYXQgdGhlIHRpbWUgb2YgdmRwYSBjcmVhdGlvbiB3b3VsZCBzaW1wbGlmeSB0aGUgaW1wbGVt
ZW50YXRpb24gYSBsb3Q/Cj4gCj4gVGhhbmtzLAo+IC1TaXdlaQoKCkkgZG9uJ3Qga25vdyBmb3Ig
c3VyZS4gVGFrZSBhIGxvb2sgYXQgdGhlIHdvcmsgSGFsaWwgd2FzIGRvaW5nCnRvIHRyeSBhbmQg
c3VwcG9ydCB0cmFuc2l0aW9uYWwgZGV2aWNlcyB3aXRoIEJFIGd1ZXN0cy4KCgo+ID4gCj4gPiA+
IE9uIDMvMi8yMDIxIDI6NTMgQU0sIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gT24gMjAyMS8z
LzIgNTo0NyDkuIvljYgsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+IE9uIE1v
biwgTWFyIDAxLCAyMDIxIGF0IDExOjU2OjUwQU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4g
PiA+ID4gPiA+IE9uIDIwMjEvMy8xIDU6MzQg5LiK5Y2ILCBNaWNoYWVsIFMuIFRzaXJraW4gd3Jv
dGU6Cj4gPiA+ID4gPiA+ID4gT24gV2VkLCBGZWIgMjQsIDIwMjEgYXQgMTA6MjQ6NDFBTSAtMDgw
MCwgU2ktV2VpIExpdSB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gRGV0ZWN0aW5nIGl0IGlzbid0
IGVub3VnaCB0aG91Z2gsIHdlIHdpbGwgbmVlZCBhIG5ldyBpb2N0bCB0byBub3RpZnkKPiA+ID4g
PiA+ID4gPiA+ID4gdGhlIGtlcm5lbCB0aGF0IGl0J3MgYSBsZWdhY3kgZ3Vlc3QuIFVnaCA6KAo+
ID4gPiA+ID4gPiA+ID4gV2VsbCwgYWx0aG91Z2ggSSB0aGluayBhZGRpbmcgYW4gaW9jdGwgaXMg
ZG9hYmxlLCBtYXkgSQo+ID4gPiA+ID4gPiA+ID4ga25vdyB3aGF0IHRoZSB1c2UKPiA+ID4gPiA+
ID4gPiA+IGNhc2UgdGhlcmUgd2lsbCBiZSBmb3Iga2VybmVsIHRvIGxldmVyYWdlIHN1Y2ggaW5m
bwo+ID4gPiA+ID4gPiA+ID4gZGlyZWN0bHk/IElzIHRoZXJlIGEKPiA+ID4gPiA+ID4gPiA+IGNh
c2UgUUVNVSBjYW4ndCBkbyB3aXRoIGRlZGljYXRlIGlvY3RscyBsYXRlciBpZiB0aGVyZSdzIGlu
ZGVlZAo+ID4gPiA+ID4gPiA+ID4gZGlmZmVyZW50aWF0aW9uIChsZWdhY3kgdi5zLiBtb2Rlcm4p
IG5lZWRlZD8KPiA+ID4gPiA+ID4gPiBCVFcgYSBnb29kIEFQSSBjb3VsZCBiZQo+ID4gPiA+ID4g
PiA+IAo+ID4gPiA+ID4gPiA+ICNkZWZpbmUgVkhPU1RfU0VUX0VORElBTiBfSU9XKFZIT1NUX1ZJ
UlRJTywgPywgaW50KQo+ID4gPiA+ID4gPiA+ICNkZWZpbmUgVkhPU1RfR0VUX0VORElBTiBfSU9X
KFZIT1NUX1ZJUlRJTywgPywgaW50KQo+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+IHdlIGRp
ZCBpdCBwZXIgdnJpbmcgYnV0IG1heWJlIHRoYXQgd2FzIGEgbWlzdGFrZSAuLi4KPiA+ID4gPiA+
ID4gQWN0dWFsbHksIEkgd29uZGVyIHdoZXRoZXIgaXQncyBnb29kIHRpbWUgdG8ganVzdCBub3Qg
c3VwcG9ydAo+ID4gPiA+ID4gPiBsZWdhY3kgZHJpdmVyCj4gPiA+ID4gPiA+IGZvciB2RFBBLiBD
b25zaWRlcjoKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IDEpIEl0J3MgZGVmaW5pdGlvbiBpcyBu
by1ub3JtYXRpdmUKPiA+ID4gPiA+ID4gMikgQSBsb3Qgb2YgYnVkcmVuIG9mIGNvZGVzCj4gPiA+
ID4gPiA+IAo+ID4gPiA+ID4gPiBTbyBxZW11IGNhbiBzdGlsbCBwcmVzZW50IHRoZSBsZWdhY3kg
ZGV2aWNlIHNpbmNlIHRoZSBjb25maWcKPiA+ID4gPiA+ID4gc3BhY2Ugb3Igb3RoZXIKPiA+ID4g
PiA+ID4gc3R1ZmZzIHRoYXQgaXMgcHJlc2VudGVkIGJ5IHZob3N0LXZEUEEgaXMgbm90IGV4cGVj
dGVkIHRvIGJlCj4gPiA+ID4gPiA+IGFjY2Vzc2VkIGJ5Cj4gPiA+ID4gPiA+IGd1ZXN0IGRpcmVj
dGx5LiBRZW11IGNhbiBkbyB0aGUgZW5kaWFuIGNvbnZlcnNpb24gd2hlbiBuZWNlc3NhcnkKPiA+
ID4gPiA+ID4gaW4gdGhpcwo+ID4gPiA+ID4gPiBjYXNlPwo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+
ID4gVGhhbmtzCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gT3ZlcmFsbCBJIHdvdWxkIGJlIGZpbmUg
d2l0aCB0aGlzIGFwcHJvYWNoIGJ1dCB3ZSBuZWVkIHRvIGF2b2lkIGJyZWFraW5nCj4gPiA+ID4g
PiB3b3JraW5nIHVzZXJzcGFjZSwgcWVtdSByZWxlYXNlcyB3aXRoIHZkcGEgc3VwcG9ydCBhcmUg
b3V0IHRoZXJlIGFuZAo+ID4gPiA+ID4gc2VlbSB0byB3b3JrIGZvciBwZW9wbGUuIEFueSBjaGFu
Z2VzIG5lZWQgdG8gdGFrZSB0aGF0IGludG8gYWNjb3VudAo+ID4gPiA+ID4gYW5kIGRvY3VtZW50
IGNvbXBhdGliaWxpdHkgY29uY2VybnMuCj4gPiA+ID4gCj4gPiA+ID4gQWdyZWUsIGxldCBtZSBj
aGVjay4KPiA+ID4gPiAKPiA+ID4gPiAKPiA+ID4gPiA+ICDCoCBJIG5vdGUgdGhhdCBhbnkgaGFy
ZHdhcmUKPiA+ID4gPiA+IGltcGxlbWVudGF0aW9uIGlzIGFscmVhZHkgYnJva2VuIGZvciBsZWdh
Y3kgZXhjZXB0IG9uIHBsYXRmb3JtcyB3aXRoCj4gPiA+ID4gPiBzdHJvbmcgb3JkZXJpbmcgd2hp
Y2ggbWlnaHQgYmUgaGVscGZ1bCBpbiByZWR1Y2luZyB0aGUgc2NvcGUuCj4gPiA+ID4gCj4gPiA+
ID4gWWVzLgo+ID4gPiA+IAo+ID4gPiA+IFRoYW5rcwo+ID4gPiA+IAo+ID4gPiA+IAo+ID4gPiA+
ID4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
