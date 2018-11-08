From: jiangyiwen <jiangyiwen@huawei.com>
Subject: Re: [PATCH 2/5] VSOCK: support fill data to mergeable rx buffer in
	host
Date: Thu, 8 Nov 2018 09:56:26 +0800
Message-ID: <5BE397CA.5060000__19821.8506681316$1541642079$gmane$org@huawei.com>
References: <5BDFF537.3050806@huawei.com>
	<485c2c5d-d73e-e679-9549-aad3de02f0ab@redhat.com>
	<5BE134EF.1070009@huawei.com>
	<8963dba5-c2fb-69d0-4adb-72d751a9dedf@redhat.com>
	<5BE2903C.50608@huawei.com>
	<76732898-8e4f-910a-aac5-ea4b635a1c15@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <76732898-8e4f-910a-aac5-ea4b635a1c15@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>, stefanha@redhat.com, stefanha@gmail.com
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

T24gMjAxOC8xMS83IDIxOjMyLCBKYXNvbiBXYW5nIHdyb3RlOgo+IAo+IE9uIDIwMTgvMTEvNyDk
uIvljYgzOjExLCBqaWFuZ3lpd2VuIHdyb3RlOgo+PiBPbiAyMDE4LzExLzcgMTQ6MTgsIEphc29u
IFdhbmcgd3JvdGU6Cj4+PiBPbiAyMDE4LzExLzYg5LiL5Y2IMjozMCwgamlhbmd5aXdlbiB3cm90
ZToKPj4+Pj4gU2VlbXMgZHVwbGljYXRlZCB3aXRoIHRoZSBvbmUgdXNlZCBieSB2aG9zdC1uZXQu
Cj4+Pj4+Cj4+Pj4+IEluIHBhY2tlZCB2aXJ0cXVldWUgaW1wbGVtZW50YXRpb24sIEkgcGxhbiB0
byBtb3ZlIHRoaXMgdG8gdmhvc3QuYy4KPj4+Pj4KPj4+PiBZZXMsIHRoaXMgY29kZSBpcyBmdWxs
IGNvcGllZCBmcm9tIHZob3N0LW5ldCwgaWYgaXQgY2FuIGJlIHBhY2tlZCBpbnRvCj4+Pj4gdmhv
c3QuYywgaXQgd291bGQgYmUgZ3JlYXQuCj4+Pj4KPj4+IElmIHlvdSB0cnkgdG8gcmV1c2Ugdmhv
c3QtbmV0LCB5b3UgZG9uJ3QgZXZlbiBuZWVkIHRvIGNhcmUgYWJvdXQgdGhpczopCj4+Pgo+Pj4g
VGhhbmtzCj4+Pgo+Pj4KPj4+IC4KPj4+Cj4+IEhpIEphc29uLAo+Pgo+PiBUaGFuayB5b3VyIGFk
dmljZSwgSSB3aWxsIGNvbnNpZGVyIHlvdXIgaWRlYS4gQnV0IEkgZG9uJ3Qga25vdwo+PiB3aGF0
J3Mgc3RlZmFuJ3Mgc3VnZ2VzdGlvbj8gSXQgc2VlbXMgdGhhdCBoZSBkb2Vzbid0IGNhcmUgbXVj
aAo+PiBhYm91dCB0aGlzIGNvbW11bml0eS46KAo+IAo+IAo+IEkgdGhpbmsgbm90LiBIZSBpcyBw
cm9iYWJseSBidXN5IHRoZXNlIGRheXMuCj4gCj4gCj4+Cj4+IEkgc3RpbGwgaG9wZSB0aGlzIGNv
bW11bml0eSBjYW4gaGF2ZSBzb21lIHZpdGFsaXR5Lgo+Pgo+IAo+IExldCdzIHdhaXQgZm9yIGZl
dyBtb3JlIGRheXMgZm9yIHRoZSBwb3NzaWJsZSBjb21tZW50cyBmcm9tIFN0ZWZhbiBvciBNaWNo
YWVsLiBCdXQgSSBkbyBwcmVmZXIgdG8gdW5pZnkgdGhlIHZpcnRpbyBuZXR3b3JraW5nIGRhdGFw
YXRoIHdoaWNoIHdpbGwgYmUgZWFzaWVyIHRvIGJlIGV4dGVuZGVkIGFuZCBtYWludGFpbmVkLgo+
IAo+IFRoYW5rcwo+IAo+IAo+IC4KPiAKCkhpIEphc29uLAoKQWN0dWFsbHkgdnNvY2sgdXNlIHZp
cnRpby1uZXQgYXMgdHJhbnNwb3J0IHBhdGggc2hvdWxkIGJlIGEgYmV0dGVyIGlkZWEsCkkgd2ls
bCB0cnkgdG8gY29uc2lkZXIgdGhlIG5ldyBpZGVhLgoKVGhhbmtzLApZaXdlbi4KCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
