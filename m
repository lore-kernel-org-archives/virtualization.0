From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3] virtio_balloon: Convert "vballoon" kthread into a
	workqueue
Date: Thu, 20 Nov 2014 11:50:28 -0500
Message-ID: <20141120165028.GM14877@htj.dyndns.org>
References: <1416499397-16669-1-git-send-email-pmladek@suse.cz>
	<20141120160746.GI14877@htj.dyndns.org>
	<20141120162543.GA7466@redhat.com>
	<20141120162624.GA7479@redhat.com>
	<20141120162935.GK14877@htj.dyndns.org>
	<20141120164711.GA7495@redhat.com>
	<20141120164933.GL14877@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20141120164933.GL14877@htj.dyndns.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.cz>, virtualization@lists.linux-foundation.org, Jeff Epler <jepler@unpythonic.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 20, 2014 at 11:49:33AM -0500, Tejun Heo wrote:
> On Thu, Nov 20, 2014 at 06:47:11PM +0200, Michael S. Tsirkin wrote:
> > > There's cancel_work_sync() to stop the self-requeueing ones.
> > 
> > What happens if queue_work runs while cancel_work_sync is in progress?
> > Does it fail to queue?
> 
> cancel_work_sync() is guaranteed to take self-requeueing work items no
                                      ^ stop

-- 
tejun
