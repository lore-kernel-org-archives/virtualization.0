From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [virtio_blk] WARNING: CPU: 0 PID: 1 at fs/sysfs/dir.c:526
	sysfs_add_one()
Date: Mon, 04 Nov 2013 15:58:41 -0700
Message-ID: <527826A1.1060309__27676.3697075241$1383609180$gmane$org@kernel.dk>
References: <20131104141012.GA17177@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20131104141012.GA17177@localhost>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 11/04/2013 07:10 AM, Fengguang Wu wrote:
> Hi Jens,
> 
> I'm not very sure about this bisect, but anyway it'd be good to inform
> you of a possible problem on commit
> 
> commit 3a02db083a78c9f3c9b69305ab513f9422d91b08
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Fri May 24 20:22:33 2013 +0200
> 
>     virtio_blk: blk-mq support
>     
>     Pretend we have 4 issue queues.
>     
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>

What git branch are you on? That one is outdated.

-- 
Jens Axboe
