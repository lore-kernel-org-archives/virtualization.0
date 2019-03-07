From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH V2 4/5] vhost: introduce helpers to get the size of
	metadata area
Date: Thu, 7 Mar 2019 10:40:20 +0800
Message-ID: <f61076eb-93ec-b924-2ad9-96af0df45830__20401.9863669359$1551926441$gmane$org@redhat.com>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
	<1551856692-3384-5-git-send-email-jasowang@redhat.com>
	<608E47C2-5130-41DE-9D52-02807EBCDD43@dinechin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <608E47C2-5130-41DE-9D52-02807EBCDD43@dinechin.org>
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
To: Christophe de Dinechin <christophe.de.dinechin@gmail.com>
Cc: aarcange@redhat.com, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMy82IOS4i+WNiDY6NTYsIENocmlzdG9waGUgZGUgRGluZWNoaW4gd3JvdGU6Cj4+
IE9uIDYgTWFyIDIwMTksIGF0IDA4OjE4LCBKYXNvbiBXYW5nPGphc293YW5nQHJlZGhhdC5jb20+
ICB3cm90ZToKPj4KPj4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZzxqYXNvd2FuZ0ByZWRoYXQu
Y29tPgo+PiAtLS0KPj4gZHJpdmVycy92aG9zdC92aG9zdC5jIHwgNDYgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQo+PiAxIGZpbGUgY2hhbmdlZCwgMjggaW5z
ZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zo
b3N0L3Zob3N0LmMgYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPj4gaW5kZXggMjAyNTU0My4uMTAx
NTQ2NCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92aG9zdC92aG9zdC5jCj4+ICsrKyBiL2RyaXZl
cnMvdmhvc3Qvdmhvc3QuYwo+PiBAQCAtNDEzLDYgKzQxMywyNyBAQCBzdGF0aWMgdm9pZCB2aG9z
dF9kZXZfZnJlZV9pb3ZlY3Moc3RydWN0IHZob3N0X2RldiAqZGV2KQo+PiAJCXZob3N0X3ZxX2Zy
ZWVfaW92ZWNzKGRldi0+dnFzW2ldKTsKPj4gfQo+Pgo+PiArc3RhdGljIHNpemVfdCB2aG9zdF9n
ZXRfYXZhaWxfc2l6ZShzdHJ1Y3Qgdmhvc3RfdmlydHF1ZXVlICp2cSwgaW50IG51bSkKPiBOaXQ6
IEFueSByZWFzb24gbm90IHRvIG1ha2UgYG51bWAgdW5zaWduZWQgb3Igc2l6ZV90Pwo+CgpMZXQg
bWUgdXNlIHVuc2lnbmVkIGludCB0byBtYXRjaCB0aGUgZGVmaW5pdGlvbiBvZiB2cS0+bnVtLgoK
VGhhbmtzCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
