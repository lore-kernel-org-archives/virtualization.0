From: Ryo Tsuruta <ryov@valinux.co.jp>
Subject: Re: [patch 0/4] [RFC] Another proportional weight IO controller
Date: Fri, 28 Nov 2008 12:09:54 +0900 (JST)
Message-ID: <20081128.120954.1024833258536769313.ryov__3209.45236967436$1227842159$gmane$org@valinux.co.jp>
References: <20081126.214707.653026525707335397.ryov@valinux.co.jp>
	<20081126160805.GE27826@redhat.com>
	<1227775382.7443.43.camel@sebastian.kern.oss.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1227775382.7443.43.camel@sebastian.kern.oss.ntt.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: fernando@oss.ntt.co.jp
Cc: menage@google.com, riel@redhat.com, fchecconi@gmail.com, peterz@infradead.org, paolo.valente@unimore.it, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, taka@valinux.co.jp, jmoyer@redhat.com, jens.axboe@oracle.com, balbir@linux.vnet.ibm.com, ngupta@google.com, akpm@linux-foundation.org, vgoyal@redhat.com, righi.andrea@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

Hi,

> > > I don't come up with any use case, but I would like to make the
> > > resource controller more flexible. Actually, a certain block device
> > > that I'm using does not use the I/O scheduler.
> > 
> > Isn't it equivalent to using No-op? If yes, then it should not be an
> > issue?
> 
> No, it is not equivalent. When using devices drivers that provide their
> own make_request_fn() (check for devices that invoke
> blk_queue_make_request() at initialization time) bios entering the block
> layer can go directly to the device driver and from there to the device.

As Fernando said, that device driver invokes blk_queue_make_request(),

Thanks,
Ryo Tsuruta
