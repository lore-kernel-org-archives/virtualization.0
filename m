From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [RFC] kvm tools: Add support for virtio-mmio
Date: Wed, 16 Nov 2011 13:21:58 +0000
Message-ID: <1321449718.3137.258.camel__17717.0808696703$1321449742$gmane$org@hornet.cambridge.arm.com>
References: <1321375667-17284-1-git-send-email-levinsasha928@gmail.com>
	<CAFEAcA-2QGk_Y1R_FPrVRVGiP7KyQOuv0zubORm77cOoU_K6gQ@mail.gmail.com>
	<1321379773.3200.9.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1321379773.3200.9.camel@lappy>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "asias.hejun@gmail.com" <asias.hejun@gmail.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "penberg@kernel.org" <penberg@kernel.org>, "gorcunov@gmail.com" <gorcunov@gmail.com>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

T24gVHVlLCAyMDExLTExLTE1IGF0IDE3OjU2ICswMDAwLCBTYXNoYSBMZXZpbiB3cm90ZToKPiBI
bW0uLi4gSWYgdGhhdHMgdGhlIHBsYW4sIGl0IHNob3VsZCBwcm9iYWJseSBiZSBhIHZpcnRpbyB0
aGluZyAobm90Cj4gdmlydGlvLW1taW8gc3BlY2lmaWMpLgo+IAo+IEVpdGhlciB3YXksIGl0IGNv
dWxkIGFsc28gdXNlIHNvbWUgY2xhcmlmaWNhdGlvbiBpbiB0aGUgc3BlYy4KCldlbGwsIHRoZSBz
cGVjIChwLiAyLjEpIHNheXM6ICJUaGUgU3Vic3lzdGVtIFZlbmRvciBJRCBzaG91bGQgcmVmbGVj
dAp0aGUgUENJIFZlbmRvciBJRCBvZiB0aGUgZW52aXJvbm1lbnQgKGl0J3MgY3VycmVudGx5IG9u
bHkgdXNlZCBmb3IKaW5mb3JtYXRpb25hbCBwdXJwb3NlcyBieSB0aGUgZ3Vlc3QpLiIuIFRoZSBm
YWN0IGlzIHRoYXQgYWxsIHRoZSBjdXJyZW50CnZpcnRpbyBkcml2ZXJzIHNpbXBseSBpZ25vcmUg
dGhpcyBmaWVsZC4gU28gdW5sZXNzIHRoaXMgY2hhbmdlcyBJIHNpbXBseQpoYXZlIG5vIGlkZWEg
aG93IHRvIGRlc2NyaWJlIHRoYXQgcmVnaXN0ZXIuICJQdXQgYW55dGhpbmcgdGhlcmUsIG5vIG9u
ZQpjYXJlcyI/ICJXcml0ZSB6ZXJvIG5vdywgbWF5IGNoYW5nZSBpbiBmdXR1cmUiPyBBbnkgaWRl
YXMgd2VsY29tZWQuCgpDaGVlcnMhCgpQYXdlxYIKClBTLiBUaGFua3MgZm9yIGRlZmVuZGluZyBt
eSBob25vdXIgaW4gdGhlIGRlbGF5ZWQtZXhwbG9zaXZlLWRldmljZQp0aHJlYWQgOy0pCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
