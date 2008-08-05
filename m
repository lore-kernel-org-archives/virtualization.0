From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: Too many I/O controller patches
Date: Tue, 05 Aug 2008 09:25:37 -0700
Message-ID: <1217953537.10907.30.camel__16639.5082175315$1217953702$gmane$org@nimitz>
References: <20080804.175126.193692178.ryov@valinux.co.jp>
	<1217870433.20260.101.camel@nimitz> <489748E6.5080106@gmail.com>
	<1217876521.20260.123.camel@nimitz> <48976A2A.9060600@gmail.com>
	<6599ad830808042255y59215481l5463d4dca9fb2001@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <6599ad830808042255y59215481l5463d4dca9fb2001@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paul Menage <menage@google.com>
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com, agk@sourceware.org, righi.andrea@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2008-08-04 at 22:55 -0700, Paul Menage wrote:
> 
> As Dave suggested, I think it would make more sense to have your
> page-dirtying throttle points hook into the memory controller instead,
> and allow the memory controller to track/limit dirty pages for a
> cgroup, and potentially do throttling as part of that.

Yeah, I'm sure we're going to have to get to setting the dirty ratio
        
        $ cat /proc/sys/vm/dirty_ratio
        40

on a per-container basis at *some* point.  We might as well do it
earlier rather than later.

-- Dave
