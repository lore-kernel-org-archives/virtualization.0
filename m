From: Gerd Hoffmann <kraxel@suse.de>
Subject: [rfc/patch] use hvc for xen console
Date: Tue, 13 Feb 2007 11:36:14 +0100
Message-ID: <45D1949E.1000809@suse.de>
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
To: Virtualization Mailing List <virtualization@lists.osdl.org>, Xen devel list <xen-devel@lists.xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

Here is a patch (on top of the paravirt patch queue) which makes xen
guests use the hvc_console.c infrastructure for the console, thereby
greatly reducing the amount console code.  xvc0 is gone too, hvc0 is
used instead.

cheers,
  Gerd

-- =

Gerd Hoffmann <kraxel@suse.de>
