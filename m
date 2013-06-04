From: li guang <lig.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 2/2] xen: remove bm_rld_set of xen_processor_flags
Date: Tue, 04 Jun 2013 16:19:27 +0800
Message-ID: <1370333967.17798.60.camel__39195.6144282178$1370473227$gmane$org@liguang.fnst.cn.fujitsu.com>
References: <1370333128-11412-1-git-send-email-lig.fnst@cn.fujitsu.com>
	<1370333128-11412-2-git-send-email-lig.fnst@cn.fujitsu.com>
	<51ADBDC402000078000DAF36@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <51ADBDC402000078000DAF36@nat28.tlf.novell.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Beulich <JBeulich@suse.com>
Cc: Liu Jinsong <jinsong.liu@intel.com>, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "Rafael
	J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Len Brown <lenb@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

5ZyoIDIwMTMtMDYtMDTkuoznmoQgMDk6MTMgKzAxMDDvvIxKYW4gQmV1bGljaOWGmemBk++8mgo+
ID4+PiBPbiAwNC4wNi4xMyBhdCAxMDowNSwgbGlndWFuZyA8bGlnLmZuc3RAY24uZnVqaXRzdS5j
b20+IHdyb3RlOgo+ID4gYm1fcmxkX3NldCBzZWVtcyBvYnNvbGV0ZSBub3cKPiA+IAo+ID4gU2ln
bmVkLW9mZi1ieTogbGlndWFuZyA8bGlnLmZuc3RAY24uZnVqaXRzdS5jb20+Cj4gPiAtLS0KPiA+
ICBpbmNsdWRlL3hlbi9pbnRlcmZhY2UvcGxhdGZvcm0uaCB8ICAgIDEgLQo+ID4gIDEgZmlsZXMg
Y2hhbmdlZCwgMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQo+ID4gCj4gPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS94ZW4vaW50ZXJmYWNlL3BsYXRmb3JtLmggCj4gPiBiL2luY2x1ZGUveGVu
L2ludGVyZmFjZS9wbGF0Zm9ybS5oCj4gPiBpbmRleCBjNTdkNWY2Li43ZmZmZjMzIDEwMDY0NAo+
ID4gLS0tIGEvaW5jbHVkZS94ZW4vaW50ZXJmYWNlL3BsYXRmb3JtLmgKPiA+ICsrKyBiL2luY2x1
ZGUveGVuL2ludGVyZmFjZS9wbGF0Zm9ybS5oCj4gPiBAQCAtMjQwLDcgKzI0MCw2IEBAIHN0cnVj
dCB4ZW5fcHJvY2Vzc29yX2ZsYWdzIHsKPiA+ICAJdWludDMyX3QgYm1fY2hlY2s6MTsKPiA+ICAJ
dWludDMyX3QgaGFzX2NzdDoxOwo+ID4gIAl1aW50MzJfdCBwb3dlcl9zZXR1cF9kb25lOjE7Cj4g
PiAtCXVpbnQzMl90IGJtX3JsZF9zZXQ6MTsKPiA+ICB9Owo+ID4gIAo+ID4gIHN0cnVjdCB4ZW5f
cHJvY2Vzc29yX3Bvd2VyIHsKPiAKPiBBbnkgc3VjaCBwYXRjaCB3b3VsZCBuZWVkIHRvIGJlIHN1
Ym1pdHRlZCBhZ2FpbnN0IHRoZSBtYXN0ZXIgY29weQo+IG9mIHRoZSBoZWFkZXIgKGluIHRoZSBY
ZW4gcmVwbyksIGFuZCBieSByZWNvZ25pemluZyB0aGF0IHlvdSdkIGFsc28KPiBub3RpY2UgdGhh
dCB0aGlzIGlzIHBhcnQgb2YgYSBwdWJsaWMgQUJJLCBhbmQgaGVuY2UgY2FuJ3QgYmUgcmVtb3Zl
ZCwKPiBidXQgYXQgYmVzdCBjYW4gYmUgZG9jdW1lbnRlZCBhcyBvYnNvbGV0ZS4gT2YgY291cnNl
IHlvdSdkIGZpcnN0Cj4gbmVlZCB0byBjaGVjayB3aGV0aGVyIHRoZSBoeXBlcnZpc29yIG1ha2Vz
IGFueSB1c2Ugb2YgdGhhdCBiaXQKPiB3aGVuIHBhc3NlZCBkb3duIGZyb20gRG9tMC4KPiAKClJp
Z2h0LCB0aGlzIHBhdGNoIG1vc3RseSBsaWtlcyBhIHJlbWluZGVyLApob3Bpbmcgc29tZW9uZSB3
aWxsIHRyeSBpdCBhbmQgdmVyaWZ5IGl0J3MgZmFpbCBvciBPSywKc2luY2UgSSBjYW4ndCB0ZXN0
IHRoaXMgZm9yIG5vdy4KClNvcnJ5IGFuZCBUaGFua3MhCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
