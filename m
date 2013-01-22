From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC] virtio_console: Add DRIVER and INTERFACE to uevent.
Date: Tue, 22 Jan 2013 08:16:47 -0800
Message-ID: <20130122161647.GA10600@kroah.com>
References: <1358425438-4633-1-git-send-email-sjur.brandeland@stericsson.com>
	<87pq0yw23j.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87pq0yw23j.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, sjur.brandeland@stericsson.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 22, 2013 at 09:55:20AM +1030, Rusty Russell wrote:
> sjur.brandeland@stericsson.com writes:
> =

> > From: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
> >
> > Add information so rproc-serial can be easily recogniced
> > from user space. Add the following information to uevent:
> > DRIVER=3Dvirtio_console|virtio_rproc_serial
> > INTERFACE=3Dgrand-parent/parent/name
> >
> > Signed-off-by: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
> > ---
> > Hi,
> >
> > I need some way to identify the major/minor number for
> > the rproc-serial device, given the udev event. =

> > Review comments are welcomed.
> >
> > Thanks,
> > Sjur
> =

> Hmm, I send all uevent questions to Greg KH (CC'd).

The "INTERFACE" uevent variable is only for USB devices, so for anything
else to be sending userspace that variable, would confuse things
greatly.

Sjur, what exactly are you trying to do here?  What do you want
userspace to know, and what should it do with that information?

thanks,

greg k-h
