From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_pci: pm: Use CONFIG_PM_SLEEP instead of CONFIG_PM
Date: Mon, 09 Sep 2013 10:03:18 +0930
Message-ID: <87ob826dgx.fsf@rustcorp.com.au>
References: <52293DD4.6050403@intel.com> <20130906080744.GD29367@grmbl.mre>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130906080744.GD29367@grmbl.mre>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>, Aaron Lu <aaron.lu@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

QW1pdCBTaGFoIDxhbWl0LnNoYWhAcmVkaGF0LmNvbT4gd3JpdGVzOgoKPiBPbiAoRnJpKSAwNiBT
ZXAgMjAxMyBbMTA6Mjg6MzZdLCBBYXJvbiBMdSB3cm90ZToKPj4gCj4+IFRoZSB2aXJ0aW9fcGNp
X2ZyZWV6ZS9yZXN0b3JlIGFyZSBkZWZpbmVkIHVuZGVyIENPTkZJR19QTSBidXQgaXMgdXNlZAo+
PiBieSBTRVRfU1lTVEVNX1NMRUVQX1BNX09QUyBtYWNybywgd2hpY2ggaXMgZGVmaW5lZCB1bmRl
cgo+PiBDT05GSUdfUE1fU0xFRVAuIFNvIGlmIENPTkZJR19QTV9TTEVFUCBpcyBub3QgY29maWd1
cmVkIGJ1dAo+PiBDT05GSUdfUE1fUlVOVElNRSBpcywgdGhlIGZvbGxvd2luZyB3YXJuaW5nIG1l
c3NhZ2UgYXBwZWFyZWQ6Cj4+IAo+PiBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpLmM6NzcwOjEy
OiB3YXJuaW5nOiDigJh2aXJ0aW9fcGNpX2ZyZWV6ZeKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBb
LVd1bnVzZWQtZnVuY3Rpb25dCj4+ICBzdGF0aWMgaW50IHZpcnRpb19wY2lfZnJlZXplKHN0cnVj
dCBkZXZpY2UgKmRldikKPj4gICAgICAgICAgICAgXgo+PiBkcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cGNpLmM6NzkwOjEyOiB3YXJuaW5nOiDigJh2aXJ0aW9fcGNpX3Jlc3RvcmXigJkgZGVmaW5lZCBi
dXQgbm90IHVzZWQgWy1XdW51c2VkLWZ1bmN0aW9uXQo+PiAgc3RhdGljIGludCB2aXJ0aW9fcGNp
X3Jlc3RvcmUoc3RydWN0IGRldmljZSAqZGV2KQo+PiAgICAgICAgICAgICBeCj4+IEZpeCBpdCBi
eSBjaGFuZ2luZyBDT05GSUdfUE0gdG8gQ09ORklHX1BNX1NMRUVQLgo+PiAKPj4gU2lnbmVkLW9m
Zi1ieTogQWFyb24gTHUgPGFhcm9uLmx1QGludGVsLmNvbT4KPgo+IFJldmlld2VkLWJ5OiBBbWl0
IFNoYWggPGFtaXQuc2hhaEByZWRoYXQuY29tPgo+Cj4gCQlBbWl0CgpBcHBsaWVkLgoKVGhhbmtz
LApSdXN0eS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
