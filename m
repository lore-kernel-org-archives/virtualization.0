From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH 6/9] virtio_mmio: Cast &resources[1].start to
	=?UTF-8?Q?=E2=80=98unsigned?= int =?UTF-8?Q?*=E2=80=99?= to rid
	compiler warning
Date: Mon, 05 Nov 2012 13:00:54 +0000
Message-ID: <1352120454.10947.5.camel@hornet>
References: <1351980150-24145-1-git-send-email-lee.jones@linaro.org>
	<1351980150-24145-7-git-send-email-lee.jones@linaro.org>
	<87k3u0ydry.fsf@rustcorp.com.au> <20121105082116.GB2699@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121105082116.GB2699@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

T24gTW9uLCAyMDEyLTExLTA1IGF0IDA4OjIxICswMDAwLCBMZWUgSm9uZXMgd3JvdGU6Cj4gPiA+
ICAJcHJvY2Vzc2VkID0gc3NjYW5mKHN0ciwgIkAlbGxpOiV1JW46JWQlbiIsCj4gPiA+IC0JCQkm
YmFzZSwgJnJlc291cmNlc1sxXS5zdGFydCwgJmNvbnN1bWVkLAo+ID4gPiArCQkJJmJhc2UsICh1
bnNpZ25lZCBpbnQgKikmcmVzb3VyY2VzWzFdLnN0YXJ0LCAmY29uc3VtZWQsCj4gPiA+ICAJCQkm
dm1fY21kbGluZV9pZCwgJmNvbnN1bWVkKTsKPiA+IAo+ID4gVGhpcyBzdXBwcmVzc2VzIGEgdmFs
aWQgd2FybmluZywgbGVhdmluZyBvdXIgY29kZSBubyBsZXNzIHdyb25nIHRoYW4KPiA+IGJlZm9y
ZS4gIEJ1dCBub3cgaXQncyBzaWxlbnRseSB3cm9uZyEKPiA+IAo+ID4gRG8geW91IHdhbnQgdG8g
dHJ5IGFnYWluPwo+IAo+IEZvciBzdXJlIEknbGwgdHJ5IGFnYWluLgo+IAo+IEhvdyBkb2VzIGBz
LyV1LyVwL2Agc3VpdD8KCnNzY2FuZiBkb2Vzbid0IGRvICIlcCIuLi4gVGhlIG9ubHkgcmVhc29u
YWJsZSB3YXkgb2YgZml4aW5nIHRoaXMgaXMgYQppbnRlcm1lZGlhdGUgbG9jYWwgdmFyaWFibGUg
LSB3aWxsIHBvc3QgYSBwYXRjaCBpbiBhIHNlY29uZC4KClRoYW5rcyBmb3Igc3BvdHRpbmcgdGhp
cyEKClBhd2XFggoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
