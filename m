From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Why is virtio_console not a tty?
Date: Thu, 12 Jun 2014 12:32:31 -0700
Message-ID: <539A004F.20906@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Amit Shah <amit.shah@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org

I have gotten scattered reports of strange problems caused by the fact
that virtio_console doesn't behave like a normal tty (support termios
and so on.)  This seems to be an odd restriction -- is there any
fundamental reason for this design choice?

	-hpa
