From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next 6/8] virtio: introduce packed ring defines
Date: Thu, 5 Jul 2018 19:30:18 +0800
Message-ID: <196f5521-9215-c163-aa7c-38caf3f1e7a4@redhat.com>
References: <1530596284-4101-1-git-send-email-jasowang@redhat.com>
	<1530596284-4101-7-git-send-email-jasowang@redhat.com>
	<0f293989-a0ca-e7ad-f907-83a8d8445335@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <0f293989-a0ca-e7ad-f907-83a8d8445335@redhat.com>
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
To: Maxime Coquelin <maxime.coquelin@redhat.com>, mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDfmnIgwNeaXpSAwNDoxNSwgTWF4aW1lIENvcXVlbGluIHdyb3RlOgo+Cj4K
PiBPbiAwNy8wMy8yMDE4IDA3OjM4IEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19yaW5nLmggCj4+IGIvaW5jbHVkZS91YXBpL2xp
bnV4L3ZpcnRpb19yaW5nLmgKPj4gaW5kZXggNmQ1ZDVmYS4uNzFjN2E0NiAxMDA2NDQKPj4gLS0t
IGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19yaW5nLmgKPj4gKysrIGIvaW5jbHVkZS91YXBp
L2xpbnV4L3ZpcnRpb19yaW5nLmgKPj4gQEAgLTQzLDYgKzQzLDggQEAKPj4gwqAgI2RlZmluZSBW
UklOR19ERVNDX0ZfV1JJVEXCoMKgwqAgMgo+PiDCoCAvKiBUaGlzIG1lYW5zIHRoZSBidWZmZXIg
Y29udGFpbnMgYSBsaXN0IG9mIGJ1ZmZlciBkZXNjcmlwdG9ycy4gKi8KPj4gwqAgI2RlZmluZSBW
UklOR19ERVNDX0ZfSU5ESVJFQ1TCoMKgwqAgNAo+PiArI2RlZmluZSBWUklOR19ERVNDX0ZfQVZB
SUzCoMKgwqDCoMKgIDcKPj4gKyNkZWZpbmUgVlJJTkdfREVTQ19GX1VTRUTCoMKgwqAgMTUKPgo+
IEZvciBjb25zaXN0ZW5jeSwgeW91IG1heSB3YW50IHRvIG1ha2UgVlJJTkdfREVTQ19GX0FWQUlM
IGFuZCAKPiBWUklOR19ERVNDX0ZfVVNFRCB0byByZXByZXNlbnQgdGhlIGJpdCBtYXNrIGFuZCBu
b3QgdGhlIGJpdCBwb3NpdGlvbiwKPiBhcyBkb25lIGZvciBWUklOR19ERVNDX0ZfV1JJVEUgYW5k
IFZSSU5HX0RFU0NfRl9JTkRJUkVDVC4KPgo+IFJlZ2FyZHMsCj4gTWF4aW1lCgpZZXMsIFRpd2Vp
IGhhcyB0aGUgc2FtZSBjb21tZW50LgoKV2lsbCBmaXggdGhpcy4KClRoYW5rcwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
