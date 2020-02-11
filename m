From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 4/5] virtio: introduce a vDPA based transport
Date: Tue, 11 Feb 2020 11:04:57 +0800
Message-ID: <530d9dbe-39c0-db0c-d13a-0719e5ade777@redhat.com>
References: <20200210035608.10002-1-jasowang@redhat.com>
 <20200210035608.10002-5-jasowang@redhat.com>
 <20200210133442.GS23346@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200210133442.GS23346@mellanox.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, mhabets@solarflare.com, virtualization@lists.linux-foundation.org, rob.miller@broadcom.com, lulu@redhat.com, hanand@xilinx.com, hch@infradead.org, eperezma@redhat.com, haotian.wang@sifive.com, shahafs@mellanox.com, parav@mellanox.com, jiri@mellanox.com, xiao.w.wang@intel.com, stefanha@redhat.com, zhihong.wang@intel.com, rdunlap@infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com, netdev@vger.kernel.org, lingshan.zhu@intel.com
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMjAvMi8xMCDkuIvljYg5OjM0LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6Cj4gT24gTW9u
LCBGZWIgMTAsIDIwMjAgYXQgMTE6NTY6MDdBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4g
VGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGEgdkRQQSB0cmFuc3BvcnQgZm9yIHZpcnRpby4gVGhpcyBp
cyB1c2VkIHRvCj4+IHVzZSBrZXJuZWwgdmlydGlvIGRyaXZlciB0byBkcml2ZSB0aGUgbWVkaWF0
ZWQgZGV2aWNlIHRoYXQgaXMgY2FwYWJsZQo+PiBvZiBwb3B1bGF0aW5nIHZpcnRxdWV1ZSBkaXJl
Y3RseS4KPiBJcyB0aGlzIGNvbW1lbnQgc3RpbGwgcmlnaHQ/IElzIHRoZXJlIGEgbWVkaWF0ZWQg
ZGV2aWNlIHN0aWxsPwo+Cj4gSmFzb24KCgpObywgd2lsbCBmaXguCgpUaGFua3MKCgo+CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
