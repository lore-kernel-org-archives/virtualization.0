From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: lhype booting debootstrapped debian image over nfsroot,
	partial success
Date: Wed, 10 Jan 2007 20:51:43 +1100
Message-ID: <1168422703.19646.181.camel@localhost.localdomain>
References: <20070107224644.GA1521@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070107224644.GA1521@outpost.ds9a.nl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: bert hubert <bert.hubert@netherlabs.nl>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2007-01-07 at 23:46 +0100, bert hubert wrote:
> However, TCP/IP was working, so I installed an ssh server so I could log =
in
> over the network, but no dice:
> Starting OpenBSD Secure Shell server: sshdPRNG is not seeded

OK, this is now fixed: I was making a mess of the FPU.  That also caused
the "nan" in "uptime" and fast dd's.

The goodness is in 633a4a692d44 and later.

Thanks for the interesting bug report!
Rusty.
