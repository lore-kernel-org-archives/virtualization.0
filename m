From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] KVM: s390: Disable CONFIG_S390_GUEST_OLD_TRANSPORT by
	default
Date: Tue, 26 Sep 2017 13:10:52 +0200
Message-ID: <20170926131052.4f97f86d.cohuck__41277.8696198531$1509079478$gmane$org@redhat.com>
References: <1506350729-11311-1-git-send-email-thuth@redhat.com>
	<3c2b8ae8-ca2a-7b26-8ebd-14f14c286529@linux.vnet.ibm.com>
	<83cacb4a-94b1-c7c2-e50d-70afea5d3e9c@de.ibm.com>
	<20170926104019.GA3209@osiris>
	<376655d1-87e3-4187-d2d1-d1f23c02431a@de.ibm.com>
	<20170926104752.GB3209@osiris>
	<ec6d80f2-17ca-4a5f-a357-5cc165b1acfd@redhat.com>
	<20170926110403.GC3209@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170926110403.GC3209@osiris>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

T24gVHVlLCAyNiBTZXAgMjAxNyAxMzowNDowMyArMDIwMApIZWlrbyBDYXJzdGVucyA8aGVpa28u
Y2Fyc3RlbnNAZGUuaWJtLmNvbT4gd3JvdGU6Cgo+IE9uIFR1ZSwgU2VwIDI2LCAyMDE3IGF0IDEy
OjU3OjI2UE0gKzAyMDAsIFRob21hcyBIdXRoIHdyb3RlOgo+ID4gT24gMjYuMDkuMjAxNyAxMjo0
NywgSGVpa28gQ2Fyc3RlbnMgd3JvdGU6ICAKPiA+ID4gU28gaXQncyBnb2luZyB0byBiZSByZW1v
dmVkIHdpdGggdGhlIG5leHQgbWVyZ2Ugd2luZG93Lgo+ID4gPiBXaGVyZSBpcyB0aGUgcGF0Y2g/
IDspICAKPiA+IAo+ID4gSG1tLCBzbyBmYXIgdGhlIGNvZGUgd2FzIGFsd2F5cyBlbmFibGVkIGJ5
IGRlZmF1bHQsIHNvIGluIHRoZSB1bmxpa2VseQo+ID4gY2FzZSB0aGF0IHNvbWVib2R5IGlzIHN0
aWxsIHVzaW5nIGl0LCB0aGV5IG1pZ2h0IG5vdCBoYXZlIG5vdGljZWQgdGhhdAo+ID4gdGhpcyBp
cyBtYXJrZWQgYXMgZGVwcmVjYXRlZC4gU28gbWF5YmUgaXQncyBiZXR0ZXIgdG8ga2VlcCB0aGUg
Y29kZSBmb3IKPiA+IHR3byBtb3JlIHJlbGVhc2VkLCBidXQgZGlzYWJsZSBpdCBieSBkZWZhdWx0
LCBzbyB0aGF0IHBlb3BsZSBoYXZlIHRpbWUKPiA+IHRvIHJlYWxpemUgdGhhdCBpdCBpcyBnb2lu
ZyBhd2F5PyAuLi4ganVzdCBteSAwLjAyIOKCrCAuLi4gYnV0IGlmIHlvdQo+ID4gcHJlZmVyLCBJ
IGNhbiBhbHNvIHdyaXRlIGEgcGF0Y2ggdGhhdCByZW1vdmVzIGl0IGltbWVkaWF0ZWx5IGluc3Rl
YWQuICAKPiAKPiBTd2l0Y2hpbmcgdGhlIGRlZmF1bHQgZnJvbSB5ZXMgdG8gbm8gd29uJ3QgcHJl
dmVudCBhbnlib2R5IGZyb20gc2VsZWN0aW5nCj4gaXQgYWdhaW4uIFNvIEkgZG9uJ3Qgc2VlIGFu
eSB2YWx1ZSBpbiB3YWl0aW5nIGV2ZW4gbG9uZ2VyLgo+IAo+IEJlc2lkZXMgdGhlIG9yaWdpbmFs
IGNvbW1pdCBhbHJlYWR5IHByaW50ZWQgYSBtZXNzYWdlIHRvIHRoZSBjb25zb2xlIHRoYXQKPiB0
aGUgdHJhbnNwb3J0IGlzIGRlcHJlY2F0ZWQuCj4gU2VlIGNvbW1pdCAzYjJmYmIzZjA2ZWYgKCJ2
aXJ0aW8vczM5MDogZGVwcmVjYXRlIG9sZCB0cmFuc3BvcnQiKS4KPiAKCldvdWxkIGFjayBhIHJl
bW92YWwgYXMgd2VsbC4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
