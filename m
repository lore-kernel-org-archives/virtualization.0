Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93714C64EC4
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 09:42:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29C8361373;
	Fri, 10 Mar 2023 09:42:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 29C8361373
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OJsmP3/q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I61VswZen-El; Fri, 10 Mar 2023 09:42:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ADBC460FAB;
	Fri, 10 Mar 2023 09:42:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ADBC460FAB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B9A1C0035;
	Fri, 10 Mar 2023 09:42:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA48FC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:42:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9EB0360F9B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:42:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9EB0360F9B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wfEILNA4hjtO
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:42:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C11E160761
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C11E160761
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678441329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R1e5SuPHQGzU5Lth3ckLfQ0HVsiCpzxHGfk4+auJE4A=;
 b=OJsmP3/qYJFCpnA48mXpefNarI3MyafSRSFlkHXifPMvom/po1D371WZxJL7RyvzDsvs2b
 wW40F+gDABAj6ADW/xq7pgsffoSFllwor8n5Wz9/a5DhyMd3ZZqAFvw0radPxK6tx+osV1
 FzXaKX/6nfAQNCA9XuVvpRFwfDtvkZQ=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-flWEBnEdPY6yyHqVZaFbjQ-1; Fri, 10 Mar 2023 04:42:07 -0500
X-MC-Unique: flWEBnEdPY6yyHqVZaFbjQ-1
Received: by mail-oo1-f69.google.com with SMTP id
 y9-20020a4acb89000000b0051760012060so1470180ooq.16
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 01:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678441327;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R1e5SuPHQGzU5Lth3ckLfQ0HVsiCpzxHGfk4+auJE4A=;
 b=kmofmwfUmwl+Pn0ps0Aha1pnd7LtEJQKwayhwCBwRWfO/RaBYZZCCQBNRq0hhYIeXw
 RKMdJCfRFAbGUaCUAlrhVNEFkPh1RJ176TmF+EDAvHS+vrFxh0JBv9fDEzfFbfEQf5k3
 sOYQSa1TblXI+yM2fDw6lD9k2h3E3QT9sqhErgWhggu/qmLTPz/bCajDDEmGFS9RQv8a
 9W+InbTtGvHE0s5OaMNsEY3AE0MxsCQwNsZASgXE6b+GkNE0CQlQmQygiOemaxOUgFTT
 adKbKnLbEieJBcZLvkAVak5042wql1MC5ZeoJs6Tnp9A3ELoXkURDo7kCNWhaHHPL0yN
 79vg==
X-Gm-Message-State: AO0yUKXSZv83/N817qsoq70J9tqHyYnNK4cUbWxusGYfH2U/qGfccVIS
 SDwPdg73JfSXXiwZF9ArmEM5pw4PrZDsYPCuA7rF+spxdkXMXkkFYdHnSX97Rj+vAWXdYF+AeVO
 nrid6jUq3lFwk9vHKMfdEyA6uWAmuO+gHkqyuo6NNA6kGGISfCSCtx1lhKg==
X-Received: by 2002:a05:6870:5b31:b0:176:2b47:b31d with SMTP id
 ds49-20020a0568705b3100b001762b47b31dmr8659308oab.9.1678441326962; 
 Fri, 10 Mar 2023 01:42:06 -0800 (PST)
X-Google-Smtp-Source: AK7set93b/mE47ddVNptTIhnLDsQN7CcKWq4mq1YTnxi436AhX1ooSYgAN2O9IkU9Bppbqf7HC5ykUiwiQY82LHipRw=
X-Received: by 2002:a05:6870:5b31:b0:176:2b47:b31d with SMTP id
 ds49-20020a0568705b3100b001762b47b31dmr8659302oab.9.1678441326737; Fri, 10
 Mar 2023 01:42:06 -0800 (PST)
MIME-Version: 1.0
References: <20230228094110.37-1-xieyongji@bytedance.com>
 <20230310034934-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230310034934-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 10 Mar 2023 17:41:55 +0800
Message-ID: <CACGkMEtL6a7vDKjbRdJnkiwtZMMh5vUaJ=tH7mf=omZrFy7AFQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] VDUSE: Improve performance
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xie Yongji <xieyongji@bytedance.com>, tglx@linutronix.de, hch@lst.de,
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

T24gRnJpLCBNYXIgMTAsIDIwMjMgYXQgNDo1MOKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCBGZWIgMjgsIDIwMjMgYXQgMDU6NDA6NTlQ
TSArMDgwMCwgWGllIFlvbmdqaSB3cm90ZToKPiA+IEhpIGFsbCwKPiA+Cj4gPiBUaGlzIHNlcmll
cyBpbnRyb2R1Y2VzIHNvbWUgd2F5cyB0byBpbXByb3ZlIFZEVVNFIHBlcmZvcm1hbmNlLgo+Cj4K
PiBQbHMgZml4IHdhcm5pbmdzIHJlcG9ydGVkIGJ5IDAtZGF5IGluZnJhLCBkcm9wcGluZyB0aGlz
IGZvciBub3cuCgpOb3RlIHRoYXQgSSBwbGFuIHRvIHJldmlldyB0aGlzIG5leHQgd2Vlay4KClRo
YW5rcwoKPgo+Cj4gPiBQYXRjaCAxIH4gNiBicmluZyBjdXJyZW50IGludGVycnVwdCBhZmZpbml0
eSBzcHJlYWRpbmcgbWVjaGFuaXNtCj4gPiB0byB2ZHVzZSBkZXZpY2UgYW5kIG1ha2UgaXQgcG9z
c2libGUgZm9yIHRoZSB2aXJ0aW8tYmxrIGRyaXZlcgo+ID4gdG8gYnVpbGQgdGhlIGJsay1tcSBx
dWV1ZXMgYmFzZWQgb24gaXQuIFRoaXMgd291bGQgYmUgdXNlZnVsIHRvCj4gPiBtaXRpZ2F0ZSB0
aGUgdmlydHF1ZXVlIGxvY2sgY29udGVudGlvbiBpbiB2aXJ0aW8tYmxrIGRyaXZlci4gSW4KPiA+
IG91ciB0ZXN0LCB3aXRoIHRob3NlIHBhdGNoZXMsIHdlIGNvdWxkIGdldCB+NTAlIGltcHJvdmVt
ZW50ICg2MDBrCj4gPiBpb3BzIC0+IDkwMGsgaW9wcykgd2hlbiB1c2luZyBwZXItY3B1IHZpcnRx
dWV1ZS4KPiA+Cj4gPiBQYXRjaCA3IGFkZHMgYSBzeXNmcyBpbnRlcmZhY2UgZm9yIGVhY2ggdmR1
c2UgdmlydHF1ZXVlIHRvIGNoYW5nZQo+ID4gdGhlIGFmZmluaXR5IGZvciBJUlEgY2FsbGJhY2su
IEl0IHdvdWxkIGJlIGhlbHBmdWwgZm9yIHBlcmZvcm1hbmNlCj4gPiB0dW5pbmcgd2hlbiB0aGUg
YWZmaW5pdHkgbWFzayBjb250YWlucyBtb3JlIHRoYW4gb25lIENQVS4KPiA+Cj4gPiBQYXRjaCA4
IH4gOSBhc3NvY2lhdGUgYW4gZXZlbnRmZCB0byB0aGUgdmRwYSBjYWxsYmFjayBzbyB0aGF0Cj4g
PiB3ZSBjYW4gc2lnbmFsIGl0IGRpcmVjdGx5IGR1cmluZyBpcnEgaW5qZWN0aW9uIHdpdGhvdXQg
c2NoZWR1bGluZwo+ID4gYW4gYWRkaXRpb25hbCB3b3JrcXVldWUgdGhyZWFkIHRvIGRvIHRoYXQu
Cj4gPgo+ID4gUGF0Y2ggMTAsIDExIGFkZCBhIHN5c2ZzIGludGVyZmFjZSB0byBzdXBwb3J0IHNw
ZWNpZnlpbmcgYm91bmNlCj4gPiBidWZmZXIgc2l6ZSBpbiB2aXJ0aW8tdmRwYSBjYXNlLiBUaGUg
aGlnaCB0aHJvdWdocHV0IHdvcmtsb2Fkcwo+ID4gY2FuIGJlbmVmaXQgZnJvbSBpdC4gQW5kIHdl
IGNhbiBhbHNvIHVzZSBpdCB0byByZWR1Y2UgdGhlIG1lbW9yeQo+ID4gb3ZlcmhlYWQgZm9yIHNt
YWxsIHRocm91Z2hwdXQgd29ya2xvYWRzLgo+ID4KPiA+IFBsZWFzZSByZXZpZXcsIHRoYW5rcyEK
PiA+Cj4gPiBWMiB0byBWMzoKPiA+IC0gUmViYXNlZCB0byBuZXdlc3Qga2VybmVsIHRyZWUKPiA+
IC0gRXhwb3J0IGdyb3VwX2NwdXNfZXZlbmx5KCkgaW5zdGVhZCBvZiBpcnFfY3JlYXRlX2FmZmlu
aXR5X21hc2tzKCkgW01TVF0KPiA+IC0gUmVtb3ZlIHRoZSBzeXNmcyBmb3Igd29ya3F1ZXVlIGNv
bnRyb2wgW0phc29uXQo+ID4gLSBBc3NvY2lhdGUgYW4gZXZlbnRmZCB0byB0aGUgdmRwYSBjYWxs
YmFjayBbSmFzb25dCj4gPiAtIFNpZ25hbCB0aGUgZXZlbnRmZCBkaXJlY3RseSBpbiB2aG9zdC12
ZHBhIGNhc2UgW0phc29uXQo+ID4gLSBVc2Ugcm91bmQtcm9iaW4gdG8gc3ByZWFkIElSUXMgYmV0
d2VlbiBDUFVzIGluIHRoZSBhZmZpbml0eSBtYXNrIFtKYXNvbl0KPiA+IC0gSGFuZGxlIHRoZSBj
cHUgaG90cGx1ZyBjYXNlIG9uIElSUSBpbmplY3Rpb24gW0phc29uXQo+ID4gLSBSZW1vdmUgZWZm
ZWN0aXZlIElSUSBhZmZpbml0eSBhbmQgYmFsYW5jZSBtZWNoYW5pc20gZm9yIElSUSBhbGxvY2F0
aW9uCj4gPgo+ID4gVjEgdG8gVjI6Cj4gPiAtIEV4cG9ydCBpcnFfY3JlYXRlX2FmZmluaXR5X21h
c2tzKCkKPiA+IC0gQWRkIHNldC9nZXRfdnFfYWZmaW5pdHkgYW5kIHNldF9pcnFfYWZmaW5pdHkg
Y2FsbGJhY2tzIGluIHZEUEEKPiA+ICAgZnJhbWV3b3JrCj4gPiAtIEFkZCBhdXRvbWF0aWMgaXJx
IGNhbGxiYWNrIGFmZmluaXR5IHN1cHBvcnQgaW4gVkRVU0UgZHJpdmVyIFtKYXNvbl0KPiA+IC0g
QWRkIG1vcmUgYmFja2dyb3VuZHMgaW5mb3JtYXRpb24gaW4gY29tbWl0IGxvZyBbSmFzb25dCj4g
PiAtIE9ubHkgc3VwcG9ydCBjaGFuZ2luZyBlZmZlY3RpdmUgYWZmaW5pdHkgd2hlbiB0aGUgdmFs
dWUgaXMgYSBzdWJzZXQKPiA+ICAgb2YgdGhlIElSUSBjYWxsYmFjayBhZmZpbml0eSBtYXNrCj4g
Pgo+ID4gWGllIFlvbmdqaSAoMTEpOgo+ID4gICBsaWIvZ3JvdXBfY3B1czogRXhwb3J0IGdyb3Vw
X2NwdXNfZXZlbmx5KCkKPiA+ICAgdmRwYTogQWRkIHNldC9nZXRfdnFfYWZmaW5pdHkgY2FsbGJh
Y2tzIGluIHZkcGFfY29uZmlnX29wcwo+ID4gICB2ZHBhOiBBZGQgc2V0X2lycV9hZmZpbml0eSBj
YWxsYmFjayBpbiB2ZHBhX2NvbmZpZ19vcHMKPiA+ICAgdmR1c2U6IFJlZmFjdG9yIGFsbG9jYXRp
b24gZm9yIHZkdXNlIHZpcnRxdWV1ZXMKPiA+ICAgdmR1c2U6IFN1cHBvcnQgYXV0b21hdGljIGly
cSBjYWxsYmFjayBhZmZpbml0eQo+ID4gICB2ZHVzZTogU3VwcG9ydCBzZXQvZ2V0X3ZxX2FmZmlu
aXR5IGNhbGxiYWNrcwo+ID4gICB2ZHVzZTogQWRkIHN5c2ZzIGludGVyZmFjZSBmb3IgaXJxIGNh
bGxiYWNrIGFmZmluaXR5Cj4gPiAgIHZkcGE6IEFkZCBldmVudGZkIGZvciB0aGUgdmRwYSBjYWxs
YmFjawo+ID4gICB2ZHVzZTogU2lnbmFsIGludGVycnVwdCdzIGV2ZW50ZmQgZGlyZWN0bHkgaW4g
dmhvc3QtdmRwYSBjYXNlCj4gPiAgIHZkdXNlOiBEZWxheSBpb3ZhIGRvbWFpbiBjcmVhdGlvbgo+
ID4gICB2ZHVzZTogU3VwcG9ydCBzcGVjaWZ5aW5nIGJvdW5jZSBidWZmZXIgc2l6ZSB2aWEgc3lz
ZnMKPiA+Cj4gPiAgZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYyB8IDQ5MCArKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLQo+ID4gIGRyaXZlcnMvdmhvc3QvdmRwYS5jICAgICAg
ICAgICAgICAgfCAgIDIgKwo+ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgICAgICAg
fCAgMzMgKysKPiA+ICBpbmNsdWRlL2xpbnV4L3ZkcGEuaCAgICAgICAgICAgICAgIHwgIDI1ICsr
Cj4gPiAgbGliL2dyb3VwX2NwdXMuYyAgICAgICAgICAgICAgICAgICB8ICAgMSArCj4gPiAgNSBm
aWxlcyBjaGFuZ2VkLCA0ODggaW5zZXJ0aW9ucygrKSwgNjMgZGVsZXRpb25zKC0pCj4gPgo+ID4g
LS0KPiA+IDIuMjAuMQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
