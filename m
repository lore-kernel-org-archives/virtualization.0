From: Hirokazu Takahashi <taka@valinux.co.jp>
Subject: Re: dm-ioband + bio-cgroup benchmarks
Date: Mon, 22 Sep 2008 18:45:39 +0900 (JST)
Message-ID: <20080922.184539.116793113.taka__48795.0967545204$1222077088$gmane$org@valinux.co.jp>
References: <20080919.202031.86647893.taka@valinux.co.jp>
	<20080919131019.GA3606@redhat.com> <48D40B78.6060709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48D40B78.6060709@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: righi.andrea@gmail.com
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, jens.axboe@oracle.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com, agk@sourceware.org, xemul@openvz.org, fernando@oss.ntt.co.jp, vgoyal@redhat.com, balbir@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Hi,

> >>> To avoid creation of stacking another device (dm-ioband) on top of every
> >>> device we want to subject to rules, I was thinking of maintaining an
> >>> rb-tree per request queue. Requests will first go into this rb-tree upon
> >>> __make_request() and then will filter down to elevator associated with the
> >>> queue (if there is one). This will provide us the control of releasing
> >>> bio's to elevaor based on policies (proportional weight, max bandwidth
> >>> etc) and no need of stacking additional block device.
> >> I think it's a bit late to control I/O requests there, since process
> >> may be blocked in get_request_wait when the I/O load is high.
> >> Please imagine the situation that cgroups with low bandwidths are
> >> consuming most of "struct request"s while another cgroup with a high
> >> bandwidth is blocked and can't get enough "struct request"s.
> >>
> >> It means cgroups that issues lot of I/O request can win the game.
> >>
> > 
> > Ok, this is a good point. Because number of struct requests are limited
> > and they seem to be allocated on first come first serve basis, so if a
> > cgroup is generating lot of IO, then it might win.
> > 
> > But dm-ioband will face the same issue. Essentially it is also a request
> > queue and it will have limited number of request descriptors. Have you 
> > modified the logic somewhere for allocation of request descriptors to the
> > waiting processes based on their weights? If yes, the logic probably can
> > be implemented here too.
> 
> Maybe throttling dirty page ratio in memory could help to avoid this problem.
> I mean, if a cgroup is exceeding the i/o limits do ehm... something.. also at
> the balance_dirty_pages() level.

That is one of the important features to be implemented for controlling I/O.
The dirty page ratio controlling can help to avoid this issue but it
isn't guaranteed. So, both of them should be implemented.

What would you think happens in cases that some cgroups may have tons of
threads which issue a lot of direct I/Os, or others may have huge memory?


Thanks,
Hirokazu Takahashi.
