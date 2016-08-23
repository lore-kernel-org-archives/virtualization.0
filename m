From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: [PATCH] CodingStyle: add some more error handling guidelines
Date: Tue, 23 Aug 2016 14:46:22 +0200
Message-ID: <87mvk33b6p.fsf__13462.711001239$1472119831$gmane$org@miraculix.mork.no>
References: <1471874251-7721-1-git-send-email-mst@redhat.com>
	<87mvk3vjbg.fsf@miraculix.mork.no> <20160823115832.GG4129@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160823115832.GG4129@mwanda> (Dan Carpenter's message of "Tue,
	23 Aug 2016 14:58:32 +0300")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Julia Lawall <julia.lawall@lip6.fr>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

RGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPiB3cml0ZXM6Cgo+IEhpa2Ug
dXAgdGhlIG1vdW50YWluLCB0aGVuIGlmIHlvdSBnZXQgc3R1Y2sgaGlrZSBiYWNrIGRvd24gdXNp
bmcgdGhlCj4gZXhhY3Qgc2FtZSBwYXRoLgoKT0ssIEkgdW5kZXJzdGFuZCB3aGF0IHlvdSBzYXku
ICBJIGp1c3QgY2FuJ3QgcmVzaXN0IG9iamVjdGluZyB0byB0aGF0CmV4YW1wbGUgOykKCkluIG15
IGV4cGVyaWVuY2UsIGZpbmRpbmcgdGhlIGV4YWN0IHNhbWUgcGF0aCBiYWNrIGFmdGVyIGhpa2lu
ZyB1cCBhCm1vdW50YWluIGlzIHJlYWxseSBoYXJkLiBFc3BlY2lhbGx5IGlmIHlvdSBhcmUgaW4g
ZW5vdWdoIHRyb3VibGUgYWxyZWFkeQp0byBnZXQgc3R1Y2suIFVwIGFuZCBkb3duIHRlbmQgdG8g
bG9vayBjb21wbGV0ZWx5IGRpZmZlcmVudC4gIExvb2tpbmcKYmFjayBhbGwgdGhlIHRpbWUgd2hp
bGUgeW91IGdvIHVwIG1pZ2h0IGhlbHAsIGJ1dCBmaW5kaW5nIHlvdXIgd2F5IGJhY2sKYnkgc2lt
cGx5IHRha2luZyB0aGUgcmV2ZXJzZSBwYXRoIGlzIGRlZmluaXRlbHkgbm90IGVhc3kuCgoKQmrD
uHJuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
