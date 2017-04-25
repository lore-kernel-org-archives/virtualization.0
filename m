From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next v3 2/5] virtio-net: transmit napi
Date: Tue, 25 Apr 2017 16:36:57 +0800
Message-ID: <2c5491c0-4473-75d1-fa0f-a0dbd4dc626d__34906.6617353403$1493109430$gmane$org@redhat.com>
References: <20170424174930.82623-1-willemdebruijn.kernel@gmail.com>
	<20170424174930.82623-3-willemdebruijn.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170424174930.82623-3-willemdebruijn.kernel@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>, virtualization@lists.linux-foundation.org, davem@davemloft.net, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE35bm0MDTmnIgyNeaXpSAwMTo0OSwgV2lsbGVtIGRlIEJydWlqbiB3cm90ZToKPiBA
QCAtMTM3MSw4ICsxNDE5LDEwIEBAIHN0YXRpYyBpbnQgdmlydG5ldF9jbG9zZShzdHJ1Y3QgbmV0
X2RldmljZSAqZGV2KQo+ICAgCS8qIE1ha2Ugc3VyZSByZWZpbGxfd29yayBkb2Vzbid0IHJlLWVu
YWJsZSBuYXBpISAqLwo+ICAgCWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmdmktPnJlZmlsbCk7
Cj4gICAKPiAtCWZvciAoaSA9IDA7IGkgPCB2aS0+bWF4X3F1ZXVlX3BhaXJzOyBpKyspCj4gKwlm
b3IgKGkgPSAwOyBpIDwgdmktPm1heF9xdWV1ZV9wYWlyczsgaSsrKSB7Cj4gICAJCW5hcGlfZGlz
YWJsZSgmdmktPnJxW2ldLm5hcGkpOwo+ICsJCW5hcGlfZGlzYWJsZSgmdmktPnNxW2ldLm5hcGkp
Owo+ICsJfQoKTG9va3MgbGlrZSB0aGlzIHdpbGwgd2FpdCBmb3IgZXZlciBpZiBuYXBpX3R4IGlz
IGZhbHNlIGJlY2F1c2Ugd2UgbmV2ZXIgCmVuYWJsZSB0aGUgTkFQSSBzbyB3ZSB3aWxsIHdhaXQg
Zm9yIE5BUElfU1RBVEVfU0NIRUQgdG8gYmUgY2xlYXJlZC4KClRoYW5rcwpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
