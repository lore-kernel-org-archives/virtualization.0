From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH net-next v2 2/2] virtio_net: Extend virtio to use VF
	datapath when available
Date: Tue, 23 Jan 2018 18:33:59 +0800
Message-ID: <afd11f19-6906-2a7e-1b82-e3138c4d9530@redhat.com>
References: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
	<1515736720-39368-3-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1515736720-39368-3-git-send-email-sridhar.samudrala@intel.com>
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
To: Sridhar Samudrala <sridhar.samudrala@intel.com>, mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDHmnIgxMuaXpSAxMzo1OCwgU3JpZGhhciBTYW11ZHJhbGEgd3JvdGU6Cj4g
ICBzdGF0aWMgbmV0ZGV2X3R4X3Qgc3RhcnRfeG1pdChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1
Y3QgbmV0X2RldmljZSAqZGV2KQo+ICAgewo+ICAgCXN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpID0g
bmV0ZGV2X3ByaXYoZGV2KTsKPiAgIAlpbnQgcW51bSA9IHNrYl9nZXRfcXVldWVfbWFwcGluZyhz
a2IpOwo+ICAgCXN0cnVjdCBzZW5kX3F1ZXVlICpzcSA9ICZ2aS0+c3FbcW51bV07Cj4gKwlzdHJ1
Y3QgbmV0X2RldmljZSAqdmZfbmV0ZGV2Owo+ICAgCWludCBlcnI7Cj4gICAJc3RydWN0IG5ldGRl
dl9xdWV1ZSAqdHhxID0gbmV0ZGV2X2dldF90eF9xdWV1ZShkZXYsIHFudW0pOwo+ICAgCWJvb2wg
a2ljayA9ICFza2ItPnhtaXRfbW9yZTsKPiAgIAlib29sIHVzZV9uYXBpID0gc3EtPm5hcGkud2Vp
Z2h0Owo+ICAgCj4gKwkvKiBJZiBWRiBpcyBwcmVzZW50IGFuZCB1cCB0aGVuIHJlZGlyZWN0IHBh
Y2tldHMKPiArCSAqIGNhbGxlZCB3aXRoIHJjdV9yZWFkX2xvY2tfYmgKPiArCSAqLwo+ICsJdmZf
bmV0ZGV2ID0gcmN1X2RlcmVmZXJlbmNlX2JoKHZpLT52Zl9uZXRkZXYpOwo+ICsJaWYgKHZmX25l
dGRldiAmJiBuZXRpZl9ydW5uaW5nKHZmX25ldGRldikgJiYKPiArCSAgICAhbmV0cG9sbF90eF9y
dW5uaW5nKGRldikgJiYKPiArCSAgICBpc191bmljYXN0X2V0aGVyX2FkZHIoZXRoX2hkcihza2Ip
LT5oX2Rlc3QpKQo+ICsJCXJldHVybiB2aXJ0bmV0X3ZmX3htaXQoZGV2LCB2Zl9uZXRkZXYsIHNr
Yik7Cj4gKwoKQSBxdWVzdGlvbiBoZXJlLgoKSWYgSSByZWFkIHRoZSBjb2RlIGNvcnJlY3RseSwg
YWxsIGZlYXR1cmVzIHdlcmUgdmFsaWRhdGVkIGFnYWluc3QgdmlydGlvIAppbnN0ZWFkIFZGIGJl
Zm9yZSB0cmFuc21pdHRpbmcuIFRoaXMgYXNzdW1lcyBWRidzIGZlYXR1cmUgaXMgYSBzdXBlcnNl
dCAKb2YgdmlydGlvLCBkb2VzIHRoaXMgcmVhbGx5IHdvcms/IERvIHdlIG5lZWQgdG8gc2FuaXRp
emUgdGhlIGZlYXR1cmUgCmJlZm9yZSBqb2luaW5nPyAoZS5nIGF0IGxhc3QgTkVUSUZfUl9HU09f
Uk9CVVNUIG5lZWRzIHRvIGJlIHJlbW92ZWQpLgoKVGhhbmtzCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
