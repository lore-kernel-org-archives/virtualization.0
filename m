From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net 3/4] vhost: vsock: add weight support
Date: Fri, 17 May 2019 09:05:30 +0800
Message-ID: <70c24182-9238-1a69-8e35-53c98b957bc7__14597.8527421661$1558055151$gmane$org@redhat.com>
References: <1557992862-27320-1-git-send-email-jasowang@redhat.com>
	<1557992862-27320-4-git-send-email-jasowang@redhat.com>
	<20190516093352.GQ29507@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190516093352.GQ29507@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvNS8xNiDkuIvljYg1OjMzLCBTdGVmYW4gSGFqbm9jemkgd3JvdGU6Cj4gT24gVGh1
LCBNYXkgMTYsIDIwMTkgYXQgMDM6NDc6NDFBTSAtMDQwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4g
QEAgLTE4Myw3ICsxODQsOCBAQCBzdGF0aWMgc3RydWN0IHZob3N0X3Zzb2NrICp2aG9zdF92c29j
a19nZXQodTMyIGd1ZXN0X2NpZCkKPj4gICAJCXZpcnRpb190cmFuc3BvcnRfZGVsaXZlcl90YXBf
cGt0KHBrdCk7Cj4+ICAgCj4+ICAgCQl2aXJ0aW9fdHJhbnNwb3J0X2ZyZWVfcGt0KHBrdCk7Cj4+
IC0JfQo+PiArCQl0b3RhbF9sZW4gKz0gcGt0LT5sZW47Cj4gUGxlYXNlIGluY3JlbWVudCB0b3Rh
bF9sZW4gYmVmb3JlIHZpcnRpb190cmFuc3BvcnRfZnJlZV9wa3QocGt0KSB0bwo+IGF2b2lkIHVz
ZS1hZnRlci1mcmVlLgoKClJpZ2h0LCBsZXQgbWUgZml4IHRoaXMuCgpUaGFua3MKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
