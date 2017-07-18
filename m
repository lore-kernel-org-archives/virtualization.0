From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1] virtio_blk: Use sysfs_match_string() helper
Date: Tue, 18 Jul 2017 19:25:11 +0300
Message-ID: <20170718192323-mutt-send-email-mst@kernel.org>
References: <20170609120742.21959-1-andriy.shevchenko@linux.intel.com>
	<1499083530.22624.239.camel@linux.intel.com>
	<20170703193730-mutt-send-email-mst@kernel.org>
	<1500392812.29303.82.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1500392812.29303.82.camel@linux.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jens Axboe <axboe@fb.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 18, 2017 at 06:46:52PM +0300, Andy Shevchenko wrote:
> On Mon, 2017-07-03 at 19:37 +0300, Michael S. Tsirkin wrote:
> > On Mon, Jul 03, 2017 at 03:05:30PM +0300, Andy Shevchenko wrote:
> > > On Fri, 2017-06-09 at 15:07 +0300, Andy Shevchenko wrote:
> > > > Use sysfs_match_string() helper instead of open coded variant.
> > > 
> > > Did I miss maintainer?
> > > 
> > You didn't, I'll merge this in the next PULL.
> 
> I didn't see this in v4.13-rc1. Shall I resend?

Thanks for the patch and sorry about a delay.

It's because I didn't send a pull - this cycle is so quiet, that is the
single patch I have. I was hoping for the balloon free page hint patches
to get there but it does not look like that is happening soon. I'll
merge it you do not need to resend.

> -- 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
