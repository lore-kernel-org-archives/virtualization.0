From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] virtio-net: re enable XDP_REDIRECT for mergeable
	buffer
Date: Fri, 2 Mar 2018 17:27:22 +0800
Message-ID: <8e75beb6-ba0f-79f3-2d24-018656226b1e__21164.0355679721$1519982783$gmane$org@redhat.com>
References: <1519971929-15148-1-git-send-email-jasowang@redhat.com>
	<20180302080517.4526f384@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180302080517.4526f384@redhat.com>
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
To: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDPmnIgwMuaXpSAxNTowNSwgSmVzcGVyIERhbmdhYXJkIEJyb3VlciB3cm90
ZToKPiBPbiBGcmksICAyIE1hciAyMDE4IDE0OjI1OjI5ICswODAwCj4gSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPj4gQEAgLTc3MCw2ICs3NzQsMTkgQEAgc3RhdGlj
IHN0cnVjdCBza19idWZmICpyZWNlaXZlX21lcmdlYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2
LAo+PiAgIAkJCQlnb3RvIGVycl94ZHA7Cj4+ICAgCQkJcmN1X3JlYWRfdW5sb2NrKCk7Cj4+ICAg
CQkJZ290byB4ZHBfeG1pdDsKPj4gKwkJY2FzZSBYRFBfUkVESVJFQ1Q6Cj4+ICsJCQllcnIgPSB4
ZHBfZG9fcmVkaXJlY3QoZGV2LCAmeGRwLCB4ZHBfcHJvZyk7Cj4+ICsJCQlpZiAoZXJyKSB7Cj4+
ICsJCQkJdHJhY2VfeGRwX2V4Y2VwdGlvbih2aS0+ZGV2LCB4ZHBfcHJvZywgYWN0KTsKPiBEbyBu
b3QgYWRkIGEgdHJhY2VfeGRwX2V4Y2VwdGlvbiBoZXJlLi4uIHRoaXMgaXMgaGFuZGxlZCBpbnNp
ZGUKPiB4ZHBfZG9fcmVkaXJlY3QoKSBpbnZvY2F0aW9uLgo+Cj4KClJpZ2h0LCBsZXQgbWUgcG9z
dCBWMi4KClRoYW5rcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
