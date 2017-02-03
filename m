From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/3] Virtio: Fine-tuning for two function implementations
Date: Fri, 3 Feb 2017 10:57:29 +0800
Message-ID: <02d56f89-263e-3bda-9543-90e4c82df75b@redhat.com>
References: <61829748-a13d-42e4-8f6c-103ee5ca2c88@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <61829748-a13d-42e4-8f6c-103ee5ca2c88@users.sourceforge.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE35bm0MDHmnIgyN+aXpSAwNTo0NCwgU0YgTWFya3VzIEVsZnJpbmcgd3JvdGU6Cj4g
RnJvbTogTWFya3VzIEVsZnJpbmcgPGVsZnJpbmdAdXNlcnMuc291cmNlZm9yZ2UubmV0Pgo+IERh
dGU6IFRodSwgMjYgSmFuIDIwMTcgMjI6NDA6MDIgKzAxMDAKPgo+IEEgZmV3IHVwZGF0ZSBzdWdn
ZXN0aW9ucyB3ZXJlIHRha2VuIGludG8gYWNjb3VudAo+IGZyb20gc3RhdGljIHNvdXJjZSBjb2Rl
IGFuYWx5c2lzLgo+Cj4gTWFya3VzIEVsZnJpbmcgKDMpOgo+ICAgIHZpcnRpb19wY2k6IFVzZSBr
Y2FsbG9jKCkgaW4gdnBfcmVxdWVzdF9tc2l4X3ZlY3RvcnMoKQo+ICAgIHZpcnRpb19wY2k6IFVz
ZSBrbWFsbG9jX2FycmF5KCkgaW4gdnBfcmVxdWVzdF9tc2l4X3ZlY3RvcnMoKQo+ICAgIHZpcnRp
b19yaW5nOiBVc2Uga21hbGxvY19hcnJheSgpIGluIGFsbG9jX2luZGlyZWN0KCkKPgo+ICAgZHJp
dmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYyB8IDggKysrKy0tLS0KPiAgIGRyaXZlcnMv
dmlydGlvL3ZpcnRpb19yaW5nLmMgICAgICAgfCAzICstLQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4KCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
