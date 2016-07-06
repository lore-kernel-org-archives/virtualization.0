From: Wanpeng Li <kernellwp@gmail.com>
Subject: Re: [PATCH v2 2/4] powerpc/spinlock: support vcpu preempted check
Date: Wed, 6 Jul 2016 14:46:34 +0800
Message-ID: <CANRm+CySutzEYQuCaeqyLKKVPPcFDFT94UsNaYWo8fU43VsSig@mail.gmail.com>
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1467124991-13164-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<CANRm+CxQMSrg69p2Xey829Mz4Au9YCai+4JD17i9urdbj0VgkQ@mail.gmail.com>
	<577C8FE3.3010208@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <577C8FE3.3010208@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, kvm <kvm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, mpe@ellerman.id.au, boqun.feng@gmail.com, will.deacon@arm.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Waiman Long <waiman.long@hpe.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org, schwidefsky@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org

Q2MgUGFvbG8sIGt2bSBtbAoyMDE2LTA3LTA2IDEyOjU4IEdNVCswODowMCB4aW5odWkgPHhpbmh1
aS5wYW5AbGludXgudm5ldC5pYm0uY29tPjoKPiBIaSwgd2FucGVuZwo+Cj4gT24gMjAxNuW5tDA3
5pyIMDXml6UgMTc6NTcsIFdhbnBlbmcgTGkgd3JvdGU6Cj4+Cj4+IEhpIFhpbmh1aSwKPj4gMjAx
Ni0wNi0yOCAyMjo0MyBHTVQrMDg6MDAgUGFuIFhpbmh1aSA8eGluaHVpLnBhbkBsaW51eC52bmV0
LmlibS5jb20+Ogo+Pj4KPj4+IFRoaXMgaXMgdG8gZml4IHNvbWUgbG9jayBob2xkZXIgcHJlZW1w
dGlvbiBpc3N1ZXMuIFNvbWUgb3RoZXIgbG9ja3MKPj4+IGltcGxlbWVudGF0aW9uIGRvIGEgc3Bp
biBsb29wIGJlZm9yZSBhY3F1aXJpbmcgdGhlIGxvY2sgaXRzZWxmLiBDdXJyZW50bHkKPj4+IGtl
cm5lbCBoYXMgYW4gaW50ZXJmYWNlIG9mIGJvb2wgdmNwdV9pc19wcmVlbXB0ZWQoaW50IGNwdSku
IEl0IHRha2UgdGhlCj4+PiBjcHUKPj4+IGFzIHBhcmFtZXRlciBhbmQgcmV0dXJuIHRydWUgaWYg
dGhlIGNwdSBpcyBwcmVlbXB0ZWQuIFRoZW4ga2VybmVsIGNhbgo+Pj4gYnJlYWsKPj4+IHRoZSBz
cGluIGxvb3BzIHVwb24gb24gdGhlIHJldHZhbCBvZiB2Y3B1X2lzX3ByZWVtcHRlZC4KPj4+Cj4+
PiBBcyBrZXJuZWwgaGFzIHVzZWQgdGhpcyBpbnRlcmZhY2UsIFNvIGxldHMgc3VwcG9ydCBpdC4K
Pj4+Cj4+PiBPbmx5IHBTZXJpZXMgbmVlZCBzdXBvb3J0IGl0LiBBbmQgdGhlIGZhY3QgaXMgcG93
ZXJOViBhcmUgYnVpbHQgaW50byBzYW1lCj4+PiBrZXJuZWwgaW1hZ2Ugd2l0aCBwU2VyaWVzLiBT
byB3ZSBuZWVkIHJldHVybiBmYWxzZSBpZiB3ZSBhcmUgcnVubmlnIGFzCj4+PiBwb3dlck5WLiBU
aGUgYW5vdGhlciBmYWN0IGlzIHRoYXQgbHBwYWNhLT55aWxlZF9jb3VudCBrZWVwcyB6ZXJvIG9u
Cj4+PiBwb3dlck5WLiBTbyB3ZSBjYW4ganVzdCBza2lwIHRoZSBtYWNoaW5lIHR5cGUuCj4+Cj4+
Cj4+IExvY2sgaG9sZGVyIHZDUFUgcHJlZW1wdGlvbiBjYW4gYmUgZGV0ZWN0ZWQgYnkgaGFyZHdh
cmUgcFNlcmllcyBvcgo+PiBwYXJhdmlydCBtZXRob2Q/Cj4+Cj4gVGhlcmUgaXMgb25lIHNoYXJk
IHN0cnVjdCBiZXR3ZWVuIGtlcm5lbCBhbmQgcG93ZXJWTS9LVk0uIEFuZCB3ZSByZWFkIHRoZQo+
IHlpZWxkX2NvdW50IG9mIHRoaXMgc3RydWN0IHRvIGRldGVjdCBpZiBvbmUgdmNwdSBpcyBydW5u
aW5nIG9yIG5vdC4KPiBTTyBpdCdzIGVhc3kgZm9yIHBwYyB0byBpbXBsZW1lbnQgc3VjaCBpbnRl
cmZhY2UuIE5vdGUgdGhhdCB5aWVsZF9jb3VudCBpcwo+IHNldCBieSBwb3dlclZNL0tWTS4KPiBh
bmQgb25seSBwU2VyaWVzIGNhbiBydW4gYSBndWVzdCBmb3Igbm93LiA6KQo+Cj4gSSBhbHNvIHJl
dmlldyB4ODYgcmVsYXRlZCBjb2RlLCBsb29rcyBsaWtlIHdlIG5lZWQgYWRkIG9uZSBoeWVyLWNh
bGwgdG8gZ2V0Cj4gc3VjaCB2Y3B1IHByZWVtcHRpb24gaW5mbz8KClRoZXJlIGlzIG5vIHN1Y2gg
c3R1ZmYgdG8gcmVjb3JkIGxvY2sgaG9sZGVyIGluIHg4NiBrdm0sIG1heWJlIHdlCmRvbid0IG5l
ZWQgdG8gZGVwZW5kIG9uIFBMRSBoYW5kbGVyIGFsZ29yaXRobSB0byBndWVzcyBpdCBpZiB3ZSBj
YW4Ka25vdyBsb2NrIGhvbGRlciB2Q1BVIGRpcmVjdGx5LgoKUmVnYXJkcywKV2FucGVuZyBMaQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
