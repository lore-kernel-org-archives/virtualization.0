From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [virtio_blk] WARNING: CPU: 0 PID: 1 at fs/sysfs/dir.c:526
	sysfs_add_one()
Date: Wed, 6 Nov 2013 20:53:45 +0800
Message-ID: <20131106125345.GA16685__38299.4614694782$1383742455$gmane$org@localhost>
References: <20131104141012.GA17177@localhost>
 <527826A1.1060309@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <527826A1.1060309@kernel.dk>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Jens,

On Mon, Nov 04, 2013 at 03:58:41PM -0700, Jens Axboe wrote:
> On 11/04/2013 07:10 AM, Fengguang Wu wrote:
> > Hi Jens,
> > 
> > I'm not very sure about this bisect, but anyway it'd be good to inform
> > you of a possible problem on commit
> > 
> > commit 3a02db083a78c9f3c9b69305ab513f9422d91b08
> > Author: Jens Axboe <axboe@kernel.dk>
> > Date:   Fri May 24 20:22:33 2013 +0200
> > 
> >     virtio_blk: blk-mq support
> >     
> >     Pretend we have 4 issue queues.
> >     
> >     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> What git branch are you on? That one is outdated.

The commit is from block tree's new-queue and new-queue2 branches.
Yeah sorry these two branches are a bit old.

Thanks,
Fengguang
