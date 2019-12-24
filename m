From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC v4 00/13] virtio-mem: paravirtualized memory
Date: Tue, 24 Dec 2019 10:28:20 +0100
Message-ID: <2828152B-D0EB-4802-A304-4A90CA5C4B6C__2361.27370023809$1577179720$gmane$org@redhat.com>
References: <91ED8152-61FC-4E87-9F7B-44CD05C77279@linux.alibaba.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <91ED8152-61FC-4E87-9F7B-44CD05C77279@linux.alibaba.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: teawater <teawaterz@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.com>, Michal Hocko <mhocko@suse.com>, Robert Bradford <robert.bradford@intel.com>, Pingfan Liu <kernelfans@gmail.com>, Luiz Capitulino <lcapitulino@redhat.com>, Linux MM <linux-mm@kvack.org>, Alexander Potapenko <glider@google.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, Mike Rapoport <rppt@linux.ibm.com>, Michal Hocko <mhocko@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Dave Young <dyoung@redhat.com>, Len Brown <lenb@kernel.org>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Qian Cai <cai@lca.pw>, Alexander Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>, Samuel Ortiz <sam>
List-Id: virtualization@lists.linuxfoundation.org

Cgo+IEFtIDI0LjEyLjIwMTkgdW0gMDg6MDQgc2NocmllYiB0ZWF3YXRlciA8dGVhd2F0ZXJ6QGxp
bnV4LmFsaWJhYmEuY29tPjoKPiAKPiDvu79IaSBEYXZpZCwKPiAKPiBUaGFua3MgZm9yIHlvdXIg
d29yay4KPiAKPiBJIEdvdCBmb2xsb3dpbmcgYnVpbGQgZmFpbCBpZiBYODZfNjRfQUNQSV9OVU1B
IGlzIG4gd2l0aCByZmMzIGFuZCByZmM0Ogo+IG1ha2UgLWo4IGJ6SW1hZ2UKPiAgR0VOICAgICBN
YWtlZmlsZQo+ICBERVNDRU5EICBvYmp0b29sCj4gIENBTEwgICAgL2hvbWUvdGVhd2F0ZXIva2Vy
bmVsL2xpbnV4LXVwc3RyZWFtMy9zY3JpcHRzL2F0b21pYy9jaGVjay1hdG9taWNzLnNoCj4gIENB
TEwgICAgL2hvbWUvdGVhd2F0ZXIva2VybmVsL2xpbnV4LXVwc3RyZWFtMy9zY3JpcHRzL2NoZWNr
c3lzY2FsbHMuc2gKPiAgQ0hLICAgICBpbmNsdWRlL2dlbmVyYXRlZC9jb21waWxlLmgKPiAgQ0Mg
ICAgICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fbWVtLm8KPiAvaG9tZS90ZWF3YXRlci9rZXJuZWwv
bGludXgtdXBzdHJlYW0zL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19tZW0uYzogSW4gZnVuY3Rpb24g
4oCYdmlydGlvX21lbV90cmFuc2xhdGVfbm9kZV9pZOKAmToKPiAvaG9tZS90ZWF3YXRlci9rZXJu
ZWwvbGludXgtdXBzdHJlYW0zL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19tZW0uYzo0Nzg6MTA6IGVy
cm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhweG1fdG9fbm9kZeKAmSBb
LVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KPiAgIG5vZGUgPSBweG1fdG9f
bm9kZShub2RlX2lkKTsKPiAgICAgICAgICBefn5+fn5+fn5+fgo+IGNjMTogc29tZSB3YXJuaW5n
cyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwo+IC9ob21lL3RlYXdhdGVyL2tlcm5lbC9saW51eC11
cHN0cmVhbTMvc2NyaXB0cy9NYWtlZmlsZS5idWlsZDoyNjU6IHJlY2lwZSBmb3IgdGFyZ2V0ICdk
cml2ZXJzL3ZpcnRpby92aXJ0aW9fbWVtLm8nIGZhaWxlZAo+IG1ha2VbM106ICoqKiBbZHJpdmVy
cy92aXJ0aW8vdmlydGlvX21lbS5vXSBFcnJvciAxCj4gL2hvbWUvdGVhd2F0ZXIva2VybmVsL2xp
bnV4LXVwc3RyZWFtMy9zY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjUwMzogcmVjaXBlIGZvciB0YXJn
ZXQgJ2RyaXZlcnMvdmlydGlvJyBmYWlsZWQKPiBtYWtlWzJdOiAqKiogW2RyaXZlcnMvdmlydGlv
XSBFcnJvciAyCj4gL2hvbWUvdGVhd2F0ZXIva2VybmVsL2xpbnV4LXVwc3RyZWFtMy9NYWtlZmls
ZToxNjQ5OiByZWNpcGUgZm9yIHRhcmdldCAnZHJpdmVycycgZmFpbGVkCj4gbWFrZVsxXTogKioq
IFtkcml2ZXJzXSBFcnJvciAyCj4gL2hvbWUvdGVhd2F0ZXIva2VybmVsL2xpbnV4LXVwc3RyZWFt
My9NYWtlZmlsZToxNzk6IHJlY2lwZSBmb3IgdGFyZ2V0ICdzdWItbWFrZScgZmFpbGVkCj4gbWFr
ZTogKioqIFtzdWItbWFrZV0gRXJyb3IgMgo+IAoKVGhhbmtzIEh1aSwKClNvIGl0IGhhcyB0byBi
ZSB3cmFwcGVkIGluIGFuIGlmZGVmLCB0aGFua3MhCgpDaGVlcnMhCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
