Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD37C77B76
	for <virtualization@archiver.kernel.org>; Sun, 23 Apr 2023 11:07:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36EE160F5C;
	Sun, 23 Apr 2023 11:07:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 36EE160F5C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KBvT5WuT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6bq8zCgXxLAS; Sun, 23 Apr 2023 11:07:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9EFF960A47;
	Sun, 23 Apr 2023 11:07:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9EFF960A47
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57273C0037;
	Sun, 23 Apr 2023 11:07:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDE85C002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 11:07:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 989C481275
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 11:07:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 989C481275
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KBvT5WuT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O81HyH7MHz1B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 11:06:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 880BF80EAE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 880BF80EAE
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 11:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682248018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g1lbsLzGIKBrnxXJSYGJKVy6ieEQPX6tVrFGk22ivD8=;
 b=KBvT5WuTymayJdKYiah2r7hTcaj0qqu4I1nbZJgA90MR70nN7D/MLUAgYHsA8kpPKDubTA
 xLS8ERtqYojImic7RSf/6ECb1Vd9lkP+4Gvm2LR2j2Y3FQjc7JQ1X0oJAcTa0UF8Wvt2i+
 SuBV30Lg/sLQt17hguJZS8ZeyI/FWAY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-LmnUeRxAN-qQzQnd1vFgMQ-1; Sun, 23 Apr 2023 07:06:57 -0400
X-MC-Unique: LmnUeRxAN-qQzQnd1vFgMQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f168827701so12196665e9.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 04:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682248016; x=1684840016;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g1lbsLzGIKBrnxXJSYGJKVy6ieEQPX6tVrFGk22ivD8=;
 b=ZF69uuwk1pbhbwkgWYUMbUggStlIMJh+fJVtmZBt9i8k9rjHiFrIYszkajweeBu8qQ
 iNv3bySb0qcQL3Ed8rZvmHQGyWkEMfWiCyQlCU2D64zmEH9RPxCEmNCkTQmYQdvreNj9
 faLvmc7LWCZ04w8tLmF52uYMcM6HF79Vn9NOUjP+HtVNjgk+5WYTqsaidTlWkp7UpsWu
 wcPuybu6FiULZSl55HLq26q5RsoGgwh/ofeMxGxSJPh046Q3UUNVVf27FBatZOlzxx+u
 LGa33nVdmw2g/dGyIy4o0Q2G753QT12UdlzefwHxh84qX736ZNKtNAKYDjr+pAYrd1nv
 CKhw==
X-Gm-Message-State: AAQBX9e9bAjBwaKhTY2t/R9altzuuwzCvf1PbeGgYyJrCHR5mlB45gUD
 KwsxSWB8bbrAJJv69P6rzgLgznNKibWa6WoQt2YG6WHGIWKwJILwkvXgQ6yh4vkNWhHFjgDgK5W
 +rt9FWWV7hNF2V6o86QD5CPx9QVp0HpT8WWJ/Wm42/w==
X-Received: by 2002:adf:e391:0:b0:2ff:f37:9d18 with SMTP id
 e17-20020adfe391000000b002ff0f379d18mr8443653wrm.58.1682248016037; 
 Sun, 23 Apr 2023 04:06:56 -0700 (PDT)
X-Google-Smtp-Source: AKy350YH8SS0VuiRXjohEkEQZc8MmQshWjBCHCvdHkztK8dbkfkMtdUR3z5eGaMnzjCodqZBlxcrXw==
X-Received: by 2002:adf:e391:0:b0:2ff:f37:9d18 with SMTP id
 e17-20020adfe391000000b002ff0f379d18mr8443639wrm.58.1682248015697; 
 Sun, 23 Apr 2023 04:06:55 -0700 (PDT)
Received: from redhat.com ([2.55.61.39]) by smtp.gmail.com with ESMTPSA id
 j32-20020a05600c1c2000b003f173987ec2sm12802917wms.22.2023.04.23.04.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Apr 2023 04:06:55 -0700 (PDT)
Date: Sun, 23 Apr 2023 07:06:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Message-ID: <20230423065132-mutt-send-email-mst@kernel.org>
References: <20230417030713-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723F3E6AE381AEC36D1AEFED49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417051816-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237705695AFD873DEE4530D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417073830-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA4F0FFEBD25903E3344D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417075645-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA90465186B5A8A5C001D4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230423031308-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47233B680283E892C45430BCD4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB47233B680283E892C45430BCD4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
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

T24gU3VuLCBBcHIgMjMsIDIwMjMgYXQgMDc6NTI6MTBBTSArMDAwMCwgQWx2YXJvIEthcnN6IHdy
b3RlOgo+ID4gSG1tLiBJIHdhcyB3cm9uZy4gVGhlcmUgaXMgbm8gd2F5IHRvIGRpc2FibGUgQ1ZR
IGZlYXR1cmUgYml0Lgo+ID4gCj4gPiAxLiBSZXNldCB0aGUgZGV2aWNlLgo+ID4gMi4gU2V0IHRo
ZSBBQ0tOT1dMRURHRSBzdGF0dXMgYml0OiB0aGUgZ3Vlc3QgT1MgaGFzIG5vdGljZSB0aGUgZGV2
aWNlLgo+ID4gMy4gU2V0IHRoZSBEUklWRVIgc3RhdHVzIGJpdDogdGhlIGd1ZXN0IE9TIGtub3dz
IGhvdyB0byBkcml2ZSB0aGUgZGV2aWNlLgo+ID4gNC4gUmVhZCBkZXZpY2UgZmVhdHVyZSBiaXRz
LCBhbmQgd3JpdGUgdGhlIHN1YnNldCBvZiBmZWF0dXJlIGJpdHMgdW5kZXJzdG9vZCBieSB0aGUg
T1MgYW5kIGRyaXZlciB0byB0aGUKPiA+IGRldmljZS4gRHVyaW5nIHRoaXMgc3RlcCB0aGUgZHJp
dmVyIE1BWSByZWFkIChidXQgTVVTVCBOT1Qgd3JpdGUpIHRoZSBkZXZpY2Utc3BlY2lmaWMgY29u
ZmlndXJhdGlvbgo+ID4gZmllbGRzIHRvIGNoZWNrIHRoYXQgaXQgY2FuIHN1cHBvcnQgdGhlIGRl
dmljZSBiZWZvcmUgYWNjZXB0aW5nIGl0Lgo+ID4gNS4gU2V0IHRoZSBGRUFUVVJFU19PSyBzdGF0
dXMgYml0LiBUaGUgZHJpdmVyIE1VU1QgTk9UIGFjY2VwdCBuZXcgZmVhdHVyZSBiaXRzIGFmdGVy
IHRoaXMgc3RlcC4KPiA+IDYuIFJlLXJlYWQgZGV2aWNlIHN0YXR1cyB0byBlbnN1cmUgdGhlIEZF
QVRVUkVTX09LIGJpdCBpcyBzdGlsbCBzZXQ6IG90aGVyd2lzZSwgdGhlIGRldmljZSBkb2VzIG5v
dAo+ID4gc3VwcG9ydCBvdXIgc3Vic2V0IG9mIGZlYXR1cmVzIGFuZCB0aGUgZGV2aWNlIGlzIHVu
dXNhYmxlLgo+ID4gNy4gUGVyZm9ybSBkZXZpY2Utc3BlY2lmaWMgc2V0dXAsIGluY2x1ZGluZyBk
aXNjb3Zlcnkgb2YgdmlydHF1ZXVlcyBmb3IgdGhlIGRldmljZSwgb3B0aW9uYWwgcGVyLT4gYnVz
IHNldHVwLAo+ID4gcmVhZGluZyBhbmQgcG9zc2libHkgd3JpdGluZyB0aGUgZGV2aWNl4oCZcyB2
aXJ0aW8gY29uZmlndXJhdGlvbiBzcGFjZSwgYW5kIHBvcHVsYXRpb24gb2YgdmlydHF1ZXVlcy4K
PiA+IDguIFNldCB0aGUgRFJJVkVSX09LIHN0YXR1cyBiaXQuIEF0IHRoaXMgcG9pbnQgdGhlIGRl
dmljZSBpcyDigJxsaXZl4oCdLgo+ID4gCj4gPiAKPiA+IFNvIGZlYXR1cmVzIGFyZSBjb25maXJt
ZWQgYmVmb3JlIGZpbmQgdnFzLgo+ID4gCj4gPiBUaGUgcmVzdCBvZiBzdHVmZiBjYW4gcHJvYmFi
bHkganVzdCBiZSBtb3ZlZCB0byBhZnRlciBmaW5kX3ZxcyB3aXRob3V0Cj4gPiBtdWNoIHBhaW4u
Cj4gPiAKPiBBY3R1YWxseSwgSSB0aGluayB0aGF0IHdpdGggYSBsaXR0bGUgYml0IG9mIHBhaW4g
OikKPiBJZiB3ZSB1c2Ugc21hbGwgdnJpbmdzIGFuZCBhIEdSTyBmZWF0dXJlIGJpdCBpcyBzZXQs
IExpbnV4IHdpbGwgbmVlZCB0byBhbGxvY2F0ZSA2NEtCIG9mIGNvbnRpbnVvdXMgbWVtb3J5IGZv
ciBldmVyeSByZWNlaXZlIGRlc2NyaXB0b3IuLgoKT2ggcmlnaHQuIEhtbS4gV2VsbCB0aGlzIGlz
IHNhbWUgYXMgYmlnIHBhY2tldHMgdGhvdWdoLCBpc24ndCBpdD8KCgo+IEluc3RlYWQgb2YgZmFp
bGluZyBwcm9iZSBpZiBHUk8vQ1ZRIGFyZSBzZXQsIGNhbiB3ZSBqdXN0IHJlc2V0IHRoZSBkZXZp
Y2UgaWYgd2UgZGlzY292ZXIgc21hbGwgdnJpbmdzIGFuZCBzdGFydCBvdmVyPwo+IENhbiB3ZSBy
ZW1lbWJlciB0aGF0IHRoaXMgZGV2aWNlIHVzZXMgc21hbGwgdnJpbmdzLCBhbmQgdGhlbiBqdXN0
IGF2b2lkIG5lZ290aWF0aW5nIHRoZSBmZWF0dXJlcyB0aGF0IHdlIGNhbm5vdCBzdXBwb3J0PwoK
CldlIHRlY2huaWNhbGx5IGNhbiBvZiBjb3Vyc2UuIEkgYW0ganVzdCBub3Qgc3VyZSBzdXBwb3J0
aW5nIENWUSB3aXRoIGp1c3QgMSBzL2cgZW50cnkgd2lsbApldmVyIGJlIHZpYWJsZS4KCi0tIApN
U1QKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
