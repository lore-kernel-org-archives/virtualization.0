From: "Ky Srinivasan" <ksrinivasan@novell.com>
Subject: [PATCH]: A daemon to support HyperV KVP functionality
Date: Tue, 07 Dec 2010 15:37:10 -0700
Message-ID: <4CFE54A60200003000091769@novprvoes0310.provo.novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part6B46D406.0__="
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
To: devel@driverdev.osuosl.org, Virtualization@lists.osdl.org
Cc: Zbr@ioremap.net, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <shemminger@vyatta.com>, Greg KH <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

--=__Part6B46D406.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

From: K. Y. Srinivasan <ksrinivasan@novell.com>

Subject: An implementation of key/value pair feature (KVP) for Linux
on HyperV.

Signed-off-by: K. Y. Srinivasan <ksrinivasan@novell.com>


Index: linux.trees.git/drivers/staging/hv/tools/hv_kvp_daemon.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux.trees.git/drivers/staging/hv/tools/hv_kvp_daemon.c	2010-12-07 =
08:46:19.000000000 -0500
@@ -0,0 +1,470 @@
+/*
+ * An implementation of key value pair (KVP) functionality for Linux.
+ *
+ *
+ * Copyright (C) 2010, Novell, Inc.
+ * Author : K. Y. Srinivasan <ksrinivasan@novell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify =
it
+ * under the terms of the GNU General Public License version 2 as =
published
+ * by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 =
USA.
+ *
+ */
+
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/poll.h>
+#include <sys/utsname.h>
+#include <linux/types.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <arpa/inet.h>
+#include <linux/connector.h>
+#include <linux/netlink.h>
+#include <sys/socket.h>
+#include <ifaddrs.h>
+#include <netdb.h>
+#include <syslog.h>
+
+/*
+ * KYS: TODO. Need to register these in the kernel.
+ *
+ * The following definitions are shared with the in-kernel component; do =
not
+ * change any of this without making the corresponding changes in
+ * the KVP kernel component.
+ */
+#define CN_KVP_IDX		0x9     /* MSFT KVP functionality */
+#define CN_KVP_VAL		0x1 /* This supports queries from the =
kernel */
+#define CN_KVP_USER_VAL		0x2 /* This supports queries from =
the user  */
+
+/*
+ * KVP protocol: The user mode component first registers with the
+ * the kernel component. Subsequently, the kernel component requests, =
data
+ * for the specified keys. In response to this message the user mode =
component
+ * fills in the value corresponding to the specified key. We overload the
+ * sequence field in the cn_msg header to define our KVP message types.
+ *
+ * We use this infrastructure for also supporting queries from user mode
+ * application for state that may be maintained in the KVP kernel =
component.
+ *
+ * XXXKYS: Have a shared header file between the user and kernel (TODO)
+ */
+
+enum kvp_op {
+	KVP_REGISTER =3D 0, /* Register the user mode component*/
+	KVP_KERNEL_GET, /*Kernel is requesting the value for the specified =
key*/
+	KVP_KERNEL_SET, /*Kernel is providing the value for the specified =
key*/
+	KVP_USER_GET, /*User is requesting the value for the specified =
key*/
+	KVP_USER_SET /*User is providing the value for the specified key*/
+};
+
+#define HV_KVP_EXCHANGE_MAX_KEY_SIZE	512
+#define HV_KVP_EXCHANGE_MAX_VALUE_SIZE	2048
+
+struct hv_ku_msg {
+	__u32	kvp_index;
+	__u8  kvp_key[HV_KVP_EXCHANGE_MAX_KEY_SIZE]; /* Key name */
+	__u8  kvp_value[HV_KVP_EXCHANGE_MAX_VALUE_SIZE]; /* Key  value */
+};
+
+enum key_index {
+	FullyQualifiedDomainName =3D 0,
+	IntegrationServicesVersion, /*This key is serviced in the kernel*/
+	NetworkAddressIPv4,
+	NetworkAddressIPv6,
+	OSBuildNumber,
+	OSName,
+	OSMajorVersion,
+	OSMinorVersion,
+	OSVersion,
+	ProcessorArchitecture
+};
+
+/*
+ * End of shared definitions.
+ */
+
+static char kvp_send_buffer[4096];
+static char kvp_recv_buffer[4096];
+static struct sockaddr_nl addr;
+
+static char os_name[100];
+static char os_major[50];
+static char os_minor[50];
+static char processor_arch[50];
+static char os_build[100];
+static char *lic_version;
+
+void kvp_get_os_info(void)
+{
+	FILE	*file;
+	char	*eol;
+	struct utsname buf;
+
+	uname(&buf);
+	strcpy(os_build, buf.release);
+	strcpy(processor_arch, buf.machine);
+
+	file =3D fopen("/etc/SuSE-release", "r");
+	if (file !=3D NULL)
+		goto kvp_osinfo_found;
+	file  =3D fopen("/etc/redhat-release", "r");
+	if (file !=3D NULL)
+		goto kvp_osinfo_found;
+	/*
+	 * Add code for other supported platforms.
+	 */
+
+	/*
+	 * We don't have information about the os.
+	 */
+	strcpy(os_name, "Linux");
+	strcpy(os_major, "0");
+	strcpy(os_minor, "0");
+	return;
+
+kvp_osinfo_found:
+	fgets(os_name, 99, file);
+	eol =3D index(os_name, '\n');
+	*eol =3D '\0';
+	fgets(os_major, 49, file);
+	eol =3D index(os_major, '\n');
+	*eol =3D '\0';
+	fgets(os_minor, 49, file);
+	eol =3D index(os_minor, '\n');
+	*eol =3D '\0';
+	fclose(file);
+	return;
+}
+
+static int
+kvp_get_ip_address(int family, char *buffer, int length)
+{
+	struct ifaddrs *ifap;
+	struct ifaddrs *curp;
+	int ipv4_len =3D strlen("255.255.255.255") + 1;
+	int ipv6_len =3D strlen("ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff")+=
1;
+	int offset =3D 0;
+	const char *str;
+	char tmp[50];
+	int error =3D 0;
+
+	/*
+	 * On entry into this function, the buffer is capable of holding =
the
+	 * maximum key value (2048 bytes).
+	 */
+
+	if (getifaddrs(&ifap)) {
+		strcpy(buffer, "getifaddrs failed\n");
+		return 1;
+	}
+
+	curp =3D ifap;
+	while (curp !=3D NULL) {
+		if ((curp->ifa_addr !=3D NULL) &&
+		   (curp->ifa_addr->sa_family =3D=3D family)) {
+			if (family =3D=3D AF_INET) {
+				struct sockaddr_in *addr =3D
+				(struct sockaddr_in *) curp->ifa_addr;
+
+				str =3D inet_ntop(family, &addr->sin_addr,
+						tmp, 50);
+				if (str =3D=3D NULL) {
+					strcpy(buffer, "inet_ntop =
failed\n");
+					error =3D 1;
+					goto getaddr_done;
+				}
+				if (offset =3D=3D 0)
+					strcpy(buffer, tmp);
+				else
+					strcat(buffer, tmp);
+				strcat(buffer, ";");
+
+				offset +=3D strlen(str) + 1;
+				if ((length - offset) < (ipv4_len + 1))
+					goto getaddr_done;
+
+			} else {
+
+			/*
+			 * We only support AF_INET and AF_INET6
+			 * and the list of addresses is seperated by a =
";".
+			 */
+				struct sockaddr_in6 *addr =3D
+				(struct sockaddr_in6 *) curp->ifa_addr;
+
+				str =3D inet_ntop(family,
+					&addr->sin6_addr.s6_addr,
+					tmp, 50);
+				if (str =3D=3D NULL) {
+					strcpy(buffer, "inet_ntop =
failed\n");
+					error =3D 1;
+					goto getaddr_done;
+				}
+				if (offset =3D=3D 0)
+					strcpy(buffer, tmp);
+				else
+					strcat(buffer, tmp);
+				strcat(buffer, ";");
+				offset +=3D strlen(str) + 1;
+				if ((length - offset) < (ipv6_len + 1))
+					goto getaddr_done;
+
+			}
+
+		}
+		curp =3D curp->ifa_next;
+	}
+
+getaddr_done:
+	freeifaddrs(ifap);
+	return error;
+}
+
+
+static int
+kvp_get_domain_name(char *buffer, int length)
+{
+	struct addrinfo	hints, *info ;
+	gethostname(buffer, length);
+	int error =3D 0;
+
+	memset(&hints, 0, sizeof(hints));
+	hints.ai_family =3D AF_INET; /*Get only ipv4 addrinfo. */
+	hints.ai_socktype =3D SOCK_STREAM;
+	hints.ai_flags =3D AI_CANONNAME;
+
+	error =3D getaddrinfo(buffer, "http", &hints, &info);
+	if (error !=3D 0) {
+		strcpy(buffer, "getaddrinfo failed\n");
+		error =3D 1;
+		goto get_domain_done;
+	}
+	strcpy(buffer, info->ai_canonname);
+get_domain_done:
+	freeaddrinfo(info);
+	return error;
+}
+
+static int
+netlink_send(int fd, struct cn_msg *msg)
+{
+	struct nlmsghdr *nlh;
+	unsigned int size;
+	struct msghdr message;
+	char buffer[64];
+	struct iovec iov[2];
+
+	size =3D NLMSG_SPACE(sizeof(struct cn_msg) + msg->len);
+
+	nlh =3D (struct nlmsghdr *)buffer;
+	nlh->nlmsg_seq =3D 0;
+	nlh->nlmsg_pid =3D getpid();
+	nlh->nlmsg_type =3D NLMSG_DONE;
+	nlh->nlmsg_len =3D NLMSG_LENGTH(size - sizeof(*nlh));
+	nlh->nlmsg_flags =3D 0;
+
+	iov[0].iov_base =3D nlh;
+	iov[0].iov_len =3D sizeof(*nlh);
+
+	iov[1].iov_base =3D msg;
+	iov[1].iov_len =3D size;
+
+	memset(&message, 0, sizeof(message));
+	message.msg_name =3D &addr;
+	message.msg_namelen =3D sizeof(addr);
+	message.msg_iov =3D iov;
+	message.msg_iovlen =3D 2;
+
+	return sendmsg(fd, &message, 0);
+}
+
+main(void)
+{
+	int fd, len, sock_opt;
+	int error;
+	struct cn_msg *message;
+	struct pollfd pfd;
+	struct nlmsghdr *incoming_msg;
+	struct cn_msg	*incoming_cn_msg;
+	char	*key_value;
+	char	*key_name;
+	int	 key_index;
+
+	daemon(1, 0);
+	openlog("KVP", 0, LOG_USER);
+	syslog(LOG_INFO, "KVP starting; pid is:%d", getpid());
+	/*
+	 * Retrieve OS release information.
+	 */
+	kvp_get_os_info();
+
+	fd =3D socket(AF_NETLINK, SOCK_DGRAM, NETLINK_CONNECTOR);
+	if (fd < 0) {
+		syslog(LOG_ERR, "netlink socket creation failed; error:%d",=
 fd);
+		exit(-1);
+	}
+	addr.nl_family =3D AF_NETLINK;
+	addr.nl_pad =3D 0;
+	addr.nl_pid =3D 0;
+	addr.nl_groups =3D CN_KVP_IDX;
+
+
+	error =3D bind(fd, (struct sockaddr *)&addr, sizeof(addr));
+	if (error < 0) {
+		syslog(LOG_ERR, "bind failed; error:%d", error);
+		close(fd);
+		exit(-1);
+	}
+	sock_opt =3D addr.nl_groups;
+	setsockopt(fd, 270, 1, &sock_opt, sizeof(sock_opt));
+	/*
+	 * Register ourselves with the kernel.
+	 */
+	message =3D (struct cn_msg *)kvp_send_buffer;
+	message->id.idx =3D CN_KVP_IDX;
+	message->id.val =3D CN_KVP_VAL;
+	message->seq =3D KVP_REGISTER;
+	message->ack =3D 0;
+	message->len =3D 0;
+
+	len =3D netlink_send(fd, message);
+	if (len < 0) {
+		syslog(LOG_ERR, "netlink_send failed; error:%d", len);
+		close(fd);
+		exit(-1);
+	}
+
+	pfd.fd =3D fd;
+
+	while (1) {
+		pfd.events =3D POLLIN;
+		pfd.revents =3D 0;
+		poll(&pfd, 1, -1);
+
+		len =3D recv(fd, kvp_recv_buffer, sizeof(kvp_recv_buffer), =
0);
+
+		if (len < 0) {
+			syslog(LOG_ERR, "recv failed; error:%d", len);
+			close(fd);
+			return -1;
+		}
+
+		incoming_msg =3D (struct nlmsghdr *)kvp_recv_buffer;
+		incoming_cn_msg =3D (struct cn_msg *)NLMSG_DATA(incoming_ms=
g);
+
+		switch (incoming_cn_msg->seq) {
+		case KVP_REGISTER:
+			/*
+			 * Driver is registering with us; stash away the =
version
+			 * information.
+			 */
+			lic_version =3D malloc(strlen(incoming_cn_msg->data=
) + 1);
+			if (lic_version) {
+				strcpy(lic_version, incoming_cn_msg->data);=

+				syslog(LOG_INFO, "KVP LIC Version: %s",
+					lic_version);
+			} else {
+				syslog(LOG_ERR, "malloc failed");
+			}
+			continue;
+
+		case KVP_KERNEL_GET:
+			break;
+		default:
+			continue;
+		}
+
+		key_index =3D
+		((struct hv_ku_msg *)incoming_cn_msg->data)->kvp_index;
+		key_name =3D
+		((struct hv_ku_msg *)incoming_cn_msg->data)->kvp_key;
+		key_value =3D
+		((struct hv_ku_msg *)incoming_cn_msg->data)->kvp_value;
+
+		switch (key_index) {
+		case FullyQualifiedDomainName:
+			kvp_get_domain_name(key_value,
+					HV_KVP_EXCHANGE_MAX_VALUE_SIZE);
+			strcpy(key_name, "FullyQualifiedDomainName");
+			break;
+		case IntegrationServicesVersion:
+			strcpy(key_name, "IntegrationServicesVersion");
+			strcpy(key_value, lic_version);
+			break;
+		case NetworkAddressIPv4:
+			kvp_get_ip_address(AF_INET, key_value,
+					HV_KVP_EXCHANGE_MAX_VALUE_SIZE);
+			strcpy(key_name, "NetworkAddressIPv4");
+			break;
+		case NetworkAddressIPv6:
+			kvp_get_ip_address(AF_INET6, key_value,
+					HV_KVP_EXCHANGE_MAX_VALUE_SIZE);
+			strcpy(key_name, "NetworkAddressIPv6");
+			break;
+		case OSBuildNumber:
+			strcpy(key_value, os_build);
+			strcpy(key_name, "OSBuildNumber");
+			break;
+		case OSName:
+			strcpy(key_value, os_name);
+			strcpy(key_name, "OSName");
+			break;
+		case OSMajorVersion:
+			strcpy(key_value, os_major);
+			strcpy(key_name, "OSMajorVersion");
+			break;
+		case OSMinorVersion:
+			strcpy(key_value, os_minor);
+			strcpy(key_name, "OSMinorVersion");
+			break;
+		case OSVersion:
+			strcpy(key_value, os_build);
+			strcpy(key_name, "OSVersion");
+			break;
+		case ProcessorArchitecture:
+			strcpy(key_value, processor_arch);
+			strcpy(key_name, "ProcessorArchitecture");
+			break;
+		default:
+			strcpy(key_value, "Unknown Key");
+			/*
+			 * We use a null key name to terminate enumeration.=

+			 */
+			strcpy(key_name, "");
+			break;
+		}
+		/*
+		 * Send the value back to the kernel. The response is
+		 * already in the receive buffer. Update the cn_msg header =
to
+		 * reflect the key value that has been added to the =
message
+		 */
+
+		incoming_cn_msg->id.idx =3D CN_KVP_IDX;
+		incoming_cn_msg->id.val =3D CN_KVP_VAL;
+		incoming_cn_msg->seq =3D KVP_USER_SET;
+		incoming_cn_msg->ack =3D 0;
+		incoming_cn_msg->len =3D sizeof(struct hv_ku_msg);
+
+		len =3D netlink_send(fd, incoming_cn_msg);
+		if (len < 0) {
+			syslog(LOG_ERR, "net_link send failed; error:%d", =
len);
+			exit(-1);
+		}
+	}
+
+}


--=__Part6B46D406.0__=
Content-Type: text/plain; name="hv_kvp_daemon.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="hv_kvp_daemon.patch"

From: K. Y. Srinivasan <ksrinivasan@novell.com>=0A=0ASubject: An implementa=
tion of key/value pair feature (KVP) for Linux=0Aon HyperV.=0A=0ASigned-off=
-by: K. Y. Srinivasan <ksrinivasan@novell.com>=0A=0A=0AIndex: linux.trees.g=
it/drivers/staging/hv/tools/hv_kvp_daemon.c=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=0A--- /dev/null	1970-01-01 00:00:00.0000000=
00 +0000=0A+++ linux.trees.git/drivers/staging/hv/tools/hv_kvp_daemon.c	=
2010-12-07 08:46:19.000000000 -0500=0A@@ -0,0 +1,470 @@=0A+/*=0A+ * An =
implementation of key value pair (KVP) functionality for Linux.=0A+ *=0A+ =
*=0A+ * Copyright (C) 2010, Novell, Inc.=0A+ * Author : K. Y. Srinivasan =
<ksrinivasan@novell.com>=0A+ *=0A+ * This program is free software; you =
can redistribute it and/or modify it=0A+ * under the terms of the GNU =
General Public License version 2 as published=0A+ * by the Free Software =
Foundation.=0A+ *=0A+ * This program is distributed in the hope that it =
will be useful, but=0A+ * WITHOUT ANY WARRANTY; without even the implied =
warranty of=0A+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, =
GOOD TITLE or=0A+ * NON INFRINGEMENT.  See the GNU General Public License =
for more=0A+ * details.=0A+ *=0A+ * You should have received a copy of the =
GNU General Public License=0A+ * along with this program; if not, write to =
the Free Software=0A+ * Foundation, Inc., 51 Franklin St, Fifth Floor, =
Boston, MA 02110-1301 USA.=0A+ *=0A+ */=0A+=0A+=0A+#include <sys/types.h>=
=0A+#include <sys/socket.h>=0A+#include <sys/poll.h>=0A+#include <sys/utsna=
me.h>=0A+#include <linux/types.h>=0A+#include <stdio.h>=0A+#include =
<stdlib.h>=0A+#include <unistd.h>=0A+#include <string.h>=0A+#include =
<errno.h>=0A+#include <arpa/inet.h>=0A+#include <linux/connector.h>=0A+#inc=
lude <linux/netlink.h>=0A+#include <sys/socket.h>=0A+#include <ifaddrs.h>=
=0A+#include <netdb.h>=0A+#include <syslog.h>=0A+=0A+/*=0A+ * KYS: TODO. =
Need to register these in the kernel.=0A+ *=0A+ * The following definitions=
 are shared with the in-kernel component; do not=0A+ * change any of this =
without making the corresponding changes in=0A+ * the KVP kernel component.=
=0A+ */=0A+#define CN_KVP_IDX		0x9     /* MSFT KVP functionality =
*/=0A+#define CN_KVP_VAL		0x1 /* This supports queries from =
the kernel */=0A+#define CN_KVP_USER_VAL		0x2 /* This =
supports queries from the user  */=0A+=0A+/*=0A+ * KVP protocol: The user =
mode component first registers with the=0A+ * the kernel component. =
Subsequently, the kernel component requests, data=0A+ * for the specified =
keys. In response to this message the user mode component=0A+ * fills in =
the value corresponding to the specified key. We overload the=0A+ * =
sequence field in the cn_msg header to define our KVP message types.=0A+ =
*=0A+ * We use this infrastructure for also supporting queries from user =
mode=0A+ * application for state that may be maintained in the KVP kernel =
component.=0A+ *=0A+ * XXXKYS: Have a shared header file between the user =
and kernel (TODO)=0A+ */=0A+=0A+enum kvp_op {=0A+	KVP_REGISTER =3D =
0, /* Register the user mode component*/=0A+	KVP_KERNEL_GET, /*Kernel =
is requesting the value for the specified key*/=0A+	KVP_KERNEL_SET, =
/*Kernel is providing the value for the specified key*/=0A+	KVP_USER_GE=
T, /*User is requesting the value for the specified key*/=0A+	KVP_USER_SE=
T /*User is providing the value for the specified key*/=0A+};=0A+=0A+#defin=
e HV_KVP_EXCHANGE_MAX_KEY_SIZE	512=0A+#define HV_KVP_EXCHANGE_MAX_VALUE_SI=
ZE	2048=0A+=0A+struct hv_ku_msg {=0A+	__u32	kvp_index;=0A+	=
__u8  kvp_key[HV_KVP_EXCHANGE_MAX_KEY_SIZE]; /* Key name */=0A+	__u8  =
kvp_value[HV_KVP_EXCHANGE_MAX_VALUE_SIZE]; /* Key  value */=0A+};=0A+=0A+en=
um key_index {=0A+	FullyQualifiedDomainName =3D 0,=0A+	Integration=
ServicesVersion, /*This key is serviced in the kernel*/=0A+	NetworkAddr=
essIPv4,=0A+	NetworkAddressIPv6,=0A+	OSBuildNumber,=0A+	OSName,=0A+=
	OSMajorVersion,=0A+	OSMinorVersion,=0A+	OSVersion,=0A+	=
ProcessorArchitecture=0A+};=0A+=0A+/*=0A+ * End of shared definitions.=0A+ =
*/=0A+=0A+static char kvp_send_buffer[4096];=0A+static char kvp_recv_buffer=
[4096];=0A+static struct sockaddr_nl addr;=0A+=0A+static char os_name[100];=
=0A+static char os_major[50];=0A+static char os_minor[50];=0A+static char =
processor_arch[50];=0A+static char os_build[100];=0A+static char *lic_versi=
on;=0A+=0A+void kvp_get_os_info(void)=0A+{=0A+	FILE	*file;=0A+	=
char	*eol;=0A+	struct utsname buf;=0A+=0A+	uname(&buf);=0A+	=
strcpy(os_build, buf.release);=0A+	strcpy(processor_arch, buf.machine)=
;=0A+=0A+	file =3D fopen("/etc/SuSE-release", "r");=0A+	if (file =
!=3D NULL)=0A+		goto kvp_osinfo_found;=0A+	file  =3D =
fopen("/etc/redhat-release", "r");=0A+	if (file !=3D NULL)=0A+		=
goto kvp_osinfo_found;=0A+	/*=0A+	 * Add code for other supported =
platforms.=0A+	 */=0A+=0A+	/*=0A+	 * We don't have information about =
the os.=0A+	 */=0A+	strcpy(os_name, "Linux");=0A+	strcpy(os_major, =
"0");=0A+	strcpy(os_minor, "0");=0A+	return;=0A+=0A+kvp_osinfo_f=
ound:=0A+	fgets(os_name, 99, file);=0A+	eol =3D index(os_name, =
'\n');=0A+	*eol =3D '\0';=0A+	fgets(os_major, 49, file);=0A+	=
eol =3D index(os_major, '\n');=0A+	*eol =3D '\0';=0A+	fgets(os_mi=
nor, 49, file);=0A+	eol =3D index(os_minor, '\n');=0A+	*eol =3D =
'\0';=0A+	fclose(file);=0A+	return;=0A+}=0A+=0A+static =
int=0A+kvp_get_ip_address(int family, char *buffer, int length)=0A+{=0A+	=
struct ifaddrs *ifap;=0A+	struct ifaddrs *curp;=0A+	int =
ipv4_len =3D strlen("255.255.255.255") + 1;=0A+	int ipv6_len =3D strlen("ff=
ff:ffff:ffff:ffff:ffff:ffff:ffff:ffff")+1;=0A+	int offset =3D 0;=0A+	=
const char *str;=0A+	char tmp[50];=0A+	int error =3D 0;=0A+=0A+	=
/*=0A+	 * On entry into this function, the buffer is capable of holding =
the=0A+	 * maximum key value (2048 bytes).=0A+	 */=0A+=0A+	if =
(getifaddrs(&ifap)) {=0A+		strcpy(buffer, "getifaddrs =
failed\n");=0A+		return 1;=0A+	}=0A+=0A+	curp =3D ifap;=0A+	=
while (curp !=3D NULL) {=0A+		if ((curp->ifa_addr !=3D NULL) =
&&=0A+		   (curp->ifa_addr->sa_family =3D=3D family)) {=0A+		=
	if (family =3D=3D AF_INET) {=0A+				=
struct sockaddr_in *addr =3D=0A+				(struct =
sockaddr_in *) curp->ifa_addr;=0A+=0A+				str =3D =
inet_ntop(family, &addr->sin_addr,=0A+						=
tmp, 50);=0A+				if (str =3D=3D NULL) {=0A+		=
			strcpy(buffer, "inet_ntop failed\n");=0A+		=
			error =3D 1;=0A+					=
goto getaddr_done;=0A+				}=0A+				=
if (offset =3D=3D 0)=0A+					strcpy(buff=
er, tmp);=0A+				else=0A+				=
	strcat(buffer, tmp);=0A+				strcat(buff=
er, ";");=0A+=0A+				offset +=3D strlen(str) + =
1;=0A+				if ((length - offset) < (ipv4_len + =
1))=0A+					goto getaddr_done;=0A+=0A+		=
	} else {=0A+=0A+			/*=0A+			 * =
We only support AF_INET and AF_INET6=0A+			 * and the =
list of addresses is seperated by a ";".=0A+			 */=0A+		=
		struct sockaddr_in6 *addr =3D=0A+				=
(struct sockaddr_in6 *) curp->ifa_addr;=0A+=0A+				=
str =3D inet_ntop(family,=0A+					&addr->sin6=
_addr.s6_addr,=0A+					tmp, 50);=0A+		=
		if (str =3D=3D NULL) {=0A+					=
strcpy(buffer, "inet_ntop failed\n");=0A+					=
error =3D 1;=0A+					goto getaddr_done;=
=0A+				}=0A+				if (offset =
=3D=3D 0)=0A+					strcpy(buffer, tmp);=0A+	=
			else=0A+					=
strcat(buffer, tmp);=0A+				strcat(buffer, =
";");=0A+				offset +=3D strlen(str) + 1;=0A+	=
			if ((length - offset) < (ipv6_len + 1))=0A+		=
			goto getaddr_done;=0A+=0A+			=
}=0A+=0A+		}=0A+		curp =3D curp->ifa_next;=0A+	=
}=0A+=0A+getaddr_done:=0A+	freeifaddrs(ifap);=0A+	return error;=0A+}=
=0A+=0A+=0A+static int=0A+kvp_get_domain_name(char *buffer, int length)=0A+=
{=0A+	struct addrinfo	hints, *info ;=0A+	gethostname(buffer, =
length);=0A+	int error =3D 0;=0A+=0A+	memset(&hints, 0, =
sizeof(hints));=0A+	hints.ai_family =3D AF_INET; /*Get only ipv4 =
addrinfo. */=0A+	hints.ai_socktype =3D SOCK_STREAM;=0A+	hints.ai_fl=
ags =3D AI_CANONNAME;=0A+=0A+	error =3D getaddrinfo(buffer, "http", =
&hints, &info);=0A+	if (error !=3D 0) {=0A+		strcpy(buffer, =
"getaddrinfo failed\n");=0A+		error =3D 1;=0A+		=
goto get_domain_done;=0A+	}=0A+	strcpy(buffer, info->ai_canonname);=
=0A+get_domain_done:=0A+	freeaddrinfo(info);=0A+	return error;=0A+}=
=0A+=0A+static int=0A+netlink_send(int fd, struct cn_msg *msg)=0A+{=0A+	=
struct nlmsghdr *nlh;=0A+	unsigned int size;=0A+	struct msghdr =
message;=0A+	char buffer[64];=0A+	struct iovec iov[2];=0A+=0A+	=
size =3D NLMSG_SPACE(sizeof(struct cn_msg) + msg->len);=0A+=0A+	nlh =3D =
(struct nlmsghdr *)buffer;=0A+	nlh->nlmsg_seq =3D 0;=0A+	nlh->nlmsg_=
pid =3D getpid();=0A+	nlh->nlmsg_type =3D NLMSG_DONE;=0A+	nlh->nlmsg_=
len =3D NLMSG_LENGTH(size - sizeof(*nlh));=0A+	nlh->nlmsg_flags =3D =
0;=0A+=0A+	iov[0].iov_base =3D nlh;=0A+	iov[0].iov_len =3D =
sizeof(*nlh);=0A+=0A+	iov[1].iov_base =3D msg;=0A+	iov[1].iov_len =3D =
size;=0A+=0A+	memset(&message, 0, sizeof(message));=0A+	message.msg=
_name =3D &addr;=0A+	message.msg_namelen =3D sizeof(addr);=0A+	=
message.msg_iov =3D iov;=0A+	message.msg_iovlen =3D 2;=0A+=0A+	=
return sendmsg(fd, &message, 0);=0A+}=0A+=0A+main(void)=0A+{=0A+	=
int fd, len, sock_opt;=0A+	int error;=0A+	struct cn_msg *message;=0A+=
	struct pollfd pfd;=0A+	struct nlmsghdr *incoming_msg;=0A+	=
struct cn_msg	*incoming_cn_msg;=0A+	char	*key_value;=0A+	char	=
*key_name;=0A+	int	 key_index;=0A+=0A+	daemon(1, 0);=0A+	=
openlog("KVP", 0, LOG_USER);=0A+	syslog(LOG_INFO, "KVP starting; =
pid is:%d", getpid());=0A+	/*=0A+	 * Retrieve OS release information.=
=0A+	 */=0A+	kvp_get_os_info();=0A+=0A+	fd =3D socket(AF_NETLINK, =
SOCK_DGRAM, NETLINK_CONNECTOR);=0A+	if (fd < 0) {=0A+		=
syslog(LOG_ERR, "netlink socket creation failed; error:%d", fd);=0A+		=
exit(-1);=0A+	}=0A+	addr.nl_family =3D AF_NETLINK;=0A+	addr.nl_pad=
 =3D 0;=0A+	addr.nl_pid =3D 0;=0A+	addr.nl_groups =3D CN_KVP_IDX;=0A+=
=0A+=0A+	error =3D bind(fd, (struct sockaddr *)&addr, sizeof(addr));=
=0A+	if (error < 0) {=0A+		syslog(LOG_ERR, "bind failed; =
error:%d", error);=0A+		close(fd);=0A+		exit(-1);=0A+	=
}=0A+	sock_opt =3D addr.nl_groups;=0A+	setsockopt(fd, 270, 1, =
&sock_opt, sizeof(sock_opt));=0A+	/*=0A+	 * Register ourselves with =
the kernel.=0A+	 */=0A+	message =3D (struct cn_msg *)kvp_send_buffer;=0A+	=
message->id.idx =3D CN_KVP_IDX;=0A+	message->id.val =3D CN_KVP_VAL;=0A+=
	message->seq =3D KVP_REGISTER;=0A+	message->ack =3D 0;=0A+	=
message->len =3D 0;=0A+=0A+	len =3D netlink_send(fd, message);=0A+	if =
(len < 0) {=0A+		syslog(LOG_ERR, "netlink_send failed; error:%d", =
len);=0A+		close(fd);=0A+		exit(-1);=0A+	}=0A+=0A+	=
pfd.fd =3D fd;=0A+=0A+	while (1) {=0A+		pfd.events =3D POLLIN;=0A+	=
	pfd.revents =3D 0;=0A+		poll(&pfd, 1, -1);=0A+=0A+		=
len =3D recv(fd, kvp_recv_buffer, sizeof(kvp_recv_buffer), 0);=0A+=0A+		=
if (len < 0) {=0A+			syslog(LOG_ERR, "recv failed; =
error:%d", len);=0A+			close(fd);=0A+			=
return -1;=0A+		}=0A+=0A+		incoming_msg =3D (struct =
nlmsghdr *)kvp_recv_buffer;=0A+		incoming_cn_msg =3D (struct cn_msg =
*)NLMSG_DATA(incoming_msg);=0A+=0A+		switch (incoming_cn_msg->se=
q) {=0A+		case KVP_REGISTER:=0A+			/*=0A+		=
	 * Driver is registering with us; stash away the version=0A+		=
	 * information.=0A+			 */=0A+			=
lic_version =3D malloc(strlen(incoming_cn_msg->data) + 1);=0A+			=
if (lic_version) {=0A+				strcpy(lic_version, =
incoming_cn_msg->data);=0A+				syslog(LOG_INFO, =
"KVP LIC Version: %s",=0A+					lic_version=
);=0A+			} else {=0A+				syslog(LOG_=
ERR, "malloc failed");=0A+			}=0A+			=
continue;=0A+=0A+		case KVP_KERNEL_GET:=0A+			=
break;=0A+		default:=0A+			continue;=0A+		=
}=0A+=0A+		key_index =3D=0A+		((struct hv_ku_msg =
*)incoming_cn_msg->data)->kvp_index;=0A+		key_name =3D=0A+	=
	((struct hv_ku_msg *)incoming_cn_msg->data)->kvp_key;=0A+		=
key_value =3D=0A+		((struct hv_ku_msg *)incoming_cn_msg->data)=
->kvp_value;=0A+=0A+		switch (key_index) {=0A+		=
case FullyQualifiedDomainName:=0A+			kvp_get_domain_name=
(key_value,=0A+					HV_KVP_EXCHANGE_MAX_VALUE_S=
IZE);=0A+			strcpy(key_name, "FullyQualifiedDomainName"=
);=0A+			break;=0A+		case IntegrationServicesVer=
sion:=0A+			strcpy(key_name, "IntegrationServicesVersio=
n");=0A+			strcpy(key_value, lic_version);=0A+		=
	break;=0A+		case NetworkAddressIPv4:=0A+			=
kvp_get_ip_address(AF_INET, key_value,=0A+					=
HV_KVP_EXCHANGE_MAX_VALUE_SIZE);=0A+			strcpy(key_name, =
"NetworkAddressIPv4");=0A+			break;=0A+		=
case NetworkAddressIPv6:=0A+			kvp_get_ip_address(AF_INET6=
, key_value,=0A+					HV_KVP_EXCHANGE_MAX=
_VALUE_SIZE);=0A+			strcpy(key_name, "NetworkAddressIPv=
6");=0A+			break;=0A+		case OSBuildNumber:=
=0A+			strcpy(key_value, os_build);=0A+			=
strcpy(key_name, "OSBuildNumber");=0A+			break;=0A+		=
case OSName:=0A+			strcpy(key_value, os_name);=0A+		=
	strcpy(key_name, "OSName");=0A+			break;=0A+		=
case OSMajorVersion:=0A+			strcpy(key_value, =
os_major);=0A+			strcpy(key_name, "OSMajorVersion");=0A+		=
	break;=0A+		case OSMinorVersion:=0A+			=
strcpy(key_value, os_minor);=0A+			strcpy(key_name, =
"OSMinorVersion");=0A+			break;=0A+		case =
OSVersion:=0A+			strcpy(key_value, os_build);=0A+		=
	strcpy(key_name, "OSVersion");=0A+			break;=0A+	=
	case ProcessorArchitecture:=0A+			strcpy(key_value, =
processor_arch);=0A+			strcpy(key_name, "ProcessorArchitec=
ture");=0A+			break;=0A+		default:=0A+		=
	strcpy(key_value, "Unknown Key");=0A+			/*=0A+		=
	 * We use a null key name to terminate enumeration.=0A+			=
 */=0A+			strcpy(key_name, "");=0A+			=
break;=0A+		}=0A+		/*=0A+		 * Send the value =
back to the kernel. The response is=0A+		 * already in the receive =
buffer. Update the cn_msg header to=0A+		 * reflect the key value =
that has been added to the message=0A+		 */=0A+=0A+		=
incoming_cn_msg->id.idx =3D CN_KVP_IDX;=0A+		incoming_cn_msg->id=
.val =3D CN_KVP_VAL;=0A+		incoming_cn_msg->seq =3D KVP_USER_S=
ET;=0A+		incoming_cn_msg->ack =3D 0;=0A+		incoming_cn_msg->le=
n =3D sizeof(struct hv_ku_msg);=0A+=0A+		len =3D netlink_send(fd, =
incoming_cn_msg);=0A+		if (len < 0) {=0A+			=
syslog(LOG_ERR, "net_link send failed; error:%d", len);=0A+			=
exit(-1);=0A+		}=0A+	}=0A+=0A+}=0A
--=__Part6B46D406.0__=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/devel

--=__Part6B46D406.0__=--
