From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/2] virtio_ring: Use DMA API if memory is encrypted
Date: Thu, 17 Oct 2019 10:33:59 +0800
Message-ID: <398dce4b-9290-0b14-28b1-e521331ec309__40494.67792954$1571279666$gmane$org@redhat.com>
References: <1570843519-8696-1-git-send-email-linuxram@us.ibm.com>
	<1570843519-8696-2-git-send-email-linuxram@us.ibm.com>
	<1570843519-8696-3-git-send-email-linuxram@us.ibm.com>
	<20191015073501.GA32345@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191015073501.GA32345@lst.de>
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
To: Christoph Hellwig <hch@lst.de>, Ram Pai <linuxram@us.ibm.com>
Cc: andmike@us.ibm.com, sukadev@linux.vnet.ibm.com, b.zolnierkie@samsung.com, benh@kernel.crashing.org, aik@linux.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, paulus@ozlabs.org, iommu@lists.linux-foundation.org, paul.burton@mips.com, mpe@ellerman.id.au, robin.murphy@arm.com, m.szyprowski@samsung.com, linuxppc-dev@lists.ozlabs.org, david@gibson.dropbear.id.au
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMTAvMTUg5LiL5Y2IMzozNSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gT24g
RnJpLCBPY3QgMTEsIDIwMTkgYXQgMDY6MjU6MTlQTSAtMDcwMCwgUmFtIFBhaSB3cm90ZToKPj4g
RnJvbTogVGhpYWdvIEp1bmcgQmF1ZXJtYW5uIDxiYXVlcm1hbkBsaW51eC5pYm0uY29tPgo+Pgo+
PiBOb3JtYWxseSwgdmlydGlvIGVuYWJsZXMgRE1BIEFQSSB3aXRoIFZJUlRJT19GX0lPTU1VX1BM
QVRGT1JNLCB3aGljaCBtdXN0Cj4+IGJlIHNldCBieSBib3RoIGRldmljZSBhbmQgZ3Vlc3QgZHJp
dmVyLiBIb3dldmVyLCBhcyBhIGhhY2ssIHdoZW4gRE1BIEFQSQo+PiByZXR1cm5zIHBoeXNpY2Fs
IGFkZHJlc3NlcywgZ3Vlc3QgZHJpdmVyIGNhbiB1c2UgdGhlIERNQSBBUEk7IGV2ZW4gdGhvdWdo
Cj4+IGRldmljZSBkb2VzIG5vdCBzZXQgVklSVElPX0ZfSU9NTVVfUExBVEZPUk0gYW5kIGp1c3Qg
dXNlcyBwaHlzaWNhbAo+PiBhZGRyZXNzZXMuCj4gU29ycnksIGJ1dCB0aGlzIGlzIGEgY29tcGxl
dGUgYnVsbHNoaXQgaGFjay4gIERyaXZlciBtdXN0IGFsd2F5cyB1c2UKPiB0aGUgRE1BIEFQSSBp
ZiB0aGV5IGRvIERNQSwgYW5kIGlmIHZpcnRpbyBkZXZpY2VzIHVzZSBwaHlzaWNhbCBhZGRyZXNz
ZXMKPiB0aGF0IG5lZWRzIHRvIGJlIHJldHVybmVkIHRocm91Z2ggdGhlIHBsYXRmb3JtIGZpcm13
YXJlIGludGVyZmFjZXMgZm9yCj4gdGhlIGRtYSBzZXR1cC4gIElmIHlvdSBkb24ndCBkbyB0aGF0
IHlldCAod2hpY2ggYmFzZWQgb24gcHJldmlvdXMKPiBpbmZvcm1hdGlvbnMgeW91IGRvbid0KSwg
eW91IG5lZWQgdG8gZml4IGl0LCBhbmQgd2UgY2FuIHRoZW4gcXVpcmsKPiBvbGQgaW1wbGVtZW50
YXRpb25zIHRoYXQgYWxyZWFkeSBhcmUgb3V0IGluIHRoZSBmaWVsZC4KPgo+IEluIG90aGVyIHdv
cmRzOiB3ZSBmaW5hbGx5IG5lZWQgdG8gZml4IHRoYXQgdmlydGlvIG1lc3MgYW5kIG5vdCBwaWxl
Cj4gaGFja3Mgb24gdG9wIG9mIGhhY2tzLgoKCkkgYWdyZWUsIHRoZSBvbmx5IHJlYXNvbiBmb3Ig
SU9NTVVfUExBVEZPUk0gaXMgdG8gbWFrZSBzdXJlIGd1ZXN0IHdvcmtzIApmb3Igc29tZSBvbGQg
YW5kIGJ1Z2d5IHFlbXUgd2hlbiB2SU9NTVUgaXMgZW5hYmxlZCB3aGljaCBzZWVtcyB1c2VsZXNz
IAoobm90ZSB3ZSBkb24ndCBldmVuIHN1cHBvcnQgdklPTU1VIG1pZ3JhdGlvbiBpbiB0aGF0IGNh
c2UpLgoKVGhhbmtzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
