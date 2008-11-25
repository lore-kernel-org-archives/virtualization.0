From: Ryo Tsuruta <ryov@valinux.co.jp>
Subject: Re: [patch 0/4] [RFC] Another proportional weight IO controller
Date: Tue, 25 Nov 2008 11:33:59 +0900 (JST)
Message-ID: <20081125.113359.623571555980951312.ryov__40691.6856569753$1227580664$gmane$org@valinux.co.jp>
References: <20081113221304.GH7542@redhat.com>
	<20081120.182053.220301508585579959.ryov@valinux.co.jp>
	<20081120134701.GB29306@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081120134701.GB29306@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: vgoyal@redhat.com
Cc: menage@google.com, riel@redhat.com, akpm@linux-foundation.org, fchecconi@gmail.com, peterz@infradead.org, paolo.valente@unimore.it, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, taka@valinux.co.jp, jmoyer@redhat.com, jens.axboe@oracle.com, balbir@linux.vnet.ibm.com, ngupta@google.com, fernando@oss.ntt.co.jp, righi.andrea@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

Hi Vivek,

> > > Ryo, do you still want to stick to two level scheduling? Given the problem
> > > of it breaking down underlying scheduler's assumptions, probably it makes
> > > more sense to the IO control at each individual IO scheduler.
> > 
> > I don't want to stick to it. I'm considering implementing dm-ioband's
> > algorithm into the block I/O layer experimentally.
> 
> Thanks Ryo. Implementing a control at block layer sounds like another
> 2 level scheduling. We will still have the issue of breaking underlying
> CFQ and other schedulers. How to plan to resolve that conflict.

I think there is no conflict against I/O schedulers.
Could you expain to me about the conflict?

> What do you think about the solution at IO scheduler level (like BFQ) or
> may be little above that where one can try some code sharing among IO
> schedulers? 

I would like to support any type of block device even if I/Os issued
to the underlying device doesn't go through IO scheduler. Dm-ioband
can be made use of for the devices such as loop device.

Thanks,
Ryo Tsuruta
