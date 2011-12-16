From: Zang Hongyong <zanghongyong@huawei.com>
Subject: Re: [PATCH 0/2] vhot-net: Use kvm_memslots instead of vhost_memory to
	translate GPA to HVA
Date: Fri, 16 Dec 2011 15:40:01 +0800
Message-ID: <4EEAF5D1.2080805__771.75540286607$1324331283$gmane$org@huawei.com>
References: <1324013528-3663-1-git-send-email-zanghongyong@huawei.com>
	<1324019151.4496.9.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-reply-to: <1324019151.4496.9.camel@lappy>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: wusongwei@huawei.com, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, hanweidong@huawei.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xiaowei.yang@huawei.com
List-Id: virtualization@lists.linuxfoundation.org

5LqOIDIwMTEvMTIvMTYs5pif5pyf5LqUIDE1OjA1LCBTYXNoYSBMZXZpbiDlhpnpgZM6Cj4gT24g
RnJpLCAyMDExLTEyLTE2IGF0IDEzOjMyICswODAwLCB6YW5naG9uZ3lvbmdAaHVhd2VpLmNvbSB3
cm90ZToKPj4gRnJvbTogSG9uZ3lvbmcgWmFuZzx6YW5naG9uZ3lvbmdAaHVhd2VpLmNvbT4KPj4K
Pj4gVmhvc3QtbmV0IHVzZXMgaXRzIG93biB2aG9zdF9tZW1vcnksIHdoaWNoIHJlc3VsdHMgZnJv
bSB1c2VyIHNwYWNlIChxZW11KSBpbmZvLAo+PiB0byB0cmFuc2xhdGUgR1BBIHRvIEhWQS4gU2lu
Y2Uga2VybmVsJ3Mga3ZtIHN0cnVjdHVyZSBhbHJlYWR5IG1haW50YWlucyB0aGUKPj4gYWRkcmVz
cyByZWxhdGlvbnNoaXAgaW4gaXRzIG1lbWJlciAqa3ZtX21lbXNsb3RzKiwgdGhlc2UgcGF0Y2hl
cyB1c2Uga2VybmVsJ3MKPj4ga3ZtX21lbXNsb3RzIGRpcmVjdGx5IHdpdGhvdXQgdGhlIG5lZWQg
b2YgaW5pdGlhbGl6YXRpb24gYW5kIG1haW50ZW5hbmNlIG9mCj4+IHZob3N0X21lbW9yeS4KPiBD
b25jZXB0dWFsbHksIHZob3N0IGlzbid0IGF3YXJlIG9mIEtWTSAtIGl0J3MganVzdCBhIGRyaXZl
ciB3aGljaCBtb3Zlcwo+IGRhdGEgZnJvbSB2cSB0byBhIHRhcCBkZXZpY2UgYW5kIGJhY2suIFlv
dSBjYW4ndCBzaW1wbHkgYWRkIEtWTSBzcGVjaWZpYwo+IGNvZGUgaW50byB2aG9zdC4KPgo+IFdo
YXRzIHRoZSBwZXJmb3JtYW5jZSBiZW5lZml0Pwo+CkJ1dCB2aG9zdC1uZXQgaXMgb25seSB1c2Vk
IGluIHZpcnR1YWxpemF0aW9uIHNpdHVhdGlvbi4gdmhvc3RfbWVtb3J5IGlzIAptYWludGFpbmVk
CmJ5IHVzZXIgc3BhY2UgcWVtdS4KSW4gdGhpcyB3YXksIHRoZSBtZW1vcnkgcmVsYXRpb25zaGlw
IGNhbiBiZSBhY2NxdWlyZWQgZnJvbSBrZXJuZWwgCndpdGhvdXQgdGhlCm5lZWQgb2YgbWFpbnRh
aW5lbmNlIG9mIHZob3N0X21lbW9yeSBmcm9tIHFlbXUuCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
