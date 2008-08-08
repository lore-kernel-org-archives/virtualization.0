From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>
Subject: Re: RFC: I/O bandwidth controller
Date: Fri, 08 Aug 2008 17:10:56 +0900
Message-ID: <1218183056.17648.6.camel__31875.0027021908$1218183479$gmane$org@sebastian.kern.oss.ntt.co.jp>
References: <1217870433.20260.101.camel@nimitz>
	<1217985189.3154.57.camel@sebastian.kern.oss.ntt.co.jp>
	<20080808.152119.43521725.taka@valinux.co.jp>
	<20080808.162024.189720323.ryov@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080808.162024.189720323.ryov@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ryo Tsuruta <ryov@valinux.co.jp>
Cc: xen-devel@lists.xensource.com, uchida@ap.jp.nec.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, dave@linux.vnet.ibm.com, taka@valinux.co.jp, dm-devel@redhat.com, agk@sourceware.org, virtualization@lists.linux-foundation.org, ngupta@google.com, righi.andrea@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2008-08-08 at 16:20 +0900, Ryo Tsuruta wrote:
> > >   - Implement a block layer resource controller. dm-ioband is a working
> > > solution and feature rich but its dependency on the dm infrastructure is
> > > likely to find opposition (the dm layer does not handle barriers
> > > properly and the maximum size of I/O requests can be limited in some
> > > cases). In such a case, we could either try to build a standalone
> > > resource controller based on dm-ioband (which would probably hook into
> > > generic_make_request) or try to come up with something new.
> > 
> > I doubt about the maximum size of I/O requests problem. You can't avoid
> > this problem as far as you use device mapper modules with such a bad
> > manner, even if the controller is implemented as a stand-alone controller.
> > There is no limitation if you only use dm-ioband without any other device
> > mapper modules.
> 
> The following is a part of source code where the limitation comes from.
> 
> dm-table.c: dm_set_device_limits()
>         /*
>          * Check if merge fn is supported.
>          * If not we'll force DM to use PAGE_SIZE or
>          * smaller I/O, just to be safe.
>          */
> 
>         if (q->merge_bvec_fn && !ti->type->merge)
>                 rs->max_sectors =
>                         min_not_zero(rs->max_sectors,
>                                      (unsigned int) (PAGE_SIZE >> 9));
> 
> As far as I can find, In 2.6.27-rc1-mm1, Only some software RAID
> drivers and pktcdvd driver define merge_bvec_fn().

Yup, exactly. The implication of this is that we may see a drop in
performance in some RAID configurations.
