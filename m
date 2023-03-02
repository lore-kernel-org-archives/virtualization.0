Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F4CC7EE3A
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 09:48:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2F7B44056E;
	Thu,  2 Mar 2023 09:48:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F7B44056E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JhuSAmVG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XPkAd5lQJnA1; Thu,  2 Mar 2023 09:48:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8213440025;
	Thu,  2 Mar 2023 09:48:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8213440025
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54CC8C0035;
	Thu,  2 Mar 2023 09:48:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B689FC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 09:48:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 89E4C60BFF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 09:48:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 89E4C60BFF
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JhuSAmVG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sZmmogOIefKU
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 09:48:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4EC0260A69
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4EC0260A69
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 09:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677750525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p7N+1E5DGA3fl08/MkVUOzNTAgunnlolIcVRuXePLlY=;
 b=JhuSAmVGeGoM7JbAi7VjMJtlIpj4fdEPb1BpyvJqvHucFPP6c0qweraHIg5GGRVcsixRlw
 yQ4E4QUNHdkH4tdwGZBXB6AqagfQJAHOY5Z2CgKLtRwlqAgR+NsGWtmrTUC2Ix8hOxNsGd
 Tma17gj9Zpn1dZlpB/eqDVuriddB37s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-zWrPsGutNdeMC1OPXgC5RA-1; Thu, 02 Mar 2023 04:48:44 -0500
X-MC-Unique: zWrPsGutNdeMC1OPXgC5RA-1
Received: by mail-wm1-f71.google.com with SMTP id
 c7-20020a7bc847000000b003e00be23a70so1029366wml.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Mar 2023 01:48:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677750523;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p7N+1E5DGA3fl08/MkVUOzNTAgunnlolIcVRuXePLlY=;
 b=LSSIyQLju9pC5P647xBiCP+9P9gpD/glSzbI+nQZPNioibxVrHDu3ATDXnKBWIDTiQ
 /nie+a5scyZkQOANHBD14AWxBOq+yy2nWm/GQaXFFruF4sXXMclC281MaoRZRhH+MLV6
 4wc++Th542916k4PWxYdTQQSPh9RejNBO2xdWIouriOhTOGcHjcPmfTOziwy4K1bTnjs
 owVkpSiDoq0RSsyXNatnog3vXVNVX/bMDloaeqfx9D2yQPiLVGT0tw1JV6RG61pBCQFW
 nef8PuQn++cMz4hifQwuM237MneicC/gG+T+YSZ1DzvfuKO10W1NakIgDYv42XdTNOcW
 XZXw==
X-Gm-Message-State: AO0yUKX5fg9Dv/vb5dS3j9Au6ou33Hq/QNYN5mOm10crVkEX0teuglED
 B8ctlNk9LYE4XJqGCfWzkSQqvHh2cWiZ7oZzTP69ACbDDr7RsH2szwdxsZ8U/arWLnLz1wq5spM
 NXrVqxa/XAMlV9vFTCPYXkTTunylLQztfhZi4bbTrCQ==
X-Received: by 2002:adf:f7ca:0:b0:2ca:c865:51b3 with SMTP id
 a10-20020adff7ca000000b002cac86551b3mr6860272wrq.12.1677750523190; 
 Thu, 02 Mar 2023 01:48:43 -0800 (PST)
X-Google-Smtp-Source: AK7set/GZp3j5zzeEXt8/MDOyF0K1e3KRj5zkoXbShUyIVh62NUr4keMmltn9kmTDOdf0l7t8o5h1g==
X-Received: by 2002:adf:f7ca:0:b0:2ca:c865:51b3 with SMTP id
 a10-20020adff7ca000000b002cac86551b3mr6860257wrq.12.1677750522792; 
 Thu, 02 Mar 2023 01:48:42 -0800 (PST)
Received: from redhat.com ([2.52.141.194]) by smtp.gmail.com with ESMTPSA id
 s2-20020a5d6a82000000b002c53cc7504csm15208871wru.78.2023.03.02.01.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Mar 2023 01:48:42 -0800 (PST)
Date: Thu, 2 Mar 2023 04:48:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3] virtio-net: Fix probe of virtio-net on kvmtool
Message-ID: <20230302044806-mutt-send-email-mst@kernel.org>
References: <20230223-virtio-net-kvmtool-v3-1-e038660624de@rivosinc.com>
 <20230301093054-mutt-send-email-mst@kernel.org>
 <CACGkMEsG10CWigz+S6JgSVK8XfbpT=L=30hZ8LDvohtaanAiZQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsG10CWigz+S6JgSVK8XfbpT=L=30hZ8LDvohtaanAiZQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 rbradford@rivosinc.com, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

T24gVGh1LCBNYXIgMDIsIDIwMjMgYXQgMDQ6MTA6MjBQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBXZWQsIE1hciAxLCAyMDIzIGF0IDEwOjQ04oCvUE0gTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gV2VkLCBNYXIgMDEsIDIwMjMgYXQg
MDE6NTk6NTJQTSArMDAwMCwgUm9iIEJyYWRmb3JkIHZpYSBCNCBSZWxheSB3cm90ZToKPiA+ID4g
RnJvbTogUm9iIEJyYWRmb3JkIDxyYnJhZGZvcmRAcml2b3NpbmMuY29tPgo+ID4gPgo+ID4gPiBT
aW5jZSB0aGUgZm9sbG93aW5nIGNvbW1pdCB2aXJ0aW8tbmV0IG9uIGt2bXRvb2wgaGFzIHByaW50
ZWQgYSB3YXJuaW5nCj4gPiA+IGR1cmluZyB0aGUgcHJvYmU6Cj4gPiA+Cj4gPiA+IGNvbW1pdCBk
YmNmMjRkMTUzODg0NDM5ZGFkMzA0ODRhMGUzZjAyMzUwNjkyZTRjCj4gPiA+IEF1dGhvcjogSmFz
b24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiA+ID4gRGF0ZTogICBUdWUgQXVnIDE3IDE2
OjA2OjU5IDIwMjEgKzA4MDAKPiA+ID4KPiA+ID4gICAgIHZpcnRpby1uZXQ6IHVzZSBORVRJRl9G
X0dST19IVyBpbnN0ZWFkIG9mIE5FVElGX0ZfTFJPCj4gPiA+Cj4gPiA+IFsgICAgMS44NjU5OTJd
IG5ldCBldGgwOiBGYWlsIHRvIHNldCBndWVzdCBvZmZsb2FkLgo+ID4gPiBbICAgIDEuODcyNDkx
XSB2aXJ0aW9fbmV0IHZpcnRpbzIgZXRoMDogc2V0X2ZlYXR1cmVzKCkgZmFpbGVkICgtMjIpOyB3
YW50ZWQgMHgwMDAwMDAwMDAwMTM0ODI5LCBsZWZ0IDB4MDA4MDAwMDAwMDEzNDgyOQo+ID4gPgo+
ID4gPiBUaGlzIGlzIGJlY2F1c2UgZHVyaW5nIHRoZSBwcm9iaW5nIHRoZSB1bmRlcmx5aW5nIG5l
dGRldiBkZXZpY2UgaGFzCj4gPiA+IGlkZW50aWZpZWQgdGhhdCB0aGUgbmV0ZGV2IGZlYXR1cmVz
IG9uIHRoZSBkZXZpY2UgaGFzIGNoYW5nZWQgYW5kCj4gPiA+IGF0dGVtcHRzIHRvIHVwZGF0ZSB0
aGUgdmlydGlvLW5ldCBvZmZsb2FkcyB0aHJvdWdoIHRoZSB2aXJ0aW8tbmV0Cj4gPiA+IGNvbnRy
b2wgcXVldWUuIGt2bXRvb2wgaG93ZXZlciBkb2VzIG5vdCBoYXZlIGEgY29udHJvbCBxdWV1ZSB0
aGF0IHN1cHBvcnRzCj4gPiA+IG9mZmxvYWQgY2hhbmdpbmcgKFZJUlRJT19ORVRfRl9DVFJMX0dV
RVNUX09GRkxPQURTIGlzIG5vdCBhZHZlcnRpc2VkKQo+ID4gPgo+ID4gPiBUaGUgbmV0ZGV2IGZl
YXR1cmVzIGhhdmUgY2hhbmdlZCBkdWUgdG8gdmFsaWRhdGlvbiBjaGVja3MgaW4KPiA+ID4gbmV0
ZGV2X2ZpeF9mZWF0dXJlcygpOgo+ID4gPgo+ID4gPiBpZiAoIShmZWF0dXJlcyAmIE5FVElGX0Zf
UlhDU1VNKSkgewo+ID4gPiAgICAgICAvKiBORVRJRl9GX0dST19IVyBpbXBsaWVzIGRvaW5nIFJY
Q1NVTSBzaW5jZSBldmVyeSBwYWNrZXQKPiA+ID4gICAgICAgICogc3VjY2Vzc2Z1bGx5IG1lcmdl
ZCBieSBoYXJkd2FyZSBtdXN0IGFsc28gaGF2ZSB0aGUKPiA+ID4gICAgICAgICogY2hlY2tzdW0g
dmVyaWZpZWQgYnkgaGFyZHdhcmUuICBJZiB0aGUgdXNlciBkb2VzIG5vdAo+ID4gPiAgICAgICAg
KiB3YW50IHRvIGVuYWJsZSBSWENTVU0sIGxvZ2ljYWxseSwgd2Ugc2hvdWxkIGRpc2FibGUgR1JP
X0hXLgo+ID4gPiAgICAgICAgKi8KPiA+ID4gICAgICAgaWYgKGZlYXR1cmVzICYgTkVUSUZfRl9H
Uk9fSFcpIHsKPiA+ID4gICAgICAgICAgICAgICBuZXRkZXZfZGJnKGRldiwgIkRyb3BwaW5nIE5F
VElGX0ZfR1JPX0hXIHNpbmNlIG5vIFJYQ1NVTSBmZWF0dXJlLlxuIik7Cj4gPiA+ICAgICAgICAg
ICAgICAgZmVhdHVyZXMgJj0gfk5FVElGX0ZfR1JPX0hXOwo+ID4gPiAgICAgICB9Cj4gPiA+IH0K
PiA+ID4KPiA+ID4gU2luY2Uga3ZtdG9vbCBkb2VzIG5vdCBhZHZlcnRpc2UgdGhlIFZJUlRJT19O
RVRfRl9HVUVTVF9DU1VNIGZlYXR1cmUgdGhlCj4gPiA+IE5FVElGX0ZfUlhDU1VNIGJpdCBpcyBu
b3QgcHJlc2VudCBhbmQgc28gdGhlIE5FVElGX0ZfR1JPX0hXIGJpdCBpcwo+ID4gPiBjbGVhcmVk
LiBUaGlzIHJlc3VsdHMgaW4gdGhlIG5ldGRldiBmZWF0dXJlcyBjaGFuZ2luZywgd2hpY2ggdHJp
Z2dlcnMKPiA+ID4gdGhlIGF0dGVtcHQgdG8gcmVwcm9ncmFtIHRoZSB2aXJ0aW8tbmV0IG9mZmxv
YWRzIHdoaWNoIHRoZW4gZmFpbHMuCj4gPiA+Cj4gPiA+IFRoaXMgY29tbWl0IHByZXZlbnRzIHRo
YXQgc2V0IG9mIG5ldGRldiBmZWF0dXJlcyBmcm9tIGNoYW5naW5nIGJ5Cj4gPiA+IHByZWVtcHRp
dmVseSBhcHBseWluZyB0aGUgc2FtZSB2YWxpZGF0aW9uIGFuZCBvbmx5IHNldHRpbmcKPiA+ID4g
TkVUSUZfRl9HUk9fSFcgaWYgTkVUSUZfRl9SWENTVU0gaXMgc2V0IGJlY2F1c2UgdGhlIGRldmlj
ZSBzdXBwb3J0cyBib3RoCj4gPiA+IFZJUlRJT19ORVRfRl9HVUVTVF9DU1VNIGFuZCBWSVJUSU9f
TkVUX0ZfR1VFU1RfVFNPezQsNn0KPiA+ID4KPiA+ID4gU2lnbmVkLW9mZi1ieTogUm9iIEJyYWRm
b3JkIDxyYnJhZGZvcmRAcml2b3NpbmMuY29tPgo+ID4gPiAtLS0KPiA+ID4gQ2hhbmdlcyBpbiB2
MzoKPiA+ID4gLSBJZGVudGlmaWVkIHJvb3QtY2F1c2Ugb2YgZmVhdHVyZSBiaXQgY2hhbmdpbmcg
YW5kIHVwZGF0ZWQgY29uZGl0aW9ucwo+ID4gPiAgIGNoZWNrCj4gPiA+IC0gTGluayB0byB2Mjog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIzMDIyMy12aXJ0aW8tbmV0LWt2bXRvb2wtdjIt
MS04ZWM5MzUxMWU2N2ZAcml2b3NpbmMuY29tCj4gPiA+Cj4gPiA+IENoYW5nZXMgaW4gdjI6Cj4g
PiA+IC0gVXNlIHBhcmVudGhlc2VzIHRvIGdyb3VwIGxvZ2ljYWwgT1Igb2YgZmVhdHVyZXMKPiA+
ID4gLSBMaW5rIHRvIHYxOgo+ID4gPiAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMzAy
MjMtdmlydGlvLW5ldC1rdm10b29sLXYxLTEtZmMyM2QyOWI5ZDdhQHJpdm9zaW5jLmNvbQo+ID4g
PiAtLS0KPiA+ID4gIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDEwICsrKysrKy0tLS0KPiA+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gPiA+
Cj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMKPiA+ID4gaW5kZXggNjFlMzNlNGRkMGNkLi4yZTc3MDUxNDJjYTUgMTAw
NjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gPiArKysgYi9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gQEAgLTM3NzgsMTEgKzM3NzgsMTMgQEAgc3RhdGlj
IGludCB2aXJ0bmV0X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgZGV2LT5mZWF0dXJlcyB8PSBkZXYtPmh3X2ZlYXR1cmVzICYgTkVU
SUZfRl9BTExfVFNPOwo+ID4gPiAgICAgICAgICAgICAgIC8qICghY3N1bSAmJiBnc28pIGNhc2Ug
d2lsbCBiZSBmaXhlZCBieSByZWdpc3Rlcl9uZXRkZXYoKSAqLwo+ID4gPiAgICAgICB9Cj4gPiA+
IC0gICAgIGlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX0dVRVNUX0NT
VU0pKQo+ID4gPiArICAgICBpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRf
Rl9HVUVTVF9DU1VNKSkgewo+ID4gPiAgICAgICAgICAgICAgIGRldi0+ZmVhdHVyZXMgfD0gTkVU
SUZfRl9SWENTVU07Cj4gPiA+IC0gICAgIGlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklS
VElPX05FVF9GX0dVRVNUX1RTTzQpIHx8Cj4gPiA+IC0gICAgICAgICB2aXJ0aW9faGFzX2ZlYXR1
cmUodmRldiwgVklSVElPX05FVF9GX0dVRVNUX1RTTzYpKQo+ID4gPiAtICAgICAgICAgICAgIGRl
di0+ZmVhdHVyZXMgfD0gTkVUSUZfRl9HUk9fSFc7Cj4gPiA+ICsgICAgICAgICAgICAgLyogVGhp
cyBkZXBlbmRlbmN5IGlzIGVuZm9yY2VkIGJ5IG5ldGRldl9maXhfZmVhdHVyZXMgKi8KPiA+ID4g
KyAgICAgICAgICAgICBpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9H
VUVTVF9UU080KSB8fAo+ID4gPiArICAgICAgICAgICAgICAgICB2aXJ0aW9faGFzX2ZlYXR1cmUo
dmRldiwgVklSVElPX05FVF9GX0dVRVNUX1RTTzYpKQo+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgZGV2LT5mZWF0dXJlcyB8PSBORVRJRl9GX0dST19IVzsKPiA+ID4gKyAgICAgfQo+ID4gPiAg
ICAgICBpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9DVFJMX0dVRVNU
X09GRkxPQURTKSkKPiA+ID4gICAgICAgICAgICAgICBkZXYtPmh3X2ZlYXR1cmVzIHw9IE5FVElG
X0ZfR1JPX0hXOwo+IAo+IFNob3VsZCB3ZSBtb3ZlIHRoaXMgYWxzbyB1bmRlciB0aGUgY2hlY2sg
b2YgUlhDU1VNLCBvdGhlcndpc2Ugd2UgbWF5Cj4gZW5kIHVwIHRoZSBmb2xsb3dpbmcgY2FzZToK
PiAKPiB3aGVuIENTVU0gaXMgbm90IG5lZ290aWF0ZWQgYnV0IEdVRVNUX09GRkxPQURTLCBjYW4g
c3RpbGwgdHJ5IHRvCj4gZW5hYmxlLW9yLWRpc2FibGUgZ3Vlc3Qgb2ZmbG9hZHM/IE9yIGRvIHdl
IG5lZWQgdG8gZmFpbCB0aGUgcHJvYmUgaW4KPiB0aGUgY2FzZSB2aWEgdmlydG5ldF92YWxpZGF0
ZV9mZWF0dXJlcygpPwo+IAo+ID4gPgo+ID4KPiA+IEkgc2VlLiBJdCBpcyBhbm5veWluZyB0aGF0
IHdlIGFyZSBkdXBsaWNhdGluZyB0aGUgbG9naWMgZnJvbQo+ID4gbmV0ZGV2X2ZpeF9mZWF0dXJl
cyBoZXJlIHRob3VnaCA6KAo+ID4gTWF5YmUgd2Ugc2hvdWxkIGNhbGwgbmV0ZGV2X3VwZGF0ZV9m
ZWF0dXJlcywgaW4gdGhlIGNhbGxiYWNrIGNoZWNrCj4gPiB0aGUgZmxhZ3MgYW5kIGRlY2lkZSB3
aGF0IHRvIHNldCBhbmQgd2hhdCB0byBjbGVhcj8KPiA+IE9yIGV4cG9ydCBuZXRkZXZfZml4X2Zl
YXR1cmVzIHRvIG1vZHVsZXM/Cj4gCj4gVGhlcmUncyBhIG5kb19maXhfZmVhdHVyZXMoKSB0aGF0
IG1pZ2h0IGJlIHVzZWQgaGVyZS4KPiAKPiA+Cj4gPgo+ID4KPiA+IEFsc28gcmUtcmVhZGluZyBE
b2N1bWVudGF0aW9uL25ldHdvcmtpbmcvbmV0ZGV2LWZlYXR1cmVzLnJzdCAtCj4gPgo+ID4gIDEu
IG5ldGRldi0+aHdfZmVhdHVyZXMgc2V0IGNvbnRhaW5zIGZlYXR1cmVzIHdob3NlIHN0YXRlIG1h
eSBwb3NzaWJseQo+ID4gICAgIGJlIGNoYW5nZWQgKGVuYWJsZWQgb3IgZGlzYWJsZWQpIGZvciBh
IHBhcnRpY3VsYXIgZGV2aWNlIGJ5IHVzZXIncwo+ID4gICAgIHJlcXVlc3QuICBUaGlzIHNldCBz
aG91bGQgYmUgaW5pdGlhbGl6ZWQgaW4gbmRvX2luaXQgY2FsbGJhY2sgYW5kIG5vdAo+ID4gICAg
IGNoYW5nZWQgbGF0ZXIuCj4gPgo+ID4gIDIuIG5ldGRldi0+ZmVhdHVyZXMgc2V0IGNvbnRhaW5z
IGZlYXR1cmVzIHdoaWNoIGFyZSBjdXJyZW50bHkgZW5hYmxlZAo+ID4gICAgIGZvciBhIGRldmlj
ZS4gIFRoaXMgc2hvdWxkIGJlIGNoYW5nZWQgb25seSBieSBuZXR3b3JrIGNvcmUgb3IgaW4KPiA+
ICAgICBlcnJvciBwYXRocyBvZiBuZG9fc2V0X2ZlYXR1cmVzIGNhbGxiYWNrLgo+ID4KPiA+Cj4g
PiBpcyBpdCB0aGVuIHdyb25nIHRoYXQgdmlydGlvIHNldHMgTkVUSUZfRl9SWENTVU0gYW5kIE5F
VElGX0ZfR1JPX0hXIGluCj4gPiBkZXYtPmZlYXR1cmVzIGFuZCBub3QgaW4gZGV2LT5od19mZWF0
dXJlcz8KPiAKPiBMb29rcyBub3QgdGhlIGNvcmUgY2FuIHRyeSB0byBlbmFibGUgYW5kIGRpc2Fi
bGUgZmVhdHVyZXMgYWNjb3JkaW5nIHRvCj4gdGhlIGRpZmYgYmV0d2VlbiBmZWF0dXJlcyBhbmQg
aHdfZmVhdHVyZXMKPiAKPiBzdGF0aWMgaW5saW5lIG5ldGRldl9mZWF0dXJlc190IG5ldGRldl9n
ZXRfd2FudGVkX2ZlYXR1cmVzKAo+ICAgICAgICAgc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiB7
Cj4gICAgICAgICByZXR1cm4gKGRldi0+ZmVhdHVyZXMgJiB+ZGV2LT5od19mZWF0dXJlcykgfCBk
ZXYtPndhbnRlZF9mZWF0dXJlczsKPiB9Cj4gCj4gVGhhbmtzCgp5ZXMgd2hhdCB3ZSBkbyB3b3Jr
IGFjY29yZGluZyB0byBjb2RlLiAgU28gdGhlIGRvY3VtZW50YXRpb24gaXMgd3JvbmcgdGhlbj8K
Cj4gPiBXZSBzZXQgaXQgdGhlcmUgYmVjYXVzZQo+ID4gd2l0aG91dCBjdHJsIGd1ZXN0IG9mZmxv
YWQgdGhlc2UgY2FuIG5vdCBiZSBjaGFuZ2VkLgo+ID4gSSBzdXNwZWN0IHRoaXMgaXMganVzdCBh
IG1pbm9yIGRvY3VtZW50YXRpb24gYnVnIHllcz8gTWF5YmUgZGV2aWNlcwo+ID4gd2hlcmUgZmVh
dHVyZXMgY2FuJ3QgYmUgY2xlYXJlZCBhcmUgdW5jb21tb24uCj4gPgo+ID4gQWxzbzoKPiA+ICAg
ICAgICAgaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfQ1RSTF9HVUVT
VF9PRkZMT0FEUykpCj4gPiAgICAgICAgICAgICAgICAgZGV2LT5od19mZWF0dXJlcyB8PSBORVRJ
Rl9GX0dST19IVzsKPiA+Cj4gPiBidXQgc2hvdWxkIHdlIG5vdCBzZXQgTkVUSUZfRl9SWENTVU0g
dGhlcmUgdG9vPwo+ID4KPiA+Cj4gPgo+ID4gPiAtLS0KPiA+ID4gYmFzZS1jb21taXQ6IGMzOWNl
YTZmMzhlZWZlMzU2ZDY0ZDBiYzFlMWYyMjY3ZTI4MmNkZDMKPiA+ID4gY2hhbmdlLWlkOiAyMDIz
MDIyMy12aXJ0aW8tbmV0LWt2bXRvb2wtODdmMzc1MTViZTIyCj4gPiA+Cj4gPiA+IEJlc3QgcmVn
YXJkcywKPiA+ID4gLS0KPiA+ID4gUm9iIEJyYWRmb3JkIDxyYnJhZGZvcmRAcml2b3NpbmMuY29t
Pgo+ID4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
