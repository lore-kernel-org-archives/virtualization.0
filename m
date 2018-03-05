From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net V2] virtio-net: re enable XDP_REDIRECT for mergeable
	buffer
Date: Mon, 5 Mar 2018 10:43:41 +0800
Message-ID: <986bd816-2452-9eca-ec8a-ce267ef49a2d@redhat.com>
References: <1519982954-14360-1-git-send-email-jasowang@redhat.com>
	<20180304.183811.344767417258525977.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180304.183811.344767417258525977.davem@davemloft.net>
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
To: David Miller <davem@davemloft.net>
Cc: mst@redhat.com, netdev@vger.kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, brouer@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDPmnIgwNeaXpSAwNzozOCwgRGF2aWQgTWlsbGVyIHdyb3RlOgo+IEZyb206
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gRGF0ZTogRnJpLCAgMiBNYXIgMjAx
OCAxNzoyOToxNCArMDgwMAo+Cj4+IFhEUF9SRURJUkVDVCBzdXBwb3J0IGZvciBtZXJnZWFibGUg
YnVmZmVyIHdhcyByZW1vdmVkIHNpbmNlIGNvbW1pdAo+PiA3MzI0ZjUzOTliMDYgKCJ2aXJ0aW9f
bmV0OiBkaXNhYmxlIFhEUF9SRURJUkVDVCBpbiByZWNlaXZlX21lcmdlYWJsZSgpCj4+IGNhc2Ui
KS4gVGhpcyBpcyBiZWNhdXNlIHdlIGRvbid0IHJlc2VydmUgZW5vdWdoIHRhaWxyb29tIGZvciBz
dHJ1Y3QKPj4gc2tiX3NoYXJlZF9pbmZvIHdoaWNoIGJyZWFrcyBYRFAgYXNzdW1wdGlvbi4gU28g
dGhpcyBwYXRjaCBmaXhlcyB0aGlzCj4+IGJ5IHJlc2VydmluZyBlbm91Z2ggdGFpbHJvb20gYW5k
IHVzaW5nIGZpeGVkIHNpemUgb2YgcnggYnVmZmVyLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+PiAtLS0KPj4gQ2hhbmdlcyBmcm9tIFYxOgo+
PiAtIGRvIG5vdCBhZGQgZHVwbGljYXRlZCB0cmFjZXBvaW50IHdoZW4gcmVkaXJlY3Rpb24gZmFp
bHMKPiBBcHBsaWVkIHRvIG5ldC1uZXh0LCB0aGFua3MgSmFzb24uCgpIaSBEYXZpZCwKCkNvbnNp
ZGVyIHRoZSBjaGFuZ2UgaXMgbm90IGxhcmdlLCBhbnkgY2hhbmNlIHRvIG1ha2UgaXQgZm9yIC1u
ZXQgdG8ga2VlcCAKWERQIHJlZGlyZWN0aW9uIHdvcms/CgpUaGFua3MKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
