From: =?UTF-8?B?546L6YeR5rWm?= <jinpuwang@gmail.com>
Subject: Re: [PATCH] virtio_blk: avoid DMA to stack for the sense buffer
Date: Thu, 5 Jan 2017 11:37:46 +0100
Message-ID: <CAD9gYJ+w4YshNR_G5zHG2SNb9fAhrF9vMbF6=ee-kYbehfGMyw__6817.4779102721$1483728423$gmane$org@mail.gmail.com>
References: <1483507505-26797-1-git-send-email-hch@lst.de>
	<1483507505-26797-2-git-send-email-hch@lst.de>
	<CAD9gYJKe5wbQkMGvVhZ0MUbLAAFumubk+k-nVhMDiha9FEQNTg@mail.gmail.com>
	<20170105095706.GA15566@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170105095706.GA15566@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, mst@redhat.com, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

MjAxNy0wMS0wNSAxMDo1NyBHTVQrMDE6MDAgQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+
Ogo+IE9uIFdlZCwgSmFuIDA0LCAyMDE3IGF0IDA0OjQ3OjAzUE0gKzAxMDAsIOeOi+mHkea1piB3
cm90ZToKPj4gVGhpcyBzb3VuZHMgc2NhcnkuCj4+IENvdWxkIHlvdSBzaGFyZSBob3cgdG8gcmVw
cm9kdWNlIGl0LCB0aGlzIHNob3VsZCBnbyBpbnRvIHN0YWJsZSBpZgo+PiBpdCdzIHRoZSBjYXNl
Lgo+Cj4gU3RlcCAxOiBCdWlsZCB5b3VyIGtlcm5lbCB3aXRoIENPTkZJR19WTUFQX1NUQUNLPXkK
PiBTdGVwIDI6IGlzc3VlIGEgU0dfSU8gaW9jdGwsIGUuZy4gc2dfaW5xIC9kZXYvdmRhCj4KVGhh
bmtzLCBzbyBpdCdzIG9ubHkgcmVsZXZhbnQgdG8ga2VybmVsID4gNC45LCBhcyAgQ09ORklHX1ZN
QVBfU1RBQ0sKb25seSBpbnRyb2R1Y2VkIGluIDQuOSBrZXJuZWwuCgpSZWdhcmRzLApKaW5wdQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
