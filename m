From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: Extending virtio_console to support multiple ports
Date: Sun, 30 Aug 2009 07:48:37 -0500
Message-ID: <4A9A7525.6010707__31672.5879711614$1251636654$gmane$org@codemonkey.ws>
References: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
	<20090826112718.GA11117@amit-x200.redhat.com>
	<4A980D18.30106@codemonkey.ws>
	<20090830101057.GB32563@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090830101057.GB32563@amit-x200.redhat.com>
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah wrote:
> I did think about that as well, but there are problems:
>
> - vnc clients (at least tigervnc) wants to receive the entire clipboard
>   in a single flush command. So in the pre-allocated buffers scenario we
>   could run short of the available buffers in some cases. So there will
>   have to be a flag with each buffer that says 'there's more data
>   pending for this particular write' which will have to be passed on to
>   qemu and qemu will then flush it once it receives all the data
>   

No flags, assume it's a streaming protocol and don't assume anything 
about message sizes.  IOW, when you send clipboard data, send size and 
then the data.  QEMU consumes bytes until it reaches size.

> - A lock has to be introduced to fetch one unused buffer from the list
>   and pass it on to the host. And this lock has to be a spinlock, just
>   because writes can be called from irq context.
>   

I don't see a problem here.

Regards,

Anthony Liguori

> 		Amit
>   
