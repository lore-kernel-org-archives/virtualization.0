From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 0/2] vhost: fix vhost_vq_access_ok() log check
Date: Tue, 10 Apr 2018 14:40:10 +0800
Message-ID: <8642c057-e49d-d95d-19e5-6d304f20064e__38920.6731961623$1523342318$gmane$org@redhat.com>
References: <20180410052630.11270-1-stefanha@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180410052630.11270-1-stefanha@redhat.com>
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
To: Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDTmnIgxMOaXpSAxMzoyNiwgU3RlZmFuIEhham5vY3ppIHdyb3RlOgo+IHYy
Ogo+ICAgKiBSZXdyb3RlIHRoZSBjb25kaXRpb25hbCB0byBtYWtlIHRoZSB2cSBhY2Nlc3MgY2hl
Y2sgY2xlYXJlciBbTGludXNdCj4gICAqIEFkZGVkIFBhdGNoIDIgdG8gbWFrZSB0aGUgcmV0dXJu
IHR5cGUgY29uc2lzdGVudCBhbmQgaGFyZGVyIHRvIG1pc3VzZSBbTGludXNdCj4KPiBUaGUgZmly
c3QgcGF0Y2ggZml4ZXMgdGhlIHZob3N0IHZpcnRxdWV1ZSBhY2Nlc3MgY2hlY2sgd2hpY2ggd2Fz
IHJlY2VudGx5Cj4gYnJva2VuLiAgVGhlIHNlY29uZCBwYXRjaCByZXBsYWNlcyB0aGUgaW50IHJl
dHVybiB0eXBlIHdpdGggYm9vbCB0byBwcmV2ZW50Cj4gZnV0dXJlIGJ1Z3MuCj4KPiBTdGVmYW4g
SGFqbm9jemkgKDIpOgo+ICAgIHZob3N0OiBmaXggdmhvc3RfdnFfYWNjZXNzX29rKCkgbG9nIGNo
ZWNrCj4gICAgdmhvc3Q6IHJldHVybiBib29sIGZyb20gKl9hY2Nlc3Nfb2soKSBmdW5jdGlvbnMK
Pgo+ICAgZHJpdmVycy92aG9zdC92aG9zdC5oIHwgIDQgKy0tCj4gICBkcml2ZXJzL3Zob3N0L3Zo
b3N0LmMgfCA3MCArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgMzYgZGVsZXRpb25z
KC0pCj4KCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhhbmtz
IQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
