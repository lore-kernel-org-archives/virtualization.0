From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for host-guest
	communication
Date: Thu, 06 Aug 2009 08:29:40 -0500
Message-ID: <4A7ADAC4.70902__8439.98117275096$1249565648$gmane$org@codemonkey.ws>
References: <1248717876-17630-1-git-send-email-amit.shah@redhat.com>
	<4A6E0C9E.10908@codemonkey.ws> <20090727203214.GG15020@redhat.com>
	<20090727204627.GA32432@shareable.org>
	<4A6E3BDC.8050101@codemonkey.ws>
	<20090728140029.GA16067@amd.home.annexia.org>
	<4A77410D.4090804@codemonkey.ws>
	<20090805175713.GB28738@shareable.org>
	<4A79C8D9.5030606@codemonkey.ws>
	<20090806103843.GC9222@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090806103843.GC9222@amit-x200.redhat.com>
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
Cc: kvm@vger.kernel.org, Jamie Lokier <jamie@shareable.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah wrote:
> Sure; but there's been no resistance from anyone from including the
> virtio-serial device driver so maybe we don't need to discuss that.
>   

There certainly is from me.  The userspace interface is not reasonable 
for guest applications to use.

Regards,

Anthony Liguori

> 		Amit
>   
