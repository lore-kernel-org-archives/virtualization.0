From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH -next] vdpasim: Rerun status in vdpasim_get_status
Date: Tue, 31 Mar 2020 13:29:55 +0800
Message-ID: <096a742b-9387-370e-db22-81f220cf7c70@redhat.com>
References: <20200331033501.31272-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200331033501.31272-1-yuehaibing@huawei.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: YueHaibing <yuehaibing@huawei.com>, mst@redhat.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMjAvMy8zMSDkuIrljYgxMTozNSwgWXVlSGFpYmluZyB3cm90ZToKPiB2ZHBhc2ltLT5z
dGF0dXMgc2hvdWxkIGFjcXVpcmVkIHVuZGVyIHNwaW4gbG9jay4KPgo+IEZpeGVzOiA4NzA0NDhj
MzE3NzUgKCJ2ZHBhc2ltOiB2RFBBIGRldmljZSBzaW11bGF0b3IiKQo+IFNpZ25lZC1vZmYtYnk6
IFl1ZUhhaWJpbmcgPHl1ZWhhaWJpbmdAaHVhd2VpLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmly
dGlvL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmly
dGlvL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyBiL2RyaXZlcnMvdmlydGlvL3ZkcGEvdmRwYV9z
aW0vdmRwYV9zaW0uYwo+IGluZGV4IDZlOGEwY2YyZmRlYi4uNzI4NjNkMDFhMTJhIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+ICsrKyBiL2Ry
aXZlcnMvdmlydGlvL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+IEBAIC00ODgsNyArNDg4LDcg
QEAgc3RhdGljIHU4IHZkcGFzaW1fZ2V0X3N0YXR1cyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEp
Cj4gICAJc3RhdHVzID0gdmRwYXNpbS0+c3RhdHVzOwo+ICAgCXNwaW5fdW5sb2NrKCZ2ZHBhc2lt
LT5sb2NrKTsKPiAgIAo+IC0JcmV0dXJuIHZkcGFzaW0tPnN0YXR1czsKPiArCXJldHVybiBzdGF0
dXM7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyB2b2lkIHZkcGFzaW1fc2V0X3N0YXR1cyhzdHJ1Y3Qg
dmRwYV9kZXZpY2UgKnZkcGEsIHU4IHN0YXR1cykKCgpUeXBvIGluIHRoZSB0aXRsZSBidXQgcGF0
Y2ggbG9va3MgZ29vZC4KCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PgoKVGhhbmtzCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
