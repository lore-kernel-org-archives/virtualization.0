Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC12FC76196
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 06:27:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4782E41885;
	Tue, 28 Mar 2023 06:27:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4782E41885
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HvBgH14I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m2Q6sYCLbX8A; Tue, 28 Mar 2023 06:27:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6D3A341875;
	Tue, 28 Mar 2023 06:27:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6D3A341875
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47CE3C0036;
	Tue, 28 Mar 2023 06:27:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A75DAC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 82FA16113E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:27:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 82FA16113E
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HvBgH14I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D7DJyzKZTaXR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:27:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A7B7A61139
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A7B7A61139
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679984866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9cBJC8SmcZRTlzODlygtFSbI/m2n/gX8dxFjyM93IDo=;
 b=HvBgH14IqksoFNLpDioTCvzlg7eDI5Gk7CYp6gwcJGVrhVD+gBSbd2dVu4euOEcjq4C91h
 wy2z/7XbAin4AJEO4yq3S2DNRPjqV8EnEOCDtHl0HKaINYscRsLv/71fQuQ9ACTyOl51N7
 rkAcG0k20k2yZ8Bn6HOFzg5GnvSz/5I=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-MMMF1AqvO3iVBm1cN5nwYg-1; Tue, 28 Mar 2023 02:27:45 -0400
X-MC-Unique: MMMF1AqvO3iVBm1cN5nwYg-1
Received: by mail-oi1-f199.google.com with SMTP id
 s127-20020acaa985000000b003891d21e8c0so1239860oie.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 23:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679984865;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9cBJC8SmcZRTlzODlygtFSbI/m2n/gX8dxFjyM93IDo=;
 b=pf9fap5FFmIY/uDO8m/WIRHDn5q1JGO034EqI7z73Tgmu8NgElQ93+patROz4n+j3k
 U5bNPsOCTuNACT5dCJTP8hx16BI0fxoSBi1I0ugG8VGUrR7+867yKmAu+VpVwzCPDFky
 8pTlVI+tvIZH4nvHs1n3hTxvltZhfMInxFJdAIdz449AkV+zP55o59SlAvr422IqXi2P
 pduOWUJvaTdevTl38BOr5XNgkYYfuBHw3DPh0EcIhRfOSd/JMWw8mCX/jBHxgYfZhd6z
 Qvw1GdZShkNVA3coR+OgGPmkL6yp9b+7ZMSWzvJ8pWBU59UK8kfjCd6h1XfKtrwT0TE5
 mYXA==
X-Gm-Message-State: AO0yUKU6hAIeMo6AlOvyBOwKCKAS37C/cP2/T6hB3eqtrVNTAjAjrdcz
 PHOSLY1IvBix22YT4/RB9Xiq1R3CYAJ7C82W6Bir9wqBFta4xd5Mn2t9CY8FF7TrDfph399yD+N
 G1DslPXDhAAGxXBCphEH9dnQgktrim3kDOsUOa3y2MSiQ4ZFutkoUPpq5uw==
X-Received: by 2002:a9d:66d1:0:b0:69f:bac:aa8a with SMTP id
 t17-20020a9d66d1000000b0069f0bacaa8amr4940803otm.2.1679984864819; 
 Mon, 27 Mar 2023 23:27:44 -0700 (PDT)
X-Google-Smtp-Source: AK7set8uDrhFi4ylmtAjM3puoRdwbmR272em4ZOHowbVALG6jhQag4TCKCeh/c7Hm1LMEV3/ayyfuPmAU5gx5CX3rT4=
X-Received: by 2002:a9d:66d1:0:b0:69f:bac:aa8a with SMTP id
 t17-20020a9d66d1000000b0069f0bacaa8amr4940799otm.2.1679984864590; Mon, 27 Mar
 2023 23:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230327040536.48338-1-xuanzhuo@linux.alibaba.com>
 <20230327040536.48338-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230327040536.48338-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 28 Mar 2023 14:27:33 +0800
Message-ID: <CACGkMEvX_JvJi83kJN3i1gZRLOUD-BHU_N9WHKf=+-voKFvnMA@mail.gmail.com>
Subject: Re: [PATCH vhost v6 05/11] virtio_ring: packed: support premapped
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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

T24gTW9uLCBNYXIgMjcsIDIwMjMgYXQgMTI6MDXigK9QTSBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IHZpcnRpbyBjb3JlIG9ubHkgc3VwcG9ydHMgdmly
dHVhbCBhZGRyZXNzZXMsIGRtYSBpcyBjb21wbGV0ZWQgaW4gdmlydGlvCj4gY29yZS4KPgo+IElu
IHNvbWUgc2NlbmFyaW9zIChzdWNoIGFzIHRoZSBBRl9YRFApLCB0aGUgbWVtb3J5IGlzIGFsbG9j
YXRlZAo+IGFuZCBETUEgbWFwcGluZyBpcyBjb21wbGV0ZWQgaW4gYWR2YW5jZSwgc28gaXQgaXMg
bmVjZXNzYXJ5IGZvciB1cyB0bwo+IHN1cHBvcnQgcGFzc2luZyB0aGUgRE1BIGFkZHJlc3MgdG8g
dmlydGlvIGNvcmUuCj4KPiBEcml2ZXMgY2FuIHVzZSBzZy0+ZG1hX2FkZHJlc3MgdG8gcGFzcyB0
aGUgbWFwcGVkIGRtYSBhZGRyZXNzIHRvIHZpcnRpbwo+IGNvcmUuIElmIG9uZSBzZy0+ZG1hX2Fk
ZHJlc3MgaXMgdXNlZCB0aGVuIGFsbCBzZ3MgbXVzdCB1c2UKPiBzZy0+ZG1hX2FkZHJlc3MsIG90
aGVyd2lzZSBhbGwgbXVzdCBiZSBudWxsIHdoZW4gcGFzc2luZyBpdCB0byB0aGUgQVBJcwo+IG9m
IHZpcnRpby4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxp
YmFiYS5jb20+CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRo
YW5rcwoKPiAtLS0KPiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDE3ICsrKysrKysr
KysrKysrLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXggOWQ2YWNkNTllM2UwLi4yYWZmZjFkYzZj
NzQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBiL2Ry
aXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtODEsNiArODEsNyBAQCBzdHJ1Y3QgdnJp
bmdfZGVzY19zdGF0ZV9wYWNrZWQgewo+ICAgICAgICAgc3RydWN0IHZyaW5nX3BhY2tlZF9kZXNj
ICppbmRpcl9kZXNjOyAvKiBJbmRpcmVjdCBkZXNjcmlwdG9yLCBpZiBhbnkuICovCj4gICAgICAg
ICB1MTYgbnVtOyAgICAgICAgICAgICAgICAgICAgICAgIC8qIERlc2NyaXB0b3IgbGlzdCBsZW5n
dGguICovCj4gICAgICAgICB1MTYgbGFzdDsgICAgICAgICAgICAgICAgICAgICAgIC8qIFRoZSBs
YXN0IGRlc2Mgc3RhdGUgaW4gYSBsaXN0LiAqLwo+ICsgICAgICAgdTMyIGZsYWdzOyAgICAgICAg
ICAgICAgICAgICAgICAvKiBTdGF0ZSBmbGFncy4gKi8KPiAgfTsKPgo+ICBzdHJ1Y3QgdnJpbmdf
ZGVzY19leHRyYSB7Cj4gQEAgLTEyNjQsNyArMTI2NSw4IEBAIHN0YXRpYyBpbmxpbmUgdTE2IHBh
Y2tlZF9sYXN0X3VzZWQodTE2IGxhc3RfdXNlZF9pZHgpCj4gIH0KPgo+ICBzdGF0aWMgdm9pZCB2
cmluZ191bm1hcF9leHRyYV9wYWNrZWQoY29uc3Qgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEs
Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2cmluZ19kZXNj
X2V4dHJhICpleHRyYSkKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Ry
dWN0IHZyaW5nX2Rlc2NfZXh0cmEgKmV4dHJhLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBib29sIGRtYV9tYXBfaW50ZXJuYWwpCj4gIHsKPiAgICAgICAgIHUxNiBmbGFn
czsKPgo+IEBAIC0xMjc5LDYgKzEyODEsOSBAQCBzdGF0aWMgdm9pZCB2cmluZ191bm1hcF9leHRy
YV9wYWNrZWQoY29uc3Qgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKGZsYWdzICYgVlJJTkdfREVTQ19GX1dSSVRFKSA/Cj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRE1BX0ZST01fREVWSUNFIDogRE1BX1RPX0RF
VklDRSk7Cj4gICAgICAgICB9IGVsc2Ugewo+ICsgICAgICAgICAgICAgICBpZiAoIWRtYV9tYXBf
aW50ZXJuYWwpCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuOwo+ICsKPiAgICAgICAg
ICAgICAgICAgZG1hX3VubWFwX3BhZ2UodnJpbmdfZG1hX2Rldih2cSksCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGV4dHJhLT5hZGRyLCBleHRyYS0+bGVuLAo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAoZmxhZ3MgJiBWUklOR19ERVNDX0ZfV1JJVEUpID8KPiBAQCAt
MTQ0NSw2ICsxNDUwLDcgQEAgc3RhdGljIGlubGluZSBpbnQgdmlydHF1ZXVlX2FkZF9wYWNrZWQo
c3RydWN0IHZpcnRxdWV1ZSAqX3ZxLAo+ICAgICAgICAgdW5zaWduZWQgaW50IGksIG4sIGMsIGRl
c2NzX3VzZWQ7Cj4gICAgICAgICBfX2xlMTYgaGVhZF9mbGFncywgZmxhZ3M7Cj4gICAgICAgICB1
MTYgaGVhZCwgaWQsIHByZXYsIGN1cnI7Cj4gKyAgICAgICBib29sIGRtYV9tYXBfaW50ZXJuYWw7
Cj4gICAgICAgICBpbnQgZXJyOwo+Cj4gICAgICAgICBTVEFSVF9VU0UodnEpOwo+IEBAIC0xNDkw
LDcgKzE0OTYsOCBAQCBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVfYWRkX3BhY2tlZChzdHJ1
Y3QgdmlydHF1ZXVlICpfdnEsCj4gICAgICAgICBpZCA9IHZxLT5mcmVlX2hlYWQ7Cj4gICAgICAg
ICBCVUdfT04oaWQgPT0gdnEtPnBhY2tlZC52cmluZy5udW0pOwo+Cj4gLSAgICAgICBpZiAodmly
dHF1ZXVlX21hcF9zZ3ModnEsIHNncywgdG90YWxfc2csIG91dF9zZ3MsIGluX3NncykpIHsKPiAr
ICAgICAgIGRtYV9tYXBfaW50ZXJuYWwgPSAhc2dzWzBdLT5kbWFfYWRkcmVzczsKPiArICAgICAg
IGlmIChkbWFfbWFwX2ludGVybmFsICYmIHZpcnRxdWV1ZV9tYXBfc2dzKHZxLCBzZ3MsIHRvdGFs
X3NnLCBvdXRfc2dzLCBpbl9zZ3MpKSB7Cj4gICAgICAgICAgICAgICAgIEVORF9VU0UodnEpOwo+
ICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTzsKPiAgICAgICAgIH0KPiBAQCAtMTU0NCw2ICsx
NTUxLDcgQEAgc3RhdGljIGlubGluZSBpbnQgdmlydHF1ZXVlX2FkZF9wYWNrZWQoc3RydWN0IHZp
cnRxdWV1ZSAqX3ZxLAo+ICAgICAgICAgdnEtPnBhY2tlZC5kZXNjX3N0YXRlW2lkXS5kYXRhID0g
ZGF0YTsKPiAgICAgICAgIHZxLT5wYWNrZWQuZGVzY19zdGF0ZVtpZF0uaW5kaXJfZGVzYyA9IGN0
eDsKPiAgICAgICAgIHZxLT5wYWNrZWQuZGVzY19zdGF0ZVtpZF0ubGFzdCA9IHByZXY7Cj4gKyAg
ICAgICB2cS0+cGFja2VkLmRlc2Nfc3RhdGVbaWRdLmZsYWdzID0gZG1hX21hcF9pbnRlcm5hbCA/
IFZSSU5HX1NUQVRFX0ZfTUFQX0lOVEVSTkFMIDogMDsKPgo+ICAgICAgICAgLyoKPiAgICAgICAg
ICAqIEEgZHJpdmVyIE1VU1QgTk9UIG1ha2UgdGhlIGZpcnN0IGRlc2NyaXB0b3IgaW4gdGhlIGxp
c3QKPiBAQCAtMTYxNSw4ICsxNjIzLDEwIEBAIHN0YXRpYyB2b2lkIGRldGFjaF9idWZfcGFja2Vk
KHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+ICAgICAgICAgc3RydWN0IHZyaW5nX2Rlc2Nf
c3RhdGVfcGFja2VkICpzdGF0ZSA9IE5VTEw7Cj4gICAgICAgICBzdHJ1Y3QgdnJpbmdfcGFja2Vk
X2Rlc2MgKmRlc2M7Cj4gICAgICAgICB1bnNpZ25lZCBpbnQgaSwgY3VycjsKPiArICAgICAgIGJv
b2wgZG1hX21hcF9pbnRlcm5hbDsKPgo+ICAgICAgICAgc3RhdGUgPSAmdnEtPnBhY2tlZC5kZXNj
X3N0YXRlW2lkXTsKPiArICAgICAgIGRtYV9tYXBfaW50ZXJuYWwgPSAhIShzdGF0ZS0+ZmxhZ3Mg
JiBWUklOR19TVEFURV9GX01BUF9JTlRFUk5BTCk7Cj4KPiAgICAgICAgIC8qIENsZWFyIGRhdGEg
cHRyLiAqLwo+ICAgICAgICAgc3RhdGUtPmRhdGEgPSBOVUxMOwo+IEBAIC0xNjI5LDcgKzE2Mzks
OCBAQCBzdGF0aWMgdm9pZCBkZXRhY2hfYnVmX3BhY2tlZChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVl
ICp2cSwKPiAgICAgICAgICAgICAgICAgY3VyciA9IGlkOwo+ICAgICAgICAgICAgICAgICBmb3Ig
KGkgPSAwOyBpIDwgc3RhdGUtPm51bTsgaSsrKSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAg
dnJpbmdfdW5tYXBfZXh0cmFfcGFja2VkKHZxLAo+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAmdnEtPnBhY2tlZC5kZXNjX2V4dHJhW2N1cnJdKTsKPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnZxLT5wYWNr
ZWQuZGVzY19leHRyYVtjdXJyXSwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZG1hX21hcF9pbnRlcm5hbCk7Cj4gICAgICAgICAgICAgICAgICAgICAg
ICAgY3VyciA9IHZxLT5wYWNrZWQuZGVzY19leHRyYVtjdXJyXS5uZXh0Owo+ICAgICAgICAgICAg
ICAgICB9Cj4gICAgICAgICB9Cj4gLS0KPiAyLjMyLjAuMy5nMDExOTVjZjlmCj4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
