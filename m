Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999F3C001B0
	for <virtualization@archiver.kernel.org>; Wed, 16 Aug 2023 01:51:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1075861208;
	Wed, 16 Aug 2023 01:51:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1075861208
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LIxyOQPb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WIKSimllwy9X; Wed, 16 Aug 2023 01:51:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 95C5761207;
	Wed, 16 Aug 2023 01:51:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 95C5761207
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A5D3C0071;
	Wed, 16 Aug 2023 01:51:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 176D2C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 01:51:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF40B41BA8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 01:51:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF40B41BA8
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LIxyOQPb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LYhWP76YODpL
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 01:51:07 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A447D41BA7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 01:51:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A447D41BA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692150666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R3O81hg7gg2mXRpvSXXoS7dQFF8r5Y/dzNLuKVW9nqw=;
 b=LIxyOQPbSts2FBy5W8e15hE7TUtoXaEFIAjw6YdygaXKvz0gVVoFJLAEh+7XO0Z5JVNedN
 gi/jWShU3JRT4iH7rHYU2s2uNoGuxaooDt7zH/b+VN2CPMS0uhZNYyviwOtrnWuwuGQnKY
 O+AsciCDHmIaaiuwTSFXFtiR/wggC1M=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-G4w8VTmnMCWhDPcCI3uaWA-1; Tue, 15 Aug 2023 21:51:05 -0400
X-MC-Unique: G4w8VTmnMCWhDPcCI3uaWA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ba077dcbbcso58447291fa.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 18:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692150663; x=1692755463;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R3O81hg7gg2mXRpvSXXoS7dQFF8r5Y/dzNLuKVW9nqw=;
 b=LjDByz304BVpIrAuOegDiZZqQ8EZsdUEighjKk95YNfqAlPTvROTRMOIEIc6YFv4VC
 zbujI/Tz41KmsmMnAyZSJn+3TQDD6wzok+2j7VdwwdX02QpKF1A7zHUnuHm02SYM43qB
 uUwqHvmk1i8RsbkorXizt5P3fp1fESCsXDRsJwZtAUoGbwND6UYIUhHKbkn19bzdQ1lJ
 J4kO/8+bARQB6TsNRKJjP8HP4I3k+QQaTsreMaoiylUjnM+PYo7f0i7O9wCAtx1iHnX1
 cjTZnHV1bQ/JSLL9ph6+Qd2zPoju1TCjah7oCFlzYAbANyNZ6+3/c4rWupIRzRTDxdWV
 f1ig==
X-Gm-Message-State: AOJu0YwEwdKir9MWJoIo1gk+l5V/NG8PDI3MZkQpOcPdm+BSzSKAee86
 8ASj0M/OWPARG0HP+tdBgTYZ7rkx8KuwjFBLKXthwDxxtKtBnZFUjtD9Mz/W6+DqOaTZaW0YUD3
 WlzyVRvX2c0tr8um5Z7B6wEfUQMTdk4ZT5ivBMEjH6th+3DUPM0drJcFbqA==
X-Received: by 2002:a05:651c:22c:b0:2b7:2ea:33c3 with SMTP id
 z12-20020a05651c022c00b002b702ea33c3mr388069ljn.22.1692150663699; 
 Tue, 15 Aug 2023 18:51:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa60dGwW/BjtE9dJqseF8RH2H+olrqWe2dXToP2nMgUX7G8bZIIqAOcFUEiAkibVb2DaVnpnFPtZULBKsWP9E=
X-Received: by 2002:a05:651c:22c:b0:2b7:2ea:33c3 with SMTP id
 z12-20020a05651c022c00b002b702ea33c3mr388061ljn.22.1692150663405; Tue, 15 Aug
 2023 18:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <1691585683-3948-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuUEHA9d3FXVvrzGm0_t6C3FJsNH+zkOYoH6EWpitfwqw@mail.gmail.com>
 <c22b96cf-3fbe-618e-8980-004ea063d30c@oracle.com>
In-Reply-To: <c22b96cf-3fbe-618e-8980-004ea063d30c@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Aug 2023 09:50:52 +0800
Message-ID: <CACGkMEv2J=XSO1hhEgMC_Ad-miiJdg52zufiyvA2gbcYm6wjDw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] vdpa: dedicated descriptor table group
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, elic@nvidia.com
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

T24gV2VkLCBBdWcgMTYsIDIwMjMgYXQgODowMuKAr0FNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVA
b3JhY2xlLmNvbT4gd3JvdGU6Cj4KPgo+Cj4gT24gOC85LzIwMjMgODo1MCBQTSwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+IE9uIFdlZCwgQXVnIDksIDIwMjMgYXQgODo1NuKAr1BNIFNpLVdlaSBMaXUg
PHNpLXdlaS5saXVAb3JhY2xlLmNvbT4gd3JvdGU6Cj4gPj4gRm9sbG93aW5nIHBhdGNoc2V0IGlu
dHJvZHVjZXMgZGVkaWNhdGVkIGdyb3VwIGZvciBkZXNjcmlwdG9yIHRhYmxlIHRvCj4gPj4gcmVk
dWNlIGxpdmUgbWlncmF0aW9uIGRvd250aW1lIHdoZW4gcGFzc3Rocm91Z2ggVlEgaXMgYmVpbmcg
c3dpdGNoZWQKPiA+PiB0byBzaGFkb3cgVlEuIEFzIHRoaXMgUkZDIHNldCBpcyB0byBzZWVrIGVh
cmx5IGZlZWRiYWNrIG9uIHRoZSB1QVBJCj4gPj4gYW5kIGRyaXZlciBBUEkgcGFydCwgZm9yIG5v
dyB0aGVyZSdzIG5vIGFzc29jaWF0ZWQgZHJpdmVyIHBhdGNoIGNvbnN1bWluZwo+ID4+IHRoZSBB
UEkuIEFzIHNvb24gYXMgdGhlIHN1cHBvcnQgaXMgaW4gcGxhY2Ugb24gYm90aCBoYXJkd2FyZSBk
ZXZpY2UgYW5kCj4gPj4gZHJpdmVyLCBwZXJmb3JtYW5jZSBkYXRhIHdpbGwgYmUgc2hvdyB1c2lu
ZyByZWFsIGhhcmR3YXJlIGRldmljZS4gVGhlCj4gPj4gdGFyZ2V0IGdvYWwgb2YgdGhpcyBzZXJp
ZXMgaXMgdG8gcmVkdWNlIHRoZSBTVlEgc3dpdGNoaW5nIG92ZXJoZWFkCj4gPj4gdG8gbGVzcyB0
aGFuIDMwMG1zIG9uIGEgfjEwMEdCIGd1ZXN0IHdpdGggMiBub24tbXEgdmhvc3QtdmRwYSBkZXZp
Y2VzLgo+ID4+Cj4gPj4gVGhlIHBsYW4gb2YgdGhlIGludGVuZGVkIGRyaXZlciBpbXBsZW1lbnRh
dGlvbiBpcyB0byB1c2UgYSBkZWRpY2F0ZWQKPiA+PiBncm91cCAoc3BlY2lmaWNhbGx5LCAyIGlu
IGJlbG93IHRhYmxlKSB0byBob3N0IGRlc2NyaXB0b3IgdGFibGUgZm9yCj4gPj4gYWxsIGRhdGEg
dnFzLCBkaWZmZXJlbnQgZnJvbSB3aGVyZSBidWZmZXIgYWRkcmVzc2VzIGFyZSBjb250YWluZWQg
KGluCj4gPj4gZ3JvdXAgMCBhcyBiZWxvdykuIGN2cSBkb2VzIG5vdCBoYXZlIHRvIGFsbG9jYXRl
IGRlZGljYXRlZCBncm91cCBmb3IKPiA+PiBkZXNjcmlwdG9yIHRhYmxlLCBzbyBpdHMgYnVmZmVy
cyBhbmQgZGVzY3JpcHRvciB0YWJsZSB3b3VsZCBhbHdheXMKPiA+PiBiZWxvbmcgdG8gYSBzYW1l
IGdyb3VwICgxKS4KPiA+IEknbSBmaW5lIHdpdGggdGhpcywgYnV0IEkgdGhpbmsgd2UgbmVlZCBh
biBpbXBsZW1lbnRhdGlvbiBpbiB0aGUKPiA+IGRyaXZlciAoZS5nIHRoZSBzaW11bGF0b3IpLgo+
IFllcy4gRldJVyBmb3IgdGhlIHNha2Ugb2YgdGltZSBzYXZpbmcgYW5kIGdldCB0aGlzIHNlcmll
cyBhY2NlcHRlZAo+IHByb21wdGx5IGluIHRoZSB1cGNvbWluZyB2Ni42IG1lcmdlIHdpbmRvdywg
dGhlIGRyaXZlciB3ZSdyZSBnb2luZyB0bwo+IHN1cHBvcnQgYWxvbmcgd2l0aCB0aGlzIHNlcmll
cyB3aWxsIGJlIG1seDVfdmRwYSBpbiB0aGUgZm9ybWFsCj4gc3VibWlzc2lvbiwgYW5kIHNpbXVs
YXRvciBzdXBwb3J0IG1heSBjb21lIHVwIGxhdGVyIGFmdGVyIGlmIEkgZ290IHNwYXJlCj4gY3lj
bGUuCgpUaGF0IHdvdWxkIGJlIGZpbmUuCgo+IERvIHlvdSBmb3Jlc2VlIGFueSBpc3N1ZSB3aXRo
b3V0IHNpbXVsYXRvciBjaGFuZ2U/CgpOby4KCj4gV2Ugd2lsbCBoYXZlCj4gbWx4NV92ZHBhIGRy
aXZlciBjb25zdW1pbmcgdGhlIEFQSSBmb3Igc3VyZSwgdGhhdCdzIHRoZSB0YXJnZXQgb2YgdGhp
cwo+IHdvcmsgYW5kIGl0IGhhcyB0byBiZSBwcm92ZWQgd29ya2luZyBvbiByZWFsIGRldmljZSBh
dCBmaXJzdC4KClllcywgSSBtZW50aW9uIHRoZSBzaW11bGF0b3IganVzdCBiZWNhdXNlIGl0J3Mg
c2ltcGxlLCBpdCB3b3VsZCBiZQphbHNvIGdyZWF0IGlmIGl0IGlzIHByb3ZlZCBvbiByZWFsIHZE
UEEgcGFyZW50LgoKVGhhbmtzCgo+Cj4gVGhhbmtzLAo+IC1TaXdlaQo+Cj4gPgo+ID4gVGhhbmtz
Cj4gPgo+ID4+Cj4gPj4gICAgICAgICAgICAgICAgfCAgZGF0YSB2cSB8IGN0cmwgdnEKPiA+PiA9
PT09PT09PT09PT09PSs9PT09PT09PT09Kz09PT09PT09PT09Cj4gPj4gdnFfZ3JvdXAgICAgICB8
ICAgIDAgICAgIHwgICAgMQo+ID4+IHZxX2Rlc2NfZ3JvdXAgfCAgICAyICAgICB8ICAgIDEKPiA+
Pgo+ID4+Cj4gPj4gLS0tCj4gPj4KPiA+PiBTaS1XZWkgTGl1ICgzKToKPiA+PiAgICB2ZHBhOiBp
bnRyb2R1Y2UgZGVkaWNhdGVkIGRlc2NyaXB0b3IgZ3JvdXAgZm9yIHZpcnRxdWV1ZQo+ID4+ICAg
IHZob3N0LXZkcGE6IGludHJvZHVjZSBkZXNjcmlwdG9yIGdyb3VwIGJhY2tlbmQgZmVhdHVyZQo+
ID4+ICAgIHZob3N0LXZkcGE6IHVBUEkgdG8gZ2V0IGRlZGljYXRlZCBkZXNjcmlwdG9yIGdyb3Vw
IGlkCj4gPj4KPiA+PiAgIGRyaXZlcnMvdmhvc3QvdmRwYS5jICAgICAgICAgICAgIHwgMjcgKysr
KysrKysrKysrKysrKysrKysrKysrKysrCj4gPj4gICBpbmNsdWRlL2xpbnV4L3ZkcGEuaCAgICAg
ICAgICAgICB8IDExICsrKysrKysrKysrCj4gPj4gICBpbmNsdWRlL3VhcGkvbGludXgvdmhvc3Qu
aCAgICAgICB8ICA4ICsrKysrKysrCj4gPj4gICBpbmNsdWRlL3VhcGkvbGludXgvdmhvc3RfdHlw
ZXMuaCB8ICA1ICsrKysrCj4gPj4gICA0IGZpbGVzIGNoYW5nZWQsIDUxIGluc2VydGlvbnMoKykK
PiA+Pgo+ID4+IC0tCj4gPj4gMS44LjMuMQo+ID4+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
