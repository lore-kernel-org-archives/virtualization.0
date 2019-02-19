From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] vhost: correctly check the return value of
	translate_desc() in log_used()
Date: Tue, 19 Feb 2019 14:50:46 +0800
Message-ID: <43623186-8759-507f-836e-0ef633b23264__36000.1453825802$1550559103$gmane$org@redhat.com>
References: <20190215075324.18891-1-jasowang@redhat.com>
	<20190215.100356.251698752340585300.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190215.100356.251698752340585300.davem@davemloft.net>
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
To: David Miller <davem@davemloft.net>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMi8xNiDkuIrljYgyOjAzLCBEYXZpZCBNaWxsZXIgd3JvdGU6Cj4gRnJvbTogSmFz
b24gV2FuZzxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+IERhdGU6IEZyaSwgMTUgRmViIDIwMTkgMTU6
NTM6MjQgKzA4MDAKPgo+PiBXaGVuIGZhaWwsIHRyYW5zbGF0ZV9kZXNjKCkgcmV0dXJucyBuZWdh
dGl2ZSB2YWx1ZSwgb3RoZXJ3aXNlIHRoZQo+PiBudW1iZXIgb2YgaW92cy4gU28gd2Ugc2hvdWxk
IGZhaWwgd2hlbiB0aGUgcmV0dXJuIHZhbHVlIGlzIG5lZ2F0aXZlCj4+IGluc3RlYWQgb2YgYSBi
bGluZGx5IGNoZWNrIGFnYWluc3QgemVyby4KPj4KPj4gUmVwb3J0ZWQtYnk6IFN0ZXBoZW4gSGVt
bWluZ2VyPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPgo+PiBGaXhlczogY2M1ZTcxMDc1OTQ3
ICgidmhvc3Q6IGxvZyBkaXJ0eSBwYWdlIGNvcnJlY3RseSIpCj4+IFNpZ25lZC1vZmYtYnk6IEph
c29uIFdhbmc8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiBKYXNvbiwgcGxlYXNlIHB1dCB0aGUgRml4
ZXMgdGFnIGZpcnN0Lgo+Cj4gVGhhbmsgeW91LgoKCk9rLiBXaWxsIHBvc3QgVjIuCgpUaGFua3MK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
