From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] Revert "vhost: cache used event for better
	performance"
Date: Wed, 26 Jul 2017 21:18:02 +0800
Message-ID: <117542fc-eef9-c043-7c9e-daafceb7db4e__10500.8252816789$1501075114$gmane$org@redhat.com>
References: <1501056197-3368-1-git-send-email-jasowang@redhat.com>
	<20170726155435-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170726155435-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE35bm0MDfmnIgyNuaXpSAyMDo1NywgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
IE9uIFdlZCwgSnVsIDI2LCAyMDE3IGF0IDA0OjAzOjE3UE0gKzA4MDAsIEphc29uIFdhbmcgd3Jv
dGU6Cj4+IFRoaXMgcmV2ZXJ0cyBjb21taXQgODA5ZWNiOWJjYTZhOTQyNGNjZDM5MmQ2N2UzNjgx
NjBmOGI3NmM5Mi4gU2luY2UgaXQKPj4gd2FzIHJlcG9ydGVkIHRvIGJyZWFrIHZob3N0X25ldC4g
V2Ugd2FudCB0byBjYWNoZSB1c2VkIGV2ZW50IGFuZCB1c2UKPj4gaXQgdG8gY2hlY2sgZm9yIG5v
dGlmaWNhdGlvbi4gV2UgdHJ5IHRvIHZhbGlkIGNhY2hlZCB1c2VkIGV2ZW50IGJ5Cj4+IGNoZWNr
aW5nIHdoZXRoZXIgb3Igbm90IGl0IHdhcyBhaGVhZCBvZiBuZXcsIGJ1dCB0aGlzIGlzIG5vdCBj
b3JyZWN0Cj4+IGFsbCB0aGUgdGltZSwgaXQgY291bGQgYmUgc3RhbGUgYW5kIHRoZXJlJ3Mgbm8g
d2F5IHRvIGtub3cgYWJvdXQgdGhpcy4KPj4KPj4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZzxq
YXNvd2FuZ0ByZWRoYXQuY29tPgo+IENvdWxkIHlvdSBzdXBwbHkgYSBiaXQgbW9yZSBkYXRhIGhl
cmUgcGxlYXNlPyAgSG93IGRvZXMgaXQgZ2V0IHN0YWxlPwo+IFdoYXQgZG9lcyBndWVzdCBuZWVk
IHRvIGRvIHRvIG1ha2UgaXQgc3RhbGU/ICBUaGlzIHdpbGwgYmUgaGVscGZ1bCBpZgo+IGFueW9u
ZSB3YW50cyB0byBicmluZyBpdCBiYWNrLCBvciBpZiB3ZSB3YW50IHRvIGV4dGVuZCB0aGUgcHJv
dG9jb2wuCj4KClRoZSBwcm9ibGVtIHdlIGRvbid0IGtub3cgd2hldGhlciBvciBub3QgZ3Vlc3Qg
aGFzIHB1Ymxpc2hlZCBhIG5ldyB1c2VkIApldmVudC4gVGhlIGNoZWNrIHZyaW5nX25lZWRfZXZl
bnQodnEtPmxhc3RfdXNlZF9ldmVudCwgbmV3ICsgdnEtPm51bSwgCm5ldykgaXMgbm90IHN1ZmZp
Y2llbnQgdG8gY2hlY2sgZm9yIHRoaXMuCgpUaGFua3MKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
