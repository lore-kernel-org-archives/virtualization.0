From: Petr Mladek <pmladek@suse.cz>
Subject: Re: [PATCH v2] virtio_balloon: Convert "vballon" kthread into a
	workqueue
Date: Fri, 14 Nov 2014 18:42:52 +0100
Message-ID: <20141114174252.GE7969@dhcp128.suse.cz>
References: <1415797368-22660-1-git-send-email-pmladek@suse.cz>
	<20141112133204.GA23334@redhat.com>
	<20141114131915.GD21209@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20141114131915.GD21209@htj.dyndns.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: Jiri Kosina <jkosina@suse.cz>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri 2014-11-14 08:19:15, Tejun Heo wrote:
> Hello, Michael, Petr.
> 
> On Wed, Nov 12, 2014 at 03:32:04PM +0200, Michael S. Tsirkin wrote:
> > > +	/* The workqueue servicing the balloon. */
> > > +	struct workqueue_struct *wq;
> > > +	struct work_struct wq_work;
> > 
> > We could use system_freezable_wq instead.
> > I do agree a dedicated wq is better since this can get blocked
> > for a long time while allocating memory.
> > However, please add a comment to this effect.
> 
> system_freezable_wq should be fine.  Workqueues by default have a
> pretty high maximum concurrency level (256).  There's no reason to
> create separate workqueues solely for that purpose.

Great. If nobody complains until next week, I will send an updated
patch with the system workqueue and also with the fixed typos.

Thanks all reviewers for nice hints.

Best Regards,
Petr
