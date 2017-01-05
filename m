From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] net: make ndo_get_stats64 a void function
Date: Thu, 05 Jan 2017 13:18:45 -0500 (EST)
Message-ID: <20170105.131845.1605952043383659916.davem__16767.8494508893$1483640362$gmane$org@davemloft.net>
References: <20170105173136.2817-1-sthemmin@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-7"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170105173136.2817-1-sthemmin@microsoft.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: stephen@networkplumber.org
Cc: devel@driverdev.osuosl.org, dev@openvswitch.org, sthemmin@microsoft.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, oss-drivers@netronome.com, linux-ppp@vger.kernel.org, devel@linuxdriverproject.org
List-Id: virtualization@lists.linuxfoundation.org

RnJvbTogU3RlcGhlbiBIZW1taW5nZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KRGF0
ZTogVGh1LCAgNSBKYW4gMjAxNyAwOTozMTozNiAtMDgwMA0KDQo+IFRoZSBuZXR3b3JrIGRldmlj
ZSBvcGVyYXRpb24gZm9yIHJlYWRpbmcgc3RhdGlzdGljcyBpcyBvbmx5IGNhbGxlZA0KPiBpbiBv
bmUgcGxhY2UsIGFuZCBpdCBpZ25vcmVzIHRoZSByZXR1cm4gdmFsdWUuIEhhdmluZyBhIHN0cnVj
dHVyZQ0KPiByZXR1cm4gdmFsdWUgaXMgcG90ZW50aWFsbHkgY29uZnVzaW5nIGJlY2F1c2Ugc29t
ZSBmdXR1cmUgZHJpdmVyIGNvdWxkDQo+IGluY29ycmVjdGx5IGFzc3VtZSB0aGF0IHRoZSByZXR1
cm4gdmFsdWUgd2FzIHVzZWQuDQo+IA0KPiBGaXggYWxsIGRyaXZlcnMgd2l0aCBuZG9fZ2V0X3N0
YXRzNjQgdG8gaGF2ZSBhIHZvaWQgZnVuY3Rpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTdGVw
aGVuIEhlbW1pbmdlciA8c3RoZW1taW5AbWljcm9zb2Z0LmNvbT4NCg0KWW91IG1pc3NlZCBhdCBs
ZWFzdCBvbmUgbmV3IHdhcm5pbmcsIHBsZWFzZSBkbyBhIGZyZXNoIGFsbG1vZGNvbmZpZyBidWls
ZA0KYW5kIHdhdGNoIHRoZSBsb2dzLg0KDQpkcml2ZXJzL25ldC9ldGhlcm5ldC9icm9hZGNvbS9i
bngyLmM6IEluIGZ1bmN0aW9uIKFibngyX2dldF9zdGF0czY0ojoNCmRyaXZlcnMvbmV0L2V0aGVy
bmV0L2Jyb2FkY29tL2JueDIuYzo2ODMwOjEwOiB3YXJuaW5nOiChcmV0dXJuoiB3aXRoIGEgdmFs
dWUsIGluIGZ1bmN0aW9uIHJldHVybmluZyB2b2lkDQoNClRoYW5rcy4NCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
