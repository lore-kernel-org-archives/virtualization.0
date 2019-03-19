From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [summary] virtio network device failover writeup
Date: Tue, 19 Mar 2019 17:19:55 -0400
Message-ID: <20190319171638-mutt-send-email-mst__45278.2453897939$1553030516$gmane$org@kernel.org>
References: <20190317095052-mutt-send-email-mst@kernel.org>
	<54E7C3AF-C3C5-4AF2-86C9-AA50389F855F@oracle.com>
	<20190319084647.727f8dcf@shemminger-XPS-13-9360>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190319084647.727f8dcf@shemminger-XPS-13-9360>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: vuhuong@mellanox.com, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Sridhar Samudrala <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtualization@lists.linux-foundation.org, Liran Alon <liran.alon@oracle.com>, Netdev <netdev@vger.kernel.org>, Si-Wei Liu <si-wei.liu@oracle.com>, boris.ostrovsky@oracle.com, David Miller <davem@davemloft.net>, ogerlitz@mellanox.com
List-Id: virtualization@lists.linuxfoundation.org

T24gVHVlLCBNYXIgMTksIDIwMTkgYXQgMDg6NDY6NDdBTSAtMDcwMCwgU3RlcGhlbiBIZW1taW5n
ZXIgd3JvdGU6Cj4gT24gVHVlLCAxOSBNYXIgMjAxOSAxNDozODowNiArMDIwMAo+IExpcmFuIEFs
b24gPGxpcmFuLmFsb25Ab3JhY2xlLmNvbT4gd3JvdGU6Cj4gCj4gPiBiLjMpIGNsb3VkLWluaXQ6
IElmIGNvbmZpZ3VyZWQgdG8gcGVyZm9ybSBuZXR3b3JrLWNvbmZpZ3VyYXRpb24sIGl0IGF0dGVt
cHRzIHRvIGNvbmZpZ3VyZSBhbGwgYXZhaWxhYmxlIG5ldGRldnMuIEl0IHNob3VsZCBhdm9pZCBo
b3dldmVyIGRvaW5nIHNvIG9uIG5ldC1mYWlsb3ZlciBzbGF2ZXMuCj4gPiAoTWljcm9zb2Z0IGhh
cyBoYW5kbGVkIHRoaXMgYnkgYWRkaW5nIGEgbWVjaGFuaXNtIGluIGNsb3VkLWluaXQgdG8gYmxh
Y2tsaXN0IGEgbmV0ZGV2IGZyb20gYmVpbmcgY29uZmlndXJlZCBpbiBjYXNlIGl0IGlzIG93bmVk
IGJ5IGEgc3BlY2lmaWMgUENJIGRyaXZlci4gU3BlY2lmaWNhbGx5LCB0aGV5IGJsYWNrbGlzdCBN
ZWxsYW5veCBWRiBkcml2ZXIuIEhvd2V2ZXIsIHRoaXMgdGVjaG5pcXVlIGRvZXNu4oCZdCB3b3Jr
IGZvciB0aGUgbmV0LWZhaWxvdmVyIG1lY2hhbmlzbSBiZWNhdXNlIGJvdGggdGhlIG5ldC1mYWls
b3ZlciBuZXRkZXYgYW5kIHRoZSB2aXJ0aW8tbmV0IG5ldGRldiBhcmUgb3duZWQgYnkgdGhlIHZp
cnRpby1uZXQgUENJIGRyaXZlcikuCj4gCj4gQ2xvdWQtaW5pdCBzaG91bGQgcmVhbGx5IGp1c3Qg
aWdub3JlIGFsbCBkZXZpY2VzIHRoYXQgaGF2ZSBhIG1hc3RlciBkZXZpY2UuCj4gVGhhdCB3b3Vs
ZCBoYXZlIGJlZW4gbW9yZSBnZW5lcmFsLCBhbmQgc2FmZXIgZm9yIG90aGVyIHVzZSBjYXNlcy4K
CkdpdmVuIGxvdHMgb2YgdXNlcnNwYWNlIGRvZXNuJ3QgZG8gdGhpcywgSSB3b25kZXIgd2hldGhl
ciBpdCB3b3VsZCBiZQpzYWZlciB0byBqdXN0IHNvbWVob3cgcHJldGVuZCB0byB1c2Vyc3BhY2Ug
dGhhdCB0aGUgc2xhdmUgbGlua3MgYXJlCmRvd24/IEFuZCBhZGQgYSBzcGVjaWFsIGF0dHJpYnV0
ZSBmb3IgdGhlIGFjdHVhbCBsaW5rIHN0YXRlLgoKLS0gCk1TVApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
