From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost-scsi: remove incorrect memory barrier
Date: Wed, 17 Apr 2019 13:56:09 +0800
Message-ID: <482f8951-f8c1-aeb4-2f57-4f03f876af6a__36980.5248732277$1555480601$gmane$org@redhat.com>
References: <1555404968-39927-1-git-send-email-pbonzini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1555404968-39927-1-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, virtualization@lists.linux-foundation.org, stefanha@redhat.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvNC8xNiDkuIvljYg0OjU2LCBQYW9sbyBCb256aW5pIHdyb3RlOgo+IEF0IHRoaXMg
cG9pbnQsIHZzX3RwZyBpcyBub3QgcHVibGljIGF0IGFsbDsgdHZfdHBnX3Zob3N0X2NvdW50Cj4g
aXMgYWNjZXNzZWQgdW5kZXIgdHBnLT50dl90cGdfbXV0ZXg7IHRwZy0+dmhvc3Rfc2NzaSBpcwo+
IGFjY2Vzc2VkIHVuZGVyIHZob3N0X3Njc2lfbXV0ZXguICBUaGVyZWZvciB0aGVyZSBhcmUgbm8g
YXRvbWljCj4gb3BlcmF0aW9ucyBpbnZvbHZlZCBhdCBhbGwgaGVyZSwganVzdCByZW1vdmUgdGhl
IGJhcnJpZXIuCj4KPiBSZXBvcnRlZC1ieTogQW5kcmVhIFBhcnJpIDxhbmRyZWEucGFycmlAYW1h
cnVsYXNvbHV0aW9ucy5jb20+Cj4gU2lnbmVkLW9mZi1ieTogUGFvbG8gQm9uemluaSA8cGJvbnpp
bmlAcmVkaGF0LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmhvc3Qvc2NzaS5jIHwgMSAtCj4gICAx
IGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhv
c3Qvc2NzaS5jIGIvZHJpdmVycy92aG9zdC9zY3NpLmMKPiBpbmRleCA2MThmYjY0NjEwMTcuLmMw
OTBkMTc3YmQ3NSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Njc2kuYwo+ICsrKyBiL2Ry
aXZlcnMvdmhvc3Qvc2NzaS5jCj4gQEAgLTE0NDMsNyArMTQ0Myw2IEBAIHN0YXRpYyB2b2lkIHZo
b3N0X3Njc2lfZmx1c2goc3RydWN0IHZob3N0X3Njc2kgKnZzKQo+ICAgCQkJdHBnLT50dl90cGdf
dmhvc3RfY291bnQrKzsKPiAgIAkJCXRwZy0+dmhvc3Rfc2NzaSA9IHZzOwo+ICAgCQkJdnNfdHBn
W3RwZy0+dHBvcnRfdHBndF0gPSB0cGc7Cj4gLQkJCXNtcF9tYl9fYWZ0ZXJfYXRvbWljKCk7Cj4g
ICAJCQltYXRjaCA9IHRydWU7Cj4gICAJCX0KPiAgIAkJbXV0ZXhfdW5sb2NrKCZ0cGctPnR2X3Rw
Z19tdXRleCk7CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
