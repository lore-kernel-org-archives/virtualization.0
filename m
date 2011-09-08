From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 0000/0025] Staging: hv: Driver cleanup
Date: Thu,  8 Sep 2011 07:24:03 -0700
Message-ID: <1315491843-9513-1-git-send-email-kys@microsoft.com>
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
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Address Greg's VmBus audit comments:

	1) Leverage driver_data field in struct hv_vmbus_device_id to
	   simplify driver code.

	2) Make the util driver conform to the Linux Driver Model.

	3) Get rid of the ext field in struct hv_device by using the
	   driver specific data functionality.

	4) Other general cleanup.


Regards,

K. Y
