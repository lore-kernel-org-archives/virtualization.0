From: "KAMEZAWA Hiroyuki" <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [Xen-devel] Re: [PATCH 7/9] blkio-cgroup-v9: Page tracking hooks
Date: Thu, 23 Jul 2009 21:02:13 +0900 (JST)
Message-ID: <5971c26b399a97f51dd10ea497617733.squirrel__40812.9365802326$1248350599$gmane$org@webmail-b.css.fujitsu.com>
References: <20090723091841.81ff2432.kamezawa.hiroyu@jp.fujitsu.com>
	<20090723.153843.193704010.ryov@valinux.co.jp>
	<20090723164935.e97a3ccf.kamezawa.hiroyu@jp.fujitsu.com>
	<20090723.190253.226783703.ryov@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090723.190253.226783703.ryov@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ryo Tsuruta <ryov@valinux.co.jp>
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com, agk@redhat.com, kamezawa.hiroyu@jp.fujitsu.com
List-Id: virtualization@lists.linuxfoundation.org

Ryo Tsuruta wrote:
> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

>> > dm-ioband gives high priority to I/O for swap-out by checking whether
>> > PG_swapcache flag is set on the I/O page, regardless of the assigned
>> > I/O bandwidth, and the bandwidth consumed for swap-out is charged to
>> > the owner of the pages as a debt.
>> > How about this approach?
>>
>> I don't think it's reasonable. Why I/O device, scheduler should know
>> about
>> such mm-related information ? I think layering is wrong.
>
> I think that urgent I/O requests such as swap-out should be notified
> by setting a special flag in the struct bio, but there is no such
> mechanism at this time. That is why dm-ioband uses this approach.
>
>> And your approatch cannot be a workaround.
>>
>> In follwing _typical_ case,
>>
>>   - A process does small logging to /var/log/mylog, once in a sec.
>>     but it uses some amount of cold memory or shmem.
>>
>> This process's logging will be delayed _unexpectedly_ by some buggy
>> process
>> which does memory leak.
>
> Do you mean that the delay in logging is caused since the small process
> is swapped out unexpectedly by the buggy processes?
I don't write "small process", "small logging".
Buggy process does swap-out and cosumes someone else's bandwidth, then,
loggind will be delayed. Important here is throttle bandwidth consumed by
buggy prorcess, not other's.

> How about using memory cgroup to prevent the small process from swap-out?
It never be help if memcg is not configured.

My point is "don't allow anyone to use bandwidth of others."
Considering job isolation, a thread who requests swap-out should be charged
against bandwidth.

Thanks,
-Kame
