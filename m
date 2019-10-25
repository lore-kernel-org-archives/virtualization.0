From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2] vhost: introduce mdev based hardware backend
Date: Fri, 25 Oct 2019 17:54:55 +0800
Message-ID: <e7e239ba-2461-4f8d-7dd7-0f557ac7f4bf__22591.4370080986$1571997330$gmane$org@redhat.com>
References: <47a572fd-5597-1972-e177-8ee25ca51247@redhat.com>
	<20191023030253.GA15401@___>
	<ac36f1e3-b972-71ac-fe0c-3db03e016dcf@redhat.com>
	<20191023070747.GA30533@___>
	<106834b5-dae5-82b2-0f97-16951709d075@redhat.com>
	<20191023101135.GA6367@___>
	<5a7bc5da-d501-2750-90bf-545dd55f85fa@redhat.com>
	<20191024042155.GA21090@___>
	<d37529e1-5147-bbe5-cb9d-299bd6d4aa1a@redhat.com>
	<d4cc4f4e-2635-4041-2f68-cd043a97f25a@redhat.com>
	<20191024091839.GA17463@___>
	<fefc82a3-a137-bc03-e1c3-8de79b238080@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <fefc82a3-a137-bc03-e1c3-8de79b238080@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, zhihong.wang@intel.com, maxime.coquelin@redhat.com, lingshan.zhu@intel.com
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMTAvMjQg5LiL5Y2INjo0MiwgSmFzb24gV2FuZyB3cm90ZToKPgo+IFllcy4KPgo+
Cj4+IMKgIEFuZCB3ZSBzaG91bGQgdHJ5IHRvIGF2b2lkCj4+IHB1dHRpbmcgY3RybCB2cSBhbmQg
UngvVHggdnFzIGluIHRoZSBzYW1lIERNQSBzcGFjZSB0byBwcmV2ZW50Cj4+IGd1ZXN0cyBoYXZp
bmcgdGhlIGNoYW5jZSB0byBieXBhc3MgdGhlIGhvc3QgKGUuZy4gUUVNVSkgdG8KPj4gc2V0dXAg
dGhlIGJhY2tlbmQgYWNjZWxlcmF0b3IgZGlyZWN0bHkuCj4KPgo+IFRoYXQncyByZWFsbHkgZ29v
ZCBwb2ludC7CoCBTbyB3aGVuICJ2aG9zdCIgdHlwZSBpcyBjcmVhdGVkLCBwYXJlbnQgCj4gc2hv
dWxkIGFzc3VtZSBhZGRyIG9mIGN0cmxfdnEgaXMgaHZhLgo+Cj4gVGhhbmtzCgoKVGhpcyB3b3Jr
cyBmb3Igdmhvc3QgYnV0IG5vdCB2aXJ0aW8gc2luY2UgdGhlcmUncyBubyB3YXkgZm9yIHZpcnRp
byAKa2VybmVsIGRyaXZlciB0byBkaWZmZXIgY3RybF92cSB3aXRoIHRoZSByZXN0IHdoZW4gZG9p
bmcgRE1BIG1hcC4gT25lIApwb3NzaWJsZSBzb2x1dGlvbiBpcyB0byBwcm92aWRlIERNQSBkb21h
aW4gaXNvbGF0aW9uIGJldHdlZW4gdmlydHF1ZXVlcy4gClRoZW4gY3RybCB2cSBjYW4gdXNlIGl0
cyBkZWRpY2F0ZWQgRE1BIGRvbWFpbiBmb3IgdGhlIHdvcmsuCgpBbnl3YXksIHRoaXMgY291bGQg
YmUgZG9uZSBpbiB0aGUgZnV0dXJlLiBXZSBjYW4gaGF2ZSBhIHZlcnNpb24gZmlyc3QgCnRoYXQg
ZG9lc24ndCBzdXBwb3J0IGN0cmxfdnEuCgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
