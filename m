From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2] x86/paravirt: Cleanup native_patch()
Date: Tue, 11 Sep 2018 11:44:26 +0200
Message-ID: <eb3dd51b-1807-b5ea-58c6-714fdee7f173__30550.9267295294$1536658950$gmane$org@suse.com>
References: <20180907104917.12502-1-bp@alien8.de>
	<20180907105112.GD12849@zn.tnic> <20180907201050.GF12849@zn.tnic>
	<65bb69fa-855f-9efc-19ba-c0fab69f468c@suse.com>
	<20180908152800.GA8286@zn.tnic>
	<229941d4-c152-89fb-eb75-fcfa5f265ad4@suse.com>
	<20180910070108.GA21406@zn.tnic>
	<dfe856d6-a4db-b406-ef18-dba3b6b8c342@suse.com>
	<20180911091510.GA12094@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180911091510.GA12094@zn.tnic>
Content-Language: de-DE
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

T24gMTEvMDkvMTggMTE6MTUsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToKPiBXaGVuIENPTkZJR19Q
QVJBVklSVF9TUElOTE9DS1M9biwgaXQgZmlyZXMKPiAKPiAgIGFyY2gveDg2L2tlcm5lbC9wYXJh
dmlydF9wYXRjaF82NC5jOiBJbiBmdW5jdGlvbiDigJhuYXRpdmVfcGF0Y2jigJk6Cj4gICBhcmNo
L3g4Ni9rZXJuZWwvcGFyYXZpcnRfcGF0Y2hfNjQuYzo4OToxOiB3YXJuaW5nOiBsYWJlbCDigJhw
YXRjaF9zaXRl4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1sYWJlbF0KPiAgICBw
YXRjaF9zaXRlOgo+IAo+IGJ1dCB0aG9zZSBsYWJlbHMgY2FuIHNpbXBseSBiZSByZW1vdmVkIGJ5
IGRpcmVjdGx5IGNhbGxpbmcgdGhlCj4gcmVzcGVjdGl2ZSBmdW5jdGlvbnMgdGhlcmUuCj4gCj4g
R2V0IHJpZCBvZiBsb2NhbCB2YXJpYWJsZXMgdG9vLCB3aGlsZSBhdCBpdC4gQWxzbywgc2ltcGxp
ZnkgZnVuY3Rpb24KPiBmbG93IGZvciBiZXR0ZXIgcmVhZGFiaWxpdHkuCj4gCj4gU2lnbmVkLW9m
Zi1ieTogQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPgo+IENjOiBKdWVyZ2VuIEdyb3NzIDxq
Z3Jvc3NAc3VzZS5jb20+Cj4gQ2M6IHg4NkBrZXJuZWwub3JnCj4gQ2M6IHZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCgpSZXZpZXdlZC1ieTogSnVlcmdlbiBHcm9zcyA8
amdyb3NzQHN1c2UuY29tPgoKCkp1ZXJnZW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
