From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 06/92] kvm: introspection: add
	KVMI_CONTROL_CMD_RESPONSE
Date: Tue, 13 Aug 2019 11:15:34 +0200
Message-ID: <e8f59b08-734a-2ce1-ae28-3cc9d90c0bcb@redhat.com>
References: <20190809160047.8319-1-alazar@bitdefender.com>
	<20190809160047.8319-7-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190809160047.8319-7-alazar@bitdefender.com>
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
To: =?UTF-8?Q?Adalbert_Laz=c4=83r?= <alazar@bitdefender.com>, kvm@vger.kernel.org
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Weijiang Yang <weijiang.yang@intel.com>, Yu C Zhang <yu.c.zhang@intel.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?Q?Samuel_Laur=c3=a9n?= <samuel.lauren@iki.fi>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Patrick Colp <patrick.colp@oracle.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Mihai_Don=c8=9bu?= <mdontu@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gMDkvMDgvMTkgMTc6NTksIEFkYWxiZXJ0IExhesSDciB3cm90ZToKPiArSWYgYG5vd2AgaXMg
MSwgdGhlIGNvbW1hbmQgcmVwbHkgaXMgZW5hYmxlZC9kaXNhYmxlZCAoYWNjb3JkaW5nIHRvCj4g
K2BlbmFibGVgKSBzdGFydGluZyB3aXRoIHRoZSBjdXJyZW50IGNvbW1hbmQuIEZvciBleGFtcGxl
LCBgZW5hYmxlPTBgCj4gK2FuZCBgbm93PTFgIG1lYW5zIHRoYXQgdGhlIHJlcGx5IGlzIGRpc2Fi
bGVkIGZvciB0aGlzIGNvbW1hbmQgdG9vLAo+ICt3aGlsZSBgZW5hYmxlPTBgIGFuZCBgbm93PTBg
IG1lYW5zIHRoYXQgYSByZXBseSB3aWxsIGJlIHNlbmQgZm9yIHRoaXMKPiArY29tbWFuZCwgYnV0
IG5vdCBmb3IgdGhlIG5leHQgb25lcyAodW50aWwgZW5hYmxlZCBiYWNrIHdpdGggYW5vdGhlcgo+
ICsqS1ZNSV9DT05UUk9MX0NNRF9SRVNQT05TRSopLgo+ICsKPiArVGhpcyBjb21tYW5kIGlzIHVz
ZWQgYnkgdGhlIGludHJvc3BlY3Rpb24gdG9vbCB0byBkaXNhYmxlIHRoZSByZXBsaWVzCj4gK2Zv
ciBjb21tYW5kcyByZXR1cm5pbmcgYW4gZXJyb3IgY29kZSBvbmx5IChlZy4gKktWTUlfU0VUX1JF
R0lTVEVSUyopCj4gK3doZW4gYW4gZXJyb3IgaXMgbGVzcyBsaWtlbHkgdG8gaGFwcGVuLiBGb3Ig
ZXhhbXBsZSwgdGhlIGZvbGxvd2luZwo+ICtjb21tYW5kcyBjYW4gYmUgdXNlZCB0byByZXBseSB0
byBhbiBldmVudCB3aXRoIGEgc2luZ2xlIGB3cml0ZSgpYCBjYWxsOgo+ICsKPiArCUtWTUlfQ09O
VFJPTF9DTURfUkVTUE9OU0UgZW5hYmxlPTAgbm93PTEKPiArCUtWTUlfU0VUX1JFR0lTVEVSUyB2
Y3B1PU4KPiArCUtWTUlfRVZFTlRfUkVQTFkgICB2Y3B1PU4KPiArCUtWTUlfQ09OVFJPTF9DTURf
UkVTUE9OU0UgZW5hYmxlPTEgbm93PTAKCkkgZG9uJ3QgdW5kZXJzdGFuZCB0aGUgdXNhZ2UuICBJ
cyB0aGVyZSBhbnkgY2FzZSB3aGVyZSB5b3Ugd2FudCBub3cgPT0gMQphY3R1YWxseT8gIENhbiB5
b3UganVzdCBzYXkgdGhhdCBLVk1JX0NPTlRST0xfQ01EX1JFU1BPTlNFIG5ldmVyIGhhcyBhCnJl
cGx5LCBvciB0byBtYWtlIG5vdz09ZW5hYmxlPwoKPiArCWlmIChlcnIpCj4gKwkJa3ZtaV93YXJu
KGlrdm0sICJFcnJvciBjb2RlICVkIGRpc2NhcmRlZCBmb3IgbWVzc2FnZSBpZCAlZFxuIiwKPiAr
CQkJICBlcnIsIG1zZy0+aWQpOwo+ICsKCldvdWxkIGl0IG1ha2Ugc2Vuc2UgdG8gZXZlbiBjbG9z
ZSB0aGUgc29ja2V0IGlmIHRoZXJlIGlzIGFuIGVycm9yPwoKUGFvbG8KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
