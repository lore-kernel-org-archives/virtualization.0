From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v8 09/18] ARM: multi_v7_defconfig: Enable STi and
	simple-card drivers.
Date: Tue, 30 Aug 2016 11:25:03 +0100
Message-ID: <20160830102503.GV1661@dell>
References: <1472223413-7254-1-git-send-email-peter.griffin@linaro.org>
	<1472223413-7254-10-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1472223413-7254-10-git-send-email-peter.griffin@linaro.org>
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
Cc: devicetree@vger.kernel.org, kernel@stlinux.com, vinod.koul@intel.com, arnaud.pouliquen@st.com, linux-remoteproc@vger.kernel.org, patrice.chotard@st.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, airlied@linux.ie, broonie@kernel.org, dmaengine@vger.kernel.org, dan.j.williams@intel.com, bjorn.andersson@linaro.org, virtualization@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

Tml0OiBSZW1vdmUgZnVsbC1zdG9wIGZyb20gJFNVQkpFQ1QKCk9uIEZyaSwgMjYgQXVnIDIwMTYs
IFBldGVyIEdyaWZmaW4gd3JvdGU6Cj4gVGhpcyBwYXRjaCBlbmFibGVzIHRoZSBTVGkgQUxTQSBk
cml2ZXJzIGZvdW5kIG9uIFNUaSBwbGF0Zm9ybXMKPiBhcyB3ZWxsIGFzIHRoZSBzaW1wbGUtY2Fy
ZCBkcml2ZXIgd2hpY2ggaXMgYSBkZXBlbmRlbmN5IHRvIGhhdmUKPiB3b3JraW5nIHNvdW5kLgo+
IAo+IFNpZ25lZC1vZmYtYnk6IFBldGVyIEdyaWZmaW4gPHBldGVyLmdyaWZmaW5AbGluYXJvLm9y
Zz4KPiBDYzogYXJuYXVkLnBvdWxpcXVlbkBzdC5jb20KPiBDYzogYnJvb25pZUBrZXJuZWwub3Jn
Cj4gLS0tCj4gIGFyY2gvYXJtL2NvbmZpZ3MvbXVsdGlfdjdfZGVmY29uZmlnIHwgMyArKysKPiAg
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKQWNrZWQtYnk6IExlZSBKb25lcyA8bGVl
LmpvbmVzQGxpbmFyby5vcmc+CiAgCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2NvbmZpZ3MvbXVs
dGlfdjdfZGVmY29uZmlnIGIvYXJjaC9hcm0vY29uZmlncy9tdWx0aV92N19kZWZjb25maWcKPiBp
bmRleCA5OTg1NzhhLi41MWEzOGIxIDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtL2NvbmZpZ3MvbXVs
dGlfdjdfZGVmY29uZmlnCj4gKysrIGIvYXJjaC9hcm0vY29uZmlncy9tdWx0aV92N19kZWZjb25m
aWcKPiBAQCAtNjQ0LDYgKzY0NCw5IEBAIENPTkZJR19TTkRfU09DX0FLNDY0Mj1tCj4gIENPTkZJ
R19TTkRfU09DX1NHVEw1MDAwPW0KPiAgQ09ORklHX1NORF9TT0NfU1BESUY9bQo+ICBDT05GSUdf
U05EX1NPQ19XTTg5Nzg9bQo+ICtDT05GSUdfU05EX1NPQ19TVEk9bQo+ICtDT05GSUdfU05EX1NP
Q19TVElfU0FTPW0KPiArQ09ORklHX1NORF9TSU1QTEVfQ0FSRD1tCj4gIENPTkZJR19VU0I9eQo+
ICBDT05GSUdfVVNCX1hIQ0lfSENEPXkKPiAgQ09ORklHX1VTQl9YSENJX01WRUJVPXkKCi0tIApM
ZWUgSm9uZXMKTGluYXJvIFNUTWljcm9lbGVjdHJvbmljcyBMYW5kaW5nIFRlYW0gTGVhZApMaW5h
cm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9sbG93IExpbmFy
bzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
