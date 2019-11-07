From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v6] vhost: introduce mdev based hardware backend
Date: Thu, 7 Nov 2019 18:16:46 +0800
Message-ID: <1b60cc37-1c85-df85-1f4d-3f9a10ecef54__13559.3936241762$1573121853$gmane$org@redhat.com>
References: <20191107073530.15291-1-tiwei.bie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191107073530.15291-1-tiwei.bie@intel.com>
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
To: Tiwei Bie <tiwei.bie@intel.com>, mst@redhat.com, alex.williamson@redhat.com, maxime.coquelin@redhat.com
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, zhihong.wang@intel.com, lingshan.zhu@intel.com
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMTEvNyDkuIvljYgzOjM1LCBUaXdlaSBCaWUgd3JvdGU6Cj4gVGhpcyBwYXRjaCBp
bnRyb2R1Y2VzIGEgbWRldiBiYXNlZCBoYXJkd2FyZSB2aG9zdCBiYWNrZW5kLgo+IFRoaXMgYmFj
a2VuZCBpcyBidWlsdCBvbiB0b3Agb2YgdGhlIHNhbWUgYWJzdHJhY3Rpb24gdXNlZAo+IGluIHZp
cnRpby1tZGV2IGFuZCBwcm92aWRlcyBhIGdlbmVyaWMgdmhvc3QgaW50ZXJmYWNlIGZvcgo+IHVz
ZXJzcGFjZSB0byBhY2NlbGVyYXRlIHRoZSB2aXJ0aW8gZGV2aWNlcyBpbiBndWVzdC4KPgo+IFRo
aXMgYmFja2VuZCBpcyBpbXBsZW1lbnRlZCBhcyBhIG1kZXYgZGV2aWNlIGRyaXZlciBvbiB0b3AK
PiBvZiB0aGUgc2FtZSBtZGV2IGRldmljZSBvcHMgdXNlZCBpbiB2aXJ0aW8tbWRldiBidXQgdXNp
bmcKPiBhIGRpZmZlcmVudCBtZGV2IGNsYXNzIGlkLCBhbmQgaXQgd2lsbCByZWdpc3RlciB0aGUg
ZGV2aWNlCj4gYXMgYSBWRklPIGRldmljZSBmb3IgdXNlcnNwYWNlIHRvIHVzZS4gVXNlcnNwYWNl
IGNhbiBzZXR1cAo+IHRoZSBJT01NVSB3aXRoIHRoZSBleGlzdGluZyBWRklPIGNvbnRhaW5lci9n
cm91cCBBUElzIGFuZAo+IHRoZW4gZ2V0IHRoZSBkZXZpY2UgZmQgd2l0aCB0aGUgZGV2aWNlIG5h
bWUuIEFmdGVyIGdldHRpbmcKPiB0aGUgZGV2aWNlIGZkLCB1c2Vyc3BhY2UgY2FuIHVzZSB2aG9z
dCBpb2N0bHMgb24gdG9wIG9mIGl0Cj4gdG8gc2V0dXAgdGhlIGJhY2tlbmQuCj4KPiBTaWduZWQt
b2ZmLWJ5OiBUaXdlaSBCaWU8dGl3ZWkuYmllQGludGVsLmNvbT4KPiAtLS0KPiBUaGlzIHBhdGNo
IGRlcGVuZHMgb24gYmVsb3cgc2VyaWVzOgo+IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5LzEx
LzYvNTM4CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFu
a3MhCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
