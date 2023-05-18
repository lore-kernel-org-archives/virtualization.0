Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88FDC77B7A
	for <virtualization@archiver.kernel.org>; Thu, 18 May 2023 06:52:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C23A6FF44;
	Thu, 18 May 2023 06:52:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2C23A6FF44
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GKDJTkmm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wKHY5Zq3DXte; Thu, 18 May 2023 06:52:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8934F60E79;
	Thu, 18 May 2023 06:52:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8934F60E79
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FFF7C0036;
	Thu, 18 May 2023 06:52:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DAB1DC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 06:51:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A1B3860F1F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 06:51:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A1B3860F1F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9CWCZ2hM8d7s
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 06:51:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7301160E79
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7301160E79
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 06:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684392716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I0raKGLh9Pg2nIeGzyDIdxhOHdO2X0PF2qKhPM7QrdU=;
 b=GKDJTkmm4l5YN1bhqHOXsFrhL+4DDUICHcva87AzRAx/tV38M/t5xC6UE1yIOIeyeRpyxr
 LVDtC87fJmfVqZb6GVMXawxbMGYVQ6iGIvMtaexqbYFmlPNvEKsuWBhEgQcnStoaq/BT/l
 /xdbldh1dEhWM+nTXYpeCQOWvwpuTbY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-V2YMKo-CPAmViJWwOIn2xA-1; Thu, 18 May 2023 02:51:52 -0400
X-MC-Unique: V2YMKo-CPAmViJWwOIn2xA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4ec790b902bso1113909e87.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 23:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684392711; x=1686984711;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I0raKGLh9Pg2nIeGzyDIdxhOHdO2X0PF2qKhPM7QrdU=;
 b=CWlslLfcMs3DCXOtCpmUCVs6H2/q6+B2ZuJvyN4cZZGO+Ls04ktwRZ4IKxlp5PLKm6
 eftJ7ul/ZHMVYoVEEY3hfF6X9i/BbpzwOTVqE54WF1C8xtNiSr0a/jI2PnVIwTB1ZqiQ
 W2CwMDgXrL4tErZP0DEbl8Au0VkO7fYMDVGFUCpPdwmaQK/NFNPQNYCihu2aIMUjyGJX
 z+ssTFDL7z7Yr8EOnb1KPcgQa/uIiexGWwjLZSeOGjRpFN5XY+CDQsPeIH6cETHU/Tla
 QD3Foy3aVjGvRT4k6oZA8sJR1lLKkyfzyOzp25/R3TQNpbItRqzm0F2uvuf9huS0I5u1
 cGJw==
X-Gm-Message-State: AC+VfDzrMqW2O4+PV17pWsA4uOsct1JiRYjz39G720vblesEwzyRDGCe
 TAf0xsoGeEVl6gn4PHHb+OWboRe44LYviG9mE8onGppsO/D6asO8nOyuAtMYghnuvyFvtQ/lg5K
 Tk7X2nv1TFfyRkgKX0Pj9CRBe5lcPwRjs7cdcoxIpeyC1NGl1ZE3UN+6HJA==
X-Received: by 2002:a19:760e:0:b0:4f3:7d0e:3680 with SMTP id
 c14-20020a19760e000000b004f37d0e3680mr806714lff.21.1684392710998; 
 Wed, 17 May 2023 23:51:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4TH2X2okHq8La5ntkPWYGffyc8X8dpsvaxvt0gT96TukUCCT3BkEtk1i+mjg0pGMFCz/OquTwC3rP5jRR9GO4=
X-Received: by 2002:a19:760e:0:b0:4f3:7d0e:3680 with SMTP id
 c14-20020a19760e000000b004f37d0e3680mr806707lff.21.1684392710658; Wed, 17 May
 2023 23:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230517022249.20790-1-xuanzhuo@linux.alibaba.com>
 <20230517022249.20790-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230517022249.20790-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 May 2023 14:51:38 +0800
Message-ID: <CACGkMEtK8UDXtGpt2aJVBmx0Apq6=LRZs7LQo_Z2+VFrLHdagQ@mail.gmail.com>
Subject: Re: [PATCH vhost v9 01/12] virtio_ring: put mapping error check in
 vring_map_one_sg
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Christoph Hellwig <hch@infradead.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

T24gV2VkLCBNYXkgMTcsIDIwMjMgYXQgMTA6MjPigK9BTSBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IFRoaXMgcGF0Y2ggcHV0IHRoZSBkbWEgYWRkciBl
cnJvciBjaGVjayBpbiB2cmluZ19tYXBfb25lX3NnKCkuCj4KPiBUaGUgYmVuZWZpdHMgb2YgZG9p
bmcgdGhpczoKPgo+IDEuIG1ha2UgdnJpbmdfbWFwX29uZV9zZyBtb3JlIHNpbXBsZSwgd2l0aG91
dCBjYWxsaW5nCj4gICAgdnJpbmdfbWFwcGluZ19lcnJvciB0byBjaGVjayB0aGUgcmV0dXJuIHZh
bHVlLgo+IDIuIHJlZHVjZSBvbmUganVkZ21lbnQgb2YgdnEtPnVzZV9kbWFfYXBpLgoKQ29kZSBs
b29rcyBmaW5lIGJ1dCBpdCdzIGJldHRlciB0byBleHBsYWluIGhvdyBpdCByZWxhdGVzIG9yIHNp
bXBseQphbnl0aGluZyB3aXRoIHRoaXMgc2VyaWVzLgoKVGhhbmtzCgoKPgo+IFNpZ25lZC1vZmYt
Ynk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gLS0tCj4gIGRyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAzNyArKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9u
cygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXggYzUzMTBlYWY4YjQ2Li5jNTYzMjE1YmU2
YjkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBiL2Ry
aXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtMzU1LDkgKzM1NSw4IEBAIHN0YXRpYyBz
dHJ1Y3QgZGV2aWNlICp2cmluZ19kbWFfZGV2KGNvbnN0IHN0cnVjdCB2cmluZ192aXJ0cXVldWUg
KnZxKQo+ICB9Cj4KPiAgLyogTWFwIG9uZSBzZyBlbnRyeS4gKi8KPiAtc3RhdGljIGRtYV9hZGRy
X3QgdnJpbmdfbWFwX29uZV9zZyhjb25zdCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBzY2F0dGVybGlzdCAqc2cs
Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnVtIGRtYV9kYXRhX2RpcmVj
dGlvbiBkaXJlY3Rpb24pCj4gK3N0YXRpYyBpbnQgdnJpbmdfbWFwX29uZV9zZyhjb25zdCBzdHJ1
Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwgc3RydWN0IHNjYXR0ZXJsaXN0ICpzZywKPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZW51bSBkbWFfZGF0YV9kaXJlY3Rpb24gZGlyZWN0aW9uLCBz
dGF0aWMgZG1hX2FkZHJfdCAqYWRkcikKPiAgewo+ICAgICAgICAgaWYgKCF2cS0+dXNlX2RtYV9h
cGkpIHsKPiAgICAgICAgICAgICAgICAgLyoKPiBAQCAtMzY2LDcgKzM2NSw4IEBAIHN0YXRpYyBk
bWFfYWRkcl90IHZyaW5nX21hcF9vbmVfc2coY29uc3Qgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAq
dnEsCj4gICAgICAgICAgICAgICAgICAqIGRlcGVuZGluZyBvbiB0aGUgZGlyZWN0aW9uLgo+ICAg
ICAgICAgICAgICAgICAgKi8KPiAgICAgICAgICAgICAgICAga21zYW5faGFuZGxlX2RtYShzZ19w
YWdlKHNnKSwgc2ctPm9mZnNldCwgc2ctPmxlbmd0aCwgZGlyZWN0aW9uKTsKPiAtICAgICAgICAg
ICAgICAgcmV0dXJuIChkbWFfYWRkcl90KXNnX3BoeXMoc2cpOwo+ICsgICAgICAgICAgICAgICAq
YWRkciA9IChkbWFfYWRkcl90KXNnX3BoeXMoc2cpOwo+ICsgICAgICAgICAgICAgICByZXR1cm4g
MDsKPiAgICAgICAgIH0KPgo+ICAgICAgICAgLyoKPiBAQCAtMzc0LDkgKzM3NCwxNCBAQCBzdGF0
aWMgZG1hX2FkZHJfdCB2cmluZ19tYXBfb25lX3NnKGNvbnN0IHN0cnVjdCB2cmluZ192aXJ0cXVl
dWUgKnZxLAo+ICAgICAgICAgICogdGhlIHdheSBpdCBleHBlY3RzICh3ZSBkb24ndCBndWFyYW50
ZWUgdGhhdCB0aGUgc2NhdHRlcmxpc3QKPiAgICAgICAgICAqIHdpbGwgZXhpc3QgZm9yIHRoZSBs
aWZldGltZSBvZiB0aGUgbWFwcGluZykuCj4gICAgICAgICAgKi8KPiAtICAgICAgIHJldHVybiBk
bWFfbWFwX3BhZ2UodnJpbmdfZG1hX2Rldih2cSksCj4gKyAgICAgICAqYWRkciA9IGRtYV9tYXBf
cGFnZSh2cmluZ19kbWFfZGV2KHZxKSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2df
cGFnZShzZyksIHNnLT5vZmZzZXQsIHNnLT5sZW5ndGgsCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGRpcmVjdGlvbik7Cj4gKwo+ICsgICAgICAgaWYgKGRtYV9tYXBwaW5nX2Vycm9yKHZy
aW5nX2RtYV9kZXYodnEpLCAqYWRkcikpCj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVN
Owo+ICsKPiArICAgICAgIHJldHVybiAwOwo+ICB9Cj4KPiAgc3RhdGljIGRtYV9hZGRyX3QgdnJp
bmdfbWFwX3NpbmdsZShjb25zdCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPiBAQCAtNTg4
LDggKzU5Myw5IEBAIHN0YXRpYyBpbmxpbmUgaW50IHZpcnRxdWV1ZV9hZGRfc3BsaXQoc3RydWN0
IHZpcnRxdWV1ZSAqX3ZxLAo+Cj4gICAgICAgICBmb3IgKG4gPSAwOyBuIDwgb3V0X3Nnczsgbisr
KSB7Cj4gICAgICAgICAgICAgICAgIGZvciAoc2cgPSBzZ3Nbbl07IHNnOyBzZyA9IHNnX25leHQo
c2cpKSB7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgZG1hX2FkZHJfdCBhZGRyID0gdnJpbmdf
bWFwX29uZV9zZyh2cSwgc2csIERNQV9UT19ERVZJQ0UpOwo+IC0gICAgICAgICAgICAgICAgICAg
ICAgIGlmICh2cmluZ19tYXBwaW5nX2Vycm9yKHZxLCBhZGRyKSkKPiArICAgICAgICAgICAgICAg
ICAgICAgICBkbWFfYWRkcl90IGFkZHI7Cj4gKwo+ICsgICAgICAgICAgICAgICAgICAgICAgIGlm
ICh2cmluZ19tYXBfb25lX3NnKHZxLCBzZywgRE1BX1RPX0RFVklDRSwgJmFkZHIpKQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byB1bm1hcF9yZWxlYXNlOwo+Cj4gICAgICAg
ICAgICAgICAgICAgICAgICAgcHJldiA9IGk7Cj4gQEAgLTYwMyw4ICs2MDksOSBAQCBzdGF0aWMg
aW5saW5lIGludCB2aXJ0cXVldWVfYWRkX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSwKPiAg
ICAgICAgIH0KPiAgICAgICAgIGZvciAoOyBuIDwgKG91dF9zZ3MgKyBpbl9zZ3MpOyBuKyspIHsK
PiAgICAgICAgICAgICAgICAgZm9yIChzZyA9IHNnc1tuXTsgc2c7IHNnID0gc2dfbmV4dChzZykp
IHsKPiAtICAgICAgICAgICAgICAgICAgICAgICBkbWFfYWRkcl90IGFkZHIgPSB2cmluZ19tYXBf
b25lX3NnKHZxLCBzZywgRE1BX0ZST01fREVWSUNFKTsKPiAtICAgICAgICAgICAgICAgICAgICAg
ICBpZiAodnJpbmdfbWFwcGluZ19lcnJvcih2cSwgYWRkcikpCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgZG1hX2FkZHJfdCBhZGRyOwo+ICsKPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAo
dnJpbmdfbWFwX29uZV9zZyh2cSwgc2csIERNQV9GUk9NX0RFVklDRSwgJmFkZHIpKQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byB1bm1hcF9yZWxlYXNlOwo+Cj4gICAgICAg
ICAgICAgICAgICAgICAgICAgcHJldiA9IGk7Cj4gQEAgLTEyNzksOSArMTI4Niw4IEBAIHN0YXRp
YyBpbnQgdmlydHF1ZXVlX2FkZF9pbmRpcmVjdF9wYWNrZWQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1
ZSAqdnEsCj4KPiAgICAgICAgIGZvciAobiA9IDA7IG4gPCBvdXRfc2dzICsgaW5fc2dzOyBuKysp
IHsKPiAgICAgICAgICAgICAgICAgZm9yIChzZyA9IHNnc1tuXTsgc2c7IHNnID0gc2dfbmV4dChz
ZykpIHsKPiAtICAgICAgICAgICAgICAgICAgICAgICBhZGRyID0gdnJpbmdfbWFwX29uZV9zZyh2
cSwgc2csIG4gPCBvdXRfc2dzID8KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgRE1BX1RPX0RFVklDRSA6IERNQV9GUk9NX0RFVklDRSk7Cj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKHZyaW5nX21hcHBpbmdfZXJyb3IodnEsIGFkZHIpKQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGlmICh2cmluZ19tYXBfb25lX3NnKHZxLCBzZywgbiA8IG91dF9zZ3MgPwo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIERNQV9UT19ERVZJ
Q0UgOiBETUFfRlJPTV9ERVZJQ0UsICZhZGRyKSkKPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGdvdG8gdW5tYXBfcmVsZWFzZTsKPgo+ICAgICAgICAgICAgICAgICAgICAgICAgIGRl
c2NbaV0uZmxhZ3MgPSBjcHVfdG9fbGUxNihuIDwgb3V0X3NncyA/Cj4gQEAgLTE0MjYsOSArMTQz
MiwxMCBAQCBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVfYWRkX3BhY2tlZChzdHJ1Y3Qgdmly
dHF1ZXVlICpfdnEsCj4gICAgICAgICBjID0gMDsKPiAgICAgICAgIGZvciAobiA9IDA7IG4gPCBv
dXRfc2dzICsgaW5fc2dzOyBuKyspIHsKPiAgICAgICAgICAgICAgICAgZm9yIChzZyA9IHNnc1tu
XTsgc2c7IHNnID0gc2dfbmV4dChzZykpIHsKPiAtICAgICAgICAgICAgICAgICAgICAgICBkbWFf
YWRkcl90IGFkZHIgPSB2cmluZ19tYXBfb25lX3NnKHZxLCBzZywgbiA8IG91dF9zZ3MgPwo+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBETUFfVE9fREVWSUNFIDogRE1B
X0ZST01fREVWSUNFKTsKPiAtICAgICAgICAgICAgICAgICAgICAgICBpZiAodnJpbmdfbWFwcGlu
Z19lcnJvcih2cSwgYWRkcikpCj4gKyAgICAgICAgICAgICAgICAgICAgICAgZG1hX2FkZHJfdCBh
ZGRyOwo+ICsKPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAodnJpbmdfbWFwX29uZV9zZyh2
cSwgc2csIG4gPCBvdXRfc2dzID8KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBETUFfVE9fREVWSUNFIDogRE1BX0ZST01fREVWSUNFLCAmYWRkcikpCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIHVubWFwX3JlbGVhc2U7Cj4KPiAgICAg
ICAgICAgICAgICAgICAgICAgICBmbGFncyA9IGNwdV90b19sZTE2KHZxLT5wYWNrZWQuYXZhaWxf
dXNlZF9mbGFncyB8Cj4gLS0KPiAyLjMyLjAuMy5nMDExOTVjZjlmCj4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
