From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86: fix -Wmissing-prototypes warning
Date: Thu, 22 Nov 2018 12:14:58 +0100
Message-ID: <20181122111458.GA107823__8232.196144718$1542885189$gmane$org@gmail.com>
References: <20181122084815.GA84118@gmail.com>
	<201811221904598072830@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201811221904598072830@zte.com.cn>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: wang.yi59@zte.com.cn
Cc: linux-efi@vger.kernel.org, anton@enomsg.org, kvm@vger.kernel.org, rkrcmar@redhat.com, peterz@infradead.org, jan.kiszka@siemens.com, virtualization@lists.linux-foundation.org, pravin.shedge4linux@gmail.com, namit@vmware.com, hpa@zytor.com, akataria@vmware.com, prarit@redhat.com, robh@kernel.org, zhong.weidong@zte.com.cn, bhe@redhat.com, devicetree@vger.kernel.org, x86@kernel.org, pasha.tatashin@oracle.com, takahiro.akashi@linaro.org, andy.shevchenko@gmail.com, mingo@redhat.com, linux-pci@vger.kernel.org, dyoung@redhat.com, m.mizuma@jp.fujitsu.com, jailhouse-dev@googlegroups.com, jroedel@suse.de, keescook@chromium.org, konrad.wilk@oracle.com, rostedt@goodmis.org, rajvi.jingar@intel.com, tony.luck@intel.com, bp@alien8.de, luto@kernel.org, oleg@redhat.com, bhelgaas@google.com, tglx@linutronix.de, frank.rowand@sony.com, jgross@suse.com, douly.fnst@cn.fujitsu.com, thomas.le
List-Id: virtualization@lists.linuxfoundation.org

Ciogd2FuZy55aTU5QHp0ZS5jb20uY24gPHdhbmcueWk1OUB6dGUuY29tLmNuPiB3cm90ZToKCj4g
SGkgSW5nbywKPiAKPiA+ICogWWkgV2FuZyA8d2FuZy55aTU5QHp0ZS5jb20uY24+IHdyb3RlOgo+
ID4KPiA+ID4gV2UgbWF5IGdldCAtV21pc3NpbmctcHJvdG90eXBlcyB3YXJuaW5ncyB3aGVuIGJ1
aWxkaW5nCj4gPiA+IGtlcm5lbCB3aXRoIFc9MSwgaXQncyBiZXR0ZXIgdG8gZml4IHRoZW0gYXMg
Z2xvYmFsIGZ1bmN0aW9uCj4gPiA+IHNpZ25hdHVyZSBjYW4gYmUgY2hhbmdlZCBhbmQgY2FsbGVy
IHdobyB1c2UgdGhlIG9sZCB1bmNoYW5nZWQKPiA+ID4gcHJvdG90eXBlcyB3aWxsIGJlIGhvc2Vk
Lgo+ID4gPgo+ID4gPiBUaGlzIHBhdGNoIGZpeGVzIG1vc3Qgb2YgLVdtaXNzaW5nLXByb3RvdHlw
ZXMgd2FybmluZ3Mgd2hpY2gKPiA+ID4gYXJlIGluIHRoZSByb290IGRpcmVjdG9yeSBvZiBhcmNo
L3g4Ni9rZXJuZWwsIG5vdCBpbmNsdWRpbmcKPiA+ID4gdGhlIHN1YmRpcmVjdG9yaWVzLgo+ID4g
Pgo+ID4gPiBUaGVzZSBhcmUgdGhlIHdhcm5pbmdzIGZpeGVkIGluIHRoaXMgcGF0Y2g6Cj4gPiA+
IGFyY2gveDg2L2tlcm5lbC9zaWduYWwuYzo4NjU6MTc6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHBy
b3RvdHlwZSBmb3Ig4oCYc3lzMzJfeDMyX3J0X3NpZ3JldHVybuKAmSBbLVdtaXNzaW5nLXByb3Rv
dHlwZXNdCj4gCj4gLi4uLi4uCj4gCj4gPiA+ICBpbmNsdWRlL2xpbnV4L2Z0cmFjZS5oICAgICAg
ICAgICAgIHwgMyArKysKPiA+ID4gIGluY2x1ZGUvbGludXgva2V4ZWMuaCAgICAgICAgICAgICAg
fCAxICsKPiA+ID4gIGluY2x1ZGUvbGludXgvb2ZfZmR0LmggICAgICAgICAgICAgfCAxICsKPiA+
ID4gIGluY2x1ZGUvbGludXgvcHRyYWNlLmggICAgICAgICAgICAgfCAxICsKPiA+ID4gIDI0IGZp
bGVzIGNoYW5nZWQsIDU1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4gPgo+ID4gQnJl
YWtzIDMyLWJpdCBjb21waWxhdGlvbjoKPiA+Cj4gPiAuLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9z
ZXR1cC5oOiBBc3NlbWJsZXIgbWVzc2FnZXM6Cj4gPiAuLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9z
ZXR1cC5oOjMwOiBFcnJvcjogbm8gc3VjaCBpbnN0cnVjdGlvbjogYHVuc2lnbmVkIGxvbmcgX19z
dGFydHVwXzY0KHVuc2lnbmVkIGxvbmcgcGh5c2FkZHIsc3RydWN0IGJvb3RfcGFyYW1zICpicCkn
Cj4gPgo+ID4gSSdsbCBza2lwIHRoZSBzZXR1cC5oIGJpdHMgLSBsZXQncyBob3BlIHRoYXQncyB0
aGUgb25seSBidWcuCj4gCj4gU29ycnkgZm9yIHRoZSBpbmNvbnZlbmllbmNlLCB0aG91Z2ggSSBo
YXZlIGNoZWNrZWQgY2FyZWZ1bGx5IDotKQo+IAo+IEhvdyBkbyB5b3UgcHJvZHVjZSB0aGlzIGVy
cm9yPyBJIHRlc3RlZCB0aGlzIHdheSBidXQgZGlkIG5vdCByZXByb2R1Y2UKPiB0aGF0IGVycm9y
Ogo+ICMgbWFrZSBhbGxtb2Rjb25maWcKPiAjIG1ha2UgLWo4Cj4gCj4gVGhhbmtzIGZvciB5b3Vy
IHRpbWUgYWdhaW4hCgpJIGRvbid0IHJlbWVtYmVyIHRoZSBleGFjdCBjb25maWcsIGJ1dCB5b3Ug
Y291bGQgdHJ5IHRoZSAzMi1iaXQgCmFsbG5vY29uZmlnIGFuZCBkZWZjb25maWcuCgpOb3RlIHRo
YXQgdGhlIGNvbW1hbmRzIHlvdSB1c2VkIGFib3ZlIHdpbGwgdXNlIHRoZSA2NC1iaXQga2VybmVs
LCBub3QgdGhlIAozMi1iaXQga2VybmVsLgoKVGhhbmtzLAoKCUluZ28KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
