From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next RFC 5/5] vhost_net: basic tx virtqueue batched
	processing
Date: Thu, 28 Sep 2017 15:52:59 +0800
Message-ID: <1455d9db-3f2f-4139-8729-29fb03dd73aa__6337.46708413145$1506585210$gmane$org@redhat.com>
References: <1506067355-5771-1-git-send-email-jasowang@redhat.com>
	<1506067355-5771-6-git-send-email-jasowang@redhat.com>
	<20170926222223-mutt-send-email-mst@kernel.org>
	<16ea7512-d770-21ef-edb6-3ada51f08592@redhat.com>
	<20170928011724-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170928011724-mutt-send-email-mst@kernel.org>
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

CgpPbiAyMDE35bm0MDnmnIgyOOaXpSAwNjoxOSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
Cj4+PiAyLiBhZGQgbmV3IEFQSXMgYW5kIG1vdmUgdGhlIGxvb3AgaW50byB2aG9zdCBjb3JlCj4+
PiAgICAgIGZvciBtb3JlIHNwZWVkdXBzCj4+IEkgZG9uJ3Qgc2VlIGFueSBhZHZhbnRhZ2VzLCBs
b29rcyBsaWtlIGp1c3QgbmVlZCBzb21lIGUuZyBjYWxsYmFja3MgaW4gdGhpcwo+PiBjYXNlLgo+
Pgo+PiBUaGFua3MKPiBJVUMgY2FsbGJhY2tzIHByZXR0eSBtdWNoIGRlc3Ryb3kgdGhlIGNvZGUg
Y2FjaGUgbG9jYWxpdHkgYWR2YW50YWdlcywKPiBJUCBpcyBqdW1waW5nIGFyb3VuZCB0b28gbXVj
aC4KCkkgbWF5IG1pc3Mgc29tZXRoaW5nLCBidXQgd2UgbmVlZCBuZXQgc3BlY2lmaWMgY29kZSBh
bnl3YXkgaW4gdGhpcyBjYXNlPwoKVGhhbmtzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
