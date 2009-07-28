From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for host-guest
	communication
Date: Tue, 28 Jul 2009 08:42:32 -0500
Message-ID: <4A6F0048.1000103__30859.2872032479$1248788642$gmane$org@codemonkey.ws>
References: <1248717876-17630-1-git-send-email-amit.shah@redhat.com>
	<4A6E0C9E.10908@codemonkey.ws> <20090727203214.GG15020@redhat.com>
	<20090727204627.GA32432@shareable.org>
	<4A6E3BDC.8050101@codemonkey.ws>
	<20090728103624.GA5176@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090728103624.GA5176@amit-x200.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Jamie Lokier <jamie@shareable.org>, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah wrote:
> Right; use virtio just as the transport and all the interesting
> activity happens in userspaces. That was the basis with which I started.
> I can imagine dbus doing the copy/paste, lock screen, etc. actions.
>
> However for libguestfs, dbus isn't an option and they already have some
> predefined agents for each port. So libguestfs is an example for a
> multi-port usecase for virtio-serial.
>   

Or don't use dbus and use something that libguestfs is able to embed.  
The fact that libguestfs doesn't want dbus in the guest is not an 
argument for using a higher level kernel interface especially one that 
doesn't meet the requirements of the interface.

Regards,

Anthony Liguori
