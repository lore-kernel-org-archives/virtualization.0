From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: RFC: Attaching threads to cgroups is OK?
Date: Wed, 20 Aug 2008 17:43:34 +0900
Message-ID: <20080820174334.a566a775.kamezawa.hiroyu@jp.fujitsu.com>
References: <20080819202237.edd75933.kamezawa.hiroyu@jp.fujitsu.com>
	<48AABC31.7070207@linux.vnet.ibm.com>
	<1219150334.14590.12.camel@sebastian.kern.oss.ntt.co.jp>
	<20080820.161247.64324924.taka@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080820.161247.64324924.taka@valinux.co.jp>
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
Cc: containers@lists.linux-foundation.org, fernando@oss.ntt.co.jp, balbir@linux.vnet.ibm.com, menage@google.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 20 Aug 2008 16:12:47 +0900 (JST)
Hirokazu Takahashi <taka@valinux.co.jp> wrote:

>  - I think this kind of thread application should control its I/O requests
>    inside of the application. I guess it seems to quite difficult to
>    determine which thread is doing what kind of job in the application.
>    We can just leave this issue to these type of applications, can we?
>    I guess most of this kind of applications must have been well designed
>    already.
> 
I agree. (it's better to postpone this.)

But maybe cpuset (HPC) applications uses per-thread cgroup attachment.
So, I can't say there is no trouble even if we ignore threads.

Thanks,
-Kame
