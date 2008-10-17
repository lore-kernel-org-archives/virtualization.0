From: Ryo Tsuruta <ryov@valinux.co.jp>
Subject: [PATCH 0/2] dm-ioband: I/O bandwidth controller v1.8.0: Introduction
Date: Fri, 17 Oct 2008 16:09:50 +0900 (JST)
Message-ID: <20081017.160950.71109894.ryov__37924.229729879$1224227957$gmane$org@valinux.co.jp>
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
To: agk@redhat.com, linux-kernel@vger.kernel.org, dm-devel@redhat.com, containers@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, xen-devel@lis
Cc: fernando@oss.ntt.co.jp
List-Id: virtualization@lists.linuxfoundation.org

Hi Alasdair and all,

This is the dm-ioband version 1.8.0 release.

Dm-ioband is an I/O bandwidth controller implemented as a device-mapper
driver, which gives specified bandwidth to each job running on the same
physical device.

This release is a minor bug fix and confirmed running on the latest
stable kernel 2.6.27.1.

- Can be applied to the kernel 2.6.27.1 and 2.6.27-rc5-mm1.
- Changes from 1.7.0 (posted on Oct 3, 2008):
  - Fix a minor bug in io_limit setting that causes dm-ioband to stop
    issuing I/O requests when a large value is set to io_limit.

Alasdair, could you please review this patch and give me any comments?

Thanks,
Ryo Tsuruta
