From: xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/4] powerpc/spinlock: support vcpu preempted check
Date: Wed, 06 Jul 2016 18:18:27 +0800
Message-ID: <577CDAF3.4030401@linux.vnet.ibm.com>
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1467124991-13164-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<CANRm+CxQMSrg69p2Xey829Mz4Au9YCai+4JD17i9urdbj0VgkQ@mail.gmail.com>
	<577C8FE3.3010208@linux.vnet.ibm.com>
	<CANRm+CySutzEYQuCaeqyLKKVPPcFDFT94UsNaYWo8fU43VsSig@mail.gmail.com>
	<20160706075814.GF30921@twins.programming.kicks-ass.net>
	<CANRm+Cz5-XGDTNkZ_RcoX+gxF_+JDpUB6OB+ECOQcScuaeKfGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CANRm+Cz5-XGDTNkZ_RcoX+gxF_+JDpUB6OB+ECOQcScuaeKfGA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wanpeng Li <kernellwp@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, kvm <kvm@vger.kernel.org>, mpe@ellerman.id.au, boqun.feng@gmail.com, will.deacon@arm.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Waiman Long <waiman.long@hpe.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org, schwidefsky@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTblubQwN+aciDA25pelIDE2OjMyLCBXYW5wZW5nIExpIHdyb3RlOgo+IDIwMTYtMDct
MDYgMTU6NTggR01UKzA4OjAwIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz46
Cj4+IE9uIFdlZCwgSnVsIDA2LCAyMDE2IGF0IDAyOjQ2OjM0UE0gKzA4MDAsIFdhbnBlbmcgTGkg
d3JvdGU6Cj4+Pj4gU08gaXQncyBlYXN5IGZvciBwcGMgdG8gaW1wbGVtZW50IHN1Y2ggaW50ZXJm
YWNlLiBOb3RlIHRoYXQgeWllbGRfY291bnQgaXMKPj4+PiBzZXQgYnkgcG93ZXJWTS9LVk0uCj4+
Pj4gYW5kIG9ubHkgcFNlcmllcyBjYW4gcnVuIGEgZ3Vlc3QgZm9yIG5vdy4gOikKPj4+Pgo+Pj4+
IEkgYWxzbyByZXZpZXcgeDg2IHJlbGF0ZWQgY29kZSwgbG9va3MgbGlrZSB3ZSBuZWVkIGFkZCBv
bmUgaHllci1jYWxsIHRvIGdldAo+Pj4+IHN1Y2ggdmNwdSBwcmVlbXB0aW9uIGluZm8/Cj4+Pgo+
Pj4gVGhlcmUgaXMgbm8gc3VjaCBzdHVmZiB0byByZWNvcmQgbG9jayBob2xkZXIgaW4geDg2IGt2
bSwgbWF5YmUgd2UKPj4+IGRvbid0IG5lZWQgdG8gZGVwZW5kIG9uIFBMRSBoYW5kbGVyIGFsZ29y
aXRobSB0byBndWVzcyBpdCBpZiB3ZSBjYW4KPj4+IGtub3cgbG9jayBob2xkZXIgdkNQVSBkaXJl
Y3RseS4KPj4KPj4geDg2L2t2bSBoYXMgdmNwdS0+cHJlZW1wdGVkIHRvIGluZGljYXRlIGlmIGEg
dmNwdSBpcyBjdXJyZW50bHkgcHJlZW1wdGVkCj4+IG9yIG5vdC4gSSdtIGp1c3Qgbm90IHN1cmUg
aWYgdGhhdCBpcyB2aXNpYmxlIHRvIHRoZSBndWVzdCBvciBob3cgdG8gbWFrZQo+PiBpdCBzby4K
Pgo+IFllYWgsIEkgbWlzcyBpdC4gSSBjYW4gYmUgdGhlIHZvbHVudGVlciB0byBkbyBpdCBpZiB0
aGVyZSBpcyBhbnkgaWRlYSwKPiBwaW5nIFBhb2xvLiA6KQo+CmdsYWQgdG8ga25vdyB0aGF0LiA6
KQoKCj4gUmVnYXJkcywKPiBXYW5wZW5nIExpCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
