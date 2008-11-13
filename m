From: Ryo Tsuruta <ryov@valinux.co.jp>
Subject: Re: [patch 0/4] [RFC] Another proportional weight IO controller
Date: Thu, 13 Nov 2008 18:05:58 +0900 (JST)
Message-ID: <20081113.180558.519459540419535699.ryov__35913.657237734$1226567471$gmane$org@valinux.co.jp>
References: <20081106153022.215696930@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081106153022.215696930@redhat.com>
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
Cc: menage@google.com, riel@redhat.com, akpm@linux-foundation.org, peterz@infradead.org, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, taka@valinux.co.jp, jmoyer@redhat.com, jens.axboe@oracle.com, balbir@linux.vnet.ibm.com, ngupta@google.com, fernando@oss.ntt.co.jp, righi.andrea@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

Hi,

From: vgoyal@redhat.com
Subject: [patch 0/4] [RFC] Another proportional weight IO controller 
Date: Thu, 06 Nov 2008 10:30:22 -0500

> Hi,
> 
> If you are not already tired of so many io controller implementations, here
> is another one.
> 
> This is a very eary very crude implementation to get early feedback to see
> if this approach makes any sense or not.
> 
> This controller is a proportional weight IO controller primarily
> based on/inspired by dm-ioband. One of the things I personally found little
> odd about dm-ioband was need of a dm-ioband device for every device we want
> to control.  I thought that probably we can make this control per request
> queue and get rid of device mapper driver. This should make configuration
> aspect easy.
> 
> I have picked up quite some amount of code from dm-ioband especially for
> biocgroup implementation.
> 
> I have done very basic testing and that is running 2-3 dd commands in different
> cgroups on x86_64. Wanted to throw out the code early to get some feedback.
> 
> More details about the design and how to are in documentation patch.
> 
> Your comments are welcome.

Do you have any benchmark results?
I'm especially interested in the followings:
- Comparison of disk performance with and without the I/O controller patch.
- Put uneven I/O loads. Processes, which belong to a cgroup which is
  given a smaller weight than another cgroup, put heavier I/O load
  like the following.

     echo 1024 > /cgroup/bio/test1/bio.shares
     echo 8192 > /cgroup/bio/test2/bio.shares

     echo $$ > /cgroup/bio/test1/tasks
     dd if=/somefile1-1 of=/dev/null &
     dd if=/somefile1-2 of=/dev/null &
     ... 
     dd if=/somefile1-100 of=/dev/null
     echo $$ > /cgroup/bio/test2/tasks
     dd if=/somefile2-1 of=/dev/null &
     dd if=/somefile2-2 of=/dev/null &
     ...
     dd if=/somefile2-10 of=/dev/null &

Thanks,
Ryo Tsuruta
