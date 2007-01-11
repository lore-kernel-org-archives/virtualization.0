From: Gerd Hoffmann <kraxel@suse.de>
Subject: Re: Oops
Date: Thu, 11 Jan 2007 09:13:29 +0100
Message-ID: <45A5F1A9.9080901@suse.de>
References: <45A399D7.3090205@suse.de>
	<45A41B60.3070500@goop.org>	<45A4A0C7.5050405@suse.de>
	<45A4C014.9030909@suse.de>	<45A4E4A0.5060800@suse.de>
	<20070110235232.GE19575@sequoia.sous-sol.org>
	<45A57C76.4080103@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45A57C76.4080103@goop.org>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

> If you compile in serial console, does it try to
> do its thing even if there aren't any real serial ports?

Yes (otherwise the issue wouldn't show up in xen domUs).

cheers,
  Gerd

-- =

Gerd Hoffmann <kraxel@suse.de>
