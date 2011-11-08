From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 08/11] Staging: hv: storvsc: Get rid of an unnecessary forward declaration
Date: Tue,  8 Nov 2011 09:01:47 -0800
Message-ID: <1320771710-29139-8-git-send-email-kys@microsoft.com>
References: <1320771677-29095-1-git-send-email-kys@microsoft.com>
 <1320771710-29139-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1320771710-29139-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, James.Bottomley@HansenPartnership.com, hch@infradead.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of an unnecessary forward declaration.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 916f5d0..4cdb417 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -236,8 +236,6 @@ struct vstor_packet {
 #define STORVSC_MAX_CHANNELS				1
 #define STORVSC_MAX_CMD_LEN				16
 
-struct hv_storvsc_request;
-
 /* Matches Windows-end */
 enum storvsc_request_type {
 	WRITE_TYPE,
-- 
1.7.4.1
