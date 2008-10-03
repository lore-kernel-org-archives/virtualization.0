From: Ryo Tsuruta <ryov@valinux.co.jp>
Subject: [PATCH 0/2] dm-ioband: I/O bandwidth controller v1.7.0: Introduction
Date: Fri, 03 Oct 2008 14:37:49 +0900 (JST)
Message-ID: <20081003.143749.193701570.ryov__12391.9300655418$1223012435$gmane$org@valinux.co.jp>
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
Cc: agk@sourceware.org, fernando@oss.ntt.co.jp, xemul@openvz.org, kamezawa.hiroyu@jp.fujitsu.com, balbir@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Hi everyone,

This is the dm-ioband version 1.7.0 release.

Dm-ioband is an I/O bandwidth controller implemented as a device-mapper
driver, which gives specified bandwidth to each job running on the same
physical device.

- Can be applied to the kernel 2.6.27-rc5-mm1.
- Changes from 1.6.0 (posted on Sep 24, 2008):
  - Fix a problem that processes issuing I/Os are permanently blocked
    when I/O requests to reclaim pages are consecutively issued.

You can apply the latest bio-cgroup patch to this dm-ioband version.
The bio-cgroup provides a BIO tracking mechanism with dm-ioband.
Please see the following site for more information:
  Block I/O tracking
  http://people.valinux.co.jp/~ryov/bio-cgroup/

Thanks,
Ryo Tsuruta
