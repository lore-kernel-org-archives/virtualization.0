From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: BUG_ON in virtio-ring.c
Date: Thu, 18 Dec 2014 13:43:11 +1030
Message-ID: <87tx0ttzug.fsf@rustcorp.com.au>
References: <CAPM=9tyLrJ8VAdGCw_1guRS-ogCPE1Qp7faE_nrx_dAm2gvHLQ@mail.gmail.com>
	<87vc65p5a7.fsf@rustcorp.com.au>
	<CAPM=9tzw8jEv8yoLr7ktjO2DHCDzA+mURmJ-DXby_nsWUUNoyg@mail.gmail.com>
	<87li71oucu.fsf@rustcorp.com.au>
	<CAAts5mM_+Mj=vjWyJc8wZCvZehfK5dZxeA0Y9eowHwFDiWxo9Q@mail.gmail.com>
	<87fvesedfd.fsf@rustcorp.com.au>
	<CAAts5mPGV+u+r5cr4Ry+ePOpJSDY0BKY_T4A+hPaXVTWXL=TDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAAts5mPGV+u+r5cr4Ry+ePOpJSDY0BKY_T4A+hPaXVTWXL=TDg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexey Lapitsky <lex.public@gmail.com>
Cc: Dave Airlie <airlied@gmail.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Alexey Lapitsky <lex.public@gmail.com> writes:
> Hi,
>
> Sorry for the long delay. It prints exactly the same:
>
> [    3.792033] virtqueue elements = 128, max_segments = 126 (1 queues)
> [    3.802191]  vda: vda1 vda2 < vda5 >
>
> A little bit more about my setup (if it helps):

OK, I think this is fixed by Ming Lei's recent count updates,
which interestingly did not seem to be CC:stable.

Cheers,
Rusty.
