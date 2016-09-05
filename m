From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v8 15/18] ARM: STi: DT: STiH407: Add uniperif reader dt
	nodes
Date: Mon, 5 Sep 2016 16:42:48 +0100
Message-ID: <20160905154248.GU4921__43513.2676772357$1473090074$gmane$org@dell>
References: <1472223413-7254-1-git-send-email-peter.griffin@linaro.org>
	<1472223413-7254-16-git-send-email-peter.griffin@linaro.org>
	<20160830100148.GO1661@dell>
	<20160830142112.GA22514@griffinp-ThinkPad-X1-Carbon-2nd>
	<20160831112819.GJ27357@dell>
	<ae089830-b7c8-ee83-f697-6ff93f2646ed@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <ae089830-b7c8-ee83-f697-6ff93f2646ed@st.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: devicetree@vger.kernel.org, kernel@stlinux.com, vinod.koul@intel.com, linux-remoteproc@vger.kernel.org, patrice.chotard@st.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Peter Griffin <peter.griffin@linaro.org>, airlied@linux.ie, dmaengine@vger.kernel.org, dan.j.williams@intel.com, bjorn.andersson@linaro.org, virtualization@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

T24gTW9uLCAwNSBTZXAgMjAxNiwgQXJuYXVkIFBvdWxpcXVlbiB3cm90ZToKPiA+Pj4+ICsJCQlk
YWktbmFtZSA9ICJVbmkgUmVhZGVyICMwIChQQ00gSU4pIjsKPiA+Pj4KPiA+Pj4gT29vbywgbm90
IHNlZW4gc29tZXRoaW5nIGxpa2UgdGhpcyBiZWZvcmUuCj4gPj4+Cj4gPj4+IElmIGl0IGRvZXMg
bm90IGFscmVhZHkgaGF2ZSBvbmUsIGl0IHdvdWxkIHJlcXVpcmUgYSBEVCBBY2suCj4gPj4KPiA+
PiBObyBpZGVhLCB0aGUgZHJpdmVyIGdvdCBtZXJnZWQgMSB5ZWFyIGFnby4KPiBUaGlzIGZpZWxk
IGNvdWxkIGJlIHN1cHByZXNzZWQgYW5kIGhhbmRsZWQgaW4gc291cmNlIGNvZGUsIHVzaW5nCj4g
c3QsdW5pcGVyaXBoLWlkIHRvIHJldHJlaXZlIGl0LgoKVGhhdCB3b3VsZCBiZSBiZXR0ZXIuCgo+
ID4+IEFybmF1ZCBkaWQgeW91IGdldCBhIERUIGFjayB3aGVuIHlvdSBtZXJnZWQgdGhpcyBkcml2
ZXIgJiBiaW5kaW5nPyBpIGlmIGkgcmVtZW1iZXIgd2VsbCwgaSBoYWQgIHNlbnQgdG8gQWxzYSBt
YWlsaW5nIGxpc3Qgb25seSwgSSBtaXNzZWQKPiB0aGlzIG9idmlvdXMuLi4KCkknbSBzdXJwcmlz
ZWQgTWFyayBkaWRuJ3Qgbm90aWNlIHRoaXMuCgpIZSdzIHVzdWFsbHkgcHJldHR5IGdvb2QgYXQg
cGlja2luZyBzdHVmZiBsaWtlIHRoYXQgdXAuCgo+ID4+Pj4gKwkJCXN0LHZlcnNpb24gPSA8Mz47
Cj4gPj4+Cj4gPj4+IFRoaXMgd2lsbCBsaWtlbHkgbmVlZCBhIERUIEFjayB0b28uICBXZSB1c3Vh
bGx5IGVuY29kZSB0aGlzIHNvcnQgb2YKPiA+Pj4gaW5mb3JtYXRpb24gaW4gdGhlIGNvbXBhdGli
bGUgc3RyaW5nLgo+IHllcywgYmV0dGVyIHRvIHVzZSBjb21wYXRpYmlsaXR5Cj4gPj4KPiA+PiBT
ZWUgMDVjMWI0NDgwZTg2YTg3MWIxODAzMGQ2ZjNkNTMyZGMwZWNkZjM4Ywo+ID4gCj4gPiBXZWxs
IFJvYidzIHRoZSBib3NzLiAgV2UgY2VydGFpbmx5IG5ldmVyIHVzZWQgdG8gdGFrZSAnZGV2aWNl
IElEJyBvcgo+ID4gJ3ZlcnNpb24nIGF0dHJpYnV0ZXMuICBJIGd1ZXNzIHNvbWV0aGluZyBtdXN0
IGhhdmUgY2hhbmdlZC4KPiAKPiBJIHdpbGwgdHJ5IHRvIHByb3ZpZGUgcGF0Y2hlcyBmb3IgY29k
ZSBhbmQgYmluZGluZ3MgcmV3b3JrIHRoaXMgd2Vlay4KCldvbmRlcmZ1bC4uIFRoYW5rcyBBcm5h
dWQuCgotLSAKTGVlIEpvbmVzCkxpbmFybyBTVE1pY3JvZWxlY3Ryb25pY3MgTGFuZGluZyBUZWFt
IExlYWQKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZv
bGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
