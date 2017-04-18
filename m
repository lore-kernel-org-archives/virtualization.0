From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] ringtest: fix an assert statement
Date: Tue, 18 Apr 2017 11:01:49 +0800
Message-ID: <e6715605-242b-bf8f-855b-ba443054c87d__19589.1965101056$1492484521$gmane$org@redhat.com>
References: <20170415192214.GB6416@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170415192214.GB6416@mwanda>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dan Carpenter <dan.carpenter@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE35bm0MDTmnIgxNuaXpSAwMzoyMiwgRGFuIENhcnBlbnRlciB3cm90ZToKPiBUaGVy
ZSBpcyBhbiB8fCB2cyAmJiB0eXBvIHNvIHRoZSBhc3NlcnQgY2FuIG5ldmVyIGJlIHRyaWdnZXJl
ZC4KPgo+IFNpZ25lZC1vZmYtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xl
LmNvbT4KPgo+IGRpZmYgLS1naXQgYS90b29scy92aXJ0aW8vcmluZ3Rlc3QvbWFpbi5jIGIvdG9v
bHMvdmlydGlvL3Jpbmd0ZXN0L21haW4uYwo+IGluZGV4IDAyMmFlOTVhMDZiZC4uNDUzY2EzYzIx
MTkzIDEwMDY0NAo+IC0tLSBhL3Rvb2xzL3ZpcnRpby9yaW5ndGVzdC9tYWluLmMKPiArKysgYi90
b29scy92aXJ0aW8vcmluZ3Rlc3QvbWFpbi5jCj4gQEAgLTg3LDcgKzg3LDcgQEAgdm9pZCBzZXRf
YWZmaW5pdHkoY29uc3QgY2hhciAqYXJnKQo+ICAgCWNwdSA9IHN0cnRvbChhcmcsICZlbmRwdHIs
IDApOwo+ICAgCWFzc2VydCghKmVuZHB0cik7Cj4gICAKPiAtCWFzc2VydChjcHUgPj0gMCB8fCBj
cHUgPCBDUFVfU0VUU0laRSk7Cj4gKwlhc3NlcnQoY3B1ID49IDAgJiYgY3B1IDwgQ1BVX1NFVFNJ
WkUpOwo+ICAgCj4gICAJc2VsZiA9IHB0aHJlYWRfc2VsZigpOwo+ICAgCUNQVV9aRVJPKCZjcHVz
ZXQpOwoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
