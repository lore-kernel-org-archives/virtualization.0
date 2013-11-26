From: Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH char-misc-linus 0/5] misc: mic: Fixes for 3.13-rc2
Date: Tue, 26 Nov 2013 10:04:38 -0800
Message-ID: <cover.1385487752.git.ashutosh.dixit__35955.7889438749$1386087438$gmane$org@intel.com>
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Sudeep Dutt <sudeep.dutt@intel.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>, Siva Krishna Kumar Reddy Yerramreddy <siva.krishna.kumar.reddy.yerramreddy@intel.com>, Caz Yokoyama <Caz.Yokoyama@intel.com>, Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

These patches fix various issues which were reported or found with the
MIC driver.

Ashutosh Dixit (3):
  misc: mic: Bug fix for sysfs poll usage.
  misc: mic: Fix sparse warnings and other endianness issues.
  misc: mic: Fix user space namespace pollution from mic_common.h.

Sudeep Dutt (2):
  misc: mic: Change mic_notify(...) to return true.
  misc: mic: Minor bug fix in 'retry' loops.

 Documentation/mic/mpssd/mpssd.c    | 18 +++++++++++------
 drivers/misc/mic/card/mic_virtio.c | 33 +++++++++++++++++--------------
 drivers/misc/mic/card/mic_virtio.h |  7 +++----
 drivers/misc/mic/host/mic_boot.c   |  2 +-
 drivers/misc/mic/host/mic_virtio.c | 30 ++++++++++++++--------------
 drivers/misc/mic/host/mic_x100.c   |  4 ++--
 include/uapi/linux/mic_common.h    | 40 +++++++++++++++-----------------------
 7 files changed, 67 insertions(+), 67 deletions(-)

-- 
1.8.2.3
