From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] virtio_blk: avoid DMA to stack for the sense buffer
Date: Thu, 5 Jan 2017 12:17:59 +0100
Message-ID: <20170105111759.GA17051__38624.1785985932$1483615096$gmane$org@lst.de>
References: <1483507505-26797-1-git-send-email-hch@lst.de>
	<1483507505-26797-2-git-send-email-hch@lst.de>
	<CAD9gYJKe5wbQkMGvVhZ0MUbLAAFumubk+k-nVhMDiha9FEQNTg@mail.gmail.com>
	<20170105095706.GA15566@lst.de>
	<CAD9gYJ+w4YshNR_G5zHG2SNb9fAhrF9vMbF6=ee-kYbehfGMyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAD9gYJ+w4YshNR_G5zHG2SNb9fAhrF9vMbF6=ee-kYbehfGMyw@mail.gmail.com>
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

T24gVGh1LCBKYW4gMDUsIDIwMTcgYXQgMTE6Mzc6NDZBTSArMDEwMCwg546L6YeR5rWmIHdyb3Rl
Ogo+IFRoYW5rcywgc28gaXQncyBvbmx5IHJlbGV2YW50IHRvIGtlcm5lbCA+IDQuOSwgYXMgIENP
TkZJR19WTUFQX1NUQUNLCj4gb25seSBpbnRyb2R1Y2VkIGluIDQuOSBrZXJuZWwuCgprZXJuZWwg
Pj0gNC45LCBidXQgb3RoZXJ3aXNlLCB5ZXMuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
