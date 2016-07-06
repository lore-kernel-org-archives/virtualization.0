From: xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/4] powerpc/spinlock: support vcpu preempted check
Date: Wed, 06 Jul 2016 12:58:11 +0800
Message-ID: <577C8FE3.3010208@linux.vnet.ibm.com>
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1467124991-13164-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<CANRm+CxQMSrg69p2Xey829Mz4Au9YCai+4JD17i9urdbj0VgkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CANRm+CxQMSrg69p2Xey829Mz4Au9YCai+4JD17i9urdbj0VgkQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Peter Zijlstra <peterz@infradead.org>, mpe@ellerman.id.au, boqun.feng@gmail.com, will.deacon@arm.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Waiman Long <waiman.long@hpe.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org, schwidefsky@de.ibm.com, Paul McKenney <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org

SGksIHdhbnBlbmcKCk9uIDIwMTblubQwN+aciDA15pelIDE3OjU3LCBXYW5wZW5nIExpIHdyb3Rl
Ogo+IEhpIFhpbmh1aSwKPiAyMDE2LTA2LTI4IDIyOjQzIEdNVCswODowMCBQYW4gWGluaHVpIDx4
aW5odWkucGFuQGxpbnV4LnZuZXQuaWJtLmNvbT46Cj4+IFRoaXMgaXMgdG8gZml4IHNvbWUgbG9j
ayBob2xkZXIgcHJlZW1wdGlvbiBpc3N1ZXMuIFNvbWUgb3RoZXIgbG9ja3MKPj4gaW1wbGVtZW50
YXRpb24gZG8gYSBzcGluIGxvb3AgYmVmb3JlIGFjcXVpcmluZyB0aGUgbG9jayBpdHNlbGYuIEN1
cnJlbnRseQo+PiBrZXJuZWwgaGFzIGFuIGludGVyZmFjZSBvZiBib29sIHZjcHVfaXNfcHJlZW1w
dGVkKGludCBjcHUpLiBJdCB0YWtlIHRoZSBjcHUKPj4gYXMgcGFyYW1ldGVyIGFuZCByZXR1cm4g
dHJ1ZSBpZiB0aGUgY3B1IGlzIHByZWVtcHRlZC4gVGhlbiBrZXJuZWwgY2FuIGJyZWFrCj4+IHRo
ZSBzcGluIGxvb3BzIHVwb24gb24gdGhlIHJldHZhbCBvZiB2Y3B1X2lzX3ByZWVtcHRlZC4KPj4K
Pj4gQXMga2VybmVsIGhhcyB1c2VkIHRoaXMgaW50ZXJmYWNlLCBTbyBsZXRzIHN1cHBvcnQgaXQu
Cj4+Cj4+IE9ubHkgcFNlcmllcyBuZWVkIHN1cG9vcnQgaXQuIEFuZCB0aGUgZmFjdCBpcyBwb3dl
ck5WIGFyZSBidWlsdCBpbnRvIHNhbWUKPj4ga2VybmVsIGltYWdlIHdpdGggcFNlcmllcy4gU28g
d2UgbmVlZCByZXR1cm4gZmFsc2UgaWYgd2UgYXJlIHJ1bm5pZyBhcwo+PiBwb3dlck5WLiBUaGUg
YW5vdGhlciBmYWN0IGlzIHRoYXQgbHBwYWNhLT55aWxlZF9jb3VudCBrZWVwcyB6ZXJvIG9uCj4+
IHBvd2VyTlYuIFNvIHdlIGNhbiBqdXN0IHNraXAgdGhlIG1hY2hpbmUgdHlwZS4KPgo+IExvY2sg
aG9sZGVyIHZDUFUgcHJlZW1wdGlvbiBjYW4gYmUgZGV0ZWN0ZWQgYnkgaGFyZHdhcmUgcFNlcmll
cyBvcgo+IHBhcmF2aXJ0IG1ldGhvZD8KPgpUaGVyZSBpcyBvbmUgc2hhcmQgc3RydWN0IGJldHdl
ZW4ga2VybmVsIGFuZCBwb3dlclZNL0tWTS4gQW5kIHdlIHJlYWQgdGhlIHlpZWxkX2NvdW50IG9m
IHRoaXMgc3RydWN0IHRvIGRldGVjdCBpZiBvbmUgdmNwdSBpcyBydW5uaW5nIG9yIG5vdC4KU08g
aXQncyBlYXN5IGZvciBwcGMgdG8gaW1wbGVtZW50IHN1Y2ggaW50ZXJmYWNlLiBOb3RlIHRoYXQg
eWllbGRfY291bnQgaXMgc2V0IGJ5IHBvd2VyVk0vS1ZNLgphbmQgb25seSBwU2VyaWVzIGNhbiBy
dW4gYSBndWVzdCBmb3Igbm93LiA6KQoKSSBhbHNvIHJldmlldyB4ODYgcmVsYXRlZCBjb2RlLCBs
b29rcyBsaWtlIHdlIG5lZWQgYWRkIG9uZSBoeWVyLWNhbGwgdG8gZ2V0IHN1Y2ggdmNwdSBwcmVl
bXB0aW9uIGluZm8/Cgp0aGFua3MKeGludWkKPiBSZWdhcmRzLAo+IFdhbnBlbmcgTGkKPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
