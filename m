From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 10/10] virtio: console: Add support for nonblocking
	write()s
Date: Tue, 6 Apr 2010 12:42:58 +0930
Message-ID: <201004061242.58840.rusty@rustcorp.com.au>
References: <1270475654-399-1-git-send-email-amit.shah@redhat.com>
	<1270475654-399-10-git-send-email-amit.shah@redhat.com>
	<1270475654-399-11-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1270475654-399-11-git-send-email-amit.shah@redhat.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 5 Apr 2010 11:24:14 pm Amit Shah wrote:
> If the host port is not open, a write() should either just return if the
> file is opened in non-blocking mode, or block till the host port is
> opened.
> 
> Also, don't spin till host consumes data for nonblocking ports. For
> non-blocking ports, we can do away with the spinning and reclaim the
> buffers consumed by the host on the next write call or on the condition
> that'll make poll return.

I'm only reading the patch so I might have missed it, but what's the
locking going on here?

Can we race thinking we're full or not full incorrectly?

But the basic approach of this series seems good!

Thanks,
Rusty.
