From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: console lock up
Date: Thu, 12 Jul 2007 15:06:00 +1000
Message-ID: <1184216761.6005.746.camel@localhost.localdomain>
References: <c5d4ac100707100546j17c67b5bhcd9f36fcf9da9b2@mail.gmail.com>
	<1184153011.6005.614.camel@localhost.localdomain>
	<c5d4ac100707110546n3b26b60ayc4884f91a45517e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <c5d4ac100707110546n3b26b60ayc4884f91a45517e1@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sam Abed <samabed@gmail.com>
Cc: virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-07-11 at 22:46 +1000, Sam Abed wrote:
> 1:1235:respawn:/sbin/mingetty tty0

s/tty0/hvc0/ and it works (we don't have multiple virtual consoles in
lguest)

Sorry for the runaround: I'll update the FAQ.

Thanks!
Rusty.
