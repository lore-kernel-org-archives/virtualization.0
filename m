From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/5] VSOCK: support fill data to mergeable rx buffer in
	host
Date: Thu, 8 Nov 2018 16:20:45 +0800
Message-ID: <83572636-5027-0ffa-3b1e-1d1d44907f03__47235.1767974489$1541665145$gmane$org@redhat.com>
References: <5BDFF537.3050806@huawei.com>
	<485c2c5d-d73e-e679-9549-aad3de02f0ab@redhat.com>
	<5BE134EF.1070009@huawei.com>
	<8963dba5-c2fb-69d0-4adb-72d751a9dedf@redhat.com>
	<5BE2903C.50608@huawei.com>
	<76732898-8e4f-910a-aac5-ea4b635a1c15@redhat.com>
	<5BE397CA.5060000@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5BE397CA.5060000@huawei.com>
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
To: jiangyiwen <jiangyiwen@huawei.com>, stefanha@redhat.com, stefanha@gmail.com
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTgvMTEvOCDkuIrljYg5OjU2LCBqaWFuZ3lpd2VuIHdyb3RlOgo+IE9uIDIwMTgvMTEv
NyAyMTozMiwgSmFzb24gV2FuZyB3cm90ZToKPj4gT24gMjAxOC8xMS83IOS4i+WNiDM6MTEsIGpp
YW5neWl3ZW4gd3JvdGU6Cj4+PiBPbiAyMDE4LzExLzcgMTQ6MTgsIEphc29uIFdhbmcgd3JvdGU6
Cj4+Pj4gT24gMjAxOC8xMS82IOS4i+WNiDI6MzAsIGppYW5neWl3ZW4gd3JvdGU6Cj4+Pj4+PiBT
ZWVtcyBkdXBsaWNhdGVkIHdpdGggdGhlIG9uZSB1c2VkIGJ5IHZob3N0LW5ldC4KPj4+Pj4+Cj4+
Pj4+PiBJbiBwYWNrZWQgdmlydHF1ZXVlIGltcGxlbWVudGF0aW9uLCBJIHBsYW4gdG8gbW92ZSB0
aGlzIHRvIHZob3N0LmMuCj4+Pj4+Pgo+Pj4+PiBZZXMsIHRoaXMgY29kZSBpcyBmdWxsIGNvcGll
ZCBmcm9tIHZob3N0LW5ldCwgaWYgaXQgY2FuIGJlIHBhY2tlZCBpbnRvCj4+Pj4+IHZob3N0LmMs
IGl0IHdvdWxkIGJlIGdyZWF0Lgo+Pj4+Pgo+Pj4+IElmIHlvdSB0cnkgdG8gcmV1c2Ugdmhvc3Qt
bmV0LCB5b3UgZG9uJ3QgZXZlbiBuZWVkIHRvIGNhcmUgYWJvdXQgdGhpczopCj4+Pj4KPj4+PiBU
aGFua3MKPj4+Pgo+Pj4+Cj4+Pj4gLgo+Pj4+Cj4+PiBIaSBKYXNvbiwKPj4+Cj4+PiBUaGFuayB5
b3VyIGFkdmljZSwgSSB3aWxsIGNvbnNpZGVyIHlvdXIgaWRlYS4gQnV0IEkgZG9uJ3Qga25vdwo+
Pj4gd2hhdCdzIHN0ZWZhbidzIHN1Z2dlc3Rpb24/IEl0IHNlZW1zIHRoYXQgaGUgZG9lc24ndCBj
YXJlIG11Y2gKPj4+IGFib3V0IHRoaXMgY29tbXVuaXR5LjooCj4+IEkgdGhpbmsgbm90LiBIZSBp
cyBwcm9iYWJseSBidXN5IHRoZXNlIGRheXMuCj4+Cj4+Cj4+PiBJIHN0aWxsIGhvcGUgdGhpcyBj
b21tdW5pdHkgY2FuIGhhdmUgc29tZSB2aXRhbGl0eS4KPj4+Cj4+IExldCdzIHdhaXQgZm9yIGZl
dyBtb3JlIGRheXMgZm9yIHRoZSBwb3NzaWJsZSBjb21tZW50cyBmcm9tIFN0ZWZhbiBvciBNaWNo
YWVsLiBCdXQgSSBkbyBwcmVmZXIgdG8gdW5pZnkgdGhlIHZpcnRpbyBuZXR3b3JraW5nIGRhdGFw
YXRoIHdoaWNoIHdpbGwgYmUgZWFzaWVyIHRvIGJlIGV4dGVuZGVkIGFuZCBtYWludGFpbmVkLgo+
Pgo+PiBUaGFua3MKPj4KPj4KPj4gLgo+Pgo+IEhpIEphc29uLAo+Cj4gQWN0dWFsbHkgdnNvY2sg
dXNlIHZpcnRpby1uZXQgYXMgdHJhbnNwb3J0IHBhdGggc2hvdWxkIGJlIGEgYmV0dGVyIGlkZWEs
Cj4gSSB3aWxsIHRyeSB0byBjb25zaWRlciB0aGUgbmV3IGlkZWEuCj4KPiBUaGFua3MsCj4gWWl3
ZW4uCj4KCkdvb2QgdG8ga25vdyB0aGlzIGFuZCB0aGFua3MhCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
