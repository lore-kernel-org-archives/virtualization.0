From: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
Subject: Re: [patch 0/4] [RFC] Another proportional weight IO controller
Date: Fri, 07 Nov 2008 10:36:50 +0800
Message-ID: <4913A9C2.8060904__42298.6418627717$1226075711$gmane$org@cn.fujitsu.com>
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
Cc: menage@google.com, Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Hirokazu Takahashi <taka@valinux.co.jp>, Jeff Moyer <jmoyer@redhat.com>, jens.axboe@oracle.com, balbir@linux.vnet.ibm.com, ngupta@google.com, fernando@oss.ntt.co.jp, Andrea Righi <righi.andrea@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

vgoyal@redhat.com wrote:
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

  Which kernel version is this patch set based on?

> 
> Thanks
> Vivek
> 

-- 
Regards
Gui Jianfeng
