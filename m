From: Gerd Hoffmann <kraxel@suse.de>
Subject: Re: Oops
Date: Wed, 10 Jan 2007 14:05:36 +0100
Message-ID: <45A4E4A0.5060800@suse.de>
References: <45A399D7.3090205@suse.de> <45A41B60.3070500@goop.org>
	<45A4A0C7.5050405@suse.de> <45A4C014.9030909@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45A4C014.9030909@suse.de>
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
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Gerd Hoffmann wrote:
> OK, now I'm back to the old buggy state where the ttylinux rootfs fails
> to boot up due to init being killed instantly or something like that ...

That was something completely different.  Machine booted up just fine,
but without any output.  Due to initialization in link order and xen/
coming after serial/ in drivers/ the serial console becomes default when
enabled.  Ouch.  Move it up.

--- paravirt-2.6.20-rc4-hg691.orig/drivers/Makefile
+++ paravirt-2.6.20-rc4-hg691/drivers/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_ARM_AMBA)                +=3D amba/
 # char/ comes before serial/ etc so that the VT console is the boot-time
 # default.
 obj-y                          +=3D char/
+obj-$(CONFIG_XEN)              +=3D xen/

 obj-$(CONFIG_CONNECTOR)                +=3D connector/

@@ -31,7 +32,6 @@ obj-y                         +=3D base/ block/ misc/
mfd/ net/
 obj-$(CONFIG_NUBUS)            +=3D nubus/
 obj-$(CONFIG_ATM)              +=3D atm/
 obj-$(CONFIG_PPC_PMAC)         +=3D macintosh/
-obj-$(CONFIG_XEN)              +=3D xen/
 obj-$(CONFIG_IDE)              +=3D ide/
 obj-$(CONFIG_FC4)              +=3D fc4/
 obj-$(CONFIG_SCSI)             +=3D scsi/

cheers,
  Gerd

-- =

Gerd Hoffmann <kraxel@suse.de>
