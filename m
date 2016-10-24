From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 5/5] x86, kvm: support vcpu preempted check
Date: Mon, 24 Oct 2016 17:18:36 +0200
Message-ID: <1a556fcf-e071-8c32-7a4b-ca7a2ffc17e9__49833.2198047594$1477322358$gmane$org@redhat.com>
References: <1476872416-42752-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1476872416-42752-6-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<20161019172403.GA9240@potion>
	<c00e636e-ea06-6bbb-6a67-39804ee8ba75@redhat.com>
	<20161024151417.GC2247@potion>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161024151417.GC2247@potion>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: kernellwp@gmail.com, linux-s390@vger.kernel.org, benh@kernel.crashing.org, jgross@suse.com, kvm@vger.kernel.org, peterz@infradead.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, will.deacon@arm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, xen-devel-request@lists.xenproject.org, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, boqun.feng@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyNC8xMC8yMDE2IDE3OjE0LCBSYWRpbSBLcsSNbcOhxZkgd3JvdGU6Cj4gMjAxNi0xMC0y
NCAxNjozOSswMjAwLCBQYW9sbyBCb256aW5pOgo+PiBPbiAxOS8xMC8yMDE2IDE5OjI0LCBSYWRp
bSBLcsSNbcOhxZkgd3JvdGU6Cj4+Pj4+ICsJaWYgKHZjcHUtPmFyY2guc3QubXNyX3ZhbCAmIEtW
TV9NU1JfRU5BQkxFRCkKPj4+Pj4gKwkJaWYgKGt2bV9yZWFkX2d1ZXN0X2NhY2hlZCh2Y3B1LT5r
dm0sICZ2Y3B1LT5hcmNoLnN0LnN0aW1lLAo+Pj4+PiArCQkJCQkmdmNwdS0+YXJjaC5zdC5zdGVh
bCwKPj4+Pj4gKwkJCQkJc2l6ZW9mKHN0cnVjdCBrdm1fc3RlYWxfdGltZSkpID09IDApIHsKPj4+
Pj4gKwkJCXZjcHUtPmFyY2guc3Quc3RlYWwucHJlZW1wdGVkID0gMTsKPj4+Pj4gKwkJCWt2bV93
cml0ZV9ndWVzdF9jYWNoZWQodmNwdS0+a3ZtLCAmdmNwdS0+YXJjaC5zdC5zdGltZSwKPj4+Pj4g
KwkJCQkJJnZjcHUtPmFyY2guc3Quc3RlYWwsCj4+Pj4+ICsJCQkJCXNpemVvZihzdHJ1Y3Qga3Zt
X3N0ZWFsX3RpbWUpKTsKPj4+Pj4gKwkJfQo+Pj4gUGxlYXNlIG5hbWUgdGhpcyBibG9jayBvZiBj
b2RlLiAgU29tZXRoaW5nIGxpa2UKPj4+ICAga3ZtX3N0ZWFsX3RpbWVfc2V0X3ByZWVtcHRlZCh2
Y3B1KTsKPj4KPj4gV2hpbGUgYXQgaXQ6Cj4+Cj4+IDEpIHRoZSBrdm1fcmVhZF9ndWVzdF9jYWNo
ZWQgaXMgbm90IG5lY2Vzc2FyeS4gIFlvdSBjYW4gcmlnIHRoZSBjYWxsIHRvCj4+IGt2bV93cml0
ZV9ndWVzdF9jYWNoZWQgc28gdGhhdCBpdCBvbmx5IHdyaXRlcyB2Y3B1LT5hcmNoLnN0LnN0ZWFs
LnByZWVtcHRlZC4KPiAKPiBJIGFncmVlLiAga3ZtX3dyaXRlX2d1ZXN0X2NhY2hlZCgpIGFsd2F5
cyB3cml0ZXMgZnJvbSBvZmZzZXQgMCwgc28gd2UnZAo+IHdhbnQgYSBuZXcgZnVuY3Rpb24gdGhh
dCBhbGxvd3MgdG8gc3BlY2lmeSBhIHN0YXJ0aW5nIG9mZnNldC4KClllYWgsIGxldCdzIGxlYXZl
IGl0IGZvciBhIGZvbGxvdy11cCB0aGVuIQoKVGhhbmtzLAoKUGFvbG8KCj4gVXNpbmcgY2FjaGVk
IHZjcHUtPmFyY2guc3Quc3RlYWwgdG8gYXZvaWQgdGhlIHJlYWQgd291bGRuJ3QgYmUgYXMgZ29v
ZC4KPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
