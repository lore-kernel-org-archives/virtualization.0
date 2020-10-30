Return-Path: <SRS0=7x/u=EF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D00C61DD8
	for <virtualization@archiver.kernel.org>; Fri, 30 Oct 2020 10:02:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 472F820727
	for <virtualization@archiver.kernel.org>; Fri, 30 Oct 2020 10:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DifxDmPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472F820727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 760038680B;
	Fri, 30 Oct 2020 10:02:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YzTmbWyQeNzw; Fri, 30 Oct 2020 10:02:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8BCE186403;
	Fri, 30 Oct 2020 10:02:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 724E8C0859;
	Fri, 30 Oct 2020 10:02:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8B15C0859
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 10:02:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B798187343
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 10:02:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 740eFk2UWdMV
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 10:02:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CEE51872F3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 10:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604052152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vu4Swj5ZddyZ5LlCNkDJhXHFRPfGcHPYwnlBLFF6NdI=;
 b=DifxDmPZHJut5xU6zinPBd6uto8qENjep7gqFPS0+S0ZN5suKivR6s6osTbDEcDM8iNdUo
 g0HpzIgaO9Cm6RbSReROdOrIJz6QC1++yZyKzwkFjrvYTcqus7vTeSCyUeNw5EqgEhSc2N
 7rciaWhEu7XghRjDOLO1iXEdQIeBbBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-HAqy5cglN9SlsxddpB3cEQ-1; Fri, 30 Oct 2020 06:02:29 -0400
X-MC-Unique: HAqy5cglN9SlsxddpB3cEQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42B53803620;
 Fri, 30 Oct 2020 10:02:28 +0000 (UTC)
Received: from [10.72.12.248] (ovpn-12-248.pek2.redhat.com [10.72.12.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E34325B4A1;
 Fri, 30 Oct 2020 10:02:19 +0000 (UTC)
Subject: Re: [PATCH] vhost/vsock: add IOTLB API support
To: Stefano Garzarella <sgarzare@redhat.com>, mst@redhat.com
References: <20201029174351.134173-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <751cc074-ae68-72c8-71de-a42458058761@redhat.com>
Date: Fri, 30 Oct 2020 18:02:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029174351.134173-1-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIwMjAvMTAvMzAg5LiK5Y2IMTo0MywgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IFRo
aXMgcGF0Y2ggZW5hYmxlcyB0aGUgSU9UTEIgQVBJIHN1cHBvcnQgZm9yIHZob3N0LXZzb2NrIGRl
dmljZXMsCj4gYWxsb3dpbmcgdGhlIHVzZXJzcGFjZSB0byBlbXVsYXRlIGFuIElPTU1VIGZvciB0
aGUgZ3Vlc3QuCj4KPiBUaGVzZSBjaGFuZ2VzIHdlcmUgbWFkZSBmb2xsb3dpbmcgdmhvc3QtbmV0
LCBpbiBkZXRhaWxzIHRoaXMgcGF0Y2g6Cj4gLSBleHBvc2VzIFZJUlRJT19GX0FDQ0VTU19QTEFU
Rk9STSBmZWF0dXJlIGFuZCBpbml0cyB0aGUgaW90bGIKPiAgICBkZXZpY2UgaWYgdGhlIGZlYXR1
cmUgaXMgYWNrZWQKPiAtIGltcGxlbWVudHMgVkhPU1RfR0VUX0JBQ0tFTkRfRkVBVFVSRVMgYW5k
Cj4gICAgVkhPU1RfU0VUX0JBQ0tFTkRfRkVBVFVSRVMgaW9jdGxzCj4gLSBjYWxscyB2cV9tZXRh
X3ByZWZldGNoKCkgYmVmb3JlIHZxIHByb2Nlc3NpbmcgdG8gcHJlZmV0Y2ggdnEKPiAgICBtZXRh
ZGF0YSBhZGRyZXNzIGluIElPVExCCj4gLSBwcm92aWRlcyAucmVhZF9pdGVyLCAud3JpdGVfaXRl
ciwgYW5kIC5wb2xsIGNhbGxiYWNrcyBmb3IgdGhlCj4gICAgY2hhcmRldjsgdGhleSBhcmUgdXNl
ZCBieSB0aGUgdXNlcnNwYWNlIHRvIGV4Y2hhbmdlIElPVExCIG1lc3NhZ2VzCj4KPiBUaGlzIHBh
dGNoIHdhcyB0ZXN0ZWQgd2l0aCBRRU1VIGFuZCBhIHBhdGNoIGFwcGxpZWQgWzFdIHRvIGZpeCBh
Cj4gc2ltcGxlIGlzc3VlOgo+ICAgICAgJCBxZW11IC1NIHEzNSxhY2NlbD1rdm0sa2VybmVsLWly
cWNoaXA9c3BsaXQgXAo+ICAgICAgICAgICAgIC1kcml2ZSBmaWxlPWZlZG9yYS5xY293Mixmb3Jt
YXQ9cWNvdzIsaWY9dmlydGlvIFwKPiAgICAgICAgICAgICAtZGV2aWNlIGludGVsLWlvbW11LGlu
dHJlbWFwPW9uIFwKPiAgICAgICAgICAgICAtZGV2aWNlIHZob3N0LXZzb2NrLXBjaSxndWVzdC1j
aWQ9Myxpb21tdV9wbGF0Zm9ybT1vbgoKClBhdGNoIGxvb2tzIGdvb2QsIGJ1dCBhIHF1ZXN0aW9u
OgoKSXQgbG9va3MgdG8gbWUgeW91IGRvbid0IGVuYWJsZSBBVFMgd2hpY2ggbWVhbnMgdmhvc3Qg
d29uJ3QgZ2V0IGFueSAKaW52YWxpZGF0aW9uIHJlcXVlc3Qgb3IgZGlkIEkgbWlzcyBhbnl0aGlu
Zz8KClRoYW5rcwoKCj4KPiBbMV0gaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9x
ZW11LWRldmVsLzIwMjAtMTAvbXNnMDkwNzcuaHRtbAo+Cj4gU2lnbmVkLW9mZi1ieTogU3RlZmFu
byBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92aG9z
dC92c29jay5jIHwgNjggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LQo+ICAgMSBmaWxlIGNoYW5nZWQsIDY1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92c29jay5jIGIvZHJpdmVycy92aG9zdC92c29j
ay5jCj4gaW5kZXggYTQ4M2NlYzMxZDVjLi41ZTc4ZmI3MTk2MDIgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy92aG9zdC92c29jay5jCj4gKysrIGIvZHJpdmVycy92aG9zdC92c29jay5jCj4gQEAgLTMw
LDcgKzMwLDEyIEBACj4gICAjZGVmaW5lIFZIT1NUX1ZTT0NLX1BLVF9XRUlHSFQgMjU2Cj4gICAK
PiAgIGVudW0gewo+IC0JVkhPU1RfVlNPQ0tfRkVBVFVSRVMgPSBWSE9TVF9GRUFUVVJFUywKPiAr
CVZIT1NUX1ZTT0NLX0ZFQVRVUkVTID0gVkhPU1RfRkVBVFVSRVMgfAo+ICsJCQkgICAgICAgKDFV
TEwgPDwgVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNKQo+ICt9Owo+ICsKPiArZW51bSB7Cj4gKwlW
SE9TVF9WU09DS19CQUNLRU5EX0ZFQVRVUkVTID0gKDFVTEwgPDwgVkhPU1RfQkFDS0VORF9GX0lP
VExCX01TR19WMikKPiAgIH07Cj4gICAKPiAgIC8qIFVzZWQgdG8gdHJhY2sgYWxsIHRoZSB2aG9z
dF92c29jayBpbnN0YW5jZXMgb24gdGhlIHN5c3RlbS4gKi8KPiBAQCAtOTQsNiArOTksOSBAQCB2
aG9zdF90cmFuc3BvcnRfZG9fc2VuZF9wa3Qoc3RydWN0IHZob3N0X3Zzb2NrICp2c29jaywKPiAg
IAlpZiAoIXZob3N0X3ZxX2dldF9iYWNrZW5kKHZxKSkKPiAgIAkJZ290byBvdXQ7Cj4gICAKPiAr
CWlmICghdnFfbWV0YV9wcmVmZXRjaCh2cSkpCj4gKwkJZ290byBvdXQ7Cj4gKwo+ICAgCS8qIEF2
b2lkIGZ1cnRoZXIgdm1leGl0cywgd2UncmUgYWxyZWFkeSBwcm9jZXNzaW5nIHRoZSB2aXJ0cXVl
dWUgKi8KPiAgIAl2aG9zdF9kaXNhYmxlX25vdGlmeSgmdnNvY2stPmRldiwgdnEpOwo+ICAgCj4g
QEAgLTQ0OSw2ICs0NTcsOSBAQCBzdGF0aWMgdm9pZCB2aG9zdF92c29ja19oYW5kbGVfdHhfa2lj
ayhzdHJ1Y3Qgdmhvc3Rfd29yayAqd29yaykKPiAgIAlpZiAoIXZob3N0X3ZxX2dldF9iYWNrZW5k
KHZxKSkKPiAgIAkJZ290byBvdXQ7Cj4gICAKPiArCWlmICghdnFfbWV0YV9wcmVmZXRjaCh2cSkp
Cj4gKwkJZ290byBvdXQ7Cj4gKwo+ICAgCXZob3N0X2Rpc2FibGVfbm90aWZ5KCZ2c29jay0+ZGV2
LCB2cSk7Cj4gICAJZG8gewo+ICAgCQl1MzIgbGVuOwo+IEBAIC03NjYsOCArNzc3LDEyIEBAIHN0
YXRpYyBpbnQgdmhvc3RfdnNvY2tfc2V0X2ZlYXR1cmVzKHN0cnVjdCB2aG9zdF92c29jayAqdnNv
Y2ssIHU2NCBmZWF0dXJlcykKPiAgIAltdXRleF9sb2NrKCZ2c29jay0+ZGV2Lm11dGV4KTsKPiAg
IAlpZiAoKGZlYXR1cmVzICYgKDEgPDwgVkhPU1RfRl9MT0dfQUxMKSkgJiYKPiAgIAkgICAgIXZo
b3N0X2xvZ19hY2Nlc3Nfb2soJnZzb2NrLT5kZXYpKSB7Cj4gLQkJbXV0ZXhfdW5sb2NrKCZ2c29j
ay0+ZGV2Lm11dGV4KTsKPiAtCQlyZXR1cm4gLUVGQVVMVDsKPiArCQlnb3RvIGVycjsKPiArCX0K
PiArCj4gKwlpZiAoKGZlYXR1cmVzICYgKDFVTEwgPDwgVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JN
KSkpIHsKPiArCQlpZiAodmhvc3RfaW5pdF9kZXZpY2VfaW90bGIoJnZzb2NrLT5kZXYsIHRydWUp
KQo+ICsJCQlnb3RvIGVycjsKPiAgIAl9Cj4gICAKPiAgIAlmb3IgKGkgPSAwOyBpIDwgQVJSQVlf
U0laRSh2c29jay0+dnFzKTsgaSsrKSB7Cj4gQEAgLTc3OCw2ICs3OTMsMTAgQEAgc3RhdGljIGlu
dCB2aG9zdF92c29ja19zZXRfZmVhdHVyZXMoc3RydWN0IHZob3N0X3Zzb2NrICp2c29jaywgdTY0
IGZlYXR1cmVzKQo+ICAgCX0KPiAgIAltdXRleF91bmxvY2soJnZzb2NrLT5kZXYubXV0ZXgpOwo+
ICAgCXJldHVybiAwOwo+ICsKPiArZXJyOgo+ICsJbXV0ZXhfdW5sb2NrKCZ2c29jay0+ZGV2Lm11
dGV4KTsKPiArCXJldHVybiAtRUZBVUxUOwo+ICAgfQo+ICAgCj4gICBzdGF0aWMgbG9uZyB2aG9z
dF92c29ja19kZXZfaW9jdGwoc3RydWN0IGZpbGUgKmYsIHVuc2lnbmVkIGludCBpb2N0bCwKPiBA
QCAtODExLDYgKzgzMCwxOCBAQCBzdGF0aWMgbG9uZyB2aG9zdF92c29ja19kZXZfaW9jdGwoc3Ry
dWN0IGZpbGUgKmYsIHVuc2lnbmVkIGludCBpb2N0bCwKPiAgIAkJaWYgKGNvcHlfZnJvbV91c2Vy
KCZmZWF0dXJlcywgYXJncCwgc2l6ZW9mKGZlYXR1cmVzKSkpCj4gICAJCQlyZXR1cm4gLUVGQVVM
VDsKPiAgIAkJcmV0dXJuIHZob3N0X3Zzb2NrX3NldF9mZWF0dXJlcyh2c29jaywgZmVhdHVyZXMp
Owo+ICsJY2FzZSBWSE9TVF9HRVRfQkFDS0VORF9GRUFUVVJFUzoKPiArCQlmZWF0dXJlcyA9IFZI
T1NUX1ZTT0NLX0JBQ0tFTkRfRkVBVFVSRVM7Cj4gKwkJaWYgKGNvcHlfdG9fdXNlcihhcmdwLCAm
ZmVhdHVyZXMsIHNpemVvZihmZWF0dXJlcykpKQo+ICsJCQlyZXR1cm4gLUVGQVVMVDsKPiArCQly
ZXR1cm4gMDsKPiArCWNhc2UgVkhPU1RfU0VUX0JBQ0tFTkRfRkVBVFVSRVM6Cj4gKwkJaWYgKGNv
cHlfZnJvbV91c2VyKCZmZWF0dXJlcywgYXJncCwgc2l6ZW9mKGZlYXR1cmVzKSkpCj4gKwkJCXJl
dHVybiAtRUZBVUxUOwo+ICsJCWlmIChmZWF0dXJlcyAmIH5WSE9TVF9WU09DS19CQUNLRU5EX0ZF
QVRVUkVTKQo+ICsJCQlyZXR1cm4gLUVPUE5PVFNVUFA7Cj4gKwkJdmhvc3Rfc2V0X2JhY2tlbmRf
ZmVhdHVyZXMoJnZzb2NrLT5kZXYsIGZlYXR1cmVzKTsKPiArCQlyZXR1cm4gMDsKPiAgIAlkZWZh
dWx0Ogo+ICAgCQltdXRleF9sb2NrKCZ2c29jay0+ZGV2Lm11dGV4KTsKPiAgIAkJciA9IHZob3N0
X2Rldl9pb2N0bCgmdnNvY2stPmRldiwgaW9jdGwsIGFyZ3ApOwo+IEBAIC04MjMsNiArODU0LDM0
IEBAIHN0YXRpYyBsb25nIHZob3N0X3Zzb2NrX2Rldl9pb2N0bChzdHJ1Y3QgZmlsZSAqZiwgdW5z
aWduZWQgaW50IGlvY3RsLAo+ICAgCX0KPiAgIH0KPiAgIAo+ICtzdGF0aWMgc3NpemVfdCB2aG9z
dF92c29ja19jaHJfcmVhZF9pdGVyKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVy
ICp0bykKPiArewo+ICsJc3RydWN0IGZpbGUgKmZpbGUgPSBpb2NiLT5raV9maWxwOwo+ICsJc3Ry
dWN0IHZob3N0X3Zzb2NrICp2c29jayA9IGZpbGUtPnByaXZhdGVfZGF0YTsKPiArCXN0cnVjdCB2
aG9zdF9kZXYgKmRldiA9ICZ2c29jay0+ZGV2Owo+ICsJaW50IG5vYmxvY2sgPSBmaWxlLT5mX2Zs
YWdzICYgT19OT05CTE9DSzsKPiArCj4gKwlyZXR1cm4gdmhvc3RfY2hyX3JlYWRfaXRlcihkZXYs
IHRvLCBub2Jsb2NrKTsKPiArfQo+ICsKPiArc3RhdGljIHNzaXplX3Qgdmhvc3RfdnNvY2tfY2hy
X3dyaXRlX2l0ZXIoc3RydWN0IGtpb2NiICppb2NiLAo+ICsJCQkJCXN0cnVjdCBpb3ZfaXRlciAq
ZnJvbSkKPiArewo+ICsJc3RydWN0IGZpbGUgKmZpbGUgPSBpb2NiLT5raV9maWxwOwo+ICsJc3Ry
dWN0IHZob3N0X3Zzb2NrICp2c29jayA9IGZpbGUtPnByaXZhdGVfZGF0YTsKPiArCXN0cnVjdCB2
aG9zdF9kZXYgKmRldiA9ICZ2c29jay0+ZGV2Owo+ICsKPiArCXJldHVybiB2aG9zdF9jaHJfd3Jp
dGVfaXRlcihkZXYsIGZyb20pOwo+ICt9Cj4gKwo+ICtzdGF0aWMgX19wb2xsX3Qgdmhvc3RfdnNv
Y2tfY2hyX3BvbGwoc3RydWN0IGZpbGUgKmZpbGUsIHBvbGxfdGFibGUgKndhaXQpCj4gK3sKPiAr
CXN0cnVjdCB2aG9zdF92c29jayAqdnNvY2sgPSBmaWxlLT5wcml2YXRlX2RhdGE7Cj4gKwlzdHJ1
Y3Qgdmhvc3RfZGV2ICpkZXYgPSAmdnNvY2stPmRldjsKPiArCj4gKwlyZXR1cm4gdmhvc3RfY2hy
X3BvbGwoZmlsZSwgZGV2LCB3YWl0KTsKPiArfQo+ICsKPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
ZmlsZV9vcGVyYXRpb25zIHZob3N0X3Zzb2NrX2ZvcHMgPSB7Cj4gICAJLm93bmVyICAgICAgICAg
ID0gVEhJU19NT0RVTEUsCj4gICAJLm9wZW4gICAgICAgICAgID0gdmhvc3RfdnNvY2tfZGV2X29w
ZW4sCj4gQEAgLTgzMCw2ICs4ODksOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0
aW9ucyB2aG9zdF92c29ja19mb3BzID0gewo+ICAgCS5sbHNlZWsJCT0gbm9vcF9sbHNlZWssCj4g
ICAJLnVubG9ja2VkX2lvY3RsID0gdmhvc3RfdnNvY2tfZGV2X2lvY3RsLAo+ICAgCS5jb21wYXRf
aW9jdGwgICA9IGNvbXBhdF9wdHJfaW9jdGwsCj4gKwkucmVhZF9pdGVyICAgICAgPSB2aG9zdF92
c29ja19jaHJfcmVhZF9pdGVyLAo+ICsJLndyaXRlX2l0ZXIgICAgID0gdmhvc3RfdnNvY2tfY2hy
X3dyaXRlX2l0ZXIsCj4gKwkucG9sbCAgICAgICAgICAgPSB2aG9zdF92c29ja19jaHJfcG9sbCwK
PiAgIH07Cj4gICAKPiAgIHN0YXRpYyBzdHJ1Y3QgbWlzY2RldmljZSB2aG9zdF92c29ja19taXNj
ID0gewoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
