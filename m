From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_console: Let unconnected rproc device receive data.
Date: Tue, 19 Feb 2013 09:27:21 +1030
Message-ID: <87mwv1i626.fsf@rustcorp.com.au>
References: <1358425362-4517-1-git-send-email-sjur.brandeland@stericsson.com>
	<20130125091024.GB30483@amit.redhat.com>
	<81C3A93C17462B4BBD7E272753C105792458D7DEEF@EXDCVYMBSTM005.EQ1STM.local>
	<CAJK669a7yr2Fo2Asrthtq5osLynurkuM_k_yO1GTsOTNaho+Dg@mail.gmail.com>
	<20130212094242.GC22567@redhat.com>
	<CAJK669Y2=FRDLH9RbyzfVLQaF+wUNoziBzWZA=7mfG7VMmZWBw@mail.gmail.com>
	<20130212100930.GA23359@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130212100930.GA23359@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Sjur =?utf-8?Q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Cc: Amit Shah <amit.shah@redhat.com>, Erwan.Yvin@stericsson.com, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Ik1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPiB3cml0ZXM6Cj4gT24gVHVlLCBG
ZWIgMTIsIDIwMTMgYXQgMTE6MDE6MTBBTSArMDEwMCwgU2p1ciBCcsOmbmRlbGFuZCB3cm90ZToK
Pj4gT24gVHVlLCBGZWIgMTIsIDIwMTMgYXQgMTA6NDIgQU0sIE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+PiAuLi4KPj4gPiA+ID4gPiBIb3cgYWJvdXQgc2V0dGlu
ZyBwb3J0LT5ndWVzdF9jb25uZWN0ZWQgPSB0cnVlIGluIHRoZSBpbml0IHJvdXRpbmVzCj4+ID4g
PiA+ID4gaW5zdGVhZD8gIEtlZXBzIHRoaXMgY29kZSBwYXRoIGNsZWFuZXIuCj4+ID4gPiA+Cj4+
ID4gPiA+IEFncmVlLCBJJ2xsIHJlc3BpbiB0aGlzIHBhdGNoLgo+PiA+ID4KPj4gPiA+IEhtLCBS
dXN0eSBoYXMgYWxyZWFkeSBwaWNrZWQgdGhpcyB1cC4KPj4gPgo+PiA+IEkgZG9uJ3Qgc2VlIGl0
IGluIHZpcnRpby1uZXh0LiBEbyB5b3U/Cj4+IAo+PiAKPj4gWWVzIEkgZG8sIHNlZToKPj4gCj4+
IGh0dHA6Ly9naXQua2VybmVsLm9yZy8/cD1saW51eC9rZXJuZWwvZ2l0L3J1c3R5L2xpbnV4Lmdp
dDthPWNvbW1pdGRpZmY7aD0xZjgwNTE4NzZhMTk0ZDdmN2ZlNzgzNGQ5ODUzZjI0MGQ2YjRiOWFi
O2hwPTIyNjM2NDc2NmY5MzZkMjQ5ZTQwOGRlMDM4MjE0NjhjMWJmMTFkZGEKPj4gCj4+IFJlZ2Fy
ZHMsCj4+IFNqdXIKPgo+IFJpZ2h0LCBtaXNzZWQgdGhpcy4gSW4gdGhpcyBjYXNlIGJldHRlciB0
byBzZW5kIGFuIGluY3JlbWVudGFsIHBhdGNoIEkKPiB0aGluaywgd2UgZG9uJ3Qgd2FudCByZWJh
c2VzIHVubGVzcyBhYnNvbHV0ZWx5IHJlcXVpcmVkLgoKSW5kZWVkLCBJIHRyeSBub3QgdG8gcmVi
YXNlIHZpcnRpby1uZXh0LiAgcGVuZGluZy1yZWJhc2VzIGlzIHdoZXJlIEkgcHV0CnN0dWZmIHdo
aWNoIGNhbiBiZSB3aWxkbHkgcmViYXNlZC4uLgoKQ2hlZXJzLApSdXN0eS4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
