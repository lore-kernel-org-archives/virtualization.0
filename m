From: KAIZUKA Hiroyuki <kaizuka@valinux.co.jp>
Subject: Utility tool for dm-ioband.
Date: Thu, 24 Apr 2008 20:55:27 +0900
Message-ID: <4810752F.30205__10346.8466237702$1209038468$gmane$org@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com, xen-devel@lists.xensource.com
Cc: agk@sourceware.org
List-Id: virtualization@lists.linuxfoundation.org

Hi everyone,

I made a utility tool for dm-ioband version 0.0.4, named iobandctl.

It enables you to easily apply I/O bandwidth control to an entire disk,
and manage it. It helps you set the percentage of bandwidth
to give each partition, and each user, process, group, or cgroup.
(You are not able to use cgroup support yet, because the dm-ioband
patch to enable cgroup support (http://lwn.net/Articles/273802/)
is not ported to linux-2.6.25, but it will be soon.)

You can download it and find the manual at
http://people.valinux.co.jp/~kaizuka/dm-ioband/iobandctl/

This is a prototype code.
So, I'd like to hear your requests.
Feature fixed, it is going to be re-written in C.

Thanks,
KAIZUKA Hiroyuki
