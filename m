Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7054DC678D5
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 05:20:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED0B460FE0;
	Wed,  8 Mar 2023 05:20:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ED0B460FE0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YQCUM6z6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fp74PXm6ddPL; Wed,  8 Mar 2023 05:20:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 36B7A60EAA;
	Wed,  8 Mar 2023 05:20:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 36B7A60EAA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F2A7C0035;
	Wed,  8 Mar 2023 05:20:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42C8BC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 05:20:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 10DD740B87
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 05:20:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 10DD740B87
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YQCUM6z6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dkp68zTYYXzb
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 05:20:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3D85F400B9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3D85F400B9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 05:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678252846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wa4+P9X3U2iWquKABTxg91kwsSVZQMAhZf+vdvnCUmk=;
 b=YQCUM6z6FD+oOVoALYvqDVXWLnoiB+ZOvXCpTF3QM29dqAfmgefJ5DXYwk43lO4eyXSDBU
 Qa+0GUbabdJaetaFE1bEbKkiPBeGhYpgabGviyxQZ83y2AiuWXw70rlmPV78J7SIN9TGoa
 epbPmZCUqZqSAE9sPOIZbWJfzWxFVWc=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-k6hfUQQsO6ijdj5Z_8RdoA-1; Wed, 08 Mar 2023 00:20:45 -0500
X-MC-Unique: k6hfUQQsO6ijdj5Z_8RdoA-1
Received: by mail-ot1-f69.google.com with SMTP id
 d28-20020a056830045c00b006942409f1d4so6813350otc.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Mar 2023 21:20:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678252844;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wa4+P9X3U2iWquKABTxg91kwsSVZQMAhZf+vdvnCUmk=;
 b=CL9OokNfBMC5l8XCOtiu7mqXlLhawTLp7dndmAQ5ZiyfZq6i6p+JnC4amZuIezySYZ
 jdiuskLxuUM+UXR0CsasC5EXG/z77IVPoBNzxiL821UtObyRb4DcsRmLkKfby0Mpy2rR
 lB20F6ooq0x+y3Abde8S6DK3A4DoEhSlYdgju7gnKQOA+h0DdI21Bp3a3TLbHsXjI/OW
 rPRh9hEELufq2qt+EsttJjYJLdODTmFevaFS1C+IxI969dQmmtfOnFl8U7z9CUfhy6zL
 U5H0XcX+auRbO5iJO2+bMsxWOeLAZpkaybl7/9qbOsxNsg0Dekj0jZG4qVweA8mQYeq7
 frsg==
X-Gm-Message-State: AO0yUKUFtpvlGw7fSgkPnFJsX69Jfnw4so/GRW2SwMIeCAslTQwbMBCQ
 0QcjRmZz02cl0DgiL8rEu8wLmmXIZOXW23WOl17Zf2P++SQPnggM+GpGqwBWCwyO+AVkY7tLi6a
 2IsvOyh6ApCNCwtmSZwDvMwlSplp2NpAsqkkRZg5xmSDJ+Y+NWgtgTrllHBw42xRSOpvs
X-Received: by 2002:a05:6808:1d5:b0:384:c4a:1b49 with SMTP id
 x21-20020a05680801d500b003840c4a1b49mr5072638oic.9.1678252844128; 
 Tue, 07 Mar 2023 21:20:44 -0800 (PST)
X-Google-Smtp-Source: AK7set/OLYMsO2LNrrSBawUARTPqeRe7hILOydRzI5q0j+Df/L45Q8nqe9tX40F1cAWlz5w5JcJrobFOqZABZHRdRqs=
X-Received: by 2002:a05:6808:1d5:b0:384:c4a:1b49 with SMTP id
 x21-20020a05680801d500b003840c4a1b49mr5072619oic.9.1678252843934; Tue, 07 Mar
 2023 21:20:43 -0800 (PST)
MIME-Version: 1.0
References: <20230308024935.91686-1-xuanzhuo@linux.alibaba.com>
 <20230308024935.91686-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230308024935.91686-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Mar 2023 13:20:32 +0800
Message-ID: <CACGkMEvePWxKR2=mkYLG5-22HD9WtM8Ew4z4pQtw1p-Ri6miQw@mail.gmail.com>
Subject: Re: [PATCH net, stable v1 2/3] virtio_net: separate the logic of
 checking whether sq is full
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Yichun Zhang <yichun@openresty.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
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

T24gV2VkLCBNYXIgOCwgMjAyMyBhdCAxMDo0OeKAr0FNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gU2VwYXJhdGUgdGhlIGxvZ2ljIG9mIGNoZWNraW5n
IHdoZXRoZXIgc3EgaXMgZnVsbC4gVGhlIHN1YnNlcXVlbnQgcGF0Y2gKPiB3aWxsIHJldXNlIHRo
aXMgZnVuYy4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxp
YmFiYS5jb20+Cj4gUmV2aWV3ZWQtYnk6IEFsZXhhbmRlciBEdXljayA8YWxleGFuZGVyZHV5Y2tA
ZmIuY29tPgo+IEFja2VkLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgoK
QWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCj4gLS0t
Cj4gIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDYwICsrKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyksIDI0
IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBi
L2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IGluZGV4IDhiMzFhMDQwNTJmMi4uNDZiYmRkYWFk
YjBkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ICsrKyBiL2RyaXZl
cnMvbmV0L3ZpcnRpb19uZXQuYwo+IEBAIC01OTEsNiArNTkxLDQxIEBAIHN0YXRpYyBib29sIGlz
X3hkcF9yYXdfYnVmZmVyX3F1ZXVlKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLCBpbnQgcSkKPiAg
ICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwo+ICB9Cj4KPiArc3RhdGljIHZvaWQgY2hlY2tf
c3FfZnVsbF9hbmRfZGlzYWJsZShzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgc2VuZF9xdWV1ZSAqc3Ep
Cj4gK3sKPiArICAgICAgIGJvb2wgdXNlX25hcGkgPSBzcS0+bmFwaS53ZWlnaHQ7Cj4gKyAgICAg
ICBpbnQgcW51bTsKPiArCj4gKyAgICAgICBxbnVtID0gc3EgLSB2aS0+c3E7Cj4gKwo+ICsgICAg
ICAgLyogSWYgcnVubmluZyBvdXQgb2Ygc3BhY2UsIHN0b3AgcXVldWUgdG8gYXZvaWQgZ2V0dGlu
ZyBwYWNrZXRzIHRoYXQgd2UKPiArICAgICAgICAqIGFyZSB0aGVuIHVuYWJsZSB0byB0cmFuc21p
dC4KPiArICAgICAgICAqIEFuIGFsdGVybmF0aXZlIHdvdWxkIGJlIHRvIGZvcmNlIHF1ZXVpbmcg
bGF5ZXIgdG8gcmVxdWV1ZSB0aGUgc2tiIGJ5Cj4gKyAgICAgICAgKiByZXR1cm5pbmcgTkVUREVW
X1RYX0JVU1kuIEhvd2V2ZXIsIE5FVERFVl9UWF9CVVNZIHNob3VsZCBub3QgYmUKPiArICAgICAg
ICAqIHJldHVybmVkIGluIGEgbm9ybWFsIHBhdGggb2Ygb3BlcmF0aW9uOiBpdCBtZWFucyB0aGF0
IGRyaXZlciBpcyBub3QKPiArICAgICAgICAqIG1haW50YWluaW5nIHRoZSBUWCBxdWV1ZSBzdG9w
L3N0YXJ0IHN0YXRlIHByb3Blcmx5LCBhbmQgY2F1c2VzCj4gKyAgICAgICAgKiB0aGUgc3RhY2sg
dG8gZG8gYSBub24tdHJpdmlhbCBhbW91bnQgb2YgdXNlbGVzcyB3b3JrLgo+ICsgICAgICAgICog
U2luY2UgbW9zdCBwYWNrZXRzIG9ubHkgdGFrZSAxIG9yIDIgcmluZyBzbG90cywgc3RvcHBpbmcg
dGhlIHF1ZXVlCj4gKyAgICAgICAgKiBlYXJseSBtZWFucyAxNiBzbG90cyBhcmUgdHlwaWNhbGx5
IHdhc3RlZC4KPiArICAgICAgICAqLwo+ICsgICAgICAgaWYgKHNxLT52cS0+bnVtX2ZyZWUgPCAy
K01BWF9TS0JfRlJBR1MpIHsKPiArICAgICAgICAgICAgICAgbmV0aWZfc3RvcF9zdWJxdWV1ZShk
ZXYsIHFudW0pOwo+ICsgICAgICAgICAgICAgICBpZiAodXNlX25hcGkpIHsKPiArICAgICAgICAg
ICAgICAgICAgICAgICBpZiAodW5saWtlbHkoIXZpcnRxdWV1ZV9lbmFibGVfY2JfZGVsYXllZChz
cS0+dnEpKSkKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZpcnRxdWV1ZV9uYXBp
X3NjaGVkdWxlKCZzcS0+bmFwaSwgc3EtPnZxKTsKPiArICAgICAgICAgICAgICAgfSBlbHNlIGlm
ICh1bmxpa2VseSghdmlydHF1ZXVlX2VuYWJsZV9jYl9kZWxheWVkKHNxLT52cSkpKSB7Cj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgLyogTW9yZSBqdXN0IGdvdCB1c2VkLCBmcmVlIHRoZW0gdGhl
biByZWNoZWNrLiAqLwo+ICsgICAgICAgICAgICAgICAgICAgICAgIGZyZWVfb2xkX3htaXRfc2ti
cyhzcSwgZmFsc2UpOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChzcS0+dnEtPm51bV9m
cmVlID49IDIrTUFYX1NLQl9GUkFHUykgewo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgbmV0aWZfc3RhcnRfc3VicXVldWUoZGV2LCBxbnVtKTsKPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHZpcnRxdWV1ZV9kaXNhYmxlX2NiKHNxLT52cSk7Cj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgfQo+ICsgICAgICAgICAgICAgICB9Cj4gKyAgICAgICB9Cj4gK30KPiArCj4g
IHN0YXRpYyBpbnQgX192aXJ0bmV0X3hkcF94bWl0X29uZShzdHJ1Y3QgdmlydG5ldF9pbmZvICp2
aSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBzZW5kX3F1ZXVl
ICpzcSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB4ZHBfZnJh
bWUgKnhkcGYpCj4gQEAgLTE5ODksMzAgKzIwMjQsNyBAQCBzdGF0aWMgbmV0ZGV2X3R4X3Qgc3Rh
cnRfeG1pdChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQo+ICAg
ICAgICAgICAgICAgICBuZl9yZXNldF9jdChza2IpOwo+ICAgICAgICAgfQo+Cj4gLSAgICAgICAv
KiBJZiBydW5uaW5nIG91dCBvZiBzcGFjZSwgc3RvcCBxdWV1ZSB0byBhdm9pZCBnZXR0aW5nIHBh
Y2tldHMgdGhhdCB3ZQo+IC0gICAgICAgICogYXJlIHRoZW4gdW5hYmxlIHRvIHRyYW5zbWl0Lgo+
IC0gICAgICAgICogQW4gYWx0ZXJuYXRpdmUgd291bGQgYmUgdG8gZm9yY2UgcXVldWluZyBsYXll
ciB0byByZXF1ZXVlIHRoZSBza2IgYnkKPiAtICAgICAgICAqIHJldHVybmluZyBORVRERVZfVFhf
QlVTWS4gSG93ZXZlciwgTkVUREVWX1RYX0JVU1kgc2hvdWxkIG5vdCBiZQo+IC0gICAgICAgICog
cmV0dXJuZWQgaW4gYSBub3JtYWwgcGF0aCBvZiBvcGVyYXRpb246IGl0IG1lYW5zIHRoYXQgZHJp
dmVyIGlzIG5vdAo+IC0gICAgICAgICogbWFpbnRhaW5pbmcgdGhlIFRYIHF1ZXVlIHN0b3Avc3Rh
cnQgc3RhdGUgcHJvcGVybHksIGFuZCBjYXVzZXMKPiAtICAgICAgICAqIHRoZSBzdGFjayB0byBk
byBhIG5vbi10cml2aWFsIGFtb3VudCBvZiB1c2VsZXNzIHdvcmsuCj4gLSAgICAgICAgKiBTaW5j
ZSBtb3N0IHBhY2tldHMgb25seSB0YWtlIDEgb3IgMiByaW5nIHNsb3RzLCBzdG9wcGluZyB0aGUg
cXVldWUKPiAtICAgICAgICAqIGVhcmx5IG1lYW5zIDE2IHNsb3RzIGFyZSB0eXBpY2FsbHkgd2Fz
dGVkLgo+IC0gICAgICAgICovCj4gLSAgICAgICBpZiAoc3EtPnZxLT5udW1fZnJlZSA8IDIrTUFY
X1NLQl9GUkFHUykgewo+IC0gICAgICAgICAgICAgICBuZXRpZl9zdG9wX3N1YnF1ZXVlKGRldiwg
cW51bSk7Cj4gLSAgICAgICAgICAgICAgIGlmICh1c2VfbmFwaSkgewo+IC0gICAgICAgICAgICAg
ICAgICAgICAgIGlmICh1bmxpa2VseSghdmlydHF1ZXVlX2VuYWJsZV9jYl9kZWxheWVkKHNxLT52
cSkpKQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmlydHF1ZXVlX25hcGlfc2No
ZWR1bGUoJnNxLT5uYXBpLCBzcS0+dnEpOwo+IC0gICAgICAgICAgICAgICB9IGVsc2UgaWYgKHVu
bGlrZWx5KCF2aXJ0cXVldWVfZW5hYmxlX2NiX2RlbGF5ZWQoc3EtPnZxKSkpIHsKPiAtICAgICAg
ICAgICAgICAgICAgICAgICAvKiBNb3JlIGp1c3QgZ290IHVzZWQsIGZyZWUgdGhlbSB0aGVuIHJl
Y2hlY2suICovCj4gLSAgICAgICAgICAgICAgICAgICAgICAgZnJlZV9vbGRfeG1pdF9za2JzKHNx
LCBmYWxzZSk7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgaWYgKHNxLT52cS0+bnVtX2ZyZWUg
Pj0gMitNQVhfU0tCX0ZSQUdTKSB7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBu
ZXRpZl9zdGFydF9zdWJxdWV1ZShkZXYsIHFudW0pOwo+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdmlydHF1ZXVlX2Rpc2FibGVfY2Ioc3EtPnZxKTsKPiAtICAgICAgICAgICAgICAg
ICAgICAgICB9Cj4gLSAgICAgICAgICAgICAgIH0KPiAtICAgICAgIH0KPiArICAgICAgIGNoZWNr
X3NxX2Z1bGxfYW5kX2Rpc2FibGUodmksIGRldiwgc3EpOwo+Cj4gICAgICAgICBpZiAoa2ljayB8
fCBuZXRpZl94bWl0X3N0b3BwZWQodHhxKSkgewo+ICAgICAgICAgICAgICAgICBpZiAodmlydHF1
ZXVlX2tpY2tfcHJlcGFyZShzcS0+dnEpICYmIHZpcnRxdWV1ZV9ub3RpZnkoc3EtPnZxKSkgewo+
IC0tCj4gMi4zMi4wLjMuZzAxMTk1Y2Y5Zgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
