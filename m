From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch 1/4] io controller: documentation
Date: Mon, 10 Nov 2008 08:44:07 -0500
Message-ID: <20081110134407.GA26956__22921.4150844657$1226324943$gmane$org@redhat.com>
References: <20081106153022.215696930@redhat.com>
	<20081106153135.743458085@redhat.com>
	<4917A116.7040603@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4917A116.7040603@cn.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Li Zefan <lizf@cn.fujitsu.com>
Cc: menage@google.com, Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Hirokazu Takahashi <taka@valinux.co.jp>, Jeff Moyer <jmoyer@redhat.com>, jens.axboe@oracle.com, balbir@linux.vnet.ibm.com, ngupta@google.com, fernando@oss.ntt.co.jp, Andrea Righi <righi.andrea@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Nov 10, 2008 at 10:48:54AM +0800, Li Zefan wrote:
> Hi, Vivek
> 
> Thanks for your work. :)
> 
> A question below.
> 
> > +For example, assume there are two cgroups A and B with weights 1024 and 2048
> > +in the system. Tasks in two cgroups A and B are doing IO to two disks sda and
> > +sdb in the system. A user has enabled IO control on both sda and sdb. Now on
> > +both sda and sdb, tasks in cgroup B will get to use 2/3 of disk BW and
> > +tasks in cgroup A will get to use 1/3 of disk bandwidth, only in case of
> > +contention. If tasks in any of the groups stop doing IO to a particular disk,
> > +task in other group will get to use full disk BW for that duration.
> > +
> 
> So in this example, I can't assign 1/3 of sda's disk BW while 2/3 of sdb's
> disk BW to A. Am I right?

Hi,

Yes you are right. Currently policies are global and not per disk. So in 
above example, cgroup A will get 1/3 of disk BW both on sda and sdb. And
one can not configure in such a manner so that A gets 1/3 of BW on sda and
2/3 of BW on sdb.

I think assigning cgroup weights per disk should be doable but personally
I think it makes configuration complex and I am not sure if it really a
very useful feature.

Thanks
Vivek
