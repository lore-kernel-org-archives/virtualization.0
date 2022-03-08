Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA420C433EF
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 08:08:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 768C241688;
	Tue,  8 Mar 2022 08:08:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e7sGxILgnSyQ; Tue,  8 Mar 2022 08:08:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 60B8D41681;
	Tue,  8 Mar 2022 08:08:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CD9AC001D;
	Tue,  8 Mar 2022 08:08:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B7EAC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 08:08:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1A153408ED
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 08:08:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3W4dJs_ntEzk
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 08:08:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B9921408EA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 08:08:30 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id x15so27089006wru.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 00:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=w2kpbDHbmA0uZN+CsMThxfqb9nbhJ8u8Feprw4xNVCo=;
 b=H2fvfqR+I6VM2Kk9IJYxRI4A6ijk4Qn7lQFH2W2PR+olehv6klS+VeDxePKtFAVv7S
 8ygNpmOvYIXEw1Jkyy3vf1JJnxERuP+XaHmS1D4zxXtN2EdyDs7ra39Jt13vr/RQNfP8
 fHCRtN0Qudi90mb33HhTUycYmfmsCLq+k+OPt/4IbfQvQfL/Z/f2gIPMksMlUZLRgkD8
 DU4VmMObglStBQIyHpInbQRCEWzwYPwePXiQ0+mePYzxV2j3z475Kofkfj5CBFw6AG0O
 9pvZkuyTRM9guHFOE+Omp3Pxm3rFlyC8wW4M9fzHgQqGa08mdIaUWy/nC7uUgSRFuYZk
 XCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=w2kpbDHbmA0uZN+CsMThxfqb9nbhJ8u8Feprw4xNVCo=;
 b=DS5TIGGCmaB99i9EON8L0qe09nMCercgbUCD2LF94HDEC5yqeJNhVYVNjjvT+l/g2T
 1vOTPUNzH8nImhUotfJUOkLbAt/MMic6rDBmOlZYWKCAXFCcsFYkarqbcJU3miHijFHw
 ZUt3eBLKm8z7xiLlltRiLcwKZplUoZaboygVLxeOLLUR3k4H+eAqGPHdS7KB6JpfLrCS
 5mNCXjPrnuYhW0Lpm1LBFxSG/i2ixh9CwOn2UGGlzRIfFqoYtGaaLN/KgIw6maUCSf2A
 mmD5TY4mjh3DGeSTbNBhxxO5r+mLUWfgU6JFOE73x8lcVRG2+YaQJT00rq0t/3+nhgBR
 4O5w==
X-Gm-Message-State: AOAM533wbRHuO31JmJp/gY0wbjUQOE3kAGKm6/v27qvn0xI8LlpjI5CQ
 RmA6oeqPcH7TmRtHxNuk6XG3Hw==
X-Google-Smtp-Source: ABdhPJzxQ/wNPlE0Op8r9v7pQTLfIf/oRM+ZegzSmvEtfz5rbvQrhtQyNtGfUsLEaBrywseYTM9mjA==
X-Received: by 2002:adf:fd50:0:b0:1f0:7a8e:c922 with SMTP id
 h16-20020adffd50000000b001f07a8ec922mr11353776wrs.166.1646726908942; 
 Tue, 08 Mar 2022 00:08:28 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net.
 [86.27.177.88]) by smtp.gmail.com with ESMTPSA id
 m18-20020a05600c3b1200b003899d242c3asm1461077wms.44.2022.03.08.00.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Mar 2022 00:08:28 -0800 (PST)
Date: Tue, 8 Mar 2022 08:08:25 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <YicO+aF4VhaBYNqK@google.com>
References: <20220307191757.3177139-1-lee.jones@linaro.org>
 <CACGkMEsjmCNQPjxPjXL0WUfbMg8ARnumEp4yjUxqznMKR1nKSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACGkMEsjmCNQPjxPjXL0WUfbMg8ARnumEp4yjUxqznMKR1nKSQ@mail.gmail.com>
Cc: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com,
 kvm <kvm@vger.kernel.org>, mst <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org,
 virtualization <virtualization@lists.linux-foundation.org>
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

T24gVHVlLCAwOCBNYXIgMjAyMiwgSmFzb24gV2FuZyB3cm90ZToKCj4gT24gVHVlLCBNYXIgOCwg
MjAyMiBhdCAzOjE4IEFNIExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+IHdyb3RlOgo+
ID4KPiA+IHZob3N0X3Zzb2NrX2hhbmRsZV90eF9raWNrKCkgYWxyZWFkeSBob2xkcyB0aGUgbXV0
ZXggZHVyaW5nIGl0cyBjYWxsCj4gPiB0byB2aG9zdF9nZXRfdnFfZGVzYygpLiAgQWxsIHdlIGhh
dmUgdG8gZG8gaGVyZSBpcyB0YWtlIHRoZSBzYW1lIGxvY2sKPiA+IGR1cmluZyB2aXJ0cXVldWUg
Y2xlYW4tdXAgYW5kIHdlIG1pdGlnYXRlIHRoZSByZXBvcnRlZCBpc3N1ZXMuCj4gPgo+ID4gQWxz
byBXQVJOKCkgYXMgYSBwcmVjYXV0aW9uYXJ5IG1lYXN1cmUuICBUaGUgcHVycG9zZSBvZiB0aGlz
IGlzIHRvCj4gPiBjYXB0dXJlIHBvc3NpYmxlIGZ1dHVyZSByYWNlIGNvbmRpdGlvbnMgd2hpY2gg
bWF5IHBvcCB1cCBvdmVyIHRpbWUuCj4gPgo+ID4gTGluazogaHR0cHM6Ly9zeXprYWxsZXIuYXBw
c3BvdC5jb20vYnVnP2V4dGlkPTI3OTQzMmQzMGQ4MjVlNjNiYTAwCj4gPgo+ID4gQ2M6IDxzdGFi
bGVAdmdlci5rZXJuZWwub3JnPgo+ID4gUmVwb3J0ZWQtYnk6IHN5emJvdCthZGMzY2IzMjM4NTU4
NmJlYzg1OUBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tCj4gPiBTaWduZWQtb2ZmLWJ5OiBMZWUg
Sm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgo+ID4gLS0tCj4gPiAgZHJpdmVycy92aG9zdC92
aG9zdC5jIHwgMTAgKysrKysrKysrKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25z
KCspCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYyBiL2RyaXZlcnMv
dmhvc3Qvdmhvc3QuYwo+ID4gaW5kZXggNTllZGI1YTFmZmUyOC4uZWY3ZTM3MWUzZTY0OSAxMDA2
NDQKPiA+IC0tLSBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+ID4gKysrIGIvZHJpdmVycy92aG9z
dC92aG9zdC5jCj4gPiBAQCAtNjkzLDYgKzY5MywxNSBAQCB2b2lkIHZob3N0X2Rldl9jbGVhbnVw
KHN0cnVjdCB2aG9zdF9kZXYgKmRldikKPiA+ICAgICAgICAgaW50IGk7Cj4gPgo+ID4gICAgICAg
ICBmb3IgKGkgPSAwOyBpIDwgZGV2LT5udnFzOyArK2kpIHsKPiA+ICsgICAgICAgICAgICAgICAv
KiBObyB3b3JrZXJzIHNob3VsZCBydW4gaGVyZSBieSBkZXNpZ24uIEhvd2V2ZXIsIHJhY2VzIGhh
dmUKPiA+ICsgICAgICAgICAgICAgICAgKiBwcmV2aW91c2x5IG9jY3VycmVkIHdoZXJlIGRyaXZl
cnMgaGF2ZSBiZWVuIHVuYWJsZSB0byBmbHVzaAo+ID4gKyAgICAgICAgICAgICAgICAqIGFsbCB3
b3JrIHByb3Blcmx5IHByaW9yIHRvIGNsZWFuLXVwLiAgV2l0aG91dCBhIHN1Y2Nlc3NmdWwKPiA+
ICsgICAgICAgICAgICAgICAgKiBmbHVzaCB0aGUgZ3Vlc3Qgd2lsbCBtYWxmdW5jdGlvbiwgYnV0
IGF2b2lkaW5nIGhvc3QgbWVtb3J5Cj4gPiArICAgICAgICAgICAgICAgICogY29ycnVwdGlvbiBp
biB0aG9zZSBjYXNlcyBkb2VzIHNlZW0gcHJlZmVyYWJsZS4KPiA+ICsgICAgICAgICAgICAgICAg
Ki8KPiA+ICsgICAgICAgICAgICAgICBXQVJOX09OKG11dGV4X2lzX2xvY2tlZCgmZGV2LT52cXNb
aV0tPm11dGV4KSk7Cj4gPiArCj4gCj4gSSBkb24ndCBnZXQgaG93IHRoaXMgY2FuIGhlbHAsIHRo
ZSBtdXRleCBjb3VsZCBiZSBncmFiYmVkIGluIHRoZQo+IG1pZGRsZSBvZiB0aGUgYWJvdmUgYW5k
IGJlbG93IGxpbmUuCgpUaGUgd29yc3QgdGhhdCBoYXBwZW5zIGluIHRoaXMgc2xpbSBzY2VuYXJp
byBpcyB3ZSBtaXNzIGEgd2FybmluZy4KVGhlIG11dGV4ZXMgYmVsb3cgd2lsbCBzdGlsbCBmdW5j
dGlvbiBhcyBleHBlY3RlZCBhbmQgcHJldmVudCBwb3NzaWJsZQptZW1vcnkgY29ycnVwdGlvbi4K
Cj4gPiArICAgICAgICAgICAgICAgbXV0ZXhfbG9jaygmZGV2LT52cXNbaV0tPm11dGV4KTsKPiA+
ICAgICAgICAgICAgICAgICBpZiAoZGV2LT52cXNbaV0tPmVycm9yX2N0eCkKPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgIGV2ZW50ZmRfY3R4X3B1dChkZXYtPnZxc1tpXS0+ZXJyb3JfY3R4KTsK
PiA+ICAgICAgICAgICAgICAgICBpZiAoZGV2LT52cXNbaV0tPmtpY2spCj4gPiBAQCAtNzAwLDYg
KzcwOSw3IEBAIHZvaWQgdmhvc3RfZGV2X2NsZWFudXAoc3RydWN0IHZob3N0X2RldiAqZGV2KQo+
ID4gICAgICAgICAgICAgICAgIGlmIChkZXYtPnZxc1tpXS0+Y2FsbF9jdHguY3R4KQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgZXZlbnRmZF9jdHhfcHV0KGRldi0+dnFzW2ldLT5jYWxsX2N0
eC5jdHgpOwo+ID4gICAgICAgICAgICAgICAgIHZob3N0X3ZxX3Jlc2V0KGRldiwgZGV2LT52cXNb
aV0pOwo+ID4gKyAgICAgICAgICAgICAgIG11dGV4X3VubG9jaygmZGV2LT52cXNbaV0tPm11dGV4
KTsKPiA+ICAgICAgICAgfQo+IAo+IEknbSBub3Qgc3VyZSBpdCdzIGNvcnJlY3QgdG8gYXNzdW1l
IHNvbWUgYmVoYXZpb3VyIG9mIGEgYnVnZ3kgZGV2aWNlLgo+IEZvciB0aGUgZGV2aWNlIG11dGV4
LCB3ZSB1c2UgdGhhdCB0byBwcm90ZWN0IG1vcmUgdGhhbiBqdXN0IGVyci9jYWxsCj4gYW5kIHZx
LgoKV2hlbiBJIGF1dGhvcmVkIHRoaXMsIEkgZGlkIHNvIGFzICp0aGUqIGZpeC4gIEhvd2V2ZXIs
IHNpbmNlIHRoZSBjYXVzZQpvZiB0b2RheSdzIGNyYXNoIGhhcyBub3cgYmVlbiBwYXRjaGVkLCB0
aGlzIGhhcyBiZWNvbWUgYSBiZWx0IGFuZApicmFjZXMgc29sdXRpb24uICBNaWNoYWVsJ3MgYWRk
aXRpb24gb2YgdGhlIFdBUk4oKSBhbHNvIGhhcyB0aGUKYmVuZWZpdCBvZiBwcm92aWRpbmcgdXMg
d2l0aCBhbiBlYXJseSB3YXJuaW5nIHN5c3RlbSBmb3IgZnV0dXJlCmJyZWFrYWdlcy4gIFBlcnNv
bmFsbHksIEkgdGhpbmsgaXQncyBraW5kYSBuZWF0LgoKLS0gCkxlZSBKb25lcyBb5p2O55C85pav
XQpQcmluY2lwYWwgVGVjaG5pY2FsIExlYWQgLSBEZXZlbG9wZXIgU2VydmljZXMKTGluYXJvLm9y
ZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFybSBTb0NzCkZvbGxvdyBMaW5hcm86IEZh
Y2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
