From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for host-guest
	communication
Date: Mon, 27 Jul 2009 18:44:28 -0500
Message-ID: <4A6E3BDC.8050101__30576.2729062282$1248738688$gmane$org@codemonkey.ws>
References: <1248717876-17630-1-git-send-email-amit.shah@redhat.com>
	<4A6E0C9E.10908@codemonkey.ws> <20090727203214.GG15020@redhat.com>
	<20090727204627.GA32432@shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090727204627.GA32432@shareable.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jamie Lokier <jamie@shareable.org>
Cc: Amit Shah <amit.shah@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Jamie Lokier wrote:
> With multiple X servers, there can be more than one currently logged in user.
>
> Same with multiple text consoles - that's more familiar.
>
> Which one owns /dev/vmch3?
>   

For a VMM, copy/paste should work with whatever user has the active X 
session that's controlling the physical display.

Yes, it could get complicated if we supported multiple video cards, but 
fortunately we don't :-)

I really think you need to have a copy/paste daemon that allows multiple 
X sessions to connect to it and then that daemon can somehow determine 
who is the "active" session.

This is part of the reason I've been pushing for a concrete example.  
All the signs here point to a privileged daemon that delegates to 
multiple users.  I think just about any use-case will have a similar model.

It really suggests that you need _one_ vmchannel that's exposed to 
userspace with a single userspace daemon that consumes it.  You want the 
flexibility of a userspace daemon in determining how you multiplex and 
do security.  I don't think it's something you want to bake into the 
userspace/kernel interface.

And if you have a single daemon that serves vmchannel sessions, that 
daemon can make it transparent whether the session is going over 
/dev/ttyS0, a network device, /dev/hvc1, etc.

Regards,

Anthony Liguori
