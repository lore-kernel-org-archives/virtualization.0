From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH vhost next 06/10] vdpa: Add means to communicate vq status
 on get_vq_state
Date: Mon, 20 Jul 2020 12:13:24 +0800
Message-ID: <0ed28d74-cb0c-89af-61dd-9256e8bb2328@redhat.com>
References: <20200716072327.5359-1-eli@mellanox.com>
 <20200716072327.5359-7-eli@mellanox.com>
 <cb9bced7-1a7e-150a-875c-1b75f77ee853@redhat.com>
 <20200716082116.GA182860@mtl-vdi-166.wap.labs.mlnx>
 <296e6fcb-946c-f577-2e22-46528f78fda9@redhat.com>
 <20200716102533.GB186790@mtl-vdi-166.wap.labs.mlnx>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200716102533.GB186790@mtl-vdi-166.wap.labs.mlnx>
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
To: Eli Cohen <eli@mellanox.com>
Cc: shahafs@mellanox.com, Parav Pandit <parav@mellanox.com>, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, saeedm@mellanox.com
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMjAvNy8xNiDkuIvljYg2OjI1LCBFbGkgQ29oZW4gd3JvdGU6Cj4gT24gVGh1LCBKdWwg
MTYsIDIwMjAgYXQgMDU6MzU6MThQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4gT24gMjAy
MC83LzE2IOS4i+WNiDQ6MjEsIEVsaSBDb2hlbiB3cm90ZToKPj4+IE9uIFRodSwgSnVsIDE2LCAy
MDIwIGF0IDA0OjExOjAwUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+Pj4gT24gMjAyMC83
LzE2IOS4i+WNiDM6MjMsIEVsaSBDb2hlbiB3cm90ZToKPj4+Pj4gQ3VycmVudGx5LCBnZXRfdnFf
c3RhdGUoKSBpcyB1c2VkIG9ubHkgdG8gcGFzcyB0aGUgYXZhaWxhYmxlIGluZGV4IHZhbHVlCj4+
Pj4+IG9mIGEgdnEuIEV4dGVuZCB0aGUgc3RydWN0IHRvIHJldHVybiBzdGF0dXMgb24gdGhlIFZR
IHRvIHRoZSBjYWxsZXIuCj4+Pj4+IEZvciBub3csIGRlZmluZSBWUV9TVEFURV9OT1RfUkVBRFku
IEluIHRoZSBmdXR1cmUgaXQgd2lsbCBiZSBleHRlbmRlZCB0bwo+Pj4+PiBpbmNsdWRlIG90aGVy
IGluZm9tcmF0aW9uLgo+Pj4+Pgo+Pj4+PiBNb2RpZnkgY3VycmVudCB2ZHBhIGRyaXZlciB0byB1
cGRhdGUgdGhpcyBmaWVsZC4KPj4+Pj4KPj4+Pj4gUmV2aWV3ZWQtYnk6IFBhcmF2IFBhbmRpdDxw
YXJhdkBtZWxsYW5veC5jb20+Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEVsaSBDb2hlbjxlbGlAbWVs
bGFub3guY29tPgo+Pj4+IFdoYXQncyB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIHRoaXMgYW5kIGdl
dF92cV9yZWFkeSgpPwo+Pj4+Cj4+Pj4gVGhhbmtzCj4+Pj4KPj4+IFRoZXJlIGlzIG5vIGRpZmZl
cmVuY2UuIEl0IGlzIGp1c3QgYSB3YXkgdG8gY29tbXVuaWNhdGUgYSBwcm9ibGVtIHRvCj4+PiB3
aXRoIHRoZSBzdGF0ZSBvZiB0aGUgVlEgYmFjayB0byB0aGUgY2FsbGVyLiBUaGlzIGlzIG5vdCBh
dmFpbGFibGUgbm93Lgo+Pj4gSSB0aGluayBhbiBhc3luY2hyb25vdXMgaXMgcHJlZmVycmVkIGJ1
dCB0aGF0IGlzIG5vdCBhdmFpbGFibGUKPj4+IGN1cnJlbnRseS4KPj4KPj4gSSBzdGlsbCBkb24n
dCBzZWUgdGhlIHJlYXNvbiwgbWF5YmUgeW91IGNhbiBnaXZlIG1lIGFuIGV4YW1wbGU/Cj4+Cj4+
Cj4gTXkgaW50ZW50aW9uIHdhcyB0byBwcm92aWRlIGEgbWVjaGFpbnNtIHRvIHJldHVybiBtZWFu
aW5nZnVsIGluZm9ybWF0aW9uCj4gb24gdGhlIHN0YXRlIG9mIHRoZSB2cS4gRm9yIGV4YW1wbGUs
IHdoZW4geW91IGZhaWwgdG8gZ2V0IHRoZSBzdGF0ZSBvZgo+IHRoZSBWUS4KPgo+IE1heWJlIEkg
Y291bGQganVzdCBjaGFuZ2UgdGhlIHByb3RvdHlwZSBvZiB0aGUgZnVuY3Rpb24gdG8gcmV0dXJu
IGludAo+IGFuZCB0aGUgZHJpdmVyIGNvdWxkIHB1dCBhbiBlcnJvciBpZiBpdCBoYXMgdHJvdWJs
ZSByZXR1cm5pbmcgdGhlIHZxCj4gc3RhdGUuCgoKVGhhdCdzIGZpbmUuCgpUaGFua3MKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
