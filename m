From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: vhost_net_ioctl
Date: Wed, 6 Oct 2010 11:33:38 +0100
Message-ID: <AANLkTikMK3fsoY5urLEoOT7XEj+03x2qMNO_h2EmSJFD@mail.gmail.com>
References: <AANLkTimzGqmS=YOsJjdM_-d1sJDd4w1t2Cyjk57xrQZo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimzGqmS=YOsJjdM_-d1sJDd4w1t2Cyjk57xrQZo@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: devi thapa <devi.thapa@gmail.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 6, 2010 at 11:16 AM, devi thapa <devi.thapa@gmail.com> wrote:
> =A0 =A0 =A0 =A0 =A0 What's the role or value of the third argument in the
> vhost_net_ioctl function in /drivers/vhost/net.c .

Read the code.  There is the kernel vhost code and the QEMU vhost
userspace code to look at.  By studying both sides you can figure this
out.

Look at how arg is used in vhost_net_ioctl().

Please spend more time learning how things work before sending
questions to the mailing list.

Stefan
