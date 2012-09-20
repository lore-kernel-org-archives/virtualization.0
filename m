From: Sjur BRENDELAND <sjur.brandeland@stericsson.com>
Subject: RE: [PATCHv2] virtio_console: Add support for remoteproc serial
Date: Thu, 20 Sep 2012 11:29:27 +0200
Message-ID: <81C3A93C17462B4BBD7E272753C1057923BD6DF285__31799.8607097708$1348134941$gmane$org@EXDCVYMBSTM005.EQ1STM.local>
References: <1348073458-17592-1-git-send-email-sjur.brandeland@stericsson.com>
	<20120920061057.GD5721@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120920061057.GD5721@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Ohad Ben-Cohen <ohad@wizery.com>
Cc: =?iso-8859-1?Q?Sjur_Br=E6ndeland?= <sjurbren@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> sjur.brandeland@stericsson.com wrote:
> > From: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
> >
> > Add a simple serial connection driver called
> > VIRTIO_ID_RPROC_SERIAL (0xB) for communicating with a
> > remote processor in an asymmetric multi-processing
> > configuration.
> >
> > This implementation reuses the existing virtio_console
> > implementation, and adds support for DMA allocation
> > of data buffers and disables use of tty console and
> > the virtio control queue.
> =

> Can't repoteproc work with control queue?
> Reason I ask, there are known races when
> using config space and I was working on
> a spec change that uses control queue for
> all config accesses.

In my case rproc-serial will be used for transferring boot
image or crash-dump to a modem. In these scenarios the
execution environment is very limited (no OS) and  the size
and complexity of the virtio code at the modem should be kept
to a minimum.

The usage pattern in this case is also very simple,
the virtio device is opened only once, and only reopened
after a complete modem cold-start.

So the control queue is not appropriate for my use-case,
simplicity is the most important requirement.
(And currently the virtio config-space is not supported
by remoteproc anyway).

I don't know if other potential users of rproc_serial have more
complex use-cases in mind?

Regards,
Sjur
