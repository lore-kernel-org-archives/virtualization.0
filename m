From: Gerd Hoffmann <kraxel@suse.de>
Subject: more build errors ...
Date: Tue, 09 Jan 2007 12:25:56 +0100
Message-ID: <45A37BC4.6060303@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

Get these now:

this one with non-pae builds:

  arch/i386/kernel/built-in.o: In function `APIC_init_uniprocessor':
  (.init.text+0x6357): undefined reference to `setup_boot_clock'

this on both pae and non-pae (CONFIG_MAGIC_SYSRQ=3Dy):

  drivers/built-in.o: In function `xencons_rx':
  (.text+0x17f09): undefined reference to `sysrq_enabled'

cheers,
  Gerd

-- =

Gerd Hoffmann <kraxel@suse.de>
