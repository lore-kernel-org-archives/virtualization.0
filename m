From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost: introduce mdev based hardware backend
Date: Fri, 27 Sep 2019 16:31:31 +0800
Message-ID: <cc288a52-dc5e-1a59-6219-8835c898ea73__20625.4378355638$1569573118$gmane$org@redhat.com>
References: <20190926045427.4973-1-tiwei.bie@intel.com>
	<1b4b8891-8c14-1c85-1d6a-2eed1c90bcde@redhat.com>
	<20190927045438.GA17152@___>
	<49bb0777-3761-3737-8e5b-568957f9a935@redhat.com>
	<20190927080410.GA22568@___>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190927080410.GA22568@___>
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
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, zhihong.wang@intel.com, maxime.coquelin@redhat.com, lingshan.zhu@intel.com
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvOS8yNyDkuIvljYg0OjA0LCBUaXdlaSBCaWUgd3JvdGU6Cj4gT24gRnJpLCBTZXAg
MjcsIDIwMTkgYXQgMDM6MTQ6NDJQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4gT24gMjAx
OS85LzI3IOS4i+WNiDEyOjU0LCBUaXdlaSBCaWUgd3JvdGU6Cj4+Pj4+ICsKPj4+Pj4gKwkJLyoK
Pj4+Pj4gKwkJICogSW4gdmhvc3QtbWRldiwgdXNlcnNwYWNlIHNob3VsZCBwYXNzIHJpbmcgYWRk
cmVzc2VzCj4+Pj4+ICsJCSAqIGluIGd1ZXN0IHBoeXNpY2FsIGFkZHJlc3NlcyB3aGVuIElPTU1V
IGlzIGRpc2FibGVkIG9yCj4+Pj4+ICsJCSAqIElPVkFzIHdoZW4gSU9NTVUgaXMgZW5hYmxlZC4K
Pj4+Pj4gKwkJICovCj4+Pj4gQSBxdWVzdGlvbiBoZXJlLCBjb25zaWRlciB3ZSdyZSB1c2luZyBu
b2lvbW11IG1vZGUuIElmIGd1ZXN0IHBoeXNpY2FsCj4+Pj4gYWRkcmVzcyBpcyBwYXNzZWQgaGVy
ZSwgaG93IGNhbiBhIGRldmljZSB1c2UgdGhhdD8KPj4+Pgo+Pj4+IEkgYmVsaWV2ZSB5b3UgbWVh
bnQgImhvc3QgcGh5c2ljYWwgYWRkcmVzcyIgaGVyZT8gQW5kIGl0IGFsc28gaGF2ZSB0aGUKPj4+
PiBpbXBsaWNhdGlvbiB0aGF0IHRoZSBIUEEgc2hvdWxkIGJlIGNvbnRpbnVvdXMgKGUuZyB1c2lu
ZyBodWdldGxiZnMpLgo+Pj4gVGhlIGNvbW1lbnQgaXMgdGFsa2luZyBhYm91dCB0aGUgdmlydHVh
bCBJT01NVSAoaS5lLiBpb3RsYiBpbiB2aG9zdCkuCj4+PiBJdCBzaG91bGQgYmUgcmVwaHJhc2Vk
IHRvIGNvdmVyIHRoZSBub2lvbW11IGNhc2UgYXMgd2VsbC4gVGhhbmtzIGZvcgo+Pj4gc3BvdHRp
bmcgdGhpcy4KPj4KPj4gU28gdGhlIHF1ZXN0aW9uIHN0aWxsLCBpZiBHUEEgaXMgcGFzc2VkIGhv
dyBjYW4gaXQgYmUgdXNlZCBieSB0aGUKPj4gdmlydGlvLW1kZXYgZGV2aWNlPwo+IFNvcnJ5IGlm
IEkgZGlkbid0IG1ha2UgaXQgY2xlYXIuLgo+IE9mIGNvdXJzZSwgR1BBIGNhbid0IGJlIHBhc3Nl
ZCBpbiBub2lvbW11IG1vZGUuCgoKSSBzZWUuCgpUaGFua3MgZm9yIHRoZSBjb25maXJtYXRpb24u
CgoKPgo+Cj4+IFRoYW5rcwo+PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
