From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next V4 5/5] vhost: access vq metadata through kernel
	virtual address
Date: Fri, 25 Jan 2019 17:16:32 +0800
Message-ID: <18e64692-2598-6e95-3b93-c34528d04c1b__45266.1625736923$1548442063$gmane$org@redhat.com>
References: <20190123095557.30168-1-jasowang@redhat.com>
	<20190123095557.30168-6-jasowang@redhat.com>
	<20190123085821-mutt-send-email-mst@kernel.org>
	<335ba55b-087f-4b35-6311-540070b9647f@redhat.com>
	<20190124215912-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190124215912-mutt-send-email-mst@kernel.org>
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

Ck9uIDIwMTkvMS8yNSDkuIrljYgxMTowMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9u
IFRodSwgSmFuIDI0LCAyMDE5IGF0IDEyOjA3OjU0UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+PiBNZWFud2hpbGUsIGNvdWxkIHlvdSBwbHMgcG9zdCBkYXRhIGNvbXBhcmluZyB0aGlzIGxh
c3QgcGF0Y2ggd2l0aCB0aGUKPj4+IGJlbG93PyAgVGhpcyByZW1vdmVzIHRoZSBzcGVjdWxhdGlv
biBiYXJyaWVyIHJlcGxhY2luZyBpdCB3aXRoIGEKPj4+ICh1c2VsZXNzIGJ1dCBhdCBsZWFzdCBt
b3JlIGxpZ2h0d2VpZ2h0KSBkYXRhIGRlcGVuZGVuY3kuCj4+IFNNQVAgb2ZmCj4+Cj4+IFlvdXIg
cGF0Y2g6IDcuMk1QUHMKPj4KPj4gdm1hcDogNy40TXBwcwo+IE9LIHNvIHdoaWxlIHdlIGtlZXAg
bG9va2luZyBpbnRvIHZtYXAsIHdoeSBkb24ndCB3ZSBtZXJnZSBzb21ldGhpbmcgbGlrZQo+IHRo
ZSBiZWxvdz8gIFNlZW1zIHF1aXRlIHN0cmFpZ2h0IGZvcndhcmQgLi4uCj4KClRoZSBwcm9ibGVt
IGlzIGl0IGdpdmVzIH44JSByZWdyZXNzaW9uIG9uIFBQUyB3aGVuIFNNQVAgaXMgb24uIFRoaXMg
aXMgCnByb2JhYmx5IGJlY2F1c2UgdGhlIGxhdGVuY3kgb2YgbGZlbmNlIGlzIGhpZGVkIGJ5IHBy
ZXZpb3VzIHN0YWMgYXMgCm1lbnRpb25lZCBpbiB0aGUgY29tbWl0IGIzYmJmYjNmYjVkMjU3NzZi
OGUzZjM2MWQyZWVkYWFiYjBiNDk2Y2QuCgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
