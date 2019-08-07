From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 01/10] vhost: disable metadata prefetch optimization
Date: Wed, 7 Aug 2019 15:05:49 +0800
Message-ID: <a084127d-4acb-dceb-3bb6-617eb79734e4@redhat.com>
References: <20190807065449.23373-1-jasowang@redhat.com>
	<20190807065449.23373-2-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190807065449.23373-2-jasowang@redhat.com>
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
To: mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvOC83IOS4i+WNiDI6NTQsIEphc29uIFdhbmcgd3JvdGU6Cj4gRnJvbTogIk1pY2hh
ZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPgo+Cj4gVGhpcyBzZWVtcyB0byBjYXVzZSBn
dWVzdCBhbmQgaG9zdCBtZW1vcnkgY29ycnVwdGlvbi4KPiBEaXNhYmxlIGZvciBub3cgdW50aWwg
d2UgZ2V0IGEgYmV0dGVyIGhhbmRsZSBvbiB0aGF0Lgo+Cj4gU2lnbmVkLW9mZi1ieTogTWljaGFl
bCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmhvc3Qvdmhv
c3QuaCB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuaCBiL2RyaXZlcnMvdmhv
c3Qvdmhvc3QuaAo+IGluZGV4IDgxOTI5NjMzMjkxMy4uNDJhOGMyYTEzYWIxIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuaAo+ICsrKyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuaAo+
IEBAIC05Niw3ICs5Niw3IEBAIHN0cnVjdCB2aG9zdF91YWRkciB7Cj4gICB9Owo+ICAgCj4gICAj
aWYgZGVmaW5lZChDT05GSUdfTU1VX05PVElGSUVSKSAmJiBBUkNIX0lNUExFTUVOVFNfRkxVU0hf
RENBQ0hFX1BBR0UgPT0gMAo+IC0jZGVmaW5lIFZIT1NUX0FSQ0hfQ0FOX0FDQ0VMX1VBQ0NFU1Mg
MQo+ICsjZGVmaW5lIFZIT1NUX0FSQ0hfQ0FOX0FDQ0VMX1VBQ0NFU1MgMAo+ICAgI2Vsc2UKPiAg
ICNkZWZpbmUgVkhPU1RfQVJDSF9DQU5fQUNDRUxfVUFDQ0VTUyAwCj4gICAjZW5kaWYKCgpPb3Bz
LCB0aGlzIGlzIHVubmVjZXNzYXJ5LgoKV2lsbCBwb3N0IFY0LgoKVGhhbmtzCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
