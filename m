From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Re: [PATCH] vhost-net: add module alias
Date: Wed, 11 Jan 2012 08:54:26 -0800
Message-ID: <20120111085426.1c1ec3bf__25386.7957894274$1326300888$gmane$org@nehalam.linuxnetplumber.net>
References: <20120110205400.6c1cb306@nehalam.linuxnetplumber.net>
	<CAFeW=paA4Aqk2gy2qpUUM6nANjr3ahio3N02Tz4LVEGVVxNJWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAFeW=paA4Aqk2gy2qpUUM6nANjr3ahio3N02Tz4LVEGVVxNJWA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amos Kong <kongjianjun@gmail.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, device@lanana.org, alan@linux.intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 11 Jan 2012 15:43:42 +0800
Amos Kong <kongjianjun@gmail.com> wrote:

> On Wed, Jan 11, 2012 at 12:54 PM, Stephen Hemminger
> <shemminger@vyatta.com>wrote:
> 
> > By adding the a module alias, programs (or users) won't have to explicitly
> > call modprobe. Vhost-net will always be available if built into the kernel.
> > It does require assigning a permanent minor number for depmod to work.
> > Choose one next to TUN since this driver is related to it.
> >
> > Also, use C99 style initialization.
> >
> > Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
> >
> > ---
> >  drivers/vhost/net.c        |    8 +++++---
> >  include/linux/miscdevice.h |    1 +
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> >
:
> /*
>  *      These allocations are managed by device@lanana.org. If you use an
>  *      entry that is not in assigned your entry may well be moved and
>  *      reassigned, or set dynamic if a fixed value is not justified.
>  */

Didn't that mailing address was ever used any more. Like many places
in kernel, the comment looked like a historical leftover.
