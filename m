From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] virtio_console: Use virtio device index to generate port
	name
Date: Mon, 11 Feb 2013 21:24:40 +0530
Message-ID: <20130211155440.GB8319@amit.redhat.com>
References: <1358425397-4584-1-git-send-email-sjur.brandeland@stericsson.com>
	<20130125092008.GC30483@amit.redhat.com>
	<CAJK669aD7S4kxm3fo401v2ni1LubNAB=96aB1uWsd9NmBKjzQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAJK669aD7S4kxm3fo401v2ni1LubNAB=96aB1uWsd9NmBKjzQw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sjur =?iso-8859-1?Q?Br=E6ndeland?= <sjurbren@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Mon) 11 Feb 2013 [14:12:52], Sjur Br=E6ndeland wrote:
> On Fri, Jan 25, 2013 at 10:20 AM, Amit Shah <amit.shah@redhat.com> wrote:
> =

> > On (Thu) 17 Jan 2013 [13:23:17], sjur.brandeland@stericsson.com wrote:
> > > From: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
> > >
> > > Use virtio device index for creating unique device port names.
> > > Current index allocation in virtio is based on a monotonically
> > > increasing variable "index". A better handling of this is to
> > > use device index which is allocated by ida.
> >
> > This should be fine.  I'm wondering, though, if there's something else
> > you need from the naming scheme (esp. considering the next patch)?
> =

> This current patch solves the most critical issue - that the device name
> changes for every modem reboot. This is a show-stopper for me. So it would
> be
> great if this patch could go upstream. The other problem that device name
> is non-deterministic is currently only a theoretical problem as we have
> only one
> remoteproc device.

OK - I've no problem with the patch.

		Amit
