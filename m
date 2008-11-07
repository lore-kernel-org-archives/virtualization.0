From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [patch 3/4] io controller: Core IO controller implementation logic
Date: Fri, 7 Nov 2008 12:21:45 +0900
Message-ID: <20081107122145.69500cd3.kamezawa.hiroyu__14119.343707762$1226028376$gmane$org@jp.fujitsu.com>
References: <20081106153022.215696930@redhat.com>
	<20081106153135.869625751@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081106153135.869625751@redhat.com>
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
Cc: menage@google.com, Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Hirokazu@smtp1.linux-foundation.org, containers@lists.linux-foundation.org, balbir@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Takahashi <taka@valinux.co.jp>, Jeff Moyer <jmoyer@redhat.com>, jens.axboe@oracle.com, Andrea@smtp1.linux-foundation.org, ngupta@google.com, fernando@oss.ntt.co.jp, Righi <righi.andrea@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 06 Nov 2008 10:30:25 -0500
vgoyal@redhat.com wrote:

> 
> o Core IO controller implementation
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> 

2 comments after a quick look.

 - I don't recommend generic work queue. More stacked dependency between "work"
   is not good. (I think disk-driver uses "work" for their jobs.)

 - It seems this bio-cgroup can queue the bio to infinite. Then, a process can submit
   io unitl cause OOM.
   (IIUC, Dirty bit of the page is cleared at submitting I/O. 
    Then dirty_ratio can't help us.)
   please add "wait for congestion by sleeping" code in bio-cgroup.


Thanks,
-Kame
