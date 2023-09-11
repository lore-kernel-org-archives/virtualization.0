Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20CDC71153
	for <virtualization@archiver.kernel.org>; Mon, 11 Sep 2023 03:52:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48FB3815AB;
	Mon, 11 Sep 2023 03:52:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 48FB3815AB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BPgAOciE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QreHWdZjxH9Z; Mon, 11 Sep 2023 03:52:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B4D89815CE;
	Mon, 11 Sep 2023 03:52:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B4D89815CE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79161C0039;
	Mon, 11 Sep 2023 03:52:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C2E4C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 03:52:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E5D8860C0F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 03:52:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E5D8860C0F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BPgAOciE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dd1ZlfM9VjZ2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 03:52:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1050660C05
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 03:52:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1050660C05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694404362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FGsUnbXnFX4UDRFsRz7zmCwf0QEau4HXVmtvjLXSLMY=;
 b=BPgAOciEd/O7KCa96l/5IQmYTPI1AMjjp9jg7GBhlxwnodeEz2iyv/sPQfM+nQuqnxZdFl
 zWpmw4FsIVr31lYaX/tUNfoXSZaRP74ciZCNfDyjGW7QeRBhiZ7zA9SrZQibFdckv41Cq3
 6wcdnfKpHYUhpC3TjjPbvBSLL8tLV7o=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-Z_NB0o2HMn2lxtWhZOItVA-1; Sun, 10 Sep 2023 23:52:41 -0400
X-MC-Unique: Z_NB0o2HMn2lxtWhZOItVA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-500c67585acso3906269e87.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Sep 2023 20:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694404359; x=1695009159;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FGsUnbXnFX4UDRFsRz7zmCwf0QEau4HXVmtvjLXSLMY=;
 b=SG6gwbHp58Fx1V3ZPc6Y5O95A/5kn1bADslHpWt1E6B6fBch+Pz/4XHwpi00iuxTzz
 lb8X0XYafD9fI+NPejTL748gJi06XE89ACWtaorOGCdzjkPPjnPt6vn1lpFbxDeDDl7j
 FHsCl1BtI/uKiXmPsARlOYpcos2OS4g54g7SpU34i4QLPxOZ0Rrlj0muwbdXmFPYb72M
 Xvgv0kTMgmLJnfxlo6ToDsEeKkQNx1LkJvFYf+E3UXkNx7/keJeC7ghuNFTeaK5QvUBH
 6yM+JGNTT7ogN8kIVb24yZuA044zfKtUs3s0Wl52TIV0PhxA00GNlucIQxjEWpYtqbT5
 +qrw==
X-Gm-Message-State: AOJu0Yx2hZnJmjw76VDZqMOcTZ58LTu/YABjjxgd8xGfz+SqeOOxb3FI
 l6dzV3jX5UFib0gZa/5WpT+o8ti4ANBovSUNwTRffZYIsHGMnv2z3bPykGpfnUL8PPmFsJuImqj
 BhFuB0aReHmTy7wNAriyNkgZYMPF8AV/mjK5v0NwxAJDm+YJrMvZFiGGkjA==
X-Received: by 2002:a05:6512:10ce:b0:500:94aa:739c with SMTP id
 k14-20020a05651210ce00b0050094aa739cmr6755525lfg.61.1694404359686; 
 Sun, 10 Sep 2023 20:52:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpjAZiyhtEb+MhK2lfZiNuUfvgDVAXARBJ7ow7FST6TxvSU6yYaKuh72ur0atY7uTKQyjalX/ecqfWXfq/nvk=
X-Received: by 2002:a05:6512:10ce:b0:500:94aa:739c with SMTP id
 k14-20020a05651210ce00b0050094aa739cmr6755513lfg.61.1694404359383; Sun, 10
 Sep 2023 20:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <1694267039-718-1-git-send-email-si-wei.liu@oracle.com>
 <1694267039-718-5-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1694267039-718-5-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Sep 2023 11:52:28 +0800
Message-ID: <CACGkMEu5ey0c-541=ECv7pW7Uj68Pv1Z7TG7Cci1tHfyA4bRqg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 4/4] vhost-vdpa: introduce IOTLB_PERSIST backend
 feature bit
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 xuanzhuo@linux.alibaba.com, mst@redhat.com
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

T24gU2F0LCBTZXAgOSwgMjAyMyBhdCA5OjQ24oCvUE0gU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBv
cmFjbGUuY29tPiB3cm90ZToKPgo+IFVzZXJzcGFjZSBuZWVkcyB0aGlzIGZlYXR1cmUgZmxhZyB0
byBkaXN0aW5ndWlzaCBpZiB2aG9zdC12ZHBhCj4gaW90bGIgaW4gdGhlIGtlcm5lbCBzdXBwb3J0
cyBwZXJzaXN0ZW50IElPVExCIG1hcHBpbmcgYWNyb3NzCj4gZGV2aWNlIHJlc2V0LgoKQXMgZGlz
Y3Vzc2VkLCB0aGUgSU9UTEIgcGVyc2lzdHMgZm9yIGRldmljZXMgd2l0aCBwbGF0Zm9ybSBJT01N
VSBhdApsZWFzdC4gWW91J3ZlIG1lbnRpb25lZCB0aGF0IHRoaXMgYmVoYXZpb3VyIGlzIGNvdmVy
ZWQgYnkgUWVtdSBzaW5jZQppdCByZXNldCBJT1RMQiBvbiByZXNldC4gSSB3b25kZXIgd2hhdCBo
YXBwZW5zIGlmIHdlIHNpbXBseSBkZWNvdXBsZQp0aGUgSU9UTEIgcmVzZXQgZnJvbSB2RFBBIHJl
c2V0IGluIFFlbXUuIENvdWxkIHdlIG1lZXQgYnVncyB0aGVyZT8KCkJ0dywgaXMgdGhlcmUgYSBR
ZW11IHBhdGNoIGZvciByZWZlcmVuY2UgZm9yIHRoaXMgbmV3IGZlYXR1cmU/CgpUaGFua3MKCj4g
VGhlcmUgYXJlIHR3byBjYXNlcyB0aGF0IGJhY2tlbmQgbWF5IGNsYWltCj4gdGhpcyBmZWF0dXJl
IGJpdCBvbjoKPgo+IC0gcGFyZW50IGRldmljZSB0aGF0IGhhcyB0byB3b3JrIHdpdGggcGxhdGZv
cm0gSU9NTVUKPiAtIHBhcmVudCBkZXZpY2Ugd2l0aCBvbi1jaGlwIElPTU1VIHRoYXQgaGFzIHRo
ZSBleHBlY3RlZAo+ICAgLnJlc2V0X21hcCBzdXBwb3J0IGluIGRyaXZlcgo+Cj4gU2lnbmVkLW9m
Zi1ieTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgo+IC0tLQo+IFJGQyB2MiAt
PiB2MzoKPiAgIC0gZml4IG1pc3NpbmcgcmV0dXJuIGR1ZSB0byBtZXJnZSBlcnJvcgo+Cj4gLS0t
Cj4gIGRyaXZlcnMvdmhvc3QvdmRwYS5jICAgICAgICAgICAgIHwgMTYgKysrKysrKysrKysrKysr
LQo+ICBpbmNsdWRlL3VhcGkvbGludXgvdmhvc3RfdHlwZXMuaCB8ICAyICsrCj4gIDIgZmlsZXMg
Y2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBpbmRleCA3MWZi
ZDU1OS4uYjQwNDUwNCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ICsrKyBi
L2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gQEAgLTQxNCw2ICs0MTQsMTQgQEAgc3RhdGljIGJvb2wg
dmhvc3RfdmRwYV9oYXNfZGVzY19ncm91cChjb25zdCBzdHJ1Y3Qgdmhvc3RfdmRwYSAqdikKPiAg
ICAgICAgIHJldHVybiBvcHMtPmdldF92cV9kZXNjX2dyb3VwOwo+ICB9Cj4KPiArc3RhdGljIGJv
b2wgdmhvc3RfdmRwYV9oYXNfcGVyc2lzdGVudF9tYXAoY29uc3Qgc3RydWN0IHZob3N0X3ZkcGEg
KnYpCj4gK3sKPiArICAgICAgIHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4g
KyAgICAgICBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2ZHBhLT5jb25maWc7
Cj4gKwo+ICsgICAgICAgcmV0dXJuICghb3BzLT5zZXRfbWFwICYmICFvcHMtPmRtYV9tYXApIHx8
IG9wcy0+cmVzZXRfbWFwOwo+ICt9Cj4gKwo+ICBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX2dldF9m
ZWF0dXJlcyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTY0IF9fdXNlciAqZmVhdHVyZXApCj4gIHsK
PiAgICAgICAgIHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4gQEAgLTcxNiw3
ICs3MjQsOCBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3VubG9ja2VkX2lvY3RsKHN0cnVjdCBm
aWxlICpmaWxlcCwKPiAgICAgICAgICAgICAgICAgaWYgKGZlYXR1cmVzICYgfihWSE9TVF9WRFBB
X0JBQ0tFTkRfRkVBVFVSRVMgfAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJJ
VF9VTEwoVkhPU1RfQkFDS0VORF9GX0RFU0NfQVNJRCkgfAo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX1NVU1BFTkQpIHwKPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9SRVNVTUUp
KSkKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCSVRfVUxMKFZIT1NUX0JBQ0tF
TkRfRl9SRVNVTUUpIHwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCSVRfVUxM
KFZIT1NUX0JBQ0tFTkRfRl9JT1RMQl9QRVJTSVNUKSkpCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIC1FT1BOT1RTVVBQOwo+ICAgICAgICAgICAgICAgICBpZiAoKGZlYXR1cmVzICYg
QklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfU1VTUEVORCkpICYmCj4gICAgICAgICAgICAgICAgICAg
ICAgIXZob3N0X3ZkcGFfY2FuX3N1c3BlbmQodikpCj4gQEAgLTczMCw2ICs3MzksOSBAQCBzdGF0
aWMgbG9uZyB2aG9zdF92ZHBhX3VubG9ja2VkX2lvY3RsKHN0cnVjdCBmaWxlICpmaWxlcCwKPiAg
ICAgICAgICAgICAgICAgaWYgKChmZWF0dXJlcyAmIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX0RF
U0NfQVNJRCkpICYmCj4gICAgICAgICAgICAgICAgICAgICAgIXZob3N0X3ZkcGFfaGFzX2Rlc2Nf
Z3JvdXAodikpCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQOwo+
ICsgICAgICAgICAgICAgICBpZiAoKGZlYXR1cmVzICYgQklUX1VMTChWSE9TVF9CQUNLRU5EX0Zf
SU9UTEJfUEVSU0lTVCkpICYmCj4gKyAgICAgICAgICAgICAgICAgICAgIXZob3N0X3ZkcGFfaGFz
X3BlcnNpc3RlbnRfbWFwKHYpKQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRU9Q
Tk9UU1VQUDsKPiAgICAgICAgICAgICAgICAgdmhvc3Rfc2V0X2JhY2tlbmRfZmVhdHVyZXMoJnYt
PnZkZXYsIGZlYXR1cmVzKTsKPiAgICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gICAgICAgICB9
Cj4gQEAgLTc4NSw2ICs3OTcsOCBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3VubG9ja2VkX2lv
Y3RsKHN0cnVjdCBmaWxlICpmaWxlcCwKPiAgICAgICAgICAgICAgICAgICAgICAgICBmZWF0dXJl
cyB8PSBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9SRVNVTUUpOwo+ICAgICAgICAgICAgICAgICBp
ZiAodmhvc3RfdmRwYV9oYXNfZGVzY19ncm91cCh2KSkKPiAgICAgICAgICAgICAgICAgICAgICAg
ICBmZWF0dXJlcyB8PSBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9ERVNDX0FTSUQpOwo+ICsgICAg
ICAgICAgICAgICBpZiAodmhvc3RfdmRwYV9oYXNfcGVyc2lzdGVudF9tYXAodikpCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgZmVhdHVyZXMgfD0gQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfSU9U
TEJfUEVSU0lTVCk7Cj4gICAgICAgICAgICAgICAgIGlmIChjb3B5X3RvX3VzZXIoZmVhdHVyZXAs
ICZmZWF0dXJlcywgc2l6ZW9mKGZlYXR1cmVzKSkpCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ciA9IC1FRkFVTFQ7Cj4gICAgICAgICAgICAgICAgIGJyZWFrOwo+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL3VhcGkvbGludXgvdmhvc3RfdHlwZXMuaCBiL2luY2x1ZGUvdWFwaS9saW51eC92aG9zdF90
eXBlcy5oCj4gaW5kZXggNmFjYzYwNC4uMGZkYjZmMCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL3Vh
cGkvbGludXgvdmhvc3RfdHlwZXMuaAo+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92aG9zdF90
eXBlcy5oCj4gQEAgLTE4Niw1ICsxODYsNyBAQCBzdHJ1Y3Qgdmhvc3RfdmRwYV9pb3ZhX3Jhbmdl
IHsKPiAgICogYnVmZmVycyBtYXkgcmVzaWRlLiBSZXF1aXJlcyBWSE9TVF9CQUNLRU5EX0ZfSU9U
TEJfQVNJRC4KPiAgICovCj4gICNkZWZpbmUgVkhPU1RfQkFDS0VORF9GX0RFU0NfQVNJRCAgICAw
eDYKPiArLyogSU9UTEIgZG9uJ3QgZmx1c2ggbWVtb3J5IG1hcHBpbmcgYWNyb3NzIGRldmljZSBy
ZXNldCAqLwo+ICsjZGVmaW5lIFZIT1NUX0JBQ0tFTkRfRl9JT1RMQl9QRVJTSVNUICAweDcKPgo+
ICAjZW5kaWYKPiAtLQo+IDEuOC4zLjEKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
