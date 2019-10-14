From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v4 1/5] vsock/virtio: limit the memory used per-socket
Date: Mon, 14 Oct 2019 16:21:35 +0800
Message-ID: <2398c960-b6d7-8af3-fa25-d75344335db7__12331.5480815776$1571042220$gmane$org@redhat.com>
References: <20190717113030.163499-1-sgarzare@redhat.com>
	<20190717113030.163499-2-sgarzare@redhat.com>
	<20190729095956-mutt-send-email-mst@kernel.org>
	<20190830094059.c7qo5cxrp2nkrncd@steredhat>
	<20190901024525-mutt-send-email-mst@kernel.org>
	<CAGxU2F7fA5UtkuMQbOHHy0noOGZUtpepBNKFg5afD81bynMVUQ@mail.gmail.com>
	<20191014081724.GD22963@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191014081724.GD22963@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMTAvMTQg5LiL5Y2INDoxNywgU3RlZmFuIEhham5vY3ppIHdyb3RlOgo+IFNPX1ZN
X1NPQ0tFVFNfQlVGRkVSX1NJWkUgbWlnaHQgaGF2ZSBiZWVuIHVzZWZ1bCBmb3IgVk1DSS1zcGVj
aWZpYwo+IGFwcGxpY2F0aW9ucywgYnV0IHdlIHNob3VsZCB1c2UgU09fUkNWQlVGIGFuZCBTT19T
TkRCVUYgZm9yIHBvcnRhYmxlCj4gYXBwbGljYXRpb25zIGluIHRoZSBmdXR1cmUuICBUaG9zZSBz
b2NrZXQgb3B0aW9ucyBhbHNvIHdvcmsgd2l0aCBvdGhlcgo+IGFkZHJlc3MgZmFtaWxpZXMuCj4K
PiBJIGd1ZXNzIHRoZXNlIHNvY2tvcHRzIGFyZSBieXBhc3NlZCBieSBBRl9WU09DSyBiZWNhdXNl
IGl0IGRvZXNuJ3QgdXNlCj4gdGhlIGNvbW1vbiBza2IgcXVldWluZyBjb2RlIGluIG5ldC9jb3Jl
L3NvY2suYzooLiAgQnV0IG9uZSBkYXkgd2UgbWlnaHQKPiBtaWdyYXRlIHRvIGl0Li4uCj4KPiBT
dGVmYW4KCgorMSwgd2Ugc2hvdWxkIHJlYWxseSBjb25zaWRlciB0byByZXVzZSB0aGUgZXhpc3Qg
c29ja2V0IG1lY2hhbmlzbSAKaW5zdGVhZCBvZiByZS1pbnZlbnRpbmcgd2hlZWxzLgoKVGhhbmtz
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
