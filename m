From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 14/15] Tools: hv: Rename the function kvp_get_ip_address()
Date: Sat, 14 Jul 2012 13:34:19 -0700
Message-ID: <1342298060-12662-14-git-send-email-kys@microsoft.com>
References: <1342297930-12607-1-git-send-email-kys@microsoft.com>
 <1342298060-12662-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1342298060-12662-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, olaf@aepfle.de, apw@canonical.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Rename the function kvp_get_ip_address().

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 tools/hv/hv_kvp_daemon.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index c33fc8e..6d224e7 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -762,7 +762,7 @@ static int kvp_process_ip_address(void *addrp,
 }
 
 static int
-kvp_get_ip_address(int family, char *if_name, int op,
+kvp_get_ip_info(int family, char *if_name, int op,
 		 void  *out_buffer, int length)
 {
 	struct ifaddrs *ifap;
@@ -1360,12 +1360,12 @@ int main(void)
 			strcpy(key_value, lic_version);
 			break;
 		case NetworkAddressIPv4:
-			kvp_get_ip_address(AF_INET, NULL, KVP_OP_ENUMERATE,
+			kvp_get_ip_info(AF_INET, NULL, KVP_OP_ENUMERATE,
 				key_value, HV_KVP_EXCHANGE_MAX_VALUE_SIZE);
 			strcpy(key_name, "NetworkAddressIPv4");
 			break;
 		case NetworkAddressIPv6:
-			kvp_get_ip_address(AF_INET6, NULL, KVP_OP_ENUMERATE,
+			kvp_get_ip_info(AF_INET6, NULL, KVP_OP_ENUMERATE,
 				key_value, HV_KVP_EXCHANGE_MAX_VALUE_SIZE);
 			strcpy(key_name, "NetworkAddressIPv6");
 			break;
-- 
1.7.4.1
