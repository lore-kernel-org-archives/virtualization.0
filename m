From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: Multicast and receive filtering in TUN/TAP
Date: Thu, 10 Jul 2008 22:23:40 +0200
Message-ID: <200807102223.40717.borntraeger__20608.7323640988$1215721683$gmane$org@de.ibm.com>
References: <4875428F.4080704@qualcomm.com>
	<200807101029.17121.borntraeger@de.ibm.com>
	<48763F94.7050507@qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48763F94.7050507@qualcomm.com>
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
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: netdev@vger.kernel.org, Brian Braunstein <linuxkernel@bristyle.com>, Shaun Jackman <sjackman@gmail.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Donnerstag, 10. Juli 2008 schrieb Max Krasnyansky:
> > Thing is, we are heading towards virtio. 
> Even for Windows ?

Its possible:
http://marc.info/?l=kvm&m=121075389300722&w=2

> 
> > Unfortunately, virtio_net currently  does not offer a method to register 
multicast addresses.
> I haven't looked at the virtio stuff much, I was assuming that the host side
> of it is still the TUN driver. Is it not ?

Yes, the host side is still tun/tap. The problem is that qemu doesnt know 
which multicast addresses are used inside the guest.
