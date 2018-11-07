From: jiangyiwen <jiangyiwen@huawei.com>
Subject: Re: [PATCH 2/5] VSOCK: support fill data to mergeable rx buffer in
	host
Date: Wed, 7 Nov 2018 15:11:56 +0800
Message-ID: <5BE2903C.50608__45492.4098951325$1541574601$gmane$org@huawei.com>
References: <5BDFF537.3050806@huawei.com>
	<485c2c5d-d73e-e679-9549-aad3de02f0ab@redhat.com>
	<5BE134EF.1070009@huawei.com>
	<8963dba5-c2fb-69d0-4adb-72d751a9dedf@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <8963dba5-c2fb-69d0-4adb-72d751a9dedf@redhat.com>
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

T24gMjAxOC8xMS83IDE0OjE4LCBKYXNvbiBXYW5nIHdyb3RlOgo+IAo+IE9uIDIwMTgvMTEvNiDk
uIvljYgyOjMwLCBqaWFuZ3lpd2VuIHdyb3RlOgo+Pj4gU2VlbXMgZHVwbGljYXRlZCB3aXRoIHRo
ZSBvbmUgdXNlZCBieSB2aG9zdC1uZXQuCj4+Pgo+Pj4gSW4gcGFja2VkIHZpcnRxdWV1ZSBpbXBs
ZW1lbnRhdGlvbiwgSSBwbGFuIHRvIG1vdmUgdGhpcyB0byB2aG9zdC5jLgo+Pj4KPj4gWWVzLCB0
aGlzIGNvZGUgaXMgZnVsbCBjb3BpZWQgZnJvbSB2aG9zdC1uZXQsIGlmIGl0IGNhbiBiZSBwYWNr
ZWQgaW50bwo+PiB2aG9zdC5jLCBpdCB3b3VsZCBiZSBncmVhdC4KPj4KPiAKPiBJZiB5b3UgdHJ5
IHRvIHJldXNlIHZob3N0LW5ldCwgeW91IGRvbid0IGV2ZW4gbmVlZCB0byBjYXJlIGFib3V0IHRo
aXMgOikKPiAKPiBUaGFua3MKPiAKPiAKPiAuCj4gCgpIaSBKYXNvbiwKClRoYW5rIHlvdXIgYWR2
aWNlLCBJIHdpbGwgY29uc2lkZXIgeW91ciBpZGVhLiBCdXQgSSBkb24ndCBrbm93CndoYXQncyBz
dGVmYW4ncyBzdWdnZXN0aW9uPyBJdCBzZWVtcyB0aGF0IGhlIGRvZXNuJ3QgY2FyZSBtdWNoCmFi
b3V0IHRoaXMgY29tbXVuaXR5LiA6KAoKSSBzdGlsbCBob3BlIHRoaXMgY29tbXVuaXR5IGNhbiBo
YXZlIHNvbWUgdml0YWxpdHkuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
