From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Subject: Re: [RFC PATCH] virtio_net: Extend virtio to use VF datapath when
	available
Date: Tue, 19 Dec 2017 09:41:39 -0800
Message-ID: <ca709329-a47a-2e76-b1fc-38fc665d7c0b__17345.9564721727$1515606392$gmane$org@intel.com>
References: <1513644036-45230-1-git-send-email-sridhar.samudrala@intel.com>
	<20171219174259-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171219174259-mutt-send-email-mst@kernel.org>
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
Cc: netdev@vger.kernel.org, alexander.duyck@gmail.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDEyLzE5LzIwMTcgNzo0NyBBTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IEknbGwg
bmVlZCB0byBsb29rIGF0IHRoaXMgbW9yZSwgaW4gcGFydGljdWxhciB0aGUgZmVhdHVyZQo+IGJp
dCBpcyBtaXNzaW5nIGhlcmUuIEZvciBub3cgb25lIHF1ZXN0aW9uOgo+Cj4gT24gTW9uLCBEZWMg
MTgsIDIwMTcgYXQgMDQ6NDA6MzZQTSAtMDgwMCwgU3JpZGhhciBTYW11ZHJhbGEgd3JvdGU6Cj4+
IEBAIC01Niw2ICs1OCw4IEBAIG1vZHVsZV9wYXJhbShuYXBpX3R4LCBib29sLCAwNjQ0KTsKPj4g
ICAgKi8KPj4gICBERUNMQVJFX0VXTUEocGt0X2xlbiwgMCwgNjQpCj4+ICAgCj4+ICsjZGVmaW5l
IFZGX1RBS0VPVkVSX0lOVAkoSFogLyAxMCkKPj4gKwo+PiAgICNkZWZpbmUgVklSVE5FVF9EUklW
RVJfVkVSU0lPTiAiMS4wLjAiCj4+ICAgCj4+ICAgc3RhdGljIGNvbnN0IHVuc2lnbmVkIGxvbmcg
Z3Vlc3Rfb2ZmbG9hZHNbXSA9IHsKPiBXaHkgaXMgdGhpcyBkZWxheSBuZWNlc3Nhcnk/IEFuZCB3
aHkgYnkgMTAwbXM/CgpUaGlzIGlzIGJhc2VkIG9uIG5ldHZzYyBpbXBsZW1lbnRhdGlvbiBhbmQg
aGVyZSBpcyB0aGUgY29tbWl0IHRoYXQKYWRkZWQgdGhpcyBkZWxheS7CoCBOb3Qgc3VyZSBpZiB0
aGlzIG5lZWRzIHRvIGJlIDEwMG1zLgoKY29tbWl0IDYxMjNjNjY4NTRjMTc0ZTQ5ODJmOTgxOTUx
MDBjMWQ5OTBmOWU1ZTYKQXV0aG9yOiBzdGVwaGVuIGhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3Jr
cGx1bWJlci5vcmc+CkRhdGU6wqDCoCBXZWQgQXVnIDkgMTc6NDY6MDMgMjAxNyAtMDcwMAoKIMKg
wqDCoCBuZXR2c2M6IGRlbGF5IHNldHVwIG9mIFZGIGRldmljZQoKIMKgwqDCoCBXaGVuIFZGIGRl
dmljZSBpcyBkaXNjb3ZlcmVkLCBkZWxheSBicmluZyBpdCBhdXRvbWF0aWNhbGx5IHVwIGluCiDC
oMKgwqAgb3JkZXIgdG8gYWxsb3cgdXNlcnNwYWNlIHRvIHNvbWUgc2ltcGxlIGNoYW5nZXMgKGxp
a2UgcmVuYW1pbmcpLgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
