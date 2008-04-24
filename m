From: Ryo Tsuruta <ryov@valinux.co.jp>
Subject: [PATCH 0/2] dm-ioband: I/O bandwidth controller v0.0.4: Introduction
Date: Thu, 24 Apr 2008 20:18:57 +0900 (JST)
Message-ID: <20080424.201857.183035295.ryov__37930.0709501424$1209036104$gmane$org@valinux.co.jp>
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
Cc: agk@sourceware.org
List-Id: virtualization@lists.linuxfoundation.org

Hi everyone,

This is dm-ioband version 0.0.4 release.

Dm-ioband is an I/O bandwidth controller implemented as a device-mapper
driver, which gives specified bandwidth to each job running on the same
physical device.

Changes since 0.0.3 (5th February):
   - Improve the performance when many processes are issuing I/Os
     simultaneously. 
   - Change the table format to fully support dmsetup table/load commands.
     The table format consists all configuration parameters.
   - Port to linux-2.6.25.

An administration tool is available. It makes it easy to configure
bandwidths of disk partitions.
You can download it and find the manual at
http://people.valinux.co.jp/~kaizuka/dm-ioband/iobandctl/

For more details, please refer to:
http://people.valinux.co.jp/~ryov/dm-ioband/

Thanks,
Ryo Tsuruta
