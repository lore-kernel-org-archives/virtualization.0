From: "rkrcmar@redhat.com" <rkrcmar@redhat.com>
Subject: Re: [PATCH v5 9/9] Documentation: virtual: kvm: Support vcpu
	preempted check
Date: Fri, 21 Oct 2016 20:39:52 +0200
Message-ID: <20161021183951.GA29131__18374.494839418$1477075225$gmane$org@potion>
References: <1476998874-2089-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1476998874-2089-10-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<063D6719AE5E284EB5DD2968C1650D6DB0207B44@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DB0207B44@AcuExch.aculab.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Laight <David.Laight@ACULAB.COM>
Cc: "kernellwp@gmail.com" <kernellwp@gmail.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "jgross@suse.com" <jgross@suse.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, 'Pan Xinhui' <xinhui.pan@linux.vnet.ibm.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "paulus@samba.org" <paulus@samba.org>, "xen-devel-request@lists.xenproject.org" <xen-devel-request@lists.xenproject.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: virtualization@lists.linuxfoundation.org

MjAxNi0xMC0yMSAxMToyNyswMDAwLCBEYXZpZCBMYWlnaHQ6Cj4gRnJvbTogUGFuIFhpbmh1aQo+
PiBTZW50OiAyMCBPY3RvYmVyIDIwMTYgMjI6MjgKPj4gQ29tbWl0ICgieDg2LCBrdm06IHN1cHBv
cnQgdmNwdSBwcmVlbXB0ZWQgY2hlY2siKSBhZGQgb25lIGZpZWxkICJfX3U4Cj4+IHByZWVtcHRl
ZCIgaW50byBzdHJ1Y3Qga3ZtX3N0ZWFsX3RpbWUuIFRoaXMgZmllbGQgdGVsbHMgaWYgb25lIHZj
cHUgaXMKPj4gcnVubmluZyBvciBub3QuCj4+IAo+PiBJdCBpcyB6ZXJvIGlmIDEpIHNvbWUgb2xk
IEtWTSBkZW9zIG5vdCBzdXBwb3J0IHRoaXMgZmlsZWQuIDIpIHRoZSB2Y3B1IGlzCj4+IHByZWVt
cHRlZC4gT3RoZXIgdmFsdWVzIG1lYW5zIHRoZSB2Y3B1IGhhcyBiZWVuIHByZWVtcHRlZC4KPj4g
Cj4+IFNpZ25lZC1vZmYtYnk6IFBhbiBYaW5odWkgPHhpbmh1aS5wYW5AbGludXgudm5ldC5pYm0u
Y29tPgo+PiAtLS0KPj4gIERvY3VtZW50YXRpb24vdmlydHVhbC9rdm0vbXNyLnR4dCB8IDggKysr
KysrKy0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
Pj4gCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3ZpcnR1YWwva3ZtL21zci50eHQgYi9E
b2N1bWVudGF0aW9uL3ZpcnR1YWwva3ZtL21zci50eHQKPj4gaW5kZXggMmE3MWM4Zi4uMzM3NmYx
MyAxMDA2NDQKPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi92aXJ0dWFsL2t2bS9tc3IudHh0Cj4+ICsr
KyBiL0RvY3VtZW50YXRpb24vdmlydHVhbC9rdm0vbXNyLnR4dAo+PiBAQCAtMjA4LDcgKzIwOCw4
IEBAIE1TUl9LVk1fU1RFQUxfVElNRTogMHg0YjU2NGQwMwo+PiAgCQlfX3U2NCBzdGVhbDsKPj4g
IAkJX191MzIgdmVyc2lvbjsKPj4gIAkJX191MzIgZmxhZ3M7Cj4+IC0JCV9fdTMyIHBhZFsxMl07
Cj4+ICsJCV9fdTggIHByZWVtcHRlZDsKPj4gKwkJX191MzIgcGFkWzExXTsKPj4gIAl9Cj4gCj4g
SSB0aGluayBJJ2QgYmUgZXhwbGljaXQgYWJvdXQgdGhlIDMgcGFkIGJ5dGVzIHlvdSd2ZSBsZWZ0
LgoKU2Vjb25kZWQuCgpXaXRoIHRoYXQgY2hhbmdlIGFyZSBhbGwgS1ZNIGJpdHMKCkFja2VkLWJ5
OiBSYWRpbSBLcsSNbcOhxZkgPHJrcmNtYXJAcmVkaGF0LmNvbT4KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
