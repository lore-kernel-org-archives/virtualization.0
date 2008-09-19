From: Hirokazu Takahashi <taka@valinux.co.jp>
Subject: Re: dm-ioband + bio-cgroup benchmarks
Date: Fri, 19 Sep 2008 15:12:21 +0900 (JST)
Message-ID: <20080919.151221.49666828.taka__42852.2118054845$1221804899$gmane$org@valinux.co.jp>
References: <20080918.210418.226794540.ryov@valinux.co.jp>
	<20080918131554.GB20640@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080918131554.GB20640@redhat.com>
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
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, jens.axboe@oracle.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com, righi.andrea@gmail.com, agk@sourceware.org, xemul@openvz.org, fernando@oss.ntt.co.jp, balbir@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Hi,

> > Hi All,
> > 
> > I have got excellent results of dm-ioband, that controls the disk I/O
> > bandwidth even when it accepts delayed write requests.
> > 
> > In this time, I ran some benchmarks with a high-end storage. The
> > reason was to avoid a performance bottleneck due to mechanical factors
> > such as seek time.
> > 
> > You can see the details of the benchmarks at:
> > http://people.valinux.co.jp/~ryov/dm-ioband/hps/
> > 
> 
> Hi Ryo,
> 
> I had a query about dm-ioband patches. IIUC, dm-ioband patches will break
> the notion of process priority in CFQ because now dm-ioband device will
> hold the bio and issue these to lower layers later based on which bio's
> become ready. Hence actual bio submitting context might be different and
> because cfq derives the io_context from current task, it will be broken.

This is completely another problem we have to solve.
The CFQ scheduler has really bad assumption that the current process
must be the owner. This problem occurs when you use some of device
mapper devices or use linux aio.

> To mitigate that problem, we probably need to implement Fernando's
> suggestion of putting io_context pointer in bio. 
> 
> Have you already done something to solve this issue?

Actually, I already have a patch to solve this problem, which make
each bio have a pointer to the io_context of the owner process.
Would you take a look at the thread whose subject is "I/O context
inheritance" in:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0804.2/index.html#2850

Fernando also knows this.

Thank you,
Hirokazu Takahashi.
