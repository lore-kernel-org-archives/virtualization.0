From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Host<->guest channel interface advice needed
Date: Wed, 26 Nov 2008 14:02:57 +0100
Message-ID: <200811261402.58033.arnd__17563.6068256155$1227704828$gmane$org@arndb.de>
References: <20081126123919.GC3521@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081126123919.GC3521@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 26 November 2008, Gleb Natapov wrote:
> The interfaces that are being considered are netlink socket (only datagram
> semantics, linux specific), new socket family or character device with
> different minor number for each channel. Which one better suits for
> the purpose? =A0Is there other kind of interface to consider? New socket
> family looks like a good choice, but it would be nice to hear other
> opinions before starting to work on it.

I think a socket and a pty both look reasonable here, but one important
aspect IMHO is that you only need a new kernel driver for the guest, if
you just use the regular pty support or Unix domain sockets in the host.

Obviously, there needs to be some control over permissions, as a guest
most not be able to just open any socket or pty of the host, so a
reasonable approach might be that the guest can only create a socket
or pty that can be opened by the host, but not vice versa. Alternatively,
you create the socket/pty in host userspace and then allow passing that
down into the guest, which creates a virtio device from it.

	Arnd <><
