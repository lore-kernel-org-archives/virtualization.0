From: Tejun Heo <tj@kernel.org>
Subject: Re: virt_blk BUG: sleeping function called from invalid context
Date: Mon, 30 Jun 2014 16:17:41 -0400
Message-ID: <20140630201741.GA20853@htj.dyndns.org>
References: <CA+5PVA4h2hQJLrAm4eEZ8oUgGiAjq2y5eAyBcJWxK_FiQXnuQg@mail.gmail.com>
	<20140629082637.GA23942@redhat.com> <20140629193222.GA7030@lst.de>
	<20140629204710.GB11100@redhat.com> <53B07D48.60003@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <53B07D48.60003@kernel.dk>
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
Cc: Josh Boyer <jwboyer@fedoraproject.org>, "Michael S. Tsirkin" <mst@redhat.com>, John McCutchan <john@johnmccutchan.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Robert Love <rlove@rlove.org>, Eric Paris <eparis@parisplace.org>, Brian Lane <bcl@redhat.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Jun 29, 2014 at 02:55:36PM -0600, Jens Axboe wrote:
> > commit d911d98748018f7c8facc035ba39c30f5cce6f9c
> > Author: Tejun Heo <tj@kernel.org>
> > Date:   Wed Apr 9 11:07:31 2014 -0400
> > 
> >     kernfs: make kernfs_notify() trigger inotify events too
> > 
> > Tejun, what do you think?
> > 
> > Josh, Brian, could you try reverting that commit to see if it helps?
> 
> That definitely be a bug. If you need to block off ->bi_end_io(), just
> must punt to a worker thread.

Ugh... didn't realize we had users triggering sysfs notifications from
an atomic context.  fsnotify support requires sleepable context.
Guess I'll have to punt it to a work item. :(

Thanks.

-- 
tejun
