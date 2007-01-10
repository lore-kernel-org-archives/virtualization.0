From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Oops
Date: Wed, 10 Jan 2007 15:53:26 -0800
Message-ID: <45A57C76.4080103@goop.org>
References: <45A399D7.3090205@suse.de>
	<45A41B60.3070500@goop.org>	<45A4A0C7.5050405@suse.de>
	<45A4C014.9030909@suse.de>	<45A4E4A0.5060800@suse.de>
	<20070110235232.GE19575@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070110235232.GE19575@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Chris Wright wrote:
> This should not be needed, the console should be xcv0, completely decoupl=
ed
> from serial.

Isn't it just a matter of what gets used by default without a
command-line option?  If you compile in serial console, does it try to
do its thing even if there aren't any real serial ports?

    J
