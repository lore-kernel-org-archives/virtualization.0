From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v37 1/3] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
Date: Fri, 28 Dec 2018 09:03:46 +0100
Message-ID: <2e801749-eb66-1d68-3c06-67cc6508e067@de.ibm.com>
References: <1535333539-32420-1-git-send-email-wei.w.wang@intel.com>
	<1535333539-32420-2-git-send-email-wei.w.wang@intel.com>
	<49d706f7-a0ee-e571-7d02-bcadac5ce742@de.ibm.com>
	<5C259485.2030809@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5C259485.2030809@intel.com>
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
To: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, dgilbert@redhat.com
Cc: yang.zhang.wz@gmail.com, riel@redhat.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, pbonzini@redhat.com, nilal@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyOC4xMi4yMDE4IDA0OjEyLCBXZWkgV2FuZyB3cm90ZToKPiBPbiAxMi8yNy8yMDE4IDA4
OjAzIFBNLCBDaHJpc3RpYW4gQm9ybnRyYWVnZXIgd3JvdGU6Cj4+IE9uIDI3LjA4LjIwMTggMDM6
MzIsIFdlaSBXYW5nIHdyb3RlOgo+Pj4gwqAgc3RhdGljIGludCBpbml0X3ZxcyhzdHJ1Y3Qgdmly
dGlvX2JhbGxvb24gKnZiKQo+Pj4gwqAgewo+Pj4gLcKgwqDCoCBzdHJ1Y3QgdmlydHF1ZXVlICp2
cXNbM107Cj4+PiAtwqDCoMKgIHZxX2NhbGxiYWNrX3QgKmNhbGxiYWNrc1tdID0geyBiYWxsb29u
X2FjaywgYmFsbG9vbl9hY2ssIHN0YXRzX3JlcXVlc3QgfTsKPj4+IC3CoMKgwqAgc3RhdGljIGNv
bnN0IGNoYXIgKiBjb25zdCBuYW1lc1tdID0geyAiaW5mbGF0ZSIsICJkZWZsYXRlIiwgInN0YXRz
IiB9Owo+Pj4gLcKgwqDCoCBpbnQgZXJyLCBudnFzOwo+Pj4gK8KgwqDCoCBzdHJ1Y3QgdmlydHF1
ZXVlICp2cXNbVklSVElPX0JBTExPT05fVlFfTUFYXTsKPj4+ICvCoMKgwqAgdnFfY2FsbGJhY2tf
dCAqY2FsbGJhY2tzW1ZJUlRJT19CQUxMT09OX1ZRX01BWF07Cj4+PiArwqDCoMKgIGNvbnN0IGNo
YXIgKm5hbWVzW1ZJUlRJT19CQUxMT09OX1ZRX01BWF07Cj4+PiArwqDCoMKgIGludCBlcnI7Cj4+
Pgo+Pj4gwqDCoMKgwqDCoCAvKgo+Pj4gLcKgwqDCoMKgICogV2UgZXhwZWN0IHR3byB2aXJ0cXVl
dWVzOiBpbmZsYXRlIGFuZCBkZWZsYXRlLCBhbmQKPj4+IC3CoMKgwqDCoCAqIG9wdGlvbmFsbHkg
c3RhdC4KPj4+ICvCoMKgwqDCoCAqIEluZmxhdGVxIGFuZCBkZWZsYXRlcSBhcmUgdXNlZCB1bmNv
bmRpdGlvbmFsbHkuIFRoZSBuYW1lc1tdCj4+PiArwqDCoMKgwqAgKiB3aWxsIGJlIE5VTEwgaWYg
dGhlIHJlbGF0ZWQgZmVhdHVyZSBpcyBub3QgZW5hYmxlZCwgd2hpY2ggd2lsbAo+Pj4gK8KgwqDC
oMKgICogY2F1c2Ugbm8gYWxsb2NhdGlvbiBmb3IgdGhlIGNvcnJlc3BvbmRpbmcgdmlydHF1ZXVl
IGluIGZpbmRfdnFzLgo+Pj4gwqDCoMKgwqDCoMKgICovCj4+IFRoaXMgbWlnaHQgYmUgdHJ1ZSBm
b3IgdmlydGlvLXBjaSwgYnV0IGl0IGlzIG5vdCBmb3IgdmlydGlvLWNjdy4KPiAKPiBIaSBDaHJp
c3RpYW4sCj4gCj4gCj4gUGxlYXNlIHRyeSB0aGUgZml4IHBhdGNoZXM6IGh0dHBzOi8vbGttbC5v
cmcvbGttbC8yMDE4LzEyLzI3LzMzNgoKU2VlIGFuc3dlciB0byB0aGF0IHRocmVhZC4gSXQgZml4
ZXMgdGhlIHJhbmRvbSBib290IGNyYXNoZXMuClRoZXJlIGlzIHN0aWxsIHRoZSByZWdyZXNzaW9u
IHRoYXQgYmFsbG9vbmluZyBkb2VzIG5vIGxvbmdlciB3b3JrIG9uCnMzOTAgKHNlZSB0aGUgY2Fs
bCB0cmFjZSkuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
