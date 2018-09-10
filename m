From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next 04/11] tuntap: simplify error handling in
	tun_build_skb()
Date: Mon, 10 Sep 2018 11:44:26 +0800
Message-ID: <372ec320-83cf-add5-acf7-27d876c3d604__28227.3532044657$1536550953$gmane$org@redhat.com>
References: <20180906040526.22518-1-jasowang@redhat.com>
	<20180906040526.22518-5-jasowang@redhat.com>
	<20180906130425-mutt-send-email-mst@kernel.org>
	<e1f17f51-5f99-df18-4185-6c6e4dfaba89@redhat.com>
	<20180907101645-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180907101645-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDnmnIgwN+aXpSAyMjoxNywgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
IE9uIEZyaSwgU2VwIDA3LCAyMDE4IGF0IDExOjIyOjAwQU0gKzA4MDAsIEphc29uIFdhbmcgd3Jv
dGU6Cj4+Pj4gQEAgLTE2NjgsNiArMTY2OCw5IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqdHVu
X2J1aWxkX3NrYihzdHJ1Y3QgdHVuX3N0cnVjdCAqdHVuLAo+Pj4+ICAgIAlpZiAoY29waWVkICE9
IGxlbikKPj4+PiAgICAJCXJldHVybiBFUlJfUFRSKC1FRkFVTFQpOwo+Pj4+ICsJZ2V0X3BhZ2Uo
YWxsb2NfZnJhZy0+cGFnZSk7Cj4+Pj4gKwlhbGxvY19mcmFnLT5vZmZzZXQgKz0gYnVmbGVuOwo+
Pj4+ICsKPj4+IFRoaXMgYWRkcyBhbiBhdG9taWMgb3Agb24gWERQX0RST1Agd2hpY2ggaXMgYSBk
YXRhIHBhdGgKPj4+IG9wZXJhdGlvbiBmb3Igc29tZSB3b3JrbG9hZHMuCj4+IFllcywgSSBoYXZl
IHBhdGNoIG9uIHRvcCB0byBhbW9ydGl6ZSB0aGlzLCB0aGUgaWRlYSBpcyB0byBoYXZlIGEgdmVy
eSBiaWcKPj4gcmVmY291bnQgb25jZSBhZnRlciB0aGUgZnJhZyB3YXMgYWxsb2NhdGVkIGFuZCBt
YWludGFpbiBhIGJpYXMgYW5kIGRlY3JlYXNlCj4+IHRoZW0gYWxsIHdoZW4gYWxsb2NhdGluZyBu
ZXcgZnJhZ3MuJwo+IFdoeSBib3RoZXIgd2l0aCByZWZjb3VudGluZyBmb3IgYSBkcm9wIHRob3Vn
aD8gSXQgc2hvdWxkIGJlIHNpbXBsZS4KPgoKUmlnaHQsIGxldCBtZSBmaXggdGhpcy4KClRoYW5r
cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
