From: Rik van Riel <riel@redhat.com>
Subject: Re: [patch 0/4] [RFC] Another proportional weight IO controller
Date: Thu, 06 Nov 2008 11:47:47 -0500
Message-ID: <49131FB3.4060807__43308.8987287649$1225990303$gmane$org@redhat.com>
References: <20081106153022.215696930@redhat.com>	
	<1225986593.7803.4688.camel@twins>
	<20081106160154.GA7461@redhat.com>
	<1225988173.7803.4723.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1225988173.7803.4723.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: menage@google.com, Andrew Morton <akpm@linux-foundation.org>, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Hirokazu Takahashi <taka@valinux.co.jp>, Jeff Moyer <jmoyer@redhat.com>, jens.axboe@oracle.com, balbir@linux.vnet.ibm.com, ngupta@google.com, fernando@oss.ntt.co.jp, Vivek Goyal <vgoyal@redhat.com>, Andrea Righi <righi.andrea@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Peter Zijlstra wrote:

> Nice, although I would think only doing the higher level devices makes
> more sense than only doing the leafs.

I'm not convinced.

Say that you have two resource groups on a bunch of LVM
volumes across two disks.

If one of the resource groups only sends requests to one
of the disks, the other resource group should be able to
get all of its requests through immediateley at the other
disk.

Holding up the second resource group's requests could
result in a disk being idle. Worse, once that cgroup's
requests finally make it through, the other cgroup might
also want to use the disk and they both get slowed down.

When a resource is uncontended, should a potential user
be made to wait?

-- 
All rights reversed.
