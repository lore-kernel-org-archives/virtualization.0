From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 0000/0020] Staging: hv: Driver cleanup
Date: Tue, 13 Sep 2011 10:59:19 -0700
Message-ID: <1315936759-20623-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Address Greg's VmBus audit comments:

	1) Leverage driver_data field in struct hv_vmbus_device_id to
	   simplify driver code.

	2) Make the util driver conform to the Linux Driver Model.

	3) Get rid of the ext field in struct hv_device by using the
	   driver specific data functionality.

	4) Implement vmbus specific wrapper functions for setting and getting
	   driver specific data..

	5) Other general cleanup.


Regards,

K. Y
