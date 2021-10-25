Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF1CC433F5
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 06:03:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD94A60724
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 06:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD94A60724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 71AD8401FA;
	Mon, 25 Oct 2021 06:03:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MsnsIKtVKy9c; Mon, 25 Oct 2021 06:03:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 01E9E40148;
	Mon, 25 Oct 2021 06:03:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A88EEC0019;
	Mon, 25 Oct 2021 06:03:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A04BDC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 06:03:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8122D401EE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 06:03:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W3Z-iHxtiSr0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 06:03:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E8B6740148
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 06:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635141793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FR7xctmKn68qHoUiqe4YwpxQ5stu0ejkVSqpnhLZEo4=;
 b=ZqKjRrzxpN92K7itwTKQSqvEdq4ZBXK+Bpy4eLQpLJ+TU+xbH3Z6VWA1A0yI2igas7a5IG
 vCKAab0usFaqbdivdz676mbgLJr0tHaiyZl4h4Mb6drGQU9SM2VlqpwpsHtDefl11Bs3z+
 DXwzYgtn9/Lyna8qzKgPssfNb838E74=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-UsuQsIqDNY2SiIEhgCOtAg-1; Mon, 25 Oct 2021 02:03:09 -0400
X-MC-Unique: UsuQsIqDNY2SiIEhgCOtAg-1
Received: by mail-pf1-f198.google.com with SMTP id
 2-20020aa79102000000b0044c216dd8ecso5857744pfh.18
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 23:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=FR7xctmKn68qHoUiqe4YwpxQ5stu0ejkVSqpnhLZEo4=;
 b=5lemcl6DfTQACfYFJGQ9EBYqlpSBTFMMdZE3fW6DQc2K7F41URGUC/iKNaAvZdHo5W
 0+/Cx2eyu2N9tWYNXnGe9P1dx10el0dWnJ34fF9S21g0hiGXFty3EyOuTCr5Zfpmnd56
 iQKOi8JrbkKQFje8mo/NxMRDj1jUB2qrq6g+vfPFQ13FvVbOxdqU60cgZIcZwOG7eE39
 Ikg6XJOPhta1HaiqGgTbKbm7IgqKoFG+VtZ+icSkx3ZCSVwgjswcGlXU9S+b00yUgZGt
 qUtUjtClowj8Uyrf6VuT2zFQioeJqm90Vgy+x+N0UqsoBFzmzo+tR6yzbCRjbtNjPRRh
 blrw==
X-Gm-Message-State: AOAM531DssaZ0JWbpdcYTdm5CQba8/93WfOnWfVFUPTIAXx8wGfiGb98
 fjArfp9vtNzfc6wixk6EMj5UsyUaXJe2mjZr1q0m30X8c4hHKmCidk6eQiUkrIG3l8P+pumquwW
 zq4rure9gu0vF6oTjMNoQ5BX8GkCDxjq4CRKCtaQNtA==
X-Received: by 2002:a63:1d53:: with SMTP id d19mr11950468pgm.85.1635141788692; 
 Sun, 24 Oct 2021 23:03:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUtFP/uYyXUnSb/VHfGEl47UgPOxGcgq7GTGJqblWTB/mnR8lrbANhagoGZeH4ap9T8fZR/Q==
X-Received: by 2002:a63:1d53:: with SMTP id d19mr11950441pgm.85.1635141788332; 
 Sun, 24 Oct 2021 23:03:08 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 21sm19658182pjg.57.2021.10.24.23.03.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Oct 2021 23:03:07 -0700 (PDT)
Subject: Re: [PATCH linux-next v4 1/8] vdpa: Introduce and use vdpa device
 get, set config helpers
To: Parav Pandit <parav@nvidia.com>, virtualization@lists.linux-foundation.org
References: <20211021163509.6978-1-parav@nvidia.com>
 <20211021163509.6978-2-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <358dd349-906d-4d94-7ea1-f799d51283c2@redhat.com>
Date: Mon, 25 Oct 2021 14:03:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211021163509.6978-2-parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: elic@nvidia.com, mst@redhat.com
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvMTAvMjIgyc/O5zEyOjM1LCBQYXJhdiBQYW5kaXQg0LS1wDoKPiBTdWJzZXF1ZW50
IHBhdGNoZXMgZW5hYmxlIGdldCBhbmQgc2V0IGNvbmZpZ3VyYXRpb24gZWl0aGVyCj4gdmlhIG1h
bmFnZW1lbnQgZGV2aWNlIG9yIHZpYSB2ZHBhIGRldmljZScgY29uZmlnIG9wcy4KPgo+IFRoaXMg
cmVxdWlyZXMgc3luY2hyb25pemF0aW9uIGJldHdlZW4gbXVsdGlwbGUgY2FsbGVycyB0byBnZXQg
YW5kIHNldAo+IGNvbmZpZyBjYWxsYmFja3MuIEZlYXR1cmVzIHNldHRpbmcgYWxzbyBpbmZsdWVu
Y2UgdGhlIGxheW91dCBvZiB0aGUKPiBjb25maWd1cmF0aW9uIGZpZWxkcyBlbmRpYW5uZXNzLgo+
Cj4gVG8gYXZvaWQgZXhwb3Npbmcgc3luY2hyb25pemF0aW9uIHByaW1pdGl2ZXMgdG8gY2FsbGVy
cywgaW50cm9kdWNlCj4gaGVscGVyIGZvciBzZXR0aW5nIHRoZSBjb25maWd1cmF0aW9uIGFuZCB1
c2UgaXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+
Cj4gUmV2aWV3ZWQtYnk6IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPgo+IEFja2VkLWJ5OiBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92ZHBhL3Zk
cGEuYyAgfCAzNiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgIGRyaXZl
cnMvdmhvc3QvdmRwYS5jIHwgIDMgKy0tCj4gICBpbmNsdWRlL2xpbnV4L3ZkcGEuaCB8IDE5ICsr
KystLS0tLS0tLS0tLS0tLS0KCgpEbyB3ZSBuZWVkIHRvIGNoYW5nZSB2aXJ0aW9fdmRwYV9zZXQo
KSBhcyB3ZWxsPwoKVGhhbmtzCgoKPiAgIDMgZmlsZXMgY2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygr
KSwgMTcgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGEuYyBi
L2RyaXZlcnMvdmRwYS92ZHBhLmMKPiBpbmRleCAxZGMxMjFhMDdhOTMuLjZmZGZjMTFlY2IxMyAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYS5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3Zk
cGEuYwo+IEBAIC0yODksNiArMjg5LDQyIEBAIHZvaWQgdmRwYV9tZ210ZGV2X3VucmVnaXN0ZXIo
c3RydWN0IHZkcGFfbWdtdF9kZXYgKm1kZXYpCj4gICB9Cj4gICBFWFBPUlRfU1lNQk9MX0dQTCh2
ZHBhX21nbXRkZXZfdW5yZWdpc3Rlcik7Cj4gICAKPiArLyoqCj4gKyAqIHZkcGFfZ2V0X2NvbmZp
ZyAtIEdldCBvbmUgb3IgbW9yZSBkZXZpY2UgY29uZmlndXJhdGlvbiBmaWVsZHMuCj4gKyAqIEB2
ZGV2OiB2ZHBhIGRldmljZSB0byBvcGVyYXRlIG9uCj4gKyAqIEBvZmZzZXQ6IHN0YXJ0aW5nIGJ5
dGUgb2Zmc2V0IG9mIHRoZSBmaWVsZAo+ICsgKiBAYnVmOiBidWZmZXIgcG9pbnRlciB0byByZWFk
IHRvCj4gKyAqIEBsZW46IGxlbmd0aCBvZiB0aGUgY29uZmlndXJhdGlvbiBmaWVsZHMgaW4gYnl0
ZXMKPiArICovCj4gK3ZvaWQgdmRwYV9nZXRfY29uZmlnKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRl
diwgdW5zaWduZWQgaW50IG9mZnNldCwKPiArCQkgICAgIHZvaWQgKmJ1ZiwgdW5zaWduZWQgaW50
IGxlbikKPiArewo+ICsJY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRldi0+
Y29uZmlnOwo+ICsKPiArCS8qCj4gKwkgKiBDb25maWcgYWNjZXNzZXMgYXJlbid0IHN1cHBvc2Vk
IHRvIHRyaWdnZXIgYmVmb3JlIGZlYXR1cmVzIGFyZSBzZXQuCj4gKwkgKiBJZiBpdCBkb2VzIGhh
cHBlbiB3ZSBhc3N1bWUgYSBsZWdhY3kgZ3Vlc3QuCj4gKwkgKi8KPiArCWlmICghdmRldi0+ZmVh
dHVyZXNfdmFsaWQpCj4gKwkJdmRwYV9zZXRfZmVhdHVyZXModmRldiwgMCk7Cj4gKwlvcHMtPmdl
dF9jb25maWcodmRldiwgb2Zmc2V0LCBidWYsIGxlbik7Cj4gK30KPiArRVhQT1JUX1NZTUJPTF9H
UEwodmRwYV9nZXRfY29uZmlnKTsKPiArCj4gKy8qKgo+ICsgKiB2ZHBhX3NldF9jb25maWcgLSBT
ZXQgb25lIG9yIG1vcmUgZGV2aWNlIGNvbmZpZ3VyYXRpb24gZmllbGRzLgo+ICsgKiBAdmRldjog
dmRwYSBkZXZpY2UgdG8gb3BlcmF0ZSBvbgo+ICsgKiBAb2Zmc2V0OiBzdGFydGluZyBieXRlIG9m
ZnNldCBvZiB0aGUgZmllbGQKPiArICogQGJ1ZjogYnVmZmVyIHBvaW50ZXIgdG8gcmVhZCBmcm9t
Cj4gKyAqIEBsZW5ndGg6IGxlbmd0aCBvZiB0aGUgY29uZmlndXJhdGlvbiBmaWVsZHMgaW4gYnl0
ZXMKPiArICovCj4gK3ZvaWQgdmRwYV9zZXRfY29uZmlnKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRl
diwgdW5zaWduZWQgaW50IG9mZnNldCwKPiArCQkgICAgIHZvaWQgKmJ1ZiwgdW5zaWduZWQgaW50
IGxlbmd0aCkKPiArewo+ICsJdmRldi0+Y29uZmlnLT5zZXRfY29uZmlnKHZkZXYsIG9mZnNldCwg
YnVmLCBsZW5ndGgpOwo+ICt9Cj4gK0VYUE9SVF9TWU1CT0xfR1BMKHZkcGFfc2V0X2NvbmZpZyk7
Cj4gKwo+ICAgc3RhdGljIGJvb2wgbWdtdGRldl9oYW5kbGVfbWF0Y2goY29uc3Qgc3RydWN0IHZk
cGFfbWdtdF9kZXYgKm1kZXYsCj4gICAJCQkJIGNvbnN0IGNoYXIgKmJ1c25hbWUsIGNvbnN0IGNo
YXIgKmRldm5hbWUpCj4gICB7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIv
ZHJpdmVycy92aG9zdC92ZHBhLmMKPiBpbmRleCAzOTAzOWUwNDYxMTcuLjAxYzU5Y2U3ZTI1MCAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3Qv
dmRwYS5jCj4gQEAgLTIzNyw3ICsyMzcsNiBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3NldF9j
b25maWcoc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4gICAJCQkJICBzdHJ1Y3Qgdmhvc3RfdmRwYV9j
b25maWcgX191c2VyICpjKQo+ICAgewo+ICAgCXN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYt
PnZkcGE7Cj4gLQljb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2ZHBhLT5jb25m
aWc7Cj4gICAJc3RydWN0IHZob3N0X3ZkcGFfY29uZmlnIGNvbmZpZzsKPiAgIAl1bnNpZ25lZCBs
b25nIHNpemUgPSBvZmZzZXRvZihzdHJ1Y3Qgdmhvc3RfdmRwYV9jb25maWcsIGJ1Zik7Cj4gICAJ
dTggKmJ1ZjsKPiBAQCAtMjUxLDcgKzI1MCw3IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfc2V0
X2NvbmZpZyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPiAgIAlpZiAoSVNfRVJSKGJ1ZikpCj4gICAJ
CXJldHVybiBQVFJfRVJSKGJ1Zik7Cj4gICAKPiAtCW9wcy0+c2V0X2NvbmZpZyh2ZHBhLCBjb25m
aWcub2ZmLCBidWYsIGNvbmZpZy5sZW4pOwo+ICsJdmRwYV9zZXRfY29uZmlnKHZkcGEsIGNvbmZp
Zy5vZmYsIGJ1ZiwgY29uZmlnLmxlbik7Cj4gICAKPiAgIAlrdmZyZWUoYnVmKTsKPiAgIAlyZXR1
cm4gMDsKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92ZHBhLmggYi9pbmNsdWRlL2xpbnV4
L3ZkcGEuaAo+IGluZGV4IDM5NzJhYjc2NWRlMS4uNzgzOTUzMzFhMTY2IDEwMDY0NAo+IC0tLSBh
L2luY2x1ZGUvbGludXgvdmRwYS5oCj4gKysrIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPiBAQCAt
MzgyLDIxICszODIsMTAgQEAgc3RhdGljIGlubGluZSBpbnQgdmRwYV9zZXRfZmVhdHVyZXMoc3Ry
dWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1NjQgZmVhdHVyZXMpCj4gICAJcmV0dXJuIG9wcy0+c2V0
X2ZlYXR1cmVzKHZkZXYsIGZlYXR1cmVzKTsKPiAgIH0KPiAgIAo+IC1zdGF0aWMgaW5saW5lIHZv
aWQgdmRwYV9nZXRfY29uZmlnKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwKPiAtCQkJCSAgIHVu
c2lnbmVkIGludCBvZmZzZXQsIHZvaWQgKmJ1ZiwKPiAtCQkJCSAgIHVuc2lnbmVkIGludCBsZW4p
Cj4gLXsKPiAtCWNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkZXYtPmNvbmZp
ZzsKPiAtCj4gLQkvKgo+IC0JICogQ29uZmlnIGFjY2Vzc2VzIGFyZW4ndCBzdXBwb3NlZCB0byB0
cmlnZ2VyIGJlZm9yZSBmZWF0dXJlcyBhcmUgc2V0Lgo+IC0JICogSWYgaXQgZG9lcyBoYXBwZW4g
d2UgYXNzdW1lIGEgbGVnYWN5IGd1ZXN0Lgo+IC0JICovCj4gLQlpZiAoIXZkZXYtPmZlYXR1cmVz
X3ZhbGlkKQo+IC0JCXZkcGFfc2V0X2ZlYXR1cmVzKHZkZXYsIDApOwo+IC0Jb3BzLT5nZXRfY29u
ZmlnKHZkZXYsIG9mZnNldCwgYnVmLCBsZW4pOwo+IC19Cj4gLQo+ICt2b2lkIHZkcGFfZ2V0X2Nv
bmZpZyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGludCBvZmZzZXQsCj4gKwkJ
ICAgICB2b2lkICpidWYsIHVuc2lnbmVkIGludCBsZW4pOwo+ICt2b2lkIHZkcGFfc2V0X2NvbmZp
ZyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IG9mZnNldCwKPiArCQkgICAg
IHZvaWQgKmJ1ZiwgdW5zaWduZWQgaW50IGxlbmd0aCk7Cj4gICAvKioKPiAgICAqIHN0cnVjdCB2
ZHBhX21nbXRkZXZfb3BzIC0gdmRwYSBkZXZpY2Ugb3BzCj4gICAgKiBAZGV2X2FkZDogQWRkIGEg
dmRwYSBkZXZpY2UgdXNpbmcgYWxsb2MgYW5kIHJlZ2lzdGVyCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
