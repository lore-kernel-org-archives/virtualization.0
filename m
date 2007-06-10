From: Avi Kivity <avi@qumranet.com>
Subject: More virtio users
Date: Sun, 10 Jun 2007 10:33:57 +0300
Message-ID: <466BA965.6050208__36933.0086665743$1181460953$gmane$org@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, xen-devel <xen-devel@lists.xensource.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

It is worthwhile, when designing virtio, to keep in mind as many 
possible users as possible.  In addition to block and net, I see at 
least the following:

- vmgl (paravirtualized 3D graphics) 
[http://www.cs.toronto.edu/~andreslc/xen-gl/]
- scsi (for tape, cd writer, etc.)
- framebuffer (with just one request to share the framebuffer?)

There are probably more.  Any ideas?

-- 
error compiling committee.c: too many arguments to function
