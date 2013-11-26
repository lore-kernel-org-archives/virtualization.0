From: Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH char-misc-linus 3/5] misc: mic: Bug fix for sysfs poll usage.
Date: Tue, 26 Nov 2013 10:12:53 -0800
Message-ID: <110d7ea2d60d47682da4208a07646a97b0f00585.1385487752.git.ashutosh.dixit__2256.8529741422$1386087463$gmane$org@intel.com>
References: <cover.1385487752.git.ashutosh.dixit@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1385487752.git.ashutosh.dixit@intel.com>
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

MIC user space daemon poll's on sysfs changes. The documentation for
sysfs_poll(...) in fs/sysfs/file.c states that "Once poll/select
indicates that the value has changed, you need to close and re-open the
file, or seek to 0 and read again". This step was missed out earlier and
resulted in the daemon spinning continuously rather than getting blocked
in 'poll'. This bug was exposed by commit aea585ef8fa65163 introduced as
part of sysfs changes in 3.13-rc1. A seek to 0 has been introduced to
fix it.

Reviewed-by: Sudeep Dutt <sudeep.dutt@intel.com>
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
---
 Documentation/mic/mpssd/mpssd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/mic/mpssd/mpssd.c b/Documentation/mic/mpssd/mpssd.c
index 0c980ad..5c7fdda 100644
--- a/Documentation/mic/mpssd/mpssd.c
+++ b/Documentation/mic/mpssd/mpssd.c
@@ -1412,6 +1412,12 @@ mic_config(void *arg)
 	}
 
 	do {
+		ret = lseek(fd, 0, SEEK_SET);
+		if (ret < 0) {
+			mpsslog("%s: Failed to seek to file start '%s': %s\n",
+				mic->name, pathname, strerror(errno));
+			goto close_error1;
+		}
 		ret = read(fd, value, sizeof(value));
 		if (ret < 0) {
 			mpsslog("%s: Failed to read sysfs entry '%s': %s\n",
-- 
1.8.2.3
