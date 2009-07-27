From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: virtio-serial: An interface for host-guest communication
Date: Mon, 27 Jul 2009 15:22:54 -0500
Message-ID: <4A6E0C9E.10908__34696.5008684949$1248726278$gmane$org@codemonkey.ws>
References: <1248717876-17630-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1248717876-17630-1-git-send-email-amit.shah@redhat.com>
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
> Hello all,
>
> This are the latest version of the patches.
>
> Lots of things have changed since the last submission. A few of
> which I remember:
> - VNC copy / paste works* (* conditions apply)
>   - client vnc copies get propagated to guest port 3 (/dev/vmch3)
>   - guest writes to port 3 (/dev/vmch3) go straight to client's clipboard
>   

Why 3?

Where's the guest application that drives the copy/paste?

I expect the first problem you'll run into is that copy/paste daemon has 
to run as an unprivileged user but /dev/vmch3 is going to be owned by 
root.  You could set udev rules for /dev/vmch3 but that's pretty 
terrible IMHO.

I think you'll find that you need a root daemon that talks to vmchannel 
and then allows unprivileged connections over a unix socket device.  In 
that case, why even bother having multiple channels since your daemon 
can multiplex..

Regards,

Anthony Liguori
