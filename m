From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 5/5] x86, kvm: support vcpu preempted check
Date: Mon, 24 Oct 2016 16:39:39 +0200
Message-ID: <c00e636e-ea06-6bbb-6a67-39804ee8ba75__2871.45163533769$1477320028$gmane$org@redhat.com>
References: <1476872416-42752-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1476872416-42752-6-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<20161019172403.GA9240@potion>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161019172403.GA9240@potion>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: kernellwp@gmail.com, linux-s390@vger.kernel.org, jgross@suse.com, kvm@vger.kernel.org, peterz@infradead.org, xen-devel-request@lists.xenproject.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, boqun.feng@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAxOS8xMC8yMDE2IDE5OjI0LCBSYWRpbSBLcsSNbcOhxZkgd3JvdGU6Cj4+ID4gKwlpZiAo
dmNwdS0+YXJjaC5zdC5tc3JfdmFsICYgS1ZNX01TUl9FTkFCTEVEKQo+PiA+ICsJCWlmIChrdm1f
cmVhZF9ndWVzdF9jYWNoZWQodmNwdS0+a3ZtLCAmdmNwdS0+YXJjaC5zdC5zdGltZSwKPj4gPiAr
CQkJCQkmdmNwdS0+YXJjaC5zdC5zdGVhbCwKPj4gPiArCQkJCQlzaXplb2Yoc3RydWN0IGt2bV9z
dGVhbF90aW1lKSkgPT0gMCkgewo+PiA+ICsJCQl2Y3B1LT5hcmNoLnN0LnN0ZWFsLnByZWVtcHRl
ZCA9IDE7Cj4+ID4gKwkJCWt2bV93cml0ZV9ndWVzdF9jYWNoZWQodmNwdS0+a3ZtLCAmdmNwdS0+
YXJjaC5zdC5zdGltZSwKPj4gPiArCQkJCQkmdmNwdS0+YXJjaC5zdC5zdGVhbCwKPj4gPiArCQkJ
CQlzaXplb2Yoc3RydWN0IGt2bV9zdGVhbF90aW1lKSk7Cj4+ID4gKwkJfQo+IFBsZWFzZSBuYW1l
IHRoaXMgYmxvY2sgb2YgY29kZS4gIFNvbWV0aGluZyBsaWtlCj4gICBrdm1fc3RlYWxfdGltZV9z
ZXRfcHJlZW1wdGVkKHZjcHUpOwoKV2hpbGUgYXQgaXQ6CgoxKSB0aGUga3ZtX3JlYWRfZ3Vlc3Rf
Y2FjaGVkIGlzIG5vdCBuZWNlc3NhcnkuICBZb3UgY2FuIHJpZyB0aGUgY2FsbCB0bwprdm1fd3Jp
dGVfZ3Vlc3RfY2FjaGVkIHNvIHRoYXQgaXQgb25seSB3cml0ZXMgdmNwdS0+YXJjaC5zdC5zdGVh
bC5wcmVlbXB0ZWQuCgoyKSBzcGxpdCB0aGUgcGF0Y2ggaW4gaG9zdCBhbmQgZ3Vlc3Qgc2lkZXMu
CgpQYW9sbwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
