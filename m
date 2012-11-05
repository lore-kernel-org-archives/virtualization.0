From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCHv8 0/3]virtio_console: Add rproc_serial driver
Date: Mon, 5 Nov 2012 11:31:44 +0100
Message-ID: <20121105103144.GB12402@amit.redhat.com>
References: <1351587113-2566-1-git-send-email-sjur@brendeland.net>
	<877gq1yora.fsf@rustcorp.com.au>
	<20121105103124.GA12402@amit.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20121105103124.GA12402@amit.redhat.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Sjur =?iso-8859-1?Q?Br=E6ndeland?= <sjur@brendeland.net>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Sjur =?iso-8859-1?Q?Br=E6ndeland?= <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

On (Mon) 05 Nov 2012 [11:31:24], Amit Shah wrote:
> On (Mon) 05 Nov 2012 [09:11:45], Rusty Russell wrote:
> > Sjur Br=E6ndeland <sjur@brendeland.net> writes:
> > =

> > > From: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
> > >
> > > This patch-set introduces a new virtio type "rproc_serial" for commun=
icating
> > > with remote processors over shared memory. The driver depends on the
> > > the remoteproc framework. As preparation for introducing "rproc_seria=
l"
> > > I've done a refactoring of the transmit buffer handling.
> > >
> > > Changes since v7:
> > > - Rebased to virtio-next branch.
> > > - Removed extra added lines.
> > > - Removed superfluous checks before calling reclaim_dma_bufs().
> > > - Rusty raised some question regarding garbage collection of the
> > >   out-vq, so I moved this into a separate patch.
> > =

> > OK, I'm not sure that WARN_ON won't fire, but that's not all that
> > harmful.
> =

> Sjur said he'll send out a respin for this; can you wait for his v8?

Er, v9.

		Amit
