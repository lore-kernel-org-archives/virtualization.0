From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: Re: [PATCH net-next 1/2] virtio-net: correctly update XDP_TX counters
Date: Wed, 1 Aug 2018 10:42:54 +0900
Message-ID: <496cdc80-aa31-1061-4af3-3606b1a69202@lab.ntt.co.jp>
References: <1533030219-9904-1-git-send-email-jasowang@redhat.com>
	<2cdb8081-90a8-3a87-b6a6-4395825594a1@lab.ntt.co.jp>
	<ffbfa3ba-3019-5324-4ecb-eb7a2699a4e8@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <ffbfa3ba-3019-5324-4ecb-eb7a2699a4e8@redhat.com>
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
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

T24gMjAxOC8wOC8wMSAxMDozMSwgSmFzb24gV2FuZyB3cm90ZToKPiBPbiAyMDE45bm0MDfmnIgz
MeaXpSAxNzo1NywgVG9zaGlha2kgTWFraXRhIHdyb3RlOgo+PiBPbiAyMDE4LzA3LzMxIDE4OjQz
LCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4gQ29tbWl0IDViOGYzYzhkMzBhNiAoInZpcnRpb19uZXQ6
IEFkZCBYRFAgcmVsYXRlZCBzdGF0cyIpIHRyaWVzIHRvCj4+PiBjb3VudCBUWCBYRFAgc3RhdHMg
aW4gdmlydG5ldF9yZWNlaXZlKCkuIFRoaXMgd2lsbCBjYXVzZSBzZXZlcmFsCj4+PiBpc3N1ZXM6
Cj4+Pgo+Pj4gLSB2aXJ0bmV0X3hkcF9zcSgpIHdhcyBjYWxsZWQgd2l0aG91dCBjaGVja2luZyB3
aGV0aGVyIG9yIG5vdCBYRFAgaXMKPj4+IMKgwqAgc2V0LiBUaGlzIG1heSBjYXVzZSBvdXQgb2Yg
Ym91bmQgYWNjZXNzIHdoZW4gdGhlcmUncyBubyBlbm91Z2ggdHhxCj4+PiDCoMKgIGZvciBYRFAu
Cj4+PiAtIFN0YXRzIHdlcmUgdXBkYXRlZCBldmVuIGlmIHRoZXJlJ3Mgbm8gWERQL1hEUF9UWC4+
Cj4+PiBGaXhpbmcgdGhpcyBieSByZXVzaW5nIHZpcnRuZXRfeGRwX3htaXQoKSBmb3IgWERQX1RY
IHdoaWNoIGNhbiBjb3VudHMKPj4+IFRYIFhEUCBjb3VudGVyIGl0c2VsZiBhbmQgcmVtb3ZlIHRo
ZSB1bm5lY2Vzc2FyeSB0eCBzdGF0cyBlbWJlZGRlZCBpbgo+Pj4gcnggc3RhdHMuCj4+IFRoYW5r
cyBmb3IgZml4aW5nIHRoaXMuCj4+IEkgd2FudGVkIHRvIGF2b2lkIGNhbGxpbmcgdTY0X3N0YXRz
X3VwZGF0ZV9iZWdpbigpIChpLmUuIHNtcF93bWIoKSBpbiAzMgo+PiBiaXQgc3lzdGVtcykgZm9y
IGV2ZXJ5IHBhY2tldC4gU28gSSdkIGxpa2UgdG8ga2VlcCBzcSBzdGF0cyBpbgo+PiB2aXJ0bmV0
X3J4X3N0YXRzLgo+Pgo+IAo+IFdlIGNhbiBvcHRpbWl6ZSB0aGlzIGJ5IGFkZGluZyBiYXRjaGlu
ZyBvbiB0b3AuICh2aXJ0bmV0X3hkcF94bWl0KCkKPiBhY2NlcHRzIGFuIGFycmF5IG9mIHhkcCBm
cmFtZXMpLiBJZiB5b3UgbGlrZSwgcGxlYXNlIHNlbmQgYSBwYXRjaCBmb3IgdGhpcy4KClllcywg
dGhhdCBzb3VuZHMgbGlrZSBhIGJldHRlciBvcHRpbWl6YXRpb24uIHdpbGwgdGhpbmsgYWJvdXQg
aXQuLi4KClRoYW5rcywKVG9zaGlha2kgTWFraXRhCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
