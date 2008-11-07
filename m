From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch 3/4] io controller: Core IO controller implementation logic
Date: Fri, 7 Nov 2008 09:50:36 -0500
Message-ID: <20081107145036.GF21884__37278.9025809199$1226069837$gmane$org@redhat.com>
References: <20081106153022.215696930@redhat.com>
	<20081106153135.869625751@redhat.com>
	<20081107122145.69500cd3.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081107122145.69500cd3.kamezawa.hiroyu@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: menage@google.com, Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Hirokazu Takahashi <taka@valinux.co.jp>, Jeff Moyer <jmoyer@redhat.com>, jens.axboe@oracle.com, balbir@linux.vnet.ibm.com, ngupta@google.com, fernando@oss.ntt.co.jp, Andrea Righi <righi.andrea@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 07, 2008 at 12:21:45PM +0900, KAMEZAWA Hiroyuki wrote:
> On Thu, 06 Nov 2008 10:30:25 -0500
> vgoyal@redhat.com wrote:
> 
> > 
> > o Core IO controller implementation
> > 
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > 
> 
> 2 comments after a quick look.
> 
>  - I don't recommend generic work queue. More stacked dependency between "work"
>    is not good. (I think disk-driver uses "work" for their jobs.)

Sorry, I did not get this. Are you recommending that don't create a new
work queue, instead use existing work queue (say kblockd) to submit the bios
here?

I will look into it. I was little worried about a kblockd being overworked
in case of too many logical devices enabling IO controller.

> 
>  - It seems this bio-cgroup can queue the bio to infinite. Then, a process can submit
>    io unitl cause OOM.
>    (IIUC, Dirty bit of the page is cleared at submitting I/O. 
>     Then dirty_ratio can't help us.)
>    please add "wait for congestion by sleeping" code in bio-cgroup.

Yes, you are right. I need to put some kind of control on max number of
bios I can queue on a cgroup and after crossing the limit, I should put
the submitting task to sleep. (Something like request descriptor kind of
flow control implememented by elevators).

Thanks
Vivek
