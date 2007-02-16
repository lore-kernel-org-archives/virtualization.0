From: Gerd Hoffmann <kraxel@suse.de>
Subject: Re: xen hvc console
Date: Fri, 16 Feb 2007 09:26:01 +0100
Message-ID: <45D56A99.102@suse.de>
References: <45D4E1AB.3020408@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45D4E1AB.3020408@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> I had a quick try to make it work, but no success thus far.  Should it
> be enough to apply the patch and then boot with "console=3D/dev/hvc0"?

Without /dev/, i.e. "console=3Dhvc0".  But, yes, that should be it.  Works
for me.

> Also, why do you comment out the EARLY_PRINTK stuff in Kconfig?

Doesn't compile due to setup_early_printk() being gone.

I also think we don't need early_printk in xen any more.  The hvc
console supports a two-step setup.  One can be done very early at boot
(hvc_instantiate) and one later on, once everything (memory, irqs) is up
and running, during normal device initialization (hvc_alloc).

I'm still playing with it a bit and browse through the console code.
Right now early hvc initialization happens in console_init, I'll try to
do it earlier at boot.

cheers,
  Gerd

-- =

Gerd Hoffmann <kraxel@suse.de>
