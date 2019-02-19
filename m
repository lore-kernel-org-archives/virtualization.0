From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] vhost: correctly check the return value of
	translate_desc() in log_used()
Date: Tue, 19 Feb 2019 14:51:26 +0800
Message-ID: <ca449a21-5018-19ad-1b20-f9a1348ae6d2__37937.6104728848$1550559143$gmane$org@redhat.com>
References: <20190215075324.18891-1-jasowang@redhat.com>
	<20190215084502.23feed0e@shemminger-XPS-13-9360>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190215084502.23feed0e@shemminger-XPS-13-9360>
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
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMi8xNiDkuIrljYgxMjo0NSwgU3RlcGhlbiBIZW1taW5nZXIgd3JvdGU6Cj4gT24g
RnJpLCAxNSBGZWIgMjAxOSAxNTo1MzoyNCArMDgwMAo+IEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgo+Cj4+IFdoZW4gZmFpbCwgdHJhbnNsYXRlX2Rlc2MoKSByZXR1cm5z
IG5lZ2F0aXZlIHZhbHVlLCBvdGhlcndpc2UgdGhlCj4+IG51bWJlciBvZiBpb3ZzLiBTbyB3ZSBz
aG91bGQgZmFpbCB3aGVuIHRoZSByZXR1cm4gdmFsdWUgaXMgbmVnYXRpdmUKPj4gaW5zdGVhZCBv
ZiBhIGJsaW5kbHkgY2hlY2sgYWdhaW5zdCB6ZXJvLgo+Pgo+PiBSZXBvcnRlZC1ieTogU3RlcGhl
biBIZW1taW5nZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPgo+PiBGaXhlczogY2M1ZTcx
MDc1OTQ3ICgidmhvc3Q6IGxvZyBkaXJ0eSBwYWdlIGNvcnJlY3RseSIpCj4+IFNpZ25lZC1vZmYt
Ynk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gTG9va3MgZ29vZC4gSXQgaXMg
YmVzdCB0byBwdXQgdGhlIEFkZHJlc3Nlcy1Db3Zlcml0eS1JZCB0YWcgb24gdGhlc2Uga2luZAo+
IG9mIGJ1ZyBmaXhlcyBzbyB0aGF0IHRoZSBhdXRvbWF0ZWQgdG9vbHMgc2VlIGl0LgoKCk9rLiBX
aWxsIGRvIHRoaXMgaW4gVjIuCgpUaGFua3MKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
