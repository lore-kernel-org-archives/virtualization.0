From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC] Discuss about an new idea "Vsock over Virtio-net"
Date: Fri, 30 Nov 2018 21:10:03 +0800
Message-ID: <27cd8ac6-e892-cfaa-cd39-74f39b452681__15052.9812476181$1543583303$gmane$org@redhat.com>
References: <5BECEE53.7090408@huawei.com>
	<20181115015547-mutt-send-email-mst@kernel.org>
	<61d57505-7ff6-23c6-d26c-6a0062e08445@redhat.com>
	<20181129085049-mutt-send-email-mst@kernel.org>
	<7e78fc3d-0d5a-090f-476d-03ad490ff8a2@redhat.com>
	<20181130075134-mutt-send-email-mst@kernel.org>
	<55352308-9ceb-413e-44f6-e3dfd8f642cc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <55352308-9ceb-413e-44f6-e3dfd8f642cc@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTgvMTEvMzAg5LiL5Y2IODo1NSwgSmFzb24gV2FuZyB3cm90ZToKPgo+IE9uIDIwMTgv
MTEvMzAg5LiL5Y2IODo1MiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4+IMKgwqAgSWYg
eW91IHdhbnQgdG8gY29tcGFyZSBpdCB3aXRoCj4+Pj4gc29tZXRoaW5nIHRoYXQgd291bGQgYmUg
VENQIG9yIFFVSUMuwqAgVGhlIGZ1bmRhbWVudGFsIGRpZmZlcmVuY2UgCj4+Pj4gYmV0d2Vlbgo+
Pj4+IHZpcnRpby12c29jayBhbmQgZS5nLiBUQ1AgaXMgdGhhdCBUQ1Agb3BlcmF0ZXMgaW4gYSBw
YWNrZXQgbG9zcyAKPj4+PiBlbnZpcm9ubWVudC4KPj4+PiBTbyB0aGV5IGFyZSB1c2luZyB0aW1l
cnMgZm9yIHJlbGlhYmlsaXR5LCBhbmQgcmVjZWl2ZXIgaXMgYWx3YXlzIAo+Pj4+IGZyZWUgdG8K
Pj4+PiBkaXNjYXJkIGFueSB1bmFja2VkIGRhdGEuCj4+PiBWaXJ0aW8tbmV0IGtub3dzIG5vdGhp
bmcgYWJvdmUgTDIsIHNvIHRoZXkgYXJlIHRvdGFsbHkgdHJhbnNwYXJlbnQgCj4+PiB0byBkZXZp
Y2UKPj4+IGl0c2VsZi4gSSBzdGlsbCBkb24ndCBnZXQgd2h5IG5vdCB1c2luZyB2aXJ0aW8tbmV0
IGluc3RlYWQuCj4+Pgo+Pj4KPj4+IFRoYW5rcwo+PiBJcyB5b3VyIHF1ZXN0aW9uIHdoeSBpcyB2
aXJ0aW8tdnNvY2sgdXNlZCBpbnN0ZWFkIG9mIFRDUCBvbiB0b3Agb2YgSVAKPj4gb24gdG9wIG9m
IHZpcnRpby1uZXQ/Cj4+Cj4+Cj4KPiBObywgbXkgcXVlc3Rpb24gaXMgd2h5IG5vdCBkbyB2c29j
ayB0aHJvdWdoIHZpcnRpby1uZXQuCj4KPiBUaGFua3MKPgoKSnVzdCB0byBjbGFyaWZ5LCBpdCdz
IG5vdCBhYm91dCB2b3NjayBvdmVyIGV0aGVybmV0LCBhbmQgaXQncyBub3QgYWJvdXQgCmludmVu
dGluZyBuZXcgZmVhdHVyZXMgb3IgQVBJcy4gSXQncyBwcm9iYWJseSBzb21ldGhpbmcgbGlrZToK
Ci0gTGV0IHZpcnRpby1uZXQgZHJpdmVyIHByb2JlIHZzb2NrIGRldmljZSBhbmQgZG8gdm9zY2sg
c3BlY2lmaWMgdGhpbmdzIAppZiBuZWVkZWQgdG8gc2hhcmUgYXMgbXVjaCBjb2Rlcy4KCi0gQSBu
ZXcga2luZCBvZiBzb2NrZmQgKHdoaWNoIGlzIHZzb2NrIGJhc2VkKSBmb3Igdmhvc3QtbmV0IGZv
ciBpdCB0byBkbyAKdnNvY2sgc3BlY2lmaWMgdGhpbmdzIChob3BlZnVsbHkgaXQgY2FuIGJlIHRy
YW5zcGFyZW50KS4KClRoZSBjaGFuZ2Ugc2hvdWxkIGJlIHRvdGFsbHkgdHJhbnNwYXJlbnQgdG8g
dXNlcnNwYWNlIGFwcGxpY2F0aW9ucy4KClRoYW5rcwoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
