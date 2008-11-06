From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 0/4] [RFC] Another proportional weight IO controller
Date: Thu, 06 Nov 2008 17:16:13 +0100
Message-ID: <1225988173.7803.4723.camel__3826.10372403196$1225988496$gmane$org@twins>
References: <20081106153022.215696930@redhat.com>
	<1225986593.7803.4688.camel@twins> <20081106160154.GA7461@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081106160154.GA7461@redhat.com>
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
Cc: menage@google.com, Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Hirokazu Takahashi <taka@valinux.co.jp>, Jeff Moyer <jmoyer@redhat.com>, jens.axboe@oracle.com, balbir@linux.vnet.ibm.com, ngupta@google.com, fernando@oss.ntt.co.jp, Andrea Righi <righi.andrea@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2008-11-06 at 11:01 -0500, Vivek Goyal wrote:

> > Does this still require I use dm, or does it also work on regular block
> > devices? Patch 4/4 isn't quite clear on this.
> 
> No. You don't have to use dm. It will simply work on regular devices. We
> shall have to put few lines of code for it to work on devices which don't
> make use of standard __make_request() function and provide their own
> make_request function. 
> 
> Hence for example, I have put that few lines of code so that it can work
> with dm device. I shall have to do something similar for md too.
> 
> Though, I am not very sure why do I need to do IO control on higher level
> devices. Will it be sufficient if we just control only bottom most
> physical block devices?
> 
> Anyway, this approach should work at any level.

Nice, although I would think only doing the higher level devices makes
more sense than only doing the leafs.

Is there any reason we cannot merge this with the regular io-scheduler
interface? afaik the only problem with doing group scheduling in the
io-schedulers is the stacked devices issue.

Could we make the io-schedulers aware of this hierarchy?
