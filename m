From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 2/2] virtio_balloon: Use a workqueue instead of
	"vballoon" kthread
Date: Sun, 3 Jan 2016 08:58:39 -0500
Message-ID: <20160103135839.GF3660@htj.duckdns.org>
References: <1449236271-10133-1-git-send-email-pmladek@suse.com>
	<1449236271-10133-3-git-send-email-pmladek@suse.com>
	<20160101121432-mutt-send-email-mst@redhat.com>
	<20160102114316.GC3660@htj.duckdns.org>
	<20160102213603.GA1703@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160102213603.GA1703@redhat.com>
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
Cc: Petr Mladek <pmladek@suse.com>, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.cz>, virtualization@lists.linux-foundation.org, Jeff Epler <jepler@unpythonic.net>
List-Id: virtualization@lists.linuxfoundation.org

Hello, Michael.

On Sat, Jan 02, 2016 at 11:36:03PM +0200, Michael S. Tsirkin wrote:
> > Why so?  As long as the maximum concurrently used workers are not
> > high, 1/5 second or even a lot longer sleeps are completely fine.
> 
> I always thought the right way to defer executing a work queue item
> is to queue delayed work, not sleep + queue work.

That works too and is preferable if there are gonna be a lot of work
items sleeping but it isn't different from any other blocking.

> Doing a sleep ties up one thread for 1/5 of a second, does it not?

It does.

> If so, as long as it's the only driver doing this, we'll be fine,
> but if many others copy this pattern, things will
> start to break, will they not?

The maximum concurrency on the system_wq is 256 which is pretty high,
so for most use cases, it's fine.  If high concurrency is expected,
it's better to break it out to a separate workqueue.

Thanks.

-- 
tejun
