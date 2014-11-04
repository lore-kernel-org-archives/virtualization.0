From: Alexey Lapitsky <lex.public@gmail.com>
Subject: Re: BUG_ON in virtio-ring.c
Date: Tue, 4 Nov 2014 15:44:47 +0100
Message-ID: <CAAts5mPGV+u+r5cr4Ry+ePOpJSDY0BKY_T4A+hPaXVTWXL=TDg@mail.gmail.com>
References: <CAPM=9tyLrJ8VAdGCw_1guRS-ogCPE1Qp7faE_nrx_dAm2gvHLQ@mail.gmail.com>
	<87vc65p5a7.fsf@rustcorp.com.au>
	<CAPM=9tzw8jEv8yoLr7ktjO2DHCDzA+mURmJ-DXby_nsWUUNoyg@mail.gmail.com>
	<87li71oucu.fsf@rustcorp.com.au>
	<CAAts5mM_+Mj=vjWyJc8wZCvZehfK5dZxeA0Y9eowHwFDiWxo9Q@mail.gmail.com>
	<87fvesedfd.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87fvesedfd.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Dave Airlie <airlied@gmail.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

Sorry for the long delay. It prints exactly the same:

[    3.792033] virtqueue elements = 128, max_segments = 126 (1 queues)
[    3.802191]  vda: vda1 vda2 < vda5 >

A little bit more about my setup (if it helps):

It's a qemu-system-x86_64 kvm instance with 16 cores and 10G of RAM.
I can reproduce the bug every time with mkfs.btrfs on a 10GB LVM
volume (right after the reboot).

I have almost no knowledge of vring / virtio.
Is it correct that we need just one sg_elem entry in the vq->vring if
vq->indirect flag is set?
That's what I thought when applying the "BUG_ON(total_sg >
vq->vring.num && !vq->indirect)" patch.
