From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 5/6] vdpa: introduce virtio pci driver
Date: Mon, 8 Jun 2020 11:32:31 +0800
Message-ID: <9b1abd2b-232c-aa0f-d8bb-03e65fd47de2@redhat.com>
References: <20200529080303.15449-1-jasowang@redhat.com>
 <20200529080303.15449-6-jasowang@redhat.com>
 <20200602010332-mutt-send-email-mst@kernel.org>
 <5dbb0386-beeb-5bf4-d12e-fb5427486bb8@redhat.com>
 <6b1d1ef3-d65e-08c2-5b65-32969bb5ecbc@redhat.com>
 <20200607095012-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200607095012-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: shahafs@mellanox.com, lulu@redhat.com, kvm@vger.kernel.org, saugatm@xilinx.com, netdev@vger.kernel.org, mhabets@solarflare.com, vmireyno@marvell.com, linux-kernel@vger.kernel.org, gdawar@xilinx.com, virtualization@lists.linux-foundation.org, eperezma@redhat.com, hanand@xilinx.com, zhangweining@ruijie.com.cn, eli@mellanox.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMjAvNi83IOS4i+WNiDk6NTEsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBPbiBG
cmksIEp1biAwNSwgMjAyMCBhdCAwNDo1NDoxN1BNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+
PiBPbiAyMDIwLzYvMiDkuIvljYgzOjA4LCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+PiArc3RhdGlj
IGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkIHZwX3ZkcGFfaWRfdGFibGVbXSA9IHsKPj4+Pj4g
K8KgwqDCoCB7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9SRURIQVRfUVVNUkFORVQsIFBDSV9B
TllfSUQpIH0sCj4+Pj4+ICvCoMKgwqAgeyAwIH0KPj4+Pj4gK307Cj4+Pj4gVGhpcyBsb29rcyBs
aWtlIGl0J2xsIGNyZWF0ZSBhIG1lc3Mgd2l0aCBlaXRoZXIgdmlydGlvIHBjaQo+Pj4+IG9yIHZk
cGEgYmVpbmcgbG9hZGVkIGF0IHJhbmRvbS4gTWF5YmUganVzdCBkb24ndCBzcGVjaWZ5Cj4+Pj4g
YW55IElEcyBmb3Igbm93LiBEb3duIHRoZSByb2FkIHdlIGNvdWxkIGdldCBhCj4+Pj4gZGlzdGlu
Y3QgdmVuZG9yIElEIG9yIGEgcmFuZ2Ugb2YgZGV2aWNlIElEcyBmb3IgdGhpcy4KPj4+Cj4+PiBS
aWdodCwgd2lsbCBkby4KPj4+Cj4+PiBUaGFua3MKPj4KPj4gUmV0aGluayBhYm91dCB0aGlzLiBJ
ZiB3ZSBkb24ndCBzcGVjaWZ5IGFueSBJRCwgdGhlIGJpbmRpbmcgd29uJ3Qgd29yay4KPiBXZSBj
YW4gYmluZCBtYW51YWxseS4gSXQncyBub3QgcmVhbGx5IGZvciBwcm9kdWN0aW9uIGFueXdheSwg
c28KPiBub3QgYSBiaWcgZGVhbCBpbWhvLgoKCkkgdGhpbmsgeW91IG1lYW4gZG9pbmcgaXQgdmlh
ICJuZXdfaWQiLCByaWdodC4KCgo+Cj4+IEhvdyBhYm91dCB1c2luZyBhIGRlZGljYXRlZCBzdWJz
eXN0ZW0gdmVuZG9yIGlkIGZvciB0aGlzPwo+Pgo+PiBUaGFua3MKPiBJZiB2aXJ0aW8gdmVuZG9y
IGlkIGlzIHVzZWQgdGhlbiBzdGFuZGFyZCBkcml2ZXIgaXMgZXhwZWN0ZWQKPiB0byBiaW5kLCBy
aWdodD8gTWF5YmUgdXNlIGEgZGVkaWNhdGVkIHZlbmRvciBpZD8KCgpJIG1lYW50IHNvbWV0aGlu
ZyBsaWtlOgoKc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkIHZwX3ZkcGFfaWRfdGFi
bGVbXSA9IHsKIMKgwqDCoCB7IFBDSV9ERVZJQ0VfU1VCKFBDSV9WRU5ET1JfSURfUkVESEFUX1FV
TVJBTkVULCBQQ0lfQU5ZX0lELCAKVlBfVEVTVF9WRU5ET1JfSUQsIFZQX1RFU1RfREVWSUNFX0lE
KSB9LAogwqDCoMKgIHsgMCB9Cn07CgpUaGFua3MKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
