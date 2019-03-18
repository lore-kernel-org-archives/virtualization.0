From: Jason Wang <jasowang@redhat.com>
Subject: Re: virtio-blk: should num_vqs be limited by num_possible_cpus()?
Date: Mon, 18 Mar 2019 15:47:26 +0800
Message-ID: <1df52766-88fb-6b23-d160-b891c3017133__37789.3020676979$1552895315$gmane$org@redhat.com>
References: <e4afe4c5-0262-4500-aeec-60f30734b4fc@default>
	<20190312183351.74764f4f.cohuck@redhat.com>
	<173d19c9-24db-35f2-269f-0b9b83bd0ad6@oracle.com>
	<20190313103900.1ea7f996.cohuck@redhat.com>
	<a3f24cfa-5160-0ccc-decc-a48362c8de19@oracle.com>
	<537e6420-8994-43d6-1d4d-ccb6e0fafa0b@redhat.com>
	<20190315134112.7d63348c.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190315134112.7d63348c.cohuck@redhat.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: axboe@kernel.dk, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMy8xNSDkuIvljYg4OjQxLCBDb3JuZWxpYSBIdWNrIHdyb3RlOgo+IE9uIEZyaSwg
MTUgTWFyIDIwMTkgMTI6NTA6MTEgKzA4MDAKPiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPgo+PiBPciBzb21ldGhpbmcgbGlrZSBJIHByb3Bvc2VkIHNldmVyYWwgeWVh
cnMgYWdvPwo+PiBodHRwczovL2RvLWRiMi5sa21sLm9yZy9sa21sLzIwMTQvMTIvMjUvMTY5Cj4+
Cj4+IEJ0dywgZm9yIHZpcnRpby1uZXQsIEkgdGhpbmsgd2UgYWN0dWFsbHkgd2FudCB0byBnbyBm
b3IgaGF2aW5nIGEgbWF4aW11bQo+PiBudW1iZXIgb2Ygc3VwcG9ydGVkIHF1ZXVlcyBsaWtlIHdo
YXQgaGFyZHdhcmUgZGlkLiBUaGlzIHdvdWxkIGJlIHVzZWZ1bAo+PiBmb3IgZS5nIGNwdSBob3Rw
bHVnIG9yIFhEUCAocmVxdWlyZXMgcGVyIGNwdSBUWCBxdWV1ZSkuIEJ1dCB0aGUgY3VycmVudAo+
PiB2ZWN0b3IgYWxsb2NhdGlvbiBkb2Vzbid0IHN1cHBvcnQgdGhpcyB3aGljaCB3aWxsIHJlc3Vs
dHMgYWxsIHZpcnRxdWV1ZXMKPj4gdG8gc2hhcmUgYSBzaW5nbGUgdmVjdG9yLiBXZSBtYXkgaW5k
ZWVkIG5lZWQgbW9yZSBmbGV4aWJsZSBwb2xpY3kgaGVyZS4KPiBJIHRoaW5rIGl0IHNob3VsZCBi
ZSBwb3NzaWJsZSBmb3IgdGhlIGRyaXZlciB0byBnaXZlIHRoZSB0cmFuc3BvcnQKPiBoaW50cyBo
b3cgdG8gc2V0IHVwIHRoZWlyIHF1ZXVlcy9pbnRlcnJ1cHQgc3RydWN0dXJlcy4gKFRoZSBkcml2
ZXIKPiBwcm9iYWJseSBrbm93cyBiZXN0IGFib3V0IGl0cyByZXF1aXJlbWVudHMuKSBQZXJoYXBz
IHdoZXRoZXIgYSBxdWV1ZSBpcwo+IGhpZ2ggb3IgbG93IGZyZXF1ZW5jeSwgb3Igd2hldGhlciBp
dCBzaG91bGQgYmUgbG93IGxhdGVuY3ksIG9yIGV2ZW4KPiB3aGV0aGVyIHR3byBxdWV1ZXMgY291
bGQgc2hhcmUgYSBub3RpZmljYXRpb24gbWVjaGFuaXNtIHdpdGhvdXQKPiBkcmF3YmFja3MuIEl0
J3MgdXAgdG8gdGhlIHRyYW5zcG9ydCB0byBtYWtlIHVzZSBvZiB0aGF0IGluZm9ybWF0aW9uLCBp
Zgo+IHBvc3NpYmxlLgoKCkV4YWN0bHkgYW5kIGl0IHdhcyB3aGF0IHRoZSBhYm92ZSBzZXJpZXMg
dHJpZWQgdG8gZG8gYnkgcHJvdmlkaW5nIGhpbnRzIApvZiBlLmcgd2hpY2ggcXVldWVzIHdhbnQg
dG8gc2hhcmUgYSBub3RpZmljYXRpb24uCgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
