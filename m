From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v10 03/19] qspinlock: Add pending bit
Date: Mon, 12 May 2014 19:29:53 +0200
Message-ID: <20140512172953.GF13467__773.320793132548$1399915814$gmane$org@laptop.programming.kicks-ass.net>
References: <1399474907-22206-1-git-send-email-Waiman.Long@hp.com>
	<1399474907-22206-4-git-send-email-Waiman.Long@hp.com>
	<20140512152208.GA12309@potion.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140512152208.GA12309@potion.brq.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: x86@kernel.org, Gleb Natapov <gleb@redhat.com>, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, Paolo Bonzini <paolo.bonzini@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, virtualization@lists.linux-foundation.org, Chegu Vinod <chegu_vinod@hp.com>, Waiman Long <Waiman.Long@hp.com>, Oleg Nesterov <oleg@redhat.com>, David Vrabel <david.vrabel@citrix.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

T24gTW9uLCBNYXkgMTIsIDIwMTQgYXQgMDU6MjI6MDhQTSArMDIwMCwgUmFkaW0gS3LEjW3DocWZ
IHdyb3RlOgo+IDIwMTQtMDUtMDcgMTE6MDEtMDQwMCwgV2FpbWFuIExvbmc6Cj4gPiBGcm9tOiBQ
ZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+Cj4gPiAKPiA+IEJlY2F1c2UgdGhl
IHFzcGlubG9jayBuZWVkcyB0byB0b3VjaCBhIHNlY29uZCBjYWNoZWxpbmU7IGFkZCBhIHBlbmRp
bmcKPiA+IGJpdCBhbmQgYWxsb3cgYSBzaW5nbGUgaW4td29yZCBzcGlubmVyIGJlZm9yZSB3ZSBw
dW50IHRvIHRoZSBzZWNvbmQKPiA+IGNhY2hlbGluZS4KPiAKPiBJIHRoaW5rIHRoZXJlIGlzIGFu
IHVud2FudGVkIHNjZW5hcmlvIG9uIHZpcnR1YWwgbWFjaGluZXM6Cj4gMSkgVkNQVSBzZXRzIHRo
ZSBwZW5kaW5nIGJpdCBhbmQgc3RhcnQgc3Bpbm5pbmcuCj4gMikgUGVuZGluZyBWQ1BVIGdldHMg
ZGVzY2hlZHVsZWQuCj4gICAgIC0gd2UgaGF2ZSBQTEUgYW5kIGxvY2sgaG9sZGVyIGlzbid0IHJ1
bm5pbmcgWzFdCj4gICAgIC0gdGhlIGh5cGVydmlzb3IgcmFuZG9tbHkgcHJlZW1wdHMgdXMKPiAz
KSBMb2NrIGhvbGRlciB1bmxvY2tzIHdoaWxlIHBlbmRpbmcgVkNQVSBpcyB3YWl0aW5nIGluIHF1
ZXVlLgo+IDQpIFN1YnNlcXVlbnQgbG9ja2VycyB3aWxsIHNlZSBmcmVlIGxvY2sgd2l0aCBzZXQg
cGVuZGluZyBiaXQgYW5kIHdpbGwKPiAgICBsb29wIGluIHRyeWxvY2sncyAnZm9yICg7OyknCj4g
ICAgIC0gdGhlIHdvcnN0LWNhc2UgaXMgbG9jayBzdGFydmluZyBbMl0KPiAgICAgLSBQTEUgY2Fu
IHNhdmUgdXMgZnJvbSB3YXN0aW5nIHdob2xlIHRpbWVzbGljZQo+IAo+IFJldHJ5IHRocmVzaG9s
ZCBpcyB0aGUgZWFzaWVzdCBzb2x1dGlvbiwgcmVnYXJkbGVzcyBvZiBpdHMgdWdsaW5lc3MgWzRd
Lgo+IAo+IEFub3RoZXIgbWlub3IgZGVzaWduIGZsYXcgaXMgdGhhdCBmb3JtZXJseSBmaXJzdCBW
Q1BVIGdldHMgYXBwZW5kZWQgdG8KPiB0aGUgdGFpbCB3aGVuIGl0IGRlY2lkZXMgdG8gcXVldWU7
Cj4gaXMgdGhlIHBlcmZvcm1hbmNlIGdhaW4gd29ydGggaXQ/CgpUaGlzIGlzIGFsbCBmb3IgcmVh
bCBoYXJkd2FyZSwgSSd2ZSBub3QgeWV0IHN0YXJlZCBhdCB0aGUgKHBhcmEpdmlydApjcmFwLgoK
TXkgcHJpbWFyeSBjb25jZXJuIGlzIHRoYXQgbmF0aXZlIGhhcmR3YXJlIHJ1bnMgZ29vZCBhbmQg
dGhhdCB0aGUKKHBhcmEpdmlydCBzdXBwb3J0IGRvZXMgcmFwZSB0aGUgY29kZSAtLSBzbyBmYXIg
aXRzIGZhaWxpbmcgaGFyZCBvbiB0aGUKc2Vjb25kLgoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
