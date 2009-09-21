From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Extending virtio_console to support multiple ports
Date: Mon, 21 Sep 2009 14:50:45 +0930
Message-ID: <200909211450.47348.rusty__47657.1816289381$1253510513$gmane$org@rustcorp.com.au>
References: <20090826112718.GA11117@amit-x200.redhat.com>
	<20090831161925.GA22928@amit-x200.redhat.com>
	<4A9BFC31.9070005@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A9BFC31.9070005@codemonkey.ws>
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
To: virtualization@lists.linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>, qemu-devel@nongnu.org, Anthony Liguori <anthony@codemonkey.ws>, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 1 Sep 2009 02:07:05 am Anthony Liguori wrote:
> Amit Shah wrote:
> Functionally speaking, both virtio-console and virtio-serial do the same 
> thing.  In fact, virtio-console is just a subset of virtio-serial.
> 
> If there are problems converging the two drivers in Linux, then I 
> suggest you have two separate driver modules in Linux.  That would 
> obviously be rejected for Linux though because you cannot have two 
> drivers for the same device.  Why should qemu have a different policy?

I've been on leave, cheerfully not thinking about this.

AFAICT, a console and serial are very similar, so it makes sense to merge
them.  But a serial port doesn't have framing either; if it does, it's
something else.

And generally using virtio framing in upper layers is a mistake (one we've
made in the qemu implementations, but that's unfortunate).


Thanks,
Rusty.
