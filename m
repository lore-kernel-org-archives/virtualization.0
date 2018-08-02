From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next v7 3/4] net: vhost: factor out busy polling logic
	to vhost_net_busy_poll()
Date: Thu, 2 Aug 2018 16:18:39 +0800
Message-ID: <b4ffd376-6fa8-4d0c-5c3a-82d1b6e924d6__29962.3212348253$1533197804$gmane$org@redhat.com>
References: <1533092454-37196-1-git-send-email-xiangxia.m.yue@gmail.com>
	<1533092454-37196-4-git-send-email-xiangxia.m.yue@gmail.com>
	<30e62749-3cbd-ae88-6582-c20087884b20@redhat.com>
	<CAMDZJNWX7L4P0yO+-PeDFu_tmtLSntihO7rcLPB2GK4eN9zbwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAMDZJNWX7L4P0yO+-PeDFu_tmtLSntihO7rcLPB2GK4eN9zbwQ@mail.gmail.com>
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
To: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDjmnIgwMeaXpSAxNzo1MiwgVG9uZ2hhbyBaaGFuZyB3cm90ZToKPj4+ICsK
Pj4+ICsgICAgICAgICAgICAgY3B1X3JlbGF4KCk7Cj4+PiArICAgICB9Cj4+PiArCj4+PiArICAg
ICBwcmVlbXB0X2VuYWJsZSgpOwo+Pj4gKwo+Pj4gKyAgICAgaWYgKCFyeCkKPj4+ICsgICAgICAg
ICAgICAgdmhvc3RfbmV0X2VuYWJsZV92cShuZXQsIHZxKTsKPj4gTm8gbmVlZCB0byBlbmFibGUg
cnggdmlydHF1ZXVlLCBpZiB3ZSBhcmUgc3VyZSBoYW5kbGVfcngoKSB3aWxsIGJlCj4+IGNhbGxl
ZCBzb29uLgo+IElmIHdlIGRpc2FibGUgcnggdmlydHF1ZXVlIGluIGhhbmRsZV90eCBhbmQgZG9u
J3Qgc2VuZCBwYWNrZXRzIGZyb20KPiBndWVzdCBhbnltb3JlKGhhbmRsZV90eCBpcyBub3QgY2Fs
bGVkKSwgc28gd2UgY2FuIHdha2UgdXAgZm9yIHNvY2sgcnguCj4gc28gdGhlIG5ldHdvcmsgaXMg
YnJva2VuLgoKTm90IHN1cmUgSSB1bmRlcnN0YW5kIGhlcmUuIEkgbWVhbiBpcyB3ZSBzY2hlZHVs
ZSB3b3JrIGZvciBoYW5kbGVfcngoKSwgCnRoZXJlJ3Mgbm8gbmVlZCB0byBlbmFibGUgaXQgc2lu
Y2UgaGFuZGxlX3J4KCkgd2lsbCBkbyB0aGlzIGZvciB1cy4KClRoYW5rcwpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
