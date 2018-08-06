From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH v3 2/2] virtio_balloon: replace oom notifier with shrinker
Date: Mon, 6 Aug 2018 19:29:17 +0900
Message-ID: <c8d25019-1990-f0dd-c83d-e4def5b5f7fe__39281.5027888448$1533551254$gmane$org@i-love.sakura.ne.jp>
References: <1533285146-25212-1-git-send-email-wei.w.wang@intel.com>
	<1533285146-25212-3-git-send-email-wei.w.wang@intel.com>
	<16c56ee5-eef7-dd5f-f2b6-e3c11df2765c@i-love.sakura.ne.jp>
	<5B681B41.6070205@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5B681B41.6070205@intel.com>
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
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

T24gMjAxOC8wOC8wNiAxODo1NiwgV2VpIFdhbmcgd3JvdGU6Cj4gT24gMDgvMDMvMjAxOCAwODox
MSBQTSwgVGV0c3VvIEhhbmRhIHdyb3RlOgo+PiBPbiAyMDE4LzA4LzAzIDE3OjMyLCBXZWkgV2Fu
ZyB3cm90ZToKPj4+ICtzdGF0aWMgaW50IHZpcnRpb19iYWxsb29uX3JlZ2lzdGVyX3Nocmlua2Vy
KHN0cnVjdCB2aXJ0aW9fYmFsbG9vbiAqdmIpCj4+PiArewo+Pj4gK8KgwqDCoCB2Yi0+c2hyaW5r
ZXIuc2Nhbl9vYmplY3RzID0gdmlydGlvX2JhbGxvb25fc2hyaW5rZXJfc2NhbjsKPj4+ICvCoMKg
wqAgdmItPnNocmlua2VyLmNvdW50X29iamVjdHMgPSB2aXJ0aW9fYmFsbG9vbl9zaHJpbmtlcl9j
b3VudDsKPj4+ICvCoMKgwqAgdmItPnNocmlua2VyLmJhdGNoID0gMDsKPj4+ICvCoMKgwqAgdmIt
PnNocmlua2VyLnNlZWtzID0gREVGQVVMVF9TRUVLUzsKPj4gV2h5IGZsYWdzIGZpZWxkIGlzIG5v
dCBzZXQ/IElmIHZiIGlzIGFsbG9jYXRlZCBieSBrbWFsbG9jKEdGUF9LRVJORUwpCj4+IGFuZCBp
cyBub3doZXJlIHplcm8tY2xlYXJlZCwgS0FTQU4gd291bGQgY29tcGxhaW4gaXQuCj4gCj4gQ291
bGQgeW91IHBvaW50IHdoZXJlIGluIHRoZSBjb2RlIHRoYXQgd291bGQgY29tcGxhaW4gaXQ/Cj4g
SSBvbmx5IHNlZSB0d28gc2hyaW5rZXIgZmxhZ3MgKE5VTUFfQVdBUkUgYW5kIE1FTUNHX0FXQVJF
KSwgYW5kIHRoZXkgc2VlbSBub3QgcmVsYXRlZCB0byB0aGF0LgoKV2hlcmUgaXMgdmItPnNocmlu
a2VyLmZsYWdzIGluaXRpYWxpemVkPwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
