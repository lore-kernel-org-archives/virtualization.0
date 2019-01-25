From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next V4 5/5] vhost: access vq metadata through kernel
	virtual address
Date: Fri, 25 Jan 2019 10:33:02 +0800
Message-ID: <99d02d64-34d1-9b31-77bc-1d53a3b89d28__45568.7306051672$1548383604$gmane$org@redhat.com>
References: <20190123095557.30168-1-jasowang@redhat.com>
	<20190123095557.30168-6-jasowang@redhat.com>
	<20190123085821-mutt-send-email-mst@kernel.org>
	<335ba55b-087f-4b35-6311-540070b9647f@redhat.com>
	<4521d3d8-561e-53f5-98e1-bf7ace003701@redhat.com>
	<20190123235219-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190123235219-mutt-send-email-mst@kernel.org>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMS8yNCDkuIvljYgxMjo1MywgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4+
IC0gSG93IGhhcmQgaXMgaXQgdG8gZmlndXJlIG91dCB3aGljaCBtb2RlIHVzZXMgd2hpY2ggY29k
ZS4KPj4gSXQncyBhcyBzaW1wbGUgYXMgdHJhY2luZyBfX2dldF91c2VyKCkgdXNhZ2UgaW4gdmhv
c3QgcHJvY2Vzcz8KPj4KPj4gVGhhbmtzCj4gV2VsbCB0aGVyZSBhcmUgbm93IG10dSBub3RpZmll
cnMgZXRjIGV0Yy4gSXQncyBoYXJkbHkgYXMgd2VsbAo+IGNvbnRhaW5lZCBhcyB0aGF0Lgo+Cj4K
CldlIGNhbiBzZXR1cCBmaWx0ZXIgb3V0IGV4YWN0bHkgd2hhdCBzZXRzIG9mIGZ1bmN0aW9uIHRo
YXQgd2Ugd2FuIHRvIAp0cmFjZS4gRS5nIHdlIGNhbiBvbmx5IHRyYWNlIHRoZSB1c2FnZSBvZiBf
X2dldF91c2VyKCkgYW5kIAppbnZhbGlkYXRlX3JhbmdlX3N0YXJ0KCkuIFRoaXMgc2hvdWxkIGJl
IHN1ZmZpY2llbnQuCgpJbiB0aGUgbG9uZyBydW4sIHdlIG1heSB3YW50IHRvIGhhdmUgc29tZSB0
cmFjZXBvaW50cyBmb3Igdmhvc3RfbmV0LgoKVGhhbmtzCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
