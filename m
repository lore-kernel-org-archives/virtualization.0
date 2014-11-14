From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] virtio_balloon: Convert "vballon" kthread into a
	workqueue
Date: Fri, 14 Nov 2014 08:19:15 -0500
Message-ID: <20141114131915.GD21209@htj.dyndns.org>
References: <1415797368-22660-1-git-send-email-pmladek@suse.cz>
	<20141112133204.GA23334@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20141112133204.GA23334@redhat.com>
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
Cc: Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.cz>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hello, Michael, Petr.

On Wed, Nov 12, 2014 at 03:32:04PM +0200, Michael S. Tsirkin wrote:
> > +	/* The workqueue servicing the balloon. */
> > +	struct workqueue_struct *wq;
> > +	struct work_struct wq_work;
> 
> We could use system_freezable_wq instead.
> I do agree a dedicated wq is better since this can get blocked
> for a long time while allocating memory.
> However, please add a comment to this effect.

system_freezable_wq should be fine.  Workqueues by default have a
pretty high maximum concurrency level (256).  There's no reason to
create separate workqueues solely for that purpose.

Thanks.

-- 
tejun
