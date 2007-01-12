From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Oops
Date: Fri, 12 Jan 2007 13:53:56 +1100
Message-ID: <1168570436.31891.16.camel@localhost.localdomain>
References: <45A399D7.3090205@suse.de> <45A41B60.3070500@goop.org>
	<45A4A0C7.5050405@suse.de> <45A4C014.9030909@suse.de>
	<45A4E4A0.5060800@suse.de>
	<20070110235232.GE19575@sequoia.sous-sol.org>
	<45A65B7C.6050503@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
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

On Thu, 2007-01-11 at 16:45 +0100, Gerd Hoffmann wrote:
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

lguest (lhype) does the following:

	/* FIXME: Better way? */
	/* Suppress vgacon startup code */
	SCREEN_INFO.orig_video_isVGA =3D VIDEO_TYPE_VLFB;

So I'd prefer a generic way of disabling the VGA stuff...

Thanks,
Rusty.
