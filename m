From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v8 02/18] MAINTAINERS: Add st slim core rproc driver to
	STi section.
Date: Tue, 30 Aug 2016 11:27:33 +0100
Message-ID: <20160830102733.GB10121__298.757703467523$1472554033$gmane$org@dell>
References: <1472223413-7254-1-git-send-email-peter.griffin@linaro.org>
	<1472223413-7254-3-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1472223413-7254-3-git-send-email-peter.griffin@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: devicetree@vger.kernel.org, kernel@stlinux.com, vinod.koul@intel.com, linux-remoteproc@vger.kernel.org, patrice.chotard@st.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, airlied@linux.ie, dmaengine@vger.kernel.org, dan.j.williams@intel.com, bjorn.andersson@linaro.org, virtualization@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

T24gRnJpLCAyNiBBdWcgMjAxNiwgUGV0ZXIgR3JpZmZpbiB3cm90ZToKCj4gVGhpcyBwYXRjaCBh
ZGRzIHRoZSBzbGltIGNvcmUgcnByb2MgZHJpdmVyIHRvIHRoZSBTVGkgc2VjdGlvbgo+IG9mIHRo
ZSBNQUlOVEFJTkVSUyBmaWxlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFBldGVyIEdyaWZmaW4gPHBl
dGVyLmdyaWZmaW5AbGluYXJvLm9yZz4KPiAtLS0KPiAgTUFJTlRBSU5FUlMgfCAyICsrCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCkFja2VkLWJ5OiBMZWUgSm9uZXMgPGxlZS5q
b25lc0BsaW5hcm8ub3JnPgogIAo+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlO
RVJTCj4gaW5kZXggMGJiZTRiMS4uNWRkM2IyNCAxMDA2NDQKPiAtLS0gYS9NQUlOVEFJTkVSUwo+
ICsrKyBiL01BSU5UQUlORVJTCj4gQEAgLTE3NDksNiArMTc0OSw3IEBAIEY6CWRyaXZlcnMvcGh5
L3BoeS1zdGloNDA3LXVzYi5jCj4gIEY6CWRyaXZlcnMvcGh5L3BoeS1zdGloNDF4LXVzYi5jCj4g
IEY6CWRyaXZlcnMvcGluY3RybC9waW5jdHJsLXN0LmMKPiAgRjoJZHJpdmVycy9yZW1vdGVwcm9j
L3N0X3JlbW90ZXByb2MuYwo+ICtGOglkcml2ZXJzL3JlbW90ZXByb2Mvc3Rfc2xpbV9ycHJvYy5j
Cj4gIEY6CWRyaXZlcnMvcmVzZXQvc3RpLwo+ICBGOglkcml2ZXJzL3J0Yy9ydGMtc3QtbHBjLmMK
PiAgRjoJZHJpdmVycy90dHkvc2VyaWFsL3N0LWFzYy5jCj4gQEAgLTE3NTcsNiArMTc1OCw3IEBA
IEY6CWRyaXZlcnMvdXNiL2hvc3QvZWhjaS1zdC5jCj4gIEY6CWRyaXZlcnMvdXNiL2hvc3Qvb2hj
aS1zdC5jCj4gIEY6CWRyaXZlcnMvd2F0Y2hkb2cvc3RfbHBjX3dkdC5jCj4gIEY6CWRyaXZlcnMv
YXRhL2FoY2lfc3QuYwo+ICtGOglpbmNsdWRlL2xpbnV4L3JlbW90ZXByb2Mvc3Rfc2xpbV9ycHJv
Yy5oCj4gIAo+ICBBUk0vU1RNMzIgQVJDSElURUNUVVJFCj4gIE06CU1heGltZSBDb3F1ZWxpbiA8
bWNvcXVlbGluLnN0bTMyQGdtYWlsLmNvbT4KCi0tIApMZWUgSm9uZXMKTGluYXJvIFNUTWljcm9l
bGVjdHJvbmljcyBMYW5kaW5nIFRlYW0gTGVhZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBz
b2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwg
QmxvZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
