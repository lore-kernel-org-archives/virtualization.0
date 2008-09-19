From: Andrea Righi <righi.andrea@gmail.com>
Subject: Re: dm-ioband + bio-cgroup benchmarks
Date: Fri, 19 Sep 2008 22:28:40 +0200
Message-ID: <48D40B78.6060709__28466.1452788443$1221856277$gmane$org@gmail.com>
References: <20080918.210418.226794540.ryov@valinux.co.jp>
	<20080918131554.GB20640@redhat.com>
	<20080919.202031.86647893.taka@valinux.co.jp>
	<20080919131019.GA3606@redhat.com>
Reply-To: righi.andrea@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080919131019.GA3606@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, jens.axboe@oracle.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Hirokazu Takahashi <taka@valinux.co.jp>, dm-devel@redhat.com, agk@sourceware.org, xemul@openvz.org, fernando@oss.ntt.co.jp, balbir@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Vivek Goyal wrote:
> On Fri, Sep 19, 2008 at 08:20:31PM +0900, Hirokazu Takahashi wrote:
>>> To avoid creation of stacking another device (dm-ioband) on top of every
>>> device we want to subject to rules, I was thinking of maintaining an
>>> rb-tree per request queue. Requests will first go into this rb-tree upon
>>> __make_request() and then will filter down to elevator associated with the
>>> queue (if there is one). This will provide us the control of releasing
>>> bio's to elevaor based on policies (proportional weight, max bandwidth
>>> etc) and no need of stacking additional block device.
>> I think it's a bit late to control I/O requests there, since process
>> may be blocked in get_request_wait when the I/O load is high.
>> Please imagine the situation that cgroups with low bandwidths are
>> consuming most of "struct request"s while another cgroup with a high
>> bandwidth is blocked and can't get enough "struct request"s.
>>
>> It means cgroups that issues lot of I/O request can win the game.
>>
> 
> Ok, this is a good point. Because number of struct requests are limited
> and they seem to be allocated on first come first serve basis, so if a
> cgroup is generating lot of IO, then it might win.
> 
> But dm-ioband will face the same issue. Essentially it is also a request
> queue and it will have limited number of request descriptors. Have you 
> modified the logic somewhere for allocation of request descriptors to the
> waiting processes based on their weights? If yes, the logic probably can
> be implemented here too.

Maybe throttling dirty page ratio in memory could help to avoid this problem.
I mean, if a cgroup is exceeding the i/o limits do ehm... something.. also at
the balance_dirty_pages() level.

-Andrea
