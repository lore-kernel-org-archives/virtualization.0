From: "rkrcmar@redhat.com" <rkrcmar@redhat.com>
Subject: Re: [PATCH v5 9/9] Documentation: virtual: kvm: Support vcpu
	preempted check
Date: Mon, 24 Oct 2016 17:05:39 +0200
Message-ID: <20161024150539.GA3197__45006.3928649344$1477321584$gmane$org@potion>
References: <1476998874-2089-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1476998874-2089-10-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<063D6719AE5E284EB5DD2968C1650D6DB0207B44@AcuExch.aculab.com>
	<20161021183951.GA29131@potion>
	<b2101564-6344-f353-7393-abc07f26c07a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <b2101564-6344-f353-7393-abc07f26c07a@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "kernellwp@gmail.com" <kernellwp@gmail.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "jgross@suse.com" <jgross@suse.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, 'Pan Xinhui' <xinhui.pan@linux.vnet.ibm.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, David Laight <David.Laight@ACULAB.COM>, "paulus@samba.org" <paulus@samba.org>, "xen-devel-request@lists.xenproject.org" <xen-devel-request@lists.xenproject.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "mingo@redhat.com" <mingo@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

MjAxNi0xMC0yNCAxNjo0MiswMjAwLCBQYW9sbyBCb256aW5pOgo+IE9uIDIxLzEwLzIwMTYgMjA6
MzksIHJrcmNtYXJAcmVkaGF0LmNvbSB3cm90ZToKPj4gMjAxNi0xMC0yMSAxMToyNyswMDAwLCBE
YXZpZCBMYWlnaHQ6Cj4+PiBGcm9tOiBQYW4gWGluaHVpCj4+Pj4gU2VudDogMjAgT2N0b2JlciAy
MDE2IDIyOjI4Cj4+Pj4gQ29tbWl0ICgieDg2LCBrdm06IHN1cHBvcnQgdmNwdSBwcmVlbXB0ZWQg
Y2hlY2siKSBhZGQgb25lIGZpZWxkICJfX3U4Cj4+Pj4gcHJlZW1wdGVkIiBpbnRvIHN0cnVjdCBr
dm1fc3RlYWxfdGltZS4gVGhpcyBmaWVsZCB0ZWxscyBpZiBvbmUgdmNwdSBpcwo+Pj4+IHJ1bm5p
bmcgb3Igbm90Lgo+Pj4+Cj4+Pj4gSXQgaXMgemVybyBpZiAxKSBzb21lIG9sZCBLVk0gZGVvcyBu
b3Qgc3VwcG9ydCB0aGlzIGZpbGVkLiAyKSB0aGUgdmNwdSBpcwo+Pj4+IHByZWVtcHRlZC4gT3Ro
ZXIgdmFsdWVzIG1lYW5zIHRoZSB2Y3B1IGhhcyBiZWVuIHByZWVtcHRlZC4KPj4+Pgo+Pj4+IFNp
Z25lZC1vZmYtYnk6IFBhbiBYaW5odWkgPHhpbmh1aS5wYW5AbGludXgudm5ldC5pYm0uY29tPgo+
Pj4+IC0tLQo+Pj4+ICBEb2N1bWVudGF0aW9uL3ZpcnR1YWwva3ZtL21zci50eHQgfCA4ICsrKysr
KystCj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
Pj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3ZpcnR1YWwva3ZtL21zci50eHQg
Yi9Eb2N1bWVudGF0aW9uL3ZpcnR1YWwva3ZtL21zci50eHQKPj4+PiBpbmRleCAyYTcxYzhmLi4z
Mzc2ZjEzIDEwMDY0NAo+Pj4+IC0tLSBhL0RvY3VtZW50YXRpb24vdmlydHVhbC9rdm0vbXNyLnR4
dAo+Pj4+ICsrKyBiL0RvY3VtZW50YXRpb24vdmlydHVhbC9rdm0vbXNyLnR4dAo+Pj4+IEBAIC0y
MDgsNyArMjA4LDggQEAgTVNSX0tWTV9TVEVBTF9USU1FOiAweDRiNTY0ZDAzCj4+Pj4gIAkJX191
NjQgc3RlYWw7Cj4+Pj4gIAkJX191MzIgdmVyc2lvbjsKPj4+PiAgCQlfX3UzMiBmbGFnczsKPj4+
PiAtCQlfX3UzMiBwYWRbMTJdOwo+Pj4+ICsJCV9fdTggIHByZWVtcHRlZDsKPj4+PiArCQlfX3Uz
MiBwYWRbMTFdOwo+Pj4+ICAJfQo+Pj4KPj4+IEkgdGhpbmsgSSdkIGJlIGV4cGxpY2l0IGFib3V0
IHRoZSAzIHBhZCBieXRlcyB5b3UndmUgbGVmdC4KPj4gCj4+IFNlY29uZGVkLgo+PiAKPj4gV2l0
aCB0aGF0IGNoYW5nZSBhcmUgYWxsIEtWTSBiaXRzCj4+IAo+PiBBY2tlZC1ieTogUmFkaW0gS3LE
jW3DocWZIDxya3JjbWFyQHJlZGhhdC5jb20+Cj4gCj4gU2F3IHRoaXMgYWZ0ZXIgcmVwbHlpbmcg
dG8gdGhlIHByZXZpb3VzIG1lc3NhZ2UuICBJZiB5b3UgbmVlZCB0byBwb3N0IHY2Cj4gb2YgdGhl
IGZ1bGwgc2VyaWVzLCBpdCB3b3VsZCBiZSBuaWNlIGlmIHlvdSByZW1vdmVkIHRoZQo+IGt2bV9y
ZWFkX2d1ZXN0X2NhY2hlZC4gIEJ1dCBhbnl3YXkgaXQgd2Fzbid0IG15IGludGVudGlvbiB0byBv
dmVycmlkZSBSYWRpbS4KClRoZSBwYXRjaCB3YXMgYWNjZXB0YWJsZSB0byBtZSBldmVuIG5vdywg
c28gSSBkZWZpbml0ZWx5IHdvdWxkbid0IG1pbmQKaWYgaXQgd2VyZSBldmVuIG5pY2VyLiA6KQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
