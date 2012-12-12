From: Sjur BRENDELAND <sjur.brandeland@stericsson.com>
Subject: RE: [[PATCH v9 3/3] 1/1] virtio_console: Remove buffers from out_vq
	at port removal
Date: Wed, 12 Dec 2012 13:31:46 +0100
Message-ID: <81C3A93C17462B4BBD7E272753C10579245758FC94@EXDCVYMBSTM005.EQ1STM.local>
References: <029d7029bc1186fbd2ec74123dc88922b9600660.1352366215.git.amit.shah@redhat.com>
	<87ip96id3a.fsf@rustcorp.com.au>
	<20121210055401.GA17187@amit.redhat.com>
	<871uexec7e.fsf@rustcorp.com.au>
	<20121211041012.GA16297@amit.redhat.com>
	<87wqwo3zr3.fsf@rustcorp.com.au>
	<20121212121228.GA22521@amit.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121212121228.GA22521@amit.redhat.com>
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
To: Amit Shah <amit.shah@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "sjur@brendeland.net" <sjur@brendeland.net>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "masami.hiramatsu.pt@hitachi.com" <masami.hiramatsu.pt@hitachi.com>
List-Id: virtualization@lists.linuxfoundation.org

> Amit Shah [mailto:amit.shah@redhat.com] writes:
> On (Wed) 12 Dec 2012 [10:31:04], Rusty Russell wrote:
> > Amit Shah <amit.shah@redhat.com> writes:
> > > On (Tue) 11 Dec 2012 [09:39:41], Rusty Russell wrote:
> > >> Amit Shah <amit.shah@redhat.com> writes:
> > >> > On (Fri) 16 Nov 2012 [11:22:09], Rusty Russell wrote:
> > >> >> Amit Shah <amit.shah@redhat.com> writes:
> > >> >> > From: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>
> > >> >> >
> > >> >> > Remove buffers from the out-queue when a port is removed.
> Rproc_serial
> > >> >> > communicates with remote processors that may crash and leave
> buffers in
> > >> >> > the out-queue. The virtio serial ports may have buffers in the =
out-
> queue
> > >> >> > as well, e.g. for non-blocking ports and the host didn't consume
> them
> > >> >> > yet.
> > >> >> >
> > >> >> > [Amit: Remove WARN_ON for generic ports case.]
> > >> >> >
> > >> >> > Signed-off-by: Sjur Br=E6ndeland
> <sjur.brandeland@stericsson.com>
> > >> >> > Signed-off-by: Amit Shah <amit.shah@redhat.com>
> > >> >>
> > >> >> I already have this in my pending queue; I've promoted it to my
> > >> >> virtio-next branch now.
> > >> >
> > >> > Rusty, I still see this series in your pending queue, not in
> > >> > virtio-next.  Did anything change in the meantime?
> > >>
> > >> Hmm:
> > >>
> > >> 40e625ac50f40d87ddba93280d0a503425aa68e9?
> > >
> > > I'm sorry, I meant the remoteproc code, not this patch.
> >
> > Still waiting for v9, AFIACT?
> =

> Instead of sending all patches marked v9, just this patch was
> re-spun.  I think you can just pick up patches 1 and 2 from v8 (they
> have my acked-by), and patch 3 was an earlier version of this one,

Yes, that's right. V8 contained three patches, Amit did a respin of 3/3 tha=
t was applied.
(And I mistakenly thought 1/3 and 2/3 was applied as well). =


Anyway I'm resending a new patch-set with the two missing patches.
The patches are identical to the V8, but are rebased to the virtio-next bra=
nch.

Sorry for the confusion here.

Regards,
Sjur
