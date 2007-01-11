From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: Oops
Date: Thu, 11 Jan 2007 09:41:45 -0800
Message-ID: <20070111174145.GR10475@sequoia.sous-sol.org>
References: <45A399D7.3090205@suse.de> <45A41B60.3070500@goop.org>
	<45A4A0C7.5050405@suse.de> <45A4C014.9030909@suse.de>
	<45A4E4A0.5060800@suse.de>
	<20070110235232.GE19575@sequoia.sous-sol.org>
	<45A65B7C.6050503@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45A65B7C.6050503@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Gerd Hoffmann <kraxel@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

* Gerd Hoffmann (kraxel@suse.de) wrote:
> Chris Wright wrote:
> > =

> > This should not be needed, the console should be xcv0, completely decou=
pled
> > from serial.
> =

> You've made the whole thing even more complicated with the last commit.
> Enabling VT is possible now.  Good.  No way around that.  The kernel
> hangs now though.  Fix is attached:  better don't try to setup the vga
> console for xen guests which don't have the hardware.

I'm not really sure what, the last commit I did was lhype?

> Next problem:  The default for xencons (tty) conflicts with the virtual
> consoles.  I'm tempted to drop the complete xencons=3Dfoobar stuff into
> the waste basket and leave in xencons=3Dxvc only.  And maybe xencons=3Dof=
f.
>  xencons=3Dtty conflicts with the VT subsystem.  xencons=3DttyS conflicts
> with the serial driver.  Disabling the offending drivers is completely
> out of question for a kernel which is supposed to work both native and
> paravirtualized.

Yes, all of tty ttyS xencons goes away.  Here the default is xvc.

> One more issue:  What should be the default console?  Right now it is
> the vt console (using the dummy device).  Not very good.  vgacon doesn't
> work.  fbcon doesn't work either (yet).  So you'll end up with a
> non-functional console by default.  Bummer.

default console should be xvc in the guest.

thanks,
-chris
