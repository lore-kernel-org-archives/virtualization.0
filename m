From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net V2 3/4] Revert "net: vhost: lock the vqs one by one"
Date: Thu, 13 Dec 2018 10:27:26 +0800
Message-ID: <6988960f-68da-af52-21b6-9cdf8bddca0c__1052.18415051258$1544667936$gmane$org@redhat.com>
References: <20181212100819.21295-1-jasowang@redhat.com>
	<20181212100819.21295-4-jasowang@redhat.com>
	<20181212092102-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181212092102-mutt-send-email-mst@kernel.org>
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

Ck9uIDIwMTgvMTIvMTIg5LiL5Y2IMTA6MjQsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBP
biBXZWQsIERlYyAxMiwgMjAxOCBhdCAwNjowODoxOFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+PiBUaGlzIHJldmVydHMgY29tbWl0IDc4MTM5Yzk0ZGM4Yzk2YTQ3OGU2N2RhYjNiZWU4NGRj
NmVjY2I1ZmQuIFdlIGRvbid0Cj4+IHByb3RlY3QgZGV2aWNlIElPVExCIHdpdGggdnEgbXV0ZXgs
IHdoaWNoIHdpbGwgbGVhZCBlLmcgdXNlIGFmdGVyIGZyZWUKPj4gZm9yIGRldmljZSBJT1RMQiBl
bnRyaWVzLiBBbmQgc2luY2Ugd2UndmUgc3dpdGNoZWQgdG8gdXNlCj4+IG11dGV4X3RyeWxvY2so
KSBpbiBwcmV2aW91cyBwYXRjaCwgaXQncyBzYWZlIHRvIHJldmVydCBpdCB3aXRob3V0Cj4+IGhh
dmluZyBkZWFkbG9jay4KPj4KPj4gRml4ZXM6IGNvbW1pdCA3ODEzOWM5NGRjOGMgKCJuZXQ6IHZo
b3N0OiBsb2NrIHRoZSB2cXMgb25lIGJ5IG9uZSIpCj4+IENjOiBUb25naGFvIFpoYW5nPHhpYW5n
eGlhLm0ueXVlQGdtYWlsLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZzxqYXNvd2Fu
Z0ByZWRoYXQuY29tPgo+IEFja2VkLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW48bXN0QHJlZGhhdC5j
b20+Cj4KPiBJJ2QgdHJ5IHRvIHB1dCB0aGlzIGluIDQuMjAgaWYgd2UgY2FuCj4gYW5kIGl0J3Mg
bmVlZGVkIGZvciAtc3RhYmxlIEkgdGhpbmsuCj4KPiBBbHNvIGxvb2tzIGxpa2Ugd2Ugc2hvdWxk
IGFsbG93IGlvdGxiIGVudHJpZXMgcGVyIHZxCj4gdG8gaW1wcm92ZSBsb2NraW5nLiBXaGF0IGRv
IHlvdSB0aGluaz8KPgoKWWVzLCB3ZSBjYW4gZG8gaXQgZm9yIC1uZXh0LgoKVGhhbmtzCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
