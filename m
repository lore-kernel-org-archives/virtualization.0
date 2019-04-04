From: Lepton Wu <ytht.net@gmail.com>
Subject: Proof of concept for GPU forwarding for Linux guest on Linux host.
Date: Wed,  3 Apr 2019 17:31:50 -0700
Message-ID: <20190404003151.253837-1-ytht.net@gmail.com>
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
To: virtualization@lists.linux-foundation.org
Cc: Lepton Wu <ytht.net@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

This is a proof of concept of GPU forwarding for Linux guest on Linux host.
I'd like to get comments and suggestions from community before I put more
time on it. To summarize what it is:

1. It's a solution to bring GPU acceleration for Linux vm guest on Linux host.
It could works with different GPU although the current proof of concept only
works with Intel GPU.

2. The basic idea is: under Linux, most applications use GPU acceleration with
help of MESA library. And MESA library interacts with kernel GPU driver by
operating on some special character device file exported by kernel GPU driver.
MESA library opens some special files in system and operations on GPU are done
by ioctl/mmap system call and regular memory operations.

We just write a kernel driver for guest Linux kernel and let it exports same
interface to user space like the real Linux GPU kernel driver. So it's an API proxy
between host and VM guest. We just proxy API at system call level. 

3. Some nasty things was done in guest kernel as a quick dirty hack so we don't need
to touch user space (wayland/mesa etc) now.

4. You can check tools/forward/README for instructions.

Thanks!

Lepton Wu (1):
  proof of concept for GPU forwarding

 arch/x86/configs/x86_64_defconfig      |    5 +
 drivers/char/Makefile                  |    1 +
 drivers/char/forwarder/Makefile        |    8 +
 drivers/char/forwarder/forwarder.h     |  103 ++
 drivers/char/forwarder/forwarder_drv.c | 2104 ++++++++++++++++++++++++
 fs/open.c                              |   18 +
 include/uapi/linux/virtwl.h            |   64 +
 tools/forward/Makefile                 |    2 +
 tools/forward/README                   |   58 +
 tools/forward/qemu.diff                | 1117 +++++++++++++
 tools/forward/wayland-proxy-main.c     |   58 +
 tools/forward/wayland-proxy.c          |  297 ++++
 12 files changed, 3835 insertions(+)
 create mode 100644 drivers/char/forwarder/Makefile
 create mode 100644 drivers/char/forwarder/forwarder.h
 create mode 100644 drivers/char/forwarder/forwarder_drv.c
 create mode 100644 include/uapi/linux/virtwl.h
 create mode 100644 tools/forward/Makefile
 create mode 100644 tools/forward/README
 create mode 100644 tools/forward/qemu.diff
 create mode 100644 tools/forward/wayland-proxy-main.c
 create mode 100644 tools/forward/wayland-proxy.c

-- 
2.21.0.392.gf8f6787159e-goog
