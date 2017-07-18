From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] virtio_blk: Use sysfs_match_string() helper
Date: Tue, 18 Jul 2017 18:46:52 +0300
Message-ID: <1500392812.29303.82.camel@linux.intel.com>
References: <20170609120742.21959-1-andriy.shevchenko@linux.intel.com>
	<1499083530.22624.239.camel@linux.intel.com>
	<20170703193730-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170703193730-mutt-send-email-mst@kernel.org>
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
Cc: Jens Axboe <axboe@fb.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2017-07-03 at 19:37 +0300, Michael S. Tsirkin wrote:
> On Mon, Jul 03, 2017 at 03:05:30PM +0300, Andy Shevchenko wrote:
> > On Fri, 2017-06-09 at 15:07 +0300, Andy Shevchenko wrote:
> > > Use sysfs_match_string() helper instead of open coded variant.
> > 
> > Did I miss maintainer?
> > 
> You didn't, I'll merge this in the next PULL.

I didn't see this in v4.13-rc1. Shall I resend?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
