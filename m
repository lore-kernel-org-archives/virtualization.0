From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 0/4] Prevent vhost kthread from hogging CPU
Date: Thu, 23 May 2019 10:37:39 +0800
Message-ID: <aa132e69-4646-da70-7def-b6ad72d4ebda__36085.5052642123$1558579078$gmane$org@redhat.com>
References: <1558067392-11740-1-git-send-email-jasowang@redhat.com>
	<20190520085207-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190520085207-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvNS8yMCDkuIvljYg4OjUyLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
RnJpLCBNYXkgMTcsIDIwMTkgYXQgMTI6Mjk6NDhBTSAtMDQwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4gSGk6Cj4+Cj4+IFRoaXMgc2VyaWVzIHRyeSB0byBwcmV2ZW50IGEgZ3Vlc3QgdHJpZ2dlcmFi
bGUgQ1BVIGhvZ2dpbmcgdGhyb3VnaAo+PiB2aG9zdCBrdGhyZWFkLiBUaGlzIGlzIGRvbmUgYnkg
aW50cm9kdWNpbmcgYW5kIGNoZWNraW5nIHRoZSB3ZWlnaHQKPj4gYWZ0ZXIgZWFjaCByZXF1cmVz
dC4gVGhlIHBhdGNoIGhhcyBiZWVuIHRlc3RlZCB3aXRoIHJlcHJvZHVjZXIgb2YKPj4gdnNvY2sg
YW5kIHZpcnRpby1uZXQuIE9ubHkgY29tcGlsZSB0ZXN0IGlzIGRvbmUgZm9yIHZob3N0LXNjc2ku
Cj4+Cj4+IFBsZWFzZSByZXZpZXcuCj4+IFRoaXMgYWRkcmVzc2VzIENWRS0yMDE5LTM5MDAuCj4g
T0sgSSB0aGluayB3ZSBzaG91bGQgY2xlYW4gdGhpcyBjb2RlIHNvbWUgbW9yZSBidXQgZ2l2ZW4K
PiBpdCdzIGEgQ1ZFIGZpeCBtYXliZSBpdCdzIGJlc3QgdG8gZG8gYXMgYSBwYXRjaCBvbiB0b3Au
Cj4KPiBBY2tlZC1ieTogTWljaGFlbCBTLiBUc2lya2luPG1zdEByZWRoYXQuY29tPgo+Cj4gRGF2
ZSBkbyB5b3Ugd2FudCB0byBtZXJnZSB0aGlzIG9yIHNob3VsZCBJPwo+CgpBY2NvcmRpbmcgdG8g
RGF2aWQncyBsYXN0IHJlcGx5LCBpdCdzIGJldHRlciBmb3IgeW91IHRvIG1lcmdlIEkgdGhpbmsu
CgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
