Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6CAC04A6A
	for <virtualization@archiver.kernel.org>; Wed, 16 Aug 2023 01:58:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 892E78214D;
	Wed, 16 Aug 2023 01:58:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 892E78214D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=grulDuxM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WzwXKkkSfCPJ; Wed, 16 Aug 2023 01:58:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DBEE5820ED;
	Wed, 16 Aug 2023 01:58:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DBEE5820ED
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0354C0071;
	Wed, 16 Aug 2023 01:58:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE80BC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 01:58:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8543A414E4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 01:58:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8543A414E4
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=grulDuxM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0-AoLwXXHygR
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 01:58:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A7D3D414DB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 01:58:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A7D3D414DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692151102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4FDYoxWhWZ3j0QEXisUXbUEzdRm4FnS0b/2UQvumTZ0=;
 b=grulDuxMLkvKZ3eR9cOqhp+BTk5mA+YdosCD6bDegHpTso7tIZZ8pb/8DcDytfEuNTw7Dk
 IxHZGRXW1e4r/vCOB7fB7/DWcicR2p9KfDAbPUbv5Av1Qt0hKhGBE9ZbFeMhpS/ADVJow0
 n1iZ5vEiEM80cJo1mRkDrvyjS6Gmbcs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-liIbhXz3PWmu2OTEN8C-3g-1; Tue, 15 Aug 2023 21:58:20 -0400
X-MC-Unique: liIbhXz3PWmu2OTEN8C-3g-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b6ff15946fso63731671fa.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 18:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692151099; x=1692755899;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4FDYoxWhWZ3j0QEXisUXbUEzdRm4FnS0b/2UQvumTZ0=;
 b=Kbk2yjwqb4UFao4nvaHQmlBdv+utLAln6LVaqW4u0gkrt2WbfmiFJ9OANUBpmBqhLC
 aKJggZxfpl5e7WEGGIk6p2cSCWgxv/tjzQNw65TL7Je7fUOZ4RJXCRnFNBMfMwRSQfof
 iCPPxbNrEh5vBrUFrFlQ4KcQy0mOR8Mvv1y5eb7O7yaXBxoV1R0vDGyM80RKbTTSjqeF
 ft/vupzHthzpFWVkJjJS9ZgZ3pkWH+h1KdZCfcQb2Ou9YyZSxueSUJYq+3a5ir3gSIA+
 nN4KfZDlsiUXP6JfLMzezfy3kakzL52Fum0KJihNrXdPK+3koXc9zC+o1XKy/jPbNIm+
 sEJQ==
X-Gm-Message-State: AOJu0YxNetssL8IoAm/qygoxbDq4Dww7nXrghFh/UFNig25yIudUxqfG
 ktK4rzPNw5rFBnXxL5a5y6CI8HK7XKKjtgAQg50J/Sm932KpKN1yRcMZPfrCrpN0OgDJVyNJrdU
 VaM3UJTw/IQXbOGA7RAFV1af27rcARc5a0kWkBibxD1Y/NpSROvwxnIQPtg==
X-Received: by 2002:a2e:87d4:0:b0:2b9:cd3d:4136 with SMTP id
 v20-20020a2e87d4000000b002b9cd3d4136mr378889ljj.2.1692151098877; 
 Tue, 15 Aug 2023 18:58:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6IJiPIJy66ofzuNGjovnLYHF+9z6b7e+ULqVmZb1fiTaEgC3A78RGK+vLW2LOpPe4NcvnjDjjUHJ/FH6ZoCE=
X-Received: by 2002:a2e:87d4:0:b0:2b9:cd3d:4136 with SMTP id
 v20-20020a2e87d4000000b002b9cd3d4136mr378881ljj.2.1692151098580; Tue, 15 Aug
 2023 18:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <1691585683-3948-1-git-send-email-si-wei.liu@oracle.com>
 <1691585683-3948-3-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEsUM9d2QHtKUDSKO+qMJjRYhKy2w7J_RgwywrOv2tcJTw@mail.gmail.com>
 <dbf568df-2ee8-e5c8-3696-74aeb71a03aa@oracle.com>
In-Reply-To: <dbf568df-2ee8-e5c8-3696-74aeb71a03aa@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Aug 2023 09:58:07 +0800
Message-ID: <CACGkMEvxYxTCX5AMtMuH3YEVuO5p-Z2BAeEtTNRFo5Vf=hdJjQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] vhost-vdpa: introduce descriptor group backend
 feature
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

T24gV2VkLCBBdWcgMTYsIDIwMjMgYXQgNzo1NOKAr0FNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVA
b3JhY2xlLmNvbT4gd3JvdGU6Cj4KPgo+Cj4gT24gOC85LzIwMjMgODo0OSBQTSwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+IE9uIFdlZCwgQXVnIDksIDIwMjMgYXQgODo1NuKAr1BNIFNpLVdlaSBMaXUg
PHNpLXdlaS5saXVAb3JhY2xlLmNvbT4gd3JvdGU6Cj4gPj4gVXNlcnNwYWNlIGtub3dzIGlmIHRo
ZSBkZXZpY2UgaGFzIGRlZGljYXRlZCBkZXNjcmlwdG9yIGdyb3VwIG9yIG5vdAo+ID4+IGJ5IGNo
ZWNraW5nIHRoaXMgZmVhdHVyZSBiaXQuCj4gPj4KPiA+PiBJdCdzIG9ubHkgZXhwb3NlZCBpZiB0
aGUgdmRwYSBkcml2ZXIgYmFja2VuZCBpbXBsZW1lbnRzIHRoZQo+ID4+IC5nZXRfdnFfZGVzY19n
cm91cCgpIG9wZXJhdGlvbiBjYWxsYmFjay4gVXNlcnNwYWNlIHRyeWluZyB0byBuZWdvdGlhdGUK
PiA+PiB0aGlzIGZlYXR1cmUgd2hlbiBpdCBvciB0aGUgZGVwZW5kZW50IF9GX0lPVExCX0FTSUQg
ZmVhdHVyZSBoYXNuJ3QKPiA+PiBiZWVuIGV4cG9zZWQgd2lsbCByZXN1bHQgaW4gYW4gZXJyb3Iu
Cj4gPj4KPiA+PiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5j
b20+Cj4gPj4gLS0tCj4gPj4gICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyAgICAgICAgICAgICB8IDE3
ICsrKysrKysrKysrKysrKysrCj4gPj4gICBpbmNsdWRlL3VhcGkvbGludXgvdmhvc3RfdHlwZXMu
aCB8ICA1ICsrKysrCj4gPj4gICAyIGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykKPiA+
Pgo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3Qv
dmRwYS5jCj4gPj4gaW5kZXggYjQzZTg2OC4uZjJlNWRjZSAxMDA2NDQKPiA+PiAtLS0gYS9kcml2
ZXJzL3Zob3N0L3ZkcGEuYwo+ID4+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gPj4gQEAg
LTM4OSw2ICszODksMTQgQEAgc3RhdGljIGJvb2wgdmhvc3RfdmRwYV9jYW5fcmVzdW1lKGNvbnN0
IHN0cnVjdCB2aG9zdF92ZHBhICp2KQo+ID4+ICAgICAgICAgIHJldHVybiBvcHMtPnJlc3VtZTsK
PiA+PiAgIH0KPiA+Pgo+ID4+ICtzdGF0aWMgYm9vbCB2aG9zdF92ZHBhX2hhc19kZXNjX2dyb3Vw
KGNvbnN0IHN0cnVjdCB2aG9zdF92ZHBhICp2KQo+ID4+ICt7Cj4gPj4gKyAgICAgICBzdHJ1Y3Qg
dmRwYV9kZXZpY2UgKnZkcGEgPSB2LT52ZHBhOwo+ID4+ICsgICAgICAgY29uc3Qgc3RydWN0IHZk
cGFfY29uZmlnX29wcyAqb3BzID0gdmRwYS0+Y29uZmlnOwo+ID4+ICsKPiA+PiArICAgICAgIHJl
dHVybiBvcHMtPmdldF92cV9kZXNjX2dyb3VwOwo+ID4+ICt9Cj4gPj4gKwo+ID4+ICAgc3RhdGlj
IGxvbmcgdmhvc3RfdmRwYV9nZXRfZmVhdHVyZXMoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHU2NCBf
X3VzZXIgKmZlYXR1cmVwKQo+ID4+ICAgewo+ID4+ICAgICAgICAgIHN0cnVjdCB2ZHBhX2Rldmlj
ZSAqdmRwYSA9IHYtPnZkcGE7Cj4gPj4gQEAgLTY3OSw2ICs2ODcsNyBAQCBzdGF0aWMgbG9uZyB2
aG9zdF92ZHBhX3VubG9ja2VkX2lvY3RsKHN0cnVjdCBmaWxlICpmaWxlcCwKPiA+PiAgICAgICAg
ICAgICAgICAgIGlmIChjb3B5X2Zyb21fdXNlcigmZmVhdHVyZXMsIGZlYXR1cmVwLCBzaXplb2Yo
ZmVhdHVyZXMpKSkKPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FRkFVTFQ7
Cj4gPj4gICAgICAgICAgICAgICAgICBpZiAoZmVhdHVyZXMgJiB+KFZIT1NUX1ZEUEFfQkFDS0VO
RF9GRUFUVVJFUyB8Cj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQklUX1VM
TChWSE9TVF9CQUNLRU5EX0ZfREVTQ19BU0lEKSB8Cj4gPj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX1NVU1BFTkQpIHwKPiA+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfUkVT
VU1FKSkpCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRU9QTk9UU1VQUDsK
PiA+PiBAQCAtNjg4LDYgKzY5NywxMiBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3VubG9ja2Vk
X2lvY3RsKHN0cnVjdCBmaWxlICpmaWxlcCwKPiA+PiAgICAgICAgICAgICAgICAgIGlmICgoZmVh
dHVyZXMgJiBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9SRVNVTUUpKSAmJgo+ID4+ICAgICAgICAg
ICAgICAgICAgICAgICAhdmhvc3RfdmRwYV9jYW5fcmVzdW1lKHYpKQo+ID4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7Cj4gPj4gKyAgICAgICAgICAgICAgIGlm
ICgoZmVhdHVyZXMgJiBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9ERVNDX0FTSUQpKSAmJgo+ID4+
ICsgICAgICAgICAgICAgICAgICAgIShmZWF0dXJlcyAmIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9G
X0lPVExCX0FTSUQpKSkKPiA+PiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZB
TDsKPiA+PiArICAgICAgICAgICAgICAgaWYgKChmZWF0dXJlcyAmIEJJVF9VTEwoVkhPU1RfQkFD
S0VORF9GX0RFU0NfQVNJRCkpICYmCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgIXZob3N0X3Zk
cGFfaGFzX2Rlc2NfZ3JvdXAodikpCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJu
IC1FT1BOT1RTVVBQOwo+ID4+ICAgICAgICAgICAgICAgICAgdmhvc3Rfc2V0X2JhY2tlbmRfZmVh
dHVyZXMoJnYtPnZkZXYsIGZlYXR1cmVzKTsKPiA+PiAgICAgICAgICAgICAgICAgIHJldHVybiAw
Owo+ID4+ICAgICAgICAgIH0KPiA+PiBAQCAtNzQxLDYgKzc1Niw4IEBAIHN0YXRpYyBsb25nIHZo
b3N0X3ZkcGFfdW5sb2NrZWRfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGVwLAo+ID4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICBmZWF0dXJlcyB8PSBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9TVVNQ
RU5EKTsKPiA+PiAgICAgICAgICAgICAgICAgIGlmICh2aG9zdF92ZHBhX2Nhbl9yZXN1bWUodikp
Cj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgIGZlYXR1cmVzIHw9IEJJVF9VTEwoVkhPU1Rf
QkFDS0VORF9GX1JFU1VNRSk7Cj4gPj4gKyAgICAgICAgICAgICAgIGlmICh2aG9zdF92ZHBhX2hh
c19kZXNjX2dyb3VwKHYpKQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgIGZlYXR1cmVzIHw9
IEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX0RFU0NfQVNJRCk7Cj4gPj4gICAgICAgICAgICAgICAg
ICBpZiAoY29weV90b191c2VyKGZlYXR1cmVwLCAmZmVhdHVyZXMsIHNpemVvZihmZWF0dXJlcykp
KQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICByID0gLUVGQVVMVDsKPiA+PiAgICAgICAg
ICAgICAgICAgIGJyZWFrOwo+ID4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdmhv
c3RfdHlwZXMuaCBiL2luY2x1ZGUvdWFwaS9saW51eC92aG9zdF90eXBlcy5oCj4gPj4gaW5kZXgg
ZDNhYWQxMmEuLjA4NTZmODQgMTAwNjQ0Cj4gPj4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3Zo
b3N0X3R5cGVzLmgKPiA+PiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3RfdHlwZXMuaAo+
ID4+IEBAIC0xODEsNSArMTgxLDEwIEBAIHN0cnVjdCB2aG9zdF92ZHBhX2lvdmFfcmFuZ2Ugewo+
ID4+ICAgI2RlZmluZSBWSE9TVF9CQUNLRU5EX0ZfU1VTUEVORCAgMHg0Cj4gPj4gICAvKiBEZXZp
Y2UgY2FuIGJlIHJlc3VtZWQgKi8KPiA+PiAgICNkZWZpbmUgVkhPU1RfQkFDS0VORF9GX1JFU1VN
RSAgMHg1Cj4gPj4gKy8qIERldmljZSBtYXkgZXhwb3NlIHRoZSBkZXNjcmlwdG9yIHRhYmxlLCBh
dmFpbCBhbmQgdXNlZCByaW5nIGluIGEKPiA+PiArICogZGlmZmVyZW50IGdyb3VwIGZvciBBU0lE
IGJpbmRpbmcgdGhhbiB0aGUgYnVmZmVycyBpdCBjb250YWlucy4KPiA+IE5pdDoKPiA+Cj4gPiBz
L2EgZGlmZmVyZW50IGdyb3VwL2RpZmZlcmVudCBncm91cHMvPwo+IFllcCwgSSB3aWxsIHRyeSB0
byByZXBocmFzZS4gV291bGQgYmVsb3cgd29yaz8KPgo+ICJEZXZpY2UgbWF5IGV4cG9zZSB2aXJ0
cXVldWUncyBkZXNjcmlwdG9yIHRhYmxlLCBhdmFpbCBhbmQgdXNlZCByaW5nIGluIGEKPiBkaWZm
ZXJlbnQgZ3JvdXAgZm9yIEFTSUQgYmluZGluZyB0aGFuIHdoZXJlIGJ1ZmZlcnMgaXQgY29udGFp
bnMgcmVzaWRlLiIKPgo+ID4gQnR3LCBub3QgYSBuYXRpdmUgc3BlYWtlciBidXQgSSB0aGluayAi
ZGVzY3JpcHRvciIgbWlnaHQgYmUgY29uZnVzaW5nCj4gPiBzaW5jZSBhcyB5b3UgZXhwbGFpbmVk
IGFib3ZlLCBpdCBjb250YWlucyBtb3JlIHRoYW4ganVzdCBhIGRlc2NyaXB0b3IKPiA+IHRhYmxl
Lgo+IFllcC4gSSBjaG9zZSAiZGVzY3JpcHRvciIgYmVjYXVzZSBwYWNrZWQgdmlydHF1ZXVlIGRv
ZXNuJ3QgaGF2ZQo+ICJwaHlzaWNhbCIgYXZhaWwgYW5kIHVzZWQgcmluZyBvdGhlciB0aGFuIGRl
c2NyaXB0b3IgdGFibGUsIGJ1dCBJIHRoaW5rCj4gSSBhbSBvcGVuIHRvIGEgYmV0dGVyIG5hbWUu
IEkgb25jZSB0aG91Z2h0IG9mICJkZXNjcmlwdG9yIHJpbmciIGJ1dCB0aGF0Cj4gbWlnaHQgYmUg
dG9vIHNwZWNpZmljIHRvIHBhY2tlZCB2aXJ0cXVldWUuIEFueSBzdWdnZXN0aW9uPwoKSSBkb24n
dCBoYXZlIGEgYmV0dGVyIGlkZWEsIHByb2JhYmx5ICJtZXRhZGF0YSIgPwoKVGhhbmtzCgo+Cj4g
VGhhbmtzLAo+IC1TaXdlaQo+Cj4gPgo+ID4gVGhhbmtzCj4gPgo+ID4+ICsgKiBSZXF1aXJlcyBW
SE9TVF9CQUNLRU5EX0ZfSU9UTEJfQVNJRC4KPiA+PiArICovCj4gPj4gKyNkZWZpbmUgVkhPU1Rf
QkFDS0VORF9GX0RFU0NfQVNJRCAgICAweDYKPiA+Pgo+ID4+ICAgI2VuZGlmCj4gPj4gLS0KPiA+
PiAxLjguMy4xCj4gPj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
