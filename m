From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/5] VSOCK: support fill data to mergeable rx buffer in
	host
Date: Wed, 7 Nov 2018 21:32:42 +0800
Message-ID: <76732898-8e4f-910a-aac5-ea4b635a1c15__26888.6981452399$1541597452$gmane$org@redhat.com>
References: <5BDFF537.3050806@huawei.com>
	<485c2c5d-d73e-e679-9549-aad3de02f0ab@redhat.com>
	<5BE134EF.1070009@huawei.com>
	<8963dba5-c2fb-69d0-4adb-72d751a9dedf@redhat.com>
	<5BE2903C.50608@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5BE2903C.50608@huawei.com>
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
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTgvMTEvNyDkuIvljYgzOjExLCBqaWFuZ3lpd2VuIHdyb3RlOgo+IE9uIDIwMTgvMTEv
NyAxNDoxOCwgSmFzb24gV2FuZyB3cm90ZToKPj4gT24gMjAxOC8xMS82IOS4i+WNiDI6MzAsIGpp
YW5neWl3ZW4gd3JvdGU6Cj4+Pj4gU2VlbXMgZHVwbGljYXRlZCB3aXRoIHRoZSBvbmUgdXNlZCBi
eSB2aG9zdC1uZXQuCj4+Pj4KPj4+PiBJbiBwYWNrZWQgdmlydHF1ZXVlIGltcGxlbWVudGF0aW9u
LCBJIHBsYW4gdG8gbW92ZSB0aGlzIHRvIHZob3N0LmMuCj4+Pj4KPj4+IFllcywgdGhpcyBjb2Rl
IGlzIGZ1bGwgY29waWVkIGZyb20gdmhvc3QtbmV0LCBpZiBpdCBjYW4gYmUgcGFja2VkIGludG8K
Pj4+IHZob3N0LmMsIGl0IHdvdWxkIGJlIGdyZWF0Lgo+Pj4KPj4gSWYgeW91IHRyeSB0byByZXVz
ZSB2aG9zdC1uZXQsIHlvdSBkb24ndCBldmVuIG5lZWQgdG8gY2FyZSBhYm91dCB0aGlzOikKPj4K
Pj4gVGhhbmtzCj4+Cj4+Cj4+IC4KPj4KPiBIaSBKYXNvbiwKPgo+IFRoYW5rIHlvdXIgYWR2aWNl
LCBJIHdpbGwgY29uc2lkZXIgeW91ciBpZGVhLiBCdXQgSSBkb24ndCBrbm93Cj4gd2hhdCdzIHN0
ZWZhbidzIHN1Z2dlc3Rpb24/IEl0IHNlZW1zIHRoYXQgaGUgZG9lc24ndCBjYXJlIG11Y2gKPiBh
Ym91dCB0aGlzIGNvbW11bml0eS46KAoKCkkgdGhpbmsgbm90LiBIZSBpcyBwcm9iYWJseSBidXN5
IHRoZXNlIGRheXMuCgoKPgo+IEkgc3RpbGwgaG9wZSB0aGlzIGNvbW11bml0eSBjYW4gaGF2ZSBz
b21lIHZpdGFsaXR5Lgo+CgpMZXQncyB3YWl0IGZvciBmZXcgbW9yZSBkYXlzIGZvciB0aGUgcG9z
c2libGUgY29tbWVudHMgZnJvbSBTdGVmYW4gb3IgCk1pY2hhZWwuIEJ1dCBJIGRvIHByZWZlciB0
byB1bmlmeSB0aGUgdmlydGlvIG5ldHdvcmtpbmcgZGF0YXBhdGggd2hpY2ggCndpbGwgYmUgZWFz
aWVyIHRvIGJlIGV4dGVuZGVkIGFuZCBtYWludGFpbmVkLgoKVGhhbmtzCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
