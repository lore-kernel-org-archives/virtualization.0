From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] virtio_blk: avoid DMA to stack for the sense buffer
Date: Thu, 5 Jan 2017 10:57:06 +0100
Message-ID: <20170105095706.GA15566@lst.de>
References: <1483507505-26797-1-git-send-email-hch@lst.de>
	<1483507505-26797-2-git-send-email-hch@lst.de>
	<CAD9gYJKe5wbQkMGvVhZ0MUbLAAFumubk+k-nVhMDiha9FEQNTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAD9gYJKe5wbQkMGvVhZ0MUbLAAFumubk+k-nVhMDiha9FEQNTg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: =?utf-8?B?546L6YeR5rWm?= <jinpuwang@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, mst@redhat.com, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

T24gV2VkLCBKYW4gMDQsIDIwMTcgYXQgMDQ6NDc6MDNQTSArMDEwMCwg546L6YeR5rWmIHdyb3Rl
Ogo+IFRoaXMgc291bmRzIHNjYXJ5Lgo+IENvdWxkIHlvdSBzaGFyZSBob3cgdG8gcmVwcm9kdWNl
IGl0LCB0aGlzIHNob3VsZCBnbyBpbnRvIHN0YWJsZSBpZgo+IGl0J3MgdGhlIGNhc2UuCgpTdGVw
IDE6IEJ1aWxkIHlvdXIga2VybmVsIHdpdGggQ09ORklHX1ZNQVBfU1RBQ0s9eQpTdGVwIDI6IGlz
c3VlIGEgU0dfSU8gaW9jdGwsIGUuZy4gc2dfaW5xIC9kZXYvdmRhCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
