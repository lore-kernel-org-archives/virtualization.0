From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch 0/4] [RFC] Another proportional weight IO controller
Date: Thu, 20 Nov 2008 08:47:01 -0500
Message-ID: <20081120134701.GB29306__6332.13429614461$1227189184$gmane$org@redhat.com>
References: <20081113.180558.519459540419535699.ryov@valinux.co.jp>
	<20081113155834.GE7542@redhat.com>
	<20081113221304.GH7542@redhat.com>
	<20081120.182053.220301508585579959.ryov@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081120.182053.220301508585579959.ryov@valinux.co.jp>
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
Cc: menage@google.com, riel@redhat.com, akpm@linux-foundation.org, fchecconi@gmail.com, peterz@infradead.org, paolo.valente@unimore.it, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, taka@valinux.co.jp, jmoyer@redhat.com, jens.axboe@oracle.com, balbir@linux.vnet.ibm.com, ngupta@google.com, fernando@oss.ntt.co.jp, righi.andrea@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 20, 2008 at 06:20:53PM +0900, Ryo Tsuruta wrote:
> Hi Vivek,
> 
> Sorry for late reply.
> 
> > > > Do you have any benchmark results?
> > > > I'm especially interested in the followings:
> > > > - Comparison of disk performance with and without the I/O controller patch.
> > > 
> > > If I dynamically disable the bio control, then I did not observe any
> > > impact on performance. Because in that case practically it boils down
> > > to just an additional variable check in __make_request().
> > > 
> > 
> > Oh.., I understood your question wrong. You are looking for what's the 
> > performance penalty if I enable the IO controller on a device.
> 
> Yes, that is what I want to know.
> 
> > I have not done any extensive benchmarking. If I run two dd commands
> > without controller, I get 80MB/s from disk (roughly 40 MB for each task).
> > With bio group enabled (default token=2000), I was getting total BW of
> > roughly 68 MB/s.
> >
> > I have not done any performance analysis or optimizations at this point of
> > time. I plan to do that once we have some sort of common understanding about
> > a particular approach. There are so many IO controllers floating, right now
> > I am more concerned if we can all come to a common platform.
> 
> I understood the reason of posting the patch well.
> 
> > Ryo, do you still want to stick to two level scheduling? Given the problem
> > of it breaking down underlying scheduler's assumptions, probably it makes
> > more sense to the IO control at each individual IO scheduler.
> 
> I don't want to stick to it. I'm considering implementing dm-ioband's
> algorithm into the block I/O layer experimentally.

Thanks Ryo. Implementing a control at block layer sounds like another
2 level scheduling. We will still have the issue of breaking underlying
CFQ and other schedulers. How to plan to resolve that conflict.

What do you think about the solution at IO scheduler level (like BFQ) or
may be little above that where one can try some code sharing among IO
schedulers? 

Thanks
Vivek
