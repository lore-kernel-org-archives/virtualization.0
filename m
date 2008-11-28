From: Ryo Tsuruta <ryov@valinux.co.jp>
Subject: Re: [patch 0/4] [RFC] Another proportional weight IO controller
Date: Fri, 28 Nov 2008 22:33:30 +0900 (JST)
Message-ID: <20081128.223330.623571555980968757.ryov__4137.36843406713$1227879375$gmane$org@valinux.co.jp>
References: <20081125162720.GH341@redhat.com>
	<20081126.214707.653026525707335397.ryov@valinux.co.jp>
	<20081126160805.GE27826@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081126160805.GE27826@redhat.com>
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

> > Thanks for your explanation. 
> > I think that the same thing occurs without the higher level scheduler,
> > because all the tasks issuing I/Os are blocked while the underlying
> > device's request queue is full before those I/Os are sent to the I/O
> > scheduler.
> > 
> 
> True and this issue was pointed out by Divyesh. I think we shall have to
> fix this by allocating the request descriptors in proportion to their
> share. One possible way is to make use of elv_may_queue() to determine
> if we can allocate furhter request descriptors or not. 

At the fist glance, elv_may_queue() seemed to be useful for the purpose
as you mentioned. But I've noticed there are some problems after I
investigated the code more.

 1. Every I/O controller must have its own decision algorithm that
    which I/O requests should be block or not, whose algorithm will be
    similar to that of dm-ioband. It would be a hassle to implement it
    in all the I/O controllers.

 2. When an I/O is completed, one of the slots in the request queue
    become available, then one of the processes being blocked get awakened
    in fifo manner. This won't be the best one in most cases and
    you have to make this process sleep again and you may want to
    wake up another one. It's inefficient.

 3. In elv_may_queue(), we can't determine which process issues an I/O.
    You have no choice but to make any kind of process sleep even if
    it's a kernel thread such as kswapd or pdflush. What do you think
    is going to happen after that?
    It may be possible to modify the code not to block kernel threads,
    but I don't think you can control delayed-write I/Os.

If you want to solve these problems, I think you are going to implement
the algorithm there whose code is very similar to that of dm-ioband.

Thanks,
Ryo Tsuruta
