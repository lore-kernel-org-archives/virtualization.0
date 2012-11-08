From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH resend] virtio_console: Free buffers from out-queue upon
	close
Date: Thu, 8 Nov 2012 09:59:13 +0100
Message-ID: <20121108085913.GA31962@amit.redhat.com>
References: <1350287856-5284-1-git-send-email-sjur.brandeland@stericsson.com>
	<1350287856-5284-5-git-send-email-sjur.brandeland@stericsson.com>
	<878vayhsca.fsf@rustcorp.com.au>
	<20121101073951.GA17012@amit.redhat.com>
	<87r4oc52ov.fsf@rustcorp.com.au>
	<20121102102047.GE10483@amit.redhat.com>
	<81C3A93C17462B4BBD7E272753C1057923BE98E5C6@EXDCVYMBSTM005.EQ1STM.local>
	<1352298171-21869-1-git-send-email-sjur.brandeland@stericsson.com>
	<1352295822-22906-1-git-send-email-sjur.brandeland@stericsson.com>
	<87sj8l2cea.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87sj8l2cea.fsf@rustcorp.com.au>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, sjur@brendeland.net, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, sjur.brandeland@stericsson.com
List-Id: virtualization@lists.linuxfoundation.org

On (Thu) 08 Nov 2012 [10:28:53], Rusty Russell wrote:
> sjur.brandeland@stericsson.com writes:
> =

> > From: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
> >
> > Free pending output buffers from the virtio out-queue when
> > host has acknowledged port_close. Also removed WARN_ON()
> > in remove_port_data().
> >
> > Signed-off-by: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
> > ---
> >
> > Resending, this time including a proper "Subject"...
> > --
> >
> > Hi Amit,
> >
> > Note: This patch is compile tested only. I have done the removal
> > of buffers from out-queue in handle_control_message()
> > when host has acked the close request. This seems less
> > racy than doing it in the release function.
> =

> This confuses me... why are we doing this in case
> VIRTIO_CONSOLE_PORT_OPEN:?
> =

> We can't pull unconsumed buffers out of the ring when the other side may
> still access it, and this seems to be doing that.

Yes -- and it's my fault; I asked Sjur to do that in the close fops
function.

We should only do this in the port remove case (unplug or device
remove) -- so the original patch, with just the WARN_ON removed is the
right way.

I'll send the revised 3/3 patch for you.

		Amit
