From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [[PATCH v9 3/3] 1/1] virtio_console: Remove buffers from out_vq
	at port removal
Date: Mon, 10 Dec 2012 11:24:01 +0530
Message-ID: <20121210055401.GA17187@amit.redhat.com>
References: <029d7029bc1186fbd2ec74123dc88922b9600660.1352366215.git.amit.shah@redhat.com>
	<87ip96id3a.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87ip96id3a.fsf@rustcorp.com.au>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, sjur@brendeland.net, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, masami.hiramatsu.pt@hitachi.com, Sjur =?iso-8859-1?Q?Br=E6ndeland?= <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

On (Fri) 16 Nov 2012 [11:22:09], Rusty Russell wrote:
> Amit Shah <amit.shah@redhat.com> writes:
> > From: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
> >
> > Remove buffers from the out-queue when a port is removed. Rproc_serial
> > communicates with remote processors that may crash and leave buffers in
> > the out-queue. The virtio serial ports may have buffers in the out-queue
> > as well, e.g. for non-blocking ports and the host didn't consume them
> > yet.
> >
> > [Amit: Remove WARN_ON for generic ports case.]
> >
> > Signed-off-by: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
> > Signed-off-by: Amit Shah <amit.shah@redhat.com>
> =

> I already have this in my pending queue; I've promoted it to my
> virtio-next branch now.

Rusty, I still see this series in your pending queue, not in
virtio-next.  Did anything change in the meantime?

		Amit
