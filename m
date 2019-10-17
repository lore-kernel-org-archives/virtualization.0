From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RFC 3/3] vhost, kcov: collect coverage from vhost_worker
Date: Thu, 17 Oct 2019 13:28:43 -0700
Message-ID: <20191017202843.GA1103978@kroah.com>
References: <cover.1571333592.git.andreyknvl@google.com>
	<af26317c0efd412dd660e81d548a173942f8a0ad.1571333592.git.andreyknvl@google.com>
	<20191017181800.GB1094415@kroah.com>
	<CAAeHK+yS24KnecLyhnPEHx-dOSk3cvVHhtGHe+9Uf2d96+ZqjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAAeHK+yS24KnecLyhnPEHx-dOSk3cvVHhtGHe+9Uf2d96+ZqjQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, netdev <netdev@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, Elena Reshetova <elena.reshetova@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, David Windsor <dwindsor@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 17, 2019 at 09:00:18PM +0200, Andrey Konovalov wrote:
> On Thu, Oct 17, 2019 at 8:18 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Oct 17, 2019 at 07:44:15PM +0200, Andrey Konovalov wrote:
> > > This patch adds kcov_remote_start/kcov_remote_stop annotations to the
> > > vhost_worker function, which is responsible for processing vhost works.
> > > Since vhost_worker is spawned when a vhost device instance is created,
> > > the common kcov handle is used for kcov_remote_start/stop annotations.
> > >
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > ---
> > >  drivers/vhost/vhost.c | 15 +++++++++++++++
> > >  drivers/vhost/vhost.h |  3 +++
> > >  2 files changed, 18 insertions(+)
> > >
> > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > index 36ca2cf419bf..71a349f6b352 100644
> > > --- a/drivers/vhost/vhost.c
> > > +++ b/drivers/vhost/vhost.c
> > > @@ -357,7 +357,13 @@ static int vhost_worker(void *data)
> > >               llist_for_each_entry_safe(work, work_next, node, node) {
> > >                       clear_bit(VHOST_WORK_QUEUED, &work->flags);
> > >                       __set_current_state(TASK_RUNNING);
> > > +#ifdef CONFIG_KCOV
> > > +                     kcov_remote_start(dev->kcov_handle);
> > > +#endif
> >
> > Shouldn't you hide these #ifdefs in a .h file?  This is not a "normal"
> > kernel coding style at all.
> 
> Well, if it's acceptable to add a kcov_handle field into vhost_dev
> even when CONFIG_KCOV is not enabled, then we can get rid of those
> #ifdefs.

It should be, it's not a big deal and there's not a ton of those
structures around that one more field is going to hurt anything...

thanks,

greg k-h
