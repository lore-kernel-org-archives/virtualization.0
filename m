From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v2 1/3] x86/xen: Avoid fast syscall path for Xen PV guests
Date: Tue, 15 Dec 2015 16:48:30 +0100
Message-ID: <20151215154830.GF26000@pd.tnic>
References: <1447970147-1733-1-git-send-email-boris.ostrovsky@oracle.com>
	<1447970147-1733-2-git-send-email-boris.ostrovsky@oracle.com>
	<56703001.9010205@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <56703001.9010205@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: konrad.wilk@oracle.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, david.vrabel@citrix.com, luto@kernel.org, hpa@zytor.com, xen-devel@lists.xenproject.org, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

T24gVHVlLCBEZWMgMTUsIDIwMTUgYXQgMTA6MjE6MzdBTSAtMDUwMCwgQm9yaXMgT3N0cm92c2t5
IHdyb3RlOgo+IEkga25vdyB0aGlzIGhhcyBiZWVuIGluIHRoZSB0aXAgdHJlZSAtLS0gd2hlbiBk
byB5b3UgdGhpbmsgdGhpcyB3aWxsIGdvCj4gTGludXMgdHJlZT8gSW4gdGhlIDQuNCB0aW1lZnJh
bWU/CgpJdCBpcyBxdWV1ZWQgZm9yIDQuNSBjdXJyZW50bHkuCgo+IFhlbiAzMi1iaXQgUFYgZ3Vl
c3RzIGFyZSBicm9rZW4gd2l0aG91dCB0aGlzLgoKU28gdGhpcyBuZWVkcyB0byBnbyBpbnRvIDQu
NCBvciBldmVuIGVhcmxpZXI/IFNpbmNlIDVmMzEwZjczOWI0YyB3ZW50CmludG8gNC40LCBJJ2Qg
dGhpbmsgNC40IG9ubHkgZm9yIHRoaXMgZml4IHRvbz8gWWVzPwoKVGhhbmtzLgoKLS0gClJlZ2Fy
ZHMvR3J1c3MsCiAgICBCb3Jpcy4KClNVU0UgTGludXggR21iSCwgR0Y6IEZlbGl4IEltZW5kw7Zy
ZmZlciwgSmFuZSBTbWl0aGFyZCwgR3JhaGFtIE5vcnRvbiwgSFJCIDIxMjg0IChBRyBOw7xybmJl
cmcpCi0tIApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
