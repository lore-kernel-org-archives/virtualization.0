From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC 2/2] vhost: IFC VF vdpa layer
Date: Wed, 23 Oct 2019 17:58:00 +0800
Message-ID: <3c6c0319-7961-67ae-61d3-13771162dba7@redhat.com>
References: <20191016013050.3918-1-lingshan.zhu@intel.com>
	<20191016013050.3918-3-lingshan.zhu@intel.com>
	<9495331d-3c65-6f49-dcd9-bfdb17054cf0@redhat.com>
	<f65358e9-6728-8260-74f7-176d7511e989@intel.com>
	<1cae60b6-938d-e2df-2dca-fbf545f06853@redhat.com>
	<ddf412c6-69e2-b3ca-d0c8-75de1db78ed9@linux.intel.com>
	<a16461af-8e78-6089-aad2-8af6d1b487af@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <a16461af-8e78-6089-aad2-8af6d1b487af@intel.com>
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
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, mst@redhat.com, alex.williamson@redhat.com
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, zhiyuan.lv@intel.com, jason.zeng@intel.com
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMTAvMjMg5LiL5Y2INToyNCwgWmh1LCBMaW5nc2hhbiB3cm90ZToKPj4+Pj4KPj4+
Pj4KPj4+Pj4gc2V0X2NvbmZpZy9nZXRfY29uZmlnIGlzIG1pc3NpbmcuIEl0IGxvb2tzIHRvIG1l
IHRoZXkgYXJlIG5vdCAKPj4+Pj4gaGFyZCwganVzdCBpbXBsZW1lbnRpbmcgdGhlIGFjY2VzcyB0
byBkZXZfY2ZnLiBJdCdzIGtleSB0byBtYWtlIAo+Pj4+PiBrZXJuZWwgdmlydGlvIGRyaXZlciB0
byB3b3JrLgo+Pj4+Pgo+Pj4+PiBBbmQgaW4gdGhlIG5ldyB2ZXJzaW9uIG9mIHZpcml0by1tZGV2
LCBmZWF0dXJlcyBsaWtlIF9GX0xPR19BTEwgCj4+Pj4+IHNob3VsZCBiZSBhZHZlcnRpc2VkIHRo
cm91Z2ggZ2V0X21kZXZfZmVhdHVyZXMuCj4+Pj4gSU1ITywgY3VycmVudGx5IHRoZSBkcml2ZXIg
Y2FuIHdvcmsgd2l0aG91dCBzZXQvZ2V0X2NvbmZpZywgCj4+Pj4gdmhvc3RfbWRldiBkb2Vzbid0
IGNhbGwgdGhlbSBmb3Igbm93Lgo+Pj4KPj4+Cj4+PiBZZXMsIGJ1dCBpdCB3YXMgcmVxdWlyZWQg
YnkgdmlydGlvX21kZXYgZm9yIGhvc3QgZHJpdmVyIHRvIHdvcmssIGFuZCAKPj4+IGl0IGxvb2tz
IHRvIG1lIGl0J3Mgbm90IGhhcmQgdG8gYWRkIHRoZW0uIElmIHBvc3NpYmxlIHBsZWFzZSBhZGQg
Cj4+PiB0aGVtIGFuZCAidmlydGlvIiB0eXBlIHRoZW4gd2UgY2FuIHVzZSB0aGUgb3BzIGZvciBi
b3RoIHRoZSBjYXNlIG9mIAo+Pj4gVk0gYW5kIGNvbnRhaW5lcnMuCj4+IHN1cmUKPgo+IEhlbGxv
IEphc29uLAo+Cj4gSnVzdCB3YW50IHRvIGRvdWJsZSBjb25maXJtIHRoZSBpbXBsZW1lbnRhdGlv
biBvZiBzZXQvZ2V0X2NvbmZpZywgZm9yIAo+IG5vdywgZGV2X2NmZyBvbmx5IGNvbnRhaW5zIG1h
Y1s2XSwgc3RhdHVzIGFuZCBtYXhfdmlydHF1ZXVlX3BhaXJzLCBpcyAKPiB0aGF0IGVub3VnaCB0
byBzdXBwb3J0IHZpcnRpb19tZGV2Pwo+Cj4gVEhhbmtzIQoKClllcywgYW5kIGl0IGRlcGVuZHMg
b24gdGhlIGZlYXR1cmVzIHRoYXQgeW91IHdhbnQgdG8gYWR2ZXJ0aXNlLiBJZiB5b3UgCmRvbid0
IHdhbnQgdG8gYWR2ZXJ0aXNlIE1RLCB0aGVyZSdzIG5vIG5lZWQgdG8gZXhwb3NlIG1heF92aXJ0
cXVldWVfcGFpcnMuCgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
