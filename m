From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] KVM: s390: Disable CONFIG_S390_GUEST_OLD_TRANSPORT by
	default
Date: Tue, 26 Sep 2017 13:04:03 +0200
Message-ID: <20170926110403.GC3209__36531.439892906$1506423887$gmane$org@osiris>
References: <1506350729-11311-1-git-send-email-thuth@redhat.com>
	<3c2b8ae8-ca2a-7b26-8ebd-14f14c286529@linux.vnet.ibm.com>
	<83cacb4a-94b1-c7c2-e50d-70afea5d3e9c@de.ibm.com>
	<20170926104019.GA3209@osiris>
	<376655d1-87e3-4187-d2d1-d1f23c02431a@de.ibm.com>
	<20170926104752.GB3209@osiris>
	<ec6d80f2-17ca-4a5f-a357-5cc165b1acfd@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <ec6d80f2-17ca-4a5f-a357-5cc165b1acfd@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Huth <thuth@redhat.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

T24gVHVlLCBTZXAgMjYsIDIwMTcgYXQgMTI6NTc6MjZQTSArMDIwMCwgVGhvbWFzIEh1dGggd3Jv
dGU6Cj4gT24gMjYuMDkuMjAxNyAxMjo0NywgSGVpa28gQ2Fyc3RlbnMgd3JvdGU6Cj4gPiBTbyBp
dCdzIGdvaW5nIHRvIGJlIHJlbW92ZWQgd2l0aCB0aGUgbmV4dCBtZXJnZSB3aW5kb3cuCj4gPiBX
aGVyZSBpcyB0aGUgcGF0Y2g/IDspCj4gCj4gSG1tLCBzbyBmYXIgdGhlIGNvZGUgd2FzIGFsd2F5
cyBlbmFibGVkIGJ5IGRlZmF1bHQsIHNvIGluIHRoZSB1bmxpa2VseQo+IGNhc2UgdGhhdCBzb21l
Ym9keSBpcyBzdGlsbCB1c2luZyBpdCwgdGhleSBtaWdodCBub3QgaGF2ZSBub3RpY2VkIHRoYXQK
PiB0aGlzIGlzIG1hcmtlZCBhcyBkZXByZWNhdGVkLiBTbyBtYXliZSBpdCdzIGJldHRlciB0byBr
ZWVwIHRoZSBjb2RlIGZvcgo+IHR3byBtb3JlIHJlbGVhc2VkLCBidXQgZGlzYWJsZSBpdCBieSBk
ZWZhdWx0LCBzbyB0aGF0IHBlb3BsZSBoYXZlIHRpbWUKPiB0byByZWFsaXplIHRoYXQgaXQgaXMg
Z29pbmcgYXdheT8gLi4uIGp1c3QgbXkgMC4wMiDigqwgLi4uIGJ1dCBpZiB5b3UKPiBwcmVmZXIs
IEkgY2FuIGFsc28gd3JpdGUgYSBwYXRjaCB0aGF0IHJlbW92ZXMgaXQgaW1tZWRpYXRlbHkgaW5z
dGVhZC4KClN3aXRjaGluZyB0aGUgZGVmYXVsdCBmcm9tIHllcyB0byBubyB3b24ndCBwcmV2ZW50
IGFueWJvZHkgZnJvbSBzZWxlY3RpbmcKaXQgYWdhaW4uIFNvIEkgZG9uJ3Qgc2VlIGFueSB2YWx1
ZSBpbiB3YWl0aW5nIGV2ZW4gbG9uZ2VyLgoKQmVzaWRlcyB0aGUgb3JpZ2luYWwgY29tbWl0IGFs
cmVhZHkgcHJpbnRlZCBhIG1lc3NhZ2UgdG8gdGhlIGNvbnNvbGUgdGhhdAp0aGUgdHJhbnNwb3J0
IGlzIGRlcHJlY2F0ZWQuClNlZSBjb21taXQgM2IyZmJiM2YwNmVmICgidmlydGlvL3MzOTA6IGRl
cHJlY2F0ZSBvbGQgdHJhbnNwb3J0IikuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
