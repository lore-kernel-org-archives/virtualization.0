From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio-net: lower min ring num_free for efficiency
Date: Thu, 15 Aug 2019 11:01:00 +0800
Message-ID: <f61d9621-cc33-44a2-f297-43f8af8d759b__24103.8392459572$1565838083$gmane$org@redhat.com>
References: <BYAPR14MB3205E4E194942B0A1A91A222A6AD0@BYAPR14MB3205.namprd14.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <BYAPR14MB3205E4E194942B0A1A91A222A6AD0@BYAPR14MB3205.namprd14.prod.outlook.com>
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
To: ? jiang <jiangkidd@hotmail.com>, "mst@redhat.com" <mst@redhat.com>
Cc: "xdp-newbies@vger.kernel.org" <xdp-newbies@vger.kernel.org>, "songliubraving@fb.com" <songliubraving@fb.com>, "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>, "hawk@kernel.org" <hawk@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, "jiangran.jr@alibaba-inc.com" <jiangran.jr@alibaba-inc.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>, "ast@kernel.org" <ast@kernel.org>, "kafai@fb.com" <kafai@fb.com>, "yhs@fb.com" <yhs@fb.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvOC8xNCDkuIrljYgxMDowNiwgPyBqaWFuZyB3cm90ZToKPiBUaGlzIGNoYW5nZSBs
b3dlcnMgcmluZyBidWZmZXIgcmVjbGFpbSB0aHJlc2hvbGQgZnJvbSAxLzIqcXVldWUgdG8gYnVk
Z2V0Cj4gZm9yIGJldHRlciBwZXJmb3JtYW5jZS4gQWNjb3JkaW5nIHRvIG91ciB0ZXN0IHdpdGgg
cWVtdSArIGRwZGssIHBhY2tldAo+IGRyb3BwaW5nIGhhcHBlbnMgd2hlbiB0aGUgZ3Vlc3QgaXMg
bm90IGFibGUgdG8gcHJvdmlkZSBmcmVlIGJ1ZmZlciBpbgo+IGF2YWlsIHJpbmcgdGltZWx5IHdp
dGggZGVmYXVsdCAxLzIqcXVldWUuIFRoZSB2YWx1ZSBpbiB0aGUgcGF0Y2ggaGFzIGJlZW4KPiB0
ZXN0ZWQgYW5kIGRvZXMgc2hvdyBiZXR0ZXIgcGVyZm9ybWFuY2UuCgoKUGxlYXNlIGFkZCB5b3Vy
IHRlc3RzIHNldHVwIGFuZCByZXN1bHQgaGVyZS4KClRoYW5rcwoKCj4KPiBTaWduZWQtb2ZmLWJ5
OiBqaWFuZ2tpZGQgPGppYW5na2lkZEBob3RtYWlsLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvbmV0
L3ZpcnRpb19uZXQuYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBi
L2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IGluZGV4IDBkNDExNWM5ZTIwYi4uYmMwOGJlNzky
NWViIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ICsrKyBiL2RyaXZl
cnMvbmV0L3ZpcnRpb19uZXQuYwo+IEBAIC0xMzMxLDcgKzEzMzEsNyBAQCBzdGF0aWMgaW50IHZp
cnRuZXRfcmVjZWl2ZShzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEsIGludCBidWRnZXQsCj4gICAJ
CX0KPiAgIAl9Cj4gICAKPiAtCWlmIChycS0+dnEtPm51bV9mcmVlID4gdmlydHF1ZXVlX2dldF92
cmluZ19zaXplKHJxLT52cSkgLyAyKSB7Cj4gKwlpZiAocnEtPnZxLT5udW1fZnJlZSA+IG1pbigo
dW5zaWduZWQgaW50KWJ1ZGdldCwgdmlydHF1ZXVlX2dldF92cmluZ19zaXplKHJxLT52cSkpIC8g
Mikgewo+ICAgCQlpZiAoIXRyeV9maWxsX3JlY3YodmksIHJxLCBHRlBfQVRPTUlDKSkKPiAgIAkJ
CXNjaGVkdWxlX2RlbGF5ZWRfd29yaygmdmktPnJlZmlsbCwgMCk7Cj4gICAJfQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
