From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Subject: Re: [PATCH net-next v11 2/5] netvsc: refactor notifier/event handling
	code to use the failover framework
Date: Tue, 22 May 2018 08:28:42 -0700
Message-ID: <39081bce-3913-5b07-3d07-0c476fca5e78__18015.3704518036$1527002824$gmane$org@intel.com>
References: <1526954781-35359-1-git-send-email-sridhar.samudrala@intel.com>
	<1526954781-35359-3-git-send-email-sridhar.samudrala@intel.com>
	<20180522090637.GE2149@nanopsycho> <20180522090853.GF2149@nanopsycho>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180522090853.GF2149@nanopsycho>
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
To: Jiri Pirko <jiri@resnulli.us>
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, mst@redhat.com, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, anjali.singhai@intel.com, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDUvMjIvMjAxOCAyOjA4IEFNLCBKaXJpIFBpcmtvIHdyb3RlOgo+IFR1ZSwgTWF5IDIyLCAy
MDE4IGF0IDExOjA2OjM3QU0gQ0VTVCwgamlyaUByZXNudWxsaS51cyB3cm90ZToKPj4gVHVlLCBN
YXkgMjIsIDIwMTggYXQgMDQ6MDY6MThBTSBDRVNULCBzcmlkaGFyLnNhbXVkcmFsYUBpbnRlbC5j
b20gd3JvdGU6Cj4+PiBVc2UgdGhlIHJlZ2lzdHJhdGlvbi9ub3RpZmljYXRpb24gZnJhbWV3b3Jr
IHN1cHBvcnRlZCBieSB0aGUgZ2VuZXJpYwo+Pj4gZmFpbG92ZXIgaW5mcmFzdHJ1Y3R1cmUuCj4+
Pgo+Pj4gU2lnbmVkLW9mZi1ieTogU3JpZGhhciBTYW11ZHJhbGEgPHNyaWRoYXIuc2FtdWRyYWxh
QGludGVsLmNvbT4KPj4gSW4gcHJldmlvdXMgcGF0Y2hzZXQgdmVyc2lvbnMsIHRoZSBjb21tb24g
Y29kZSBkaWQKPj4gbmV0ZGV2X3J4X2hhbmRsZXJfcmVnaXN0ZXIoKSBhbmQgbmV0ZGV2X3VwcGVy
X2Rldl9saW5rKCkgZXRjCj4+IChuZXR2c2NfdmZfam9pbigpKS4gTm93LCB0aGlzIGlzIHN0aWxs
IGRvbmUgaW4gbmV0dnNjLiBXaHk/Cj4+Cj4+IFRoaXMgc2hvdWxkIGJlIHBhcnQgb2YgdGhlIGNv
bW1vbiAiZmFpbG92ZXIiIGNvZGUuCgpCYXNlZCBvbiBTdGVwaGVuJ3MgZmVlZGJhY2sgb24gZWFy
bGllciBwYXRjaGVzLCBpIHRyaWVkIHRvIG1pbmltaXplIHRoZSBjaGFuZ2VzIHRvCm5ldHZzYyBh
bmQgb25seSBjb21tb25pemUgdGhlIG5vdGlmaWVyIGFuZCB0aGUgbWFpbiBldmVudCBoYW5kbGVy
IHJvdXRpbmUuCkFub3RoZXIgY29tcGxpY2F0aW9uIGlzIHRoYXQgbmV0dnNjIGRvZXMgcGFydCBv
ZiByZWdpc3RyYXRpb24gaW4gYSBkZWxheWVkIHdvcmtxdWV1ZS4KCkl0IHNob3VsZCBiZSBwb3Nz
aWJsZSB0byBtb3ZlIHNvbWUgb2YgdGhlIGNvZGUgZnJvbSBuZXRfZmFpbG92ZXIuYyB0byBnZW5l
cmljCmZhaWxvdmVyLmMgaW4gZnV0dXJlIGlmIFN0ZXBoZW4gaXMgb2sgd2l0aCBpdC4KCgo+Pgo+
IEFsc28gbm90ZSB0aGF0IGluIHRoZSBjdXJyZW50IHBhdGNoc2V0IHlvdSB1c2UgSUZGX0ZBSUxP
VkVSIGZsYWcgZm9yCj4gbWFzdGVyLCB5ZXQgZm9yIHRoZSBzbGF2ZSB5b3UgdXNlIElGRl9TTEFW
RS4gVGhhdCBpcyB3cm9uZy4KPiBJRkZfRkFJTE9WRVJfU0xBVkUgc2hvdWxkIGJlIHVzZWQuCgpO
b3Qgc3VyZSB3aGljaCBjb2RlIHlvdSBhcmUgcmVmZXJyaW5nIHRvLsKgIEkgb25seSBzZXQgSUZG
X0ZBSUxPVkVSX1NMQVZFCmluIHBhdGNoIDMuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
