From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next] virtio_net: fix error return code in
	virtnet_probe()
Date: Thu, 31 May 2018 10:05:49 +0800
Message-ID: <c11ca878-8b53-01bc-f462-b8b5f4400096__26335.4803938002$1527732242$gmane$org@redhat.com>
References: <1527732307-145609-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1527732307-145609-1-git-send-email-weiyongjun1@huawei.com>
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
To: Wei Yongjun <weiyongjun1@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDXmnIgzMeaXpSAxMDowNSwgV2VpIFlvbmdqdW4gd3JvdGU6Cj4gRml4IHRv
IHJldHVybiBhIG5lZ2F0aXZlIGVycm9yIGNvZGUgZnJvbSB0aGUgZmFpbG92ZXIgY3JlYXRlIGZh
aWwgZXJyb3IKPiBoYW5kbGluZyBjYXNlIGluc3RlYWQgb2YgMCwgYXMgZG9uZSBlbHNld2hlcmUg
aW4gdGhpcyBmdW5jdGlvbi4KPgo+IEZpeGVzOiBiYTVlNDQyNmU4MGUgKCJ2aXJ0aW9fbmV0OiBF
eHRlbmQgdmlydGlvIHRvIHVzZSBWRiBkYXRhcGF0aCB3aGVuIGF2YWlsYWJsZSIpCj4gU2lnbmVk
LW9mZi1ieTogV2VpIFlvbmdqdW4gPHdlaXlvbmdqdW4xQGh1YXdlaS5jb20+Cj4gLS0tCj4gICBk
cml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCA0ICsrKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBpbmRleCA4ZjA4YTNlLi4y
ZDU1ZTJhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ICsrKyBiL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IEBAIC0yOTM1LDggKzI5MzUsMTAgQEAgc3RhdGljIGlu
dCB2aXJ0bmV0X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ICAgCj4gICAJaWYg
KHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfU1RBTkRCWSkpIHsKPiAgIAkJ
dmktPmZhaWxvdmVyID0gbmV0X2ZhaWxvdmVyX2NyZWF0ZSh2aS0+ZGV2KTsKPiAtCQlpZiAoSVNf
RVJSKHZpLT5mYWlsb3ZlcikpCj4gKwkJaWYgKElTX0VSUih2aS0+ZmFpbG92ZXIpKSB7Cj4gKwkJ
CWVyciA9IFBUUl9FUlIodmktPmZhaWxvdmVyKTsKPiAgIAkJCWdvdG8gZnJlZV92cXM7Cj4gKwkJ
fQo+ICAgCX0KPiAgIAo+ICAgCWVyciA9IHJlZ2lzdGVyX25ldGRldihkZXYpOwo+CgpBY2tlZC1i
eTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
