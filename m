From: Balbir Singh <balbir@linux.vnet.ibm.com>
Subject: Re: dm-ioband + bio-cgroup benchmarks
Date: Wed, 24 Sep 2008 18:08:05 +0530
Message-ID: <48DA34AD.4040305__43967.9207782776$1222261095$gmane$org@linux.vnet.ibm.com>
References: <20080919131019.GA3606@redhat.com>
	<20080922.183651.62951479.taka@valinux.co.jp>
	<20080922143042.GA19222@redhat.com>
	<20080924.193414.22923673.taka@valinux.co.jp>
Reply-To: balbir@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080924.193414.22923673.taka@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, jens.axboe@oracle.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com, agk@sourceware.org, righi.andrea@gmail.com, fernando@oss.ntt.co.jp, vgoyal@redhat.com, xemul@openvz.org
List-Id: virtualization@lists.linuxfoundation.org

Hirokazu Takahashi wrote:
> Hi,
> 
>>> It's possible the algorithm of dm-ioband can be placed in the block layer
>>> if it is really a big problem.
>>> But I doubt it can control every control block I/O as we wish since
>>> the interface the cgroup supports is quite poor.
>> Had a question regarding cgroup interface. I am assuming that in a system,
>> one will be using other controllers as well apart from IO-controller.
>> Other controllers will be using cgroup as a grouping mechanism.
>> Now coming up with additional grouping mechanism for only io-controller seems
>> little odd to me. It will make the job of higher level management software
>> harder.
>>
>> Looking at the dm-ioband grouping examples given in patches, I think cases
>> of grouping based  in pid, pgrp, uid and kvm can be handled by creating right
>> cgroup and making sure applications are launched/moved into right cgroup by
>> user space tools. 
> 
> Grouping in pid, pgrp and uid is not the point, which I've been thinking
> can be replaced with cgroup once the implementation of bio-cgroup is done.
> 
> I think problems of cgroup are that they can't support lots of storages
> and hotplug devices, it just handle them as if they were just one resource.

Could you elaborate on this please?

> I don't insist the interface of dm-ioband is the best. I just hope the
> cgroup infrastructure support this kind of resources.
> 

What sort of support will help you?



-- 
	Balbir
