From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net V2] virtio-net: re enable XDP_REDIRECT for mergeable
	buffer
Date: Mon, 5 Mar 2018 10:41:29 +0800
Message-ID: <abf2cb49-64bd-16ce-23e1-53aa719243d0__4775.33234884522$1520217619$gmane$org@redhat.com>
References: <1519982954-14360-1-git-send-email-jasowang@redhat.com>
	<20180302193104-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180302193104-mutt-send-email-mst@kernel.org>
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
Cc: netdev@vger.kernel.org, brouer@redhat.com, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDPmnIgwM+aXpSAwMTozNiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
IE9uIEZyaSwgTWFyIDAyLCAyMDE4IGF0IDA1OjI5OjE0UE0gKzA4MDAsIEphc29uIFdhbmcgd3Jv
dGU6Cj4+IFhEUF9SRURJUkVDVCBzdXBwb3J0IGZvciBtZXJnZWFibGUgYnVmZmVyIHdhcyByZW1v
dmVkIHNpbmNlIGNvbW1pdAo+PiA3MzI0ZjUzOTliMDYgKCJ2aXJ0aW9fbmV0OiBkaXNhYmxlIFhE
UF9SRURJUkVDVCBpbiByZWNlaXZlX21lcmdlYWJsZSgpCj4+IGNhc2UiKS4gVGhpcyBpcyBiZWNh
dXNlIHdlIGRvbid0IHJlc2VydmUgZW5vdWdoIHRhaWxyb29tIGZvciBzdHJ1Y3QKPj4gc2tiX3No
YXJlZF9pbmZvIHdoaWNoIGJyZWFrcyBYRFAgYXNzdW1wdGlvbi4gU28gdGhpcyBwYXRjaCBmaXhl
cyB0aGlzCj4+IGJ5IHJlc2VydmluZyBlbm91Z2ggdGFpbHJvb20gYW5kIHVzaW5nIGZpeGVkIHNp
emUgb2YgcnggYnVmZmVyLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nPGphc293YW5n
QHJlZGhhdC5jb20+Cj4gQWNrZWQtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbjxtc3RAcmVkaGF0LmNv
bT4KPgo+IEkgdGhpbmsgdGhlIG5leHQgaW5jcmVtZW50YWwgc3RlcCBpcyB0byBsb29rIGF0IHNw
bGl0dGluZwo+IG91dCBmYXN0IHBhdGggWERQIHByb2Nlc3NpbmcgdG8gYSBzZXBhcmF0ZSBzZXQg
b2YgZnVuY3Rpb25zLgo+CgpMZXQgbWUgdHJ5IChwcm9iYWJseSBhZnRlciAxLjEgc3R1ZmZzKS4K
ClRoYW5rcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
