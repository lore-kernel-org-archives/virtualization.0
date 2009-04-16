From: Ryo Tsuruta <ryov@valinux.co.jp>
Subject: [PATCH 1/5] bio-cgroup: Introduction
Date: Thu, 16 Apr 2009 21:28:36 +0900 (JST)
Message-ID: <20090416.212836.226792104.ryov__6672.41012347421$1239885327$gmane$org@valinux.co.jp>
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
To: linux-kernel@vger.kernel.org, dm-devel@redhat.com, containers@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Hi all,

This is a new release of bio-cgroup which provides an IO tracking
mechanism. The patches can be applied to the kernel 2.6.30-rc1 and you
can also download them from the following site.
http://people.valinux.co.jp/~ryov/bio-cgroup/

What's bio-cgroup all about?
============================

With this feature, you can determine the owners of any type of
I/Os. This makes dm-ioband_--_I/O_bandwidth_controller_-- be able to
control the Block I/O bandwidths even when it accepts delayed write
requests. Dm-ioband can find the owner cgroup of each request. It is
also possible that the other people who work on the i/o bandwidth
throttling use this functionality to control asynchronous I/Os with a
little enhancement.

Setting up bio-cgroup
=====================

You have to apply the patch dm-ioband_v1.9.0 before applying this
series of bio-cgroup patches.
And you have to select the following config options when compiling
kernel.

      CONFIG_CGROUPS=y
      CONFIG_CGROUP_BIO=y

And I recommend you should also select the options for cgroup memory
subsystem, because it makes it possible to give some I/O bandwidth and
some memory to a certain cgroup to control delayed write requests and
the processes in the cgroup will be able to make pages dirty only
inside the cgroup even when the given bandwidth is narrow.

      CONFIG_RESOURCE_COUNTERS=y
      CONFIG_CGROUP_MEM_RES_CTLR=y

Using bio-cgroup
================

The following shows how to use dm-ioband with cgroups. Please assume
that you want make two cgroups, which we call "bio cgroup" here, to
track down block I/Os and assign them to ioband device "ioband1".

First, mount the bio cgroup filesystem.

      # mount -t cgroup -o bio none /cgroup/bio

Then, make new bio cgroups and put some processes in them.

      # mkdir /cgroup/bio/bgroup1
      # mkdir /cgroup/bio/bgroup2
      # echo 1234 > /cgroup/bio/bgroup1/tasks
      # echo 5678 > /cgroup/bio/bgroup1/tasks

Now, check the ID of each bio cgroup which is just created.

      # cat /cgroup/bio/bgroup1/bio.id
      2
      # cat /cgroup/bio/bgroup2/bio.id
      3

Finally, attach the cgroups to "ioband1" and assign them weights.

      # dmsetup message ioband1 0 type cgroup
      # dmsetup message ioband1 0 attach 2
      # dmsetup message ioband1 0 attach 3
      # dmsetup message ioband1 0 weight 2:30
      # dmsetup message ioband1 0 weight 3:60

You can also make use of the dm-ioband administration tool
iobandctl.py. You can set up the device with the tool as follows.
In this case, you don't need to know the IDs of the cgroups.

      # iobandctl.py group /dev/mapper/ioband1 cgroup \
        /cgroup/bio/bgroup1:30 /cgroup/bio/bgroup2:60
