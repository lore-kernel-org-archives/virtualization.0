From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next 7/8] vhost_net: try batch dequing from skb array
Date: Wed, 29 Mar 2017 17:58:23 +0800
Message-ID: <bf511f4a-b1d0-d732-a01e-9cd4b8ae6817__15389.788701623$1490781533$gmane$org@redhat.com>
References: <1490069087-4783-1-git-send-email-jasowang@redhat.com>
	<1490069087-4783-8-git-send-email-jasowang@redhat.com>
	<20170322155111-mutt-send-email-mst@kernel.org>
	<f41bb12f-10d6-9fb2-1cd2-76e3e9460aff@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <f41bb12f-10d6-9fb2-1cd2-76e3e9460aff@redhat.com>
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

CgpPbiAyMDE35bm0MDPmnIgyM+aXpSAxMzozNCwgSmFzb24gV2FuZyB3cm90ZToKPgo+Cj4+Cj4+
PiArewo+Pj4gKyAgICBpZiAocnZxLT5yaCAhPSBydnEtPnJ0KQo+Pj4gKyAgICAgICAgZ290byBv
dXQ7Cj4+PiArCj4+PiArICAgIHJ2cS0+cmggPSBydnEtPnJ0ID0gMDsKPj4+ICsgICAgcnZxLT5y
dCA9IHNrYl9hcnJheV9jb25zdW1lX2JhdGNoZWRfYmgocnZxLT5yeF9hcnJheSwgcnZxLT5yeHEs
Cj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgVkhPU1RfUlhfQkFUQ0gpOwo+PiBBIGNvbW1l
bnQgZXhwbGFpbmluZyB3aHkgaXMgaXMgLWJoIHdvdWxkIGJlIGhlbHBmdWwuCj4KPiBPay4KPgo+
IFRoYW5rcyAKClJldGhpbmsgYWJvdXQgdGhpcy4gSXQgbG9va3MgbGlrZSAtYmggaXMgbm90IG5l
ZWRlZCBpbiB0aGlzIGNhc2Ugc2luY2UgCm5vIGNvbnN1bWVyIHJ1biBpbiBiaC4KClRoYW5rcwpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
