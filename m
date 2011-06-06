From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 00/49] Staging: hv: Driver cleanup
Date: Mon,  6 Jun 2011 15:49:00 -0700
Message-ID: <1307400540-13193-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Further cleanup of the hv drivers:

	1) Continue to cleanup our drivers to conform to the Linux Driver
	   Model.

	2) Fix some long standing bugs with regards to unloading and 
	   reloading the drivers - block, net and stor.

	3) VMBUS is an ACPI enumerated device; make VMBUS an ACPI bus driver.

	4) Get rid of channel polling code; instead the channel receive paths 
	   will be purely interrupt drive.

	5) Cleanup error return values in the vmbus driver and general cleanup.

	6) Fix memory barrier calls in the ring buffer code.

	7) Increase the timeout values for some critical guest to host calls.


Regads,

K. Y 
